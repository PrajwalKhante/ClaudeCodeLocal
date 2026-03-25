# Claude Code Local Setup Script (Windows version)
# This script automates the installation and configuration of Claude Code with local models 
# using Ollama, LM Studio, and llama.cpp on Windows. It will pull models, set up environment variables,
# and launch the model for use.

# Step 1: Check if Ollama is installed
function Check-OllamaInstalled {
    $ollama = Get-Command "ollama" -ErrorAction SilentlyContinue
    if (-not $ollama) {
        Write-Host "Ollama is not installed. Installing Ollama now..."
        Invoke-WebRequest -Uri "https://ollama.com/install.ps1" -OutFile "install-ollama.ps1"
        & .\install-ollama.ps1
    }
    else {
        Write-Host "Ollama is already installed."
    }
}

# Step 2: Install LM Studio for local model selection
function Install-LMStudio {
    Write-Host "Installing LM Studio..."
    Invoke-WebRequest -Uri "https://lmstudio.ai/install.ps1" -OutFile "install-lmstudio.ps1"
    & .\install-lmstudio.ps1
    Write-Host "LM Studio installed successfully."
}

# Step 3: Pull a model based on user input
function Choose-And-Pull-Model {
    Write-Host "Choose a model to use for Claude Code. Here are some options:"
    Write-Host "1. devstral-small-2 (24B)"
    Write-Host "2. glm-4.7-flash:bf16 (30B)"
    Write-Host "3. qwen3-coder (30B)"
    $modelChoice = Read-Host "Enter the number corresponding to your choice"

    switch ($modelChoice) {
        "1" {
            Write-Host "Pulling model 'devstral-small-2'..."
            ollama pull devstral-small-2
            $modelName = "devstral-small-2"
        }
        "2" {
            Write-Host "Pulling model 'glm-4.7-flash:bf16'..."
            ollama pull glm-4.7-flash:bf16
            $modelName = "glm-4.7-flash:bf16"
        }
        "3" {
            Write-Host "Pulling model 'qwen3-coder'..."
            ollama pull qwen3-coder
            $modelName = "qwen3-coder"
        }
        default {
            Write-Host "Invalid choice. Using 'devstral-small-2' by default."
            ollama pull devstral-small-2
            $modelName = "devstral-small-2"
        }
    }
    Write-Host "Model '$modelName' pulled successfully."
}

# Step 4: Set environment variables for Ollama
function Set-EnvVariables {
    Write-Host "Setting environment variables..."
    $env:ANTHROPIC_BASE_URL = "http://localhost:11434"
    $env:ANTHROPIC_AUTH_TOKEN = "ollama"
    $env:ANTHROPIC_API_KEY = ""

    # For persistent environment variables, add them to PowerShell profile
    Add-Content -Path $PROFILE -Value "`n$env:ANTHROPIC_BASE_URL = 'http://localhost:11434'"
    Add-Content -Path $PROFILE -Value "`n$env:ANTHROPIC_AUTH_TOKEN = 'ollama'"
    Add-Content -Path $PROFILE -Value "`n$env:ANTHROPIC_API_KEY = ''"

    Write-Host "Environment variables set successfully."
}

# Step 5: Launch Claude with the chosen model
function Launch-Claude {
    Write-Host "Launching Claude with the selected model '$modelName'..."
    ollama launch claude --model $modelName
    Write-Host "Claude launched successfully with '$modelName'."
}

# Step 6: Troubleshooting and common fixes
function Troubleshoot {
    Write-Host "Troubleshooting steps if something goes wrong:"
    Write-Host "- Ensure that your machine meets the minimum requirements (32GB RAM, etc.)"
    Write-Host "- If you face permission issues with Ollama installation, try running with 'Run as Administrator'."
    Write-Host "- Check your internet connection during the model pull process, as large models can take time."
    Write-Host "- Ensure environment variables are correctly set by reviewing '$PROFILE'."
}

# Main Execution
Check-OllamaInstalled
Install-LMStudio
Choose-And-Pull-Model
Set-EnvVariables
Launch-Claude

# Troubleshooting guide
Troubleshoot

Write-Host "Claude setup and launch completed."

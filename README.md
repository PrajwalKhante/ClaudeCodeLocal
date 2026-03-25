# Claude Code Local Setup Script (Windows Version)

This repository provides an automated script to set up and run Claude Code with local models on Windows. The script supports multiple local model options, including Ollama, LM Studio, and llama.cpp.

## Features:
- Installs Ollama if not already installed.
- Prompts the user to select a model from options: `devstral-small-2`, `glm-4.7-flash:bf16`, and `qwen3-coder`.
- Pulls the selected model and sets up environment variables for Claude Code.
- Launches Claude Code with the selected model.
- Provides troubleshooting steps for common issues.

## Requirements:
- **RAM:** Minimum 32GB recommended (depending on model size).
- **OS:** Windows 10/11.
- **Hardware:** For smooth operation, a machine with sufficient RAM and GPU is recommended for large models (e.g., 24B+ parameters).

## Installation:

1. **Clone this repository** to your local machine:
   ```bash
   git clone https://github.com/yourusername/claude-local-setup.git
   cd claude-local-setup

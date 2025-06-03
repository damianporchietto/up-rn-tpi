#!/bin/bash

# Script to set up Python virtual environment and install requirements
# for GTZAN Music Genre Classification Project

set -e  # Exit on any error

# Configuration
VENV_NAME="gtzan_env"
PYTHON_VERSION="python3"

echo "🎵 Setting up GTZAN Music Classification Environment..."
echo "=================================================="

# Check if Python is available
if ! command -v $PYTHON_VERSION &> /dev/null; then
    echo "❌ Error: $PYTHON_VERSION is not installed or not in PATH"
    exit 1
fi

echo "✅ Found Python: $(which $PYTHON_VERSION)"
echo "   Version: $($PYTHON_VERSION --version)"

# Create virtual environment
echo ""
echo "📦 Creating virtual environment '$VENV_NAME'..."
if [ -d "$VENV_NAME" ]; then
    echo "⚠️  Virtual environment '$VENV_NAME' already exists."
    read -p "Do you want to remove it and create a new one? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🗑️  Removing existing virtual environment..."
        rm -rf "$VENV_NAME"
    else
        echo "❌ Aborted. Please remove '$VENV_NAME' manually or use a different name."
        exit 1
    fi
fi

$PYTHON_VERSION -m venv "$VENV_NAME"
echo "✅ Virtual environment created successfully!"

# Activate virtual environment
echo ""
echo "🔄 Activating virtual environment..."
source "$VENV_NAME/bin/activate"

# Upgrade pip
echo ""
echo "⬆️  Upgrading pip..."
pip install --upgrade pip

# Install requirements
echo ""
echo "📋 Installing requirements from requirements.txt..."
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
    echo "✅ All requirements installed successfully!"
else
    echo "❌ Error: requirements.txt not found in current directory"
    echo "   Make sure you're running this script from the project root"
    exit 1
fi

# Show installed packages
echo ""
echo "📚 Installed packages:"
pip list

echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "To activate the environment in the future, run:"
echo "   source $VENV_NAME/bin/activate"
echo ""
echo "To deactivate the environment, run:"
echo "   deactivate"
echo ""
echo "Happy coding! 🚀" 
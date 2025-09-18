#!/bin/bash

# Code Formatting Script
# Automatically formats all code in the project

set -e  # Exit on any error

echo "🎨 Formatting code..."
echo

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
    echo "❌ Error: pyproject.toml not found. Please run from project root."
    exit 1
fi

echo "🔤 Sorting imports with isort..."
uv run isort .

echo "🖤 Formatting code with black..."
uv run black .

echo "📋 Running ruff auto-fixes..."
uv run ruff check --fix .

echo
echo "✅ Code formatting complete!"
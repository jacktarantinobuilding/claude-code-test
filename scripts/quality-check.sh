#!/bin/bash

# Code Quality Check Script
# Runs all quality checks for the project

set -e  # Exit on any error

echo "🧹 Running code quality checks..."
echo

# Check if we're in the right directory
if [ ! -f "pyproject.toml" ]; then
    echo "❌ Error: pyproject.toml not found. Please run from project root."
    exit 1
fi

echo "📋 Running ruff linter..."
uv run ruff check .

echo
echo "🎨 Running black formatter check..."
uv run black --check --diff .

echo
echo "🔤 Running isort import sorting check..."
uv run isort --check-only --diff .

echo
echo "🔍 Running mypy type checking..."
uv run mypy backend/ main.py

echo
echo "✅ All quality checks passed!"
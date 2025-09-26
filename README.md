# Ollama R Package Checker

A tool for checking R packages using Ollama.

## Python Environment Setup

This project uses [uv](https://github.com/astral-sh/uv) for Python package management, which provides fast and reliable dependency resolution.

### Prerequisites

- Python 3.8 or higher
- `uv` (automatically installed in the dev container)

### Environment Initialization

1. **Create and activate a virtual environment:**
   ```bash
   uv venv
   source .venv/bin/activate  # On Linux/macOS
   # or
   .venv\Scripts\activate     # On Windows
   ```

2. **Install dependencies:**
   ```bash
   uv pip install -e .
   ```

3. **Install development dependencies (optional):**
   ```bash
   uv pip install -e ".[dev]"
   ```

### Alternative: Using uv sync (Recommended)

For a more streamlined workflow, you can use `uv sync` which automatically creates the virtual environment and installs dependencies:

```bash
uv sync
source .venv/bin/activate
```

### Development Workflow

- **Add new dependencies:**
  ```bash
  uv add package-name
  ```

- **Add development dependencies:**
  ```bash
  uv add --dev package-name
  ```

- **Run tests:**
  ```bash
  pytest
  ```

- **Format code:**
  ```bash
  black .
  ruff check .
  ```

## Interactive Development with Quarto

This project includes Quarto support for interactive markdown-based development. Quarto allows you to combine Python code execution with rich markdown documentation.

### Getting Started with Quarto

1. **Install development dependencies (includes Jupyter):**
   ```bash
   uv sync --group dev
   ```

2. **Preview a Quarto document:**
   ```bash
   quarto preview example.qmd
   ```

3. **Render to HTML:**
   ```bash
   quarto render example.qmd
   ```

### Quarto Features

- **Interactive code execution**: Run Python code blocks within markdown
- **Live preview**: See changes in real-time with `quarto preview`
- **Rich output**: Support for plots, tables, and formatted text
- **Multiple formats**: Render to HTML, PDF, Word, and more

### Example Usage

The included `example.qmd` file demonstrates:
- Package integration and testing
- Ollama client interaction
- Data analysis and visualization
- Interactive development workflow

### Dev Container

This project includes a VS Code dev container with all necessary tools pre-installed (including Quarto CLI). When you open the project in VS Code, you'll be prompted to reopen in the container, which will automatically set up the environment.

## Usage

After installation, you can use the package in several ways:

### Command Line
```bash
ollama-r-pkg-checker
```

### Python Module
```bash
python -m ollama_r_pkg_checker.main
```

### Interactive Development
```bash
quarto preview example.qmd  # Interactive Quarto document
```

## Project Structure

```
.
├── .devcontainer/              # Dev container configuration
├── ollama_r_pkg_checker/       # Main Python package
│   ├── __init__.py            # Package initialization
│   └── main.py                # Main functionality
├── pyproject.toml             # Python project configuration
├── example.qmd                # Quarto example document
├── README.md                  # This file
└── ...                        # Other project files
```
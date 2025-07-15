# TA-Lib API Docker Deployment

This project provides a simple Flask API that uses TA-Lib (Technical Analysis Library) to perform financial technical analysis calculations. The application is containerized using Docker for easy deployment.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/) (optional, but recommended)

## Project Structure

```
.
├── app.py              # Flask application with TA-Lib endpoints
├── Dockerfile          # Docker container configuration
├── docker-compose.yml  # Docker Compose configuration
├── .dockerignore       # Files to exclude from Docker build
├── requirements.txt    # Python dependencies
└── README.md           # This file
```

## Deployment Instructions

### Option 1: Using Docker Compose (Recommended)

1. Build and start the container:
   ```bash
   docker-compose up --build
   ```

2. The API will be available at http://localhost:8000

3. To stop the container:
   ```bash
   docker-compose down
   ```

### Option 2: Using Docker Directly

1. Build the Docker image:
   ```bash
   docker build -t talib-api .
   ```

2. Run the container:
   ```bash
   docker run -p 8000:8000 talib-api
   ```

3. The API will be available at http://localhost:8000

## Project Purpose

This project demonstrates the successful deployment of the TA-Lib technical analysis library in a Docker container, along with compatible versions of NumPy and pandas. It serves as a reference implementation for properly installing and configuring these libraries together.

## Notes on TA-Lib

The TA-Lib C library is automatically installed during the Docker build process. This handles the complex dependency installation that would otherwise be required on the host machine.

## Package Compatibility

This project uses specific package versions to ensure compatibility:

### TA-Lib 0.6.x (Latest)

- **TA-Lib C Library 0.6.4**: Latest version with modernized build system using autotools and CMake
- **TA-Lib Python 0.6.3**: Compatible with the 0.6.x C library
- **Key Changes in 0.6.x**:
  - Library naming changed from `libta_lib.so` to `libta-lib.so`
  - Header files moved to `ta-lib` subdirectory
  - No longer requires manual symlink creation

### Python and NumPy Compatibility

| Python Version | Compatible NumPy Versions | Compatible pandas Versions |
|----------------|---------------------------|----------------------------|
| 3.9            | 1.x, 2.0.x               | ≤ 2.1.x                    |
| 3.10           | 1.x, 2.0.x, 2.1.x, 2.2.x | 2.2.x                      |
| 3.11+          | 1.x, 2.0.x, 2.1.x, 2.2.x, 2.3.x | 2.2.x, 2.3.x        |

### Current Configuration

- **Python**: 3.10
- **TA-Lib**: 0.6.3
- **NumPy**: 2.2.6
- **pandas**: 2.2.2
- **Flask**: 2.3.3

> **Note**: If you need to use NumPy 2.3.x or pandas 2.3.x, you'll need to upgrade to Python 3.11+

## Development

To develop locally without Docker, you'll need to:

1. Install TA-Lib C library on your system:
   - **macOS**: `brew install ta-lib`
   - **Linux**: See instructions in the Dockerfile
   - **Windows**: Download pre-built binaries from https://www.lfd.uci.edu/~gohlke/pythonlibs/#ta-lib

2. Install dependencies using either pip or uv:

   **Option 1: Using pip with requirements.txt**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```

   **Option 2: Using uv with pyproject.toml (Recommended)**
   ```bash
   # Install uv if you don't have it
   pip install uv
   
   # Create virtual environment and install dependencies
   uv venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   uv pip install -e .
   ```

3. Run the application:
   ```bash
   python app.py
   ```

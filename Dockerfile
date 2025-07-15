FROM python:3.10

# Install dependencies required for TA-Lib
RUN apt-get update && \
    apt-get install -y build-essential wget pkg-config git automake libtool && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install TA-Lib 0.6.4 C library
RUN wget https://github.com/ta-lib/ta-lib/releases/download/v0.6.4/ta-lib-0.6.4-src.tar.gz && \
    tar -xzf ta-lib-0.6.4-src.tar.gz && \
    cd ta-lib-0.6.4/ && \
    ./configure --prefix=/usr --build=$(uname -m)-unknown-linux-gnu && \
    make && \
    make install && \
    cd .. && \
    rm -rf ta-lib-0.6.4 ta-lib-0.6.4-src.tar.gz
    
# Verify and configure library paths
RUN ls -la /usr/lib/ | grep ta && \
    echo "/usr/lib" > /etc/ld.so.conf.d/ta-lib.conf && \
    ldconfig

# Set up the application
WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Set environment variables for TA-Lib 0.6.x installation
# Note: Headers are now in /usr/include/ta-lib/ directory
ENV TA_LIBRARY_PATH=/usr/lib
ENV TA_INCLUDE_PATH=/usr/include/ta-lib

# Install NumPy first (dependency for TA-Lib)
RUN pip install numpy==2.2.6

# Install TA-Lib Python wrapper from source for better compatibility with 0.6.x
RUN pip install Cython && \
    pip install --no-binary ta-lib ta-lib==0.6.3

# Install remaining Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Expose the port the app will run on
EXPOSE 8000

# Command to run the application
CMD ["python", "app.py"]

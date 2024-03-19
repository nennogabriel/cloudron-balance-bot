# Use the specified Cloudron base image
FROM cloudron/base:4.2.0@sha256:46da2fffb36353ef714f97ae8e962bd2c212ca091108d768ba473078319a47f4

# Set environment variables for application home and data directories
ENV APP_HOME=/app/code
ENV DATA_DIR=/app/data
ENV BB_DIR=${APP_HOME}/bb

# Create the application directory
RUN mkdir -p ${APP_HOME} ${DATA_DIR} ${BB_DIR} && \
    chown cloudron:cloudron ${APP_HOME} ${DATA_DIR} ${BB_DIR}
WORKDIR ${APP_HOME}

# Install dependencies
RUN apt-get update && \
    apt-get install -y nodejs npm git && \
    npm install -g npm@latest

# Explicitly update package lists again before installing expect
RUN apt-get update && \
    apt-get install -y expect

# Corrected clone command to use BB_DIR
RUN git clone https://github.com/hodlerhacks/balance-bot-v2 ${BB_DIR}

# Navigate to the Balance Bot directory
WORKDIR ${BB_DIR}

# Install Node.js dependencies including fs-extra and prompt-sync
RUN npm install && \
    npm install fs-extra prompt-sync

RUN which expect && expect -v
# If you have an expect script to automate installation, it goes here
COPY install.expect . 
RUN chmod +x install.expect && ./install.expect

WORKDIR ${APP_HOME}

# # Copy files to the application directory
# COPY ${BB_DIR} $(DATA_DIR)

# Create a symbolic link to the Balance Bot directory run directory
RUN ln -s ${DATA_DIR}/bb ${BB_DIR}/run


# Copy the custom start script or use the one provided by the application
# Ensure the start script is executable
COPY start.sh ${APP_HOME}/start.sh
RUN chmod +x ${APP_HOME}/start.sh

# Command to start the application
CMD ["./start.sh"]

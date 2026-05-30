FROM ubuntu:22.04
 
LABEL maintainer="devops-trainee"
LABEL description="Wisecow – cow wisdom web server"
 
# Avoid interactive prompts during apt install
ENV DEBIAN_FRONTEND=noninteractive
 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fortune-mod \
        fortunes \
        cowsay \
        netcat-openbsd \
        bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
 
# cowsay installs to /usr/games – add to PATH
ENV PATH="/usr/games:${PATH}"
 
# Set working directory
WORKDIR /app
 
# Copy the wisecow shell script into the container
COPY wisecow.sh .
RUN sed -i 's/\r//' wisecow.sh
 
# Make the script executable
RUN chmod +x wisecow.sh
 
# Wisecow listens on port 4499 by default
EXPOSE 4499
 
# Run the wisecow server
CMD ["bash", "wisecow.sh"]
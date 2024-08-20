FROM jenkins/jenkins:lts

USER root

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common \
        build-essential \
        git \
        ssh \
        zip \
        unzip \
        jq \
        openssh-client && \
    # Detect architecture and install Docker CLI if amd64
    if [ "$(dpkg --print-architecture)" = "amd64" ]; then \
        curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
        add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
        apt-get update && \
        apt-get install -y --no-install-recommends docker-ce-cli; \
    fi && \
    # Install kubectl with the updated repository URL
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.26/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.26/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends kubectl && \
    # Clean up to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Distributed Builds plugins using jenkins-plugin-cli
RUN jenkins-plugin-cli --plugins \
    ssh-agent email-ext mailer slack htmlpublisher \
    greenballs simple-theme-plugin kubernetes

USER jenkins

FROM jenkins/jenkins:lts

USER root

# Install required packages and update package lists
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
    # Install Docker CLI
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        docker-ce-cli && \
    # Install kubectl
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        kubectl && \
    rm -rf /var/lib/apt/lists/*

# Distributed Builds plugins
RUN /usr/local/bin/install-plugins.sh ssh-agent \
    email-ext \
    mailer \
    slack \
    htmlpublisher \
    greenballs \
    simple-theme-plugin \
    kubernetes

USER jenkins

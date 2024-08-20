#!/bin/bash

# ASCII Art Welcome
cat << "EOF"
     ____.              __   .__                                   _____  .__       .__ __        ___.
    |    | ____   ____ |  | _|__| ____   ______   ____   ____     /     \ |__| ____ |__|  | ____ _\_ |__   ____
    |    |/ __ \ /    \|  |/ /  |/    \ /  ___/  /  _ \ /    \   /  \ /  \|  |/    \|  |  |/ /  |  \ __ \_/ __ \
/\__|    \  ___/|   |  \    <|  |   |  \\___ \  (  <_> )   |  \ /    Y    \  |   |  \  |    <|  |  / \_\ \  ___/
\________|\___  >___|  /__|_ \__|___|  /____  >  \____/|___|  / \____|__  /__|___|  /__|__|_ \____/|___  /\___  >
              \/     \/     \/       \/     \/              \/          \/        \/        \/         \/     \/
EOF

echo "Welcome to Jenkins on Kubernetes!"

# Function to check for command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install minikube
install_minikube() {
    echo "Installing Minikube..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 || { echo "Failed to download Minikube. Exiting."; exit 1; }
        sudo install minikube /usr/local/bin/ || { echo "Failed to install Minikube. Exiting."; exit 1; }
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install minikube || { echo "Failed to install Minikube via Homebrew. Exiting."; exit 1; }
    else
        echo "Unsupported OS for Minikube installation. Please install manually."
        exit 1
    fi
}

# Function to install kubectl
install_kubectl() {
    echo "Installing kubectl..."
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" || { echo "Failed to download kubectl. Exiting."; exit 1; }
        chmod +x kubectl
        sudo mv kubectl /usr/local/bin/ || { echo "Failed to move kubectl to /usr/local/bin/. Exiting."; exit 1; }
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install kubectl || { echo "Failed to install kubectl via Homebrew. Exiting."; exit 1; }
    else
        echo "Unsupported OS for kubectl installation. Please install manually."
        exit 1
    fi
}

# Check if Minikube is installed
if command_exists minikube; then
    echo "Minikube is already installed."
else
    read -p "Minikube is not installed. Do you want to install it? (y/n): " install_minikube_choice
    if [[ "$install_minikube_choice" == "y" ]]; then
        install_minikube
    else
        echo "Minikube is required. Exiting."
        exit 1
    fi
fi

# Check if kubectl is installed
if command_exists kubectl; then
    echo "kubectl is already installed."
else
    read -p "kubectl is not installed. Do you want to install it? (y/n): " install_kubectl_choice
    if [[ "$install_kubectl_choice" == "y" ]]; then
        install_kubectl
    else
        echo "kubectl is required. Exiting."
        exit 1
    fi
fi

# Start Minikube cluster
read -p "Do you want to start a Minikube cluster? (y/n): " start_minikube_choice
if [[ "$start_minikube_choice" == "y" ]]; then
    minikube start || { echo "Failed to start Minikube. Exiting."; exit 1; }
else
    echo "Minikube cluster is required. Exiting."
    exit 1
fi

# Wait for Minikube to be fully ready
echo "Waiting for Minikube to be fully ready..."
sleep 10  # Adjust this value as needed

# Create Jenkins namespace
kubectl create namespace jenkins || { echo "Failed to create Jenkins namespace. Exiting."; exit 1; }

# Create PersistentVolume and PersistentVolumeClaim
echo "Creating PersistentVolume and PersistentVolumeClaim for Jenkins..."
cat <<EOF | kubectl apply -f - || { echo "Failed to create PersistentVolume and PersistentVolumeClaim. Exiting."; exit 1; }
apiVersion: v1
kind: PersistentVolume
metadata:
  name: jenkins-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data/jenkins"

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jenkins-pvc
  namespace: jenkins
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
EOF

# Apply RBAC configuration
kubectl apply -f jenkins-admin-rbac.yaml -n jenkins || { echo "Failed to apply RBAC configuration. Exiting."; exit 1; }

# Deploy Jenkins service
kubectl apply -f jenkins-service.yaml -n jenkins || { echo "Failed to deploy Jenkins service. Exiting."; exit 1; }

# Deploy Jenkins
kubectl apply -f jenkins-deployment.yaml -n jenkins || { echo "Failed to deploy Jenkins. Exiting."; exit 1; }

# Wait for Jenkins to be ready
echo "Waiting for Jenkins to start..."
kubectl rollout status deployment/jenkins -n jenkins || { echo "Jenkins deployment failed. Exiting."; exit 1; }

# Port-forward Jenkins service to access the UI
echo "Forwarding port to access Jenkins UI..."
nohup kubectl port-forward svc/jenkins 8080:8080 -n jenkins >/dev/null 2>&1 &
sleep 5

# Print out Jenkins access information
jenkins_url="http://localhost:8080"
echo "Jenkins is now running on Minikube."
echo "Access Jenkins at: $jenkins_url"

# Launch Jenkins UI in the default web browser
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "$jenkins_url"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open "$jenkins_url"
else
    echo "Please manually open your web browser and go to $jenkins_url"
fi

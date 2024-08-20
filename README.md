Here’s the updated `README.md` with steps for using the `getstarted.sh` script as well as the manual steps.

---

# Welcome to Jenkins on Kubernetes!

This guide will help you set up Jenkins on Kubernetes using Minikube in a few simple steps. Follow the instructions below to get started.

## Table of Contents

1. [Code Walkthrough](#code-walkthrough)
2. [Steps to Get Started (Manual)](#steps-to-get-started-manual)
3. [Steps to Get Started (Using `getstarted.sh` Script)](#steps-to-get-started-using-getstartedsh-script)
4. [Opening Issues and Submitting Pull Requests](#opening-issues-and-submitting-pull-requests)

## Code Walkthrough

The project consists of several key files and scripts that are necessary to deploy Jenkins on a Kubernetes cluster. Let's walk through the main components:

### 1. `Dockerfile`

The `Dockerfile` sets up a Jenkins instance with required tools such as Docker CLI and `kubectl`. It installs necessary packages and plugins to make Jenkins work seamlessly within a Kubernetes environment. The final image can be used as a Jenkins master node.

Key steps:
- **Base Image**: Starts with the official Jenkins LTS image.
- **Packages Installation**: Installs essential packages like Docker CLI, `kubectl`, and others.
- **Plugins Installation**: Uses `jenkins-plugin-cli` to install plugins necessary for Kubernetes integration.

### 2. `getstarted.sh`

This script automates the process of setting up Jenkins on Kubernetes. It checks for the existence of Minikube and `kubectl`, installs them if necessary, and then sets up the Kubernetes cluster and Jenkins deployment.

Key steps:
- **Minikube and `kubectl` Installation**: Installs Minikube and `kubectl` if they are not already installed.
- **Kubernetes Cluster Setup**: Starts a Minikube cluster.
- **Jenkins Deployment**: Creates necessary resources like namespace, PersistentVolume, RBAC configurations, and then deploys Jenkins.
- **Port Forwarding**: Automatically forwards the Jenkins service port to your local machine for easy access.

### 3. `jenkins-admin-rbac.yaml`

This file configures Role-Based Access Control (RBAC) for Jenkins, granting it the necessary permissions to interact with Kubernetes resources.

### 4. `jenkins-service.yaml`

Defines the Jenkins service in Kubernetes, exposing it on a specific NodePort for external access.

### 5. `jenkins-deployment.yaml`

This file sets up the actual Jenkins deployment in Kubernetes, specifying the image to use, volume mounts, and other deployment details.

## Steps to Get Started (Manual)

1. **Start Minikube**:
   Set up a local Kubernetes cluster by running the following command:
   ```bash
   minikube start
   ```

2. **Create a Namespace for Jenkins**:
   Organize Jenkins resources under a dedicated namespace:
   ```bash
   kubectl create namespace jenkins
   ```

3. **Apply RBAC Configuration**:
   Grant Jenkins the necessary permissions:
   ```bash
   kubectl apply -f jenkins-admin-rbac.yaml
   ```

4. **Create Jenkins Service**:
   Deploy the Jenkins service:
   ```bash
   kubectl apply -f jenkins-service.yaml
   ```

5. **Deploy Jenkins**:
   Deploy the Jenkins instance:
   ```bash
   kubectl apply -f jenkins-deployment.yaml
   ```

6. **Get Minikube IP**:
   Obtain the Minikube IP:
   ```bash
   minikube ip
   ```

7. **Access Jenkins UI**:
   Combine the Minikube IP with the NodePort to access Jenkins. For example:
   ```bash
   http://<Minikube-IP>:<NodePort>
   ```

8. **Configure Build Executor**:
   In Jenkins UI, navigate to "Manage Jenkins" > "Manage Nodes and Clouds" to configure the Kubernetes cloud.

9. **Test the Connection**:
   Verify the Kubernetes integration by testing the connection within Jenkins.

10. **Create and Run a Job**:
    Set up a freestyle job in Jenkins to confirm everything is functioning as expected.

## Steps to Get Started (Using `getstarted.sh` Script)

To automate the entire setup process, you can use the provided `getstarted.sh` script:

1. **Ensure Prerequisites**:
   Ensure that you have a bash-compatible shell, and that the script is executable. If needed, make it executable with:
   ```bash
   chmod +x getstarted.sh
   ```

2. **Run the Script**:
   Execute the script:
   ```bash
   ./getstarted.sh
   ```

3. **Follow the Prompts**:
   The script will guide you through the installation process. It will:
   - Install Minikube and `kubectl` if they are not already installed.
   - Start a Minikube cluster.
   - Set up Kubernetes resources and deploy Jenkins.
   - Automatically forward the Jenkins service port to your local machine.

4. **Access Jenkins UI**:
   Once the script completes, it will provide you with a URL to access Jenkins, such as `http://localhost:8080`. Open this in your web browser.

## Opening Issues and Submitting Pull Requests

If you encounter any issues or have suggestions for new features, you can open an issue or submit a pull request. Here's how:

- **Opening Issues**: Navigate to the [GitHub Issues page](https://github.com/markyjackson-taulia/jenkinsci-on-kubernetes/issues) and create a new issue. Please provide as much detail as possible, including steps to reproduce the problem if applicable.

- **Submitting Pull Requests**: Fork the repository, make your changes, and submit a pull request. Ensure that your code follows the existing style and conventions. If you're adding new functionality, consider adding relevant tests.

**DockerHub Repository**: You can find the pre-built Docker image on DockerHub [here](https://hub.docker.com/repository/docker/anuclei/jenkins-on-kubernetes).

Enjoy a seamless CI/CD experience with Jenkins on Kubernetes!

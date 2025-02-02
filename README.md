# DevOps Python Web App Deployment

This project demonstrates a DevOps pipeline for deploying a Python web application using Docker, Terraform, and GitHub Actions.

## Project Overview
- **Web Application**: A simple Flask-based Python web app.
- **Containerization**: The app is containerized using Docker.
- **CI/CD Pipeline**: GitHub Actions automates building, testing, and deploying the app.
- **Infrastructure as Code (IaC)**: Terraform provisions and manages the cloud infrastructure.
- **Deployment Target**: Azure Container Instances.

## Project Structure
```
├── .github/workflows/deploy.yml  # GitHub Actions pipeline
├── app.py                         # Flask application
├── requirements.txt               # Python dependencies
├── Dockerfile                     # Docker image setup
├── terraform/
│   ├── main.tf                    # Terraform configuration
│   ├── variables.tf                # Terraform variables (if needed)
│   ├── outputs.tf                  # Terraform outputs (if needed)
└── README.md                       # Project documentation
```

## Prerequisites
- **Docker** installed on your local machine.
- **Terraform** installed.
- **GitHub Repository** with GitHub Actions enabled.
- **Azure Subscription** (if deploying to Azure).
- **Docker Hub Account** (for pushing the container image).

## Setup & Usage

### 1. Clone the Repository
```sh
git clone https://github.com/your-username/devops-python-app.git
cd devops-python-app
```

### 2. Build and Run Locally
```sh
docker build -t flask-app .
docker run -p 5000:5000 flask-app
```
Access the app at `http://localhost:5000`

### 3. Push to Docker Hub
```sh
docker tag flask-app your-dockerhub-username/flask-app:latest
docker push your-dockerhub-username/flask-app:latest
```

### 4. Deploy Infrastructure with Terraform
```sh
cd terraform
terraform init
terraform apply -auto-approve
```

### 5. Configure GitHub Secrets
Add the following secrets to your GitHub repository:
- `DOCKER_HUB_USERNAME`
- `DOCKER_HUB_PASSWORD`
- `AZURE_CREDENTIALS` (for Terraform authentication)

### 6. GitHub Actions CI/CD Pipeline
The pipeline automatically triggers on `push` to the `main` branch.
- **Builds and tests** the Docker image.
- **Pushes the image** to Docker Hub.
- **Deploys infrastructure** using Terraform.

## Cleanup
To destroy the deployed infrastructure, run:
```sh
cd terraform
terraform destroy -auto-approve
```

## License
This project is open-source and available under the MIT License.

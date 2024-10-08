# Terraform Datadog EKS

This repository provides Terraform configurations for deploying an Amazon EKS (Elastic Kubernetes Service) cluster, simple bash script which uses some pre-deploy packages along with kubernetes manifest that deploys a sample application integrated with Datadog for monitoring and observability.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Stack](stack)
- [Deployment](#deployment)
- [Assumptions](assumptions)
- [Monitoring with Datadog](#monitoring-with-datadog)
- [Cleanup](#cleanup)
- [Duration](#duration)


## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) 
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 
- [kubeseal](https://docs.coreweave.com/coreweave-kubernetes/sealed-secrets)

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/amydeg25/sosafe-dummy-aman.git
   cd terraform-datadog-eks
   ```

2. Configure your AWS credentials and set them as environment variables

  ```bash
  aws configure
  export AWS_ACCESS_KEY_ID="your_aws_access_key_id"
  export AWS_SECRET_ACCESS_KEY="your_aws_secret_access_key"
  export DATADOG_API_KEY="api_key"
  ```

## Stack

1. Terraform for Infrastructure-As-Code(IAC)
2. AWS EKS managed Cluster to deploy a dummy app: 
https://github.com/sosafe-site-reliability-engineering/dummy-app/ 
3. The whole setup is deployed within a VPC, with Application Load Balancer(ALB) in Public Subnet and Nodes and Application in a Private Subnet.
4. External DNS is configured for automatic scanning of ingresses and update the records in Route 53.
5. Cert Manager is used for the automatic TLS configuration for the app.
6. Domain Filter used here is "jklikl.xyz", my test domain in GoDaddy using AWS Name Servers.
7. Metrics endpoint is configured as annotations in deployment manifest to be used by Datadog for scraping.
8. Sample Metrics Dashboard and Monitors are created in Datadog for alerting.

## Deployment 

1. To deploy the EKS cluster, run the below commands one by one:

  ```bash
  cd terraform-infra
  terraform init
  terraform plan
  terraform apply 
  ```

2. Once the apply is complete, run by verifying:
  
  ```bash
  kubectl get nodes
  kubectl get svc
  ```

3. To deploy the packages and kubernetes manifests for app deployment:

  ```bash
  ./pre-requisites.sh
  ```
4. To verify and see what all is configured on the cluster:

  ```bash
  kubectl get all -A
  ``` 
5. For Datadog, follow the `Datadog integration guide` for EKS to set up your Datadog account and APIkey.

## Assumptions

1. As this setup is for assignment so I have used SPOT for capacity for cost efficiency.
2. As a minimal viable test product, I have not used CI/CD approach using (Github Actions/Flux).
3. Tried using latest versions where possible(have used a bit older only for stability but have also added the upgrade comments for them) with Security practices using locals, variables and also sealed secrets for kubernetes secrets.
4. Cluster AutoScaler/HPA has not been configured as we are assuming a test setup without huge load.
5. Resources (Requests/Limits) are not used for all the services which are recommended for prod.
6. Would have also created a test user with limited permissions to access the cluster in prod setup.
7. Image provided have been used directly, in prod setup it would be pushed to the public repo and used in the manifests.
8. Also in CI/CD, I would have configured SonarQube for Code Analysis, Trivy for Image Scans and Kyverno for resources like NameSpace, Pod and Cluster related policies.
9. Am also using here just the main branch, but in prod we would add a proper CICD flow with multiple branches like "dev" , "staging".
10. Also for Remote Backend, we assume that we already have a S3 bucket setup in AWS.

## Monitoring with Datadog

Once the setup is complete, you can monitor your EKS cluster in Datadog. 
Visit the Datadog dashboard to view metrics, configure monitors and alerting.

## Cleanup

  ```bash 
  terraform destroy 
  ```

## Duration: 

Will update this once I setup the project on development environment.

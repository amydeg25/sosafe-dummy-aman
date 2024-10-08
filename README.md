# Terraform Datadog EKS

This repository provides Terraform configurations for deploying an Amazon EKS (Elastic Kubernetes Service) cluster, simple bash script which uses some pre-deploy packages along with kubernetes manifest that deploys a sample application integrated with Datadog for monitoring and observability.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Stack](stack)
- [Deployment](#deployment)
- [Assumptions](assumptions)
- [Configuration](#configuration)
- [Monitoring with Datadog](#monitoring-with-datadog)
- [Cleanup](#cleanup)


## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) 
- [AWS CLI](https://aws.amazon.com/cli/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 
- [kubeseal](https://docs.coreweave.com/coreweave-kubernetes/sealed-secrets)

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/amydeg25/terraform-datadog-eks.git
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
3. The whole setup is deployed within a VPC, with ALB Load Balancer in Public Subnet and Nodes and Application in a Private Subnet.
4. External DNS is configured for automatic scanning of ingresses and update the records in Route 53.
5. Cert Manager is used for the automatic TLS configuration for the app.
6. Domain Filter used here is jklikl.xyz, my test domain in GoDaddy using AWS Name Servers.






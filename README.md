# Terraform Datadog EKS

This repository provides Terraform configurations for deploying an Amazon EKS (Elastic Kubernetes Service) cluster, deploys a sample application integrated with Datadog for monitoring and observability.

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





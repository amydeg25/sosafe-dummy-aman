# Terraform Datadog EKS

This repository provides Terraform configurations for deploying an Amazon EKS (Elastic Kubernetes Service) cluster, deploys a sample application integrated with Datadog for monitoring and observability.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Deployment](#deployment)
- [Configuration](#configuration)
- [Monitoring with Datadog](#monitoring-with-datadog)
- [Cleanup](#cleanup)
- [License](#license)

## Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (version X.X or later)
- [AWS CLI](https://aws.amazon.com/cli/) (version X.X or later)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (version X.X or later)
- [Datadog Agent](https://docs.datadoghq.com/agent/) (optional for agent installation)

## Getting Started

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/amydeg25/terraform-datadog-eks.git
   cd terraform-datadog-eks

#!/bin/bash

# Set variables
DATADOG_REPO="https://helm.datadoghq.com"
AWS_ACCESS_KEY_ID="your_aws_access_key_id"
AWS_SECRET_ACCESS_KEY="your_aws_secret_access_key"
CERT_MANAGER_VERSION="v1.12.2"

# Add Helm repository for Datadog
helm repo add datadog $DATADOG_REPO
helm repo update

# Install Datadog Operator
helm install datadog-operator datadog/datadog-operator

# Create Datadog secret
kubectl create secret generic datadog-secret --from-literal api-key=$DATADOG_API_KEY

# Create namespaces if they do not exist
kubectl create ns cert-manager --dry-run=client -o yaml | kubectl apply -f -


# Create AWS credentials secrets for external-dns
kubectl create secret generic external-dns-aws-credentials \
    --from-literal=aws-access-key-id=$AWS_ACCESS_KEY_ID \
    --from-literal=aws-secret-access-key=$AWS_SECRET_ACCESS_KEY \
    -n kube-system

# Apply Cert-Manager CustomResourceDefinitions and install Cert-Manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERT_MANAGER_VERSION/cert-manager.crds.yaml

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERT_MANAGER_VERSION/cert-manager.yaml
check_error "Failed to install Cert-Manager"

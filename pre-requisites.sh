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

# Create Datadog secret for API key
kubectl create secret generic datadog-secret --from-literal api-key=$DATADOG_API_KEY

# Create namespaces if they do not exist (cert-manager)
kubectl create ns cert-manager --dry-run=client -o yaml | kubectl apply -f -

# Create AWS credentials secret for external-dns
kubectl create secret generic external-dns-aws-credentials \
    --from-literal=aws-access-key-id=$AWS_ACCESS_KEY_ID \
    --from-literal=aws-secret-access-key=$AWS_SECRET_ACCESS_KEY \
    -n kube-system

# Apply Cert-Manager CustomResourceDefinitions and install Cert-Manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERT_MANAGER_VERSION/cert-manager.crds.yaml
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERT_MANAGER_VERSION/cert-manager.yaml

# Sealed Secrets installation
# Add Helm repository for Sealed Secrets
helm repo add sealed-secrets https://bitnami-labs.github.io/sealed-secrets
helm repo update

# Install Sealed Secrets controller into the kube-system namespace
helm install sealedsecrets-release sealed-secrets/sealed-secrets -n kube-system

# Install kubeseal CLI (Assuming you are on a Mac)
brew reinstall kubeseal

# Verify Sealed Secrets controller service is running
# kubectl get svc -n kube-system

# And you are able to see the cert 
# kubeseal --fetch-cert --controller-name sealedsecrets-release-sealed-secrets --controller-namespace kube-system

# Create a Kubernetes secret for external-dns AWS credentials and output it as a YAML file
kubectl create secret generic external-dns-aws-credentials \
--from-literal=aws-access-key-id=$AWS_ACCESS_KEY_ID \
--from-literal=aws-secret-access-key=$AWS_SECRET_ACCESS_KEY \
-n kube-system --dry-run=client -o yaml > secret.yaml

# Seal the secret using the Sealed Secrets controller
kubeseal --controller-name sealedsecrets-release-sealed-secrets \
    --controller-namespace kube-system --format yaml < secret.yaml > sealed-secret-extdns.yaml

# Apply the sealed secret to the cluster
kubectl apply -f sealed-secret-extdns.yaml

# Apply rest of the manifests 
kubectl apply -f k8s/
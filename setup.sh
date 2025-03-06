#!/bin/bash

# Clone the repository
echo "Cloning GitHub Profiles Automator repository..."
git clone https://github.com/shahad-fh/kubeflow-profiles.git
cd kubeflow-profiles

# Create profiles.yaml if it does not exist
if [ ! -f "profiles.yaml" ]; then
  echo "Creating profiles.yaml file..."
  cat <<EOL > profiles.yaml
profiles:
- name: group1
  owner:
    kind: user
    name: group1@test.com
  resources:
    hard:
      limits.cpu: "1"
  contributors:
  - name: shahad@test.com
    role: admin
  - name: amjad@test.com
    role: edit
  - name: ahmed@canonical.com
    role: view
- name: group2
  owner:
    kind: user
    name: group1@test.com
  contributors:
  - name: noor@test.com
    role: edit
  - name: shahd@canonical.com
    role: view
EOL
fi

# Deploy the GitHub Profiles Automator using Juju
echo "Deploying GitHub Profiles Automator..."
juju deploy github-profiles-automator

# Configure the repository URL and YAML path
echo "Configuring Juju settings..."
juju config github-profiles-automator repository="https://github.com/shahad-fh/kubeflow-profiles.git"
juju config github-profiles-automator pmr-yaml-path="profiles.yaml"

# Check status
echo "Checking Juju status..."
juju status

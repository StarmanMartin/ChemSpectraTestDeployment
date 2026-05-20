#!/bin/bash

echo "Make sure docker and curl is installed"
# Prompt the user for each environment variable, with default values


echo "create shared folder"

mkdir shared
mkdir shared/logs
mkdir shared/pullin
mkdir shared/pullin/instance

echo "setting .env"

curl -O https://raw.githubusercontent.com/StarmanMartin/ChemSpectraTestDeployment/main/.env.example
mv .env.example .env

echo "Downloading missing files!"

curl -O https://raw.githubusercontent.com/StarmanMartin/ChemSpectraTestDeployment/main/docker-compose.yml
cd shared/pullin/instance
curl -O https://raw.githubusercontent.com/StarmanMartin/ChemSpectraTestDeployment/main/shared/pullin/instance/config.py

cd ../..

curl -O https://raw.githubusercontent.com/StarmanMartin/ChemSpectraTestDeployment/main/shared/APP_BRANCH.txt

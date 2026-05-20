# ChemSpectraTestDeployment

Docker container factory for test deployments of ChemSpectra

**⚠️ Disclaimer**

**This setup is for testing purposes only and should not be used in production.
Please shut down the container after you're done!**

## 🚀 What is this?

This repository provides a Dockerfile to build a Docker image
that allows you to quickly and easily deploy ChemSpectra in a test environment.
The content is automatically updated after each new commit on the selected
branches.

-> __No webhooks are needed!__ It is easy to set up and you do not require any privileges.

The prebuilt image is available on Docker Hub:
```mstarman/chem-converter-test:0.0.2```

The included docker-compose.yml file demonstrates how to use the image.

## 🛠️ Getting Started

We provide an installation script that has only been tested on Ubuntu. However, you can also set it up manually in just a few steps

### In Chemotion

To include it into a Chemotion instance the Spectra container exposes PROT 4001.

### Ubuntu install script

Run:

```shell
curl -H 'Cache-Control: no-cache' -O https://raw.githubusercontent.com/StarmanMartin/ChemSpectraTestDeployment/main/setup.sh
chmod +x setup.sh
./setup.sh
```

### By Hand

1. Environment Variables

   * Copy the .env.sample file from this Repo to .env.

   * Make sure to review and update all environment variables, especially CONVERTER_URL and PROJECT_WEB_PORT.

2. Converter shared Folder Setup

   * Create a *shared* directory in the same location as your ```docker-compose.yml```.

   * This directory must contain the following subdirectories (you can also clone them from this repo):

   * Make a text file in the *shared* directory: ```APP_BRANCH.txt```.

   * Make sure you have the ```pullin/instance/config.py`` from this repo 

```
shared/
   ├── logs/
   ├── pullin/
         └── instance
               └── config.py
   └── APP_BRANCH.txt

```

Description of each folder:

* ```APP_BRANCH.txt```: The GIT repo branch for the app. This branch is monitored and if there is a new commit, the server is automatically updated.
* ```pullin/```: Config files to overwrite existing default config in container 

## Switching Branches

To change the deployed Converter branch, modify the first line in the **APP_BRANCH.txt**.
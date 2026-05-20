#!/bin/bash

echo $$ > $PIDFILE

clone_repo () {
  LOCALREPO_VC_DIR=$3/.git
  if [ -d "$LOCALREPO_VC_DIR" ]
  then
    cd "$3"
    cd ..
    rm -r "$3"
    mkdir "$3"
  fi
  git clone -b $2 "$1" "$3"
}

REPO=https://github.com/ComPlat/chem-spectra-app
LOCALREPO=/srv/spectra/app
APP_BRANCH=${APP_BRANCH:-main}

echo "|================================================================================|"
echo "|  Cloning ChemSpectra Branch: ${APP_BRANCH}  "
echo "|================================================================================|"

clone_repo $REPO ${APP_BRANCH} $LOCALREPO

echo "|================================================================================|"
echo "|  Setting environment  "
echo "|================================================================================|"

cp -r /var/share/config/* /srv/spectra/app/
service nginx start

echo "|================================================================================|"
echo "|  Installing dependencies "
echo "|================================================================================|"

cd $LOCALREPO
pip install ".[dev]"

echo "|================================================================================|"
echo "|  Running server "
echo "|================================================================================|"

# tail -f /dev/null
gunicorn -w 4 -b 0.0.0.0:4001 server:app &

# Save PID (optional, if you want to track)
echo "Script PID: $$"
echo "Gunicorn PID: $!"

wait

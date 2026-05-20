#!/bin/bash


REPO="ComPlat/chem-spectra-app"

INTERVAL=${UPDATE_INTERVAL:-600}            # Seconds between checks

echo "" > app_last_commit.txt
echo "" > $PIDFILE

while true; do
    source ./set_git_branch.sh
    app_new_commit=$(git ls-remote https://github.com/$REPO.git refs/heads/$APP_BRANCH)
    PID=$(cat $PIDFILE)
    if ! ps -p $PID > /dev/null || [[ "$app_new_commit" != $(cat app_last_commit.txt) ]]; then
        echo "[$(date)] New commit detected: APP: $app_new_commit"

        echo "$app_new_commit" > app_last_commit.txt

        kill -TERM -$PID
        setsid ./run.sh &
    fi
    sleep $INTERVAL
done




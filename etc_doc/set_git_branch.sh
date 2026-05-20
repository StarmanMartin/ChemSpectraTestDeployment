app_branch_file="/var/share/APP_BRANCH.txt"

if [ -f "$app_branch_file" ]; then
  APP_BRANCH=$(head -n 1 "$app_branch_file" | tr -d '[:space:]')
else
  echo "master" > "$app_branch_file"
  APP_BRANCH="master"
fi

export APP_BRANCH=${APP_BRANCH:-"dev"}
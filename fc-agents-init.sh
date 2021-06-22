#!/usr/bin/env bash

# 1. starts each agent in a country every 10secs
# 2. commits and dispatches all data to FC_GIT_REPO_DATA

set -o errexit

echo "Once upon a time..."

# data local dir and repo
data_dir="data"
mkdir -p "${data_dir}"
data_repo=https://${FC_GIT_PASSWORD}@${FC_GIT_HOST}/${FC_GIT_REPO_DATA}.git
git clone "${data_repo}" "${data_dir}"

# list agents found on country app
agents=$(fc-agent list "$@")
IFS=',' read -r -a agents_list <<< "$agents"
for agent in "${agents_list[@]}"; do
  echo "fc-agent scrape -a ${agent}"
  mkdir -p "${data_dir}/${agent}"
  # spawn a new agent every 10secs
  fc-agent scrape -a "${agent}" > "${data_dir}/${agent}/data.json" &
  sleep 10
done

wait

{
  today=$(date -u +"%Y-%m-%d")
  data_dir="data"

  cd "${data_dir}" || exit;

  # git credentials are env secrets on docker run
  git config user.email "${FC_GIT_USER_EMAIL}"
  git config user.name "${FC_GIT_USER}"

  git add .
  git commit -m "Daily dispatch: ${today}"
  git push
}

wait

echo "The End."


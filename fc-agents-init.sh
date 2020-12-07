#!/usr/bin/env bash

# Bootstrap script for a set of country agents

echo "Once upon a time..."

# Read .env vars
set -o allexport
source .env
set +o allexport


data_dir="data"
mkdir -p "${data_dir}"

# list agents found on country app
agents=$(fc-agent list "$@")
IFS=',' read -r -a agents_list <<< "$agents"
for agent in "${agents_list[@]}"; do
  echo "fc-agent scrape -a ${agent}"
  # spawn a new agent every 10secs
  fc-agent scrape -a "${agent}" > "${data_dir}/${agent}.json" &
  sleep 10
done

wait

{
  today=$(date -u +"%Y-%m-%d")
  data_dir="data"

  cd "${data_dir}" || exit;
  git init
  # git credentials are env secrets on docker run
  git config user.email "${FC_GIT_USER_EMAIL}"
  git config user.name "${FC_GIT_HOST_USER}"
  git checkout -b main
  git add .
  git commit -m "Daily dispatch: ${today}"
  git push --set-upstream "${FC_GIT_HOST_DATA_REPO}" main
}

echo "The End."

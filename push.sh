function error_param {
  echo "Error: '$2' required as the param number $1"
}

step_name="${1:?$(error_param 1 'Step Name')}"

function commit {
  git add .
  git commit -m "$(date)"
  git push
}

function wait {
  sleep_duration=${1:?$(error_param 1 'Sleep Duration')}

  echo "Sleeping for ${sleep_duration} seconds…"
  sleep $sleep_duration
}

function get_run_id {
  gh run list --limit 1 --json 'databaseId' -q '.[0].databaseId'
}


function log {
  title=${1:?$(error_param 1 'Title')}
  value=${2:?$(error_param 2 'Value')}

  echo "${title}: ${value}"
}

function gh_watch {
  gh run watch  "${run_id}"
}

function get_job_id {
  run_id=${1:?$(error_param 1 'Run ID')}

  gh run view "${run_id}" --log --json 'jobs' -q '.jobs[].databaseId'
}

function get_log {
  job_id="${1:?$(error_param 1 'Job ID')}"
  step_name="${2:?$(error_param 2 'Github Step Name')}"

  echo "Showing trimmed logs for '$step_name'…"
  gh run view --job "${job_id}" --log | \
    grep "${step_name}" | \
    awk '{for(i=1; i < 4; i++) $i=""; sub(/\s{2,}/, ""); print}'
}

commit
wait 20

run_id="$(get_run_id)"
log 'Run ID' $run_id

gh_watch

job_id="$(get_job_id $run_id)"
log 'Job ID' "${job_id}"

get_log $job_id "${step_name}"

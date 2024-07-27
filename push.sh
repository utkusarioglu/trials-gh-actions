function commit {
  git add .
  git commit -m "$(date)"
  git push
}

function wait {
  sleep_duration=${1:?'First param needs to be the sleep duration'}

  echo "Sleeping for ${sleep_duration}…"
  sleep $sleep_duration
}

function get_run_id {
  gh run list --limit 1 --json databaseId -q ".[0].databaseId"
}


function log {
  title=${1:?'First param needs to be the title'}
  value=${2:?'Second param needs to be the value'}

  echo "${title}: ${run_id}"
}

function gh_watch {
  gh run watch  "${run_id}"
}

function get_job_id {
  gh run view "${run_id}" --log --json "jobs" | jq -r '.jobs[].databaseId'
}

function get_log {
  job_id="${1:?'First param needs to be the job id'}"

  gh run view --job "${job_id}" --log | \
    grep 'Run Query' | \
    awk '{$1=""; $2=""; $3=""; $4=""; sub("  ", ""); print}'
}

commit
wait 15

run_id=$(get_run_id)
log 'Run ID' $run_id

gh_watch

job_id=$(get_job_id)
log 'Job ID' $job_id

get_log $job_id

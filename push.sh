git add . & git commit -m "$(date)" && git push

echo 'Sleeping for 10'
sleep 10

run_id="$(gh run list --limit 1 --json databaseId -q ".[0].databaseId")"
echo "run id: ${run_id}"

gh run watch  "${run_id}"

job_id=$(gh run view "${run_id}" --log --json "jobs" | jq -r '.jobs[].databaseId')
echo "job id: ${job_id}"

gh run view --job "${job_id}" --log | grep 'Run Query'

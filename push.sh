git add . & git commit -m "$(date)" && git push

echo 'Sleeping for 10'
sleep 10

run_id="$(gh run list --limit 1 --json databaseId -q ".[0].databaseId")"
echo "run id: ${run_id}"

gh run watch  "${run_id}"

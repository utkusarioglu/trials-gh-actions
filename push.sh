git add . & git commit -m "$(date)" && git push

echo 'Sleeping for 10'
sleep 10

gh run watch 

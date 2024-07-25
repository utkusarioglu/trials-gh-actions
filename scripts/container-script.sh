echo cats > $GITHUB_WORKSPACE/file3
release_info="$(cat /etc/os-release)"
echo "${release_info}" >> $GITHUB_OUTPUT

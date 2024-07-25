echo cats > $GITHUB_WORKSPACE/file3
files="$(cat /etc/os-release)"
echo something="${files}" >> $GITHUB_OUTPUT

echo cats > $GITHUB_WORKSPACE/file3
files="$(ls -al)"
echo something="${files}" >> $GITHUB_OUTPUT

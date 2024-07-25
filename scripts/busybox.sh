command="${1:?First param needs to be the commmand}"
echo "Running ${command}"
command_output="$($command | base64)"
echo "Command output: $command_output"
echo "command_output='${command_output}'" >> $GITHUB_OUTPUT

echo "Creating secondary_output"
echo "secondary_output=hello" >> $GITHUB_OUTPUT

echo "Creating local files"
echo 'hi' > ${GITHUB_WORKSPACE}/file1
echo 'hello1' > ${GITHUB_WORKSPACE}/file2

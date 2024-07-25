# command="${1:?First param needs to be the commmand}"
command="wget -O - https://www.google.com"
echo "Running ${command}"
command_output="$(sh -c \"$command\")"
echo "command_output='${command_output}'" >> $GITHUB_OUTPUT

echo "Creating secondary_output"
echo "secondary_output=hello" >> $GITHUB_OUTPUT

echo cats > ${GITHUB_WORKSPACE}/file3
wget -O ${GITHUB_WORKSPACE}/file4 https://www.google.com
first_line="$(cat file4 | head -n1)"
release_info="$(cat /etc/os-release)"
echo "${release_info}" >> $GITHUB_OUTPUT
echo "my_name=utku" >> $GITHUB_OUTPUT
echo "first_line='${first_line}'" >> $GITHUB_OUTPUT

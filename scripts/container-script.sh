echo cats > ${GITHUB_WORKSPACE}/file3
wget -O ${GITHUB_WORKSPACE}/file4 https://www.google.com
release_info="$(cat /etc/os-release)"
echo "${release_info}" >> $GITHUB_OUTPUT

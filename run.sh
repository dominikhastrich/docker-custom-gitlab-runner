#!/bin/bash
echo ""
echo "set ssh key"
# Write env vars to disc for decoding
echo $CI_SSH > /tmp/CI_SSH
echo $CI_SSH_PUB > /tmp/CI_SSH_PUB
# create ssh dir (if not there)
mkdir -p ~/.ssh
# decode tmp files
base64 --decode /tmp/CI_SSH > ~/.ssh/id_rsa
base64 --decode /tmp/CI_SSH_PUB > ~/.ssh/id_rsa.pub
echo "public key"
cat ~/.ssh/id_rsa.pub
# clean up
rm  /tmp/CI_SSH
rm  /tmp/CI_SSH_PUB

echo ""
echo "configure runner"
# generate configuration file
echo "concurrent = 1\n\n[[runners]]\n  name = \"$CI_NAME\"\n  url = \"$CI_URL\"\n  token = \"$CI_TOKEN\"\n  limit = 1\n  executor = \"shell\"\n" > /etc/gitlab-runner/config.toml
cat /etc/gitlab-runner/config.toml

echo ""
echo "start loop"
while :
do
	# check if gitlab runner is running
	process=`ps -ef | grep "gitlab-ci-multi-runner"`
	if [[ ! -z $process ]]
		then
			echo "GitLab CI runner is on the move"
		else
			echo "GitLab CI runner is lazy, let's get it started ..."
			gitlab-ci-multi-runner run
	fi
	
	sleep 30
done
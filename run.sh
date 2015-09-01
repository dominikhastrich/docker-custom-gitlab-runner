#!/bin/bash
echo ""
echo "Welcome to Cround services :D"
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
echo ""
echo "configure runner"
# generate configuration file
echo -e "concurrent = 1\n\n[[runners]]\n  name = \"$CI_NAME\"\n  url = \"$CI_URL\"\n  token = \"$CI_TOKEN\"\n  limit = 1\n  executor = \"shell\"\n" > /etc/gitlab-runner/config.toml
cat /etc/gitlab-runner/config.toml

echo ""
echo "Firing up GitLab CI runner"
gitlab-ci-multi-runner run


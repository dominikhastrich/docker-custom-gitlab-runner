# initiate ssh key
openssl enc -base64 -d <<< $CI_SSH > ~/.ssh/id_rsa
openssl enc -base64 -d <<< $CI_SSH_PUB > ~/.ssh/id_rsa.pub

# generate configuration of GitLab CI runner 
RUN echo -e "concurrent = 1\n\n[[runners]]\n  name = \"$CI_NAME\"\n  url = \"$CI_URL\"\n  token = \"$CI_TOKEN\"\n  limit = 1\n  exectuor = \"shell\"" > /config.toml

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
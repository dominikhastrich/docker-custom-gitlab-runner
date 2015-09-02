# docker-custom-gitlab-runner

Java 8 container with a GitLab CI runner and Gradle to deploy new versions on-the-fly.

The GitLab CI runner has to be configured via the environment variables:

- `CI_NAME` name of the runner
- `CI_URL` URL of the GitLab CI instance
- `CI_TOKEN` token to identify the project
- `CI_SSH` ssh key to identify the runner (base64 encoded)
- `CI_SSH_PUB` public ssh key to identify the runner (base64 encoded)

Exposes ports 80, 8080, 443, 8443, 10080 and 1111

To start the deployed application, a `start.sh` needs to be put under `/data/services` by the CI script.

## Troubleshooting

### Gradle not found

If the CI script can not find Gradle you can use `$GRADLE_HOME/bin/gradle`.
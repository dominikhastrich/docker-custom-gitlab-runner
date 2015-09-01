# docker-custom-gitlab-runner

Java 8 container with a GitLab CI runner and Gradle to deploy new versions on-the-fly.

The GitLab CI runner has to be configured via the environment variables:

- `CI_NAME` name of the runner
- `CI_URL` URL of the GitLab CI instance
- `CI_TOKEN` token to identify the project
- `CI_SSH` ssh key to identify the runner (base64 encoded)
- `CI_SSH_PUB` public ssh key to identify the runner (base64 encoded)

Exposes ports 80, 8080, 443, 8443, 10080 and 1111

The runner will work in `/output` which is shared as a volume.

To work with the build the build script has to execute scripts which are part of the repository itself.

A run script makes sure that a single runner is always available.

## Troubleshooting

### Gradle not found

If the CI script can not find Gradle you can use `$GRADLE_HOME/bin/gradle`.
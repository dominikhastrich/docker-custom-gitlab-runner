FROM java:8-jdk

VOLUME /output

ADD ./run.sh /run.sh

EXPOSE 80, 443

# Gradle
WORKDIR /usr/bin
RUN wget https://services.gradle.org/distributions/gradle-2.6-all.zip
RUN unzip gradle-2.6-all.zip
RUN ln -s gradle-2.6 gradle && rm gradle-2.6-all.zip
ENV GRADLE_HOME=/usr/bin/gradle
ENV PATH=$PATH:$GRADLE_HOME/bin

# GitLab CI Runner
RUN wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64
RUN chmod +x /usr/local/bin/gitlab-ci-multi-runner
RUN gitlab-ci-multi-runner install --user=root --working-directory=/output

CMD ["sh","/run.sh"]

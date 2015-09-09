FROM java:8-jdk

VOLUME /data/services

ADD ./run.sh /run.sh

# Gradle
WORKDIR /usr/bin
RUN wget https://services.gradle.org/distributions/gradle-2.6-all.zip
RUN unzip gradle-2.6-all.zip
RUN ln -s gradle-2.6 gradle && rm gradle-2.6-all.zip
ENV GRADLE_HOME=/usr/bin/gradle
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN chmod 777 $GRADLE_HOME/bin/gradle

# GitLab CI Runner
RUN wget -O /usr/local/bin/gitlab-ci-multi-runner https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-ci-multi-runner-linux-amd64
RUN chmod +x /usr/local/bin/gitlab-ci-multi-runner
RUN gitlab-ci-multi-runner install --user=root --working-directory=/data/services

# install watchman
#RUN apt-get -qq update
#RUN apt-get install -y inotify-tools automake build-essential python-setuptools
#RUN git clone https://github.com/facebook/watchman.git &&\
#	cd watchman &&\
#	git checkout v3.1 &&\
#	./autogen.sh &&\
#	./configure &&\
#	make &&\
#	make install

CMD ["/bin/bash","/run.sh"]

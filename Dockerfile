FROM gradle:jdk10

COPY . /home/gradle/src/java-demo-project
USER root
RUN chown -R gradle:gradle /home/gradle/src

USER gradle
WORKDIR /home/gradle/src/java-demo-project
RUN gradle build \
  && mkdir dist \
  && cd dist \
  && tar -xvf ../build/distributions/java-demo-project.tar

WORKDIR /home/gradle/src/java-demo-project/dist/java-demo-project/bin
CMD ./java-demo-project

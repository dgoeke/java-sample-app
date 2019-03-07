FROM gradle:jdk10

COPY . /home/gradle/src/java-demo-project
USER root
RUN chown -R gradle:gradle /home/gradle/src

USER gradle
WORKDIR /home/gradle/src/java-demo-project
RUN gradle build

USER root
RUN mkdir /app \
  && cd /app \
  && tar -xvf /home/gradle/src/java-demo-project/build/distributions/java-demo-project.tar \
  && useradd --system --no-create-home --home-dir /app appuser \
  && chown -R appuser:appuser /app

USER appuser
WORKDIR /app
CMD ./java-demo-project/bin/java-demo-project

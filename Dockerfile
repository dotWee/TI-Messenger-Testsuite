FROM maven:3.9.6-eclipse-temurin-17

# Create unprivileged user for container execution
RUN groupadd -g 10001 app && useradd -m -u 10001 -g 10001 app \
  && mkdir -p /testsuite /maven/.m2 \
  && chown -R app:app /testsuite /maven

WORKDIR /testsuite

ENV MAVEN_REPO=/maven/.m2 \
    MAVEN_BATCH=true \
    MAVEN_PROFILE=cluster

COPY --chown=app:app . /testsuite
COPY --chown=app:app entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/entrypoint.sh

USER app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

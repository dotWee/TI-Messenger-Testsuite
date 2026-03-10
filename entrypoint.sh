#!/bin/sh
set -eu

if [ "$#" -gt 0 ]; then
  exec "$@"
fi

: "${MAVEN_GOAL:=verify}"
: "${MAVEN_PROFILE:=cluster}"
: "${MAVEN_ARGS:=}"
: "${MAVEN_POM:=pom.xml}"
: "${MAVEN_REPO:=/maven/.m2}"
: "${MAVEN_BATCH:=true}"

profile_arg=""
if [ -n "$MAVEN_PROFILE" ]; then
  profile_arg="-P${MAVEN_PROFILE}"
fi

batch_arg=""
if [ "$MAVEN_BATCH" = "true" ]; then
  batch_arg="-B"
fi

exec mvn $batch_arg -ntp -Dmaven.repo.local="$MAVEN_REPO" -f "$MAVEN_POM" $profile_arg $MAVEN_ARGS "$MAVEN_GOAL"

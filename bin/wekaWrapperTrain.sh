#!/bin/bash

ROOTDIR="$1"
shift
arff="$1"
shift
model="$1"
shift
class="$1"
shift

if [ "$class" == "" ]
then
  echo 1>&2 'wekaWrapperTrain.sh: not enough parameters!'
  echo 1>&2 ROOTDIR=$ROOTDIR arff=$arff model=$model class=$class
  exit -1
fi


pushd "$ROOTDIR" >/dev/null
## NOTE: it is not trivial to make absolutely sure that there is no output from maven to 
## standard output (which is required here!)
## The -q parameter is supposed to work, but there have been reports that sometimes it still lets through INFO messages.
## An alternate approach is to set the log level via MAVEN_OPTS, so we do both
## export MAVEN_OPTS=-Dorg.slf4j.simpleLogger.defaultLogLevel=error
## mvn -q  exec:java -Dexec.mainClass="gate.lib.wekawrapper.WekaTraining" -Dexec.args="${arff} ${model} ${class} $*"
echo 1>&2 RUNNING java -cp "$ROOTDIR/target/*":"$ROOTDIR/target/dependency/*" gate.lib.wekawrapper.WekaTraining "${arff}" "${model}" "${class}" $*
java -cp "$ROOTDIR/target/*":"$ROOTDIR/target/dependency/*" gate.lib.wekawrapper.WekaTraining "${arff}" "${model}" "${class}" $*
popd >/dev/null

#!/bin/bash

[ -e /etc/sysconfig/mvsg ] && . /etc/sysconfig/mvsg

RANDOM_SLEEP=${RANDOM_SLEEP:-"0"}
OMIT_JVM_STATS=${OMIT_JVM_STATS:-"false"}

SCRIPT=`readlink -f $0`
SCRIPT_PATH=`dirname $SCRIPT`

if [ "xx$PREFIX" = "xx" ]
then
  if [ "xx$ENVIRONMENT" = "xx" ]
    then
    echo ENVIRONMENT must be set
    exit 1
  fi

  if [ "xx$APP_NAME" = "xx" ]
  then
    APP_NAME="solr"
  fi

  if [ "xx$HOSTNAME" = "xx" ]
  then
    HOSTNAME=`hostname`
  fi

  PREFIX="${ENVIRONMENT}.$(echo $HOSTNAME | cut -d'.' -f1).${APP_NAME}"
fi

if [ "xx$SOLR_HOST" = "xx" ]
then
  echo SOLR_HOST must be set
  exit 1
fi

if [ "xx$SOLR_PORT" = "xx" ]
then
  echo SOLR_PORT must be set
  exit 1
fi

if [ "xx$CARBON_HOST" = "xx" ]
then
  echo CARBON_HOST must be set
  exit 1
fi

if [ "xx$CARBON_PORT" = "xx" ]
then
  echo CARBON_PORT must be set
  exit 1
fi

OUTPUT=`python $SCRIPT_PATH/mvsg.py $PREFIX $SOLR_HOST $SOLR_PORT $OMIT_JVM_STATS`

if [ $? = 0 ]
then
  if [ "$RANDOM_SLEEP" -gt "0" ]
  then
    # Sleep for random period of time
    R=$RANDOM
    R=$(( R %= RANDOM_SLEEP ))
    sleep $R
  fi
  echo "${OUTPUT}" | nc -w 20 $CARBON_HOST $CARBON_PORT
fi

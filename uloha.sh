#!/bin/bash
#PBS -N recommender-eval
#PBS -l walltime=4:00:00
#PBS -l nodes=1:ppn=64:nodecpus64#excl
#PBS -l mem=100gb
#PBS -j oe
#  PBS -m e

trap 'clean_scratch' TERM EXIT

DATADIR="/storage/plzen1/home/$LOGNAME/"
SRCJAR="eval.jar"
JVMPAR="-server -Xms100g -Xmx100g -da -dsa -XX:NewRatio=9 -XX:+UseParallelGC -XX:+UseParallelOldGC"
PARAM="-f 50 -m -t -w -p"
RES="res"

module add jdk-7

cp $DATADIR/$SRCJAR $SCRATCHDIR || exit 1
cd $SCRATCHDIR || exit 2

java $JVMPAR -jar $SRCJAR $PARAM

cp -r $RES $DATADIR || export CLEAN_SCRATCH=false

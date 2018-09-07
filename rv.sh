#!/bin/sh

apt install -y automake autoconf make

./autogen.sh
./configure CC=rvpc CXX=rvpc++ LD=rvpld AR_FLAGS="cr"

make

export RVP_ANALYSIS_ARGS="--output=json"
export RVP_REPORT_FILE="$PWD/my_errors.json"
timeout 10m make check V=1

report_path="$PWD/report"
touch $RVP_REPORT_FILE && rv-html-report $RVP_REPORT_FILE -o $report_path

rv-upload-report $report_path

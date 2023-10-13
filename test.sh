#!/bin/bash

PRG_NAME=cat
TESTS_FOLDER=tests/*

RED='\033[0;31m'
GRE='\033[0;32m'
YEL='\033[0;33m'
NC='\033[0m'

passed_count=0
failed_count=0

runtest() {
    echo -e "${YEL}${TEST}${NC}"

    IFS=' '
    ARGS=""
    ARGS_STRING=$(cat $TEST/*.args 2>/dev/null)
    for arg in $ARGS_STRING; do
        ARGS="$ARGS $arg"
    done
    start=$(date +%s%3N)
    cat $TEST/*.input 2>/dev/null | $PRG_NAME $ARGS > $TEST/out.myout 2> $TEST/out.stderr
    retcode=$?
    end=$(date +%s%3N)
    elapsed=$((end-start))

    diff $TEST/out.myout $TEST/out.refout > /dev/null
    retcode_diff=$?

    expected_retcode=$(cat $TEST/*.refrc 2>/dev/null)
    if [ -z "$expected_retcode" ]; then
        expected_retcode="0"
    fi

    if [ $retcode_diff -eq 0 ] && [ $retcode -eq $expected_retcode ];then
        echo -e "- ${GRE}TEST PASSED${NC}                 [${elapsed}ms]"
        ((passed_count+=1))
    else
        echo -e "- ${RED}TEST FAILED${NC}                 [${elapsed}ms]"
        if [ $retcode != $expected_retcode ]; then
            echo -e "Return code: $retcode (expected: $expected_retcode)"
        fi

        if [ $retcode_diff != 0 ]; then
            echo -e;echo -e "------------------ Expected ------------------"
            cat $TEST/out.refout
            echo -e; echo -e "---------------- END Expected ----------------"
            echo -e

            echo -e "------------------- Actual -------------------"
            cat $TEST/out.myout
            echo -e;echo -e "----------------- END Actual -----------------"
        fi;
        ((failed_count+=1))
    fi
}

for TEST in $TESTS_FOLDER; do 
    runtest
done

echo -e;echo -e "$(tput bold) PASSED: $passed_count; FAILED: $failed_count"
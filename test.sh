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
    ARGS_STRING=$(<$TEST/*.args)
    for arg in $ARGS_STRING; do
        ARGS="$ARGS $arg"
    done

    $PRG_NAME $ARGS > $TEST/out.myout 2> $TEST/out.stderr < $TEST/*.input
    retcode=$?

    diff $TEST/out.myout $TEST/out.refout > /dev/null
    retcode_diff=$?

    if [ $retcode_diff -eq 0 ] && [ $retcode -eq 0 ];then
        echo -e "- ${GRE}TEST PASSED${NC}"
        ((passed_count+=1))
    else
        echo -e "- ${RED}TEST FAILED${NC}"

        echo -e "- Return code: $retcode"
        echo -e;echo -e "- Expected:"
        echo -e "\""
        cat $TEST/out.refout
        echo -e "\""
        echo -e

        echo -e "- Actual:"
        echo -e "\""
        cat $TEST/out.myout
        echo "\""
        ((failed_count+=1))
    fi
}

for TEST in $TESTS_FOLDER; do 
    runtest
done

echo -e "Passed: $passed_count; Failed: $failed_count"
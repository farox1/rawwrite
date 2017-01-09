#!/bin/bash
# QUEUE=windows:lazarus

set -e -u -o pipefail

set -x

. $(dirname $0)/../.buildkite/env.sh

if [ "$1" == "test" ] ; then
	shift
fi

TARGET=$1
BITS=$2

FILE=dd${TARGET}${BITS}.exe
get_artifact $FILE

echo "This is a test" | ./$FILE

#next_step test $TARGET ${BITS}
if [ "$TARGET" = "debug" ] ; then
	next_step build release ${BITS}
else
	next_step package "$TARGET" ${BITS}
fi


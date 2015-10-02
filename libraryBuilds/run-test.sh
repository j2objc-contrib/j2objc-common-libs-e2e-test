#!/bin/bash
#
# Copyright (c) 2015 the authors of j2objc-common-libs-e2e-test
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Fail if anything fails.
set -ev

TEST_DIR=$1
pushd $TEST_DIR

echo Preparing test $TEST_DIR

# Execute the prep.sh files within this project, if any.
# These are often used to retrieve test sources for the libraries.
# -L follows symbolic links correctly.
find -L . -name prep.sh | while read PREP_SCRIPT_FILE
do
    pushd `dirname $PREP_SCRIPT_FILE`
    sh prep.sh
    popd
done

echo Running test $TEST_DIR
./gradlew wrapper
./gradlew clean
./gradlew build --stacktrace
popd

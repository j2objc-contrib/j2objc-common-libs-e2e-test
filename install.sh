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

# Must be run from the root directory

# Fail if anything fails
set -euv

export TERM=dumb
env
xcrun clang -v

/usr/libexec/java_home -v 1.7 -F -V
java -Xmx32m -version && javac -J-Xmx32m -version

# In this repo, building of the j2objc-gradle plugin is just preperation.
pushd j2objc-gradle
./gradlew wrapper
./gradlew dependencies
./gradlew build
popd

# Download and configures j2objc distribution.
./install-j2objc.sh

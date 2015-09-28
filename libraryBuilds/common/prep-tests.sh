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

set -v
rm -rf test-repo
rm -rf src/test
rm -rf src

set -ev
TAG=$1
REPO=$2
TEST_DIR_IN_REPO=$3
git clone --depth 1 --branch $TAG $REPO test-repo
mkdir src
cp -R test-repo/$TEST_DIR_IN_REPO src/test

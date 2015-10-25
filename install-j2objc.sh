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

pushd libraryBuilds

# Specific version can be configured from command line:
# export J2OBJC_VERSION=X.Y.Z
# Default is version number listed on following line:
J2OBJC_VERSION=${J2OBJC_VERSION:=0.9.8.2.1}

# -p flag avoid failure when directory already exists
mkdir -p localJ2objcDist
mkdir -p common

pushd localJ2objcDist

DIST_DIR=j2objc-$J2OBJC_VERSION
DIST_FILE=$DIST_DIR.zip

# For developer local testing, don't keep redownloading the zip file.
if [ ! -e $DIST_FILE ]; then
  curl -L https://github.com/google/j2objc/releases/download/$J2OBJC_VERSION/j2objc-$J2OBJC_VERSION.zip > $DIST_FILE
  unzip $DIST_FILE
  echo j2objc.home=$PWD/$DIST_DIR > ../common/local.properties
  echo "libraryBuild/common/local.properties configured:"
  cat ../common/local.properties
fi

# pop localJ2objcDist
popd

# pop libraryBuilds
popd

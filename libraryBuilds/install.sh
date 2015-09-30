export TERM=dumb
env
xcrun clang -v

/usr/libexec/java_home -v 1.7 -F -V
java -Xmx32m -version && javac -J-Xmx32m -version

# In this repo, building of the j2objc-gradle plugin is just preperation.
popd
pushd j2objc-gradle
./gradlew wrapper
./gradlew dependencies
./gradlew build
popd
pushd libraryBuilds

# Download and configures j2objc distribution.
./install-j2objc.sh

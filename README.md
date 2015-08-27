# j2objc-common-libs-e2e-test
End-to-end tests for translating, compiling, and linking common Java libraries into Objective C
using [J2ObjC](http://j2objc.org) and the [J2ObjC Gradle Plugin](https://github.com/j2objc-gradle).

This is a subproject of [j2objc-gradle](https://github.com/j2objc-gradle)
and [maintained by some of the same people](NOTICE). Like j2objc-gradle, this project is not affiliated
with Google.

**Goals**
- Continuously verify that common open-source Java libraries can be translated and built correctly.
- Provide a broader base of regression tests for both the J2ObjC and j2objc-gradle projects.

**Non-goals**
- Distribute pre-built Objective C versions of those libraries.

For all support, questions, etc., please report issues directly to the j2objc-gradle
and/or j2objc projects.

**Licensing**

This test suite is distributed under the Apache 2.0 license found in the [LICENSE](LICENSE) file.
(Note: J2ObjC and the Java libraries that are downloaded and run through J2ObjC are distributed
under their own licenses.)

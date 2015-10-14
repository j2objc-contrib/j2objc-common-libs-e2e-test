Please keep in mind that your "Contribution(s)" are submitted under
the [Apache 2.0 License](LICENSE).

### Team workflow

1.  An issue is created describing the change required.
Feature requests should be labeled 'enhancement' while bugs should be labeled 'bug'.
Issues are optional for trivial fixes like typos.
2.  An issue is assigned to the developer working on it.  If the developer is
not assignable due to GitHub.com permissions, add the label 'public-dev-assigned'.
3.  The issue assignee creates a pull request (PR) with their commits.
PRs are never optional, even for trivial fixes.
4.  The PR is assigned to one of the project committers and code review/fixes ensue.
The PR assignee's LGTM is sufficient and neccessary to merge the PR, however additional
code review from anyone is welcome.  The PR author should keep the PR in a state fit for submission
(see [preparing-your-pull-request-for-submission](#preparing-your-pull-request-for-submission))
through out this process.  The PR assignee will also need you to follow the instructions in
[Conditions for accepting pull requests](#conditions-for-accepting-pull-requests).
5.  After LGTM from the PR assignee, a project committer merges the PR into master.
If the PR author is a committer, they can merge the PR themselves as long as they
have an LGTM from the PR assignee (which should be a different committer).


### Quick start

1. Fork it clicking on the top right "Fork" button
2. Create your feature branch<br>
`git checkout -b my-new-feature`
3. Commit your changes<br>
`git commit -am 'Add some feature'`
4. Push to the branch<br>
`git push origin my-new-feature`
5. Create a new Pull Request and send it for review
6. After the PR has been approved and is ready to submit see
[preparing-your-pull-request-for-submission](#preparing-your-pull-request-for-submission).


### Conditions for accepting pull requests
Please confirm that you can certify the following, 
then add the certification at the end of every commit message (with two newlines between
the main content of your commit message and the notice), entering your own information
and removing the &lt;angled brackets&gt;. If you can't certify the following, please
do not submit a pull request.

```
I, <full name> (<email@example.com>, https://github.com/<github username>), certify that
a) this Contribution is my original work, and
b) I have the right to submit this Contribution under the Apache License,
   Version 2.0 (the "License") available at
   http://www.apache.org/licenses/LICENSE-2.0, and
c) I am submitting this Contribution under the License.
```

Note: This is not legal advice.  Contributors, users, etc. must ensure their own level of comfort with
contributions certified as described here, and should seek their own legal counsel as needed.

Your Contribution (including the certification notice and other commit metadata)
will be stored publicly within the history of the repository,
and may be redistributed per the License.

_If this is your first commit_, and you are not already mentioned in the NOTICE file,
please add your name, GitHub username, and email, to the end of the
'Thanks:' list, formatted just like the entries already there:

```
  First Last @gitHubUserName <email@example.com>
```

This addition to the NOTICE file should be a part of that first commit.

### Updating j2objc-gradle
The version of j2objc-gradle in this repo is not automatically kept up
to date with HEAD of https://github.com/j2objc-contrib/j2objc-gradle.

As a submodule, you can update j2objc-gradle by doing:

```shell
# (start with a clean git working directory)
# (from your local repo for this project)
git checkout -b update-plugin
pushd j2objc-gradle
git pull
popd
git add .
git commit -m 'Updating j2objc-gradle to HEAD'
# (submit the update-plugin branch as a PR to the repo)
```

Make sure this PR is seperate from any other work.  If a library you want
to build depends on the update, work in a new branch parented to the commit
above.

TODO: [Automate this](https://github.com/j2objc-contrib/j2objc-common-libs-e2e-test/issues/33)

### Library build verification

On OS X we have system tests under the `libraryBuilds` directory.  Each test directory
has one root Gradle project (and zero or more subprojects), some or all of which apply the
`j2objc-gradle` plugin.  Locally you can run them as follows:

```sh
pushd libraryBuilds
./prep.sh
./run-all.sh
# Normal Gradle build results will be displayed for each test project.
popd
```

These system tests are also run as part of OS X continuous integration builds on Travis.
You are not required to run the system tests locally before creating a PR (they can take
time and processing power), however if the tests fail on Travis you will need to update
the PR until they pass.

### Adding a new library

When you add a new library to build, make sure it is referenced in run-all.sh (for
human contributors) and in .travis.yml (for continuous builds). If your library has failures
add the env row to the allow_failures section of .travis.yml and document the blockers.

The structure for each library to test is as follows:

```
libraryBuilds/
    - common/                   - Existing directory with common build config
    - dependencyLib1/           - Existing root of a library that newLibrary depends on
        - dependencyLib1/       - Existing project for a library that newLibrary depends on
    - dependencyLib2/           - Ditto.
        - dependencyLib2/       - Ditto.
    - newLibrary/               - New directory for the root project
        - newLibrary/           - New directory for the library itself
            - build.gradle      - Build file containing j2objcTranslation directive for newLibrary
        - dependencyLib1/       - Soft link to ../dependencyLib1/dependencyLib1/
        - dependencyLib2/       - Soft link to ../dependencyLib2/dependencyLib2/
        - build.gradle          - Soft link to ../common/build.gradle, contains the preamble
        - gradlew               - Soft link to ../../j2objc-gradle/gradlew
        - local.properties      - Soft link to ../common/local.properties
        - settings.gradle       - 'include' directive for newLibrary and libraries it depends on
```

Every library newLibrary depends on must have its own similar structure as a top-level project,
as illustrated by dependencyLib1 and 2. Note the two level directory structure above: even if
your library has no dependencies, the build.gradle file for the library must lie 2 directories
below libraryBuilds1/.


### Preparing your pull request for submission
Say you have a pull request ready for submission into the main repository - it has
been code reviewed and tested.
It's convenient for project committers if you:

1.  Condense branch history to 1 or a few commits that describe what you did.  This
eliminates internal code review fixes from being separate in history,
like refactors, typos, etc.
2.  Resolve merge conflicts with master.  As the author of the PR, you're in the
best position to resolve these correctly.  Even if the merge is a fast-forward,
doing the merge yourself allows you to test your code after incorporating others'
changes.

If you are new to github, here's an example workflow.
We'll assume you are working from your local repository
which is a clone of a fork of j2objc-contrib/j2objc-common-libs-e2e-test, that your feature
branch is called 'patch-1' and that your pull request is number 46.


### Preparation
```sh
# have a clean working directory and index
# from the tip of your patch-1 branch: first save away your work
git branch backup46
```

Don't checkout or touch branch backup46 from here on out.  If things
go terribly wrong below, you can return to a state of LKG sanity with:

1.  `git rebase --abort`
2.  `git merge --abort`
3.  `git checkout patch-1`
4.  `git reset --hard backup46`

This will return your patch-1 branch to the state before merging & rebasing

First ensure you've setup your upstream remote as per 
https://help.github.com/articles/configuring-a-remote-for-a-fork/,
then do https://help.github.com/articles/syncing-a-fork/.
Your local master should now be equal to upstream/master.
Push your local master to your origin remote:
```sh
# While in your local master branch
git push
```


### Rebasing and merging
Now you can work on merging in master to your branch.  We'll assume a simple
branch history here, where patch-1 diverged from master and has never been
merged back in yet.  If you are unfamiliar
with rebasing and merging, first read:
https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history 

The following steps will:

1. Update your repository with changes upstream.
2. Allow you to merge those change in to yours.
3. Allow you to squash all your commits into a single well-described commit.

```sh
git checkout patch-1
# condense this down to one commit to preserve proper project history
git rebase -i master
# within the rebase editor, replace the word 'pick' with 'fixup' on
# every line except the very first one.  On the first line, replace
# 'pick' with 'reword'.
# When you exit that editor, you should be given a chance to give
# your entire PR a single detailed commit message.
# resolve and finish the merge as usual.
# The -f forces a push, since you will have rewritten part of your branch's
# history.
git push -f
```

For guidance on doing the merge itself, see
https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging

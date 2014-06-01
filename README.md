# README

"Docket" is an application designed for the assistance of keeping track of exams, assignments, and other events electronically.
It is currently being written and developed.

## Setup

```sh
$ git clone git://github.com/kotct/docket.git # Clones the repository, you can use another URL if you wish.

$ cd docket
$ sudo bundle install # Installs all of the gems

$ rake db:setup # Sets up the database
$ rake db:migrate # Migrates the database to the latest version
```

## Contributing

You are welcome to contribute either ideas, bug/feature notifications, or simply code to the project, by submitting pull requests to [the repository](https://github.com/kotct/docket).
Fork, then commit to your tree, then submit a pull request; you should know the drill.

## Releases

Docket uses a major-minor-patch versioning scheme. Versions are generally notated x.x.x or vx.x.x

* A new MAJOR version indicates a significant event in the project's timeline. For example, the public release of a stable and complete Docket will be version 1.0.0.
* A new MINOR version indicates the completion of some major feature or change. Each minor version has its own milestone which describes the focus and all issues associated with it.
* A new PATCH version indicates a release of some group of minor fixes.

The latest release can always be found on the branch `latest-release` and each release is tagged as `vx.x.x`.

## Branch Scheme

You should use branches for pretty much everything when developing on this project.
Currently, the scheme we use is follows.

* If you need to make a quick fix to a system-crippling bug or other badness, create a branch called `hotfix-short-description-of-problem`, fix the problem on the branch, and merge that branch into `master`. You may then delete the `hotfix-` branch.
* If you need to fix a smaller issue that is not a part of the minor version focus, create a branch called `fix-short-description-of-problem`, fix the problem on the branch, and merge that branch into `master`. You may then delete the `fix-` branch.
* If you are implementing some part of the minor version focus, commits go on the feature branch, which is named according to what the focus of the minor version is. This branch name should be able to be found in the description of the milestone for that minor version. If you are implementing a more complex subfocus, feel free to create a branch with the feature branch as its parent. The feature branch should not be merged into master until its corresponding minor version is released. Feel free to merge master into the feature branch at any time.

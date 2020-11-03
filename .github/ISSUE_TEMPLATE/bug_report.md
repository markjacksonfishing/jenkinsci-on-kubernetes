---
name: Bug Report
about: Create a report to help us improve stellar-core
title: "[Short Description] (Version: [stellar-core version])"
labels: bug
assignees: ''

---

## Read before creating an issue

In general, we close any issues that are
* unactionable (fill the template below under "Description")
* questions best served elsewhere

We have a small community of people that manages issues, and we want to ensure that the issues that remain open are high quality (so we actually get around to implementing them!).

### I'm fairly certain it's a bug.

* Please check existing and closed issues in Github! You may have to remove the `is:open` filter.
* When possible, re-open an old issue if there's been a regression. Be sure to include additional
  details on what was supposed to be working.

## Issue Description

*Describe your bug/feature request in detail.*

## Steps to Reproduce
*List in detail the exact steps to reproduce the unexpected behavior of the software.*

## Expected Result
*Explain in detail what behavior you expected to happen.*

## Actual Result
*Explain in detail what behavior actually happened.*

## Your Environment and Setup

### Version
* If working off of master, please add the git hash of the version you're running using `git rev-parse HEAD`

### Environment
* Operation System & Version (You can usually obtain from `uname -a`)
* Are you running from the command line? From a container?
* Did you pass in special parameters when building the app?
* Please add any additional relevant configuration related to this bug report.

## Supporting Files

If you have any supporting files, please paste them or link to a relevant Github gist or archive link (such as an S3 bucket).

Potential items to attach:
* Configuration files (**DON'T FORGET TO REMOVE SECRETS**)
* Log files - it is best is to have logs running at DEBUG level when reproducing an issue (`-ll
  DEBUG` on the command line).

## Additional context
Add any other context about the problem here.

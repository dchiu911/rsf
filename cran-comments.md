## Resubmission

This is a resubmission. In this version I have:

* Renamed installed file '.gitignore to 'gitignore' so it can be found in examples
* Removed package 'here' from Imports
* Used files from inst/extdata for examples
* Improved documentation for use_rsf()
* Ensured examples are executable by adding conditional checks
* Reset the working directory at the end of examples
* Wrapped 'bookdown' and 'YAML' in Description
* Replaced dontrun{} with donttest{} in examples
* Written to tempdir() in examples

## Test environments
* local OS X install, R 3.5.3
* ubuntu 14.04 (on travis-ci), R 3.5.3
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

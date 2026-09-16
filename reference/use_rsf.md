# Use RSF project template

Create a new Quarto book R project using the RSF template. Intended for
use in RStudio menu, not interactively.

## Usage

``` r
use_rsf(path, ...)
```

## Arguments

- path:

  project path

- ...:

  project configurations supported:

  - initialize git repo via
    [`gert::git_init()`](https://docs.ropensci.org/gert/reference/git_repo.html)

  - initialize renv via
    [`renv::init()`](https://rstudio.github.io/renv/reference/init.html)

## Details

This function is called when the user selects File \> New Project \> New
Directory \> Report of Statistical Findings using Quarto. The directory
name can be specified, and the user can choose to initialize the project
as a git repository and/or use with `renv`.

## Examples

``` r
if (FALSE) { # \dontrun{
# Don't run interactively. Use RStudio Create Project menu.
use_rsf(path = ".")
} # }
```

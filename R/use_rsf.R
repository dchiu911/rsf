#' Use RSF project template
#'
#' Opens a new R project using the RSF template. Intended for use in RStudio,
#' not interactively.
#'
#' This function is called when the user selects File > New Project > New
#' Directory > Report of Statistical Findings using bookdown. The directory name
#' and output directory can be specified.
#'
#' @param path project path
#' @param ... project configurations supported:
#' * `output_dir` in `_bookdown.yml` <https://bookdown.org/yihui/bookdown/configuration.html>
#' * initialize git repo via [gert::git_init()]
#' * initialize renv via [renv::init()]
#' @export
use_rsf <- function(path, ...) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  params <- list(...)
  write_bookdown_yml(path, params$output_dir)
  write_output_yml(path)
  write_index(path)
  write_src(path)
  write_preamble(path)
  write_gitignore(path)
  if (params$git) gert::git_init(path)
  if (params$renv) renv::init(path, restart = FALSE)
}

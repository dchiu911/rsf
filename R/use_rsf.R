#' Use RSF project template
#'
#' Opens a new R project using the RSF template. Intended for use in RStudio,
#' not interactively.
#'
#' This function is called when the user selects File > New Project > New
#' Directory > Report of Statistical Findings using bookdown.
#'
#' @param path project path
#' @param ... additional project parameters
#' @export
#' @examples
#' use_rsf(".")
use_rsf <- function(path, ...) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  params <- list(...)
  write_bookdown_yml(path, params)
  write_output_yml(path)
  write_index(path)
  write_src(path)
  write_preamble(path)
}

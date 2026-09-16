#' Use RSF project template
#'
#' Create a new Quarto book R project using the RSF template. Intended for use
#' in RStudio menu, not interactively.
#'
#' This function is called when the user selects File > New Project > New
#' Directory > Report of Statistical Findings using Quarto. The directory name
#' can be specified, and the user can choose to initialize the project as
#' a git repository and/or use with `renv`.
#'
#' @param path project path
#' @param ... project configurations supported:
#' * initialize git repo via [gert::git_init()]
#' * initialize renv via [renv::init()]
#' @examples
#' \dontrun{
#' # Don't run interactively. Use RStudio Create Project menu.
#' use_rsf(path = ".")
#' }
#' @export
use_rsf <- function(path, ...) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path, "rsf"), recursive = TRUE, showWarnings = FALSE)
  extdata_dir <- system.file("extdata", package = "rsf")
  file.copy(
    from = list.files(
      extdata_dir,
      all.files = TRUE,
      full.names = TRUE,
      recursive = TRUE
    ),
    to = file.path(path, list.files(
      extdata_dir, all.files = TRUE, recursive = TRUE
    ))
  )
  params <- list(...)
  if (params$git) gert::git_init(path)
  if (params$renv) renv::init(path, restart = FALSE)
}

#' Git ignore generated outputs
#'
#' Add generated reports, figures, and HTML libraries to .gitignore
#'
#' @param path path of the directory containing the input files `.gitignore` and
#'   `_bookdown.yml`.
#' @param figs_only logical; if `TRUE` (default), only figures are git ignored.
#' @export
#' @examples
#' \donttest{
#' wd <- tempdir()
#' savedir <- setwd(wd)
#' file.copy(list.files(system.file("extdata", package = "rsf"),
#'                      full.names = TRUE, all.files = TRUE, no.. = TRUE), ".")
#' file.rename("gitignore", ".gitignore")
#' git_ignore_outputs(figs_only = FALSE)
#' setwd(savedir)
#' }
git_ignore_outputs <- function(path = ".", figs_only = TRUE) {
  # Check if input files exist
  git_ignore_path <- file.path(path, ".gitignore")
  bookdown_yml_path <- file.path(path, "_bookdown.yml")
  if (!all(file.exists(c(git_ignore_path, bookdown_yml_path)))) {
    stop("One or more input files are missing.")
  }

  git_ignore <- readLines(git_ignore_path)
  bookdown_yml <- yaml::read_yaml(bookdown_yml_path)
  output_dir <- bookdown_yml[["output_dir"]]
  if (figs_only) {
    output_dir <-
      file.path(output_dir, paste0(bookdown_yml[["book_filename"]], "_files"))
  }
  usethis::write_union(path = git_ignore_path,
                       lines = c(git_ignore, output_dir, "_bookdown_files"))
}

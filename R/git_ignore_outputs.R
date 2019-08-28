#' Git ignore generated outputs
#'
#' Add generated reports, figures, and HTML libraries to .gitignore
#'
#' @param figs_only logical; if `TRUE` (default), only figures are git ignored
#' @export
#' @examples
#' \donttest{
#' wd <- tempdir()
#' savedir <- setwd(wd)
#' git_ignore_outputs(figs_only = FALSE)
#' setwd(savedir)
#' }
git_ignore_outputs <- function(figs_only = TRUE) {
  # Check if input files exist
  if (!all(file.exists(here::here(".gitignore", "_bookdown.yml")))) {
    stop("One or more input files are missing.")
  }

  git_ignore <- readLines(here::here(".gitignore"))
  bookdown_yml <- yaml::read_yaml(here::here("_bookdown.yml"))
  output_dir <- bookdown_yml[["output_dir"]]
  if (figs_only) {
    output_dir <-
      file.path(output_dir, paste0(bookdown_yml[["book_filename"]], "_files"))
  }
  outputs <- c(output_dir, "_bookdown_files")
  if (all(outputs %in% git_ignore)) {
    usethis::ui_done("Outputs already git ignored")
    return(invisible())
  }
  usethis::use_git_ignore(outputs)
}

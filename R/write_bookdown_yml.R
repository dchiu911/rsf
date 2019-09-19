#' Write `_bookdown.yml`
#' @noRd
write_bookdown_yml <- function(path, params) {
  bookdown_yml <- rlang::exec(
    ymlthis::yml_bookdown_opts,
    .yml = ymlthis::yml_empty(),
    book_filename = paste(basename(path), "RSF", sep = "_"),
    before_chapter_script = "src/utils.R",
    rmd_subdir = "src",
    !!!params
  )
  # TODO: quiet arg not passed
  tmp <- capture.output(ymlthis::use_bookdown_yml(bookdown_yml, path, quiet = TRUE))
  # TODO: extra final line return
  tmp_path <- gsub(".*'(.*)'.*", "\\1", tmp)
  writeLines(head(readLines(tmp_path), -1), tmp_path)
}

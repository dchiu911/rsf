#' Write `_output.yml`
#' @noRd
write_output_yml <- function(path) {
  output_yml <- ymlthis::yml_output(
    .yml = ymlthis::yml_empty(),
    bookdown::gitbook(
      lib_dir = "assets",
      split_by = "chapter+number"
    ),
    bookdown::pdf_book(
      keep_tex = TRUE,
      includes = ymlthis::includes2(in_header = "preamble.tex")
    )
  )
  # TODO: quiet arg not passed
  tmp <- utils::capture.output(ymlthis::use_output_yml(output_yml, path, quiet = TRUE))
  # TODO: extra final line return
  tmp_path <- gsub(".*'(.*)'.*", "\\1", tmp)
  writeLines(utils::head(readLines(tmp_path), -1), tmp_path)
}

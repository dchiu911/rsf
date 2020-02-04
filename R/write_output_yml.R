#' Write `_output.yml`
#' @noRd
write_output_yml <- function(path) {
  output_yml <- ymlthis::yml_output(
    .yml = ymlthis::yml_empty(),
    bookdown::gitbook(
      lib_dir = "assets",
      split_by = "chapter",
      config = list(download = "pdf")
    ),
    bookdown::pdf_book(
      keep_tex = TRUE,
      includes = ymlthis::includes2(in_header = "preamble.tex")
    )
  )
  options(ymlthis.remove_blank_line = TRUE)
  ymlthis::use_output_yml(.yml = output_yml, path = path, quiet = TRUE)
  options(ymlthis.remove_blank_line = FALSE)
}

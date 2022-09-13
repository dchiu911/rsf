#' Write `_bookdown.yml`
#' @noRd
write_bookdown_yml <- function(path, output_dir) {
  bookdown_yml <- rlang::exec(
    ymlthis::yml_bookdown_opts,
    .yml = ymlthis::yml_empty(),
    book_filename = paste(basename(path), "RSF", sep = "_"),
    before_chapter_script = "src/utils.R",
    rmd_subdir = "src",
    output_dir = output_dir
  )
  options(ymlthis.remove_blank_line = TRUE)
  ymlthis::use_bookdown_yml(.yml = bookdown_yml, path = path, quiet = TRUE)
  options(ymlthis.remove_blank_line = FALSE)
}

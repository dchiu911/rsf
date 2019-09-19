#' Write `_bookdown.yml`
#' @noRd
write_bookdown_yml <- function(path, params) {
  bookdown_yml <- rlang::exec(
    ymlthis::yml_bookdown_opts,
    .yml = ymlthis::yml_empty(),
    book_filename = paste(basename(path), "RSF", sep = "_"),
    rmd_subdir = "src",
    before_chapter_script = "src/utils.R",
    !!!params
  )
  ymlthis::use_bookdown_yml(bookdown_yml, path)
}

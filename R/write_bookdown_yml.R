# _bookdown.yml
write_bookdown_yml <- function(path, params) {
  bookdown_yml <- c(
    list(
      book_filename = paste(basename(path), "RSF", sep = "_"),
      rmd_subdir = "src",
      before_chapter_script = "src/utils.R"
    ),
    params
  )
  yaml::write_yaml(
    x = bookdown_yml,
    file = file.path(path, "_bookdown.yml")
  )
}

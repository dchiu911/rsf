# _bookdown.yml
write_bookdown_yml <- function(path) {
  bookdown_yml <- list(
    book_filename = paste(basename(path), "RSF", sep = "_"),
    output_dir = "reports",
    rmd_subdir = "src",
    before_chapter_script = "src/utils.R"
  )
  yaml::write_yaml(
    x = bookdown_yml,
    file = file.path(path, "_bookdown.yml")
  )
}

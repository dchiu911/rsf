# src
write_src <- function(path) {
  src_path <- file.path(path, "src")
  dir.create(src_path)
  write_utils(src_path)
  writeLines(text = "# Introduction", con = file.path(src_path, "01-introduction.Rmd"))
  writeLines(text = "# Methods", con = file.path(src_path, "02-methods.Rmd"))
  writeLines(text = "# Results", con = file.path(src_path, "03-results.Rmd"))
}

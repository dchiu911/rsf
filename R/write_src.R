# src
write_src <- function(path) {
  src_path <- file.path(path, "src")
  dir.create(src_path)
  write_utils(src_path)
  write_rmd(src_path, "Introduction", "01-introduction.Rmd")
  write_rmd(src_path, "Methods", "02-methods.Rmd")
  write_rmd(src_path, "Results", "03-results.Rmd")
}

# utils
write_utils <- function(path) {
  chunk_opts <- 'knitr::opts_chunk$set(
  echo = FALSE,
  message = FALSE,
  warning = FALSE,
  results = "asis",
  fig.align = "center"
)'
  writeLines(text = c("# knitr options", chunk_opts),
             con = file.path(path, "utils.R"))
}

# Rmd
write_rmd <- function(path, header, rmd_name) {
  writeLines(text = paste("#", header), con = file.path(path, rmd_name))
}

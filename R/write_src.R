# src
write_src <- function(path) {
  src_path <- file.path(path, "src")
  dir.create(src_path)
  write_utils(src_path)
  write_setup(src_path)
  write_rmd(src_path, "Introduction", 1)
  write_rmd(src_path, "Methods", 2)
  write_rmd(src_path, "Results", 3)
}

# utils
write_utils <- function(path) {
  chunk_opts <- 'knitr::opts_chunk$set(
  echo = FALSE,
  message = FALSE,
  warning = FALSE,
  results = "asis",
  fig.align = "center",
  fig.pos = "H"
)'
  writeLines(text = c("# knitr options", chunk_opts),
             con = file.path(path, "utils.R"))
}

# setup
write_setup <- function(path) {
  writeLines(text = "# Setup script", con = file.path(path, "setup.R"))
}

# Rmd
write_rmd <- function(path, name, number) {
  setup_chunk <- ymlthis::code_chunk(
    chunk_code = source(here::here("src/setup.R"), encoding = "UTF-8"),
    chunk_name = paste0("setup-", sprintf("%02d", number)),
    chunk_args = list(include = FALSE)
  )
  rmd_name <- paste0(sprintf("%02d", number), "-", tolower(name), ".Rmd")
  writeLines(text = paste0("# ", name, "\n\n", setup_chunk),
             con = file.path(path, rmd_name))
}

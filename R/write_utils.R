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

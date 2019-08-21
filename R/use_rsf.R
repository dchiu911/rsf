use_rsf <- function(path, ...) {
  dir.create(path, recursive = TRUE, showWarnings = FALSE)

  dots <- list(...)
  text <- lapply(seq_along(dots), function(i) {
    key <- names(dots)[[i]]
    val <- dots[[i]]
    paste0(key, ": ", val)
  })

  contents <- paste(
    paste(text, collapse = "\n"),
    sep = "\n"
  )

  write_bookdown_yml(path)
  write_output_yml(path)
  write_index(path)
  write_src(path)
  write_preamble(path)
}

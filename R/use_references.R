#' Use references
#'
#' Add a References section at the end of the RSF.
#'
#' @param number number prepended to references Rmd source file.
#' @export
use_references <- function(number = 99) {
  # Create references Rmd source file
  src_path <- here::here("src")
  rmd_name <- paste0(stringr::str_pad(number, 2, pad = 0), "-references.Rmd")
  write_rmd(src_path, "References", rmd_name)

  # Add header and generate packages.bib
  header <- "`r if (knitr::is_html_output()) '# References {-}'`"
  chunk_start <- "\n```{r include=FALSE}"
  pkg_list <- "knitr::write_bib(c(.packages(), 'bookdown'), 'packages.bib')"
  chunk_end <- "```"
  writeLines(
    text = c(header, chunk_start, pkg_list, chunk_end),
    con = file.path(src_path, rmd_name)
  )

  # Call packages.bib from index.Rmd
  index_rmd_curr <- readLines(here::here("index.Rmd"))
  bib_style <- grep("biblio-style", index_rmd_curr)
  index_rmd_new <-
    append(index_rmd_curr, "bibliography: packages.bib", bib_style - 1)
  writeLines(text = index_rmd_new, con = here::here("index.Rmd"))
}

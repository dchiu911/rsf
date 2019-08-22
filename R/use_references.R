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
  index_rmd <- readLines(here::here("index.Rmd"))
  before_style <- grep("biblio-style", index_rmd) - 1
  index_rmd <- append(index_rmd, "bibliography: packages.bib", before_style)
  writeLines(text = index_rmd, con = here::here("index.Rmd"))

  # Add bib options to bookdown::pdf_book output
  output_yml <- yaml::read_yaml(here::here("_output.yml"))
  bib_opts <- list(citation_package = "natbib", toc_bib = TRUE)
  output_yml[["bookdown::pdf_book"]] <-
    c(output_yml[["bookdown::pdf_book"]], bib_opts)
  yaml::write_yaml(x = output_yml, file = here::here("_output.yml"))

  # Rename Bibliography to References in tex
  preamble_tex <- readLines(here::here("preamble.tex"))
  bib_rename <- "\n\\renewcommand{\\bibname}{References}
% https://tex.stackexchange.com/questions/12597/renaming-the-bibliography-page-using-bibtex"
  writeLines(text = c(preamble_tex, bib_rename), con = here::here("preamble.tex"))
}

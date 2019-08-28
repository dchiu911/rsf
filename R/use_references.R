#' Use references
#'
#' Add a References section at the end of the RSF.
#'
#' @param number number prepended to references Rmd source file.
#' @export
#' @examples
#' \donttest{
#' wd <- tempdir()
#' savedir <- setwd(wd)
#' use_references(number = 4)
#' setwd(savedir)
#' }
use_references <- function(number = 99) {
  # Check if input files exist
  if (!all(file.exists(here::here("index.Rmd", "_output.yml", "preamble.tex")))) {
    stop("One or more input files are missing.")
  }

  # Check if references already exists
  if ("bibliography" %in% names(yaml::read_yaml(here::here("index.Rmd")))) {
    usethis::ui_done("References already added")
    return(invisible())
  }

  # Create references Rmd source file
  src_path <- here::here("src")
  rmd_name <- paste0(stringr::str_pad(number, 2, pad = 0), "-references.Rmd")
  write_rmd(src_path, "References", rmd_name)

  # Add header and generate packages.bib
  header <- "`r if (knitr::is_html_output()) '# References {-}'`"
  chunk_start <- "\n```{r include=FALSE}"
  pkg_list <- "knitr::write_bib(c(.packages(), 'bookdown'), 'packages.bib')"
  chunk_end <- "```"
  rmd_path <- file.path(src_path, rmd_name)
  writeLines(text = c(header, chunk_start, pkg_list, chunk_end), con = rmd_path)
  usethis::ui_done(paste(usethis::ui_path(rmd_path), "added"))

  # Call packages.bib from index.Rmd
  index_rmd <- readLines(here::here("index.Rmd"))
  before_style <- grep("biblio-style", index_rmd) - 1
  index_rmd <- append(index_rmd, "bibliography: packages.bib", before_style)
  writeLines(text = index_rmd, con = here::here("index.Rmd"))
  usethis::ui_done(paste(usethis::ui_path("index.Rmd"), "modified"))

  # Add bib options to bookdown::pdf_book output
  output_yml <- yaml::read_yaml(here::here("_output.yml"))
  bib_opts <- list(citation_package = "natbib", toc_bib = TRUE)
  output_yml[["bookdown::pdf_book"]] <-
    c(output_yml[["bookdown::pdf_book"]], bib_opts)
  yaml::write_yaml(x = output_yml, file = here::here("_output.yml"))
  usethis::ui_done(paste(usethis::ui_path("_output.yml"), "modified"))

  # Rename Bibliography to References in tex
  preamble_tex <- readLines(here::here("preamble.tex"))
  bib_rename <- "\n\\renewcommand{\\bibname}{References}"
  writeLines(text = c(preamble_tex, bib_rename),
             con = here::here("preamble.tex"))
  usethis::ui_done(paste(usethis::ui_path("preamble.tex"), "modified"))
}

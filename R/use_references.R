#' Use references
#'
#' Add a References section at the end of the RSF.
#'
#' @param path path of the directory containing the input files `index.Rmd`,
#'   `_output.yml`, `preamble.tex`.
#' @param number number prepended to references Rmd source file.
#' @export
#' @examples
#' \donttest{
#' wd <- tempdir()
#' savedir <- setwd(wd)
#' file.copy(list.files(system.file("extdata", package = "rsf"),
#'                      full.names = TRUE), ".")
#' use_references(number = 4)
#' setwd(savedir)
#' }
use_references <- function(path = ".", number = 99) {
  # Check if input files exist
  index_rmd_path <- file.path(path, "index.Rmd")
  output_yml_path <- file.path(path, "_output.yml")
  preamble_tex_path <- file.path(path, "preamble.tex")
  if (!all(file.exists(c(index_rmd_path, output_yml_path, preamble_tex_path)))) {
    stop("One or more input files are missing.")
  }

  # Check if references already exists
  if ("bibliography" %in% names(yaml::read_yaml(index_rmd_path))) {
    usethis::ui_done("References already added")
    return(invisible())
  }

  # Create references Rmd source file
  src_path <- file.path(path, "src")
  if (!dir.exists(src_path)) dir.create(src_path)
  rmd_name <- paste0(stringr::str_pad(number, 2, pad = 0), "-references.Rmd")
  write_rmd(src_path, "References", rmd_name)

  # Add header and generate packages.bib
  header <- "`r if (knitr::is_html_output()) '# References {-}'`\n"
  chunk_start <- "```{r include=FALSE}"
  pkg_list <- "knitr::write_bib(c(.packages(), 'bookdown'), 'packages.bib')"
  chunk_end <- "```"
  rmd_path <- file.path(src_path, rmd_name)
  writeLines(text = c(header, chunk_start, pkg_list, chunk_end), con = rmd_path)
  usethis::ui_done(paste(usethis::ui_path(rmd_path), "added"))

  # Call packages.bib from index.Rmd
  index_rmd <- readLines(index_rmd_path)
  before_style <- grep("biblio-style", index_rmd) - 1
  index_rmd <- append(index_rmd, "bibliography: packages.bib", before_style)
  writeLines(text = index_rmd, con = index_rmd_path)
  usethis::ui_done(paste(usethis::ui_path(index_rmd_path), "modified"))

  # Add bib options to bookdown::pdf_book output
  output_yml <- yaml::read_yaml(output_yml_path)
  bib_opts <- list(citation_package = "natbib", toc_bib = TRUE)
  output_yml[["bookdown::pdf_book"]] <-
    c(output_yml[["bookdown::pdf_book"]], bib_opts)
  yaml::write_yaml(x = output_yml, file = output_yml_path)
  usethis::ui_done(paste(usethis::ui_path(output_yml_path), "modified"))

  # Rename Bibliography to References in tex
  preamble_tex <- readLines(preamble_tex_path)
  bib_rename <- "\n\\renewcommand{\\bibname}{References}"
  writeLines(text = c(preamble_tex, bib_rename), con = preamble_tex_path)
  usethis::ui_done(paste(usethis::ui_path(preamble_tex_path), "modified"))
}

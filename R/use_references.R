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

  # Specify references Rmd file path
  src_path <- file.path(path, "src")
  rmd_name <- paste0(sprintf("%02d", number), "-references.Rmd")
  ref_rmd_path <- file.path(src_path, rmd_name)

  if (file.exists(ref_rmd_path)) {
    # Do nothing if references Rmd already added
    usethis::ui_done(paste("Already added", usethis::ui_path(ref_rmd_path)))
    return(invisible())
  } else {
    # Rename file if it exists
    old_ref_rmd_path <-
      list.files(src_path, "^[0-9]{2}-references\\.Rmd", full.names = TRUE)
    if (length(old_ref_rmd_path) == 1) {
      file.rename(old_ref_rmd_path, ref_rmd_path)
      usethis::ui_done(paste(
        "Renaming",
        usethis::ui_path(old_ref_rmd_path),
        "to",
        usethis::ui_path(ref_rmd_path)
      ))
      return(invisible())
    } else {
      # Write header and generate packages.bib otherwise
      header <- "`r if (knitr::is_html_output()) '# References {-}'`"
      chunk <- ymlthis::code_chunk(
        chunk_code = knitr::write_bib(c(.packages(), "bookdown"), "packages.bib"),
        chunk_args = list(include = FALSE)
      )
      if (!dir.exists(src_path)) dir.create(src_path)
      writeLines(text = c(header, "", chunk), con = ref_rmd_path)
      usethis::ui_done(paste("Writing", usethis::ui_path(ref_rmd_path)))
    }
  }

  # Call packages.bib from index.Rmd
  index_rmd <- readLines(index_rmd_path)
  before_style <- grep("biblio-style", index_rmd) - 1
  index_rmd <- append(index_rmd, "bibliography: packages.bib", before_style)
  writeLines(text = index_rmd, con = index_rmd_path)
  usethis::ui_done(paste("Writing", usethis::ui_path(index_rmd_path)))

  # Add bib options to bookdown::pdf_book output
  output_yml <- yaml::read_yaml(output_yml_path)
  bib_opts <- list(citation_package = "natbib", toc_bib = TRUE)
  output_yml[["bookdown::pdf_book"]] <-
    c(output_yml[["bookdown::pdf_book"]], bib_opts)
  yaml::write_yaml(x = output_yml, file = output_yml_path)
  usethis::ui_done(paste("Writing", usethis::ui_path(output_yml_path)))

  # Rename Bibliography to References in tex
  preamble_tex <- readLines(preamble_tex_path)
  bib_rename <- "\\renewcommand{\\bibname}{References}"
  writeLines(text = c(preamble_tex, "", bib_rename), con = preamble_tex_path)
  usethis::ui_done(paste("Writing", usethis::ui_path(preamble_tex_path)))
}

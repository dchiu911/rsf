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
  ref_name <- paste0(sprintf("%02d", number), "-references.Rmd")
  ref_path <- file.path(src_path, ref_name)

  # Rename file if input name is different than existing
  if (file.exists(ref_path)) {
    usethis::ui_done(paste("Already added", usethis::ui_path(ref_path)))
  } else {
    old_ref_path <-
      list.files(src_path, "^[0-9]{2}-references\\.Rmd", full.names = TRUE)
    if (length(old_ref_path) == 1) {
      file.rename(old_ref_path, ref_path)
      usethis::ui_done(paste(
        "Renaming",
        usethis::ui_path(old_ref_path),
        "to",
        usethis::ui_path(ref_path)
      ))
    } else {
      # Write header and generate packages.bib otherwise
      header <- "`r if (knitr::is_html_output()) '# References {-}'`"
      chunk <- ymlthis::code_chunk(
        chunk_code = knitr::write_bib(c(.packages(), "bookdown"), "packages.bib"),
        chunk_args = list(include = FALSE)
      )
      if (!dir.exists(src_path)) dir.create(src_path)
      writeLines(text = c(header, "", chunk), con = ref_path)
      usethis::ui_done(paste("Adding", usethis::ui_path(ref_path)))
    }
  }

  # Call packages.bib from index.Rmd
  index_rmd <- readLines(index_rmd_path)
  pkgs_bib <- "bibliography: packages.bib"
  if (pkgs_bib %in% index_rmd) {
    usethis::ui_done(paste("Already modified", usethis::ui_path(index_rmd_path)))
  } else {
    index_rmd <-
      append(index_rmd, pkgs_bib, grep("biblio-style", index_rmd) - 1)
    writeLines(text = index_rmd, con = index_rmd_path)
    usethis::ui_done(paste("Modifying", usethis::ui_path(index_rmd_path)))
  }

  # Add bib options to bookdown::pdf_book output
  output_yml <- yaml::read_yaml(output_yml_path)
  bib_opts <- list(citation_package = "natbib", toc_bib = TRUE)
  if (all(names(bib_opts) %in% names(output_yml[["bookdown::pdf_book"]]))) {
    usethis::ui_done(paste("Already modified", usethis::ui_path(output_yml_path)))
  } else {
    output_yml[["bookdown::pdf_book"]] <-
      c(output_yml[["bookdown::pdf_book"]], bib_opts)
    yaml::write_yaml(x = output_yml, file = output_yml_path)
    usethis::ui_done(paste("Modifying", usethis::ui_path(output_yml_path)))
  }

  # Rename Bibliography to References in tex
  preamble_tex <- readLines(preamble_tex_path)
  bib_rename <- "\\renewcommand{\\bibname}{References}"
  if (bib_rename %in% preamble_tex) {
    usethis::ui_done(paste("Already modified", usethis::ui_path(preamble_tex_path)))
  } else {
    writeLines(text = c(preamble_tex, "", bib_rename), con = preamble_tex_path)
    usethis::ui_done(paste("Modifying", usethis::ui_path(preamble_tex_path)))
  }
}

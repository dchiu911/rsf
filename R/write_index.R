#' Write `index.Rmd`
#' @noRd
write_index <- function(path) {
  index_yml <- ymlthis::yml_empty() %>%
    ymlthis::yml_title(paste(basename(path),
                             "Report of Statistical Findings", sep = ": ")) %>%
    ymlthis::yml() %>%
    ymlthis::yml_bookdown_site() %>%
    ymlthis::yml_latex_opts(
      documentclass = "report",
      geometry = "margin=1in",
      colorlinks = TRUE,
      lof = TRUE,
      lot = TRUE,
      biblio_style = "apalike"
    ) %>%
    ymlthis::yml_citations(link_citations = TRUE)
  writeLines(
    text = c(utils::capture.output(print(index_yml)), "\n# Preface {-}"),
    con = file.path(path, "index.Rmd")
  )  # TODO: use_rmarkdown() forces index.Rmd to open, use_index_rmd doesn't pass body param
}

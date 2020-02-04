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
      lot = TRUE
    ) %>%
    ymlthis::yml_citations(biblio_style = "apalike", link_citations = TRUE)
  ymlthis::use_index_rmd(
    .yml = index_yml,
    path = path,
    body = "\n# Preface {-}",
    quiet = TRUE,
    open_doc = FALSE
  )
}

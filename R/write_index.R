# index.Rmd
write_index <- function(path) {
  index_yml <- list(
    title = paste(basename(path), "Report of Statistical Findings", sep = ": "),
    author = whoami::fullname(fallback = "Author"),
    date = "`r Sys.Date()`",
    site = "bookdown::bookdown_site",
    documentclass = "report",
    `biblio-style` = "apalike",
    `link-citations` = TRUE,
    colorlinks = TRUE,
    lot = TRUE,
    lof = TRUE
  )
  index_yml <- gsub("\n$", "", yaml::as.yaml(index_yml))
  writeLines(text = c("---", index_yml, "---\n\n# Preface {-}"),
             con = file.path(path, "index.Rmd"))
}

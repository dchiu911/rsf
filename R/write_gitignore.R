#' Write `.gitignore`
#' @noRd
write_gitignore <- function(path) {
  writeLines(
    c(".Rproj.user", ".Rhistory", ".RData", ".Ruserdata"),
    file.path(path, ".gitignore")
  )
}

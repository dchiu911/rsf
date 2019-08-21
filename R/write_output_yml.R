# _output.yml
write_output_yml <- function(path) {
  output_yml <- list(
    `bookdown::gitbook` = list(
      lib_dir = "assets",
      split_by = "chapter+number"
    ),
    `bookdown::pdf_book` = list(
      keep_tex = TRUE,
      includes = list(
        in_header = "preamble.tex"
      )
    )
  )
  yaml::write_yaml(
    x = output_yml,
    file = file.path(path, "_output.yml")
  )
}

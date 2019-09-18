# preamble.tex
write_preamble <- function(path) {
  cmds <-
    "\\let\\paragraph\\oldparagraph
\\let\\subparagraph\\oldsubparagraph

\\usepackage{titlesec, blindtext, color}

\\titleformat{\\chapter}[display]
  {\\Huge\\bfseries}
  {}
  {0pt}
  {\\thechapter.\\ }

\\titleformat{name=\\chapter,numberless}[display]
  {\\Huge\\bfseries}
  {}
  {0pt}
  {}

\\titlespacing*{\\chapter}{0pt}{0pt}{40pt}"

  writeLines(cmds, file.path(path, "preamble.tex"))
}

# References
# https://github.com/rstudio/bookdown/issues/677
# https://tex.stackexchange.com/questions/284893/remove-chapter-from-a-book-text"
# https://tex.stackexchange.com/questions/12597/renaming-the-bibliography-page-using-bibtex

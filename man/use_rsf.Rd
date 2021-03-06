% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/use_rsf.R
\name{use_rsf}
\alias{use_rsf}
\title{Use RSF project template}
\usage{
use_rsf(path, ...)
}
\arguments{
\item{path}{project path}

\item{...}{additional configurations for \verb{_bookdown.yml} as described in
\url{https://bookdown.org/yihui/bookdown/configuration.html}. Currently, only
\code{output_dir} is supported.}
}
\description{
Opens a new R project using the RSF template. Intended for use in RStudio,
not interactively.
}
\details{
This function is called when the user selects File > New Project > New
Directory > Report of Statistical Findings using bookdown. The directory name
and output directory can be specified.
}

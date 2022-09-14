# rsf 0.3.0

* Use GitHub Actions for CI and pkgdown site
* Add project options to initialize with git repository and/or renv private library
* Add conditions in `use_references()` to skip modifications if they already exist
* Add setup script and call from each Rmd

# rsf 0.2.2

* Always hold figure position with figure captions
* Remove latex fix for bookdown and titlesec incompatibility bug after update to bookdown (rstudio/bookdown#677)

# rsf 0.2.1

* Change `output_dir` to `docs` to work nicely with GitHub Pages
* Change `gitbook` defaults: `split_by = "chapter"` to simplify HTML links, add button to download PDF output
* Update `write_index()` after changes to `yml_citations()` and `use_index_rmd()` in `ymlthis` package
* Use `options(ymlthis.remove_blank_line = TRUE)` to remove trailing blank line in YAML files

# rsf 0.2.0

## API changes

* Use the `ymlthis` package for writing YAML

## LaTeX changes

* Decrease space before chapter header
* Don't use ruled captions for tables
* Set margins at 1 inch

# rsf 0.1.0

* Added a `NEWS.md` file to track changes to the package.

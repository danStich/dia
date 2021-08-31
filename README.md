# dia

An R package for hosting code and data, and running the Atlantic salmon Dam Impact Analysis (DIA) model.

## Installation

The development version of `dia` can be installed with  [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) in R using the repository url:

`devtools::install_github("danStich/dia")`

To install `dia`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already.

## Directories

`data/` Contains built-in data sets for the package

`man/`  help files and documentation

`R/`    R functions in scripts

`inst/shiny-examples/dia_shiny` includes server and ui files for `run_dia_shiny()`, a shiny-based user interface

`tests/` Includes package tests for default parameter accuracy conducted on package build

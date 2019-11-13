
<!-- README.md is generated from README.Rmd. Please edit that file -->

# GlacieR

<!-- badges: start -->

<!-- badges: end -->

The goal of GlacieR is to provide a low tech implementation of data
versioning. It does this by providing an interface layer to intermediate
flat files which chooses the most recent version, provided it follows a
fairly straightforward naming convention. To accelerate the process of
saving files in this manner it also makes use of some file saving
helpers.

This package leverages the excellent `{config}` package, and will have
some inherited idiosyncracies on top of the many author introduced ones.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("JDOsborne1/glacieR-vc")
```

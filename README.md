
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pudu <img src="man/figures/logo.svg" align="right" height="139" alt="" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/pachadotdev/pudu/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachadotdev/pudu/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/pachadotdev/pudu/graph/badge.svg?token=mWfiUCgfNu)](https://app.codecov.io/gh/pachadotdev/pudu)
[![BuyMeACoffee](https://raw.githubusercontent.com/pachadotdev/buymeacoffee-badges/main/bmc-donate-white.svg)](https://buymeacoffee.com/pacha)
[![CRAN
status](https://www.r-pkg.org/badges/version/pudu)](https://CRAN.R-project.org/package=pudu)
<!-- badges: end -->

# Overview

The goal of pudu is to provide function declarations and inline function
definitions that facilitate cleaning strings in C++ code before passing
them to R. It works with `cpp11::strings` and `std::vector<std::string>`
objects.

The idea is the same as the
[janitor](https://cran.r-project.org/package=janitor) package, but for
C++ code.

Why is the name Pudu? Pudu is the smallest deer on planet Earth and this
package is tiny too. The original Pudu (unvectorized) was drawn by
[Pokanvas](https://www.deviantart.com/pokanvas/art/Baby-Pudu-944226115).
This package emerged as a spinoff from the
[redatam](https://github.com/pachadotdev/open-redatam) package while
cleaning strings in C++ code.

# Installation

You can install the development version of pudu with:

``` r
remotes::install_github("pachadotdev/pudu")
```

# Example

Here is how you can use the functions in this package in C++ code:

``` cpp
#include <cpp11.hpp>
#include <pudu.hpp>

using namespace cpp11;

// Example 1

std::vector<std::string> x = {" REGION NAME "};

tidy_std_names(x); // returns 'REGION NAME'

// Example 2

tidy_std_vars(x); // returns 'region_name'

// Example 3

// test_tidy_r_names(" REGION NAME ") returns 'REGION NAME'
[[cpp11::register]] cpp11::writable::strings test_tidy_r_names(
  const cpp11::strings& x) {
  cpp11::writable::strings res = tidy_r_names(x);
  return res;
}

// Example 4

// test_tidy_r_names(" REGION NAME ") returns 'region_name'
[[cpp11::register]] cpp11::writable::strings test_tidy_r_vars(
  const cpp11::strings& x) {
  cpp11::writable::strings res = tidy_r_vars(x);
  return res;
}
```

Messy strings such as " DEPTO. .REF\_ID\_ " are converted to
“depto\_ref\_id” or “DEPTO. .REF\_ID\_”.

The following tests in R should give an idea of how the functions work:

``` r
# German
vars <- "Gau\xc3\x9f"
expect_equal(test_tidy_r_names(vars), "gau")
expect_equal(test_tidy_r_vars(vars), "Gau\u00df")

# French
vars <- "c\xc2\xb4est-\xc3\xa0-dire"
expect_equal(test_tidy_r_names(vars), "c_est_a_dire")
expect_equal(test_tidy_r_vars(vars), "c\u00b4est-\u00e0-dire")

# Spanish
vars <- "\xc2\xbfC\xc3\xb3mo est\xc3\xa1s\x3f"
expect_equal(test_tidy_r_names(vars), "como_estas")
expect_equal(test_tidy_r_vars(vars), "\u00bfC\u00f3mo est\u00e1s\u003f")

# Japanese
vars <- "Konnichiwa \xe3\x81\x93\xe3\x82\x93\xe3\x81\xab\xe3\x81\xa1\xe3\x81\xaf"
expect_equal(test_tidy_r_names(vars), "konnichiwa")
expect_equal(test_tidy_r_vars(vars), "Konnichiwa \u3053\u3093\u306b\u3061\u306f")
```

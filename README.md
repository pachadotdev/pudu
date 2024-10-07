
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cpp11janitor <img src="man/figures/logo.svg" align="right" height="139" alt="" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/pachadotdev/cpp11janitor/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachadotdev/cpp11janitor/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/pachadotdev/cpp11janitor/graph/badge.svg?token=mWfiUCgfNu)](https://app.codecov.io/gh/pachadotdev/cpp11janitor)
[![BuyMeACoffee](https://raw.githubusercontent.com/pachadotdev/buymeacoffee-badges/main/bmc-donate-white.svg)](https://buymeacoffee.com/pacha)
[![CRAN
status](https://www.r-pkg.org/badges/version/cpp11janitor)](https://CRAN.R-project.org/package=cpp11janitor)
<!-- badges: end -->

# Overview

The goal of cpp11janitor is to provide function declarations and inline
function definitions that facilitate cleaning strings in C++ code before
passing them to R. It works with `cpp11::strings` and
`std::vector<std::string>` objects.

The idea is the same as the
[janitor](https://cran.r-project.org/package=janitor) package, but for
C++ code.

# Installation

You can install the development version of cpp11janitor with:

``` r
remotes::install_github("pachadotdev/cpp11janitor")
```

# Example

Here is how you can use the functions in this package from C++ code:

``` cpp
#include "00_main.h"
#include "cpp11janitor.hpp"

// Example 1

std::vector<std::string> x = {" REGION NAME "};

tidy_std_names(x);

// Example 2

tidy_std_vars(x);

// Example 3

[[cpp11::register]] cpp11::writable::strings test_tidy_r_names(
  const cpp11::strings& x) {
  cpp11::writable::strings res = tidy_r_names(x);
  return res;
}

// Example 4

[[cpp11::register]] cpp11::writable::strings test_tidy_r_vars(
  const cpp11::strings& x) {
  cpp11::writable::strings res = tidy_r_vars(x);
  return res;
}
```

From C++, the first two examples return “region\_name” and “REGION
NAME”, respectively.

From R, the last two examples return “region\_name” and “REGION\_NAME”
when calling `test_tidy_r_names(" REGION NAME ")` and
`test_tidy_r_vars(" REGION NAME ")`, respectively. Messy strings such as
" DEPTO. .REF\_ID\_ " are converted to “depto\_ref\_id” and “DEPTO.
.REF\_ID\_”, respectively.

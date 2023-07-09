
<!-- README.md is generated from README.Rmd. Please edit that file -->

# DSPGrocery

<!-- badges: start -->

<a href="https://dspg-2023.github.io/Grocery/"><img src="man/figures/logo.png" align="right" height="139" alt="DSPGGrocery website" /></a>

<!-- badges: end -->

The goal of DSPGrocery is to provide an R based tool to help users with
decision-making for opening up a grocery store in a rural environment.
The tool itself is an R Shiny app which uses the functions from the
DSPGrocery package to generate market size, estimated revenue, expenses
and other demographic information.

## Installation

You can install the development version of DSPGGrocery from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DSPG-2023/Grocery")
```

## Example

This functions in the package can also be used independently of the R
Shiny tool by simply calling the functions after loading the library.

``` r
library(DSPGGrocery)

## Here is an example outputting the Gross Margin value using a function from the
## package.

GrossMargin <- Gross_Margin(Total_Estimated_Revenue = 120000,
                             Percentage = .25)

print(sprintf("Total Gross Margin: $%d", GrossMargin))
#> [1] "Total Gross Margin: $30000"
```

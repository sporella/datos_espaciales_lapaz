#= # Introduction  --------
#' This file was adapted from < https://github.com/yihui/knitr/blob/master/inst/examples/knitr-spin.R>.
#' This is a special R script which can be used to generate a report. You can
#' write normal text in roxygen comments.

#= # Quick Start  --------
#= ## Options  --------
#' First we set up some options (you do not have to do this):

#+ setup, include=FALSE
library(knitr)
opts_chunk$set(fig.path = 'figure/silk-')

#= ## A Simple Example  --------
#' The report begins here.

#+ test-a, cache=FALSE
# boring examples as usual
set.seed(123)
x = rnorm(5)
mean(x)

#= ## Inline Codes  --------
#' You can use the special syntax {{code}} to embed inline expressions, e.g. {{mean(x) + 2}}
#' is the mean of x plus 2.
#' The code itself may contain braces, but these are not checked.  Thus,
#' perfectly valid (though very strange) R code such as `{{2 + 3}} - {{4 - 5}}`
#' can lead to errors because `2 + 3}} - {{4 - 5` will be treated as inline code.

#= ## Plots  --------
#' Now we continue writing the report. We can draw plots as well.

#+ test-b, fig.width=5, fig.height=5
par(mar = c(4, 4, .1, .1)); plot(x)

#= ## Chunks  --------
#' Actually you do not have to write chunk options, in which case knitr will use
#' default options. For example, the code below has no options attached:

var(x)
quantile(x)

#' And you can also write two chunks successively like this:

#+ test-chisq5
sum(x^2) # chi-square distribution with df 5
#+ test-chisq4
sum((x - mean(x))^2) # df is 4 now

#' Done. Call spin('knitr-spin.R') to make silk from sow's ear now and knit a
#' lovely purse.
#= ## Comments  --------

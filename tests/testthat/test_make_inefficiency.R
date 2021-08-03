library(testthat)
library(dia)

test_that("run_inefficiency returns vector with length 15", {
            expect_type(
              run_inefficiency(n = rep(100, 15),
                               inefficiency_matrix = dia::inefficiency_matrix),
              "double")
            }
          )

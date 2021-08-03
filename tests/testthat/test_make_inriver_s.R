library(testthat)
library(dia)

test_that("In-river survival vector has 15 elements", {
            expect_equal(length(make_inriver_s()), 15)
            }
          )

test_that("In-river survival vector is within reasonable range", {
            expect_gte(min(make_inriver_s()), 0)
            expect_lte(max(make_inriver_s()), 1)
            }
          )

library(testthat)
library(dia)

test_that("Dam passage objects are structured properly", {
            expect_type(get_dam_passage(), "list")
            expect_equal(length(get_dam_passage()[[1]]), 15)  
            expect_equal(length(get_dam_passage()[[2]]), 1)  
            }
          )
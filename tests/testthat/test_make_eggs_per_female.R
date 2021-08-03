library(testthat)
library(dia)

test_that("Fecundity is within reported ranges", {
            expect_gte(make_eggs_per_female(), 4000)
            expect_lte(make_eggs_per_female(), 12000)  
            }
          )

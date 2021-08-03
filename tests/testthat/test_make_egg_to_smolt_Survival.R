library(testthat)
library(dia)

test_that("Egg-to-smolt is within reported ranges", {
            expect_gte(make_egg_to_smolt_survival(), 0)
            expect_lte(make_egg_to_smolt_survival(), 0.023)  
            }
          )

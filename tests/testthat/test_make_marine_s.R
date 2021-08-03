library(testthat)
library(dia)

test_that("Marine survival is within reported ranges", {
            expect_gte(make_marine_s(hatchery = TRUE), 0)
            expect_lte(make_marine_s(hatchery = TRUE), 0.03)  
            expect_gte(make_marine_s(hatchery = FALSE), 0)
            expect_lte(make_marine_s(hatchery = FALSE), 0.03)    
            }
          )

test_that("Marine survival average is accurate", {
            expect_equal(mean(make_marine_s(n = 10000, hatchery = TRUE)),
                         life_stage_survival[4,2], tolerance = .01)
            expect_equal(mean(make_marine_s(n = 10000, hatchery = FALSE)),
                         life_stage_survival[5,2], tolerance = .01)  
            }
          )

library(testthat)
library(portransp)

context("")
test_that("numeric 'opendata' and yyyymm 'reference' and tempdir() 'destfile'",
          potr_download(opendata = 1, reference = 202101, destfile = tempdir()))
test_that("numeric 'opendata' and yyyymm 'reference' and tempdir() 'destfile'",
          potr_download_all(opendata = "auxilio-emergencial", destfile = tempdir(), limited_to = 2))
test_that("numeric 'opendata' and yyyymm 'reference' and tempdir() 'destfile'",
          potr_download_last(opendata = "auxilio-emergencial", destfile = tempdir()))

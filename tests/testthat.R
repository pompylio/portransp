library(testthat)
library(portransp)

context("")
test_that("numeric 'opendata' and yyyymm 'reference' and tempdir() 'destfile'",
          potr_download(opendata = 11, reference = 201812, destfile = tempdir()))
test_that("character 'opendata' and yyyy 'reference' and ~/ 'destfile'",
          potr_download(opendata = "receitas", reference = 2018, destfile = tempdir()))
test_that("character 'opendata' and tempdir() 'destfile'",
          potr_download_all(opendata = "20", destfile = tempdir()))
test_that("character 'opendata' and ~/ 'destfile'",
          potr_download_all(opendata = "receitas", destfile = "~/"))
test_that("character 'opendata' and ~/ 'destfile'",
          potr_download_all(opendata = "receitas", destfile = "~/"))
test_that("numeric 'opendata' and tempdir() 'destfile'",
          potr_download_last(opendata = 10, destfile = tempdir()))
test_that("character 'opendata' and ~/ 'destfile' and other 'filename'",
          potr_download_last(opendata = "despesas", destfile = "~/", filename = "despesas_last"))

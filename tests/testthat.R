library(testthat)
library(portransp)

context("")
test_that("numeric to 'opendata' and 'reference' inputs",
  ptransp_download(opendata = 1,reference = 2018,destfile = "~/R/data",mode = "wb")
  )

require(portransp)

# orcamento-despesa -------------------------------------------------------
# single
ptransp_download(opendata = 1,reference = 2018,destfile = "~/R/data",mode = "wb") # numeric input
ptransp_download(opendata = "1",reference = "2018",destfile = "~/R/data",mode = "wb") # character input
ptransp_download(opendata = "orcamento-despesa",reference = "2018",destfile = "~/R/data",mode = "wb") # character input: 'id' or 'name' open data
#                                                                                                       on windows system, use mode 'wb'

# multiple
year <- c(2018,2017,2016,2015,2014,2013)
for(y in 1:length(year)){
  ptransp_download(opendata = 1,reference = year[y],destfile = "~/R/data",mode = "wb")
}

year <- c(2018,2017,2016,2015,2014,2013) # or year <- c("2018","2017","2016","2015","2014","2013")
odt <- c(1,8,24) # or 'odt <- c("1",8","24")' or c("orcamento-despesa","receitas","viagens)
for(o in 1:length(odt)){
  for(y in 1:length(year)){
    try(ptransp_download(opendata = odt[o],reference = year[y],destfile = "~/R/data",mode = "wb")) # use 'try' function not to stop
  }
}


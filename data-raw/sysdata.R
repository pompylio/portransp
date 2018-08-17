potrdt <- readr::read_delim("data-raw/dataset_portransp.csv",
                     ";", escape_double = FALSE, col_types = cols(id = col_character()),
                     na = "null", trim_ws = TRUE)
potrms <-
  paste0(
    paste0("(", potrdt$id, " or "),
    paste0(potrdt$dataset,""),
    paste0(", ", potrdt$formatdate,")"),
    collapse = " "
  )
potrurl <- "http://www.portaltransparencia.gov.br/download-de-dados/"
devtools::use_data(potrdt,potrms,potrurl,internal = TRUE,overwrite = TRUE)

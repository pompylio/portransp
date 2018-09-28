#' Zip file structure
#' @export
potr_structure_zip <- function(zipfile){
  if (missing(zipfile)) stop("missing zipfile")
  tempdir <- tempdir()
  output <- list(list_files = unzip(zipfile = zipfile, list = TRUE))
  output$list_files$Ncol <- 0
  output$list_files$Nrow <- 0
  unzip(zipfile = zipfile, exdir = tempdir)
  dt <- list()
  for(i in 1:length(output$list_files$Name)){
    file_select <- paste0(tempdir,"/",output$list_files$Name[i])
    db <- read.csv2(
      file = file_select,
      check.names = FALSE,
      header = TRUE,
      nrows = 1)
    output$list_files$Ncol[i] <- ncol(db)
    output$list_files$Nrow[i] <- nrow(data.table::fread(file_select, sep = ";", quote = "\"", select = 1L))
    db <- list(names(db))
    names(db) <- output$list_files$Name[i]
    dt <- append(dt, db)
  }
  output <- append(output, dt)
  for(i in 1:length(output$list_files$Name)){
    unlink(paste0(tempdir,"/",output$list_files$Name[i]))
  }
  return(output)
}

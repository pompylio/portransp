# Download Portal
#
# This function allows to download the set of data available in the
# \url{http://www.portaltransparencia.gov.br}
#
# @params opendata open data selected for download.
# @params reference valid date, which may be 'yyyy' for year, 'mm' for month,
# 'dd' day, or the join of these - (yyyymm, yyyymmdd). Depends on the entrance
# requirements of the "opendata"
# @params filename requires the location and file name to be saved
ptransp_download <- function(opendata,reference,filename,...){
  load("data/pkgdata.rda")
  msg <-
    paste0(
      paste0("(", portal$id, " or "),
      portal$opendata,
      portal$detail,
      paste0(", ", portal$reference, ")"),
      collapse = ", ")
  if (missing(opendata) | missing(reference))
    stop("Valid input (opendata, reference): ",msg, call. = FALSE)
  if (any(opendata == portal$opendata)) {
    ref <- portal$reference[which(portal$opendata == opendata)]
    if (!nchar(reference) == nchar(ref)) {
      stop("valid format for input '", opendata, "': ", ref, call. = FALSE)
      }
    } else if (any(as.character(opendata) == portal$id)) {
      ref <- portal$reference[as.numeric(opendata)]
      opendata <- portal$opendata[as.numeric(opendata)]
      if (!nchar(reference) == nchar(ref)) {
        stop("valid format for input '", opendata, "': ", ref, call. = FALSE)
        }
      } else{
        stop("Valid input (opendata, reference): ", msg, call. = FALSE)
        }
  if (missing(filename)) {
    dir <- getwd()
    filename <- paste0(dir,"/",opendata,reference,".zip")
    message("missing 'file' input. selected: ",filename)
  }
  portal$detail <- ifelse(portal$detail == "","",paste0("_",portal$detail))
  odt <- unlist(strsplit(opendata,split = "_"))[1]
  URL <-
    paste0(
      "http://www.portaltransparencia.gov.br/download-de-dados/",
      odt,
      "/",
      reference,
      portal[portal$opendata == opendata,]$detail
    )
  download.file(url = URL,destfile = filename,...)
}

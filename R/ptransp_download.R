#' Download Portal
#'
#' This function allows to download the set of data available in the
#' \url{http://www.portaltransparencia.gov.br}
#'
#' @params opendata open data selected for download.
#' @params reference valid date, which may be 'yyyy' for year, 'mm' for month,
#' 'dd' day, or the join of these - (yyyymm, yyyymmdd). Depends on the entrance
#' requirements of the "opendata"
#' @params destfile location to save the file
#' @params filename file name. For all open data defined by 'opendata' use the
#' extension '.zip'
#' @params ... arguments of the download.file () function. On windows, select
#' 'wb' mode for binary files.
#'
#' @export
#' @examples
#' ptransp_download(opendata = 1,reference = 2018)
#' ptransp_download(opendata = "1",reference = "2018")
#' ptransp_download(opendata = "orcamento-despesa",reference = "2018")
#' ptransp_download(opendata = 1,reference = 2018,destfile = "~/")
#' ptransp_download(opendata = 1,reference = 2018,destfile = "~/data",filename = "orcamento.zip")
ptransp_download <- function(opendata,reference,destfile,filename,...){
  if (missing(opendata) || missing(reference))
    stop("Missing 'opendata' or 'reference'. Valid input (opendata, reference): ",msgPtransp, call. = FALSE)
  if (any(opendata == ptrdt$opendata)) {
    ref <- ptrdt$reference[which(ptrdt$opendata == opendata)]
    if (!nchar(reference) == nchar(ref)) {
      stop("valid format for input '", opendata, "': ", ref, call. = FALSE)
      }
    } else if (any(as.character(opendata) == ptrdt$id)) {
      ref <- ptrdt$reference[as.numeric(opendata)]
      opendata <- ptrdt$opendata[as.numeric(opendata)]
      if (!nchar(reference) == nchar(ref)) {
        stop("valid format for input '", opendata, "': ", ref, call. = FALSE)
        }
      } else{
        stop("Valid input (opendata, reference): ", msgPtransp, call. = FALSE)
      }
  if (missing(destfile)){
    destfile <- getwd()
    message("missing 'destfile' input. selected: ",destfile)
  }
  if (missing(filename)) {
    filename <- paste0(opendata,reference,".zip")
    message("missing 'file' input. selected: ",filename)
  }
  destfile <- paste0(destfile,"/",filename)
  ptrdt$detail <- ifelse(ptrdt$detail == "","",paste0("_",ptrdt$detail))
  odt <- unlist(strsplit(opendata,split = "_"))[1]
  URL <-
    paste0(
      "http://www.portaltransparencia.gov.br/download-de-dados/",
      odt,
      "/",
      reference,
      ptrdt[ptrdt$opendata == opendata,]$detail
    )
  download.file(url = URL,destfile = destfile,...)
}

#' Download the last files of the 'Portal da Transparencia'
#'
#' This function can be used to download the latest data set from the 'Transparency Portal'
#' of Brazil - \url{http://www.portaltransparencia.gov.br}.
#'
#' @param opendata A character or numeric thats indicates a dataset selected for download.
#' See x to meet valid input of the argument.
#' @param destfile A character string with the name where the downloaded file is saved.
#' If missing, the file will be saved to the current directory.
#' @param filename File name to dataset. For all dataset defined by 'opendata' use the
#' extension '.zip' to the end. If missing, the file name will be a title of opendata with a reference.
#' @param download.file.mode  The mode with which to write the file. If download.file.mode is not found
#' and the operating system is windows, it will use the "wb".
#' @param ... Others arguments of the \code{\link[utils:download.file]{download.file}} function.
#'
#' @details
#' The function downloads files available in the repository of transparency portal -
#' website of the federal government of Brazil on public transparency, with budgetary
#' data and government management. The data disclosed in the Portal come from various
#' sources of government information. See http://www.portaltransparencia.gov.br/ for
#' more information.
#'
#' The function arguments are specifications about the data set to be downloaded.
#' 'opendata' is related to the content of the data, 'reference' to the date of
#' availability of the file in the portal and 'destfile' to the location to be saved.
#' Other '...' arguments are related to the download.file function of the 'utils' package.
#'
#' It is suggested that the values for '...' be reported only if the default setting
#' does not work. See \code{\link[utils:download.file]{download.file}} for more
#' information about these arguments and proxy settings.
#'
#' @examples
#' potr_download_last(opendata = 19)
#' potr_download_last(opendata = 19, destfile = "~/data")
#' potr_download_last(opendata = 19, destfile = "~/data", filename = "orcamento.zip")
#' potr_download_last(opendata = "19")
#' potr_download_last(opendata = "19", destfile = "~/data")
#' potr_download_last(opendata = "19", destfile = "~/data", filename = "orcamento.zip")
#' potr_download_last(opendata = "orcamento-despesa")
#' potr_download_last(opendata = "orcamento-despesa", destfile = "~/data")
#' potr_download_last(opendata = "orcamento-despesa", destfile = "~/data", filename = "orcamento.zip")
#' @export
potr_download_last <- function(opendata, destfile, filename, download.file.mode, ...) {
  if (missing(opendata))
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)
  if (any(opendata == potrdt$dataset))
    potrdt <- potrdt[which(potrdt$dataset == opendata), ]
  else if (any(as.character(opendata) == potrdt$id))
    potrdt <- potrdt[potrdt$id == as.numeric(opendata), ]
  else stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)
  opendata <- unlist(strsplit(potrdt$dataset, split = "_"))[1]
  reference <- seq(from = as.Date("2013-01-01"), to = Sys.Date(), by = potrdt$by)
  reference <- substr(gsub(pattern = "-", replacement = "", x = reference), 1, nchar(potrdt$formatdate))
  subitem <- ifelse(potrdt$subitem == "", "", paste0("_", potrdt$subitem))
  if (missing(filename)) filename <- potrdt$dataset
  if (missing(destfile)) destfile <- filename
  else destfile <- paste0(destfile,"/",filename)
  i = length(reference)
  file_dl <- paste0(destfile, "-", reference[i], ".zip")
  if (missing(download.file.mode) && Sys.info()["sysname"] == "Windows"){
    download.file.mode <- "wb"
  } else {
    download.file.mode <- "w"
  }
  while (file.exists(file_dl) == FALSE | i == 0) {
    link <- paste0(potrurl, opendata, "/", reference[i], subitem)
    file_dl <- paste0(destfile, "-", reference[i], ".zip")
    try(download.file(url = link, destfile = file_dl, mode = download.file.mode, ...), silent = TRUE)
    i <- i - 1
    }
}

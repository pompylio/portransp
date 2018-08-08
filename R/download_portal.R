# Download Portal
#
# This function allows to download the set of data available in the
# \url{http://www.portaltransparencia.gov.br}
#
# @params opendata open data selected for download.
# @params end_date end date

ptran_download
ptran_download_all
ptran_convert
ptran_bind
ptran_export
ptran_send

ptran_download <- function(opendata,reference,try,unzip){
  if (!requireNamespace("RCurl", quietly = TRUE)) {
    stop("Package \"RCurl\" needed for this function to work. Please install it.",
      call. = FALSE)
  }
  load("data/pkgdata.rda")
  msg <-
    paste0(
      paste0("(", portal$id, " "),
      portal$opendata,
      portal$detail,
      paste0(", ", portal$reference, ")"),
      collapse = ","
    )
  if (missing(opendata) |
      missing(reference) |
      !nchar(reference) == nchar(portal$reference[opendata]))
    stop(
      "Valid input (opendata, reference): ",
      msg
    )
  portal$detail <- ifelse(portal$detail == "","",paste0("_",portal$detail))
  URL <-
    paste0(
      "http://www.portaltransparencia.gov.br/download-de-dados/",
      portal$opendata[opendata],
      "/",
      reference,
      portal$detail[opendata]
    )

}

download_portal <- function(opendata,item,end_date = Sys.Date(),start_date = "2013-01-01",all = FALSE,unzip = FALSE,mode = "wb",...){
  if (!requireNamespace("RCurl", quietly = TRUE)) {
    stop("Package \"RCurl\" needed for this function to work. Please install it.",
      call. = FALSE)
  }

  # library -----------------------------------------------------------------
  data <- c("1"="orcamento-despesa","2"="despesas","3"="despesas-execucao","4"="transferencias","5"="cpgf","6"="cpcc","7"="cpdc","8"="receitas","10"="licitacoes","11"="compras","12"="convenios","13"="bolsa-familia-pagamentos","14"="bolsa-familia-saques","15"="garantia-safra","16"="seguro-defeso","17"="peti","18"="servidores","19"="ceaf","20"="dirigentes","21"="ceis","22"="cepim","23"="cnep","24"="viagens","25"="imoveis-funcionais")
  # missing values ----------------------------------------------------------
  if(missing(opendata)) stop("missing 'opendata'. Valid 'opendata': ", paste(names(data),data,collapse = ", "))
  if(!any(as.character(opendata) == as.character(seq(1:25)))) stop("'opendata' invalid input.")
  item <- ifelse(!opendata %in% c("18","25"),"",ifelse(opendata == "18" & item == "1","_Servidores",ifelse(opendata == "18" & item == "2","_Militares",ifelse(opendata == "25" & item == "1","_MRE",ifelse(opendata == "25" & item == "2","_SPU",ifelse(opendata == "25" & item == "3", "_MD",ifelse(opendata == "25" & item == "4","_PR",NULL)))))))
  if(is.null(item)) stop("'item' input not found.")
  # select data -------------------------------------------------------------
  URL <- paste0("http://www.portaltransparencia.gov.br/download-de-dados/",data[opendata],"/")
  # function for loop -------------------------------------------------------
  fun <- function(by,unzip){
    date <- seq.Date(from = as.Date(start_date),to = as.Date(end_date),by = by)
    date <- unique(paste0(substr(date,1,4),if(by == "year"){""}else{substr(date,6,7)},if(by %in% c("year","month")){""}else{substr(date,9,10)}))
    link <- paste0(URL,date,item)
    n <- length(date)
    while(if(opendata %in% c("12","19","21","22","23")){url.exists(link) == FALSE}else{n > 0}){
      link <- paste0(URL,date[n],item)
      file <- paste0("data/",data[opendata],item,"-",date[n],".zip")
      try(expr = download.file(url = link,destfile = file,mode = mode,...),silent = TRUE)
      Sys.sleep(1)
      if(file.info(file)$size == 0){
        message("URL ",link," not found. Try reference: ",date[n-1])
        unlink(file)
      }else if(unzip == TRUE){
        unzip(zipfile = file,exdir = "data/",overwrite = TRUE)
        unlink(file)
      }
      n = n-1
    }
  }
  # apply function to download a data ---------------------------------------
  if(all == TRUE){
    if(opendata %in% c("1","8","24")){fun(by = "year")}
    if(opendata %in% c("3","4","5","6","7","10","11","13","14","15","16","17","18")){fun(by = "month")}
    if(opendata %in% c("2","25","12","19","21","22","23")){fun(by = "day")}
  }else{
    if(opendata %in% c("1","8","24")){date <- substr(end_date,1,4)}
    if(opendata %in% c("3","4","5","6","7","10","11","13","14","15","16","17","18")){date <- paste0(substr(end_date,1,4),substr(end_date,6,7))}
    if(opendata %in% c("2","25","12","19","21","22","23")){date <- paste0(substr(end_date,1,4),substr(end_date,6,7),substr(end_date,9,10))}
    link <- paste0(URL,date,item)
    file <- paste0("data/",data[opendata],item,"-",date,".zip")
    if(url.exists(link) == TRUE){
      download.file(url = link,destfile = file,mode = "wb",...)
      if(unzip == TRUE){
        unzip(zipfile = file,exdir = "data/",overwrite = TRUE)
        unlink(file)
      }
    }else{
      stop("URL not found.")
    }
  }
}


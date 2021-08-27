#' Download files of the 'Portal da Transparencia'
#'
#' This function can be used to download all the files from a data set of the
#' 'Portal da Transparencia' of Brazil - \url{http://www.portaltransparencia.gov.br}.
#'
#' @param opendata A character or numeric that indicates a dataset selected for download.
#' See valid options in 'Details'.
#' @param destfile A character string with the name where the downloaded file is saved.
#' If missing, the file will be saved to the current directory.
#' @param filename File name to dataset. By default, the file name is the title of 'opendata'
#' with the 'reference' and '.zip' extension.
#' @param ... Others arguments of the \code{\link[utils:download.file]{download.file}} function.
#'
#' @details
#' The function downloads files available in the repository of transparency portal -
#' website of the federal government of Brazil on public transparency, with budgetary
#' data and government management. The data disclosed in the Portal come from various
#' sources of government information. See http://www.portaltransparencia.gov.br/.
#'
#' The function arguments are specifications about the data set to be downloaded.
#' 'opendata' is related to the content of the data, 'destfile' to the location to be saved
#' and 'filename' is the name of the file to be saved.
#' Other '...' arguments are related to the download.file function of the 'utils' package.
#'
#' It is suggested that the values for '...' be reported only if the default setting
#' does not work. See \code{\link[utils:download.file]{download.file}} for more
#' information about these arguments and proxy settings.
#'
#' Valid options for 'opendata' argument:
#'
#' \tabular{lllll}{
#' #' id \tab description  \tab opendata  \tab formatdate  \cr
#' 1 \tab Auxilio Emergencial  \tab auxilio-emergencial \tab yyyymm \cr
#' 2 \tab Bolsa familia pagamentos  \tab bolsa-familia-pagamentos \tab yyyymm \cr
#' 3 \tab Bolsa familia saques  \tab bolsa-familia-saques \tab yyyymm \cr
#' 4 \tab Benefício de Prestação Continuada  \tab bpc \tab yyyymm \cr
#' 5 \tab Garantia safra  \tab garantia-safra \tab yyyymm \cr
#' 6 \tab Erradicacao do trabalho infantil PETI  \tab peti \tab yyyymm \cr
#' 7 \tab Seguro defeso pescador artesanal  \tab seguro-defeso \tab yyyymm \cr
#' 8 \tab Cartao pagamento compras centralizadas  \tab cpcc \tab yyyymm \cr
#' 9 \tab Cartao pagamento da defesa civil CPDC  \tab cpdc \tab yyyymm \cr
#' 10 \tab Cartao pagamento governo federal CPGF  \tab cpgf \tab yyyymm \cr
#' 11 \tab Favorecidos PJ  \tab favorecidos-pj \tab yyyymm \cr
#' 12 \tab Convenios  \tab convenios \tab yyyymmdd \cr
#' 13 \tab Documentos empenho, liquidacao e pagamento  \tab despesas \tab yyyymmdd \cr
#' 14 \tab Execucao da despesa  \tab despesas-execucao \tab yyyymm \cr
#' 15 \tab Recursos transferidos  \tab transferencias \tab yyyymm \cr
#' 16 \tab Recebimento de recursos por favorecido  \tab despesas-favorecidos \tab yyyymm \cr
#' 17 \tab Emendas parlamentares  \tab emendas-parlamentares \tab UNICO \cr
#' 18 \tab Imoveis funcionais  \tab imoveis-funcionais-md \tab yyyymmdd \cr
#' 19 \tab Imoveis funcionais  \tab imoveis-funcionais-mre \tab yyyymmdd \cr
#' 20 \tab Imoveis funcionais  \tab imoveis-funcionais-pr \tab yyyymmdd \cr
#' 21 \tab Imoveis funcionais  \tab imoveis-funcionais-spu \tab yyyymmdd \cr
#' 22 \tab Contratacoes  \tab compras \tab yyyymm \cr
#' 23 \tab Licitacoes  \tab licitacoes \tab yyyymm \cr
#' 24 \tab Orcamento da despesa  \tab orcamento-despesa \tab yyyy \cr
#' 25 \tab Execucao da receita  \tab receitas \tab yyyy \cr
#' 26 \tab Empresas inidoneas e suspensas  \tab ceis \tab yyyymmdd \cr
#' 27 \tab Entidades sem fins lucrativos impedidas  \tab cepim \tab yyyymmdd \cr
#' 28 \tab Empresas punidas  \tab cnep \tab yyyymmdd \cr
#' 29 \tab Acordos de Leniencia  \tab acordos-leniencia \tab yyyymmdd \cr
#' 30 \tab Servidores militares ate 2019  \tab servidores-militares \tab yyyymm \cr
#' 31 \tab Servidores civis ate 2019  \tab servidores-civis \tab yyyymm \cr
#' 32 \tab Cadastro de expulsoes da administracao federal CEAF  \tab ceaf \tab yyyymmdd \cr
#' 33 \tab Pessoas expostas politicamente  \tab pep \tab yyyymm \cr
#' 34 \tab Viagens a servico  \tab viagens \tab yyyy
#' }
#'
#' @examples
#' potr_download_all(opendata = 22, reference = 2021)
#' potr_download_all(opendata = 22, reference = 2021, destfile = "~/")
#' potr_download_all(opendata = 22, reference = 2021, destfile = "~/", filename = "compras")
#' potr_download_all(opendata = "22", reference = "2021")
#' potr_download_all(opendata = "22", reference = "2021", destfile = "~/")
#' potr_download_all(opendata = "22", reference = "2021", destfile = "~/", filename = "compras")
#' potr_download_all(opendata = "compras", reference = "2021")
#' potr_download_all(opendata = "compras", reference = 2021, destfile = "~/")
#' potr_download_all(opendata = "compras", reference = 2021, destfile = "~/", filename = "compras")
#' @export

potr_download_all <- function(opendata, destfile, filename, limited_to, ...) {
  if (missing(opendata)){
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  if (any(opendata == potrdt$idname)) {
    potrdt <- potrdt[which(potrdt$idname == opendata), ]
  } else if (any(as.character(opendata) == potrdt$id)) {
    potrdt <- potrdt[potrdt$id == as.numeric(opendata), ]
  } else {
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  opendata <- unlist(strsplit(potrdt$dataset, split = "_"))[1]
  reference <- seq(from = as.Date("2013-01-01"), to = Sys.Date(), by = potrdt$by)
  reference <- substr(gsub(pattern = "-", replacement = "", x = reference), 1, nchar(potrdt$formatdate))
  if(!missing(limited_to)){
    limited_to <- as.numeric(limited_to)
    reference <- reference[(length(reference)-limited_to+1):length(reference)]
  }
  subitem <- ifelse(potrdt$subitem == "", "", paste0("_", potrdt$subitem))
  if (missing(filename)){
    filename <- potrdt$dataset
  } else if (grepl(pattern = ".zip*", x = filename)) {
    filename <- substr(filename, 1, nchar(filename)-4)
  }
  if (missing(destfile)) {
    destfile <- filename
  } else {
    if (grepl(pattern = "\\/*", x = destfile)){
      destfile <- paste0(destfile, filename)
    } else {
      destfile <- paste0(destfile, "/", filename)
      }
  }
  i = length(reference)
  file_dl <- paste0(destfile, "_", reference[i], ".zip")
  while (!i == 0) {
    link <- paste0(potrurl, opendata, "/", reference[i], subitem)
    file_dl <- paste0(destfile, "_", reference[i], ".zip")
    e=link
    try(download.file(url = link, destfile = file_dl, ...),silent = TRUE)
    i <- i - 1
  }
  invisible(link)
}

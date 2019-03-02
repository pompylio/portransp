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
#' @param download.file.mode  The mode with which to write the file. If download.file.mode
#' is not found and the operating system is windows, it will use the "wb".
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
#' id \tab description                                         \tab opendata                 \cr
#' 1  \tab Bolsa familia pagamentos                            \tab bolsa-familia-pagamentos \cr
#' 2  \tab Bolsa familia saques                                \tab bolsa-familia-saques     \cr
#' 3  \tab Erradicacao do trabalho infantil PETI               \tab peti                     \cr
#' 4  \tab Garantia safra                                      \tab garantia-safra           \cr
#' 5  \tab Seguro defeso pescador artesanal                    \tab seguro-defeso            \cr
#' 6  \tab Cartao pagamento compras centralizadas              \tab cpcc                     \cr
#' 7  \tab Cartao pagamento da defesa civil CPDC               \tab cpdc                     \cr
#' 8  \tab Cartao pagamento governo federal CPGF               \tab cpgf                     \cr
#' 9  \tab Convenios                                           \tab convenios                \cr
#' 10 \tab Documentos empenho, liquidacao e pagamento          \tab despesas                 \cr
#' 11 \tab Execucao da despesa                                 \tab despesas-execucao        \cr
#' 12 \tab Recursos transferidos                               \tab transferencias           \cr
#' 13 \tab Imoveis funcionais                                  \tab imoveis-funcionais_md    \cr
#' 14 \tab Imoveis funcionais                                  \tab imoveis-funcionais_mre   \cr
#' 15 \tab Imoveis funcionais                                  \tab imoveis-funcionais_pr    \cr
#' 16 \tab Imoveis funcionais                                  \tab imoveis-funcionais_spu   \cr
#' 17 \tab Contratacoes                                        \tab compras                  \cr
#' 18 \tab Licitacoes                                          \tab licitacoes               \cr
#' 19 \tab Orcamento da despesa                                \tab orcamento-despesa        \cr
#' 20 \tab Execucao da receita                                 \tab receitas                 \cr
#' 21 \tab Empresas inidoneas e suspensas                      \tab ceis                     \cr
#' 22 \tab Empresas punidas                                    \tab cnep                     \cr
#' 23 \tab Entidades sem fins lucrativos impedidas             \tab cepim                    \cr
#' 24 \tab Cadastro de expulsoes da administracao federal CEAF \tab ceaf                     \cr
#' 25 \tab Dirigentes de empresas                              \tab dirigentes               \cr
#' 26 \tab Servidores civis do executivo federal               \tab servidores_civis         \cr
#' 27 \tab Servidores militares do executivo federal           \tab servidores_militares     \cr
#' 28 \tab Viagens a servico                                   \tab viagens
#' }
#'
#' @examples
#' potr_download_all(opendata = 19)
#' potr_download_all(opendata = 19, destfile = "~/")
#' potr_download_all(opendata = 19, destfile = "~/", filename = "orcamento")
#' potr_download_all(opendata = "19")
#' potr_download_all(opendata = "19", destfile = "~/")
#' potr_download_all(opendata = "19", destfile = "~/", filename = "orcamento")
#' potr_download_all(opendata = "orcamento-despesa")
#' potr_download_all(opendata = "orcamento-despesa", destfile = "~/")
#' potr_download_all(opendata = "orcamento-despesa", destfile = "~/", filename = "orcamento")
#' @export
potr_download_all <- function(opendata, destfile, filename, download.file.mode, ...) {
  if (missing(opendata)){
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  if (any(opendata == potrdt$dataset)) {
    potrdt <- potrdt[which(potrdt$dataset == opendata), ]
  } else if (any(as.character(opendata) == potrdt$id)) {
    potrdt <- potrdt[potrdt$id == as.numeric(opendata), ]
  } else {
    stop("Valid input to 'opendata' and 'reference': ", potrms, call. = FALSE)}
  opendata <- unlist(strsplit(potrdt$dataset, split = "_"))[1]
  reference <- seq(from = as.Date("2013-01-01"), to = Sys.Date(), by = potrdt$by)
  reference <- substr(gsub(pattern = "-", replacement = "", x = reference), 1, nchar(potrdt$formatdate))
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
  if (missing(download.file.mode) && Sys.info()["sysname"] == "Windows"){
    download.file.mode <- "wb"
  }
  while (!i == 0) {
    link <- paste0(potrurl, opendata, "/", reference[i], subitem)
    file_dl <- paste0(destfile, "_", reference[i], ".zip")
    try(download.file(url = link, destfile = file_dl, mode = download.file.mode, ...), silent = TRUE)
    i <- i - 1
  }
  invisible(link)
}

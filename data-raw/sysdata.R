ptrdt <- data.frame(
  id = c("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16",
    "17","18","19","20","21","22","23","24","25","26","27","28"),
  opendata = c("orcamento-despesa", "despesas", "despesas-execucao",
    "transferencias", "cpgf", "cpcc", "cpdc", "receitas", "licitacoes",
    "compras", "convenios", "bolsa-familia-pagamentos", "bolsa-familia-saques",
    "garantia-safra", "seguro-defeso", "peti", "servidores_civis", "servidores_militares",
    "ceaf", "dirigentes", "ceis", "cepim", "cnep", "viagens",
    "imoveis-funcionais_mre", "imoveis-funcionais_spu", "imoveis-funcionais_md",
    "imoveis-funcionais_pr"),
  detail = c('','','','','','','','','','','','','','','','','Servidores',
    'Militares','','','','','','','MRE','SPU','MD','PR'),
  reference = c("yyyy", "yyyymmdd", "yyyymm", "yyyymm", "yyyymm", "yyyymm",
    "yyyymm", "yyyy", "yyyymm", "yyyymm", "yyyymmdd", "yyyymm", "yyyymm",
    "yyyy", "yyyymm", "yyyymm", "yyyymm", "yyyymm", "yyyymmdd", "yyyymm",
    "yyyymmdd", "yyyymmdd", "yyyymmdd", "yyyy", "yyyymmdd", "yyyymmdd",
    "yyyymmdd", "yyyymmdd"),
  stringsAsFactors = FALSE)

msgPtransp <-
  paste0(
    paste0("(", ptrdt$id, " or "),
    paste0(ptrdt$opendata,""),
    paste0(", ", ptrdt$reference,")"),
    collapse = " "
  )

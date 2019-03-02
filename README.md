# portransp
The 'portransp' is a set of functions to facilitate the download of data set available in the website of the federal government of Brazil - 
[Portal da Transparência](http://www.portaltransparencia.gov.br/).

## Installation
```{r eval = FALSE}
# The development version from GitHub
# install.packages("devtools")
devtools::install_github("pompylio/portransp")
```

## Usage
* potr_download() used to download a dataset from the 'Portal da Transparencia'
* potr_download_all() used to download all the files from a data set of the 'Portal da Transparencia' 
* potr_download_last() used to download the latest data set from the 'Portal da Transparencia'

```{r eval = FALSE}
library(portransp)

#### potr_download ####
# numeric 'opendata' | yyyymm 'reference' | temporary directory 'destfile'
potr_download(opendata = 11, reference = 201812, destfile = tempdir())

# character 'opendata' | yyyy 'reference' | other directory 'destfile'
potr_download(opendata = "receitas", reference = 2018, destfile = tempdir())

#### potr_download_all ####
# character 'opendata' | temporary directory 'destfile'
potr_download_all(opendata = "20", destfile = tempdir())

# character 'opendata' | other directory 'destfile'
potr_download_all(opendata = "receitas", destfile = "~/")

# character 'opendata' | other directory 'destfile'
potr_download_all(opendata = "receitas", destfile = "~/")

#### potr_download_last ####
# numeric 'opendata' | temporary directory 'destfile'
potr_download_last(opendata = 10, destfile = tempdir())

# character 'opendata' | other directory 'destfile' | other 'filename'",
potr_download_last(opendata = "despesas", destfile = "~/", filename = "despesas_last"))
```
Valid options for 'opendata' and 'reference' arguments:

|description                                         |opendata                 |reference       |
|----------------------------------------------------|-------------------------|----------------|
|Bolsa familia pagamentos                            |bolsa-familia-pagamentos |yyyymm          |
|Bolsa familia saques                                |bolsa-familia-saques     |yyyymm          |
|Erradicacao do trabalho infantil PETI               |peti                     |yyyymm          |
|Garantia safra                                      |garantia-safra           |yyyymm          |
|Seguro defeso pescador artesanal                    |seguro-defeso            |yyyymm          |
|Cartao pagamento compras centralizadas              |cpcc                     |yyyymm          |
|Cartao pagamento da defesa civil CPDC               |cpdc                     |yyyymm          |
|Cartao pagamento governo federal CPGF               |cpgf                     |yyyymm          |
|Convenios                                           |convenios                |yyyymmdd        |
|Documentos empenho, liquidacao e pagamento          |despesas                 |yyyymmdd        |
|Execucao da despesa                                 |despesas-execucao        |yyyymm          |
|Recursos transferidos                               |transferencias           |yyyymm          |
|Imoveis funcionais                                  |imoveis-funcionais_md    |yyyymmdd        |
|Imoveis funcionais                                  |imoveis-funcionais_mre   |yyyymmdd        |
|Imoveis funcionais                                  |imoveis-funcionais_pr    |yyyymmdd        |
|Imoveis funcionais                                  |imoveis-funcionais_spu   |yyyymmdd        |
|Contratacoes                                        |compras                  |yyyymm          |
|Licitacoes                                          |licitacoes               |yyyymm          |
|Orcamento da despesa                                |orcamento-despesa        |yyyy            |
|Execucao da receita                                 |receitas                 |yyyy            |
|Empresas inidoneas e suspensas                      |ceis                     |yyyymmdd        |
|Empresas punidas                                    |cnep                     |yyyymmdd        |
|Entidades sem fins lucrativos impedidas             |cepim                    |yyyymmdd        |
|Cadastro de expulsoes da administracao federal CEAF |ceaf                     |yyyymmdd        |
|Dirigentes de empresas                              |dirigentes               |yyyymm          |
|Servidores civis do executivo federal               |servidores_civis         |yyyymm          |
|Servidores militares do executivo federal           |servidores_militares     |yyyymm          |
|Viagens a servico                                   |viagens                  |yyyy            |

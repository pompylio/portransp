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

|description                                         |id|opendata                 |reference       |
|----------------------------------------------------|--|-------------------------|----------------|
|Bolsa familia pagamentos                            |1 |bolsa-familia-pagamentos |yyyymm          |
|Bolsa familia saques                                |2 |bolsa-familia-saques     |yyyymm          |
|Erradicacao do trabalho infantil PETI               |3 |peti                     |yyyymm          |
|Garantia safra                                      |4 |garantia-safra           |yyyymm          |
|Seguro defeso pescador artesanal                    |5 |seguro-defeso            |yyyymm          |
|Cartao pagamento compras centralizadas              |6 |cpcc                     |yyyymm          |
|Cartao pagamento da defesa civil CPDC               |7 |cpdc                     |yyyymm          |
|Cartao pagamento governo federal CPGF               |8 |cpgf                     |yyyymm          |
|Convenios                                           |9 |convenios                |yyyymmdd        |
|Documentos empenho, liquidacao e pagamento          |10|despesas                 |yyyymmdd        |
|Execucao da despesa                                 |11|despesas-execucao        |yyyymm          |
|Recursos transferidos                               |12|transferencias           |yyyymm          |
|Imoveis funcionais                                  |13|imoveis-funcionais_md    |yyyymmdd        |
|Imoveis funcionais                                  |14|imoveis-funcionais_mre   |yyyymmdd        |
|Imoveis funcionais                                  |15|imoveis-funcionais_pr    |yyyymmdd        |
|Imoveis funcionais                                  |16|imoveis-funcionais_spu   |yyyymmdd        |
|Contratacoes                                        |17|compras                  |yyyymm          |
|Licitacoes                                          |18|licitacoes               |yyyymm          |
|Orcamento da despesa                                |19|orcamento-despesa        |yyyy            |
|Execucao da receita                                 |20|receitas                 |yyyy            |
|Empresas inidoneas e suspensas                      |21|ceis                     |yyyymmdd        |
|Empresas punidas                                    |22|cnep                     |yyyymmdd        |
|Entidades sem fins lucrativos impedidas             |23|cepim                    |yyyymmdd        |
|Cadastro de expulsoes da administracao federal CEAF |24|ceaf                     |yyyymmdd        |
|Dirigentes de empresas                              |25|dirigentes               |yyyymm          |
|Servidores civis do executivo federal               |26|servidores_civis         |yyyymm          |
|Servidores militares do executivo federal           |27|servidores_militares     |yyyymm          |
|Viagens a servico                                   |28|viagens                  |yyyy            |

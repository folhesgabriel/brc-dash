###################
# global.R
# 
# Anything you want shared between your ui and server, define here.
##################
library(dplyr)
library(stringr)
library(sf)
library(htmltools)
library(leaflet)
library(leaflet.extras)
library(shinydashboard)
library(shinyBS)
library(bigrquery)
library(geobr)
library(scales)


##### Import data from BigQuery #####
#-- set vars
credentials_path <- 'credentials_dezoomcamp.json'
billing_project <- 'de-zoomcamp-2k24'

#-- Set credentials path
bigrquery::bq_auth(credentials_path)

#-- query
query <- "WITH operacao as (
  SELECT 
  operacao.sigla_uf,
  complemento.id_municipio,
  operacao.plano_safra_emissao,
  operacao.plano_safra_vencimento,
  operacao.id_referencia_bacen,
  operacao.numero_ordem,
  operacao.valor_parcela_credito,
  operacao.taxa_juro,
  FROM `de-zoomcamp-2k24.test_brazil_rural_credit.microdados_operacao` operacao
  INNER JOIN `de-zoomcamp-2k24.test_brazil_rural_credit.recurso_publico_complemento_operacao` complemento
  ON operacao.numero_ordem = complemento.numero_ordem AND operacao.id_referencia_bacen = complemento.id_referencia_bacen
  WHERE  operacao.plano_safra_emissao = '2022/2023'
)


select
plano_safra_emissao,
id_municipio,
ROUND(SUM(valor_parcela_credito),2) sum_rural_credit_loans
FROM operacao
GROUP BY 1,2
ORDER BY 1,2
DESC"



#-- process query & download data
data <- bigrquery::bq_project_query(billing_project, query)
df <- bigrquery::bq_table_download(data) %>% 
  mutate(formatted_loans = dollar(sum_rural_credit_loans, prefix = "R$", big.mark = ".", decimal.mark = ",", accuracy = 0.01)
)


#-- read municipalities
df_mun <- geobr::read_municipality() %>% 
  dplyr::mutate(code_muni = as.character(code_muni)
  ) %>% 
  dplyr::rename(id_municipio = code_muni,
                geometry = geom)


df_mun <- df %>% 
  dplyr::left_join(df_mun,
            by = 'id_municipio') 


df <- sf::st_as_sf(df_mun)


rm(df_mun, data)


#- build bins and legend
quantiles_legend <- quantile(df$sum_rural_credit_loans, probs = c(0, 0.30, 0.60, 0.90, 0.95, 1), na.rm = TRUE)
bins <- c(0, quantiles_legend[2], quantiles_legend[3], quantiles_legend[4],quantiles_legend[5], Inf)
pal <- colorBin("Reds", domain = df$sum_rural_credit_loans,bins = bins)


brazil_base_map <- geobr::read_country()
  

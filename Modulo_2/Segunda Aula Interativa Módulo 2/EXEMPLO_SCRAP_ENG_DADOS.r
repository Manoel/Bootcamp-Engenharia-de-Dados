library(twitteR)
library(ROAuth)
library(tm)
library("stringi")
library(wordcloud)
library(syuzhet)


setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- searchTwitter("Paralimpicos", n=1000, lang="pt")
dados <- twListToDF(tweets)
dim(dados)  
corpus <- Corpus(VectorSource(dados$text))
corpus <- tm_map(corpus, tolower)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords('portuguese'))
tdm <- as.matrix((TermDocumentMatrix(corpus, control=list(stemming = FALSE))))
dim(tdm)
fre <- rowSums(tdm)
fre <- sort(fre,decreasing = TRUE)
head(fre)
wordcloud(corpus, min.freq = 30, max.words = 30, random.order = FALSE,rot.per = 0.35, colors=brewer.pal(8,"Dark2"))
s<- get_nrc_sentiment(dados$text)
barplot(colSums(s), las=2, col = rainbow(10), ylab= "Contagem", 
        main = "Sentimentos em relaC'C#o a CPI" )
-----------------------------------------------------------

library(rvest)
library(dplyr)
library(stringi)
library(ramify)
url = 'https://search.vivalocal.com/auto-veiculo-usado/belo-horizonte?lb=new&search=1&start_field=1&sp_common_year%5Bstart%5D=&sp_common_year%5Bend%5D=&sp_vehicules_mileage%5Bstart%5D=&sp_vehicules_mileage%5Bend%5D=&keywords=&cat_1=40&geosearch_text=Belo+Horizonte+MG&searchGeoId=53&sp_common_price%5Bstart%5D=&sp_common_price%5Bend%5D='
site_carro <- read_html(url)


#recupera a descrigco do anzncio..
nome_carro <- site_carro %>%
  html_nodes(".clad__title") %>%
  html_text()
km_carro <- site_carro %>%
  html_nodes(".clad__spec") %>%
  html_text()
preco_carro <- site_carro %>%
  html_nodes(".clad__price") %>%
  html_text()

geo_local <- site_carro %>%
  html_nodes(".clad__first_geo") %>%
  html_text()

#criando um data frame

base = data.frame(nome_carro,preco_carro,geo_local, km_carro, stringsAsFactors = FALSE)

#limpando os dados
base$nome_carro = gsub('\\.', '', base$nome_carro)
base$preco_carro = chartr("R$","  ", base$preco)
base$preco_carro = gsub('\\s+', '', base$preco)
dat <- lapply(km_carro, as.character)
temp <- stri_list2matrix(dat, byrow = TRUE)

-----------------------------------------------------
library("rvest")
url <- "https://www.quintoandar.com.br/comprar/imovel/estoril-belo-horizonte-mg-brasil/"
conteudo <- read_html(url)  #pacote rvest

dft = data.frame()

apto <- conteudo %>% 
  html_nodes(".QJYUe") %>%
  html_text()


tipo <- conteudo %>% 
  html_nodes(".hyCyhO") %>%
  html_text()


rua <- conteudo %>% 
html_nodes(".eogEVo") %>%
html_text()
rua = as.matrix(unlist(rua))

bairrocidade <- conteudo %>% 
  html_nodes(".ebXdxg") %>%
  html_text()
bairrocidade = as.matrix(unlist(bairrocidade))


carac <- conteudo %>% 
  html_nodes(".ldRYl") %>%
  html_text()
carac = as.matrix(unlist(carac))

preco <- conteudo %>% 
  html_nodes(".gVbDUW") %>%
  html_text()
preco = as.matrix(unlist(preco))

dft <- cbind(tipo, rua, carac, preco)
-----------------------------------------------

#conexão com o MySQL
library(RMySQL)
con = dbConnect(RMySQL::MySQL(),user="root", 
                password = "novapass", dbname="dbsacihdev-1")


#Disponibilização do serviço

library(plumber)
#API <- plumb('historico.R')
#API <- plumb('cirurgia por profissional.R')
API <- plumb('servicosR.R')
#source("conexao.r")

API$run(host = '0.0.0.0',
        port = 3001,
        swagger = T)
		
#Exemplo de um serviço

#* @get /historicopaciente
#* @serializer contentType list(type="application/pdf")

function(res, numeroProntuario ,numeroInternacao){
  filename <- tempfile()
  filename <- rmarkdown::render("historicopacientev4.Rmd", output_format = "pdf_document",
                           params = list( pront = numeroProntuario, numint = numeroInternacao)) 
  res$setHeader("Content-Disposition", paste0("attachment; filename=", basename(filename)))
  bin =  readBin(filename, "raw", n=file.info(filename)$size)
}

#Exemplo de query
dadosinternacaoData <- function(datInicio, datFim) {
  rs = dbSendQuery(con, paste(" select i.id, i.numero, p.numeroProntuario, i.pacienteNome, 
  p.sexo, v.descricao, i.pacienteIdade, i.pacienteTipoIdade,  
  date_format(i.dataAdmissao, '%d/%m/%Y') as dataAdmissao, 
  date_format(i.dataSaida, '%d/%m/%Y') as dataSaida, 
  i.tipoSaida
  from Paciente p, Internacao i, CdVinculo v
  where p.id = i.pacienteId
  and v.id = i.cdvinculoId and i.dataAdmissao between '2020/10/23' and '2020/10/23'
  order by i.dataAdmissao"))
  data = fetch(rs, n=-1)
  
  dados <- list(idInt = data$id,
                numeroInternacao = data$numero,
                numeroProntuario = data$numeroProntuario,
                nome = data$pacienteNome,
                sexo = data$sexo,
                descricao = data$descricao,
                idade = data$pacienteIdade,
                tipoIdade = data$pacienteTipoIdade,
                dataAdmissao = data$dataAdmissao,
                dataSaida = data$dataSaida,
                tipoSaida = data$tipoSaida
  )
  return (dados)
}
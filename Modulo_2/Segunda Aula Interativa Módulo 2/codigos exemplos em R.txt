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

------------------------------------------------
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

------------------------------------------------
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








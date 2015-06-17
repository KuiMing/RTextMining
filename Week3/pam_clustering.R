

GData <- unlist(GpostDf$Text)
HPData <- unlist(HPpostDf$Text)
AllData <- c(GData, HPData)


library(jiebaR)
mixseg = worker()

messages = unlist(allData)

segRes = lapply(messages,function(msg) mixseg <= msg)
paste(segRes[[1]],collapse = " ")


library(tm)
tmWordsVec = sapply(segRes,function(ws) paste(ws,collapse = " "))
corpus <- Corpus(VectorSource(tmWordsVec))
tdm = TermDocumentMatrix(corpus,control = list(wordLengths = c(1, Inf)))
inspect(tdm)

dtm <- t(as.matrix(tdm))

# install.packages("fpc")
library(fpc)
pamResult <- pamk(dtm, metric="manhattan")
(k <- pamResult$nc)
pamResult <- pamResult$pamobject
for (i in 1:k) {
  cat(paste("cluster", i, ": "))
  cat(colnames(pamResult$medoids)[which(pamResult$medoids[i,]==1)], "\n")
}
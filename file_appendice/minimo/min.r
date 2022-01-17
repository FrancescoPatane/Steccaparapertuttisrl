#lettura file csv
#si presume che il file sia posto nella stessa cartella
ordini = read.csv("Ordini.csv", header = FALSE, sep = ",")

#estrazione vendite
vendite = ordini[ordini[1] == "BUONO.PRELIEVO" | ordini[1] == "FATTURA",]

#isola mese e anno nel campo data
vendite[2] = substr(vendite[,2],1,6)

#somma vendite di ogni mese di ogni anno
totali_annomese = aggregate(vendite[,3],by=vendite[2],FUN=sum)

#divisione anno e mese in colonne distinte
totali_annomese[3] = substr(totali_annomese[,1], 5, 6)
totali_annomese[1] = substr(totali_annomese[,1], 1, 4)

#distinct degli anni trattati
unique(totali_annomese[1]) -> anni

#lista contenente elementi "aaaa MM", ovvero coppie anno-mese con maggiore vendita
min_anno_mese = lapply(anni[,], function(year){paste(year, totali_annomese[grepl(year, totali_annomese[,1]),][which.min(totali_annomese[grepl(year, totali_annomese[,1]),2]),][,3])})

#mostra a video ed esporta come txt
cat("Anno Mese con minor vendita\n")
tmp<-c("Anno Mese con minor vendita\n")
for(i in min_anno_mese) {
	cat(i,"\n")
	tmp = append(tmp,i)
}
cat(paste(tmp, collapse="\n"), file = "minmese.txt")

#rendering grafico
xaxis = c()
yaxis = c()
jpeg('minmese.jpg')
for(i in min_anno_mese) {
  tmp = unlist(strsplit(i[[1]], ' '))
  xaxis = append(xaxis, as.numeric(tmp[1])) 
  yaxis = append(yaxis, as.numeric(tmp[2]))
  }
plot(xaxis, yaxis, main = "Mese minor vendita", ylab = "Mesi", xlab = "Anni", pch=19, ylim=c(0,12))
dev.off()
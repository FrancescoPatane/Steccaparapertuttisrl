#lettura file csv
#si presume che il file sia posto nella stessa cartella
ordini = read.csv("Ordini.csv", header = FALSE, sep = ",")

#estrazione vendite
vendite = ordini[ordini[1] == "BUONO.PRELIEVO" | ordini[1] == "FATTURA",]

#isola mese e anno nel campo data
vendite[2] = substr(vendite[,2],1,6)

#calcolo media per anno_mese
media_annomese = aggregate(vendite[,3],by=vendite[2],FUN=function(x) {round(mean(x), digits=2)})

#mostra a video ed esporta come csv
colnames(media_annomese) <- c('Mese','Media vendite')
print(media_annomese)
write.csv(media_annomese,"mediamesi.csv", row.names = FALSE)

#rendering grafico
jpeg('mediamesi.jpg')
barplot(unlist(media_annomese [2]), main = "Media vendite per mese", xlab="mese", ylab="media", names.arg = unlist(media_annomese [1]))
dev.off()
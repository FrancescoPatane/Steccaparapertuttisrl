#lettura file csv
#si presume che il file sia posto nella stessa cartella
ordini = read.csv("Ordini.csv", header = FALSE, sep = ",")

#estrazione vendite
vendite = ordini[ordini[1] == "BUONO.PRELIEVO" | ordini[1] == "FATTURA",]

#isola mese e anno nel campo data
vendite[2] = substr(vendite[,2],1,6)

#calcolo varianza per anno_mese
varianza_annomese = aggregate(vendite[,3],by=vendite[2],FUN=var)

#mostra a video ed esporta come csv
colnames(varianza_annomese) <- c('Mese','Varianza vendite')
print(varianza_annomese)
write.csv(varianza_annomese,"varianzamesi.csv", row.names = FALSE)

#rendering grafico
jpeg('varianzamesi.jpg')
barplot(unlist(varianza_annomese[2]), main = "Varianza vendite per mese", xlab="mese", ylab="varianza", names.arg = unlist(varianza_annomese[1]))
dev.off()
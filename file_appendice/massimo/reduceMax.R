#! /usr/bin/Rscript

#connessione a standard input
con <- file("stdin", open = "r")

# prepara ambiente per variabili
mesi <- new.env(hash = TRUE)

#ciclo su ogni riga
while (length(line <- readLines(con, n = 1, ok = TRUE, warn = FALSE)) > 0) {
    # operazione di split: vettore componenti della riga
    kv <- unlist(strsplit(line, "-"))
    # mese incontrato
    k<-substr(kv[1], 1, 6)
    # occorrenze di w: sappiamo sarà sempre 1, in questo esempio
    v<-kv[2]
    # aggiornamento conteggio
    if (exists(k, envir=mesi)) {
        # se parola già incontrata aumento l'occorrenza
	tmp <- get(k, envir=mesi)
        assign(k, (tmp + as.numeric(v)), envir=mesi)
    }
    # se non incontrata ancora, inizializzo variabile nell'ambiente
    else {
    	assign(k, as.numeric(v), envir=mesi)
    }
    
}
# chiudo connessione con standard input
close(con)

#env to named list
lmesi = as.list(mesi)
lanni = unique(unlist(substr(names(lmesi), 1, 4)))

for (a in lanni){
    #associo a ogni anno nella lista il mese con maggior vendita
    annomese = names(lmesi[grepl(paste("^",a,sep=""), names(lmesi))])[which.max(lmesi[grepl(paste("^",a,sep=""), names(lmesi))])]
    cat(substr(annomese, 1, 4), substr(annomese, 5, 6), sep = "\t", "\n")
}


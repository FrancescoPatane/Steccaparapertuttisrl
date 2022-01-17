#! /usr/bin/Rscript

#connessione a standard input
con <- file("stdin", open = "r")

# prepara ambiente per variabili
# (yyyMM, [vendita1, vendita2, ...])
anno_mese <- new.env(hash = TRUE)


#ciclo su ogni riga
while (length(line <- readLines(con, n = 1, ok = TRUE, warn = FALSE)) > 0) {
    # operazione di split: vettore componenti della riga
    kv <- unlist(strsplit(line, "-"))
    # isolo il mese incontrato nella forma yyyyMM
    k<-substr(kv[1], 1, 6)
    v<-kv[2]
    # aggiornamento somma vendite singoli giorni del mese
    if (exists(k, envir=anno_mese)) {
        # se mese già incontrata aggiungo il valore
	tmp <- get(k, envir=anno_mese);
        assign(k, append(tmp, as.numeric(v)), envir=anno_mese)
    }
    # se k non incontrata ancora, inizializzo variabile mese nell'ambiente
    else {
    	assign(k, c(as.numeric(v)), envir=anno_mese)
    }
    
}
# chiudo connessione con standard input
close(con)



#calcolo media di ogni mese 
for (m in ls(anno_mese, all = TRUE)){
    cat(m, round(mean(get(m, envir = anno_mese)), digits = 2), sep = "\t")
    cat("\n")
}




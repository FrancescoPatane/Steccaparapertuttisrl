#!/usr/bin/Rscript

# connessione con standard input
con <- file("stdin", open = "r")

# ciclo riga per riga sui file in input
while (length(line <- readLines(con, n = 1, ok = TRUE, warn = FALSE)) > 0) {

   # split rig csv, incluse soltato fatture e buoni prelievo
   data = unlist(strsplit(line, ","))
   if(data[1]=="FATTURA" || data[1]=="BUONO.PRELIEVO"){
        cat(data[2], data[3], sep="-")
        cat("\n")
   }
}

# chiusura dello standard input
close(con)

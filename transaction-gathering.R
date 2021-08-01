

rm(list = ls())

library(jsonlite)


pay.into.address.cash.addr<- "qp9eqx7dxc47cgsunvz4pm53wkwskkk7ycys04gfza"
pay.into.address.legacy <- "17tYKEFAXrCwSVX3QkxWiCuG6mC3p48HYx"

pay.out.address.cash.addr<- "qqde7q0f0zcquthhyqm3f5frsszhc2v48swuveml7y"
pay.out.address.legacy <- "13X3jDJHUdMLRbuY4oPDVFbzsFLLgEKUPi"



all.tx <- jsonlite::fromJSON(paste0("https://explorer.api.bitcoin.com/bch/v1/addrs/", 
  pay.into.address.cash.addr, "/txs?from=0&to=1000") )

all.tx.ls.df <- all.tx$items
# Not a "real" dataframe since some columns contain lists
all.tx.ls.df <- all.tx.ls.df[rev(seq_len(nrow(all.tx.ls.df))), ]
# Reverse so earliest TX at the top
tx.ls <- list()

for ( i in seq_len(nrow(all.tx.ls.df))) {
  
  single.tx <- all.tx.ls.df[i, ] 
  
  vin.index <- unlist(single.tx$vin[[1]]$addr) %in% 
    c(pay.into.address.legacy, pay.into.address.cash.addr) 
  
  if (any(vin.index)) { next } # {cat("PROBLEM: ", i, "\n"); }
  
  vout.index <- unlist(single.tx$vout[[1]]$scriptPubKey$addresses) %in% 
    c(pay.into.address.legacy, pay.into.address.cash.addr) 
  
  if (all(! vout.index)) {next}
  
  
  tx.amount <- as.numeric(single.tx$vout[[1]]$value[vout.index])
  tx.time <- as.POSIXct(min(
    single.tx$blocktime, 
    single.tx$time,
    #single.tx$firstSeenTime, 
    na.rm = TRUE),
    origin = "1970-01-01")
  tx.ls[[i]] <- data.frame(tx.time, tx.amount, tx.id = single.tx$txid,
    payin.addrs = paste0(unlist(single.tx$vin[[1]]$addr), collapse = "|"), stringsAsFactors = FALSE)
  
  
}


tx.df <- do.call(rbind, tx.ls)
tx.df$tx.amount <- as.numeric(tx.df$tx.amount)

tx.df <- tx.df[order(tx.df$tx.time), ]

tx.df$tx.amount.cumsum <- cumsum(tx.df$tx.amount)


payin.tx.df <- tx.df



all.tx <- jsonlite::fromJSON(paste0("https://explorer.api.bitcoin.com/bch/v1/addrs/", 
  pay.out.address.cash.addr, "/txs?from=0&to=1000") )

all.tx.ls.df <- all.tx$items
# not a "real" dataframe since some columns contain lists
all.tx.ls.df <- all.tx.ls.df[rev(seq_len(nrow(all.tx.ls.df))), ]
# Reverse so earliest TX at the top
tx.ls <- list()

for ( i in seq_len(nrow(all.tx.ls.df))) {
  
  single.tx <- all.tx.ls.df[i, ] 
  
  vin.index.check <- unlist(single.tx$vin[[1]]$addr) %in% 
    c(pay.out.address.legacy, pay.out.address.cash.addr)
  
  if (all(! vin.index.check)) {next}
  
  vout.index <-
    ! (unlist(single.tx$vout[[1]]$scriptPubKey$addresses) %in% 
        c(pay.out.address.legacy, pay.out.address.cash.addr) )
  
  if (all(! vout.index)) {next}
  
  if ( ! all(unlist(single.tx$vout[[1]]$scriptPubKey$addresses[vout.index]) %in% 
      unlist(strsplit( payin.tx.df$payin.addrs, "|", fixed = TRUE )  ) ) ) { 
    stop("Payout not to a paying-in address.") 
  }
  
  tx.amount <- as.numeric(single.tx$vout[[1]]$value[vout.index])
  tx.time <- as.POSIXct(min(
    single.tx$blocktime, 
    single.tx$time, 
    #  single.tx$firstSeenTime, 
    na.rm = TRUE),
    origin = "1970-01-01")
  
  player.receive.address <- setdiff(unlist(single.tx$vout[[1]]$scriptPubKey$addresses), 
    c(pay.out.address.legacy, pay.out.address.cash.addr) )
  
  tx.ls[[i]] <- data.frame(tx.time, tx.amount, tx.id = single.tx$txid,
    payout.addrs = paste0(player.receive.address, collapse = "|"), stringsAsFactors = FALSE)
  
}

tx.df <- do.call(rbind, tx.ls)

tx.df$tx.amount <- as.numeric(tx.df$tx.amount)

tx.df <- tx.df[order(tx.df$tx.time), ]

tx.df$tx.amount.cumsum <- cumsum(tx.df$tx.amount)


payout.tx.df <- tx.df

table(nchar(payout.tx.df$payout.addrs))




payin.tx.df$payout.threshold.reached.payin.number <- NA_real_
payin.tx.df$payout.threshold.reached.payin.time <- as.POSIXct(NA)

for ( i in seq_len(nrow(payin.tx.df))) {
  
  threshold.reached.ind <- which(payin.tx.df$tx.amount.cumsum >= 2 * payin.tx.df$tx.amount.cumsum[i] )
  
  if (length(threshold.reached.ind) == 0) { next }
  
  threshold.reached.ind <- min(threshold.reached.ind)
  
  payin.tx.df$payout.threshold.reached.payin.number[i] <- threshold.reached.ind
  payin.tx.df$payout.threshold.reached.payin.time[i] <- 
    payin.tx.df$tx.time[threshold.reached.ind]
}



payout.tx.df$tx.amount.scaled <- payout.tx.df$tx.amount * (1/0.9)
payout.tx.df$tx.amount.scaled.cumsum <- payout.tx.df$tx.amount.cumsum * (1/0.9)
payin.tx.df$PAYOUT_tx.id <- NA

payout.tx.df.to.elim <- payout.tx.df

for ( i in seq_len(nrow(payin.tx.df))) {
  
  payout.addrs.temp <- strsplit(payin.tx.df$payin.addrs[i], "|", fixed = TRUE)[[1]]
  payout.addrs.temp <- intersect(strsplit(payin.tx.df$payin.addrs[i], "|", fixed = TRUE)[[1]], 
    payout.tx.df.to.elim$payout.addrs)
  
  payout.tx.df.subset <- payout.tx.df.to.elim[payout.tx.df.to.elim$payout.addrs %in% payout.addrs.temp, , drop = FALSE]
  payout.tx.df.subset <- payout.tx.df.subset[payout.tx.df.subset$tx.time >=  payin.tx.df$tx.time[i], , drop = FALSE]
  if (nrow(payout.tx.df.subset) == 0) { next }
  print(abs( payout.tx.df.subset$tx.amount.scaled - 2 * payin.tx.df$tx.amount[i] ))
  if ( all(abs( payout.tx.df.subset$tx.amount.scaled - 2 * payin.tx.df$tx.amount[i] ) > 2.222222e-05 * 2)) {
    next
    # 2.222222e-05 is most common floating point error amount in the data, so double it
  }
  payin.tx.df$PAYOUT_tx.id[i] <- 
    payout.tx.df.subset$tx.id[which.min(abs( payout.tx.df.subset$tx.amount.scaled - payin.tx.df$tx.amount[i] ))]
  
  payout.tx.df.to.elim <- payout.tx.df.to.elim[payout.tx.df.to.elim$tx.id != payin.tx.df$PAYOUT_tx.id[i], ]
  
}

payin.tx.df$PAYOUT_tx.id[payin.tx.df$tx.id == "9d8eb60adfc9371090b5dc9c85f376869f933d3571ef35e73e19dfec0a2784c4"] <- NA
#  9d8eb60adfc9371090b5dc9c85f376869f933d3571ef35e73e19dfec0a2784c4 is mismatched for some reason



payout.tx.df.to.merge <- payout.tx.df
colnames(payout.tx.df.to.merge) <- paste0("PAYOUT_", colnames(payout.tx.df.to.merge))

payin.tx.df$sort.id <- seq_len(nrow(payin.tx.df))

payin.payout.tx.df <- merge(payin.tx.df, payout.tx.df.to.merge, all.x = TRUE)
payin.payout.tx.df <- payin.payout.tx.df[order(payin.payout.tx.df$sort.id), ]

payin.payout.tx.df$payout.threshold.reached.payin.payout.time.diff <- NA
payin.payout.tx.df$payout.threshold.reached.payin.payout.time.diff <- 
  difftime(payin.payout.tx.df$PAYOUT_tx.time, payin.payout.tx.df$payout.threshold.reached.payin.time, units = "hours")

payin.payout.tx.df$payout.threshold.reached.payin.payout.time.diff.hours <- 
  as.numeric(payin.payout.tx.df$payout.threshold.reached.payin.payout.time.diff )
# This is in hours


last.paid.out.ind <- max(which(!is.na(payin.payout.tx.df$PAYOUT_tx.id)))

unpaid.df <- payin.payout.tx.df[(last.paid.out.ind + 1):nrow(payin.payout.tx.df), ]
paid.df <- payin.payout.tx.df[1:last.paid.out.ind, ]





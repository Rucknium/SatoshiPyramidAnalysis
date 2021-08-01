

mean(1 - is.na(paid.df$PAYOUT_tx.id))
# Successfully matched 96 percent of deposits



summary(payin.payout.tx.df$payout.threshold.reached.payin.payout.time.diff.hours)
mean(payin.payout.tx.df$payout.threshold.reached.payin.payout.time.diff.hours <= 12, na.rm = TRUE)

nrow(payin.tx.df)
nrow(payout.tx.df)

sum(payin.tx.df$tx.amount)
sum(payout.tx.df$tx.amount)

summary(payin.tx.df$tx.amount)

nrow(unpaid.df)
sum(unpaid.df$tx.amount)
summary(unpaid.df$tx.amount)


sum(paid.df$tx.amount * 0.10)
# Total Satoshi Pyramid operator fees




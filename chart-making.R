





png("charts/adjusted-payout-full-timeline-not-log.png", width = 600, height = 600)

plot.xlim <- range(payin.tx.df$tx.time)
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid",
  sub = "Payouts scaled by 1/0.9 to account for operator fee",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.scaled.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("bottomright", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()





png("charts/adjusted-payout-full-timeline-log.png", width = 600, height = 600)

plot.xlim <- range(payin.tx.df$tx.time)
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid\nLog-scale Y axis",
  sub = "Payouts scaled by 1/0.9 to account for operator fee",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n", log = "y")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.scaled.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n", log = "y")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("bottomright", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()




png("charts/adjusted-payout-early-timeline-not-log.png", width = 600, height = 600)

plot.xlim <- c(min(payin.tx.df$tx.time), as.POSIXct("2021-06-05"))
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid\nEarly game",
  sub = "Payouts scaled by 1/0.9 to account for operator fee",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.scaled.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("topleft", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()





png("charts/adjusted-payout-early-timeline-log.png", width = 600, height = 600)

plot.xlim <- c(min(payin.tx.df$tx.time), as.POSIXct("2021-06-05"))
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid\nLog-scale Y axis, early game",
  sub = "Payouts scaled by 1/0.9 to account for operator fee",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n", log = "y")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.scaled.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n", log = "y")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("bottomright", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()






png("charts/nominal-payout-full-timeline-not-log.png", width = 600, height = 600)

plot.xlim <- range(payin.tx.df$tx.time)
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("bottomright", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()




png("charts/nominal-payout-full-timeline-log.png", width = 600, height = 600)

plot.xlim <- range(payin.tx.df$tx.time)
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid\nLog-scale Y axis",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n", log = "y")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n", log = "y")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("bottomright", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()




png("charts/nominal-payout-early-timeline-not-log.png", width = 600, height = 600)

plot.xlim <- c(min(payin.tx.df$tx.time), as.POSIXct("2021-06-05"))
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid\nEarly game",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("topleft", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()




png("charts/nominal-payout-early-timeline-log.png", width = 600, height = 600)

plot.xlim <- c(min(payin.tx.df$tx.time), as.POSIXct("2021-06-05"))
plot.ylim <- range(payin.tx.df$tx.amount.cumsum)
plot(payin.tx.df$tx.time, payin.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "",
  main = "Deposits into and payouts from Satoshi Pyramid\nLog-scale Y axis",
  xlim = plot.xlim, ylim = plot.ylim, col = "red", xaxt = "n", yaxt = "n", log = "y")
par(new = TRUE)
plot(payout.tx.df$tx.time, payout.tx.df$tx.amount.cumsum,  type = "s", xlab = "", ylab = "Total BCH",
  xlim = plot.xlim, ylim = plot.ylim, col = "green", xaxt = "n", log = "y")
axis.POSIXct(1, at = seq(min(payin.tx.df$tx.time), max(payin.tx.df$tx.time), by="days"), format = "%b %d", las = 2)
legend("bottomright", legend = c("Cumulative deposits", "Cumulative payouts"), lty = c(1, 1), col = c("red", "green"))
mtext("https://github.com/Rucknium", side = 4)

dev.off()











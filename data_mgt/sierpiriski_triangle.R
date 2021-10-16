library(grid)

grid.newpage()
pmax <- 7 # depth of fractal
port1 <- viewport(x=0.5,y=0.5,w=1,h=1)
port2 <- viewport(w=0.5, h=0.5, just=c("centre", "bottom"))
port3 <- viewport(w=0.5, h=0.5, just=c("left", "top"))
port4 <- viewport(w=0.5, h=0.5, just=c("right", "top"))

pushViewport(port1)
m <- as.matrix(expand.grid(rep(list(2:4), pmax)))

for (j in 1:nrow(m)) {
	for (k in 1:ncol(m)) {
		pushViewport(get(paste("port", m[j,k], sep="")))
	}
	grid.rect(
		gp=gpar(
			col="#ff00ff"
			, lty="twodash"
			, fill=rgb(sample(0:5,1), sample(0:2,1), sample(0:2,1), alpha=10, max=355)
		)
	)
	upViewport(pmax)
}

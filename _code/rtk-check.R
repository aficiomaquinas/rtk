library(stringr)
# Load koohii data
s.v4 <- readRDS("rtk3-remain.rds")
s.v4 <- as.data.frame(s.v4, stringsAsFactors = FALSE)

k.v4 <- readRDS("rtk1-v6-koohii.rds")
k.v4 <- as.data.frame(k.v4, stringsAsFactors = FALSE)

c.list <- rep(0,3030)
count <- 0
for (i in 1:1545) {
	s.no <- s.v4[i,1]
	if (str_length(s.no) == 4) {
		count <- count + 1
		c.list[count] <- s.no
	}
}

for (i in 1:2200) {
	k.no <- k.v4[i,1]
	count <- count + 1
	c.list[count] <- k.no
}

c.test <- rep(0,39)
c.full <- as.character(1:3030)
count <- 0
for (i in 1:3030) {
	if (!(c.full[i] %in% c.list)) {
		count <- count + 1
		c.test[count] <- c.full[i]
	}
}

writeLines(c.test,"rtk3-remain-lost.txt")

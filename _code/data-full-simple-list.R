library(stringr)
rtk1.full <- read.csv("rtk1-v6-strokes.csv")
rtk1.full <- as.vector(rtk1.full$flds)
rtk3.full <- readLines("rtk3-remain-full.txt")
rtk3.full <- str_split(rtk3.full, "\t")
rtk <- matrix(rep("",2*3030), ncol=2,
								dimnames=list(1:3030,c("no","ka")))
count <- 0
for (i in 1:2200) {
	line <- rtk1.full[i]
	line <- str_split(line, "\037")
	l <- line[[1]]
	count <- count + 1
	rtk[count,1] <- l[2]
	rtk[count,2] <- l[5]
}

for (i in 1:830) {
	count <- count + 1
	rtk[count,1] <- rtk3.full[[i]][5]
	rtk[count,2] <- rtk3.full[[i]][1]
}
write.csv(rtk,"data-full.csv")
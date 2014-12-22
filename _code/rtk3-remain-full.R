library(stringr)
# # Load koohii data
# s.v4 <- readRDS("rtk3-remain.rds")
# s.v4 <- as.data.frame(s.v4, stringsAsFactors = FALSE)
# 
# k.v4 <- readRDS("rtk1-v6-koohii.rds")
# k.v4 <- as.data.frame(k.v4, stringsAsFactors = FALSE)
# 
# c.list <- rep(0,3030)
# count <- 0
# for (i in 1:1545) {
# 	s.no <- s.v4[i,1]
# 	if (str_length(s.no) == 4) {
# 		count <- count + 1
# 		c.list[count] <- s.no
# 	}
# }
# 
# for (i in 1:2200) {
# 	k.no <- k.v4[i,1]
# 	count <- count + 1
# 	c.list[count] <- k.no
# }
# 
# c.test <- rep(0,39)
# c.full <- as.character(1:3030)
# count <- 0
# for (i in 1:3030) {
# 	if (!(c.full[i] %in% c.list)) {
# 		count <- count + 1
# 		c.test[count] <- c.full[i]
# 	}
# }
# 
# writeLines(c.test,"rtk3-remain-lost.txt")

rtk3.koo <- readRDS("rtk3-remain-koohii.rds")
rtk3.koo <- as.data.frame(rtk3.koo, stringsAsFactors = FALSE)

rtk3.full <- readLines("rtk3-remain-full.txt")
rtk3.full <- str_split(rtk3.full, "\t")

rtk3 <- matrix(rep("",6*830), ncol=6,
							 dimnames=list(1:830,c("no","ka","key",
							 											"sks","s2","on")))
for (i in 1:830) {
	rtk3.no <- rtk3.full[[i]][5]
	rtk3[i,1] <- rtk3.no
	rtk3[i,2] <- rtk3.full[[i]][1]
	rtk3[i,3] <- rtk3.full[[i]][2]
	rtk3[i,4] <- rtk3.full[[i]][4]
	rtk3[i,6] <- rtk3.full[[i]][7]
	if (rtk3.no %in% rtk3.koo$no) {
		rtk3[i,5] <- rtk3.koo[rtk3.koo$no == rtk3[i,1],5]
	}
}

saveRDS(rtk3,"rtk3-remain.rds")
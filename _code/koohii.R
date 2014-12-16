library(stringr)
koohii <- readLines("/data/Downloads/rtk20.txt")
koo.v4 <- matrix(rep("",3*3030), ncol = 3, 
								 dimnames = list(1:3030,c("no","s0","s2")))
for (i in 1:3030) {
	# Reset k.s0
	k.s0 <- ""
	# Input
	kine <- koohii[i]
	kine <- str_split(kine, "\t")
	k <- kine[[1]]
	# Set V4 number to k.no
	k.no <- k[5]
	# Check and set premitive to k.s0
	k.s1 <- k[3]
	k.pc <- str_locate(k.s1, "[*]")
	if (!is.na(k.pc[1])) {
		k.lc <- str_locate(k.s1, "[[][[:digit:]]+[]]")
		if (k.pc[1] == 1) {
			k.s0 <- str_sub(k.s1, 3, k.lc[2])
			k.s0 <- str_trim(k.s0)
		}
	}
	# Set Koohii stories to k.s2 and clear up
	k.s2 <- k[8]
	k.s2 <- str_split(k.s2, "<br[ ]*[/]?>")[[1]][2:11]
	k.s2 <- str_replace_all(k.s2, "\"{2,}", "\"")
  k.s2 <- str_replace_all(k.s2, "<a href=\"midori://search[?]text=([[:alpha:]]+)\">[[:alpha:]]+</a>", "\\1")
	k.s2 <- str_replace_all(k.s2, "http://kanji.koohii.com/study/kanji/", "../")
	k.s2 <- str_replace_all(k.s2, "<span class=\"index\">", "")
	k.s2 <- str_replace_all(k.s2, "</span>", "")
	k.s2 <- str_replace_all(k.s2, "[[:space:]]{2,}", " ")
	k.s2 <- str_trim(k.s2)
	k.s2 <- str_c(k.s2, collapse = "\n\n")
	
	# Save to matrix
	koo.v4[i,1] <- k.no
	koo.v4[i,2] <- k.s0
	koo.v4[i,3] <- k.s2
}

saveRDS(koo.v4,"koohii.rds")
library(stringr)
koohii <- readLines("/data/Downloads/rtk20.txt")
koo.v4 <- rep("",3030)
for (i in 1:3030) {
	kine <- koohii[i]
	kine <- str_split(kine, "\t")
	k <- kine[[1]]
	k.no <- as.numeric(k[5])
	k.s2 <- k[8]
	k.s2 <- str_split(k.s2, "<br[ ]*[/]?>")[[1]][2:11]
	k.s2 <- str_c(k.s2, collapse = "\n\n")
	k.s2 <- str_replace_all(k.s2, "\"\"", "\"")
	k.s2 <- str_replace_all(k.s2, "http://kanji.koohii.com/study/kanji/", "../")
	k.s2 <- str_replace_all(k.s2, "midori://search[[:punct:]]text=","http://jisho.org/kanji/details/")
	koo.v4[k.no] <- k.s2
}
saveRDS(koo.v4,"koohii.rds")
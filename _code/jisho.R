library(stringr)
data <- read.csv("database.csv")
data <- as.vector(data$flds)
koo.v4 <- readRDS("koohii.rds")
koo.v4 <- as.data.frame(koo.v4)
n <- length(data)
for (i in 1:n) {
	line <- data[i]
	line <- str_split(line, "\037")
	l <- line[[1]]
  l.no <- l[2]
	l.no6 <- l[3]
	l.key <- l[4]
	l.ka <- l[5]
	l.img <- str_replace(l[6],
												 "<img src=\"([[:alnum:]]{6,}).png\" />", 
												 "\\1")
	l.ele <- l[8]
	l.sks <- l[9]
	l.hei <- l[11]
	l.hei <- str_replace_all(l.hei, "\"", "&quot;")
	l.hei <- str_replace_all(l.hei, "<div>", "\n")
	l.hei <- str_replace_all(l.hei, "</div>", "")
	l.on <- l[17]
	l.kun <- l[18]
	l.word <- l[19]
	l.word <- str_replace_all(l.word, "<br[ ]*[/]?>", "\n\n")
	l.example <- l[20]
	l.na <- paste0(str_dup("0",4-str_length(l.no6)),l.no6)
	l.pri <- koo.v4[koo.v4$no==l.no,2]
	l.koo <- koo.v4[koo.v4$no==l.no,3]
	content <- paste0("---",
										"\nlayout: kanji",
										"\nv4: ", l.no,
										"\nv6: ", l.no6,
										"\nkanji: ", l.ka,
										"\nkeyword: ",l.key,
										"\nelements: ", l.ele,
										"\nstrokes: ", l.sks,
										"\nimage: ", l.img,
										"\non-yomi: ", l.on,
										ifelse(l.kun=="","",paste0("\nkun-yomi: ", l.kun)),
										"\npermalink: /", l.no6,"/",
										"\nredirect_from:",
										"\n - /", l.ka, "/",
										"\n - /", tolower(l.key), "/",
										"\n - /v4/", l.no, "/",
										ifelse(str_detect(l.ka,"・"),
													 paste0("\n - /", str_sub(l.ka,1,1), "/",
													 "\n - /", str_sub(l.ka,3,3), "/"),""),
										"\nprev: ", as.numeric(l.no6) - 1,
										"\nnext: ", as.numeric(l.no6) + 1,
										ifelse(l.hei=="","",
													 paste0("\nheisig: \"",l.hei,"\"")),
										ifelse(l.pri=="","",
													 paste0("\nprimit: \"",l.pri,"\"")),
										"\n---",
										"\n\n", l.koo,
										"\n")
	l.path <- paste0("/data/repos/manhtai/rtk/kanji/",l.na,".md")
	writeLines(content, l.path)
}
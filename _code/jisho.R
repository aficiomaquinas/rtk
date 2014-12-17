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
	l.image <- l[6]
	l.image <- str_replace(l.image, "src=\"", "src=\"../images/")
	l.image <- paste0("<div class=\"stroke\">",l.image,"</div>")
	l.strokes <- l[9]
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
	l.pre <- koo.v4[koo.v4$no==l.no,2]
	l.koo <- koo.v4[koo.v4$no==l.no,3]
	content <- paste0("---\nlayout: post\ntitle: " ,l.ka," ",l.key,
										"\nkanji: ", l.ka,
										"\npermalink: /", l.no6,"/",
										"\nredirect_from:",
										"\n - /", l.ka, "/",
										"\n - /", tolower(l.key), "/",
										"\n - /v4/", l.no, "/",
										"\npre_kanji: ", as.numeric(l.no6) - 1,
										"\nnex_kanji: ", as.numeric(l.no6) + 1,
										ifelse(l.hei=="","","\nheisig: \""),l.hei,
										ifelse(l.pre=="",""," "),
										l.pre,
										ifelse(l.hei=="","","\""),
										"\n---",
										"\n\n## `", l.key,"`",
										"\n\n## [",l.strokes,"]\n\n",l.image,
										"\n\n## Reading:",
										"\n\n### On-Yomi: ",l.on,
										ifelse(l.kun=="",""," &mdash; Kun-Yomi: "),l.kun,
										ifelse(l.hei=="","","\n\n## Heisig story:\n\n"),
										l.hei,
										ifelse(l.pre=="","",
													 "\n\n## Premitive:\n\n"), l.pre,
										"\n\n## Koohii stories:",
										"\n\n", l.koo)
	l.path <- paste0("/data/repos/manhtai/rtk/jisho/",l.na,".md")
	writeLines(content, l.path)
}
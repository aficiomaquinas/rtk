library(stringr)
data <- read.csv("database.csv")
data <- as.vector(data$flds)
n <- length(data)
l.nav <- rep(0, n+2)

for (i in 1:n) {
	line <- data[i]
	line <- str_split(line, "\037")
	l <- line[[1]]
	l.nav[i+1] <- l[2]
}

for (i in 1:n) {
	line <- data[i]
	line <- str_split(line, "\037")
	l <- line[[1]]
	l.no <- l[2]
	l.key <- l[4]
	l.ka <- l[5]
	l.image <- l[6]
	l.image <- str_replace(l.image, "src=\"", "src=\"../images/")
	l.image <- paste0("<div class=\"stroke\">",l.image,"</div>")
	l.strokes <- l[9]
	l.on <- l[17]
	l.kun <- l[18]
	l.word <- l[19]
	l.word <- str_replace_all(l.word, "<br[ ]*[/]?>", "\n\n")
	l.example <- l[20]
	l.na <- paste0(str_dup("0",4-str_length(l.no)),l.no)
	content <- paste0("---\nlayout: post\ntitle: " ,l.ka," ",l.key,
										"\nkanji: ", l.ka,
										"\npermalink: /", l.no,"/",
										"\nredirect_from:",
										"\n - /", l.ka, "/",
										"\n - /", tolower(l.key), "/",
										"\npre_kanji: ", l.nav[i],
										"\nnex_kanji: ", l.nav[i+2],
										"\nheisig: \"",l[11],"\"",
										"\n---",
										"\n\n## {",l.no,"}",
										"\n\n## `", l.key,"`",
										"\n\n## [",l.strokes,"]\n\n",l.image,
										"\n\n## Reading:",
										"\n\n### On-Yomi: ",l.on,
										ifelse(l.kun=="",""," &mdash; Kun-Yomi: "),l.kun,
										ifelse(l.example == "","",
													 "\n\n### Examples: "), l.example,
										ifelse(l.word == "","","\n\n## Words:\n\n"), l.word)
	l.path <- paste0("/data/repos/hochanh/rtk-jisho/jisho/",l.na,".md")
	writeLines(content, l.path)
}

# THIS CODE SPLIT KOOHII STORIES FROM ANKI PACKAGES INTO 2 PARTS:
# - RTK1-V6 PART CONTAINS 2200 KANJI, SAVE IN 'rtk1-v6-koohii.rds'
# - RTK3-REMAIN, SAVE IN 'rtk3-remain.rds'

# ANKI PACKAGES GOT FROM HERE:
# https://ankiweb.net/shared/info/2843053490

library(stringr)
# Load koohii raw data
koohii <- readLines("/data/Downloads/apkg/RTK20.txt")
nk <- length(koohii)
koo.v4 <- matrix(rep("",3*2200), ncol = 3, 
								 dimnames = list(1:2200,c("no","s0","s2")))
s.v4 <- matrix(rep("",5*(nk-2200)), ncol = 5,
							 dimnames = list(1:(nk-2200),c("no","ka","key",
							 															"sks","s2")))
count <- 0
count2 <- 0
# Split data into rtk1-v6 and rtk3-remain
for (i in 1:nk) {
	# Reset k.s0
	k.s0 <- ""
	# Input
	kine <- koohii[i]
	kine <- str_split(kine, "\t")
	k <- kine[[1]]
	# Set V4 number to k.no
	k.no <- k[5]
	# k[7] is V6 number
	if (as.numeric(k[7]) < 2201) {
		# Check and set premitive to k.s0
		k.s1 <- k[3]
		k.pc <- str_locate(k.s1, "[*]")
		if (!is.na(k.pc[1])) {
			if (k.pc[1] < 4) {
				k.lc <- str_locate(k.s1, "[[][[:digit:]]+[]]")
				if (anyNA(k.lc)) {
					k.lim <- str_length(k.s1)
				} else {
					k.lim <- k.lc[2]
				}		
				k.s0 <- str_sub(k.s1, k.pc[1]+1, k.lim)
			}
		} 
		if (str_sub(k.s0, str_length(k.s0)) == "\"") {
			k.s0 <- str_sub(k.s0, 1, str_length(k.s0) - 1)
		}
		k.s0 <- str_trim(k.s0)
		k.s0 <- str_replace_all(k.s0, "\"\"", "\"")
		k.s0 <- str_replace_all(k.s0, "\"", "&quot;")
		k.s0 <- str_replace_all(k.s0, "[[:space:]]{2,}", " ")
		
		# Set Koohii stories to k.s2 and clear up
		k.s2 <- k[8]
		k.s2 <- str_split(k.s2, "<br[ ]*[/]?>")[[1]][2:6]
		k.s2 <- str_replace_all(k.s2, "\"\"", "\"")
	  k.s2 <- str_replace_all(k.s2, "<a href=\"midori://search[?]text=([[:alnum:]|[:blank:]]+)\">[[:alnum:]|[:blank:]]+</a>", "\\1")
		k.s2 <- str_replace_all(k.s2, "<a href=\"http://kanji.koohii.com/study/kanji/([[:alnum:]]+)\">([[:alnum:]|[:blank:]]+)</a>", "<a href=\"../v4/\\1.html\">\\2</a>")
		k.s2 <- str_replace_all(k.s2, "<span class=\"index\">", "")
		k.s2 <- str_replace_all(k.s2, "</span>", "")
		k.s2 <- str_replace_all(k.s2, "[[:space:]]{2,}", " ")
		k.s2 <- str_trim(k.s2)
		k.s2 <- str_c(k.s2, collapse = "\n\n")
		
		# Save to matrix
		count <- count + 1
		koo.v4[count,1] <- k.no # V4 number
		koo.v4[count,2] <- k.s0 # Primitive
		koo.v4[count,3] <- k.s2 # Koohii stories
	} else {
		# This part copy from above, if you edit above, copy
		# and paste below.
		# Set Koohii stories to k.s2 and clear up
		k.s2 <- k[8]
		k.s2 <- str_split(k.s2, "<br[ ]*[/]?>")[[1]][2:6]
		k.s2 <- str_replace_all(k.s2, "\"\"", "\"")
		k.s2 <- str_replace_all(k.s2, "<a href=\"midori://search[?]text=([[:alnum:]|[:blank:]]+)\">[[:alnum:]|[:blank:]]+</a>", "\\1")
		k.s2 <- str_replace_all(k.s2, "<a href=\"http://kanji.koohii.com/study/kanji/([[:alnum:]]+)\">([[:alnum:]|[:blank:]]+)</a>", "<a href=\"../v4/\\1.html\">\\2</a>")
		k.s2 <- str_replace_all(k.s2, "<span class=\"index\">", "")
		k.s2 <- str_replace_all(k.s2, "</span>", "")
		k.s2 <- str_replace_all(k.s2, "[[:space:]]{2,}", " ")
		k.s2 <- str_trim(k.s2)
		k.s2 <- str_c(k.s2, collapse = "\n\n")
		
		# Save to another matrix
		count2 <- count2 + 1
		s.v4[count2,1] <- k.no # V4 number
		s.v4[count2,2] <- k[1] # Kanji
		s.v4[count2,3] <- k[2] # Keyword
		s.v4[count2,4] <- k[4] # Strokes
		s.v4[count2,5] <- k.s2 # Koohii stories
	}
}

saveRDS(koo.v4,"rtk1-v6-koohii.rds")
saveRDS(s.v4,"rtk3-remain-koohii.rds")
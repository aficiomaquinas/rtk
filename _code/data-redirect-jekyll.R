library(stringr)
# Load koohii raw data
full <- read.csv("data-full.csv", stringsAsFactors = FALSE)
for (i in 1:3030) {
	k.no <- full[i,2]
	k.ka <- full[i,3]
	if (str_detect(k.ka,"・")) {
		k.ka <- str_sub(k.ka,1,1)
	}
	content <- paste0("<!DOCTYPE html>\n",
										"<meta charset=utf-8>\n",
										"<title>Redirecting...</title>\n",
										"<link rel=canonical href=\"../",
										k.ka,
										"/index.html\">\n",
										"<meta http-equiv=refresh content=\"0; url='../",
										k.ka,"/index.html'\">\n",
										"<h1>Redirecting...</h1>\n",
										"<a href=\"../",
										k.ka,
										"/index.html\">Click here if you are not redirected.</a>\n",
										"<script>location='../",
										k.ka,
										"/index.html'</script>")
	k.path <- paste0("/data/repos/hochanh/rtk/v4/",k.no,".html")
	writeLines(content, k.path)
}


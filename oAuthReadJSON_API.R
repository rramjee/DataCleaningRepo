oAuth <- function()
{
library(httr)
library(httpuv)
library(jsonlite)
library(RJSONIO)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
  key = "e65b8c39dfb2d8476ec9",
  secret = "6dbea6d830ed9d13746cab6be93b2825f87b3865")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp,cache=FALSE)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos",gtoken )
stop_for_status(req)

data<-content(req)






# to remove NULL or na values
asFrame <- lapply(data, function(x) {
  x[sapply(x, is.null)] <- NA
  unlist(x)
})



asFrame<-do.call("rbind", asFrame)

# To convert matrix or atomic vector to a dataframe
finaldata=as.data.frame(asFrame)
finaldata$created_at[finaldata$name=="datasharing"]

}
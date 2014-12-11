
# question 1
library(httr)
library(httpuv)
# 1. Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
oauth_endpoints("github")
# 2. Register an application at https://github.com/settings/applications;
# Use any URL you would like for the homepage URL (http://github.com is fine)
# and http://localhost:1410 as the callback url
#
# Insert your client ID and secret below - if secret is omitted, it will
# look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp= oauth_app("github", "215fa567ec0aa1c79c59", "d70a6ec7c34f8868d30246056895dd7161a5b166")
# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
dt= content(req)

nm= c()
for (i in 1:length(dt)) {
	nm= c(nm, dt[[i]]$name)
}

id= which(nm=="datasharing")
mydt= dt[[id]]
names(mydt)
mydt$created_at


# question 4
con= url("http://biostat.jhsph.edu/~jleek/contact.html")
data= readLines(con)
lines= c(10, 20, 30, 100)
nchar(data[lines])

#question 5
dt= read.fwf(file=url("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for"), skip=4, widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(dt$V4)

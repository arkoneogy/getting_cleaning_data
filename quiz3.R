# setup
q1.url= 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(q1.url, destfile= 'idahoHousing.csv', method= 'curl')
q2.url= 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file (q2.url, destfile= 'jeff.jpg', method= 'curl')
q3.url1= 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
q3.url2= 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file (q3.url1, destfile= 'gdpData.csv', method= 'curl')
download.file (q3.url2, destfile= 'eduData.csv', method= 'curl')

library(data.table)
library(jpeg)

#question 1
idHousing= fread('idahoHousing.csv')
idHousing
table(idHousing$ACR)
table(idHousing$AGS)
idHousing[, myind:= (ACR==3 & AGS==6)]
head(which(idHousing$myind))

#question 2
jeff.pic= readJPEG('jeff.jpg', native=T)
x= seq(from= 0, to= 1, by= 0.1)
quantile(jeff.pic, x)

#question 3
edu= fread('eduData.csv')
gdp= fread('gdpData_1.csv')
names(gdp)
dim(edu)
names(gdp)
names(edu)
head(gdp)
head(edu$CountryCode)
setnames(gdp, 'Country', 'CountryCode')
setkeyv(gdp, 'CountryCode')
setkeyv(edu, 'CountryCode')
match= merge(gdp, edu, by= 'CountryCode')
nrow(match)
match= match[order(-Ranking)]
tail(match$CountryCode)
head(match$CountryCode, 13)
match[13, c('CountryCode', 'Short Name'), with=F]

#question 4
match[, mean(Ranking), by= "Income Group"]

#quesiton 5
match[ Ranking <= 38, .N, by= "Income Group"]

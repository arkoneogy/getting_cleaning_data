library(data.table)
library(quantmod)

# setup
q1.url= 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(q1.url, destfile= 'idahoHousing.csv', method= 'curl')
q2.url1= 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
q2.url2= 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file (q2.url1, destfile= 'gdpData.csv', method= 'curl')
download.file (q2.url2, destfile= 'eduData.csv', method= 'curl')


# question 1
idHousing= fread('idahoHousing.csv')
idHousing.names= names(idHousing)
mylist= strsplit(idHousing.names, "wgtp")
mylist[123]


# question 2 and 4
edu= fread('eduData.csv')
gdp= fread('gdpData_1.csv')
mean(gdp$GDP)
mydata= merge(gdp, edu, by= "CountryCode")
names(mydata)
options(width= 145)
head(mydata)
fyend= mydata[ grepl("[fF]iscal+(.*)+year+(.*)+end", mydata$"Special Notes")]
fyend.june= fyend[ grepl("June", fyend$"Special Notes")]
nrow(fyend.june)


# question 5
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
amzn= data.frame(amzn)
amzn$reportDate= row.names(amzn)
amzn= data.table(amzn)
amzn[, reportDate:= as.Date(reportDate)]
amzn[, reportDay:= weekdays(reportDate)]
amzn[, reportYear:= format(reportDate, "%Y")]
amzn[reportYear==2012]
amzn[reportDay=="Monday" & reportYear==2012]


library(data.table)
library(xlsx)
library(XML)
q1.url= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(q1.url, destfile = "idahoHousing.csv", method= "curl")
q3.url= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(q3.url, destfile = "gasAquisition.xlsx", method= "curl")
q4.url= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(q4.url, destfile = "baltimoreRestaurants.xml", method= "curl")
q5.url= "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(q5.url, destfile = "idahoHousing2.csv", method= "curl")


# question 1
idaho.housing= fread('idahoHousing.csv')
ans1= nrow(idaho.housing[VAL==24])

# question 2
summary(idaho.housing$FES)
mode(idaho.housing$FES)
class(idaho.housing$FES)

# question 3
rows= 18:23
cols= 7:15
gas.acquisition= read.xlsx("gasAquisition.xlsx", sheetIndex=1, 
                           colIndex= cols, rowIndex= rows)
ans3= sum(gas.acquisition$Zip * gas.acquisition$Ext, na.rm=T)

# question 4
baltimore.restaurants= xmlTreeParse('baltimoreRestaurants.xml', useInternal=T)
rootNode= xmlRoot(baltimore.restaurants)
zips= as.numeric(xpathSApply(rootNode, "//zipcode", xmlValue))
ans4= sum(zips== 21231)

# question 5
idaho.housing2= fread('idahoHousing2.csv')

DT= copy(idaho.housing2)
base= proc.time()
tapply(DT$pwgtp15,DT$SEX,mean); op1= proc.time()
sapply(split(DT$pwgtp15,DT$SEX),mean); op2= proc.time()
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15); op3= proc.time()
DT[,mean(pwgtp15),by=SEX]; op4= proc.time()
mean(DT$pwgtp15,by=DT$SEX)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] 


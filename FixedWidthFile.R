FixedWidthFileRead <- function(URL,skips,width,colnum)
{
x <- read.fwf(file=url(URL),skip=skips,widths=width)
sum(x[,colnum],na.rm=TRUE)
#FixedWidthFileRead("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for",4,c(15,4,9,4, 9,4, 9,4,4),4)
}


pollutantmean <- function(directory, pollutant, id=1:332)
{
	basedir <-getwd() 
	for(i in seq_along(id))
	{
		filename<-paste(str_pad(id[i],3,side="left",pad="0"),"csv",sep=".")
		inputfile<-paste(basedir,directory,filename,sep="/")
		dataset<-read.csv(inputfile)
		if (!is.data.frame(df))
		{
			df<- dataset
		}
		else
		{
			df<-merge(df,dataset,by=c("Date", "sulfate", "nitrate","ID"), all=T)
		}
	}
	colnum<-which( colnames(df)==pollutant )
	mean(df[,colnum],na.rm=TRUE)

	
	
}
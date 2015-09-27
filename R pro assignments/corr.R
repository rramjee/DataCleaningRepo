corr <- function(directory,threshold=0)
{
	dfcc <- complete(directory,1:332)
	dfct <- subset(dfcc, dfcc$nobs > threshold)
	dfctRow <- nrow(dfct)
	basedir <-getwd() 
	vCorrOP <- numeric ()
	for(i in 1:dfctRow)
	{
		filename<-paste(str_pad(dfct[i,1],3,side="left",pad="0"),"csv",sep=".")
		inputfile<-paste(basedir,directory,filename,sep="/")
		if(file.exists(inputfile))
		{
		dataset<-read.csv(inputfile)
		vCorrOP[i] <-cor(dataset[,2],dataset[,3],use="complete.obs")
		}
	}
vCorrOP
}
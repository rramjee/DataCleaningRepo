complete <- function(directory,id)
{
	basedir <-getwd() 
	df <- data.frame()
	for(i in seq_along(id))
	{
		filename<-paste(str_pad(id[i],3,side="left",pad="0"),"csv",sep=".")
		inputfile<-paste(basedir,directory,filename,sep="/")
		dataset<-read.csv(inputfile)
		nocc <-nrow(dataset[complete.cases(dataset),])
		df <- rbind(df, data.frame(id =id[i], nobs= nocc))
	}
df
}
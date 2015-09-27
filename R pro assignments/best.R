best <- function(state,outcome)
{
	cBaseDir <-getwd() 
	cOutCome<-toupper(paste("Hospital 30-Day Death (Mortality) Rates from",outcome,sep= " "))
	inputfile<-paste(cBaseDir,"outcome-of-care-measures.csv",sep="/")
	dfHosCarMeas<-read.csv(inputfile,colClasses = "character",check.names=FALSE)
	names(dfHosCarMeas)<-toupper(names(dfHosCarMeas))
	if(nrow(subset(dfHosCarMeas, dfHosCarMeas$STATE==state))>0)
	{
		dfHosCarStateMeas<-subset(dfHosCarMeas,dfHosCarMeas$STATE==state)
		names(dfHosCarStateMeas)<-toupper(names(dfHosCarStateMeas))
		hosName<-toupper("Hospital Name")
		if (any(toupper(names(dfHosCarStateMeas))==toupper(cOutCome)))
		{
			minMortVal<-min(as.numeric(dfHosCarStateMeas[[cOutCome]]),na.rm=T)
			outputBestHos<-tapply(dfHosCarStateMeas[[hosName]],dfHosCarStateMeas[[cOutCome]]==minMortVal,sort)[2]
			outputBestHos[[1]][[1]]
		}
		else
		{
			stop("invalid outcome")
		}
	}
	else
	{
		stop("invalid state")
	}
}
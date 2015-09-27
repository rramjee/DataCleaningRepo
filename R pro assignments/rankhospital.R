rankhospital <- function(state, outcome, num = "best")
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
			dfHosCarStateMeas<-subset(dfHosCarStateMeas, !is.na(as.numeric(dfHosCarStateMeas[[cOutCome]])))
			dfHosCarStateMeas<-dfHosCarStateMeas[order(as.numeric(dfHosCarStateMeas[[cOutCome]]),dfHosCarStateMeas[[hosName]]),]
			iTotalRows<-nrow(dfHosCarStateMeas)
			if (iTotalRows>0)
			{
				if(num=="best")
				{
					dfHosCarStateMeas[[hosName]][1]
				}
				else if (num=="worst")
				{
					dfHosCarStateMeas[[hosName]][[iTotalRows]]
				}
				else if (num > iTotalRows)
				{
					return("NA")
				}
				else
				{
					dfHosCarStateMeas[[hosName]][[num]]
				}
				
			}
			
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
rankall <- function(outcome, num = "best")
{
	cBaseDir <-getwd() 
	cOutCome<-toupper(paste("Hospital 30-Day Death (Mortality) Rates from",outcome,sep= " "))
	inputfile<-paste(cBaseDir,"outcome-of-care-measures.csv",sep="/")
	dfHosCar<-read.csv(inputfile,colClasses = "character",check.names=FALSE)
	names(dfHosCar)<-toupper(names(dfHosCar))
	hosName<-toupper("Hospital Name")
	dRes <- data.frame(hospital=character(0),state=numeric(0))
	if (any(toupper(names(dfHosCar))==toupper(cOutCome)))
	{
		cStateNames<-unique(dfHosCar$STATE)
		iStateLength<-length(cStateNames)
		for(i in 1:iStateLength)
		{
			dfHosCarStateMeas<-subset(dfHosCar,dfHosCar$STATE==cStateNames[i])
			if(nrow(dfHosCarStateMeas)>0)
			{
				dfHosCarStateMeas<-subset(dfHosCarStateMeas, !is.na(as.numeric(dfHosCarStateMeas[[cOutCome]])))
				dfHosCarStateMeas<-dfHosCarStateMeas[order(as.numeric(dfHosCarStateMeas[[cOutCome]]),dfHosCarStateMeas[[hosName]]),]
				iTotalRows<-nrow(dfHosCarStateMeas)
				if (iTotalRows>0)
				{
					if(num=="best")
					{
					dRes <- rbind(dRes, data.frame(hospital =dfHosCarStateMeas[[hosName]][1], state= cStateNames[i]))
					}
					else if (num=="worst")
					{
						dRes <- rbind(dRes, data.frame(hospital =dfHosCarStateMeas[[hosName]][iTotalRows], state= cStateNames[i]))
					}
					else if (num > iTotalRows)
					{
						dRes <- rbind(dRes, data.frame(hospital ="NA", state= cStateNames[i]))
					}
					else
					{
						dRes <- rbind(dRes, data.frame(hospital =dfHosCarStateMeas[[hosName]][[num]], state= cStateNames[i]))					
					}
					
				}
			}
			else
			{
				dRes <- rbind(dRes, data.frame(hospital ="NA", state= cStateNames[i]))
			}
		}
		
		dRes
	}
	else
	{
		stop("invalid outcome")
	}

}
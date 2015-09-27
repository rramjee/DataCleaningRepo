library(dplyr)

#reading all the feature names
dfFeatureNames<-read.table("./UCI HAR Dataset/features.txt",header = FALSE,)
##preparing Training Set by Merging activity, subject and training data

dfTrainingMeas<-read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE,sep = "", dec = ".")

colnames(dfTrainingMeas)<-dfFeatureNames[,2]
dfSubjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE,col.names=c("Subject"))
dfTrainingActivity<-read.table("./UCI HAR Dataset/train/Y_train.txt",header = FALSE,col.names=c("Activity"))
dfTrainingSet<-cbind(dfSubjectTrain,dfTrainingActivity,dfTrainingMeas)

##preparing Testing Set by Merging activity, subject and test data

dfTestingMeas<-read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE,sep = "", dec = ".")
colnames(dfTestingMeas)<-dfFeatureNames[,2]
dfSubjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE,col.names=c("Subject"))
dfTestActivity<-read.table("./UCI HAR Dataset/test/Y_test.txt",header = FALSE,col.names=c("Activity"))
dfTestingSet<-cbind(dfSubjectTest,dfTestActivity,dfTestingMeas)

#Merging both Testing and Training Set
dfTestAndTrainSet <- rbind(dfTrainingSet,dfTestingSet)

#To make the column names unique 
valid_column_names <- make.names(names=names(dfTestAndTrainSet), unique=TRUE, allow_ = TRUE)
names(dfTestAndTrainSet) <- valid_column_names

#selecting only the activity, subject, mean and std columns
dfTestAndTrainStdMean<-select(dfTestAndTrainSet, Subject,Activity,contains("mean",ignore.case = TRUE),contains("std",ignore.case = TRUE))

dfActivityLables<-read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE,)

# Replace the Activity IDs based on Activity Labels
dfTestAndTrainStdMean$Activity<-dfActivityLables[,2][dfTestAndTrainStdMean$Activity]


# To rename the columns to a more descriptive name
names(dfTestAndTrainStdMean) <- sub("^[t]", "Time", names(dfTestAndTrainStdMean))
names(dfTestAndTrainStdMean) <- sub("^[f]", "Frequency", names(dfTestAndTrainStdMean))
names(dfTestAndTrainStdMean) <- sub("[....]", "", names(dfTestAndTrainStdMean))
names(dfTestAndTrainStdMean) <- sub("[..]", "", names(dfTestAndTrainStdMean))
names(dfTestAndTrainStdMean) <- sub("[..]", "", names(dfTestAndTrainStdMean))
names(dfTestAndTrainStdMean) <- sub("^[a]", "A", names(dfTestAndTrainStdMean))

## To create a second data set with average of each variable for every activity and subject
dfAvgGroupBy<-group_by(dfTestAndTrainStdMean,Activity,Subject)
dfAvgPerActSub<-summarize_each(dfAvgGroupBy,funs(mean))

write.table(dfAvgPerActSub, file = "./Results.txt", row.names = FALSE)

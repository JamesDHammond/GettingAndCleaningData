## Jim Hammond 11/13/2016
## Final Project for Getting and Cleaning Data

## Load any necessary libraries
library(data.table)
library(plyr)
library(dplyr)

## Set the working directory
setwd("D:\\Coursera\\GettingAndCleaningData")

## Set the variables that contain the data used in the analysis
testDataFile        <- 
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\test\\X_test.txt"
testActivityFile    <- 
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\test\\y_test.txt"
testSubjectFile     <-
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\test\\subject_test.txt"
trainDataFile       <- 
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\train\\X_train.txt"
trainActivityFile    <- 
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\train\\y_train.txt"
trainSubjectFile    <- 
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\train\\subject_train.txt"

variableNameFile     <-
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\features.txt"
activityLookupFile   <-
    "D:\\Coursera\\GettingAndCleaningData\\UCI_HAR_Dataset\\activity_labels.txt"

## Now load the files into temp data tables
testData        <- fread(testDataFile)
testActData     <- fread(testActivityFile)
testSubject     <- fread(testSubjectFile)
trainData       <- fread(trainDataFile)
trainActData    <- fread(trainActivityFile)
trainSubject    <- fread(trainSubjectFile)

variableNames   <- fread(variableNameFile)
activityNames   <- fread(activityLookupFile)

## clean up the variable names so they are shorter and 
## easier to understand
## 1) get rid of matching parentheticals with nothing in between them
variableNames$V2 <- gsub("\\(\\)","",variableNames$V2)
## 2) get rid of parentheticals with a trailing number and replace with a period
variableNames$V2 <- gsub("\\(\\)1$",".1",variableNames$V2)
variableNames$V2 <- gsub("\\(\\)2$",".2",variableNames$V2)
variableNames$V2 <- gsub("\\(\\)3$",".3",variableNames$V2)
variableNames$V2 <- gsub("\\(\\)4$",".4",variableNames$V2)
variableNames$V2 <- gsub("\\(\\)4$",".4",variableNames$V2)
## 3) replace commas and dashes with perioods and remove the remaining
## parentheticals using a period to replace the leading "("
variableNames$V2 <- gsub('(.*[1-99]),([1-99].*)','\\1.to.\\2',variableNames$V2)
variableNames$V2 <- gsub('(.*[X,Y,Z]),([X,Y,Z,1,2,3,4].*)','\\1.\\2',variableNames$V2)
variableNames$V2 <- gsub('\\),',',',variableNames$V2)
variableNames$V2 <- gsub('(.*)(\\()(.*),(.*)(\\)$)','\\1.\\3.\\4',variableNames$V2)
variableNames$V2 <- gsub('-','.',variableNames$V2)

## populate the src field to indicate whether the data is from the test
## data set or the training data set
testData$src    <- "test"
trainData$src   <- "train"
names(testData)
## Now add the subjects and activities to the test/training data
testData            <- cbind("Subject"=testSubject,testData)
testData            <- cbind("Activity"=testActData,testData)
trainData           <- cbind("Subject"=trainSubject,trainData)
trainData           <- cbind("Activity"=trainActData,trainData)

## Now name the variables for the "lookup" data structure for
## activities
names(activityNames)[names(activityNames)=="V1"]  <- "Activity"
names(activityNames)[names(activityNames)=="V2"]  <- "ActDescription"

## Merge the test and training data with the activity description
testDataMerged      <- 
    merge(x=activityNames, y=testData, by.x = "Activity", by.y="Activity.V1")
trainDataMerged     <- 
    merge(x=activityNames, y=trainData, by.x = "Activity", by.y="Activity.V1")

## Combine the training and testing data
allDataMerged       <-
    rbind(testDataMerged,trainDataMerged)


## Add three additional variable names for the activity, activity description, and the data source
varNames  <- c("Activity","ActDescription","Subject",variableNames$V2,"src")

## set the variable names for the merged data set
names(allDataMerged) <- varNames 

## get the columns that contain means, standard deviations or identify the type of activity
## and source and create a projection (view) of that data
meanStdData     <- allDataMerged[,.( Activity                            
                                    ,ActDescription 
                                    ,Subject
                                    ,tBodyAcc.mean.X                     
                                    ,tBodyAcc.mean.Y                    
                                    ,tBodyAcc.mean.Z                     
                                    ,tBodyAcc.std.X                     
                                    ,tBodyAcc.std.Y                      
                                    ,tBodyAcc.std.Z                     
                                    ,tGravityAcc.mean.X                  
                                    ,tGravityAcc.mean.Y                 
                                    ,tGravityAcc.mean.Z                  
                                    ,tGravityAcc.std.X                  
                                    ,tGravityAcc.std.Y                   
                                    ,tGravityAcc.std.Z                  
                                    ,tBodyAccJerk.mean.X                 
                                    ,tBodyAccJerk.mean.Y                
                                    ,tBodyAccJerk.mean.Z                 
                                    ,tBodyAccJerk.std.X                 
                                    ,tBodyAccJerk.std.Y                  
                                    ,tBodyAccJerk.std.Z                 
                                    ,tBodyGyro.mean.X                    
                                    ,tBodyGyro.mean.Y                   
                                    ,tBodyGyro.mean.Z                    
                                    ,tBodyGyro.std.X                    
                                    ,tBodyGyro.std.Y                     
                                    ,tBodyGyro.std.Z                    
                                    ,tBodyGyroJerk.mean.X                
                                    ,tBodyGyroJerk.mean.Y               
                                    ,tBodyGyroJerk.mean.Z                
                                    ,tBodyGyroJerk.std.X                
                                    ,tBodyGyroJerk.std.Y                 
                                    ,tBodyGyroJerk.std.Z                
                                    ,tBodyAccMag.mean                    
                                    ,tBodyAccMag.std                    
                                    ,tGravityAccMag.mean                 
                                    ,tGravityAccMag.std                 
                                    ,tBodyAccJerkMag.mean                
                                    ,tBodyAccJerkMag.std                
                                    ,tBodyGyroMag.mean                   
                                    ,tBodyGyroMag.std                   
                                    ,tBodyGyroJerkMag.mean               
                                    ,tBodyGyroJerkMag.std               
                                    ,fBodyAcc.mean.X                     
                                    ,fBodyAcc.mean.Y                    
                                    ,fBodyAcc.mean.Z                     
                                    ,fBodyAcc.std.X                     
                                    ,fBodyAcc.std.Y                      
                                    ,fBodyAcc.std.Z                     
                                    ,fBodyAcc.meanFreq.X                 
                                    ,fBodyAcc.meanFreq.Y                
                                    ,fBodyAcc.meanFreq.Z                 
                                    ,fBodyAccJerk.mean.X                
                                    ,fBodyAccJerk.mean.Y                 
                                    ,fBodyAccJerk.mean.Z                
                                    ,fBodyAccJerk.std.X                  
                                    ,fBodyAccJerk.std.Y                 
                                    ,fBodyAccJerk.std.Z                  
                                    ,fBodyAccJerk.meanFreq.X            
                                    ,fBodyAccJerk.meanFreq.Y             
                                    ,fBodyAccJerk.meanFreq.Z            
                                    ,fBodyGyro.mean.X                    
                                    ,fBodyGyro.mean.Y                   
                                    ,fBodyGyro.mean.Z                    
                                    ,fBodyGyro.std.X                    
                                    ,fBodyGyro.std.Y                     
                                    ,fBodyGyro.std.Z                    
                                    ,fBodyGyro.meanFreq.X                
                                    ,fBodyGyro.meanFreq.Y               
                                    ,fBodyGyro.meanFreq.Z                
                                    ,fBodyAccMag.mean                   
                                    ,fBodyAccMag.std                     
                                    ,fBodyAccMag.meanFreq               
                                    ,fBodyBodyAccJerkMag.mean            
                                    ,fBodyBodyAccJerkMag.std            
                                    ,fBodyBodyAccJerkMag.meanFreq        
                                    ,fBodyBodyGyroMag.mean              
                                    ,fBodyBodyGyroMag.std                
                                    ,fBodyBodyGyroMag.meanFreq          
                                    ,fBodyBodyGyroJerkMag.mean           
                                    ,fBodyBodyGyroJerkMag.std           
                                    ,fBodyBodyGyroJerkMag.meanFreq       
                                    ,angle.tBodyAccMean.gravity         
                                    ,angle.tBodyAccJerkMean.gravityMean  
                                    ,angle.tBodyGyroMean.gravityMean    
                                    ,angle.tBodyGyroJerkMean.gravityMean 
                                    ,angle.X.gravityMean                
                                    ,angle.Y.gravityMean                 
                                    ,angle.Z.gravityMean                
                                    ,src)]

## Now create the data table that has the averages of all of the values listed above
## group by Activity, ActDescription, and Subject
avgMeanStdData          <- 
    group_by(meanStdData, Activity, ActDescription, Subject)

avgMeanData             <- summarize(
    avgMeanStdData,
    tBodyAcc.mean.X=mean(tBodyAcc.mean.X,na.rm=TRUE),
    tBodyAcc.mean.Y=mean(tBodyAcc.mean.Y,na.rm=TRUE),
    tBodyAcc.mean.Z=mean(tBodyAcc.mean.Z,na.rm=TRUE),
    tBodyAcc.std.X=mean(tBodyAcc.std.X,na.rm=TRUE),
    tBodyAcc.std.Y=mean(tBodyAcc.std.Y,na.rm=TRUE),
    tBodyAcc.std.Z=mean(tBodyAcc.std.Z,na.rm=TRUE),
    tGravityAcc.mean.X=mean(tGravityAcc.mean.X,na.rm=TRUE),
    tGravityAcc.mean.Y=mean(tGravityAcc.mean.Y,na.rm=TRUE),
    tGravityAcc.mean.Z=mean(tGravityAcc.mean.Z,na.rm=TRUE),
    tGravityAcc.std.X=mean(tGravityAcc.std.X,na.rm=TRUE),
    tGravityAcc.std.Y=mean(tGravityAcc.std.Y,na.rm=TRUE),
    tGravityAcc.std.Z=mean(tGravityAcc.std.Z,na.rm=TRUE),
    tBodyAccJerk.mean.X=mean(tBodyAccJerk.mean.X,na.rm=TRUE),
    tBodyAccJerk.mean.Y=mean(tBodyAccJerk.mean.Y,na.rm=TRUE),
    tBodyAccJerk.mean.Z=mean(tBodyAccJerk.mean.Z,na.rm=TRUE),
    tBodyAccJerk.std.X=mean(tBodyAccJerk.std.X,na.rm=TRUE),
    tBodyAccJerk.std.Y=mean(tBodyAccJerk.std.Y,na.rm=TRUE),
    tBodyAccJerk.std.Z=mean(tBodyAccJerk.std.Z,na.rm=TRUE),
    tBodyGyro.mean.X=mean(tBodyGyro.mean.X,na.rm=TRUE),
    tBodyGyro.mean.Y=mean(tBodyGyro.mean.Y,na.rm=TRUE),
    tBodyGyro.mean.Z=mean(tBodyGyro.mean.Z,na.rm=TRUE),
    tBodyGyro.std.X=mean(tBodyGyro.std.X,na.rm=TRUE),
    tBodyGyro.std.Y=mean(tBodyGyro.std.Y,na.rm=TRUE),
    tBodyGyro.std.Z=mean(tBodyGyro.std.Z,na.rm=TRUE),
    tBodyGyroJerk.mean.X=mean(tBodyGyroJerk.mean.X,na.rm=TRUE),
    tBodyGyroJerk.mean.Y=mean(tBodyGyroJerk.mean.Y,na.rm=TRUE),
    tBodyGyroJerk.mean.Z=mean(tBodyGyroJerk.mean.Z,na.rm=TRUE),
    tBodyGyroJerk.std.X=mean(tBodyGyroJerk.std.X,na.rm=TRUE),
    tBodyGyroJerk.std.Y=mean(tBodyGyroJerk.std.Y,na.rm=TRUE),
    tBodyGyroJerk.std.Z=mean(tBodyGyroJerk.std.Z,na.rm=TRUE),
    tBodyAccMag.mean=mean(tBodyAccMag.mean,na.rm=TRUE),
    tBodyAccMag.std=mean(tBodyAccMag.std,na.rm=TRUE),
    tGravityAccMag.mean=mean(tGravityAccMag.mean,na.rm=TRUE),
    tGravityAccMag.std=mean(tGravityAccMag.std,na.rm=TRUE),
    tBodyAccJerkMag.mean=mean(tBodyAccJerkMag.mean,na.rm=TRUE),
    tBodyAccJerkMag.std=mean(tBodyAccJerkMag.std,na.rm=TRUE),
    tBodyGyroMag.mean=mean(tBodyGyroMag.mean,na.rm=TRUE),
    tBodyGyroMag.std=mean(tBodyGyroMag.std,na.rm=TRUE),
    tBodyGyroJerkMag.mean=mean(tBodyGyroJerkMag.mean,na.rm=TRUE),
    tBodyGyroJerkMag.std=mean(tBodyGyroJerkMag.std,na.rm=TRUE),
    fBodyAcc.mean.X=mean(fBodyAcc.mean.X,na.rm=TRUE),
    fBodyAcc.mean.Y=mean(fBodyAcc.mean.Y,na.rm=TRUE),
    fBodyAcc.mean.Z=mean(fBodyAcc.mean.Z,na.rm=TRUE),
    fBodyAcc.std.X=mean(fBodyAcc.std.X,na.rm=TRUE),
    fBodyAcc.std.Y=mean(fBodyAcc.std.Y,na.rm=TRUE),
    fBodyAcc.std.Z=mean(fBodyAcc.std.Z,na.rm=TRUE),
    fBodyAcc.meanFreq.X=mean(fBodyAcc.meanFreq.X,na.rm=TRUE),
    fBodyAcc.meanFreq.Y=mean(fBodyAcc.meanFreq.Y,na.rm=TRUE),
    fBodyAcc.meanFreq.Z=mean(fBodyAcc.meanFreq.Z,na.rm=TRUE),
    fBodyAccJerk.mean.X=mean(fBodyAccJerk.mean.X,na.rm=TRUE),
    fBodyAccJerk.mean.Y=mean(fBodyAccJerk.mean.Y,na.rm=TRUE),
    fBodyAccJerk.mean.Z=mean(fBodyAccJerk.mean.Z,na.rm=TRUE),
    fBodyAccJerk.std.X=mean(fBodyAccJerk.std.X,na.rm=TRUE),
    fBodyAccJerk.std.Y=mean(fBodyAccJerk.std.Y,na.rm=TRUE),
    fBodyAccJerk.std.Z=mean(fBodyAccJerk.std.Z,na.rm=TRUE),
    fBodyAccJerk.meanFreq.X=mean(fBodyAccJerk.meanFreq.X,na.rm=TRUE),
    fBodyAccJerk.meanFreq.Y=mean(fBodyAccJerk.meanFreq.Y,na.rm=TRUE),
    fBodyAccJerk.meanFreq.Z=mean(fBodyAccJerk.meanFreq.Z,na.rm=TRUE),
    fBodyGyro.mean.X=mean(fBodyGyro.mean.X,na.rm=TRUE),
    fBodyGyro.mean.Y=mean(fBodyGyro.mean.Y,na.rm=TRUE),
    fBodyGyro.mean.Z=mean(fBodyGyro.mean.Z,na.rm=TRUE),
    fBodyGyro.std.X=mean(fBodyGyro.std.X,na.rm=TRUE),
    fBodyGyro.std.Y=mean(fBodyGyro.std.Y,na.rm=TRUE),
    fBodyGyro.std.Z=mean(fBodyGyro.std.Z,na.rm=TRUE),
    fBodyGyro.meanFreq.X=mean(fBodyGyro.meanFreq.X,na.rm=TRUE),
    fBodyGyro.meanFreq.Y=mean(fBodyGyro.meanFreq.Y,na.rm=TRUE),
    fBodyGyro.meanFreq.Z=mean(fBodyGyro.meanFreq.Z,na.rm=TRUE),
    fBodyAccMag.mean=mean(fBodyAccMag.mean,na.rm=TRUE),
    fBodyAccMag.std=mean(fBodyAccMag.std,na.rm=TRUE),
    fBodyAccMag.meanFreq=mean(fBodyAccMag.meanFreq,na.rm=TRUE),
    fBodyBodyAccJerkMag.mean=mean(fBodyBodyAccJerkMag.mean,na.rm=TRUE),
    fBodyBodyAccJerkMag.std=mean(fBodyBodyAccJerkMag.std,na.rm=TRUE),
    fBodyBodyAccJerkMag.meanFreq=mean(fBodyBodyAccJerkMag.meanFreq,na.rm=TRUE),
    fBodyBodyGyroMag.mean=mean(fBodyBodyGyroMag.mean,na.rm=TRUE),
    fBodyBodyGyroMag.std=mean(fBodyBodyGyroMag.std,na.rm=TRUE),
    fBodyBodyGyroMag.meanFreq=mean(fBodyBodyGyroMag.meanFreq,na.rm=TRUE),
    fBodyBodyGyroJerkMag.mean=mean(fBodyBodyGyroJerkMag.mean,na.rm=TRUE),
    fBodyBodyGyroJerkMag.std=mean(fBodyBodyGyroJerkMag.std,na.rm=TRUE),
    fBodyBodyGyroJerkMag.meanFreq=mean(fBodyBodyGyroJerkMag.meanFreq,na.rm=TRUE),
    angle.tBodyAccMean.gravity=mean(angle.tBodyAccMean.gravity,na.rm=TRUE),
    angle.tBodyAccJerkMean.gravityMean=mean(angle.tBodyAccJerkMean.gravityMean,na.rm=TRUE),
    angle.tBodyGyroMean.gravityMean=mean(angle.tBodyGyroMean.gravityMean,na.rm=TRUE),
    angle.tBodyGyroJerkMean.gravityMean=mean(angle.tBodyGyroJerkMean.gravityMean,na.rm=TRUE),
    angle.X.gravityMean=mean(angle.X.gravityMean,na.rm=TRUE),
    angle.Y.gravityMean=mean(angle.Y.gravityMean,na.rm=TRUE),
    angle.Z.gravityMean=mean(angle.Z.gravityMean,na.rm=TRUE)
    
)
outputFile      <- "D:\\Coursera\\GettingAndCleaningData\\tidyDataSet.txt"
write.table(avgMeanData,file=outputFile,row.name=FALSE)

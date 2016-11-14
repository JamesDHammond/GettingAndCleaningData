---
title: "CodeBook.md"
author: "Jim Hammond"
date: "November 13, 2016"
output: html_document
---

## R Markdown

This is an R Markdown document and contains the description of the data structures and
transformation performed for the last project of "Getting and Cleaning Data"

### Measurements

* Activity 
* ActDescription 
* Subject
* tBodyAcc.mean.X                     
* tBodyAcc.mean.Y                    
* tBodyAcc.mean.Z                     
* tBodyAcc.std.X                     
* tBodyAcc.std.Y                      
* tBodyAcc.std.Z                     
* tGravityAcc.mean.X                  
* tGravityAcc.mean.Y                 
* tGravityAcc.mean.Z                  
* tGravityAcc.std.X                  
* tGravityAcc.std.Y                   
* tGravityAcc.std.Z                  
* tBodyAccJerk.mean.X                 
* tBodyAccJerk.mean.Y                
* tBodyAccJerk.mean.Z                 
* tBodyAccJerk.std.X                 
* tBodyAccJerk.std.Y                  
* tBodyAccJerk.std.Z                 
* tBodyGyro.mean.X                    
* tBodyGyro.mean.Y                   
* tBodyGyro.mean.Z                    
* tBodyGyro.std.X                    
* tBodyGyro.std.Y                     
* tBodyGyro.std.Z                    
* tBodyGyroJerk.mean.X                
* tBodyGyroJerk.mean.Y               
* tBodyGyroJerk.mean.Z                
* tBodyGyroJerk.std.X                
* tBodyGyroJerk.std.Y                 
* tBodyGyroJerk.std.Z                
* tBodyAccMag.mean                    
* tBodyAccMag.std                    
* tGravityAccMag.mean                 
* tGravityAccMag.std                 
* tBodyAccJerkMag.mean                
* tBodyAccJerkMag.std                
* tBodyGyroMag.mean                   
* tBodyGyroMag.std                   
* tBodyGyroJerkMag.mean               
* tBodyGyroJerkMag.std               
* fBodyAcc.mean.X                     
* fBodyAcc.mean.Y                    
* fBodyAcc.mean.Z                     
* fBodyAcc.std.X                     
* fBodyAcc.std.Y                      
* fBodyAcc.std.Z                     
* fBodyAcc.meanFreq.X                 
* fBodyAcc.meanFreq.Y                
* fBodyAcc.meanFreq.Z                 
* fBodyAccJerk.mean.X                
* fBodyAccJerk.mean.Y                 
* fBodyAccJerk.mean.Z                
* fBodyAccJerk.std.X                  
* fBodyAccJerk.std.Y                 
* fBodyAccJerk.std.Z                  
* fBodyAccJerk.meanFreq.X            
* fBodyAccJerk.meanFreq.Y             
* fBodyAccJerk.meanFreq.Z            
* fBodyGyro.mean.X                    
* fBodyGyro.mean.Y                   
* fBodyGyro.mean.Z                    
* fBodyGyro.std.X                    
* fBodyGyro.std.Y                     
* fBodyGyro.std.Z                    
* fBodyGyro.meanFreq.X                
* fBodyGyro.meanFreq.Y               
* fBodyGyro.meanFreq.Z                
* fBodyAccMag.mean                   
* fBodyAccMag.std                     
* fBodyAccMag.meanFreq               
* fBodyBodyAccJerkMag.mean            
* fBodyBodyAccJerkMag.std            
* fBodyBodyAccJerkMag.meanFreq        
* fBodyBodyGyroMag.mean              
* fBodyBodyGyroMag.std                
* fBodyBodyGyroMag.meanFreq          
* fBodyBodyGyroJerkMag.mean           
* fBodyBodyGyroJerkMag.std           
* fBodyBodyGyroJerkMag.meanFreq       
* angle.tBodyAccMean.gravity         
* angle.tBodyAccJerkMean.gravityMean  
* angle.tBodyGyroMean.gravityMean    
* angle.tBodyGyroJerkMean.gravityMean 
* angle.X.gravityMean                
* angle.Y.gravityMean                 
* angle.Z.gravityMean                
* src

### Activities
* 1 - WALKING
* 2 - WALKING_UPSTAIRS
* 3 - WALKING_DOWNSTAIRS
* 4 - SITTING
* 5 - STANDING
* 6 - LAYING

### Variables
* _testDataFile_        - contains file location of the test data set (X_test.txt)
* _testActivityFile_    - contains file location of the test activity file (y_test.txt)
* _testSubjectFile_     - contains file location of the test subject file (subject_test.txt)
* _trainDataFile_       - contains file location of the test data set (X_train.txt)
* _trainActivityFile_   - contains file location of the test activity file (y_train.txt)
* _trainSubjectFile_    - contains file location of the test subject file (subject_train.txt)
* _variableNameFile_    - contains file location of the names of the variables (features.txt)
* _activityLookupFile_  - contains file location of the activity codes and names (activity_labels.txt)

* _testData_            - data table that contains the test data
* _testActData_         - data table that contains the activity codes for the test data
* _testSubject_         - data table that contains the subject codes for the test data
* _trainData_           - data table that contains the training data
* _trainActData_        - data table that contains the activity codes for the training data
* _trainSubject_        - data table that contains the subject codes for the test data
* _variableNames_       - data table that holds the variable names
* _activityNames_       - data table that holds the activity codes and descriptions

### Processing
1) All of the files are loaded into data tables using fread
2) The variable names in the _variableNames_ data table are transformed to remove parentheticals, and dashes
3) An additional field is added to the training and test data called "src", that indicates which data set (train or test) the data is from
4) The subject data and activity data is added to both the training and test data using the cbind function
5) The activity data including the activity description is merged with the test and training data
6) The test and training data is merged into 1 data table called _allDataMerged_.
7) The variable names that were transformed in (2) are applied to _allDataMerged_.
8) A subset of the columns that contains the activity information, subject and variables that contain means or standard deviations is used to create a new data table _meanStdData_.
9) A grouping of the data by Activity, Activity Description, and subject is created and loaded into _avgMeanStdData_.
10) The _avgMeanData_ data table is created that is a summary of the means of the columns from _avgMeanStdData_ grouped by Activity, Activity Description, and subject.
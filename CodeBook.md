---
title: "CodeBook.md"
author: "Jim Hammond"
date: "November 13, 2016"
output: html_document
---

## R Markdown

This is an R Markdown document and contains the description of the data structures and
transformation performed for the last project of "Getting and Cleaning Data"

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
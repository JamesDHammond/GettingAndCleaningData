---
title: "README.MD"
author: "Jim Hammond"
date: "November 14, 2016"
output: html_document
---

## R Markdown
* Only one script was created for this project run_analysis.R. It is uploaded separately. See CodeBook.md for the variables as well as a description of the processing, which is also included below as per the instructions for the project.

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
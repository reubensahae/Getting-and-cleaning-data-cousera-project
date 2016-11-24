---
title: "Getting & Cleaning Data-Coursera Project Week-4 README"
author: "Reuben Sahae"

---

## Introduction

This project is known as:Human Activity recognition using Smartphones

The dataset used for thsi project is:http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The complete code for this project is in run_analysis.R

CodeBook.md describes the variables, the data, and any transformations that were performed to clean up the data.

The full documentation of the variables used is given in the codebook: codebook1.md

This document will state all the steps undertaken..

First Steps 

* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Click on the above link and download the zip file and extract it at a particular location.
  eg:Desktop 

* The zip will get extracted as a folder known as "UCI HAR Dataset",copy the path to this folder.

* Setting this folder as the working directory, later on while coding, is recommended

* All Set to Code

# Steps before Running Analysis

*Load 'plyr' package (created by Hadley Wickham)

In case, 'plyr' package is not installed..

Use install.packages("plyr") to do so.

To load this package:
```{r}
library(plyr)
```

* Set Working directory

As mentioned earlier, it is recommended to use "UCI HAR Dataset" folder location as the the working directory

Working directory can be set in the following manner:

setwd("your file path")


* Step 1: Read The Training and Test Data using read.table(), keep header = FALSE, and sep = ""


```{r}
#Read the training data
X_train<-read.table("./train/X_train.txt",header = FALSE,sep= "")
X_subject_train<-read.table("./train/subject_train.txt",header=FALSE,sep = "")
Y_train<-read.table("./train/Y_train.txt",header=FALSE,sep="")

#Read the test data
X_test<-read.table("./test/X_test.txt",header=FALSE,sep = "")
X_subject_test<-read.table("./test/subject_test.txt",header=FALSE,sep="")
Y_test<-read.table("./test/y_test.txt",header=FALSE,sep="")

```

Step 2 : Read Other files mentioned within the folder "UCI HAR Dataset" Foler
```{r}
#Loading features file
features<-read.table("./features.txt")
#Loading activity file
activity_labels<-read.table("activity_labels.txt") 

```

Solutions to Tasks:

# Task 1: Merge the training and the test sets to create one data set

* Steps Undertaken:

    1. Individually merged each training file with it's test file using rbind().Therefore, X_train is         merged with X_test, Y_train with Y_test, X_Subject_Train with X_subject_test
    
```{r}
X_Merge<-rbind(X_train,X_test)
Y_Merge<-rbind(Y_train,Y_test)
X_Subject_Merge<-rbind(X_subject_train,X_subject_test)
```
 
    2. All the merged files will be merged into one dataset later on.
    
    
# Task 2:	Extracts only the measurements on the mean and standard deviation for each measurement.

*  Steps Undertaken

    1. Convert features vector from factor to character using as.character
    
    ```{r}
#Convert 2nd column from factor to character type
features[,2]<-as.character(features[,2])

```

   2. Using grep and gsub, filter features vector for features containing "mean" / "sd" as text and  
      store that text in featuresWanted,Also Use gsub to clean feature vector values  
   
```{r}
 #Filter mean and sd from all measurements using grep and gsub
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)


```


   3.  Made a subset of X_Merge called extract1, this data frame contains only variables whose names        contain "mean" or "sd" as content.
   
```{r}
#extract only mean and sd by subsetting merged dataset
extract1 <- X_Merge[, featuresWanted]

```

# Task 3:	Uses descriptive activity names to name the activities in the data set


*  Steps Undertaken

    1. Convert activity_labels from factor to character using as.character
    
```{r}
#Convert 2nd column from factor to character type
activity_labels[,2]<-as.character(activity_labels[,2])

```

    2. Replaced Y_Merge factors like 1,2,3 with activity labels such as :Laying, Sleeping, Walking 
       etc.
```{r}
#Replaced activity labels with names
Y_Merge[,1]<-activity_labels[Y_Merge[,1],2]

```

# Task 4:	Appropriately label the data set with descriptive variable names

*  Steps Undertaken

    1. Filtered features vector to remove paranthesis using the gsub function.Labelled each data set 
       respectively 

```{r}
#Removing parantheses from 2nd column of features
features[,2] <- gsub('[-()]', '', features[,2])
#Labelling data sets respectively
names(X_Merge) <- c(features[,2])
names(X_Subject_Merge) <- c("Subject")
names(Y_Merge)<-c("Activity")


```
    2.  Merged all datasets into a combined data set "Final_data" using cbind function, hence   
        completed task 1 effectively.

```{r}
#Merge Into One called final_data
Final_data<-cbind(X_Merge,Y_Merge,X_Subject_Merge)
#this has 563 variables including subject and activity 

```

# Task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

*  Steps Undertaken

    1. Converted Activity and subject variable from character to factor using as.factor function    

```{r}
Final_data$Activity<-as.factor(Final_data$Activity)
Final_data$Subject<-as.factor(Final_data$Subject)
```
    2. Used ddply function to create a data frame "averages_data" which contains mean of all 
       variables, grouped by the ids subject and activity. 
    3. averages_data.txt is a tidy set created using write.table function over data frame   
       averages_data.

```{r}
#Used ddply function from dplyr package to perform mean function based on subject and activity
averages_data <- ddply(Final_data, .(Subject, Activity), function(x) colMeans(x[, 1:561]))
write.table(averages_data, "averages_data.txt")

```



   
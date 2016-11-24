
library(plyr)

#Set Working directory to the folder that contains dataset
setwd("/Users/Magic/Desktop/Coursera\ John\ Hopkins\ R\ Training/3.\ Getting\ and\ Cleaning\ Data/PROJECT/UCI\ HAR\ Dataset")

#Read the training data
X_train<-read.table("./train/X_train.txt",header = FALSE,sep= "")
X_subject_train<-read.table("./train/subject_train.txt",header=FALSE,sep = "")
Y_train<-read.table("./train/Y_train.txt",header=FALSE,sep="")


#Read the test data
X_test<-read.table("./test/X_test.txt",header=FALSE,sep = "")
X_subject_test<-read.table("./test/subject_test.txt",header=FALSE,sep="")
Y_test<-read.table("./test/y_test.txt",header=FALSE,sep="")

#Loading features file
features<-read.table("./features.txt")
#Loading activity file
activity_labels<-read.table("activity_labels.txt")  

#-------------------------------------------------
#1.	Merges the training and the test sets to create one data set
#-------------------------------------------------------------------------
#merged both ytrain and test data sets using rbind

X_Merge<-rbind(X_train,X_test)
Y_Merge<-rbind(Y_train,Y_test)
X_Subject_Merge<-rbind(X_subject_train,X_subject_test)


#--------------------------------------------------------------------------
#2.	Extracts only the measurements on the mean and standard deviation for each measurement.
#----------------------------------------------------------------------------  
  

#Convert 2nd column from factor to character type
features[,2]<-as.character(features[,2])

#Filter mean and sd from all measurements using grep and gsub
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

#extract only mean and sd by subsetting merged dataset
extract1 <- X_Merge[, featuresWanted]

------------------------------------------------------------------------------------
#3.	Uses descriptive activity names to name the activities in the data set
------------------------------------------------------------------------------------  

#Convert 2nd column from factor to character type
activity_labels[,2]<-as.character(activity_labels[,2])
#Replaced activity labels with names
Y_Merge[,1]<-activity_labels[Y_Merge[,1],2]
#-----------------------------------------------------------------------------------
#4.	Appropriately label the data set with descriptive variable names
#-----------------------------------------------------------------------------------

#Removing parantheses from 2nd column of features
features[,2] <- gsub('[-()]', '', features[,2])
#Labelling data sets respectively
names(X_Merge) <- c(features[,2])
names(X_Subject_Merge) <- c("Subject")
names(Y_Merge)<-c("Activity")

#Merge Into One called final_data
Final_data<-cbind(X_Merge,Y_Merge,X_Subject_Merge)
#this has 563 variables including subject and activity 
#------------------------------------------------------------------------------------
#5.	From the data set in step 4, creates a second, independent tidy data set with
#   the average of each variable for each activity and each subject
#------------------------------------------------------------------------------------
Final_data$Activity<-as.factor(Final_data$Activity)
Final_data$Subject<-as.factor(Final_data$Subject)

#Used ddply function from dplyr package to perform mean function based on subject and activity
averages_data <- ddply(Final_data, .(Subject, Activity), function(x) colMeans(x[, 1:561]))
write.table(averages_data, "averages_data.txt")


#------------------------------------------------------------------------------------



---
title: "Getting & Cleaning Data-Coursera Project Week 4- Codebook"
author: "Reuben Sahae"

output: html_document
---

## Variable List & Description
The variables/objects have been described in a particular sequence based on their introduction in 
run_analysis.R

X_train       =   Dataframe used to store training data from file X_train.txt
                  
X_subject_train = Dataframe used to store training data of subject.(subject_train.txt)

Y_train       =   Dataframe used to store training data from Y_train.txt(Activity training data)

X_test        =   Dataframe used to store test data from file X_test.txt

X_subject_test =  Dataframe used to store test data of subject.(subject_test.txt)

Y_test         =  Dataframe used to store test data from Y_test.txt(Activity test data)

features       =  Datframe used to store features.txt data

activity_labels = Dataframe used to store activity_labels.txt data

X_Merge        =  Merged data frame of X_train and X_test dataframes.

Y_Merge        =  Merged data frame of Y_train and Y_test dataframes.

X_Subject_Merge = Merged data frame of X_subject_train and X_subject_test dataframes

featuresWanted = Dataframe created to store 2nd column of features based on the "mean" & "std" filter

extract1      =  Data frame that only contains variables who names have "mean" or "std"  

Final_data    =  Final merged data frame of X_Merge, Y_Merge, X_Subject_Merge

averages_data =  Data frame used to store average of all variables based on subject and activity.







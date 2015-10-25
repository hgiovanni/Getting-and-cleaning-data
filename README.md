# Getting-and-cleaning-data
Script of the course project (Coursera Getting and Cleaning Data)
## download file and unzip
This part create a file to download the zip file from the provided Url, then unzip the content of the zip file in the working directory.
It was not a part of the project, but I enjoy how to unzip files using r
## reading features.txt for name labels
Reads the features and set as character for use in step 2
## reading datasets
Reads datasets using data.table, use following args:  header = F, col.names, sep: ""
## 1.  Merge train and test dataset
Merge the train datasets using cbind
Merge the test datasets using cbind
Merte the test and train dataset using rbind
## 2.  Extract only mean and std measurements
I use grep to create a vector of the columns wich includes "mean" and "std"
I use this vector to subsetting mean and std columns, also including subject and activities
## 3. Uses descriptive activity names to name the activities in the data set
I create a loop for rename the variables
## 4.  Appropriately labels the data set with descriptive variable names.
Nothing to do, column names already assigned
## 5.  Creates a tidy data set with the average of each variable for each activity and each subject.
I use the package dplyr, group by subject and activities
Use the summarise_each tool for the tidy data set, funs(mean)
## Finally Print
Print the tidy data set

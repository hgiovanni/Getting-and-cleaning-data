## Course Project Getting and cleaning data
## download file and unzip
  file.create("tempfile.zip")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","tempfile.zip")
  unzip("tempfile.zip", exdir = "./")
## reading features (for labels)
  features <- read.table("./UCI HAR Dataset/features.txt", header = F, sep = "")
  features <- as.character(features[,2])
## reading datasets
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject", sep = "")
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features, header = F, sep = "", na.strings = "NA")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = "Activities", sep = "", na.strings = "NA")
## reading train folder
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject", sep = "")
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features, header = F, sep = "", na.strings = "NA")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = "Activities", sep = "", na.strings = "NA")
  ## 1.  Merges the training and the test sets to create one data set.
    ## Follow the principles of tidy data:
    ## * One column per variable
    ## * Each observation in a different row
    ## * One table for "each" kind of variable
    ## * If there are multiple tables, a column need to be identified as a link
    ## merge test dataframe
      all_test <- cbind(subject_test, y_test)
      all_test <- cbind(all_test, x_test)
    ## merge train dataframe
      all_train <- cbind(subject_train, y_train)
      all_train <- cbind(all_train, x_train)
    ## merge test and train dataframe
      test_train <- rbind(all_test, all_train)
## 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
      ## extract columns for mean and standar deviation
      meancols <- grep("mean", colnames(test_train))
      stdcols <- grep("std", colnames(test_train))
      mean_std <- mean_std <- c(1, 2, meancols, stdcols)
      mean_std <- test_train[,mean_std]
## 3. Uses descriptive activity names to name the activities in the data set (mean_std)
      activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = F, col.names = c("Number", "Activity"))
      for (i in 1:nrow(mean_std)) {
        if (mean_std$Activities[i] == 1) { mean_std$Activities[i] <- "WALKING"}   
        if (mean_std$Activities[i] == 2) { mean_std$Activities[i] <- "WALKING_UPSTAIRS"}
        if (mean_std$Activities[i] == 3) { mean_std$Activities[i] <- "WALKING_DOWNSTAIRS"}
        if (mean_std$Activities[i] == 4) { mean_std$Activities[i] <- "SITTING"}
        if (mean_std$Activities[i] == 5) { mean_std$Activities[i] <- "STANDING"}
        if (mean_std$Activities[i] == 6) { mean_std$Activities[i] <- "LAYING"}
      }
## 4. Appropriately labels the data set with descriptive variable names.
      ## labels for subject, activities and measurements were already assigned 
      ##  when reading data using col.names argument
      
## 5. From the data set in step 4, creates a second, independent tidy data set
##    with the average of each variable for each activity and each subject.
      library(dplyr)
      tidy <- group_by(mean_std, Subject, Activities)  ## group by subject and activities
      tidy <- summarise_each(tidy, funs(mean))
## upload 
      write.table(tidy, file = "tidy.txt", row.name = F)
## print the tidy data set
      print(tidy)

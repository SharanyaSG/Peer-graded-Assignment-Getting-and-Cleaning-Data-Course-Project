#-----------------------------------------------------------------------------------------------------
## DATA PREPERATION
#-----------------------------------------------------------------------------------------------------
# Checking and creating directory
  if (!file.exists ("./data"))
    {
    dir.create("./data")
  }
  # Downloading data set using the given URL
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file (fileURL, destfile = "./data/Dataset.zip", method="curl")
  # Unzipping data set 
  unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

#-----------------------------------------------------------------------------------------------------
## RESPONSE TO PROJECT REQUIREMENTS
#-----------------------------------------------------------------------------------------------------

## *** REQUIREMENT 1 - Merge the training and the test sets to create one data set.***

  ## Step 1 - Read activity label file 
  activity_labels <- read.table ("./data/UCI HAR Dataset/activity_labels.txt")
  
  ## Step 2 - Read all feature table 
  features_info <- read.table ("./data/UCI HAR Dataset/features_info.txt")
  features <- read.table ("./data/UCI HAR Dataset/features.txt")
  
  ## Step 3 - Read all tables under the Test file
  subject_test <- read.table ("./data/UCI HAR Dataset/test/subject_test.txt")
  X_test <- read.table ("./data/UCI HAR Dataset/test/X_test.txt")
  Y_test <- read.table ("./data/UCI HAR Dataset/test/Y_test.txt")
  
  ## Step 4 - Read all tables under the Train file
  subject_train <- read.table ("./data/UCI HAR Dataset/train/subject_train.txt")
  X_train <- read.table ("./data/UCI HAR Dataset/train/X_train.txt")
  Y_train <- read.table ("./data/UCI HAR Dataset/train/Y_train.txt")
  
  ## Step 5 - Assign column names to Test sets
  colnames(X_test) <- features[ ,2]
  colnames(Y_test) <- "ActivityID"
  colnames(subject_test) <- "SubjectID"
  
  ## Step 6 - Assign column names to Train sets
  colnames(X_train) <- features[ ,2]
  colnames(Y_train) <- "ActivityID"
  colnames(subject_train) <- "SubjectID"
  
  ## Step 6 - Assign column names to Activity Labels
  colnames(activity_labels) <- c('ActivityID', 'ActivityType')
  
  ## Step 7 - Merge all data sets into one set
  merge_test <- cbind(X_test, Y_test, subject_test)
  merge_train <- cbind(X_train, Y_train, subject_train)
  merge_test_train <- rbind(merge_test, merge_train)

## *** REQUIREMENT 2 - Extract only the measurements on the mean and standard deviation for each measurement. *** 
  
  ##STEP 1 - Read all column names from the merged data set
  colnames <- colnames(merge_test_train)
  
  ##STEP 2 - Create a vector for the Activity ID, Subject ID, Mean and Standard Deviation.
  measure_m_std <- (grepl("ActivityID",colnames) | grepl("SubjectID",colnames) | grepl("mean..",colnames) | grepl("std..",colnames))
  
  ##STEP 3 - Create a subset of the means and standard deviations from the merged data set
  subset_m_std <- merge_test_train[ , measure_m_std == TRUE]
 
## *** REQUIREMENT 3 - Use descriptive activity names to name the activities in the data set *** 
  desc_activity_names <- merge (subset_m_std, activity_labels, by = 'ActivityID', all.x=TRUE)
  
## *** REQUIREMENT 4 - Appropriately label the data set with descriptive variable names.*** 
  #Done while completing Requirements 1 - 3
  
## *** REQUIREMENT 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.***
  
  ##STEP 1 - Create a second tidy data set.
  tidy_data_again <- aggregate(. ~SubjectID + ActivityID, desc_activity_names, mean)
  tidy_data_again <- tidy_data_again[order(tidy_data_again$SubjectID, tidy_data_again$ActivityID), ]

  ##STEP 2 - Write the second tidy data set into a text file. 
  write.table(tidy_data_again, "SecondTidyDataset.txt", row.name = FALSE)
 
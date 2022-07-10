#-----------------------------------------------------------------------------------------------------
## LOAD PACKAGES
#-----------------------------------------------------------------------------------------------------
  library(dplyr)

#-----------------------------------------------------------------------------------------------------
## DATA PREPERATION
#-----------------------------------------------------------------------------------------------------
  filename <- "DS3_Project.zip"
  # Check if archive exists
    if (!file.exists(filename))
      {
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename, method="curl")
      }  
  # Checking if folder exists
    if (!file.exists("UCI HAR Dataset")) 
      { 
        unzip(filename) 
      }

#-----------------------------------------------------------------------------------------------------
## READ DATA AND ASSIGN COLUMN NAMES
#-----------------------------------------------------------------------------------------------------
## Step 1 - Read and assign column names to table in the activity label file 
  activity_labels <- read.table ("UCI HAR Dataset/activity_labels.txt", col.names= c("ID", "Activity"))

## Step 2 - Read and assign column names to table in the feature file 
  features <- read.table ("UCI HAR Dataset/features.txt", col.names= c("FeatureID", "FeatureType"))

## Step 3 - Read and assign column names to all tables under the Test file
  X_test <- read.table ("UCI HAR Dataset/test/X_test.txt", col.names= features$FeatureType)
  Y_test <- read.table ("UCI HAR Dataset/test/y_test.txt", col.names="ID" )
  subject_test <- read.table ("UCI HAR Dataset/test/subject_test.txt", col.names= "Subject")

## Step 4 - Read and assign column names to all tables under the Train file
  X_train <- read.table ("UCI HAR Dataset/train/X_train.txt", col.names= features$FeatureType)
  Y_train <- read.table ("UCI HAR Dataset/train/y_train.txt", col.names="ID")
  subject_train <- read.table ("UCI HAR Dataset/train/subject_train.txt", col.names= "Subject")

#-----------------------------------------------------------------------------------------------------
## RESPONSE TO PROJECT REQUIREMENTS
#-----------------------------------------------------------------------------------------------------

## *** REQUIREMENT 1 - Merge the training and the test sets to create one data set.***
  merge_X <- rbind(X_test, X_train)
  merge_Y <- rbind(Y_test, Y_train)
  merge_Subject <- rbind(subject_test, subject_train)
  merge_Data <- cbind(merge_Subject, merge_X, merge_Y)

## *** REQUIREMENT 2 - Extract only the measurements on the mean and standard deviation for each measurement. *** 
  First_Tidy_Data <- merge_Data %>% select(Subject, ID, contains("mean"), contains("std"))

## *** REQUIREMENT 3 - Use descriptive activity names to name the activities in the data set *** 
  First_Tidy_Data$ID <- activity_labels[First_Tidy_Data$ID, 2]

## *** REQUIREMENT 4 - Appropriately label the data set with descriptive variable names.*** 
  names(First_Tidy_Data)[2] = "activity"
  names(First_Tidy_Data)<-gsub("Acc", "Accelerometer", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("Gyro", "Gyroscope", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("BodyBody", "Body", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("Mag", "Magnitude", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("^t", "Time", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("^f", "Frequency", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("tBody", "TimeBody", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("-mean()", "Mean", names(First_Tidy_Data), ignore.case = TRUE)
  names(First_Tidy_Data)<-gsub("-std()", "STD", names(First_Tidy_Data), ignore.case = TRUE)
  names(First_Tidy_Data)<-gsub("-freq()", "Frequency", names(First_Tidy_Data), ignore.case = TRUE)
  names(First_Tidy_Data)<-gsub("angle", "Angle", names(First_Tidy_Data))
  names(First_Tidy_Data)<-gsub("gravity", "Gravity", names(First_Tidy_Data))

## *** REQUIREMENT 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.***
  Second_Tidy_Data <- First_Tidy_Data %>%
    group_by(Subject, activity) %>%
    summarise_all(funs(mean))
  write.table(Second_Tidy_Data, "Tidy Data.txt", row.name=FALSE, quote = FALSE, sep = '\t')

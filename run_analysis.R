## Getting and cleaning data project assignment week 4

## Download the data 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data1/Dataset.zip")

## Unzip the files

unzip(zipfile="./data1/Dataset.zip",exdir="./data1")

## View and select the necesary files

list.files("./data1/Dataset.zip")
path1 <- file.path("./data1" , "UCI HAR Dataset")
files<-list.files(path1, recursive=TRUE)
files

## 1. Merges the training and the test sets to create one data set.

# Reading the necessary files

x_train = read.table(file.path(path1, "train", "X_train.txt"),col.names = features$functions)
y_train = read.table(file.path(path1, "train", "y_train.txt"),col.names = "code")
subject_train = read.table(file.path(path1, "train", "subject_train.txt"), col.names = "subject")
x_test = read.table(file.path(path1, "test", "X_test.txt"),col.names = features$functions)
y_test = read.table(file.path(path1, "test", "y_test.txt"),col.names = "code")
subject_test = read.table(file.path(path1, "test", "subject_test.txt"),col.names = "subject")
features = read.table(file.path(path1, "features.txt"),col.names = c("n","functions"))
activity_Labels = read.table(file.path(path1, "activity_labels.txt"),col.names = c("code", "activity")))

# Merge the data

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
All_Data <- cbind(Subject, y, x)

## 3. Extracts only the measurements on the mean and standard deviation for each measurement.

library(dplyr)

mean_sd_Data <-All_Data %>% select(subject, code, contains("mean"), contains("std"))
mean_sd_Data$code <- activity_Labels[mean_sd_Data$code, 2]

## 4. Appropriately labels the data set with descriptive variable names

names(mean_sd_Data)[2] = "activity"
names(mean_sd_Data)<-gsub("Acc", "Accelerometer", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("Gyro", "Gyroscope", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("BodyBody", "Body", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("Mag", "Magnitude", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("^t", "Time", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("^f", "Frequency", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("tBody", "TimeBody", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("-mean()", "Mean", names(mean_sd_Data), ignore.case = TRUE)
names(mean_sd_Data)<-gsub("-std()", "STD", names(mean_sd_Data), ignore.case = TRUE)
names(mean_sd_Data)<-gsub("-freq()", "Frequency", names(mean_sd_Data), ignore.case = TRUE)
names(mean_sd_Data)<-gsub("angle", "Angle", names(mean_sd_Data))
names(mean_sd_Data)<-gsub("gravity", "Gravity", names(mean_sd_Data))

## 5. From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.

New_Data <- mean_sd_Data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean))
write.table(New_Data, "FinalData.txt", row.name=FALSE)

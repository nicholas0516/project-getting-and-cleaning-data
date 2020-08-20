---
title: "codebook project"
output: 
  html_document:
    keep_md: true
---

## DATASET

- the data is in the folder "UCI HAR Dataset"

## VARIABLES
 
- `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
- `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
- `features` contains the correct names for the `x_data` dataset.
- `New_data` contain the average of each variable for each activity and each subject.
- `àll_data` containall the merged data.

## R script guide 
 
- Downlaod the data of the page http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each 
activity and each subject.

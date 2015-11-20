Course Project- getting and cleaning data 11/20/15
=========================================

Intro
-----------------------------------------
Coursera course "Getting and Cleaning data" - Coursera/JHU - Data Science specialization.



Data
-----------------------------------------
source:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
data used:
http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

File naming conventions:
```sh
x_ = features
y_ = activities
subject_ = subjects or users
```

Run_analysis.R script
-----------------------------------------
The "UCI HAR Dataset" must be unzipped in the working directory before the run_analysis.R script can be run.
run_analysis.R will read the necessary files, and create a tidy data set containing one row for each user and activity 
with descriptively named averages for each average and standard deviation value collected for the activity.  Run_analysis.R 
will output the dataset in the working directory as tidy.txt.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Code Book
-----------------------------------------
CodeBook.md steps through each of the data transformation steps and describes the resulting tidy.txt dataset. 
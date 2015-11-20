If you haven't already, you'll need to download and unzip the .zip file into the working directory  before you can run the run_analysis.R script 

```sh
setwd()
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
```


You'll need to have two libraries installed to run the script
```sh
library(reshape)
library(dplyr)
```



First step in the run_analysis.R fil is to import each of the 8 tables that will be used to create the tidy data set.
```sh
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./GettingandCleaning/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./GettingandCleaning/UCI HAR Dataset/activity_labels.txt")
```

The test and train data sets are formatted the same way, so we'll use rbind to create combined files for x_, y_, and subject.
```sh
x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
sub_all <- rbind(sub_train, sub_test)
```

None of these files have variable names
```sh
names(x_all) #561 vars
names(y_all) #1 var
names(sub_all) # 1 var
```


Add names to each of the three combined datasets, x_ has 561 variables that allign to the 561 names in feature.txt.  subject and activity each contain one variable and are named.
```sh
names(x_all) <- features[,2]
colnames(sub_all) <- "subject"
colnames(y_all) <- "activity"
```

The tidy dataset only needs to keep the variables with std() or mean() in the name, so all other variables are removed and x_all_mn_std is created with just the required values.
```sh
mean_cols <- grep("mean\\(\\)", features$V2)
std_cols <- grep("std\\(\\)", features$V2)
x_all_mn_std <-x_all [, c(mean_cols, std_cols)]
```
Combine all three data sets into one set
```sh
df <- cbind(cbind(sub_all, y_all), x_all_mn_std)
```

Use the activity_labels file to replace the activity code with the full text version
```sh
df$activity <- sapply(df$activity, function(x) activity_labels[x, 2])
```


From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Use melt function from reshape package to group by subject and activity
```sh
melted <- melt(df, id = c("subject", "activity"))
```

Use cast function from reshape package to add mean of each variable to each unique subject/activity.
```sh
tidy <- cast(melted, subject + activity ~ variable, mean)
```

The tidy data set includes 180 rows and 68 columns with one row for each of the 30 subjects for each of the 6 activities included(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
The value for each of the remaining variables are the mean for that subject and activity.  Thes means are expressed in3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz captured from the embedded accelerometer and gyroscope of Samsung Galaxy S IIs.

```sh
 "subject"                  
 "activity"                    
 "tBodyAcc-mean()-X"           
 "tBodyAcc-mean()-Y"           
 "tBodyAcc-mean()-Z"           
 "tGravityAcc-mean()-X"        
 "tGravityAcc-mean()-Y"       
 "tGravityAcc-mean()-Z"       
 "tBodyAccJerk-mean()-X"       
 "tBodyAccJerk-mean()-Y"       
 "tBodyAccJerk-mean()-Z"      
 "tBodyGyro-mean()-X"         
 "tBodyGyro-mean()-Y"         
 "tBodyGyro-mean()-Z"         
 "tBodyGyroJerk-mean()-X"     
 "tBodyGyroJerk-mean()-Y"      
 "tBodyGyroJerk-mean()-Z"      
 "tBodyAccMag-mean()"         
 "tGravityAccMag-mean()"      
 "tBodyAccJerkMag-mean()"     
 "tBodyGyroMag-mean()"        
 "tBodyGyroJerkMag-mean()"     
 "fBodyAcc-mean()-X"           
 "fBodyAcc-mean()-Y
 "fBodyAcc-mean()-Z"         
 "fBodyAccJerk-mean()-X"      
 "fBodyAccJerk-mean()-Y"      
 "fBodyAccJerk-mean()-Z"      
 "fBodyGyro-mean()-X"          
 "fBodyGyro-mean()-Y"         
 "fBodyGyro-mean()-Z"         
 "fBodyAccMag-mean()"          
 "fBodyBodyAccJerkMag-mean()"  
 "fBodyBodyGyroMag-mean()"     
 "fBodyBodyGyroJerkMag-mean()"
 "tBodyAcc-std()-X"            
 "tBodyAcc-std()-Y"            
 "tBodyAcc-std()-Z"            
 "tGravityAcc-std()-X"         
 "tGravityAcc-std()-Y"        
 "tGravityAcc-std()-Z"         
 "tBodyAccJerk-std()-X"       
 "tBodyAccJerk-std()-Y"       
 "tBodyAccJerk-std()-Z"        
 "tBodyGyro-std()-X"           
 "tBodyGyro-std()-Y"           
 "tBodyGyro-std()-Z"           
 "tBodyGyroJerk-std()-X"       
 "tBodyGyroJerk-std()-Y"      
 "tBodyGyroJerk-std()-Z"      
 "tBodyAccMag-std()"           
 "tGravityAccMag-std()"        
 "tBodyAccJerkMag-std()"       
 "tBodyGyroMag-std()"          
 "tBodyGyroJerkMag-std()"      
 "fBodyAcc-std()-X"           
 "fBodyAcc-std()-Y"           
 "fBodyAcc-std()-Z"            
 "fBodyAccJerk-std()-X"        
 "fBodyAccJerk-std()-Y"        
 "fBodyAccJerk-std()-Z"        
 "fBodyGyro-std()-X"           
 "fBodyGyro-std()-Y"          
 "fBodyGyro-std()-Z"           
 "fBodyAccMag-std()"           
 "fBodyBodyAccJerkMag-std()"   
 "fBodyBodyGyroMag-std()"      
 "fBodyBodyGyroJerkMag-std()" 
 ```
 
 
 

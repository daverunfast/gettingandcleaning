library(reshape)
library(dplyr)

#import tables
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")


#1. Merges the training and the test sets to create one data set.
x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
sub_all <- rbind(sub_train, sub_test)

#check variables in each set
names(x_all) #561 vars
names(y_all) #1 var
names(sub_all) # 1 var

#add names to data sets
names(x_all) <- features[,2]
colnames(sub_all) <- "subject"
colnames(y_all) <- "activity"

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_cols <- grep("mean\\(\\)", features$V2)
std_cols <- grep("std\\(\\)", features$V2)
x_all_mn_std <-x_all [, c(mean_cols, std_cols)]

#combine all three data sets
df <- cbind(cbind(sub_all, y_all), x_all_mn_std)


#3. Uses descriptive activity names to name the activities in the data set
df$activity <- sapply(df$activity, function(x) activity_labels[x, 2])


#4. Appropriately labels the data set with descriptive variable names. 
# Done in add names in step one


#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
melted <- melt(df, id = c("subject", "activity"))
tidy <- cast(melted, subject + activity ~ variable, mean)
write.table(tidy, file="tidy.txt", row.names = FALSE)
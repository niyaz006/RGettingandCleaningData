## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Initialize

library(reshape2)
filename <- "getdata_dataset.zip"

# Download and unzip the dataset

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels and features

activityLabel <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabel[,2] <- as.character(activityLabel[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation

featuresReq <- grep(".*mean.*|.*std.*", features[,2])
featuresReq.names <- features[featuresReq,2]
featuresReq.names = gsub('-mean', 'Mean', featuresReq.names)
featuresReq.names = gsub('-std', 'Std', featuresReq.names)
featuresReq.names <- gsub('[-()]', '', featuresReq.names)


# Load the datasets
 
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubject, trainActivity, read.table("UCI HAR Dataset/train/X_train.txt")[featuresReq])

testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubject, testActivity, read.table("UCI HAR Dataset/test/X_test.txt")[featuresReq])

# Merge datasets and add labels

data <- rbind(train, test)
colnames(data) <- c("subject", "activity", featuresReq.names)

# Convert activities & subjects into factors

data$activity <- factor(data$activity, levels = activityLabel[,1], labels = activityLabel[,2])
data$subject <- as.factor(data$subject)

data.melted <- melt(data, id = c("subject", "activity"))
data.mean <- dcast(data.melted, subject + activity ~ variable, mean)

# Create tidy data file

write.table(data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
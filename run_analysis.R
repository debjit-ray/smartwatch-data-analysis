#---------------------------------------------------------------------------------------------------------------------
# Load all the required libraries
#---------------------------------------------------------------------------------------------------------------------
library(plyr)
library(dplyr)
library(stringr)

#---------------------------------------------------------------------------------------------------------------------
# Read the relevant files to the corresponding dataframes
#---------------------------------------------------------------------------------------------------------------------
# activity_labels.txt contains the mapping of activity code against the activity name
activityLabels <- read.table("./data/activity_labels.txt", sep = " ",
                             col.names = c("activityID", "activityName"))
# features.txt contains the list of feature names against a serial number
features <- read.table("./data/features.txt", sep = " ",
                       col.names = c("slNo", "featureName"))

#---------------------------------------------------------------------------------------------------------------------
## Gather all the relevant files and data identified as the training datasets
#---------------------------------------------------------------------------------------------------------------------
# X_test.txt contains the list of all the relevant observations which were classified as the testing dataset
xTestSet <- read.table("./data/test/X_test.txt", col.names = unlist(features$featureName))
# subject_test.txt contains the list of the unique people whose data has been collected here. 
subjectTestSet <- read.table("./data/test/subject_test.txt", col.names = "subjectID")
# y_test.txt contains the list of the activity being monitored.
yTestSet <- read.table("./data/test/y_test.txt", col.names = "activityID")
# collate the testing dataset into a single dataframe to include the subject ID and activity ID
testDF <- cbind(yTestSet, subjectTestSet, xTestSet)

    
# X_train.txt contains the list of all the relevant observations which were classified as the training dataset
xTrainSet <- read.table("./data/train/X_train.txt", col.names = unlist(features$featureName))
# subject_train.txt contains the list of the unique people whose data has been collected here. 
subjectTrainSet <- read.table("./data/train/subject_train.txt", col.names = "subjectID")
# y_train.txt contains the list of the activity being monitored.
yTrainSet <- read.table("./data/train/y_train.txt", col.names = "activityID")
# collate the training dataset into a single dataframe to include the subject ID and activity ID
trainDF <- cbind(yTrainSet, subjectTrainSet, xTrainSet)

#---------------------------------------------------------------------------------------------------------------------
# Merge the training and test datasets to form one combined dataset
#---------------------------------------------------------------------------------------------------------------------
mergedDF <- rbind(testDF, trainDF)

# Convert to dplyr dataframe
mergedTBL_DF <- tbl_df(mergedDF)

# Extract only the activity ID, subject ID and the columns that contain the mean or standard deviations
selectedCols_DF <- select(mergedTBL_DF,"activityID", "subjectID",contains("mean"), contains("std"))

# Include the activity name in the dataframe
outputData_DF <- join(activityLabels, selectedCols_DF, by = "activityID")

# Format the column names to a more readable format
df_colname <- colnames(outputData_DF)
df_colname <- (sub(pattern = "^t", replacement = "Time", x = df_colname))
df_colname <- (sub(pattern = "^f", replacement = "FFT", x = df_colname))
df_colname <- (sub(pattern = "Acc", replacement = "Accelerometer", x = df_colname))
df_colname <- (sub(pattern = "Gyro", replacement = "Gyroscope", x = df_colname))
df_colname <- (sub(pattern = "gravity", replacement = "Gravity", x = df_colname))
df_colname <- (sub(pattern = "Mag", replacement = "Magnitude", x = df_colname))
df_colname <- (sub(pattern = "tBody", replacement = "TimeBody", x = df_colname))
df_colname <- (sub(pattern = "angle", replacement = "Angle", x = df_colname))
df_colname <- (sub(pattern = "mean", replacement = "Mean", x = df_colname))
df_colname <- (sub(pattern = "std", replacement = "STD", x = df_colname))
#df_colname <- (sub(pattern = "+([a-zA-Z]+)+\1", replacement = "+([a-zA-Z]+)", x = df_colname))
colnames(outputData_DF) <-df_colname 

# Finally summarize the data to provide the means for each activity and each subject.  
summary_DF <- 
    outputData_DF %>%
    group_by(activityID, activityName,subjectID) %>%
    summarise_all(list(mean))

# Write the output to outpt datasets
write.table(outputData_DF, file = "./data/finalOutput.txt", row.names = FALSE)
write.table(summary_DF, file = "./data/summaryOutput.txt", row.names = FALSE)
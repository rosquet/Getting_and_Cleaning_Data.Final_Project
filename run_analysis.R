        ########################################################
        #               run_analysis.R                         #
        #                                                      #
        # Step 1. Initialize workspace, load libraries,        #
        #         create working directory                     #
        # Step 2. Download zipped data, unzip, read            #
        #         relevant files                               #
        # Step 3. Replace column names with more descriptive   #
        #         ones                                         #
        # Step 4. Create combined data set, find mean and      #
        #         standard deviation columns                   #
        # Step 5. Clean up column names, remove invalid        #
        #         characters                                   #
        # Step 6. Create final data set of the averages of     #
        #         each variable and each subject               #
        # Step 7. Replace activity numbers with activity names #
        ########################################################

        ########## Step 1 ##########

# Reinitialize workspace #

rm(list=ls())

# Load libraries #

library(dplyr)
library(data.table)

# Check for, create new directory. Set working directory #

if (!file.exists("~/R/HumanActivityRecognition/")) {
        dir.create("~/R/HumanActivityRecognition/")
}
setwd("~/R/HumanActivityRecognition/UCI HAR Dataset")

        ########## Step 2 ##########

# Download zip file, unzip #

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipData <- download.file(url, "zipData")
unzip("zipData")

# Read top-level files #

activityLabels = read.table("./activity_labels.txt", header = FALSE)
features = read.table("./features.txt", header = FALSE)

# Read test files #

subjectTest = read.table("./test/subject_test.txt", header = FALSE)
X_test = read.table("./test/X_test.txt", header = FALSE)
Y_test = read.table("./test/y_test.txt", header = FALSE)

# Read train files #

subjectTrain = read.table("./train/subject_train.txt", header = FALSE)
X_train = read.table("./train/X_train.txt", header = FALSE)
Y_train = read.table("./train/y_train.txt", header = FALSE)

        ########## Step 3 ##########

# Replace column names with more descriptive names #

colnames(activityLabels) = c("activity_id", "activity")
colnames(features) = c("timeDomainID", "timeDomainSignal")
colnames(subjectTest) = c("subject_id")
colnames(X_test) = features[,2]
colnames(Y_test) = "activity_id"
colnames(subjectTrain) = "subject_id"
colnames(X_train) = features[,2]
colnames(Y_train) = "activity_id"

        ########## Step 4 ##########

# Create complete training and test datasets #

trainData = cbind(Y_train, subjectTrain, X_train)
testData = cbind(Y_test, subjectTest, X_test)

# Create combined dataset #

HARdata = (rbind(trainData, testData))

# Find mean and standard deviation columns, build table of only
# these columns #

colnames = colnames(HARdata)
meanCols = grepl("*mean*", colnames)
stdCols = grepl("*std*", colnames)
meanStdData = (HARdata[(meanCols == TRUE | stdCols == TRUE)])

        ########## Step 5 ##########

# Change column names to more descriptive ones #

names(meanStdData) <- gsub(names(meanStdData), pattern = "^t", 
                           replacement = "Time\ ")
names(meanStdData) <- gsub(names(meanStdData), pattern = "*Body*", 
                           replacement = "\ Body\ ") 
names(meanStdData) <- gsub(names(meanStdData), pattern = "Acc", 
                           replacement = "\ Accelerometer\ ") 
names(meanStdData) <- gsub(names(meanStdData), pattern = "-mean()", 
                           replacement = "\ Mean\ ") 
names(meanStdData) <- gsub(names(meanStdData), pattern = "-std()", 
                           replacement = "\ StdDev\ ")
names(meanStdData) <- gsub(names(meanStdData), pattern = "Gyro", 
                           replacement = "\ Gyroscope\ ") 
names(meanStdData) <- gsub(names(meanStdData), pattern = "()-", 
                           replacement = "\ ") 
names(meanStdData) <- gsub(names(meanStdData), pattern = "Mag", 
                           replacement = "\ Magnitude\ ")
names(meanStdData) <- gsub(names(meanStdData), pattern = "^f", 
                           replacement = "\ Fast Fourier Transform\ ") 
names(meanStdData) <- gsub(names(meanStdData), pattern = "()", 
                       replacement = "")

# Remove invalid characters from new column names. This helps with
# later filtering #

valid_column_names <- make.names(names=names(meanStdData), unique=TRUE, 
                                 allow_ = TRUE)
names(meanStdData) <- valid_column_names

# Return activity and subject columns to meanStdData and rename #

meanStdData <- cbind(HARdata[,1:2], meanStdData)
names(meanStdData)[1] = "Activity"
names(meanStdData)[2] = "Subject"

        ########## Step 6 ##########

# Create a new, independent data set with the average of each 
# variable for each activity and each subject
# - Create finalData, an empty table of appropriate dimensions
# and with column names inherited from previous data set
# - Nested for loops populate finalData by creating 24 (subject)
# rows for each of six activities.
# - tempData is used to store data for each activity-subject pair
# - Column means of tempData read into the appropriate cells of
# finalData

# Use meanStdData table to create empty finalData table #

finalData = data.table(meanStdData[1:144,])
finalData[1:144, 1:81] = 0

# Nested for loops select for activity, for each activity each subject, for 
#each activity-subject pair each column in the table of means and SDs. Store 
#means of each column in appropriate cell of finalData #

row = 1
for (i in 1:6) {               
        for (j in 1:24) {       
                for (k in 3:81) {   
                        tempData = data.table(filter(meanStdData, Activity==i, 
                                                     Subject==j))
                        finalData[row, 1] = i
                        finalData[row, 2] = j
                        finalData[row, k] = colMeans(tempData[,k, with=FALSE])
                }
                row = row + 1
        }
}

        ########## Step 7 ##########

# Replace activity codes with activity names #

finalData <- finalData %>% mutate(Activity=recode(Activity, "1" = "Walking", 
                                                  "2" = "Walking Upstairs", 
                                                  "3" = "Walking Downstairs", 
                                                  "4" = "Sitting", 
                                                  "5" = "Standing", 
                                                  "6" = "Laying"))

        ########## END ##########


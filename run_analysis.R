# 1. Merges the training and the test sets to create one data set.

trainXData <- read.table("train/X_train.txt")
testXData <- read.table("test/X_test.txt")
XData <- rbind(trainXData, testXData)

trainYData <- read.table("train/y_train.txt")
testYData <- read.table("test/y_test.txt")
YData  <- rbind(trainYData, testYData)

trainSData <- read.table("train/subject_train.txt")
testSData <- read.table("test/subject_test.txt")
SData <- rbind(trainSData, testSData)

rm(trainXData)
rm(testXData)
rm(trainYData)
rm(testYData)
rm(trainSData)
rm(testSData)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
meanStdIndices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
XData <- XData[, meanStdIndices]

colnames(XData) <- features[meanStdIndices, 2]
colnames(XData) <- gsub("\\(|\\)", "", colnames(XData))
colnames(XData) <- gsub("-mean-", " Mean ", colnames(XData))
colnames(XData) <- gsub("-std-", " Std ", colnames(XData))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(activities[, 2]))

YData[, 1] = activities[YData[, 1], 2]

colnames(YData) <- c("activity")


# 4. Appropriately labels the data set with descriptive activity names.

colnames(SData) <- c("subject")
MData <- cbind(SData, YData, XData)


# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(SData)[,1]
numUniqueSubjects = length(unique(SData)[, 1])
numActivities = length(activities[, 1])
numCols = dim(MData)[2]
FinalData = MData[1:(numUniqueSubjects * numActivities), ]

row = 1

for (sub in 1:numUniqueSubjects) {
    for (act in 1:numActivities) {
        FinalData[row, 1] = uniqueSubjects[sub]
        FinalData[row, 2] = activities[act, 2]

        TData <- MData[MData$subject == sub & MData$activity == activities[act, 2], ]
        FinalData[row, 3:numCols] <- colMeans(TData[, 3:numCols])

        row = row+1
    }
}

write.table(FinalData, file = "average_dataset.txt", row.names = FALSE)

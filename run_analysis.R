#Load all initial data files into R
#This script assumes the folder UCI HAR Dataset is in the same working directory as the script

#load training set
training_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
training_labels <- read.table("./UCI HAR Dataset/train/Y_train.txt")
training_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#load test set
test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("./UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#load label table for lookups and and feature table to extract mean and std columns
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#use rbind to create a union of the test and training set
mergedData <- rbind(training_set, test_set)
mergedLabels <-rbind(training_labels, test_labels)
mergedSubjects <- rbind(training_subjects, test_subjects)

#create regex to extract features dealing with mean or std
pattern <- "(?:(?:mean\\(\\))|(?:std\\(\\)))"

#create table with vectors of only relevant features 
relevantFeatures <- features[grepl(pattern, features$V2),]

#create table containing only the columns with means or stds
mergedDataColFiltered <- mergedData[,relevantFeatures$V1]
#rename columns using descriptive variable names from features file
colnames(mergedDataColFiltered) <- relevantFeatures$V2

#rename columns using descriptive names
colnames(labels) <- c("labelID", "descriptiveActivityLabel")
colnames(mergedSubjects) <- c("subjectID")
colnames(mergedLabels) <- c("labelID")

#merge all three labeled vectors into single table with column bind
mergedObservations <- cbind(mergedSubjects, mergedLabels, mergedDataColFiltered)

#merge descriptive label names with main data table using common "labelID value"
finalData = merge(mergedObservations, labels)

#aggregate data by subject and activity, then find average variable for each
t<-aggregate(finalData[,3:68], by = list(finalData$subjectID, finalData$descriptiveActivityLabel),mean)

#create to data frame to manipulate headers
meanData <- data.frame(t)

#change headers to provide descriptions of the values
setnames(meanData, "Group.1", "subjectID")
setnames(meanData, "Group.2", "activityDescription")

#tidy up column names for avg columns to make data more readable
trimmedCols <- sub("\\.\\.\\.", "\\.", colnames(meanData))
colnames(meanData) <- trimmedCols

#write output to disk
write.table(meanData, "tidyMeans.txt", row.names = FALSE)



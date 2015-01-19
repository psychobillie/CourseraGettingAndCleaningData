#Getting and Cleaning Data Course Project Readme File

This document provides a brief description of the run_analysis.R file written for the Coursera
Getting and Cleaning Data Course.  It will provide a description of the required input files and 
an overview of the operations performed by the script to create the output file.  The output file itself
contains mean values of various observations from the original data grouped by subject and activity.
For a specific description of this file, please see the codebook.md file in this repo.

##Input Files

When running this script assumes that the folder "UCI HAR Dataset" and its associated files are in the same 
working directory and that the file names have not been changed.  This data can be obtained at 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Program Flow

The program follows the following steps to generate the output tidy set.

1. The script reads in the following files as data frames
	-UCI HAR Dataset/train/X_train.txt
	-UCI HAR Dataset/train/Y_train.txt
	-UCI HAR Dataset/train/subject_train.txt
	-UCI HAR Dataset/test/X_test.txt
	-UCI HAR Dataset/test/Y_test.txt
	-UCI HAR Dataset/test/subject_test.txt
	-UCI HAR Dataset/activity_labels.txt
	-UCI HAR Dataset/features.txt

2. The script merges the training and test set data frames using the rowbind function.

3. Per the requirement the script uses the grepl function to identify the columns in the original
features file that are either mean or std values be explicitly searching for "mean()" or "std()".

4. The list of mean and std columns is then applied to the main observation set to extract relevant
columns.  The features data frame is also used to create descriptive column names at this point.

5.  Descriptive column names are applied to the other input data frames.

6.  The column bind function is used to merge the observational data, the subject ID data, and the 
activity ID data into a single data frame.

7. The merged data is joined with the table containing the descriptive activity names
using the activity label ID to create the final data frame that will be used to perform 
aggregate calculations.

8. The aggregate function is passed the relevant columns, the subjectID as a factor, the activity
as a factor, and the mean function.  This creates a second table which provides average values for
each mean and std variable on a user and activity basis.

9.  The columns in this summarized data set are changed to have more dscriptive names and then
written to disk.

  






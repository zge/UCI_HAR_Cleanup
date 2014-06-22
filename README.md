README for run_analysis.R
========================================================

This script does the following tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Environment setup

* Clear the workspace
* Load in the necessary packages plyr and reshape2
  - First, the packages will be automatically installed if they have not been installed yet
  - Second, they will be load in by `library(pkg)`
* Set up current working directory
  - In Windows, it will be *C:\Users\\{username}\Downloads*, e.g. *C:\Users\zge\Downloads* on my computer
  - In Linux/iOS, it will be */home/{username}/Downloads*, e.g. */home/zge/Downloads* on my computer 
  - If the working directory does not exist on your computer, it will be automatically created
  - Then, it will update your current working directory to the one just set up

## File download
  
* Download data zip file **[getdata-projectfiles-UCI HAR Dataset.zip](http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)** to current working directory
* Unzip the zip file to the destination folder __UCI HAR Dataset__
* The above two steps will be only executed if the zip file or the destination folder does not exist

## Perform tasks
* Develope inline function for merging the same type of data in training (xxx_train.txt) and test (xxx_test.txt) into one file called xxx_all.txt
* Merge data one by one through a for loop and save them in a newly created subfolder called 'all' (_task 1_)
* Read in the merged feature data and extract only the features with mean and standard deviation measurements to form a subset of the merged data called '__X__' (_task 2_)
* Read in the _activity_ and _subject_ labels and append them as columns to the merged data __X__
* Replace the activity labels (1~6) with activity labels (STANDING, WALKING, etc., _task 3_)
* Assign the descriptive column names to __X__ (_task 4_)
* Create a secondary data frame __Y__ with average of each variable for each activity and each subject (_task 5_)

## Output results for task 2 and 5
* Write the tidy data __X__ as .txt file called _'X_activity_subject.txt'_
* Write the tidy data __Y__ as .txt file called _'activity_subject_varmean.txt'_
* For better visualization, also both __X__ and __Y__ as .csv files called _'X_activity_subject.csv'_ and _'activity_subject_varmean.csv'_
* All the output result files are saved in the destination folder __UCI HAR Dataset__

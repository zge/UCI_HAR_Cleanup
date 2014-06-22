# Project - Getting and Clening Data Course
# This script does the following tasks:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
#
# Zhenhao (Roger) Ge, 2014-06-22

# clear the workspace
rm(list=ls())

# load in the necessary packages plyr and reshape2
pkg <- c("plyr", "reshape2")
for (i in 1:length(pkg)) {
  if(pkg[i] %in% rownames(installed.packages()) == F) {install.packages(pkg[i])}
}
library(plyr)
library(reshape2)

# set up the working directory
path_rel <- "Downloads"
path <- paste0('/home/', Sys.info()[["user"]], '/', path_rel)
if(.Platform$OS.type == 'windows')
  path <- paste0('C:/Users/', Sys.info()[["user"]], '/', path_rel)
if(!file.exists(path)){dir.create(path)} 

# update working directory if necessary 
path_old <- getwd()
if(path_old != path) {
  setwd(path)
  print(paste0('dir update: ', path_old, ' -> ', path))
}
rm(path_rel, path_old)

# download zip folder and unzip
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- gsub("%2F", '-', tail(strsplit(fileUrl,"[/]")[[1]],1))
fileName <- gsub("%20", ' ', fileName)
if(!file.exists(fileName)){download.file(fileUrl, fileName)}
folder <- strsplit(fileName,"[-.]")[[1]][3]
if(!file.exists(folder)){unzip(fileName)}

# create folder called "All" to put the training&test merged set
folderAll <- paste0(folder, '/all')
if (!file.exists(folderAll)) {dir.create(folderAll)}

# read in file lists for both training and test set
fileList1 <- list.files(paste0(folder,'/train'), recursive=T)
fileList2 <- list.files(paste0(folder,'/test'), recursive=T)

# function to create the row-mergeed file for two data frames
mergeFile <- function (inFile1, inFile2, outFile) {
  d1 <- read.table(inFile1)
  d2 <- read.table(inFile2)
  d <- rbind(d1,d2)
  write.table(d, outFile, col.names=F, row.names=F)
}

# merges the training and the test sets to create one data set (task 1)
for (i in 1:length(fileList1)) {
  inFile1 <- paste0(folder, '/train/', fileList1[i])
  inFile2 <- paste0(folder, '/test/', fileList2[i])
  outFile <- gsub('train', 'all', inFile1)
  if (!file.exists(dirname(outFile))) {dir.create(dirname(outFile))}
  mergeFile(inFile1, inFile2, outFile)
}

# read in the merged data
X <- read.table(paste0(folder,'/all/X_all.txt'))

# extract the feature names and indeces for mean and std. deviation measurements (task 2)
features <- read.table(paste0(folder, '/features.txt'))
u <- which(apply(features, 1, function(x) any(grepl("mean|std", x))))
X <- X[, u]

# appropriately labels the data set with descriptive variable names (task 4)
colnames(X) <- features[u,2]

# read in the activity index lables
y <- read.table(paste0(folder,'/all/y_all.txt'))
colnames(y) <- "activity"

# read in the subject lables
subject <- read.table(paste0(folder,'/all/subject_all.txt'))
colnames(subject) <- "subject"

# add the activity (y) and subject columns to data (X)
X <- cbind(X, y, subject)

# read in the activity and its corresponding index lables
labels <- read.table(paste0(folder,'/activity_labels.txt'))

# uses descriptive activity names to name the activities in the data set (task 3)
X$activity <- mapvalues(X$activity, c(labels[,1]), c(as.character(labels[,2])))

# Creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject (task 5)
XMelt <- melt(X, id=c("subject","activity"))
Y <- dcast(XMelt, activity + subject ~ variable, mean)

# write out the result files of task 2 and 5
write.table(X, paste0(folder, "/X_activity_subject.txt"), col.names=F, row.names=F)
write.table(Y, paste0(folder, "/activity_subject_varmean.txt"), col.names=F, row.names=F)
write.csv(X, paste0(folder, "/X_activity_subject.csv"))
write.csv(Y, paste0(folder, "/activity_subject_varmean.csv"))

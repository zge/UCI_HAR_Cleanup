CodeBook for run_analysis.R
========================================================

Tidy Data Sets
=================

1. Data with measurements on the mean and stardard deviation for each measurement (i.e. variables) with activity and subject lables (data '__X__' in _run_analysis.R_)
2. Data with the average of all variables for each activity and each subject (data '__Y__' in _run_analysis.R_)

Data and Variable Description
=================

1. __X__: tidy data set 1 (refer to the "Tidy Data Sets" section above for details)
1. __Y__: tidy data set 2 (refer to the "Tidy Data Sets" section above for details)
1. __y__: activity labels (1-6) from merged activity label file (_'y_all.txt'_), which is appended to __X__
1. __subject__: subject labels (1-30) from merged subject label file (_'subject_all.txt'_), which is appended to __X__
1. __XMelt__: melted version of __X__ with _activity_ and _subject_ as IDs and all other variables as measurements, for the preparaton of __Y__ from __X__
1. __labels__: activity numeric label and named label correspondance 

Work Performed to Clean Up the Data
=================

1. Set up environment and download data file  
2. Develope inline function for merging the same type of data in training (xxx_train.txt) and test (xxx_test.txt) into one file called xxx_all.txt  
3. Merge data one by one through a for loop and save them in a newly created subfolder called 'all' (_task 1_)  
4. Read in the merged feature data and extract only the features with mean and standard deviation measurements to form a subset of the merged data called '__X__' (_task 2_)  
5. Read in the _activity_ and _subject_ labels and append them as columns to the merged data __X__  
6. Replace the activity labels (1~6) with activity labels (STANDING, WALKING, etc., _task 3_)  
7. Assign the descriptive column names to __X__ (_task 4_)  
8. Create a secondary data frame __Y__ with average of each variable for each activity and each subject (_task 5_)
9. Output results for task 2 and 5  

_Note_: please check '__README.md__' for details. 

Code Books for Tidy Data Sets
=================

* Tidy data set 1 (__X__):
```{r}
1  tBodyAcc-mean()-X
2  tBodyAcc-mean()-Y
3	tBodyAcc-mean()-Z
4	tBodyAcc-std()-X
5	tBodyAcc-std()-Y
6	tBodyAcc-std()-Z
7	tGravityAcc-mean()-X
8	tGravityAcc-mean()-Y
9	tGravityAcc-mean()-Z
10	tGravityAcc-std()-X
11	tGravityAcc-std()-Y
12	tGravityAcc-std()-Z
13	tBodyAccJerk-mean()-X
14	tBodyAccJerk-mean()-Y
15	tBodyAccJerk-mean()-Z
16	tBodyAccJerk-std()-X
17	tBodyAccJerk-std()-Y
18	tBodyAccJerk-std()-Z
19	tBodyGyro-mean()-X
20	tBodyGyro-mean()-Y
21	tBodyGyro-mean()-Z
22	tBodyGyro-std()-X
23	tBodyGyro-std()-Y
24	tBodyGyro-std()-Z
25	tBodyGyroJerk-mean()-X
26	tBodyGyroJerk-mean()-Y
27	tBodyGyroJerk-mean()-Z
28	tBodyGyroJerk-std()-X
29	tBodyGyroJerk-std()-Y
30	tBodyGyroJerk-std()-Z
31	tBodyAccMag-mean()
32	tBodyAccMag-std()
33	tGravityAccMag-mean()
34	tGravityAccMag-std()
35	tBodyAccJerkMag-mean()
36	tBodyAccJerkMag-std()
37	tBodyGyroMag-mean()
38	tBodyGyroMag-std()
39	tBodyGyroJerkMag-mean()
40	tBodyGyroJerkMag-std()
41	fBodyAcc-mean()-X
42	fBodyAcc-mean()-Y
43	fBodyAcc-mean()-Z
44	fBodyAcc-std()-X
45	fBodyAcc-std()-Y
46	fBodyAcc-std()-Z
47	fBodyAcc-meanFreq()-X
48	fBodyAcc-meanFreq()-Y
49	fBodyAcc-meanFreq()-Z
50	fBodyAccJerk-mean()-X
51	fBodyAccJerk-mean()-Y
52	fBodyAccJerk-mean()-Z
53	fBodyAccJerk-std()-X
54	fBodyAccJerk-std()-Y
55	fBodyAccJerk-std()-Z
56	fBodyAccJerk-meanFreq()-X
57	fBodyAccJerk-meanFreq()-Y
58	fBodyAccJerk-meanFreq()-Z
59	fBodyGyro-mean()-X
60	fBodyGyro-mean()-Y
61	fBodyGyro-mean()-Z
62	fBodyGyro-std()-X
63	fBodyGyro-std()-Y
64	fBodyGyro-std()-Z
65	fBodyGyro-meanFreq()-X
66	fBodyGyro-meanFreq()-Y
67	fBodyGyro-meanFreq()-Z
68	fBodyAccMag-mean()
69	fBodyAccMag-std()
70	fBodyAccMag-meanFreq()
71	fBodyBodyAccJerkMag-mean()
72	fBodyBodyAccJerkMag-std()
73	fBodyBodyAccJerkMag-meanFreq()
74	fBodyBodyGyroMag-mean()
75	fBodyBodyGyroMag-std()
76	fBodyBodyGyroMag-meanFreq()
77	fBodyBodyGyroJerkMag-mean()
78	fBodyBodyGyroJerkMag-std()
79	fBodyBodyGyroJerkMag-meanFreq()
80	activity
81	subject
```

* Tidy data set 2 (__Y__)
```{r}
1  activity
2  subject
3	tBodyAcc-mean()-X
4	tBodyAcc-mean()-Y
5	tBodyAcc-mean()-Z
6	tBodyAcc-std()-X
7	tBodyAcc-std()-Y
8	tBodyAcc-std()-Z
9	tGravityAcc-mean()-X
10	tGravityAcc-mean()-Y
11	tGravityAcc-mean()-Z
12	tGravityAcc-std()-X
13	tGravityAcc-std()-Y
14	tGravityAcc-std()-Z
15	tBodyAccJerk-mean()-X
16	tBodyAccJerk-mean()-Y
17	tBodyAccJerk-mean()-Z
18	tBodyAccJerk-std()-X
19	tBodyAccJerk-std()-Y
20	tBodyAccJerk-std()-Z
21	tBodyGyro-mean()-X
22	tBodyGyro-mean()-Y
23	tBodyGyro-mean()-Z
24	tBodyGyro-std()-X
25	tBodyGyro-std()-Y
26	tBodyGyro-std()-Z
27	tBodyGyroJerk-mean()-X
28	tBodyGyroJerk-mean()-Y
29	tBodyGyroJerk-mean()-Z
30	tBodyGyroJerk-std()-X
31	tBodyGyroJerk-std()-Y
32	tBodyGyroJerk-std()-Z
33	tBodyAccMag-mean()
34	tBodyAccMag-std()
35	tGravityAccMag-mean()
36	tGravityAccMag-std()
37	tBodyAccJerkMag-mean()
38	tBodyAccJerkMag-std()
39	tBodyGyroMag-mean()
40	tBodyGyroMag-std()
41	tBodyGyroJerkMag-mean()
42	tBodyGyroJerkMag-std()
43	fBodyAcc-mean()-X
44	fBodyAcc-mean()-Y
45	fBodyAcc-mean()-Z
46	fBodyAcc-std()-X
47	fBodyAcc-std()-Y
48	fBodyAcc-std()-Z
49	fBodyAcc-meanFreq()-X
50	fBodyAcc-meanFreq()-Y
51	fBodyAcc-meanFreq()-Z
52	fBodyAccJerk-mean()-X
53	fBodyAccJerk-mean()-Y
54	fBodyAccJerk-mean()-Z
55	fBodyAccJerk-std()-X
56	fBodyAccJerk-std()-Y
57	fBodyAccJerk-std()-Z
58	fBodyAccJerk-meanFreq()-X
59	fBodyAccJerk-meanFreq()-Y
60	fBodyAccJerk-meanFreq()-Z
61	fBodyGyro-mean()-X
62	fBodyGyro-mean()-Y
63	fBodyGyro-mean()-Z
64	fBodyGyro-std()-X
65	fBodyGyro-std()-Y
66	fBodyGyro-std()-Z
67	fBodyGyro-meanFreq()-X
68	fBodyGyro-meanFreq()-Y
69	fBodyGyro-meanFreq()-Z
70	fBodyAccMag-mean()
71	fBodyAccMag-std()
72	fBodyAccMag-meanFreq()
73	fBodyBodyAccJerkMag-mean()
74	fBodyBodyAccJerkMag-std()
75	fBodyBodyAccJerkMag-meanFreq()
76	fBodyBodyGyroMag-mean()
77	fBodyBodyGyroMag-std()
78	fBodyBodyGyroMag-meanFreq()
79	fBodyBodyGyroJerkMag-mean()
80	fBodyBodyGyroJerkMag-std()
81	fBodyBodyGyroJerkMag-meanFreq()
```

* Activity numeric label and named label correspondance (__labels__):
``` {r}
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
```

Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ   
tGravityAcc-XYZ   
tBodyAccJerk-XYZ   
tBodyGyro-XYZ   
tBodyGyroJerk-XYZ   
tBodyAccMag   
tGravityAccMag   
tBodyAccJerkMag   
tBodyGyroMag   
tBodyGyroJerkMag   
fBodyAcc-XYZ   
fBodyAccJerk-XYZ   
fBodyGyro-XYZ   
fBodyAccMag   
fBodyAccJerkMag   
fBodyGyroMag   
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean

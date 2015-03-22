# Introduction
One of the most exciting areas in all of data science right now is wearable computing - see for example this article.
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S
smartphone.

original source
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Contains:
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject

data for analisys:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



# Variables


The following first texts: a_ytst,a_ytr,s_train,s_test,f_xtst,f_xtr, refers to the downloaded data files for the project

The second set of texts names: s_tst_train,y_tst_train,x_tst_train regroup and join toguether the data.

The third grop of text names: names(s_tst_train), names(y_tst_train),features_names contains the names of the data sets.

The fourth group refers to the combine data set: datos_ys,datos_combina, the following nombres_1,nombres_2 designates
the names of the given big data set.

Finally datos_extract point the transform data and through the text name datos_tidy a file with the data set is created.


# Activities

First step of the preprocessing is to merge the training and test sets. Two sets are combined and generate 10,299 instances 
where each instance contains 561 features (560 measurements and subject identifier). After the merge operation the 
resulting data, the table contains 562 columns (560 measurements, subject identifier and activity label).

From the combine setsis extracted the with the estimated mean and standard deviation, then the labels area assingn from
the file 'activity_labels.txt'. Finally a tidy data set is created that contains 10299 observations with 81 variables
divided in:

- an activity label: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
- an identifier of the subject who carried out the experiment (Subject):1,3,5,6,7,8,11,14,15,16,17,19,21,22,23,25,26,27,28,29,30
- a 79-feature vector with time and frequency domain signal variables (numeric)


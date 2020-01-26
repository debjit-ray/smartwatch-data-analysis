Objectives : 
	>> Merge the training and the test sets to create one data set.
	>> Extract only the measurements on the mean and standard deviation for each measurement.
	>> Use descriptive activity names to name the activities in the data set
	>> Appropriately label the data set with descriptive variable names.
	>> Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	
Inputs Considered:
	>> activity_labels.txt - This file contains the mapping between activity ID and the activity name.
	>> features.txt - This file contains the name of the observations (i.e. column names) for the files "X_test.txt" and "X_train.txt".
	>> X_test.txt - This file contains 30% of the observations (actual data).
	>> X_train.txt - This file contains the remaining 70% of the observations (actual data).
	>> y_test.txt - This file contains the activity ID corresponding to the observations in the dataset "X_test.txt".
	>> y_train.txt - This file contains the activity ID corresponding to the observations in the dataset "X_train.txt".
	>> subject_test.txt - This file contains the subject ID corresponding to the observations in the dataset "X_test.txt".
	>> subject_train.txt - This file contains the subject ID corresponding to the observations in the dataset "X_train.txt".
	
Outputs Generated:
	>> finalOutput.txt - The file contains the mean and standard deviation of the readings taken from the accelerometer and gyroscope of the 
              smart device worn by 30 different person, while performing different activities.
        >> summaryOutput.txt - The file contains the average reading for each subject per activity.
              
Processing Steps:
	>> Read the relevant files to the corresponding dataframes
		>> Read "activity_labels.txt" into the dataframe activityLabels. 
		>> Read "features.txt" into the dataframe features.
		>> Read "X_test.txt" into the dataframe xTestSet with column names populated from dataframe features.
		>> Read "y_test.txt" into the dataframe yTestSet.
		>> Read "subject_test.txt" into the dataframe subjectTestSet.
		>> Read "X_train.txt" into the dataframe xTrainSet with column names populated from dataframe features.
		>> Read "y_train.txt" into the dataframe yTrainSet.
		>> Read "subject_train.txt" into the dataframe subjectTrainSet.		
	>> Vertically merge the dataframes xTestSet, yTestSet and subjectTestSet to create a new dataframe, testDF. This way, the new dataframe
	   will have the subjectID and activityID along with all the observations in a single dataframe.
	>> Vertically merge the dataframes xTrainSet, yTrainSet and subjectTrainSet to create a new dataframe, trainDF. This way, the new dataframe
	   will have the subjectID and activityID along with all the observations in a single dataframe.
	>> Horizontally merge the dataframes, testDF and trainDF to create a single dataframe, mergedDF. Thus this contains a consolidated dataframe
	   of all the observations.
	>> From the mergedDF, create a new dataframe table, mergedTBL_DF.
	>> Extract the activityID, subjectID and columns containing mean and standard deviation measurements into a new dataframe, selectedcols_DF.
	>> Next include the activity Name by joining the dataframe selectedcols_DF with the dataframe activityLabels. The new dataframe is named outputData_DF.
	>> To make the column names of the dataframe outputData_DF more readable, the following replacements are made:
		>> Any column name starting with "t" is replaced with "Time"
		>> Any column name starting with "f" is replaced with "FFT"
		>> Any column name containing "Acc" is replaced with "Accelerometer"
		>> Any column name containing "Gyro" is replaced with "Gyroscope"
		>> Any column name containing "gravity" is replaced with "Gravity"
		>> Any column name containing "Mag" is replaced with "Magnitude"
		>> Any column name containing "tBody" is replaced with "TimeBody"
		>> Any column name containing "angle" is replaced with "Angle"
		>> Any column name containing "mean" is replaced with "Mean"
		>> Any column name containing "std" is replaced with "STD"
	>> Next, an independent dataframe, summary_DF is created by
		>> Grouping the data in outputData_DF, on the basis of activity ID, activity Name and subject ID
		>> Find the mean of each column on the basis of the groups created above.
	>> Finally, write the output files to output datasets.
		>> Write the dataframe outputData_DF to the dataset "finalOutput.txt"
		>> Write the dataframe summary_DF to the dataset "summaryOutput.txt"
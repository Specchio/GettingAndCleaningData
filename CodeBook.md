## CodeBook

This file includes information about the data included in the tidy dataset created by executing the run_analysis.R script included in this repo.

The columns of this dataset are 4:

1. subject: This column identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
2. activity: Depicts the activities each person has performed six activities and has six possible values:
  * walking
  * walking_upstairs
  * walking_downstairs
  * sitting
  * standing
  * laying
3. measure: It describes the various measurements that have been recorded during this experiment. Those measurements come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. All of them are related either to a mean or to a standard deviation value.
4. mean: It includes the mean value of each measurement.
 
The data described above are practically an independent tidy data set with the average of each variable for each activity and each subject.

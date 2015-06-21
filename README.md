## Synopsis

This project is practically about the cleaning of the data from the "Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.", part of the "Getting and Cleaning Data" course of coursera and Johns Hopkins university.

## Motivation

The main purpose behind this project was to fulfil the requirements of the coursework and learn more about getting and cleaning data. Although it was astonishing there will be no maintaining as the goal of the project has been met.

## Installation

After you clone the project to a local folder of yours (hint: git clone <link>) you will just have to set the current session's path to the folder that is created from the extraction of the coursework's data and run in r the command:
```r
source("run_analysis.R")
```

## Documentation

I have followed certain steps in order to transform the given raw data to the tidy dataset the script produces and this is the section where I will explain my mindset:

1. My first step was to read the data from the various files included in the rar file of the coursework. My hypothesis that the session path is set exactly a the folder created from the extraction of the data is needed in order for the script to run so before you execute anything please set the session path to the appropriate folder. The reading of the data takes place using __read.table__ command and reads the data from:
  * UCI HAR Dataset/test/X_test.txt
  * UCI HAR Dataset/train/X_train.txt
  * UCI HAR Dataset/test/subject_test.txt
  * UCI HAR Dataset/train/subject_train.txt
  * UCI HAR Dataset/test/y_test.txt
  * UCI HAR Dataset/train/y_train.txt
  * UCI HAR Dataset/features.txt
2. Next step is to load all the data in their respective tbl data frames, using the __tbl_df__ function.
3. Then, we bind the two data pieces in one respectively using __bind_rows__. At this point we could mutate the data frames to keep track which one originated from the train set and which one from the test set but this was not needed from the project's description so I decided not to do it.
4. The activity data has to get renamed from the numeric values 1-6 to the respective values given in the activity_labels.txt file. This is done by simple assignments as I didn't have the time to implement something fancy.
5. The columns of the data set have to be named as well so I grab the contents of the features.txt and by using the __colnames__ function I set them accordingly.
6. As we don't want to keep all the columns from the dataset I "extract only the measurements on the mean and standard deviation for each measurement" using the __grep__ command. In my opinion, although there were cases of columns that include the mean or std keywords they should not get accepted as they don't really represent mean or std values, that's why I have kept the columns with mean() / std() in their names (fixed grep).
7. At this point I concatenate the columns from all the data I have manipulated above to one dataset using __bind_cols__.
8. A proper, tidy dataset has to have clean column names so I decided to avoid leaving them as they were mentioned in the features.txt file but to reshape them a little bit. For this purpose I used the __gsub__ command and got rid of any parenthesis in the column names and substituted dashes ( - ) with underscores ( _ ) as I believe this kind of naming looks better. I have avoided using the __make.names__ function that's created for this purpose as subtituting the not accepted characters to dots wasn't pretty enough for me.
9. In order to tidy the data a little bit more I have arranged the data based on subject and then by activity using the __arrange__ function.
10. Then, I have grouped the data by subject and then by activity as my purpose was to create an independent tidy data set with the average of each variable for each activity and each subject. This was done with __group_by__ function.
11. Next step was to summarize the data using the __summarise_each__ function using the __mean__ function on all the columns but subject and activity.
12. In order to transform the whide table data that I have at this point to a long table data I used the __melt__ function. I have also used the __variable.name__ and __value.name__ parameters to name the two new columns that would be created from the function in my dataset.
13. Finally, our data were ready to get saved in a .txt file so the __write.table__ command was used there with the __row.name=FALSE__ parameter existent. The output.txt should get saved in the session path you have set at the start of the execution. Enjoy!

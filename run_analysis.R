# Read data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

print("Done reading the data.")

# Load data in a tbl data frame
X_test_ <- tbl_df(X_test)
X_train_ <- tbl_df(X_train)
subject_test_ <- tbl_df(subject_test)
subject_train_ <- tbl_df(subject_train)
y_test_ <- tbl_df(y_test)
y_train_ <- tbl_df(y_train)

print("Transformed them to tbl.")

# Bind the two data pieces in one (objective No1)
X <- bind_rows(X_test, X_train)
subject <- bind_rows(subject_test, subject_train)
activity <- bind_rows(y_test, y_train)

print("Binded the data.")

# Name the activities
activity[activity$V1 == 1, 1] <- "walking"
activity[activity$V1 == 2, 1] <- "walking_Upstairs"
activity[activity$V1 == 3, 1] <- "walking_Downstairs"
activity[activity$V1 == 4, 1] <- "sitting"
activity[activity$V1 == 5, 1] <- "standing"
activity[activity$V1 == 6, 1] <- "laying"

# Give names in columns
colnames(X) <- features$V2
colnames(subject) <- "subject"
colnames(activity) <- "activity"

# Keep only the columns that contain "mean" or "std" in their titles
Xmean <- X[ , grep("mean()", names(X), fixed = TRUE) ]
Xstd <- X[ , grep("std()", names(X), fixed = TRUE) ]

# Create the final data
data <- bind_cols(subject, activity, Xmean, Xstd)

# Rename the columns (remove parenthesis and sub dash to underscore)
colnames(data) <- gsub("\\(|\\)", "", names(data))
colnames(data) <- gsub("-", "_", names(data))

# Arrange the data based based on subject and then by activity
data <- arrange(data, subject, activity)

# Group data
grouped_data <- group_by(data, subject, activity)

# Summarize the grouped data
outcome <- summarise_each(grouped_data, funs(mean), -c(subject,activity))

# Transform from Wide table to Lond using melt
outcome <- melt(outcome, id.vars = c("subject", "activity"), variable.name = "measure", value.name = "mean")

# Write the table to a txt file
write.table(outcome, file = "output.txt", row.name=FALSE)
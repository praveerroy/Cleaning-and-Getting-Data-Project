library(plyr)


# Merge the training and test sets 

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# combine x
x_data <- rbind(x_train, x_test)

# combine y
y_data <- rbind(y_train, y_test)

# combine subject
subject_data <- rbind(subject_train, subject_test)


#mean and standard deviations for the data set

features <- read.table("features.txt")

features_data <- grep("-(mean|std)\\(\\)", features[, 2])

x_data <- x_data[, features_data]

names(x_data) <- features[features_data, 2]

# descriptive activity names 

activities <- read.table("activity_labels.txt")

y_data[, 1] <- activities[y_data[, 1], 2]


names(y_data) <- "activity"


#label the data set 


names(subject_data) <- "subject"

all_data <- cbind(x_data, y_data, subject_data)

# Create the final dataset with averages

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)

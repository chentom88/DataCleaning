library("dplyr")

# Download and extract data
if (!file.exists("dataset")) {
    zip_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(zip_url, "dataset.zip")
    unzip("dataset.zip")
    file.rename("UCI\ HAR\ Dataset", "dataset")
}

# Read the feature names which will be used to label the columns
# of the collected accelerometer data
features <- read.csv("dataset/features.txt", sep="", header=F)
colnames(features) <- c("index", "name")
features$name <- as.character(features$name)

# Read activity labels
act_key <- read.csv("dataset/activity_labels.txt", sep="", header=F)
colnames(act_key) <- c("act_key", "label")

# This function will load and tidy the data. Valid values for directory
# are either 'test' or 'train'
get_data <- function(directory) {
    if (directory != "train" && directory != "test") {
        stop("get_data can only load test or train data")
    }
    
    # Read subject data
    subj_file <- sprintf("dataset/%1$s/subject_%1$s.txt", directory)
    subj_data <- read.csv(subj_file, header=F)
    colnames(subj_data) <- c("subject_id")
    
    # Read the acivity label data
    y_file <- sprintf("dataset/%1$s/y_%1$s.txt", directory) 
    y <- read.csv(y_file, header=F)
    colnames(y) <- c("act_key")
    y$activity <- factor(y$act_key, c(1,2,3,4,5,6), act_key$label)
    
    # Read the accelerometer data. Retains only data that has mean or std 
    # in the column name
    x_file <- sprintf("dataset/%1$s/X_%1$s.txt", directory)
    x <- read.csv(x_file, sep="", header=F)
    colnames(x) <- features$name
    filtered_x <- x[, grepl("^.+(mean\\(|std\\()).+$", names(x))]
    
    # Combine all three sets of data, remove the redundant activity key
    data <- cbind(subj_data, y, filtered_x)
    data[,-which(names(data) == "act_key")]
}

train_data <- get_data("train")
test_data <- get_data("test")

# Combine the data sets and create the summary data which
# is the means of all variables by subject id and activity
all_data <- rbind(train_data, test_data)
summary_data <- all_data %>% group_by(subject_id, activity) %>% summarize_all(mean)
summary_data <- as.data.frame(summary_data)

# Write the combined data set and summary data set out to files
write.csv(all_data, "all_data.csv", row.names=F)
write.csv(summary_data, "summary_data.csv", row.names=F)

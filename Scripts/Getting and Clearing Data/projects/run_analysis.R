# Cleaning Data -- End of Course Assignment 

# run_analysis.R script

# Libraries
library(stringr)
library(tidyr)

getwd()
list.files("./Data/UCI HAR Dataset/")


# - 'features.txt': List of all features.
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
# - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 



# Data 
# Step1: Merges the training and the test sets to create one data set -----

# Train datasets
train<-read.table("./Data/UCI HAR Dataset/train/X_train.txt")
names(train)<-gsub("V","",names(train))

train_labels <- read.table("./Data/UCI HAR Dataset/train/y_train.txt")
names(train_labels) <- "ACTIVITY_LABEL"

subjects<-read.table("./Data/UCI HAR Dataset/train/subject_train.txt")
names(subjects) <- "SUBJECT_NUM"

df_train<-cbind(subjects, train_labels, train)
df_train$DATA_SET <- "TRAIN"

# Test datasets
test<-read.table("./Data/UCI HAR Dataset/test/X_test.txt")
names(test)<-gsub("V","",names(test))

test_labels <- read.table("./Data/UCI HAR Dataset/test/y_test.txt")
names(test_labels) <- "ACTIVITY_LABEL"

subjects<-read.table("./Data/UCI HAR Dataset/test/subject_test.txt")
names(subjects) <- "SUBJECT_NUM"

df_test<-cbind(subjects, test_labels, test)
df_test$DATA_SET <- "TEST"

# Merge all datas 
df_main <- rbind(df_test, df_train)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.----

# Labels
activity_labels<-read.table("./Data/UCI HAR Dataset/activity_labels.txt",col.names = c("LABEL", "NAME"))

features<-read.table("./Data/UCI HAR Dataset/features.txt",col.names = c("LABEL", "NAME"))

features.labels <- features[grep("(mean|std)\\(\\)", features$NAME),]
features.labels$NAME <- gsub('[()]','', features.labels$NAME)

df_main<-df_main[,c("SUBJECT_NUM", "ACTIVITY_LABEL","DATA_SET",features.labels$LABEL)]

names(df_main)

# Step 3: Uses descriptive activity names to name the activities in the data set
# actvity labels
df_main$ACTIVITY_LABEL <- factor(df_main$ACTIVITY_LABEL,
                                 levels = activity_labels$LABEL,
                                 labels = activity_labels$NAME)
# measurement labels
df_main <- df_main %>% gather(MEASUREMENT , VALUE ,'1':'543')

df_main$MEASUREMENT <- factor(df_main$MEASUREMENT, 
                              levels = features.labels$LABEL,
                              labels = features.labels$NAME)

head(df_main)


# Step 4: creates a second, independent tidy data set with the average of each variable for each activity and each subject


df_main_means <- df_main %>%
  group_by(SUBJECT_NUM, ACTIVITY_LABEL, MEASUREMENT) %>%
  summarise(mean(VALUE))



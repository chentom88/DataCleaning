# Code Book 

## How the raw data was processed

1. The raw data set is downloaded and unzipped into a folder named `dataset`
  1. The raw data set is understood to be structured as follows
    1. The raw data is separated into a training data set and test data set
    1. For both sets of data, there is a common `activity_labels.txt` file that 
       correlates the activity number in the movement data with a descriptive 
       label of the activity
    1. For both sets of data, there is a common `features.txt` file that contains
       the descriptive feature names of all of the collected movement data
    1. Both data sets contain a `subject_train.txt` file that holds only
       the subject column for the movement data. Each row is a number identifying
       to one of the 30 volunteers of the study.
    1. Both data sets contain a `y_<set name>.txt` file that holds only the
       activity column for the movement data. Each row is a number in the 
       range 1:6 identifying one of the activities in the `activity_labels.txt` 
       file.
    1. Both data sets contain a `X_<set name>.txt` file that holds the bulk
       of the sensor measurement data taken on each of the volunteers. Each row is a 
       list containing measurements that match up with the features listed
       in the `features.txt`
1. For each of the sub-divided data sets, the script will combine the subject data
in the `subject_train.txt` file with the activity data in `y_<set name>.txt`.
    1. The activity data stored in `y_<set name>.txt` is coded by activity number 
       so each activity number was decoded into a descriptive label 
       with the `activity_labels.txt`.
    1. The measurement data stored in the `X_<set name>.txt` file is not labeled with
       any descriptive descriptions. So the data was read into a data frame and names were
       assigned to each column as provided by the `features.txt` file.
    1. Since we only want the mean and std data, all other columns are removed from the
       measurment data.
    1. The final step for producing the data frames for the training and test data sets
       was to combine the subject data, activity data and measurements data for
       each.
    1. The activity number and activity description are redundant and so the column
       containing activity number was removed
1. Once each of the training and test data frames had been produced, both data
   frames were combined into one data frame labeled `all_data`. This data frame is written 
   out to the `all_data.csv` file
1. The data of the `all_data` data frame is grouped first by subject id and then
   by activity. A new `summary_data` data frame is created that contains the
   average of each measurement variable for each subject and each activity.
   This data frame is then written out to the `all_data.csv` file.

## Glossary of variables

Both the data frames contained in the `all_data.csv` and `summary_data.csv` files contain 
the same variables/features so this glossary should apply to both. All sensor measurement
data should be in standard gravity units 'g'

* **subject_id**: A unique numeric identifier for a single participant in the measurement study
* **activity**: A descriptive label of the activity that the subject was performing when
the measurement data was taken
* **sensor measurement data**: for a description of the sensor measurement data, please see the 
original data set from the 
[UCI Machine Learning repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

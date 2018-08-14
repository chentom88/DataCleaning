# Getting and Cleaning Data Course Project

This repository contains one R script, `run_analysis.R`, that will download a [human activity 
recognition data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from 
the UCI Machine Learning Repository.  Please follow the previously provided link for details 
on this data set, how it was collected and what observations were made. The script will 
take the raw data in this data set and create a couple of clean and 
tidy datasets as described below.

* **all_data.csv**: This file contains the mean and std calculations of all of the sensor measurements taken
on the study's volunteers.  All of the sensor data collected is in standard gravity units. 
It is assumed that the means and std calculations are presented in the same units.
* **summary_data.csv**: This file contains the means of the data contained in the `all_data.csv` as grouped by `subject_id` 
and `activity`. For example, the first row contains the means of all the mean and std data that was collected for subject #1 
while performing the activity of `WALKING`.

## Running the script

The `run_analysis.R` script depends on the `dplyr` library. Please have that package installed before running the script.

## More Information

More detailed information can be found in the [Code Book](CodeBook.md)



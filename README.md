# Getting and Cleaning Data using R

This is the assignment project for the Getting and Cleaning Data Coursera course. The R script (run_analysis.R) is used to download and clean the data file. The detailed steps are:

1. Download the dataset from source.
2. Unzip the file.
3. Load the activity and feature.
4. Load the training and test datasets. Filter only those columns which reflect a mean or standard deviation.
5. Load the activity and subject data for each dataset, and merges those columns with the dataset.
6. Merges the two datasets.
7. Convert the activity and subject columns into factors.
8. Create a tidy dataset with mean of each variable for every subject and activity pair.

The end result is shown in the file tidy.txt.

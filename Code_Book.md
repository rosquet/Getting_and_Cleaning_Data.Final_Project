---
title: "Code_Book.rmd"
author: "Clayton Glad"
date: "5/2/2020"
output: html_document
---

## Final Project: JHU Getting and Cleaning Data

This document provides information about this repository, part of the final 
project of JHU's Getting and Cleaning Data course.

### Data

The data is sourced from UC Irvine's Human Activity Recognition Using Smartphones Data Set. The data set can be downloaded here as a zipped .csv file:

[UCI HAR data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Experiment Design and Data Set

[Detailed information](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#### Attribute Information:

For each record in the dataset it is provided:
<ul>
<li>Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.</li>
<li>Triaxial Angular velocity from the gyroscope.</li>
<li>A 561-feature vector with time and frequency domain variables.</li>
<li>Its activity label.</li>
<li>An identifier of the subject who carried out the experiment.</li>
</ul>

#### Variables:

    time_domain_body_accelerometer_mean_X-axis

    time_domain_body_accelerometer_mean_Y-axis

    time_domain_body_accelerometer_mean_Z-axis

    frequency_domain_body_accelerometer_mean_X-axis

    frequency_domain_body_accelerometer_mean_Y-axis

    frequency_domain_body_accelerometer_mean_Z-axis

    time_domain_body_accelerometer_standard_deviation_X-axis

    time_domain_body_accelerometer_standard_deviation_Y-axis

    time_domain_body_accelerometer_standard_deviation_Z-axis

    frequency_domain_body_accelerometer_standard_deviation_X-axis

    frequency_domain_body_accelerometer_standard_deviation_Y-axis

    frequency_domain_body_accelerometer_standard_deviation_Z-axis

    time_domain_gravity_accelerometer_mean_X-axis

    time_domain_gravity_accelerometer_mean_Y-axis

    time_domain_gravity_accelerometer_mean_Z-axis

    Note: Not applicable for frequency domain.

    time_domain_gravity_accelerometer_standard_deviation_X-axis

    time_domain_gravity_accelerometer_standard_deviation_Y-axis

    time_domain_gravity_accelerometer_standard_deviation_Z-axis

    time_domain_body_accelerometer_jerk_mean_X-axis

    time_domain_body_accelerometer_jerk_mean_Y-axis

    time_domain_body_accelerometer_jerk_mean_Z-axis

    frequency_domain_body_accelerometer_jerk_mean_X-axis

    frequency_domain_body_accelerometer_jerk_mean_Y-axis

    frequency_domain_body_accelerometer_jerk_mean_Z-axis

    time_domain_body_accelerometer_jerk_standard_deviation_X-axis

    time_domain_body_accelerometer_jerk_standard_deviation_Y-axis

    time_domain_body_accelerometer_jerk_standard_deviation_Z-axis

    frequency_domain_body_accelerometer_jerk_standard_deviation_X-axis

    frequency_domain_body_accelerometer_jerk_standard_deviation_Y-axis

    frequency_domain_body_accelerometer_jerk_standard_deviation_Z-axis

    time_domain_body_gyroscope_mean_X-axis

    time_domain_body_gyroscope_mean_Y-axis

    time_domain_body_gyroscope_mean_Z-axis

    frequency_domain_body_gyroscope_mean_X-axis

    frequency_domain_body_gyroscope_mean_Y-axis

    frequency_domain_body_gyroscope_mean_Z-axis

    time_domain_body_gyroscope_standard_deviation_X-axis

    time_domain_body_gyroscope_standard_deviation_Y-axis

    time_domain_body_gyroscope_standard_deviation_Z-axis

    frequency_domain_body_gyroscope_standard_deviation_X-axis

    frequency_domain_body_gyroscope_standard_deviation_Y-axis

    frequency_domain_body_gyroscope_standard_deviation_Z-axis

    time_domain_body_gyroscope_jerk_mean_X-axis

    time_domain_body_gyroscope_jerk_mean_Y-axis

    time_domain_body_gyroscope_jerk_mean_Z-axis

    Note: Not applicable for frequency domain.

    time_domain_body_gyroscope_jerk_standard_deviation_X-axis

    time_domain_body_gyroscope_jerk_standard_deviation_Y-axis

    time_domain_body_gyroscope_jerk_standard_deviation_Z-axis

    Note: not applicable for frequency domain.

    time_domain_body_accelerometer_magnitude_mean

    time_domain_body_accelerometer_magnitude_standard_deviation

    frequency_domain_body_accelerometer_magnitude_mean

    frequency_domain_body_accelerometer_magnitude_standard_deviation

    time_domain_body_accelerometer_jerk_magnitude_mean

    time_domain_body_accelerometer_jerk_magnitude_standard_deviation

    frequency_domain_body_accelerometer_jerk_magnitude_mean

    frequency_domain_body_accelerometer_jerk_magnitude_standard_deviation

    time_domain_body_gyroscope_magnitude_mean

    time_domain_body_gyroscope_magnitude_standard_deviation

    frequency_domain_body_gyroscope_magnitude_mean

    frequency_domain_body_gyroscope_magnitude_standard_deviation

    time_domain_body_gyroscope_jerk_magnitude_mean

    time_domain_body_gyroscope_jerk_magnitude_standard_deviation

    frequency_domain_body_gyroscope_jerk_magnitude_mean

    frequency_domain_body_gyroscope_jerk_magnitude_standard_deviation


### Structure of run_analysis.R

run_analysis.R is a script that achieves the goals of this project. Those being,
<br>
<ol>
<li>Merges the training and test sets into one data set</li>
<li>Uses descriptive activity names to name the activities in the data set</li>
<li>Appropriately labels the data set with descriptive variable names</li>
<li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>
</ol>

The script is divided into seven steps.

<b>Step 1.</b> Initialize workspace, load libraries, create working directory
<br>
<b>Step 2.</b> Download zipped data, unzip, read relevant files
<br>
<b>Step 3.</b> Replace column names with more descriptive ones
<br>
<b>Step 4.</b> Create combined data set, find mean and standard deviation columns
<br>
<b>Step 5.</b> Clean up column names, remove invalid characters                    <br>
<b>Step 6.</b> Create final data set of the averages of each variable and each subject
<br>
<b>Step 7.</b> Replace activity numbers with activity names


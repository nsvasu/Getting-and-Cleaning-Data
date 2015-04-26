Course Project Code Book
========================

Here is the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script ("run_analysis.R") performs the cleanup of the data and creates the tidy dataset:

The following are the steps performed by the R script.

* It Merges the training and test sets to create one dataset 
  1. train/X_train.txt with test/X_test.txt
  2. train/y_train.txt with test/y_test.txt
  3. train/subject_train.txt with test/subject_test.txt

* It reads the features.txt file and for each measurement it extracts only the measurements on mean and standard deviation. 

* It reads the activity_labels.txt file and it names the activities in the data set by applying the descriptive activity names (mentioned below) to initial activity names:

  walking
  walkingupstairs
  walkingdownstairs
  sitting
  standing
  laying

* The script also labels the data set with appropirate descriptive names and in the labels the underscores and brackets () are removed. Below are some of the names of the attributes:

  tbodyacc Mean X 
  tbodyacc Mean Y 
  tbodyacc Mean Z 
  tbodyacc Std X
  tbodyacc Std Y 
  tbodyacc Std Z 
  tgravityacc Mean X 
  tgravityacc Mean Y

* Finally, the script creates a tidy data set with the average of each measurement for each activity and each subject. The final tidy dataset is saved as average_dataset.txt, that has a 180x68 data frame data.

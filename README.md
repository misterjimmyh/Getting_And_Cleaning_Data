Description of run_analysis.R:

Section 1 reads in the data required to generate the tidy data set. The test data and training data each have three tables to read, and there are two additional tables of column names that will later be applied to the test and training columns.

Section 2 names the columns using the features and activity labels

Section 3 combines the data tables to create the final set. It uses cbind to make one table for training data and one table for test data, then rbind to combine those into a single data frame. Then, Merge is used to put the Activity column in as well.

Section 4 uses a grepl() search on the variable names of the AllData2 table to find the columns we want. 
  Note 1: grep() will work, but returns warnings.
  Note 2: ActivityIDNumber, Activity, and SubjectIDNumber are *explicity* searched for exactly as spelled because I want those in the final working data set.
Finally, DesiredData is created from the resulting table

Section 5 reads and adjusts the variable names using a search and replace to something HUMAN READABLE AND UNDERSTANDABLE. I also left a row and column counter in there for my own convenience so I can be sure it is working as expected. This does not affect the output.

Section 6 is where the big transformation happens. The aggregate() function is used to calculate the mean values per each ActivityIDNumber and SubjectIDNumber. The Activity field is first stripped off, and then later re-added with merge(). If this is not done, it will duplicate for some reason. Finally, the data set is sorted by ActivityIDNumber and then SubjectIDNumber, and then written out to a text file.

# About

R program that implements K-Nearest Neighbour with K-Fold Cross Validation. Although the program analyzes "Appointment1000" dataset but can easily be tweeked for other datasets.

# K-Fold Cross Validation

The data set is divided into 10 different parts and the KNN model is fitted with the k-1 parts (training set) and predicted using 1 part (test set). Following this, the test mean square error is calculated and the above procedure is repeated 10 times for each part to be treated as a validation set. In the end, the test error rate is calculated as the average of all 10 errors. Finally the best value of K is chosen and the KNN model is fitted again with the best "K".

## Plot



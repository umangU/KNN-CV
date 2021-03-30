# About

R program that implements K-Nearest Neighbour with K-Fold Cross Validation. Although the program analyzes "Appointment1000" dataset but can easily be tweeked for other datasets.

# Discussion

The data set is divided into 10 different parts and the KNN model is fitted with the k-1 parts (training set) and predicted using 1 part (test set). Following this, the test mean square error is calculated and the above procedure is repeated 10 times for each part to be treated as a validation set. In the end, the test error rate is calculated as the average of all 10 errors. Finally for all the values of K (0-200 in this case), 10 folds are fited and error rates are determined therfore giving the optimal K with minimum error.

## Plot

KNN Cross-Validation error rates against all values of K and folds

![image](https://user-images.githubusercontent.com/72771903/112981813-6aa9a200-91a7-11eb-8fd8-eaf8a65ef2ab.png)

   

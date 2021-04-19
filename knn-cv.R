# Loading the libraries class and caTools for knn() and sample.split() respectively
library(class)
library(caTools)

# Loading the libraries tibble and tiddyverse for the tibble() and ggplot() respectively
library(tibble)
library(tidyverse)

# Reading the appointment1000.csv in R
appoint=read_xlsx(file.choose())

# Declaring number of folds
M <- 10
# Getting the dimension of the dataset
n<-dim(appoint)[1]
# Declaring the k-values
k_values <- c(3, 7, 9, seq(from=1, to=200, by=4)) num_k=length(k_values)
# Creating a dataframe to store the cross validation errors error_df <- tibble(k=rep(0, num_k), tr=rep(0, num_k), ts=rep(0, num_k))
cv_error_df <- matrix(0, nrow=num_k, ncol=M) %>% as_tibble() %>%
  add_column(k=k_values)
# Make column names nice
colnames(cv_error_df) <- str_replace(colnames(cv_error_df), 'V', 'fold')

# Looping through all the M = 10 folds
for(m in 1:M)
{
  points<-floor(n*(M-1)/M)
  
  # Dividing the dataset into train and test 
  indices<-sample(x=1:n, size=points, replace=FALSE) 
  train.index <- appoint[indices,]
  test.index <- appoint[-indices,]
  
  # looping through all the k values
  for(i in 1:num_k)
  {
    k<-k_values[i]
    # Seperating the train and test data
    train.X <- train.index %>% select(-No.show)
    train.show <- train.index$No.show 
    # turn into a vector 
    test.X <- test.index %>% select(-No.show)
    test.show <- test.index$No.show 
    # turn into a vector
    # Using knn classifier on the training data
    knn_train_prediction <- knn(train.X,train.X,train.show, k=k) 
    # using knn classifier on the test data
    knn_test_prediction <- knn(train.X,test.X,train.show,k=k)
    # Getting the train and test error
    tr_err <- mean(knn_train_prediction!=train.show) 
    ts_err <- mean(knn_test_prediction!=test.show)
    # Storing the train and test prediction error as a list
    cv_error<-list(tr=tr_err,ts=ts_err)
    cv_error_df[i, paste0('fold',m)] <- cv_error[['ts']]
    error_df[i, 'k'] <- k
    error_df[i, 'tr'] <- cv_error[['tr']]
    error_df[i, 'ts'] <- cv_error[['ts']]
  } }

# Plotting the the cross validation error against the value of k
cv_error_df %>%
  gather(key='type', value='error', contains('fold')) %>% ggplot() +
  geom_point(aes(x=k, y=error, color=type, shape=type)) + geom_line(aes(x=k, y=error, color=type, linetype=type))+ ggtitle('knn cross validation')

# Compute the mean cv error for each value of k
cv_mean_error <- cv_error_df %>%
  select(-k) %>%
  rowMeans()

# Getting the mean errors for all values of k
error_df <- error_df %>%
  add_column(cv=cv_mean_error)
# Printing the mean errors for all values of k
error_df
# Printing the minimum cv errors on the training data for all values of k
error_df %>%
  filter(tr==min(tr))
# Printing the minimum cv errors on the test data for all values of k
error_df %>%
  filter(ts==min(ts))
# Printing the minimum cross validation error rate and respective value of k
error_df %>%
  filter(cv==min(cv))

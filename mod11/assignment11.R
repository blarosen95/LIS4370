# The fundModeling library is only being imported to use as a known-good reference for testing my own outlier detection.
library(funModeling)
# The mdedge/stfspack library is imported to simplify the creation of a matrix with outliers.
# You might need to run the following 2 lines in the R console to install the library:
# install.packages("remotes")
# remotes::install_github("mdedge/stfspack")
library(stfspack)

# set.seed(1915)
set.seed(16061915)

matches_funModeling <- function(bottom_threshold, top_threshold, x) {
  actual <- c(bottom_threshold, top_threshold)
  names(actual) <- c("bottom_threshold", "top_threshold")
  return(actual == tukey_outlier(x))
}

tukey_multiple <- function(x) {
  outliers <- array(TRUE,dim=dim(x))
  # for (j in 1:ncol(x)) # Defensive programming point 1
  for (j in seq(ncol(x)))
  {
    # Assign the column located at index of current iterator, the result of a function (this would be the bug as the
    # function does not exist yet) in the form of a boolean expression:
    # outliers[,j] <- outliers[,j] && tukey.outlier(x[,j], j)
    # TODO: The above could possibly be replaced with a line that does not include the `outliers[,j] &&` part.
    # TODO: In fact, it needs to be replaced as the boolean expression is incorrect
    outliers[,j] <- tukey.outlier(x[,j], j) # TODO: Major blog discussion here on the background of TRUE && FALSE
  }
  outlier.vec <- vector(length=nrow(x))
  # for (i in 1:nrow(x)) # Defensive programming point 1 repeated
  for (i in seq(nrow(x)))
  {
    # TODO: It is tricky for me to decide whether using `all` is correct, but it will be discussed in the blog
    # print(all(outliers[i,]))
    outlier.vec[i] <- all(outliers[i,])
  }
  return(outlier.vec)
}

# The missing function:
tukey.outlier <- function(x, debug_column_num) {
  q <- quantile(x)
  q_25 <- q[2]
  q_75 <- q[4]
  iqr <- IQR(x)

  bottom_threshold <- q_25 - 3 * iqr
  top_threshold <- q_75 + 3 * iqr
  stopifnot(matches_funModeling(bottom_threshold, top_threshold, x)) # Defensive programming point 2

  rtn <- array(T,dim=length(x))
  for (i in seq(length(x)))
  {
    ifelse(x[i] < bottom_threshold || x[i] > top_threshold, rtn[i] <- TRUE, rtn[i] <- FALSE) # TODO: not debuggable
  #   if (x[i] < bottom_threshold || x[i] > top_threshold)
  #   {
  #     # print(debug_column_num)
  #     # print(x[i])
  #     rtn[i] <- TRUE
  #   }
  #   else
  #   {
  #     rtn[i] <- FALSE
  #   }
  }

  return(rtn)
}

# Injecting a full row of outliers into mat to test the `all` call at end of tukey_multiple function:
mat <- matrix(0, nrow=6, ncol=10)
mat[1:5,] <- matrix(rnorm.contam(50), ncol=10)
mat[6,] <- c(1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000, 1000)

# actual <- tukey.outlier(mat[,6], 6)

# Use the function to find the outliers:
result <- tukey_multiple(mat)
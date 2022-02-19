A <- matrix(c(2, 0, 1, 3), ncol=2)
B <- matrix(c(5, 2, 4, -1), ncol=2)

# Find A+B
A+B
# Find A-B
A-B

# Using the diag() function, build a matrix of size 4 with the following values in the diagonal: 4, 1, 2, 3
C <- diag(c(4, 1:3))
C

# Generate the following matrix:
# [,1] [,2] [,3] [,4] [,5]
# [1,] 3 1 1 1 1
# [2,] 2 3 0 0 0
# [3,] 2 0 3 0 0
# [4,] 2 0 0 3 0
# [5,] 2 0 0 0 3

D <- matrix(0, 5, 5)
D[1,] <- 1
D[,1] <- 2
diag(D) <- rep(3, 5)
D

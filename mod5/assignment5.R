library(MASS)

# Instantiate two matrices, one with 100 columns and the other with 1000 columns both of which have 10 rows:
A <- matrix(1:100, nrow=10)
B <- matrix(1:1000, nrow=10) # Would be square if nrow were 32, and compatible with A if nrow were 100

det(A) # A is singular as its determinant here is zero
# det(B) # B is not square and, therefore, does not have a determinant

# solve(A) # As A is singular, so there cannot be a true inverse
# solve(B) # B is not square and, therefore, cannot be inverted

# Define two variables as the Moore-Penrose pseudoinverse of A and B:
mPInverseA <- ginv(A)
mPInverseB <- ginv(B)
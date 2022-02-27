irises <- iris
setClass("Flower",
         slots = c(
           Sepal.Length = "numeric",
           Sepal.Width = "numeric",
           Petal.Length = "numeric",
           Petal.Width = "numeric",
           Species = "character"
         )
)

first_iris <- iris[1,]

iris_s4 <- new("Flower",
                Sepal.Length = first_iris$Sepal.Length,
                Sepal.Width = first_iris$Sepal.Width,
                Petal.Length = first_iris$Petal.Length,
                Petal.Width = first_iris$Petal.Width,
                Species = as(first_iris$Species, "character")
)

data("iris") # Works
head(iris, 6) # Works
list(iris, 6) # Works
# data(iris_s4) # Won't work because this object is not a data set.
# head(iris_s4, 6) # You cannot use head on an object that cannot be subsetted. As an S4-type, iris_s4 cannot be subsetted.
list(iris_s4, 6) # Shouldn't work

# You can tell what OO system (S3 vs S4) an object is associated with `isS4`:
isS4(first_iris) # False
isS4(iris_s4) # True

# You can determine the primitive/generic type of a variable with `class`:
class(first_iris) # data.frame
class(iris_s4) # Flower
# You can determine the base type of a variable with `typeof`:
typeof(first_iris) # list
typeof(iris_s4) # S4

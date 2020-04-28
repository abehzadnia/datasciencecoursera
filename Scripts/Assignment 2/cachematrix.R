## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse.


makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL #defining object inv - inverse matrix
  setMatrix <- function(y){
    x <<- y #passing obj matrix to parent environment
    inv <<- NULL
  }
  setMatrixInverse <- function(MatrixtInverse) inv <<- MatrixtInverse
  getMatrix <- function()x
  getMatrixInverse <- function()inv
  list(
    setMatrix = setMatrix,
    getMatrix = getMatrix,
    setMatrixInverse = setMatrixInverse,
    getMatrixInverse = getMatrixInverse
  )
}

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inv <- x$getMatrixInverse()
  if(!is.null(inv)){
    message("getting cached data")
    return(inv)
  }
  data <- x$getMatrix()
  inv <- solve(data, ...)
  x$setMatrixInverse(inv)
  inv
}

rm(x)
x<-matrix(rnorm(25),5 ,5)
x
solve(x)

my_matrix<-makeCacheMatrix(x)
my_solve<-cacheSolve(my_matrix)
print(my_solve)[1]


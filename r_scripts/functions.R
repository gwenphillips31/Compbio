### functions
### Gwen Phillips
### Feb 10 2026

###__________________________________________________________________________________________________
sum(3,2) # a "prefix" function
3 + 2 # an "operator", but it is actually a function
`+`(3,2) # the operator is an "infix" function

y <- 3
print(y)

`<-`(yy,3) # another "infix" function
print(yy)

# to see contents of a function, print it
print(read.table)

sd # shows the code
sd(c(3,2)) # call the function with parameters
# sd() # call function with default values for parameters

functionName <- function(parX=defaultX,parY=defaultY,parZ=defaultZ) { 
  return(z)  # returns from the function a single element (z could be a list)
  } 

# prints the function body
functionName 

# calls the function with default values and returns object z
functionName() 

hardy_weinberg <- function(p=runif(1)) {
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
 vec_out <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
 return(vec_out)
}

# calls the function with user-specified values for each paramater
functionName(parX=myMatrix,parY="Order",parZ=c(0.3,1.6,2,6))
hardy_weinberg<- function(p= runif(1)){

  print(sum(c(q,p)))



}
###########################################
#END FUNCTION

hardy_weinberg


### global bs local parameters:
my_func<- function(a= 3, b=4){
  z<- a+b
  return(z)
}

my_func()

b<-4
my_bad_func<- function(a=3){
  z<- a+b
  return(z)
}
my_bad_func()

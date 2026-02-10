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

### passing global properly
a<- 32
b<- 4

my_func_2<- function(first, second){
  z<- first+second
  return(z)
}

my_func_2(first=a, second= b)

### hardy_weinberg
hardy_weinberg <- function(p=runif(1)) {
  if(p> 1 | p< 0){
    return("Function failure p must be grreater than 0 or less than 1")
  }
  
  q <- 1 - p

  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
 vec_out <- signif(c(q=q, p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
 return(vec_out)
}

################
### END Function
hardy_weinberg(p= 3)


### using stop
hardy_weinberg <- function(p=runif(1)) {
  if(p> 1 | p< 0){
    stop("Function failure p must be grreater than 0 or less than 1")
  }
  
  q <- 1 - p

  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
 vec_out <- signif(c(q=q, p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
 return(vec_out)
}
############## END FUNCTION
hardy_weinberg(p= 3)


#### Linear model w/ regression
# START OF FUNCTION
############################################################
fit_linear <- function(x = runif(20), y= runif(20)){
 #################################################################
### FUNCTION: fit_linear
### PURPOSE: fits a simple linear regression
### INPUTS: numeric vector of predictors x and response y
### OUT: slope and p-value 
 my_mod<- lm(y~x)### heres the model
  ### get values out
 my_out<- c(slope=summary(my_mod)$coefficients[2,1],
  p_value=summary(my_mod)$coefficients[2,4]) 

  ### plot the output
  plot(x=x, y=y)
  return(my_out)
}
############################################################
### END OF FUNCTION

fit_linear()

var1<- 1:20
var2<- 21:40

fit_linear(x= var1, y= var2)

# START OF FUNCTION
############################################################
fit_linear<- function(p=NULL){
  #################################################################
### FUNCTION: fit_linear
### PURPOSE: fits a simple linear regression
### INPUTS: numeric vector of predictors x and response y
### OUT: slope and p-value  
  if(is.null(p)){
    p <- list(x=runif(20), y= runif(20))
  }
  my_mod<- lm(p$x~p$y) ### fit the model

  ### get the outputs
  my_out<- c(slope=summary(my_mod)$coefficients[2,1],
  p_value=summary(my_mod)$coefficients[2,4]) 

  plot(x=p$x, y=p$y) ### quick and dirty plot to check output
  return (my_out)
}

fit_linear()

my_parms<- list(x=1:10, y=sort(runif(10)))
my_parms

fit_linear(p= my_parms)

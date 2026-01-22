### This is a document describing vectors in R
### 22-Jan-2026
### G. Phillips

###-----------------------------------------------------------------------
### Start of script

x<- 5
print(x)

plant_height <- 3 #snake case
plantHeight <- 4 # camel case
plant.height <-2 # thats not preferred

### . is not a defined character so could be used for temp variable


### 1D atomic vec:
z<- c(3.2,5,5,6)
print(z)
typeof(z)

z<- c(c(3.2,3),c(3,5))
print(z)
is.character(z)

###character strings
t <- "perch"
print(t)

t<- c("perch","bass","trout")
print(t)
t[1]

t<- c("This is a 'character' string","a second")
t[2]

typeof(t)
is.numeric(t)

###Logical/ Boolean
z<- c(TRUE, FALSE, TRUE)
print(z)

is.logical(z)

mean(z)

### vector properties
z<- c(1.1,1.2,3,4.4)
typeof(z)
is.numeric(z)
t<- as.character(z) # as. coerces variabel
print(t)

t<- c(1,2,"3",4)

length(t)


### random number generator
z<- runif(5)
names(z)
print(z)

names(z) <-c("A","B","C","D","E")
names(z) <- NULL #### resets names to nothing

###special data types
z<- c(3.2,3,3,NA)
print(z)
typeof(z)
length(z)
typeof(z[3])
typeof(z[4])

sum(z, na.rm=T)

z<- 0/0
z
z<-1/0

### vectorization
z<- c(10,20,30, 40)
z *2
z /3

y<- c(1,2,3)
z+y

### recycling 
x<- c(1,2)
z+x

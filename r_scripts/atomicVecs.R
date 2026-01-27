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


##### Atomic vec pt II

z<- vector(mode = "numeric", length=0)
print (z)
### dynamic creation (Dont in R, do in Python)
z<- c(z,5)
print (z)

#### predefined length
z<- rep(0,100)
print (z)
length (z)

### empty vector
z<- rep(NA, 100)
print (z)

typeof(z)

z[1]<- "Vermont"
head(z)
typeof(z)

my_vector <- runif(100)
my_names <-paste("Species", seq(1:length(my_vector)),sep="") #length=100
print (my_names)

names(my_vector) <- my_names
head(my_vector)
str(my_vector)

### Using the rep function
rep(0.5, 6)
rep(x=0.5, times= 6)
my_vec <- c(1,2,3)


### repeat a vector
rep(x=my_vec, times=2, each=2)

### seq vectors
seq(from= 2, to= 4)
2:4 # okay shorthand

x<- seq(from= 2, to= 4, length= 7) ### evenly spaced with final length of 7

my_vec <- 1:length (x) ### common in other languages, slow in R
my_vec

### Better in R
seq_along(my_vec)

### generating random vectors
runif(5) #gives us 5 values from 0-1

###The params
set.seed(123) ### takes any number and gives you the same progression
runif(n=1, min=0, max=1)

### normal distribution
out<- rnorm(n=500, mean =100, sd=30)
hist(out)

### random sampling

long_vec<- seq_len(10)
sample(x= long_vec, size=100, replace= T)

### weighted sampling from a vec
weights<- c(rep(20,5),rep(100,5))
weights

sample(x=long_vec, replace=T, prob=weights)

### subsetting vectors
z<- c(3.1, 9.2, 1.3, 0.4,7.5)
print(z)

z[-c(2,3)] #using vecs to slice
z[z<3] # using logical

# <   less than
# >   greater than
# <=  less than or equal to
# >=  greater than or equal to
# ==  equal to

#logical vectors
# ! not
# & and (vector)
# | or (vector)
# xor(x,y)

x<- 1:5
y<- c(1:3, 7,7)

x==2 # equals
x !=2 #not equals
x ==5 & y==7 ### using and
x==1 | y== 7 ## or
x==3 | y==3

### missing values
set.seed(90)
z<- runif(10)
z
z<0.5
z[z< 0.5]

z[which(z<0.5)]

zd<- c(z,NA, NA)

zd[zd< 0.5]

#### dropping NA with which to index
zd[which(zd< 0.5)]

### Lists, Matrices, and data frames
### Gwen Phillips
### Jan 29 2026

###__________________________________________________________________________________________________

### create a mat from a vector
my_vec<-1:12

### numbers by rowa
m<- matrix(data= my_vec, nrow= 4)
m

### numbers by columns, as in the other way
m<- matrix(data=my_vec, ncol=3, byrow = T)
m

### Lists
my_list<- list(1:10, matrix(1:8, nrow=4, byrow=T), letters[1:3], pi)
my_list

### indexing a list
x<- my_list[[1]] #double brackets for object within the list element

### indexing into a matrix
my_list[[2]][1,2] # [rows, columns]

### naming lists
my_list2<- list(tester=FALSE, little_m= matrix(1:9, nrow=3))
my_list2

### named objects in lists
my_list2$little_m [2,3]

### looking at empty place indexing
my_list2$little_m [1,] ### works for rows or columns
my_list2$little_m [2] ### treats matrix as vector

### unlist
unrolled<- unlist(my_list2)
unrolled

### unpacking complex lists
install.packages ("ggplot2")
library (ggplot2)

### create some random vars
y_var<- runif(10)
x_var<- runif(10)

### regression
my_model<- lm(y_var~x_var)

### plot it
plot(x=x_var, y=y_var)

### explore structure
str(summary(my_model))
summary(my_model)$coefficients ["x_var","Pr(>|t|)"]
u<- unlist(summary(my_model))
u
pval<- u$coefficients8

### data frames
var_a<- 1:12
var_b<- rep(c("A", "B", "C"), 4)
var_c<- runif(12)

### creating df from vectors
df<- data.frame(var_a, var_b, var_c)
str(df)
df$var_b ### look up a column
df[1,3] ### look up a cell
df$var_a[1] ### different cell lookup

### expanding and appending the data frame
new_data<- list(var_a=13, var_b="D", var_c= 0.77)

df2<- rbind(df,new_data) ### appending the frame
head(df2, 10) ### gives first 10 rows
View(df2) ### calls up data frame into view

### add a new column to a df
### using cbind
new_var<- rnorm(13)
df3<- cbind(df2, new_var)
### using assignment operator
char_var<- rep("T", 13)
df3$charV <- char_var

### writing data frames
getwd()
write.csv(df3, "data/my_dataframe.csv")
data<- read.csv("data/my_dataframe.csv")
data$var_a


### Distinctions between DFs and Mat Dims

z_mat<- matrix(data=1:30, ncol= 3, byrow= T)
z_dframe<- as.data.frame(z_mat) #turn into df

str(z_mat)
str(z_dframe)

head(z_mat)

z_mat[2,2]
z_dframe$V2[2] ## more correct for df

z_dframe$V1
z_mat[,3]

### reference only on demension
z_mat[2]
z_dframe[2]

### missing data in DFs and Mats
zd<- runif(10)
zd[c(5,7)] <- NA
 print(zd)

### complete cases
complete.cases(zd)

### filter for only true
zd[complete.cases(zd)]

### which positions are missing
which(!complete.cases(zd)) ### ! means not

### missing data in a matrix
m<- matrix(1:20, nrow=5)
print(m)

###add missing data
m[1,1] <- NA
m[5,4]<- NA

m[complete.cases(m),] ### comma maintains dimensionality

### subsetting mats and df
m<- matrix(data= 1:12, nrow=3)

dimnames(m)<- list(paste("Species", LETTERS[1:nrow(m)],sep=""),paste())

### elementwise subsetting
m[1:2, 3:4]

m[1:2,]
m[,3:4]

### using logical for subsetting
sums<- colSums(m) 

sums [sums>15]

rowSums(m)
m[rowSums(m)==22]

m[,"Site1"]<3

### data curation
install.packages(rmarkdown)

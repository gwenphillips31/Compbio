### basic coding with for loops
### 10, 12, 17 Feb 2026
### Gwen Phillips

### creating a basic for loop:
for(i in 1:5){
    cat("stuck in a loop", "\n")
    cat(3+2, "\n")
    cat(runif(1), "\n")
}

my_dogs<- c("chow", "akita", "malamute", "husky", "samoyed")

for(i in 1:length(my_dogs)){
  cat("i= ", i, "my_dogs[i]= ", my_dogs[i], "\n")
}

my_bad_dogs<- NULL
for(i in 1:length(my_dogs)){
  cat("i= ", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

for(i in seq_along(my_dogs)){
   cat("i=", i, "my_dogs[i] =", my_dogs[i], "\n")
}

### Tip 1
### dont do things in a loop if you dont need to
 for(i in seq_along(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])
 }
toupper(my_dogs)  ### also tolower function

### Tip 2
### Dont channge the dimensions in a loop
my_dat <- runif(1)
my_dat
for(i in 2:10){
  temp<- runif(1)
  my_dat<- c(my_dat, temp)
  ### cat("loop number =", i, my_dat[i], "\n")
  print(my_dat)
}

### Tip 3
### dont write a loop if you can vectorize it
my_dat<- 1:10
for (i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number =", i, "vector element =",my_dat[i], "\n")
}
### This is much faster and efficient
z<- 1:10
z<- z+z^2

### Tip 4
###  remember difference between i and z[i]

z<- c(10,2,4)
for (i in seq_along(z)){
  cat("i=", i,"z[i] =", "\n")
}

### Tip 5
### dont have to loop through everything
z<- 1:20
for (i in seq_along(z)){
  if(i %% 2 ==0) next
  print(i)
}

#########################################
### Look at the parameter space of the logistic
### growth model with a for loop
pop<- function(r=0.1, N0, k, tstep, tfinal){
time<- seq(from= 0, to= tfinal, by=tstep)
n_t<- k/(1+((k-N0)/N0)*exp(-r*tstep))
output<- data.frame(
    time= time,
    population= n_t
)
return(output)
}

result <- pop(
    N0=10,
    r=0.1,
    k=100,
    tstep= 0.1,
    tfinal=50
)

r_vec<- seq(0,1, by= 0.1) ### vector of the little rs
container_vec<- rep(NA, length(r_vec)) ### storage for max_n

for(i in seq_along(r_vec)){
  temp_df<- pop(r=r_vec[i])
  max_n<- (temp_df$population)
  container_vec[i]<- max_n ### storage is happening here
}

growthDF<- data.frame(r=r_vec, N= container_vec)
head(growthDF)

plot(x=growthDF$r, y= growthDF$N)

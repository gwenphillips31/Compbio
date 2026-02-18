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

################################
#2d parameter sweep for log grwoth function
r_values<- seq(0,1, length.out=100)
k_values<- seq(10,1000, length.out=100)

### create storage matrix for outputs
store_mat<- matrix(NA, nrow= length(r_values), ncol=length(k_values))

growth_sweep<- function(rvec, kvec){
  ### create a matrix for the outputs
  store_mat<- matrix(NA, nrow= length(rvec), ncol=length(kvec))

  for( i in seq_along(rvec)){ ### rows
  for(j in seq_along(kvec)){ ### cols

    ### run log growth
    tmp_df<- pop(r=rvec[i], K= kvec)

    ### store max n in 2D matrix
    store_mat[i,j] <- max(tmp_df$population)
  }
}
  return(store_mat)
}

## run growth param sweep
growth_mat<- growth_sweep(rvec= r_values, kvec= k_values)

### create storage dataframe
dfLength<- length(rvec)*length(kvec)

r_out<- rep(NA,dfLength)
k_out<- rep(NA, dfLength)
maxn_out<- rep(NA,dfLength)

### turn vecs into df
storagedf<- data.frame(r_out, k_out,maxn_out)

pop(r=r_values[i], K= k_values)
################################ Feb 17
### Create a random walk function
### Name ran_walk
### Purpose: conduct a random walk
### Input: times= number of time steps
### N1 intitial pop size
### lambda= finite rate of increase
### noise_sd= 10
### Output: 
### vector n with population size >0 until extinct
##################################################
library(ggplot2)
#### Start of function
ran_walk<- function(times= 100, n1= 50, lamda= 1, noise_sd=10){
  n<- rep(NA, times)  ### create our output vec
  n[1]<- n1  ### initialize init pop size
  noise <- rnorm(n=100, mean=0, sd =noise_sd)  ### created noise/error

    for(i in 1:(times-1)) {
                  n[i + 1] <- lamda*n[i] + noise[i]
                  if(n[i + 1] <=0) {
                    n[i + 1] <- NA
                    cat("Population extinction at time",i+1,"\n")
                    break}
  }
  return(n)
}

x<- ran_walk
print(x)


### plotting with default values
qplot(x=1:100, y=ran_walk(), geom="line")

### not so random walk
qplot(x=1:100, y=ran_walk(noise_sd=0), geom="line")

### no noise and adjust lamda
qplot(x=1:100, y=ran_walk(lamda= 0.92, noise_sd=0), geom="line")

### add some stoch. make lamda
qplot(x=1:100, y=ran_walk(lamda= 1.01, noise_sd=3), geom="line")

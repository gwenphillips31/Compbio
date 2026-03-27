### Gwen Phillips
### python intro
### 3/17-3/19

################################################################

###############################################################################
import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.api as sm
import statsmodels.formula.api as smf

###############################################################################
# OBJECTS, METHODS, and FUNCTIONS
###############################################################################

print("I love Python!") # the print function

greeting = "Hello!" # character string as an object

scaler = 6 # integer value

out = scaler * 3 # multiply by 3 to create a new object

myList = [34, 7, 98] # a list

myList.append(33) # a method of a list object

len(myList) # function performed on the object

###############################################################################
# DATA STRUCTURES AND INDEXING
###############################################################################


# ------ LISTS ------ #

# make a list of colors
a_list = ["blue", "green", "red"]

# indexing
first_element = a_list[0]

print(a_list)
print(first_element)

# how long is the list?
len(a_list)

# data types
nums = [1, 3, 5, 8]
chars = ["a", "b", "c"]
boolean = [True, True, False, True, False]

# a mixed list
mixed = [1, 3, True, "blue", 5]

type(mixed) # what type of object is this

# negative indexing
mixed[-1] # last
mixed[-3] # third from the right

# ranged indexing
mixed[1:4] # 1 through 4
mixed[:4] # the start through 4
mixed[2:] # 2 to the end

# is an item in my list?
1 in mixed

# change blue to green
mixed[3] = "green"

# the insert method
mixed.insert(0, "start")

# other methods....
# extend
# remove
# pop
# clear
# and others


# List Comprehension
print(mixed)

# make a list from all items in mixed
[x for x in mixed]

# print each item in list
[print(x) for x in mixed]

# make a new list of just string items
[x for x in mixed if isinstance(x,str)]

######################
###DICTIONARIES
#######################

md={
    "first":"John",
    "last":"Smith",
    "year": 2017,
    "status": "active"
}

md2= dict(first= "John", last= "Smith")

type(md)
len(md)

### data types within a dictionary
dataTypes={
    "string":"thing",
    "integer": 3,
    "float": 3.14342,
    "list": (1,2,3,"a"),
    "boolean": False
    }

### Calling values by using key name in brackets
dataTypes["string"]

### you can use built in method
dataTypes.get("boolean")

dataTypes.keys()
dataTypes.values()

### return as a list of tuples
dataTypes.items()
### add value
dataTypes["age"]=36
### change value
dataTypes["age"] = 35
dataTypes

############################
# NUMPY

arr1= np.array([0,1,2,3,4,5,6,7,8,9])
arr1[3]
arr1[-1]
arr1[:3]
arr1[1:5]
arr1[1:8:3] ### last place in indexing encodes every nth place in array

### 2d arrays
arr2= np.array([[1,2,3],[4,5,6],[7,8,9]])
arr2[2,2]
arr2[:,2] # third column
arr2[2,:] # third row
arr2[0:2,0:2] # a 2D subset with slicing

### 3d arrays
arr3 = np.array([[[1, 2], [3, 4]], [[5, 6], [7, 8]]])

arr3[1,0,1] # layer, row, column

# dimensions of arrays
arr1.ndim # 1 dimension
arr2.ndim # 2 dimensions
arr3.ndim # 3 dimensions

# shapes...
arr1.shape
arr2.shape
arr3.shape

# data types...
arr2.dtype # what is our data type?
arr2.astype(str) # convert to another type

# reshaping
arr1.shape # a 1D array
arr1.reshape(2,5) # make it a 2D array

arr3.shape # a 3d array
arr3.reshape(4,2)

### Joining arrays
first = np.array([1,2,3])
second = np.array([4,5,6,7,8,9])

longArray = np.concatenate((first, second)) # concatenate arrays

# 2D arrays - lets examine the axis argument
np.concatenate((arr2, arr2), axis=0)

# stacking arrays - creates a new axis - try: dstack, vstack
np.stack((arr2, arr2))

# splitting arrays ------------
np.array_split(arr1, 2) # 1D array

np.array_split(arr3, 2, axis=0) # 2D array on axis

from numpy import random

random.seed(seed=100)

random.randint(50)

x= random.normal(loc= 5, scale= 3, size= 200)
plt.hist(x)
plt.show(x)

x= random.binomial(n = 10, p = 0.5, size= 300)

plt.hist(x)
plt.show

x= random.uniform(low=1, high= 10, size =50)
print(x)

### math is still math

x*100

arr2*arr2

np.mean(arr2)
np.max(arr2)

##############################################################
### logic structures
##############################################################
### if.stat

a=6
if a >= 5:
    print("a is greater than or eaqual to 5")

if a >=6:
    print ("a is greater than or equal to 5")
else:
    print("a is less than 5")

a=3
b=3
operation= "mutl"

if operation = "mult":
    y=a*b
elif operation == "div":
    y= a/b
elif operation == "add":
    y= a+b
elif operation == "sub":
    y= a-b
else:
    y= "i dont know that operation"
 
y

#############################################################
### Loops
#############################################################

l= [10, 20]

for i in range(2):
    print(l[i])

### loop on an obj directly
x= ["blue","green","red"]

for i in x:
    print(i)

### a more complicated loop
rnd= random.uniform(low=1, high= 5, size= 10)

outList= [] ### truly empty list

for i in range(len(arr1)):
    outList.append(rnd[i]+ arr1[i])

outList

### nested loop with ifelse

rnd2D= random.uniform(low= 0, high= 1, size= (3,3))
rnd2D

matOut = np.empty(shape= (3,3))
shp = rnd2D.shape
shp

### nested loop
for i in range(shp[0]):
    for j in range(shp[1]):

        if rnd2D[i,j] >p= 0.5:
            matOut[i,j] = rnd2D[i,j]*1000
        else:
            matOut[i,j] = rnd2D[i,j]/1000

matOut

###############################################################################
# PANDAS
###############################################################################

# ------ CREATING A DATA FRAME ------ #

# make a date vec
dates = pd.date_range("20130101", periods=6)

# create a data frame with 4 numeric columns of length 6 named A, B, C, and, D
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list("ABCD"))
df

# ------ DF INFO ------ #

df.head(4) # top 4 rows
df.tail(4) # bottom 4 rows

df.index # look at index variables
df.columns # look at the columns
df.describe() # summary stats for each row

# convert to numpy array
df.to_numpy()

# ------ DF INDEXING ------ #

# selecting rows and columns - BY LABELS
df["A"] # column
df.loc[:, ["A", "B"]] # columns
df["20130102":"20130104"] # rows

# slicing on both axises using the date labels
df.loc["20130102":"20130104", ["A", "B"]]

# selecting rows and columns - BY LOCATION
df.iloc[3,2] # value at index 3,2
df.iloc[[1, 2, 4], [0, 2]] # rows 1,2,4 and cols 0 and 2
df.iloc[1:3, :] # First two rows all cols

# ------ DF MANIPULATION ------ #

# read in data sets
ds = pd.read_csv("iris.data.csv")
ds["sepal_length"] # pull sepal width out of data set

ds.head() # examine the data set

# adding a new columns
ds["sepal_area"] = ds.sepal_length * ds.sepal_width
ds["petal_area"] = ds["petal_length"] * ds["petal_width"]

# boolean operations
ds[ds["sepal_length"] > 7] #  all rows where sepal length is greater than 7

# fully numeric data frame
df[df > .5] # values in the data frame greater than 2 - everythin else is nan

# ------ DF GROUPING AND SUMMARY ------ #           

# mean of petal length and petal width for each species
mean_table = ds.groupby("species")[["petal_length", "petal_width"]].mean()

# let's make a long form data set and use hhierarchical indexing

# make wide format to long
ds_long = pd.melt(ds, id_vars=['species'], value_vars=["sepal_width", "sepal_length", "petal_width", "petal_length"],
           var_name='vars', value_name='vals')


# table with two indexes; species and variable
mult_indx = ds_long.groupby(["species", "vars"]).mean()


# pivot tables - another way of grouping
pd.pivot_table(ds_long, values="vals", index=["vars"], columns=["species"], aggfunc=np.mean)
pd.pivot_table(ds_long, values="vals", index=["vars"], columns=["species"], aggfunc=np.sum)



### GRAPHICS seaborn

### import seaborn

import seaborn as sns

sns.set_theme(style="ticks", font_scale = 1.5)

# ------ SCATTER PLOTS ------ #
# Species as column
sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      col="species")
plt.show()

# Species as style and color
sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      style="species", hue="species")
plt.show()

# Species as color - adding some features
f = sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)
f.legend.set_title("Species")
f.ax.margins(.15)
plt.show()

# lets move the legend
sns.set_theme(style = "white", font_scale = 1.5)

# Species as color - adding some features
f = sns.relplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)

# 'upper right', 'upper left', 'lower left', 'lower right', 'right', 'center left', 'center right', 'lower center', 'upper center', 'center'
sns.move_legend(
    f, "upper center",
    bbox_to_anchor=(.5, 1), ncol=3, title=None, frameon=False,
)

plt.show()

# ------ LINEAR FITS ------ #
f = sns.lmplot(
      data=ds,
      x="sepal_width", y="petal_length",
      hue="species", palette="bright")
      
f.set_axis_labels("Sepal Width", "Petal Length", labelpad=10)

plt.show()

# ------ A 4 PANEL HISTOGRAM ------ #
f = sns.displot(
    ds_long,
    x="vals", hue="species",
    col="vars", col_wrap=2, height=3,
    kde=True,
)
plt.show()

# ------ A BAR PLOT ------ #
sns.catplot(data=ds_long, kind="bar", x="species", y="vals", hue="vars")
plt.show()
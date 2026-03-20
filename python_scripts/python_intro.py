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

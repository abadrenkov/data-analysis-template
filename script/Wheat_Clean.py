import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas import DataFrame
import xlwt
from tempfile import TemporaryFile

# reading from the first xl file
xl = pd.ExcelFile("../data/raw/Wheat_Prices_1278_1536.xls")
df = xl.parse("Wheat")

#gathering all the data into a dictionary by year
#First we grab the year into the x variable. We check if the year is already in the dictionary. 
#If it is not, we start a new list for the data points. If it is, we grab the list associated with the
#year we want. Then we add a list of all the data points for that year
#to the dictionary. We do this for all the data in 5 files.
dict1 = {}
df2 = DataFrame(df)['Season']
for i in range(0, len(df2)) :
    x = df.iloc[i]['Season'][:4]
    if x in dict1.keys() :
        ls1 = dict1[x]
    else:
        ls1 = []
    for j in range(2, 15) :
        val = df.iloc[i][j]
        if not np.isnan(val) :
            ls1.append(val)
    dict1[int(x)] = ls1

# reading from the second xl file
xl2 = pd.ExcelFile("../data/raw/Wheat_Prices_1594_1681.xls")
df3 = xl2.parse("Wheat")

#gathering all the data into a dictionary by year
df4 = DataFrame(df3)['Season']
for i in range(0, len(df4)) :
    x = df3.iloc[i]['Season'][:4]
    if x in dict1.keys() :
        ls1 = dict1[x]
    else:
        ls1 = []
    for j in range(1, 7) :
        val = df3.iloc[i][j]
        if not np.isnan(val) :
            ls1.append(val)
    dict1[int(x)] = ls1	

# reading from the third xl file
xl3 = pd.ExcelFile("../data/raw/Wheat_Prices_1657_1817.xls")
df5 = xl3.parse("Wheat")

#gathering all the data into a dictionary by year
df6 = DataFrame(df5)['Year']
for i in range(0, len(df6)) :
    x = df5.iloc[i]['Year']
    if x in dict1.keys() :
        ls1 = dict1[x]
    else:
        ls1 = []
    for j in range(1, 6) :
        val = df5.iloc[i][j]
        if not np.isnan(val) :
            ls1.append(val)
    dict1[int(x)] = ls1	

# reading from the fourth xl file
xl4 = pd.ExcelFile("../data/raw/Wheat_Prices_1790_1850_2.xls")
df7 = xl4.parse("Wheat")

#gathering all the data into a dictionary by year
df8 = DataFrame(df7)['Year']
for i in range(0, len(df8)) :
    x = df7.iloc[i]['Year']
    if x in dict1.keys() :
        ls1 = dict1[x]
    else:
        ls1 = []
    for j in range(1, 2) :
        val = df7.iloc[i][j]
        if not np.isnan(val) :
            ls1.append(val)
    dict1[int(x)] = ls1	

# reading from the fifth xl file
xl5 = pd.ExcelFile("../data/raw/Wheat_Prices_1850_1950_2.xls")
df9 = xl5.parse("Wheat")

#gathering all the data into a dictionary by year
df10 = DataFrame(df9)['Year']
for i in range(0, len(df10)) :
    x = df9.iloc[i]['Year']
    if x in dict1.keys() :
        ls1 = dict1[x]
    else:
        ls1 = []
    for j in range(1, 2) :
        val = df9.iloc[i][j]
        if not np.isnan(val) :
            ls1.append(val)
    dict1[int(x)] = ls1		

#gather averages of the data
arr = []
for k in range(280, 680):
    if ((1270+k) in dict1.keys() and len(dict1[1270+k]) != 0) :
        ls2 = dict1[1270+k]
        sum = 0.0
        counter = 0.0
        for l in ls2:
            sum = sum + l
            counter = counter + 1
        arr.append(sum/counter/20.0)
    else:
		arr.append(None)

#graphing the data from 1270 to 1950
z = np.array(range(1550, 1950))
plt.plot(z, arr)
plt.xlabel('Year')
plt.ylabel('Pounds per Quarter')
plt.title('Wheat Prices')
plt.show()

#write to a excel file
book = xlwt.Workbook()
sheet1 = book.add_sheet('Wheat')
for i,e in enumerate(arr):
    sheet1.write(i,1,e)
for i in range(0, 400):
    sheet1.write(i,0,1550+i)
sheet1.write(0,2,0)
for i in range(1, 400):
    if arr[i] != None and arr[i-1] != None :
        sheet1.write(i,2,(arr[i]-arr[i-1])/arr[i-1])
    else :
        sheet1.write(i,2,0)

name = "../data/cleaned/Cleaned_Wheat.xls"
book.save(name)
book.save(TemporaryFile())
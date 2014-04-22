import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas import DataFrame

# reading from the xl file
xl = pd.ExcelFile("Wheat_Prices_1278_1536.xls")
print(xl.sheet_names)
df = xl.parse("Wheat")

#gathering all the data into a dictionary by year
dict1 = {}
df2 = DataFrame(df)['Season']
for i in range(0, len(df2)) :
    x = df.iloc[i]['Season'][:4]
    if x in dict1.keys() :
        ls1 = dict1[x]
    else:
        ls1 = []
    for j in range(2, 14) :
        val = df.iloc[i][j]
        if not np.isnan(val) :
            ls1.append(val)
    dict1[int(x)] = ls1

#gather averages of the data
arr = []
for k in range(0, 348):
    if ((1270+k) in dict1.keys()) :
        ls2 = dict1[1270+k]
        sum = 0.0
        counter = 0
        for l in ls2:
            sum = sum + l
            counter = counter + 1
        arr.append(sum/counter)
    else:
		arr.append(None)
print len(arr)

#graphing the data
z = np.array(range(1270, 1618))
plt.plot(z, arr)
plt.show()
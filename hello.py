import pandas as pd
from pandas import ExcelWriter
from pandas import ExcelFile
 
df = pd.read_excel('/Users/junsenpan/Downloads/isic.xlsx', sheetname='Sheet1')
 
print("Column headings:")
print(df.columns)
print(df.columns[1][0])
for cel in df["class"]:
    
    print(cel)
    
    
    





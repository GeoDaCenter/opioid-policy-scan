import pandas as pd
tract_file = pd.read_csv("the path to tract level data stored locally")
county_file = pd.read_csv("the path to county level level data stored locally")
#the type of GEOID for both county data and tract data is numpy.int.64 

#create set to store variables respectively
tract_cols = set(tract_file.columns)
county_cols = set(county_file.columns)

#get varibales in taract data which county data doesn't have
dif_tract = tract_cols - county_cols

#create geoid_c variale for tract data ro help match data with county data
COUNTYFP = []
for num in tract_file["GEOID"]:
    if(len(str(num)) == 10):
        COUNTYFP.append(int(str(num)[0:4]))
    else:
        COUNTYFP.append(int(str(num)[0:5])) 

#create an empty dataframe with dif_tract 
part_table = pd.DataFrame()
part_table["GEOID_C"] = COUNTYFP

#Get table for complemnetary data
for item in dif_tract:
    part_table[item]=tract_file[item]
#Get sum of data of tracts in theb same county, and remove NULL
new_table = part_table.groupby(["GEOID_C"]).sum()
new_table.dropna(axis=0, how="all", inplace=True)

#merge table
final_table = county_file.merge(new_table, how='outer', left_on="GEOID", right_on="GEOID_C")
#create file
final_table.to_csv("the path to store csv table after merging", index = False)

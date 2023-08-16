import pandas as pd
import re 

#the code below can used to check which invalid character
# file_path = "file path"
# position = error

# with open(file_path, 'rb') as file:
#     file_contents = file.read()
#     character = file_contents[position]

# print("Character at position", position, ":", character)

tract_file = pd.read_csv("tarct level data path")
county_file = pd.read_csv("county level data path")
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
tract_file["GEOID_C"] = COUNTYFP
part_table["GEOID_C"] = COUNTYFP
print(type(tract_file["GEOID_C"][1]))
#Get table for complemnetary data
for item in dif_tract:
    part_table[item]=tract_file[item]
#Get sum of data of tracts in theb same county, and remove NULL
new_table = part_table.groupby(["GEOID_C"]).sum()
new_table.dropna(axis=0, how="all", inplace=True)

#merge table
merged_table = county_file.merge(new_table, how='outer', left_on="GEOID", right_on="GEOID_C")

#Remove the columns which need to be calculated again or already existed
columns_drop = []
columns_recall = []
for item in merged_table.columns:
    if (("TmWk" in item) or
        ("TmBk" in item) or 
        ("MinDis" in item)):
            columns_drop.append(item)
for item in merged_table.columns:
    if(("CntDr" in item) or
       ("CntWk" in item) or
       ("CntBk") in item):
            columns_recall.append(item)
columns_drop.append("TRACTCE")
final_table_no_access = merged_table.drop(columns_drop + columns_recall, axis = 1)

#create some new variables
SpPerCap = []
PcpPerCap = []
ChildrenP = []
for item in final_table_no_access["TotSp"]:
        SpPerCap.append(item/100000)
final_table_no_access["SpPerCap"] = SpPerCap
for item in final_table_no_access["TotPcp"]:
        PcpPerCap.append(item/100000)
final_table_no_access["PcpPerCap"] = PcpPerCap
for i, j in zip(final_table_no_access["AgeOv18"], final_table_no_access["TotPop"]):
    ChildrenP.append(j-i)
final_table_no_access["ChildrenP"] = ChildrenP

#create and calculate the percentage of tracts with various providers in 30 biking/walking/driving distance
prd_table = pd.DataFrame(columns=["GEOID", "CNT_T"])
prd_table["GEOID"] = final_table_no_access["GEOID"]
cnt = []
for item in prd_table["GEOID"]:
    num = list(part_table["GEOID_C"]).count(item)
    cnt.append(num)
prd_table["CNT_T"] = cnt

#calculate the tract number with none-zero value for "walking"/"Biking"/"Driving" etc
#crreat table storing the count of tracts with various access variables
access_P_table = pd.DataFrame(columns = columns_recall, index=final_table_no_access["GEOID"])
for num in final_table_no_access["GEOID"]:
    sub_table = tract_file[tract_file["GEOID_C"] == num]
    for var in columns_recall:
        rsl = (sub_table[var] != 0).sum()
        access_P_table[var][num] = rsl
#Get the county level data with count of tracts
final_table_with_cntT = final_table_no_access.merge(prd_table, left_on="GEOID", right_on="GEOID", how = "outer")

#merging none_zero_record
final_table_with_access  = final_table_with_cntT.merge(access_P_table, left_on = "GEOID", right_index = True, how = "outer" )

#calculate percentage and create new variales
for item in columns_recall:
    final_table_with_access[item+"P"] = final_table_with_access[item]/final_table_with_access["CNT_T"]

#drop original access variables
final_table = final_table_with_access.drop(columns_recall, axis = 1)
final_table.to_csv("path to store file/C_Latest.csv", index = False)
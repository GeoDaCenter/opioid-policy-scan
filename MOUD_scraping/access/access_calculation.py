#https://colab.research.google.com/drive/1hFEU74iu_xTfT4rtZzsKw5f7OcClNGMt#scrollTo=MnPdB5LNyIJd
import numpy as np
import os
import pandas as pd
import geopandas as gpd
import altair as alt
import matplotlib.pyplot as plt
from spatial_access.Models import AccessCount, AccessModel, AccessSum, AccessTime
import itertools as iter
from itertools import groupby
from scipy.spatial import cKDTree
from shapely.geometry import Point

# year = 1980
# mm_key = 'Drug' #'Drug': 'Drug'
# year = 1990
# mm_key = 'MM' #'MM': 'Methadone Unit OT Other Unit'
# year = 2000
# mm_key = 'ML' #'ML': 'Methadone/LAAM'
year = 2010
mm_key = 'MM' #'Methadone maintenance'

#LOAD ORIGINS DATA
origins = pd.read_csv("intermediateOrigins.csv") 
origins['GEOID'] = origins['GEOID'].astype(str).str.zfill(5)

#LOAD DESTINATIONS DATA
#zipcodes for merging
zipCodes = gpd.read_file('contiguousUSZCTAs.gpkg')
zipCodes = zipCodes.rename(columns = {'GEOID10' : 'GEOID'})
zipCodes.head()
#geocoded MOUD data
def cat(keys):
    if mm_key in keys:
        return 'Methadone'
    return False
dests = gpd.read_file('../{0}/{0}_g.csv'.format(year))
dests['category'] = dests.Keys.apply(cat)
dests = dests[dests['category'] != False]
dests = dests.reset_index(drop=True)
dests = gpd.GeoDataFrame(dests, geometry=gpd.points_from_xy(dests.Longitude, dests.Latitude))
print('Number of {} methadone MOUD:'.format(year), len(dests))
#combine
dests.crs = "EPSG:4326" #unify coordinate systems
zipCodes.geometry = zipCodes.geometry.to_crs(epsg = 4326)
destsOver = gpd.sjoin(dests, zipCodes[['GEOID', 'geometry']], how='inner', op='intersects')#spatial join to include GEOID
destsOver = destsOver.reset_index(drop=True) 
destsOver['ID'] = destsOver.index + 1 #Format destsOver
destsOver = destsOver.drop(columns=['index_right'])
destsOver['GEOID'] = destsOver['GEOID'].astype(str)
base = zipCodes.plot(figsize=(20,10)) #plot
destsOver.plot(ax=base, color='yellow', markersize = 1, figsize=(10,10))
plt.savefig('data{}/point_plot.png'.format(year), dpi = 300)

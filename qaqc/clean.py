import pandas as pd
from glob import glob
import csv

def readTxt(file):
    a_file = open(file)
    file_contents = a_file.read()
    return file_contents.splitlines(True)

def checkIndexValues(dataSlice):
    """
        Checks if a slice of a pandas data series is simply the row numbers, exported previously
        as an index column.
        
        Parameters
        ----------
        dataSlice: pandas data series
            A slice of data or list
            
        Returns
        --------
        boolean
            True if data values are indices based on row number
            False if data values are not indices based on row number
    """
    for idx, val in enumerate(dataSlice):
        if val != idx+1:
            return False
    return True

expectedLengths = {
    'C':5,
    'Z':5,
    'T':11,
    'S':2
}

joinCols = {
    'C':'COUNTYFP',
    'Z':'ZCTA',
    'T':'GEOID',
    'S':'STATEFP',
}

expectedColumnLengths = [
    {
        "name":'COUNTYFP',
        "length":5
    },
    {
        "name":'STATEFP',
        "length":2
    },
    {
        "name":'ZCTA',
        "length":5
    },
    {
        "name":'GEOID',
        "length":11
    },
    {
        "name":'TRACTCE',
        "length":6
    }
]


def pad(x, length):
    try:
        if len(f"{x}") == length:
            return x
        
        if len(f"{x}") < length:
            return pad(f"0{x}", length)
    # In case x does not have a length
    except:
        return x
    return x

if __name__ == '__main__':
    ignore_files = readTxt('./qaqc/.ignore')
    round_ignore_files = readTxt('./qaqc/.roundignore')
    files = glob('data_final/*.csv')
    # Start by looping through each file
    for file in files:
        if file.split('/')[-1] in ignore_files:
            continue
        
        print(f"Processing {file}")
        # Read the file
        # Use those types and read in to pandas
        raw = pd.read_csv(file, dtype={
            'COUNTYFP':'str',
            'STATEFP':'str',
            'ZCTA':'str',
            'GEOID':'str',
            'TRACTCE':'str'
        })
        
        # Find the join column based on the last character before the file extension
        try:
            joinCol = joinCols[file.split('.csv')[0][-1]]
            joinChar = file.split('.csv')[0][-1]
        # Others have it in the middle - (ツ)_/¯
        except:
            joinCol = joinCols[file.split('_')[2]]
            joinChar = file.split('_')[2]
        
        # IF the join column is not as expected, something is wrong. Some have a vestigial GISJOIN column
        # Otherwise, flag this to check out after the back
        if joinCol not in list(raw.columns):
            print(f'Warning - {file} does not have the proper join column')
            continue
                
        for column in raw.columns:
            # Markers of an unnamed index column to be removed
            if (column == 'Unnamed: 0' or column == 'X') and checkIndexValues(raw[column][0:10]):
                raw = raw.drop(columns=[column])

        # This section is meant to appropriately pad with leading zeroes
        for col in expectedColumnLengths:
            if col['name'] in list(raw.columns):
                raw.loc[:, col['name']] = raw.loc[:, col['name']].apply(lambda x: pad(x, col['length']))
        
        for col in joinCols.values():
            if col != joinCol and col in raw.columns:
                raw = raw.drop(columns=[col])

        # replace -999 values
        raw = raw.replace(-999, '')

        # round to 2 decimal places

        if file.split('/')[-1] not in round_ignore_files:
            raw = raw.round(2)

        raw.round(2).to_csv(file, index=False)
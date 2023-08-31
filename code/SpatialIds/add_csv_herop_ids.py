import csv
from pathlib import Path

## This is one-off script used to add a new HEROP_ID to all of the CSVs
## The HEROP_ID is a similar to GEOIDs that can come from data.census.gov,
## as described here: https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html
## but is simplified to three parts:
## 3-digit summary level code, the letters "US", and the relevant GEOID.
## For example, the summary level code for State is 040, and the GEOID for states
## are FP codes, so 040US48 would be the HEROP_ID for Texas.

## Note that in the future, the source and destination paths in the script may
## no longer exist, so it functions more as a record of transformation than as a
## reusable snippet.

sl_lookup = {
    "S": {
        "code": "040",
        "id_length": 2,
    },
    "C": {
        "code": "050",
        "id_length": 5,
    },
    "T": {
        "code": "140",
        "id_length": 11,
    },
    "Z": {
        "code": "860",
        "id_length": 5,
    },
}

f_lookup = {
    "C_1980.csv": "GEOID",
    "C_1990.csv": "GEOID",
    "C_2000.csv": "GEOID",
    "C_2010.csv": "GEOID",
    "C_Latest.csv": "GEOID",
    "S_1980.csv": "STATEFP",
    "S_1990.csv": "STATEFP",
    "S_2000.csv": "STATEFP",
    "S_2010.csv": "GEOID",
    "S_Latest.csv": "GEOID",
    "T_1980.csv": "GEOID",
    "T_1990.csv": "GEOID",
    "T_2000.csv": "GEOID",
    "T_2010.csv": "GEOID",
    "T_Latest.csv": "GEOID",
    "Z_1980.csv": "ZCTA",
    "Z_1990.csv": "ZCTA",
    "Z_2000.csv": "ZCTA",
    "Z_2010.csv": "GEOID",
    "Z_Latest.csv": "GEOID",
}

drop_fields = ["STATEFP", "G_STATEFP", "STUSPS", "TRACTCE", "ZIP", "COUNTYFP", "ZCTA", "GEOID"]

new_suffix = "bq"

csv_dir = Path(__file__).resolve().parent.parent.parent / 'data_final' / 'v2.0' / 'tables'
paths = [i for i in csv_dir.glob("*.csv") if not str(i).endswith(f"{new_suffix}.csv")]

for path in paths:

    print(path.name)
    out_path = str(path).replace(".csv", f"_{new_suffix}.csv")
    print(out_path)
    geo = path.name[0]

    rows = []
    new_geoid_field = 'HEROP_ID'
    with open(path, "r") as r:
        reader = csv.DictReader(r)
        fieldnames = [new_geoid_field] + [i for i in reader.fieldnames]

        for r in reader:
            str_geoid = str(r[f_lookup[path.name]]).zfill(sl_lookup[geo]['id_length'])
            new_geoid = f"{sl_lookup[geo]['code']}US{str_geoid}"
            r[new_geoid_field] = new_geoid
            rows.append(r)

    with open(out_path, "w") as w:
        writer = csv.DictWriter(w, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    Path(out_path).replace(path)
import fiona
from fiona import Feature, Properties
from pathlib import Path

## This is one-off script used to add a new HEROP_ID to all of the shapefiles,
## while also moving them to a new final location.
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

# relative paths from the data_final/geometryFiles directory, field names with GEOID base
f_lookup = {
    "state/states2018.shp": "STATEFP",
    "county/counties2018.shp": "GEOID",
    "tract/tracts2018.shp": "GEOID",
    "zcta/zctas2018.shp": "GEOID10",
    "state/states2010.shp": "STATEFP",
    "county/counties2010.shp": "GEOID",
    "tract/tracts2010.shp": "GEOID",
}

new_suffix = "bq"

in_dir = Path(__file__).resolve().parent.parent.parent / 'data_final' / 'geometryFiles'
out_dir = Path(__file__).resolve().parent.parent.parent / '.temp'
out_dir.mkdir(exist_ok=True)

for path in f_lookup.keys():

    shp_path = Path(in_dir, path)
    print("\n"+shp_path.name)

    if "state" in path:
        sl = sl_lookup["S"]
    elif "counties" in path:
        sl = sl_lookup["C"]
    elif "tract" in path:
        sl = sl_lookup["T"]
    elif "zcta" in path:
        sl = sl_lookup["Z"]
    else:
        raise Exception("unexpected input shapefile")

    out_path = out_dir / Path(path).name
    with fiona.open(shp_path) as src:
        dst_schema = src.schema
        dst_schema['properties']['HEROP_ID'] = 'str'

        with fiona.open(
            out_path,
            mode="w",
            crs=src.crs,
            driver="ESRI Shapefile",
            schema=dst_schema,
        ) as dst:
            for feat in src:
                geo_id = str(feat.properties[f_lookup[path]]).zfill(sl['id_length'])
                herop_id =  f"{sl['code']}US{geo_id}"
                if "HEROP_ID" in feat.properties:
                    feat.properties['HEROP_ID'] = herop_id
                    props = feat.properties
                else:
                    props = Properties.from_dict(
                        **feat.properties,
                        HEROP_ID=herop_id,
                    )
                dst.write(Feature(geometry=feat.geometry, properties=props))

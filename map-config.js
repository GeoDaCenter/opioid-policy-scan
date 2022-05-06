import variables from './config/variables.json';

const data = [
  {
    name: 'US States', // Plain english name for dataset
    geodata: 'states.geojson', // geospatial data to join to
    id: 'GEOID', // fid / geoid join column
    bounds: [-125.109215,-66.925621,25.043926,49.295128],
    tables: {
      PS09_data: {
        file: 'PS09_2017_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      PS11_data: {
        file: 'PS11_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      PS08_data: {
        file: 'PS08_2019_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },   
      PS03_data: {
        file: 'PS03_2017_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      PS04_data: {
        file: 'PS04_2018_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      PS05_data: {
        file: 'PS05_2017_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      PS06_data: {
        file: 'PS06_2019_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      PS07_data: {
        file: 'PS07_2018_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      Health01_data: {
        file: 'Health01_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      Health02_1_data: {
        file: 'Health02_S_Prevalence.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
     Health02_2_data: {
        file: 'Health02_S_Mortality.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },  
      Health03_data: {
        file: 'Health03_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Health04_data: {
        file: 'Health04_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Access01_CS_data: {
        file: 'Access01_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Access02_CS_data: {
        file: 'Access02_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Access03_CS_data: {
        file: 'Access03_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Access04_CS_data: {
        file: 'Access04_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Access05_CS_data: {
        file: 'Access05_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      Access06_CS_data: {
        file: 'Access06_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      DS01_data: {
        file: 'DS01_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      DS04_data: {
        file: 'DS04_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      DS05_data: {
        file: 'DS05_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      DS06_data: {
        file: 'DS06_S.csv',
        type: 'characteristic',
        join: 'STATEFP',
      },
      EC01: {
        file: 'EC01_2018_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      EC02: {
        file: 'EC02_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      EC03: {
        file: 'EC03_2018_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      EC04: {
        file: 'EC04_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      EC05: {
        file: 'EC05_2019_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      BE01: {
        file: 'BE01_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      BE03: {
        file: 'BE03_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      BE05: {
        file: 'BE05_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
      BE06: {
        file: 'BE06_NDVI_S.csv',
        type:'characteristics',
        join:'STATEFP'
      },
    },
  },
  {
    name: 'US Counties', // Plain english name for dataset
    geodata: 'county.geojson', // geospatial data to join to
    id: 'GEOID', // fid / geoid join column
    bounds: [-125.109215,-66.925621,25.043926,49.295128],
    tables: {
      Health01_data: {
        file: 'Health01_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      Health03_data: {
        file: 'Health03_C.csv',
        type:'characteristic',
        join: 'COUNTYFP',
      },
      Health04_data: {
        file: 'Health04_C.csv',
        type:'characteristic',
        join: 'COUNTYFP',
      },
      Access01_CS_data: {
        file: 'Access01_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      Access02_CS_data: {
        file: 'Access02_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      Access03_CS_data: {
        file: 'Access03_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      Access04_CS_data: {
        file: 'Access04_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      Access05_CS_data: {
        file: 'Access05_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      Access06_CS_data: {
        file: 'Access06_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      DS01_data: {
        file: 'DS01_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      DS03_data: {
        file: 'DS03_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      DS04_data: {
        file: 'DS04_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      DS05_data: {
        file: 'DS05_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      DS06_data: {
        file: 'DS06_C.csv',
        type: 'characteristic',
        join: 'COUNTYFP',
      },
      PS01_data: {
        file: 'PS01_2016_C.csv',
        type:'characteristic',
        join: 'COUNTYFP',
      },
      PS02_data: {
        file: 'PS02_2017_C.csv',
        type:'characteristic',
        join: 'COUNTYFP',
      },
      EC01: {
        file: 'EC01_2018_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      EC02: {
        file: 'EC02_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      EC03: {
        file: 'EC03_2018_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      EC04: {
        file: 'EC04_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      EC05: {
        file: 'EC05_2019_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      BE01: {
        file: 'BE01_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      BE02_C: {
        file: 'BE02_RUCA_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      BE03: {
        file: 'BE03_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      BE04: {
        file: 'BE04_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      BE05: {
        file: 'BE05_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
      BE06: {
        file: 'BE06_NDVI_C.csv',
        type:'characteristics',
        join:'COUNTYFP'
      },
    },
  },
  {
    name: 'US Zip Codes',
    geodata: 'US Zip Codes [tiles]',
    tiles: `csds-hiplab.7quz45z3`,
    id: 'ZCTA',
    bounds: [-125.109215,-66.925621,25.043926,49.295128],
    tables: {
      // Test - MOUD Walk Access
      MOUDWalkAccess_data: {
        file: 'moud_zip_walkAccess.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      // Test - MOUD Bike Access
      MOUDBikeAccess_data: {
        file: 'moud_zip_bikeAccess.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access01_sub_data: {
        file: 'Access01_sub_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      Access01_data: {
        file: 'Access01_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      Access02_data: {
        file: 'Access02_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      Access03_data: {
        file: 'Access03_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      Access04_data: {
      file: 'Access04_Z.csv',
      type: 'characteristic',
      join: 'ZCTA',
      },
      Access05_data: {
      file: 'Access05_Z.csv',
      type: 'characteristic',
      join: 'ZCTA',
      },
      Access06_data: {
        file: 'Access06_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      Access07_data: {
        file: 'Access07_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      DS01_data: {
        file: 'DS01_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      DS04_data: {
        file: 'DS04_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      DS05_data: {
        file: 'DS05_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      DS06_data: {
        file: 'DS06_Z.csv',
        type: 'characteristic',
        join: 'ZCTA',
      },
      EC01: {
        file: 'EC01_2018_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      EC02: {
        file: 'EC02_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      EC03: {
        file: 'EC03_2018_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      EC05: {
        file: 'EC05_2019_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      BE01: {
        file: 'BE01_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      BE02: {
        file: 'BE02_RUCA_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      BE03: {
        file: 'BE03_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
      BE05: {
        file: 'BE05_Z.csv',
        type:'characteristics',
        join:'ZIP'
      },
      BE06: {
        file: 'BE06_NDVI_Z.csv',
        type:'characteristics',
        join:'ZCTA'
      },
    }
  },  
  {
    name: 'US Tracts',
    geodata: 'US Tracts [tiles]',
    tiles: `csds-hiplab.3ezoql1c`,
    id: 'GEOID',
    bounds: [-125.109215,-66.925621,25.043926,49.295128],
    tables: {
      // Test - MOUD Walk Access
      MOUDWalkAccess_data: {
        file: 'moud_tract_walkAccess.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      // Test - MOUD Bike Access
      MOUDBikeAccess_data: {
        file: 'moud_tract_bikeAccess.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      MOUDAccess_data: {
        file: 'Access01_T2.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access01_data: {
        file: 'Access01_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access01_sub2_data: {
        file: 'Access01_T_2.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access01_sub_data: {
        file: 'Access01_sub_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access02_data: {
        file: 'Access02_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      DS01_data: {
        file: 'DS01_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      DS03_data: {
        file: 'DS03_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      DS04_data: {
        file: 'DS04_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      DS05_data: {
        file: 'DS05_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      DS06_data: {
        file: 'DS06_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access03_data: {
        file: 'Access03_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access04_data: {
        file: 'Access04_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access05_data: {
        file: 'Access05_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access06_data: {
        file: 'Access06_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      Access07_data: {
        file: 'Access07_T.csv',
        type: 'characteristic',
        join: 'GEOID',
      },
      EC01: {
        file: 'EC01_2018_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      EC02: {
        file: 'EC02_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      EC03: {
        file: 'EC03_2018_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      EC04: {
        file: 'EC04_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      EC05: {
        file: 'EC05_2019_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      BE01: {
        file: 'BE01_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      BE02: {
        file: 'BE02_RUCA_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      BE03: {
        file: 'BE03_T.csv',
        type:'characteristics',
        join:'GEOID'
      },
      BE06: {
        file: 'BE06_NDVI_T.csv',
        type:'characteristics',
        join:'tract_fips'
      },
    }
  }
];

// const mapModes = {
//   "2D": true,
//   "3D": false,
//   BubbleCartogram: false,
// };

// const variableHeaders = [
//   {
//     name: 'Policy Variables',
//     startsAt: "Medical Marijuana Laws"
//   },
//   {
//     name: 'Health Variables',
//     startsAt: "Drug-Related Death Rate"
//   },
//   {
//     name: 'Demographic Variables',
//     startsAt: "% White Population"
//   },
//   {
//     name: 'Economic Variables',
//     startsAt: "Poverty %"
//   },
//   {
//     name: 'Physical Environment Variables',
//     startsAt: "Urban-Suburban-Rural"
//   },
//   {
//     name: 'COVID-19 Variables',
//     startsAt: "Essential Workers %"
//   }
// ]

let style = {
  variableHeaders: {},
  tooltip: {
    displayOnlyCurrentVariable: true
  }
}

// // 🦺 exports below -- you can safely ignore! 🦺 //
// variableHeaders.forEach(header => {
//   style.variableHeaders[variables.findIndex(f => f.variable === header.startsAt)] = header.name
// })

export const dataPresets = {
  data,
  variables,
  style
};
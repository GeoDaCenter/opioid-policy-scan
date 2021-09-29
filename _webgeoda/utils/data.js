import { CSVLoader } from "@loaders.gl/csv";
import { load } from "@loaders.gl/core";

export const fixedScales = {
  // eg. lisa
};

export const fixedBreakLabels = {
  percentileBreaks: ["Lowest 1%", "10%", "50%", "90%", "Highest 99%"],
  stddev_breaks: [
    "-2 Std Dev",
    "-1 Std Dev",
    "Median",
    "+1 Std Dev",
    "+2 Std Dev",
  ],
  hinge15Breaks: ["Lower Outlier", "25%", "50%", "75%", "Upper Outlier"],
  hinge30Breaks: ["Lower Outlier", "25%", "50%", "75%", "Upper Outlier"],
};

/**
 * Global data function
 * @param {Object | Array} numeratorData Object or array with numerator data for a feature
 * @param {Object | Array} denominatorData Object or array with denominator data for a feature
 * @param {Object} dataParams Webgeoda parameters for data parsing (eg. Numerator, denominator, nProperty, scale)
 * @returns {Number} Parsed value based on given
 */
export const dataFn = (
  numeratorData,
  denominatorData,
  dataParams,
  debug = false
) => {

  if (dataParams.categorical && numeratorData) return numeratorData[dataParams.nProperty||dataParams.nIndex]

  const { nProperty, nIndex, dProperty, dIndex, nType, dType } = dataParams;

  const scale = dataParams.scale || 1;

  const nRange = nIndex <= dataParams.nRange ? nIndex : dataParams.nRange;
  const dRange = dIndex <= dataParams.dRange ? dIndex : dataParams.dRange;

  if (numeratorData === undefined || numeratorData[nProperty] === null || numeratorData[nIndex] === null) {
    return null;
  } else if (
    nProperty !== null &&
    numeratorData[nProperty] === undefined &&
    nIndex !== null &&
    numeratorData[nIndex] === undefined
  ) {
    return null;
  } else if (nType === "time-series" && dType === "time-series") {
    if ((nRange === null) & (dRange === null)) {
      return (numeratorData[nIndex] / denominatorData[dIndex]) * scale;
    } else {
      return (
        ((numeratorData[nIndex] - numeratorData[nIndex - nRange]) /
          nRange /
          ((denominatorData[dIndex] - denominatorData[dIndex - dRange]) /
            dRange)) *
        scale
      );
    }
  } else if (!dProperty && !nRange) {
    // whole count or number -- no range, no normalization
    return nProperty !== undefined
      ? numeratorData[nProperty] * scale
      : nIndex !== undefined
      ? numeratorData[nIndex] * scale
      : null
  } else if (!dProperty && nRange) {
    // range number, daily or weekly count -- no normalization
    return (
      ((numeratorData[nIndex] - numeratorData[nIndex - nRange]) / nRange) *
      scale
    );
  } else if (dProperty && !nRange) {
    // whole count or number normalized -- no range
    return (
      ((numeratorData[nProperty] || numeratorData[nIndex]) /
        (denominatorData[dProperty] || denominatorData[dIndex])) *
      scale
    );
  } else if (dProperty !== null && nRange !== null && dRange === null) {
    // range number, daily or weekly count, normalized to a single value
    return (
      ((numeratorData[nIndex] - numeratorData[nIndex - nRange]) /
        nRange /
        (denominatorData[dProperty] || denominatorData[dIndex])) *
      scale
    );
  } else {
    return 0;
  }
};

export function mapFn(val, bins, colors, maptype, table) {
  if (val === null) {
    return null;
  } else if (maptype === "natural_breaks") {
    if (
      (val === 0 && table.indexOf("testing") === -1) ||
      (val === -100 && table.includes("testing"))
    )
      return colors[0];

    for (let i = 1; i < bins.length; i++) {
      if (val < bins[i]) {
        return colors[i];
      }
    }
    return colors[0];
  } else if (maptype.includes("hinge")) {
    if (val === null) return [0, 0, 0, 0];

    for (let i = 1; i < bins.length; i++) {
      if (val < bins[i]) {
        return colors[i - 1];
      }
    }
    return colors[colors.length - 1];
  }
}

export function mapFnNb(val, bins, colors, maptype, table) {
  if (val === null) return null;
  if (val === 0) return colors[0];
  for (let i = 1; i < bins.length; i++) {
    if (val < bins[i]) {
      return colors[i];
    }
  }
  return colors[colors.length - 1];
}

export function mapFnTesting(val, bins, colors, maptype, table) {
  if (val === null) return null;
  if (val === -1) return colors[0];
  for (let i = 1; i < bins.length; i++) {
    if (val < bins[i]) {
      return colors[i];
    }
  }
  return colors[colors.length - 1];
}

export function mapFnHinge(val, bins, colors, maptype, table) {
  if (val === null) return [0, 0, 0, 0];
  if (val === 0) return colors[0];
  for (let i = 1; i < bins.length; i++) {
    if (val < bins[i]) {
      return colors[i - 1];
    }
  }
  return colors[colors.length - 1];
}

/**
 * Generates a deterministic ID based on data params and dataset
 * @param {String} currentData Name of current geodata
 * @param {Object} dataParams Webgeoda parameters for data parsing (eg. Numerator, denominator, nProperty, scale)
 * @returns {String} Unique deterministic ID
 */
export const getVarId = (currentData, dataParams) => {
  return `${dataParams.variable}-${currentData}-${dataParams.numerator}-${dataParams.nIndex}-${dataParams.nRange}-${dataParams.denominator}-${dataParams.dProperty}-${dataParams.dIndex}-${dataParams.dRange}-${dataParams.scale}`;
};

/**
 * Shallow compare the values of two objects
 * @param {Object} object1 Object 1 to compare
 * @param {Object} object2 Object 2 to compare
 * @returns {Boolean} True if same, false if different
 */
export const shallowEqual = (object1, object2) => {
  // Thanks @Dmitri Pavlutin
  const keys = Object.keys(object1);
  if (keys.length !== keys.length) return false;
  for (let i = 0; i < keys.length; i++) {
    if (object1[keys[i]] !== object2[keys[i]]) {
      if (keys[i] !== "nIndex" && keys[i] !== "dIndex") return false;
    }
  }
  return true;
};

/**
 * Assign an array of geo objects (eg. Features of a GeoJSON) into an indexed object
 * based  on the provided key property
 * @param {Object} data Geojson-like object to be assigned
 * @param {String} key Key inside properties to index rows on
 * @returns {Object} Indexed geodata for faster access
 */
export const indexGeoProps = (data, key) => {
  let geoProperties = {};
  for (var i = 0; i < data.features.length; i++) {
    geoProperties[data.features[i].properties[key]] =
      data.features[i].properties;
  }
  return geoProperties;
};

/**
 * Assign a simple array of objects based on the provided key property
 * @param {Object} data Any array of objects to be assigned
 * @param {String} key Key in each object to index rows on
 * @returns {Object} Indexed data for faster access
 */
export const indexTable = (data, key) => {
  let propsObj = {};
  for (var i = 0; i < data.length; i++) propsObj[data[i][key]] = data[i];
  return propsObj;
};

/**
 * @param  {Object} numeratorData An object, indexed by ID column, with the relevant numerator data.
 * @param  {Object} denominatorData An object, indexed by ID column, with relevant denominator data.
 * @param  {Object} dataParams A WebGeoDa variable spec.
 * @param  {Array} fixedOrder A fixed ID column order for use with LISA. Default is false / not used.
 * @returns {Array} An array of parsed data according to the dataParams variable spec.
*/
export const parseColumnData = ({
  numeratorData,
  denominatorData,
  dataParams,
  fixedOrder = false
}) => {
  const tempDenominatorData = denominatorData === undefined ? {} : denominatorData;
  let { nProperty, nIndex, dType, dIndex, dProperty } = dataParams;
  let tempDataParams = { ...dataParams };

  // declare empty array for return variables
  let rtn = new Array(
    fixedOrder ? fixedOrder.length : Object.keys(numeratorData).length
  );

  // length of data table to loop through
  const keys = fixedOrder || Object.keys(numeratorData);
  const n = keys.length;

  // this checks if the bins generated should be dynamic (generating for each date) or fixed (to the most recent date)
  if (nIndex === null && nProperty === null) {
    // if fixed, get the most recent date
    let tempIndex = numeratorData.length - 1;
    // if the denominator is time series data (eg. deaths / cases this week), make the indices the same (most recent)
    let tempDIndex =
      dType === "time-series" ? tempDenominatorData.length - 1 : dIndex;
    // loop through, do appropriate calculation. add returned value to rtn array
    for (let i = 0; i < n; i++) {
      rtn[keys[i]] =
        dataFn(numeratorData[keys[i]], tempDenominatorData[keys[i]], {
          ...dataParams,
          nIndex: tempIndex,
          dIndex: tempDIndex,
        }) || 0;
    }
  } else {
    for (let i = 0; i < n; i++) {
      rtn[i] =
        dataFn(
          numeratorData[keys[i]],
          tempDenominatorData[keys[i]],
          tempDataParams
        ) || 0;
    }
  }

  for (let i = 0; i < rtn.length; i++) {
    if (rtn[i] < 0) rtn[i] = 0;
  }

  return rtn;
};
/**
 * @param  {Object} table An object, indexed by an ID column, with data to get categorical or unique values from.
 * @param  {Object} dataParams A WebGeoDa variable spec.
 */

export const getUniqueVals = (table, dataParams) => {
  let tempArray = [];
  const keys = Object.keys(table);

  for (let i=0; i<keys.length; i++){
    const currVal = table[keys[i]][dataParams.nProperty||dataParams.nIndex]
    if (currVal !== undefined && tempArray.indexOf(currVal) === -1) tempArray.push(currVal)
  }

  return tempArray
}

/**
 * Finds the first object in an array of objects that matches the given condition
 * @param {Array} collection Any array of objects to be searched
 * @param {Function} testFunc A function to test each object on, eg:
 *
 * let myFishies = [
 *  {
 *    fish:'🐠',
 *    color:'orange'
 *  },
 *  {
 *    fish:'🐟',
 *    color:'blue'
 *  }
 * ]
 *
 * find(myFishies, obj => obj.color === 'orange') // returns {fish:'🐠',color:'orange'}
 *
 * @returns {Object} Indexed data for faster access
 */
export const find = (collection, testFunc) => {
  for (let i = 0; i < collection.length; i++)
    if (testFunc(collection[i])) return collection[i];
};

/**
 * From the tables joined to a given geography, finds the name of the table file for reference
 * in state.storedData.
 * @param  {Array} dataPresets The array of available data presets, usually state.dataPresets
 * @param  {String} currentData The current data table for which you want the table
 * @param  {String} table The name of the table you are looking for
 * @returns {String} Name of the data table file
 */
export const findTable = (
  dataPresets, 
  currentData, 
  table
) => find(
      dataPresets,
      (o) => o.geodata === currentData
  )?.tables[table]?.file;


export const fileLoader = {
  csv: async (fetchUrl) => {
    const parsedData = await load(fetchUrl, CSVLoader);
    return parsedData;
  },
  pbf: async (fetchUrl, schema) => { // todo: PBF loading
    return true;
  },
};
/**
 * Handles tabular data loading based on dataset spec.
 * @param  {Object} info
 * @param  {} dateList
 * @returns {Object} { 
 *  dateIndices (indices of available dates for timeseries data),
 *  columns (names of columns in data)
 *  data (object, keyed to ID column with tabular data)
 * }
 */
export const handleLoadData = async (info, dateList) => {
  const { file, type, join, dates, accumulate, schema } = info;
  const fetchUrl =
    file.slice(0, 4) === "http" ? file : `${window.location.origin}/${file.slice(-3)}/${file}`;
  let data = await fileLoader[file.slice(-3)](fetchUrl, schema);
  let dateIndices = [];
  let columns = Object.keys(data[0]);
  if (dates) {
    if (accumuluate) {
      // todo accumulation logic
    } else {
      // todo non-accumulation date assignment logic
    }
  }

  return {
    dateIndices,
    columns,
    data: indexTable(data, join),
  };
};

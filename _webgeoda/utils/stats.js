
import {mean, standardDeviation, zScore} from 'simple-statistics';

/**
 * @param  {Array} values A list of values to standarize
 */
export const standardize = (values) => {
    const avg = mean(values);
    const stdev = standardDeviation(values);
    let standardizedArray = []
    for (let i=0; i<values.length;i++){
        standardizedArray.push(zScore(values[i], avg, stdev))
    }
    return standardizedArray
};
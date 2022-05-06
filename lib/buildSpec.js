// eslint-ignore
const fs = require('fs')
const path = require('path')
const papa = require('papaparse')
const csvPath = path.join('config', 'variables.csv');
const chokidar = require('chokidar');

const columnMap = {
    "variable name": "variable",
    "theme": "theme",
    "subtheme": "subTheme",
    "data table": "numerator",
    "data column": "nProperty",
    "categorical": "categorical",
    'fixed binning scale': "fixedScale",
    'fixed binning scale labels': "fixedLabels",
    'binning strategy': 'binning',
    'number of bins': "numberOfBins",
    'color scale': 'colorScale',
    'reverse color scale': "reverse"
}

const buildSpec = () => {
    fs.readFile(csvPath, 'utf8', (err, data) => {
        const obj = papa.parse(data, { header: true, dynamicTyping: true } ).data.sort((a, b) => a.variable.localeCompare(b.variable))
        const output = obj.map(row => Object.assign({}, ...Object.keys(row).map(key => row[key] ? ({ [columnMap[key]]: row[key] }) : {})))
        fs.writeFile(path.join('config', 'variables.json'), JSON.stringify(output), (err) => {
            if (err) throw err;
            console.log('The file has been saved!');
        })
    })
}

buildSpec()
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

const cleanValue = (value) => {
    if (!value || typeof value !== 'string') return value
    if (!value.includes(",")) {
        return value
    }
    try {
        return JSON.parse(value)
    } catch {}

    try {
        return value.slice(1,-1).split(",")
    } catch {}

    return null
}

const buildSpec = () => {
    fs.readFile(csvPath, 'utf8', (err, data) => {
        const obj = papa.parse(data, { header: true, dynamicTyping: true } ).data.sort((a, b) => (a["variable name"] && b["variable name"] && a["theme"] && b["theme"]) ? a["variable name"].localeCompare(b["variable name"]) && a["theme"].localeCompare(b["theme"]) : 0)
        const output = obj
            .map(row => Object.assign({}, ...Object.keys(row).map(key => row[key] ? ({ [columnMap[key]]: cleanValue(row[key]) }) : {})))
        fs.writeFile(path.join('config', 'variables.json'), JSON.stringify(output), (err) => {
            if (err) throw err;
            console.log('💽 SPEC UPDATED 💽');
        })
    })
}

buildSpec()

chokidar.watch('./config/variables.csv').on('all', () => {
    buildSpec()
});
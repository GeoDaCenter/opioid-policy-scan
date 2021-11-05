const Papa = require('papaparse')

const dataConversion = {
    county: "C",
    zip: "Z",
    state: "S",
    tract: "T",
}

const idCol = {
    "C": "COUNTYFP",
    "S": "STATEFP",
    "T":"GEOID",
    "Z":"ZCTA"
}

const filterData = (data, agg, idList, stateList) => idList
    ? data.filter(row => idList.includes(row[idCol[agg]]))
    : data

const formatData = (data, format) => format === 'csv'
    ? Papa.unparse(data)
    : data


// spec oeps.ssd.uchicago.edu/api/data/{aggregation}/{dataset}?id={id}&state={state}&format={format<csv|json>}
// ALT endpoints: oeps.ssd.uchicago.edu/api/docs
// ALT endpoints: oeps.ssd.uchicago.edu/api/geometry
// ALT endpoints: oeps.ssd.uchciago.edu/api/variables

export default async function handler(req, res) {
    const baseUrl = `http://${req.rawHeaders.slice(-1)[0]}`
    const { id, state, param, format='json' } = req.query;
    const idList = id ? id.split(',') : false;
    const stateList = state ? state.split(',') : false;
    
    const agg = dataConversion[param[1]]
    const dataset = `${param[0]}_${agg}.csv`

    const data = await fetch(`${baseUrl}/csv/${dataset}`)
        .then(r => r.text())
        .then(data => Papa.parse(data, { header: true }))
        .then(table => table.data)

    const result = id
        ? data.filter(row => idList.includes(row[idCol[agg]]))
        : data
    
    const formattedData = format === 'csv'
        ? Papa.unparse(result)
        : result

    if (result.length) {
        res.status(200).json(formattedData)
    } else {
        res.status(500).json({ error: 'No data found' })
    }
}
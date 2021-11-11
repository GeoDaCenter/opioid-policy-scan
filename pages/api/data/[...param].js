import * as Papa from 'papaparse';
import stateInfo from '../../../meta/stateInfo'
import zipRange from '../../../meta/zipRange'
import Cors from 'cors'
import initMiddleware from '../../../lib/init-middleware'

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

// Initialize the cors middleware
const cors = initMiddleware(
    // You can read more about the available options here: https://github.com/expressjs/cors#configuration-options
    Cors({
      // Only allow requests with GET, POST and OPTIONS
      methods: ['GET', 'POST', 'OPTIONS'],
    })
)

const getStateFilterFn = (agg, stateList, stateIdList) => {
    const zipMinMax = zipRange.filter(z => stateList.includes(z.STUSPS))
    switch (agg) {
        case 'C':
            return (f) => stateIdList.includes(Math.floor(f[idCol[agg]]/1000))
        case 'S':
            return (f) => stateIdList.includes(+f[idCol[agg]])
        case 'T':
            return (f) => stateIdList.includes(Math.floor(f[idCol[agg]]/1000000000))
        case 'Z':
            return (f) => zipMinMax.some(({MIN, MAX}) => f[idCol[agg]] >= MIN && f[idCol[agg]] <= MAX);
        default:
            return () => true
    }
}

export default async function handler(req, res) {
    // Run cors
    await cors(req, res)
    const { id, param, state, format='json' } = req.query;
    // if (!keys.includes(key)) {
    //     res.status(401).send('Unauthorized')
    //     return
    // }
    const baseUrl = req.rawHeaders.includes('localhost')
        ? `http://${req.rawHeaders.slice(-1)[0]}`
        : `https://oeps.ssd.uchicago.edu`
        
    if (param[0] === 'index.html') res.status(500).json({ error: 'Please add a dataset to your query.' })
    if (!param[1]) res.status(500).json({ error: 'Please add a spatial scale to your query.' })
    
    const agg = dataConversion[param[1]]

    const dataset = `${param[0]}_${agg}.csv`

    const idList = id 
        ? id.split(',') 
        : false;

    const stateList = state 
        ? state.split(',')
        : false;

    const stateIdList = state 
        ? state.split(',').map(state => +stateInfo.find(stateInfo => stateInfo.STUSAB === state).STATE)
        : false;

    const stateFilter = !state 
        ? () => true
        : getStateFilterFn(agg, stateList, stateIdList)

    const data = await fetch(`${baseUrl}/csv/${dataset}`)
        .then(r => r.text())
        .then(data => Papa.parse(data, { header: true }))
        .then(table => table.data)
    
    const result = !!idList || !!stateList
        ? data.filter(row => 
            ((idList ? idList.includes(row[idCol[agg]]) : true)
            && 
            (stateList ? stateFilter(row) : true))
        )
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
import Cors from 'cors'
import initMiddleware from '../../../lib/middleware'
// import keys from '../keys';
import docs from '../../../meta/docCrosswalk.js';
const keys = ''
const cors = initMiddleware(Cors({methods: ['GET', 'POST', 'OPTIONS'],}))
function onlyUnique(value, index, self) {return self.indexOf(value) === index;}
  
const baseUrl = 'https://raw.githubusercontent.com/GeoDaCenter/opioid-policy-scan/master/data_final/metadata/'

const fetchMd = async (url) => {
    try {
        return fetch(url).then(r => r.text())
    } catch {
        return 'Could not find documentation.'
    }
}

export default async function handler(req, res) {
    await cors(req, res) // Run cors
    const { key, dataset } = req.query;
    
    if (!key) {
        res.status(400).send('Please include an api key in your query as "?key=abc123". If you need an API key, please register at {url coming soon...}')
        return;
    }
    if (!keys.includes(key)) {
        res.status(401).send('Unauthorized API Key. Please contact the UChicago HEROP lab if you are receiving this message in error. If you need an API key, please register at {url coming soon...}')
        return;
    }
        
    if (dataset === 'index.html') res.status(500).json({ error: 'Please add a dataset to your query.' })

    const mdToFetch = docs.filter(d => d.dataset === dataset).map(f => f.markdown).filter(onlyUnique)
    
    if (mdToFetch.length === 0) {
        res.status(500).json({ error: 'Could not find documentation.' })
        return;
    }

    const urlsToFetch = mdToFetch.map(f => `${baseUrl}${f}.md`)
    const mdFiles = await Promise.all(urlsToFetch.map(md => fetchMd(md)))      
    const mdText = mdFiles.map((md, idx) => `## ${mdToFetch[idx]}: \n\n ${md}`).join('\n\n')
    
    res.status(200).send(mdText)
}
import Cors from 'cors'
import initMiddleware from '../../lib/middleware';
// import keys from './keys';
const keys = ''
const cors = initMiddleware(Cors({methods: ['GET', 'POST', 'OPTIONS'],}))
function onlyUnique(value, index, self) {return self.indexOf(value) === index;}

export default async (req, res) => {
    await cors(req, res) // Run cors
    const { key } = req.query;
    
    if (!key) {
        res.status(400).send('Please include an api key in your query as "?key=abc123". If you need an API key, please register at {url coming soon...}')
        return;
    }
    if (!keys.includes(key)) {
        res.status(401).send('Unauthorized API Key. Please contact the UChicago HEROP lab if you are receiving this message in error. If you need an API key, please register at {url coming soon...}')
        return;
    }

    try {
        const response = await fetch("https://api.github.com/repos/GeoDaCenter/opioid-policy-scan/git/trees/master?recursive=1")
            .then(r=>r.json())
        const datasets = response.tree.filter(f => (f.path.includes("data_final/") && f.path.includes(".csv")))
            .map(dataset => dataset.path.split('/').slice(-1)[0].split('_')[0])
            .filter(onlyUnique)
        res.status(200).json({ datasets })      
    } catch (error){
        res.status(400).json({ error })
    }
}
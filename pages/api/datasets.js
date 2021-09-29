// Next.js API route support: https://nextjs.org/docs/api-routes/introduction

// export default (req, res) => {
//     console.log(`http://localhost:3000/api/geojson/tx.geojson`)
//     res.status(200).json({ test: 'test' });
// };
  
import axios from "axios"

export default async (req, res) => {
  const url = `https://webgeoda.vercel.app/geojson/tx.geojson`
    await axios
        .get(url)
        .then(({ data }) => {
            res.status(200).json({ data: data.features[0] })
        })
        .catch(({ err }) => {
            res.status(400).json({ err })
        })
}
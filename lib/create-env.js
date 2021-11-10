const fs = require('fs')
fs.writeFileSync('./lib/env.js', `export const keys = ${process.env.api_keys.split(',')}`)
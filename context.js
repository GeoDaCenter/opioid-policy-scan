const fs = require('fs');
console.log(__dirname)
fs.writeFileSync(
  'public/context.json',
  JSON.stringify({ context: process.env })
);
const fs = require('fs');

fs.writeFileSync(
  'public/context.json',
  JSON.stringify({ context: process.env })
);
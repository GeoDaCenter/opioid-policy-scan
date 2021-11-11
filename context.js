const fs = require('fs');

fs.writeFileSync(
  'pages/api/data/keys.js',
  `export default "${process.env.api_keys}"`
);
const fs = require('fs');

fs.writeFileSync(
  'pages/api/keys.js',
  `export default "${process.env.api_keys}"`
);
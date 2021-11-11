const util = require('util')
const zlib = require('zlib')
const gzip = util.promisify(zlib.gzip)

export default async function gzipResponse(responseEncoded, csv=false) {
  return {
    statusCode: 200,
    headers: {
      'Content-Type': csv ? 'text/csv' : 'application/json',
      'Content-Encoding': 'gzip'
    },
    body: (await gzip(responseEncoded)).toString('base64'),
    isBase64Encoded: true,
  }
}
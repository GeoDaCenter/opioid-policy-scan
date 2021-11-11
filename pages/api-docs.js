import Head from "next/head";
import styles from "../styles/About.module.css";
import { Gutter } from "../components/layout/Gutter";
import MainNav from "../components/layout/MainNav";
import Footer from "../components/layout/Footer";

export default function About() {
  return (
    <div className={styles.container}>
      <Head>
        <title>API Docs :: OEPS </title>
        <meta name="description" content="Documentation for the OEPS API" />
        <link rel="icon" href="/favicon.ico" />
        <link
          rel="preconnect"
          href="https://fonts.gstatic.com"
          crossOrigin="true"
        />
        <link
          rel="preload"
          as="style"
          href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,900;1,400;1,700&family=Lora:ital@0;1&display=swap"
        />
        <link
          rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,900;1,400;1,700&family=Lora:ital@0;1&display=swap"
          media="print"
          onLoad="this.media='all'"
        />
        <noscript>
          <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,900;1,400;1,700&family=Lora:ital@0;1&display=swap"
          />
        </noscript>
      </Head>
      <MainNav />
      <main className={styles.main}>
        <h1 className={styles.title}>OEPS API Documentation</h1>
        <Gutter em={3} />
        <div className="row">
          <div className="col-xs-12 col-md-4 col-lg-3">
            <h2>Purpose</h2>
          </div>
          <div className="col-xs-12 col-md-8 col-lg-9">
            <p>
              The OEPS API is a RESTful API that allows users to access the available datasets freely with a few 
              filtering functions for utility. The API is designed to be used by data scientists and developers to
              query data for local use, and we recommend re-deploying data with your application, rather than querying
              the API directly. 
            </p>
            <p>
              For a general introduction to RESTful APIs, please see <a href="https://towardsdatascience.com/introduction-to-rest-apis-90b5d9676004" target="_blank" rel="noopener noreferrer">Towards Data Science's Intro Article</a>.
            </p>
          </div>
        </div>
        <Gutter em={1} />
        <div className="row">
          <div className="col-xs-12 col-md-4 col-lg-3">
            <h2>Endpoints</h2>
          </div>

          <div className="col-xs-12 col-md-8 col-lg-9">
            <p>
              Three main data endpoints are available:
              <ul>
                <li><code>data</code>: full datasets by theme provided as JSON or CSV</li>
                <li><code>docs</code>: markdown documentation for each dataset</li>
                <li><code>datasets</code>: a list of all datasets available</li>
              </ul>
              All endpoints require a <code>key</code> parameter to access the data. You can request a key via a form coming soon. 
              Examples of valid queries are included in the parameter section below.
            </p>
          </div>
        </div>
        <Gutter em={1} />
        <div className="row">
          <div className="col-xs-12 col-md-4 col-lg-3">
            <h2>Parameters</h2>
          </div>
          <div className="col-xs-12 col-md-8 col-lg-9">
            <p>
              Each data endpoint (except for <code>datasets</code>) has a number of routing and url parameters to help us provided
              the dataset you request and any filtering needed, such as state or geography ID filtering. Below are the available routing and url parameters 
              for the current endpoints:
            </p>
            <h3><code>data</code></h3>
            <p>
              The <code>data</code> endpoint is the main endpoint for accessing datasets. It accepts the following parameters:
              <br/><br/>
              <code>https://oeps.ssd.uchicago.edu/api/data/<b>dataset</b>/<b>spatial scale</b></code>
              <br/><br/>
              Here, dataset should be one of the available tabular datasets, such as <code>Access01</code> or <code>BE02</code> for access metrics, and 
              built environment stats, respectively. Spatial scale represents the geographic unit you want to request, and currently we have available county, state, zip, and tract
              level datasets. Please note - not every spatial scale is available for every dataset.
              <br/><br/>
              Each parameter should be included in the URL without any quotation marks or other special characters.
              <br/><br/>
              Additionally, the following url parameters are available. The first url parameter should use a question mark (<code>...data/BE01/county?key=abc123)</code>
              and all subsequent parameters should use an ampersand (<code>...data/BE01/county?key=abc123&amp;state=AL</code>).
              <ul>
                <li><code>key</code>: a valid API key (<b>required</b>)</li>
                <li><code>state</code>: a two letter state abbreviation such as IL, CA, or TX. Note that some datasets are not avaiable for all states (<i>optional</i>)</li>
                <li>
                  <code>id</code>: a FIPS code or GEOID for the spatial scale you are requesting. For zip codes, something like 60626 or 10001 would be valid. 
                  For states, 17, 37, or 45. You can use multiple comma-separated IDs to retrieve multiple relevant entries. This supercedes the state filter, if using. 
                  See the <a href="https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html" target="_blank" rel="noopener noreferrer">US Census GEOID Structure</a> explanation 
                  for more information (<i>optional</i>)</li>
                <li><code>format</code>: a choice of CSV (comma separated values) or JSON (javascript object notation) for your data return. 
                By default, JSON will be returned as an array of objects (<i>optional</i>)</li>
              </ul>
              Here are some example queries:
              <ul>
                <li>
                  Zip code level access metrics for mental health services in Illinois:
                  <br/>
                  <code>https://oeps.ssd.uchicago.edu/api/data/Access04/zip?key=abc123&amp;state=IL</code>
                  <br/>
                  <br/>
                </li>
                <li>
                  State level race and ethnicity data for Virginia, North Carolina, and South Carolina:
                  <br/>
                  <code>https://oeps.ssd.uchicago.edu/api/data/DS01/state?key=abc123&amp;id=51,37,45</code>
                  <br/>
                  <br/>
                </li>
                <li>
                  A CSV of workers employed in different job industries by county:
                  <br/>
                  <code>https://oeps.ssd.uchicago.edu/api/data/EC02/county?key=abc123&amp;format=csv</code>
                  <br/>
                  <br/>
                </li>
              </ul>
            </p>
            <h3><code>docs</code></h3>
            <p>
              The <code>docs</code> endpoint returns information on the datasets as markdown with the following parameters:
              <br/><br/>
              <code>https://oeps.ssd.uchicago.edu/api/data/<b>dataset</b></code>
              <br/><br/>
              Here, dataset should be one of the available tabular datasets, such as <code>Access01</code> or <code>BE02</code> for access metrics, and 
              built environment stats, respectively. 
              <br/><br/>
              Additionally, a key parameters must be included in the URL (<code>...docs/BE01?key=abc123</code>).
              Here are some example queries:
              <ul>
                <li>
                  Docs for dataset Access01:
                  <br/>
                  <code>https://oeps.ssd.uchicago.edu/api/docs/Access01?key=abc123</code>
                  <br/>
                  <br/>
                </li>
                <li>
                  Docs for dataset DS01:
                  <br/>
                  <code>https://oeps.ssd.uchicago.edu/api/docs/DS01?key=abc123</code>
                  <br/>
                  <br/>
                </li>
              </ul>
            </p>
            <h3><code>datasets</code></h3>
            <p>
              The <code>datasets</code> endpoint returns currently available dataset names. There are no parameters for this endpoint, but you 
              must provide an API key.
              <br/><br/>
              <code>https://oeps.ssd.uchicago.edu/api/datasets</code>
              <br/><br/>
              Here is an example queries:
              <ul>
                <li>
                  Available datasets:
                  <br/>
                  <code>https://oeps.ssd.uchicago.edu/api/datasets?key=abc123</code>
                </li>
              </ul>
            </p>
          </div>
          
        </div>
        <Gutter em={3} />
        <div className="row">
          <div className="col-xs-12 col-md-4 col-lg-3">
            <h2>Getting an API Key</h2>
          </div>
          <div className="col-xs-12 col-md-8 col-lg-9">
            <p>
              API keys are available upon request for interested developers and researchers. To request access, fill out this form [coming soon].
            </p>
            <p>If you'd prefer to not use an API key, you can use 
              the <a href="/download" target="blank" rel="noopener noreferrer">data downloader page</a> or access 
              the <a href="https://github.com/GeoDaCenter/opioid-policy-scan" target="blank" rel="noopener noreferrer">repository directly</a>.
            </p>
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

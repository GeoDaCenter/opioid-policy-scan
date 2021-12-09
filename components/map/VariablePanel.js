import { useDispatch, useSelector } from "react-redux";
import { useState, useEffect, useMemo } from 'react';
import styles from "./VariablePanel.module.css";
import { variables } from '../../meta/variables';

import {
  Listbox,
  ListboxOption
} from "@reach/listbox";
import "@reach/listbox/styles.css";

import {
  Gutter
} from "../layout/Gutter";
import RemoteMarkdownModal from "@components/markdown/RemoteMarkdownModal";

const themeCategories = [
  "Policy Variables",
  "Health Variables",
  "Demographic Variables",
  "Economic Variables",
  "Built Environment Variables",
  "COVID-19 Variables"
]

const filterVars = (list, themes, currTheme) => {
  const keys = Object.values(themes)
  const indices = Object.keys(themes)
  const startIndex = +indices[keys.indexOf(currTheme)]
  if (keys.indexOf(currTheme) === keys.length -1) {
    return list.slice(startIndex,)
  } else {
    try {
      const endIndex = +indices[keys.indexOf(currTheme)+1]
      return list.slice(startIndex, endIndex)
    } catch {
      return list.slice(startIndex,)
    }
  }
}

export default function VariablePanel(props) {
  const dataParams = useSelector((state => state.dataParams));
  const currentData = useSelector((state) => state.currentData);
  const dataPresets = useSelector((state) => state.dataPresets);
  const [activeDocs, setActiveDocs] = useState('')
  const [activeTheme, setActiveTheme] = useState(Object.keys(variables)[1])
  const filteredVars = useMemo(() => filterVars(dataPresets.variables, dataPresets.style.variableHeaders, activeTheme),[activeTheme])
  const dispatch = useDispatch();

  useEffect(() => {
    const vars = filterVars(dataPresets.variables, dataPresets.style.variableHeaders, activeTheme)
    dispatch({ type: "CHANGE_VARIABLE", payload: vars[0].variable })
  },[activeTheme])

  useMemo(() => {
    alert('The current variable is: '+dataParams.variable)
  }, [dataParams.variable])

  return (
    <>
      <div
        className={
          styles.panelContainer + " " + (props.open 
            ? styles.open 
            : styles.hidden)
        }
      >
        <p>Theme Select</p>
        <Listbox
          value={activeTheme}
          onChange={(value) => setActiveTheme(value)}
          id="themeSelect"
        >
          {themeCategories.map(entry => 
            <ListboxOption value={entry} key={`theme-${entry}`}>
              {entry}
            </ListboxOption>)
          }
        </Listbox>
        <Gutter em={1}/>
        <p>Variable Select</p>
        <Listbox
          value={dataParams.variable}
          onChange={(value) =>
            dispatch({ type: "CHANGE_VARIABLE", payload: value })
          }
          id="variableSelect"
        >
          {filteredVars.map((entry, i) => 
            <ListboxOption value={entry.variable} key={`variable-list-${i}`}>
              {entry.variable}
            </ListboxOption>
          )}
        </Listbox>

        {dataPresets.data.length > 1 &&
        <> 
          <Gutter em={1}/>
          <p>Geography Select</p>
          {dataPresets.data.map(entry => 
            <button onClick={() => dispatch({ type: "CHANGE_DATASET", payload: entry.geodata})} 
              key={`geography-list-${entry.geodata}`} 
              disabled={
                !((dataParams.numerator in entry.tables)||dataParams.numerator==="properties")||currentData===entry.geodata
              }
              className={`${styles.pillButton} ${currentData===entry.geodata&&styles.activeButton}`}
            >
              {entry.name}
            </button>
          )}
        </>}
        <Gutter em={1} />
        {dataParams.numerator ? <button 
          className={styles.readMoreButton}
          onClick={() => setActiveDocs(`https://raw.githubusercontent.com/GeoDaCenter/opioid-policy-scan/master/data_final/metadata/${variables[activeTheme].find(f => f.markdownPrefix.includes(dataParams.numerator.split('_')[0])).markdown}.md`)}
          >
          Read more about this data 
          <br/>
          Dataset: <code>{dataParams.numerator.split('_')[0]}</code><br/>
          Column: <code>{dataParams.nProperty}</code>
        </button> : null}
        {dataParams.denominator ? <button 
          className={styles.readMoreButton}
          onClick={() => setActiveDocs(`https://raw.githubusercontent.com/GeoDaCenter/opioid-policy-scan/master/data_final/metadata/${variables[activeTheme].find(f => f.markdownPrefix.includes(dataParams.numerator.split('_')[0])).markdown}.md`)}
          >
          Read more about this data 
          <br/>
          Dataset: <code>{dataParams.denominator.split('_')[0]}</code><br/>
          Column: <code>{dataParams.dProperty}</code>
        </button> : null}
      </div>
      {activeDocs.length ? <RemoteMarkdownModal url={activeDocs} reset={() => setActiveDocs(false)}/> : null}
    </>
  );
}

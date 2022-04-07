import { useState, useEffect } from 'react';
import styles from "./MainMap.module.css";
import { useSelector } from "react-redux";
import { handleLoadData } from '@webgeoda/utils/data'

const pad = (val, len, padChar) => `${val}`.length >= len ? ''+val : pad(`${padChar}${val}`, len, padChar)

const findTractStateAndCounty = ({countyDict, id}) => {
  const idVal = pad(id, 11, 0)
  const county = countyDict[+idVal.slice(0,5)]
  return county?.Name + ' County, ' + county?.State
}

const TooltipTitle = ({currentData, stateDict, countyDict, id}) => {
  if (!currentData) return null
  const text = currentData.includes('state')
    ? stateDict[id]?.State
    : currentData.includes('count')
    ? countyDict[id]?.Name + ', ' + countyDict[id]?.State
    : currentData.includes('Zip')
    ? 'Zip Code: ' + pad(id, 5, 0)
    : findTractStateAndCounty({countyDict, id})
    
  if (text === undefined || (typeof text === 'string' && text.includes('undefined'))) return null
  return <span>
    <h2 className="tooltip-header">{text}</h2>
    {currentData.includes('Tract') && <h4>Tract# {pad(id, 11, 0)}</h4>}
    </span>
}

export default function MapTooltip() {
  const [stateDict, setStateDict] = useState({});
  const [countyDict, setCountyDict] = useState({});
  const currentHoverTarget = useSelector((state) => state.currentHoverTarget);
  const currentData = useSelector((state) => state.currentData);

  useEffect(() => {
    Promise.all([
      handleLoadData({
        file:'counties.csv',
        join:'FIPS'
      }),
      handleLoadData({
        file:'states.csv',
        join:'FIPS'
      })
    ]).then(([counties,states]) => {
      setCountyDict(counties.data)
      setStateDict(states.data)
    })
  },[])

  if (!(typeof window) || !currentHoverTarget.data) return null;

  const rightSide = currentHoverTarget.x > window.innerWidth / 2
  const bottomSide = currentHoverTarget.y > window.innerHeight / 2
  const [ 
    xProp, 
    x,
    yProp,
    y
  ] = [
    rightSide ? 'right' : 'left',
    rightSide ? window.innerWidth - currentHoverTarget.x : currentHoverTarget.x,
    bottomSide ? 'bottom' : 'top',
    bottomSide ? window.innerHeight - currentHoverTarget.y - 50: currentHoverTarget.y + 50,
  ]
  
  return (
    <div
      className={styles.tooltipContainer}
      style={{ [xProp]: x, [yProp]: y, display: x === null ? 'none' : 'block' }}
    >
      <TooltipTitle   
        currentData={currentData}
        stateDict={stateDict}
        countyDict={countyDict}
        id={currentHoverTarget.id}
      />
      {currentHoverTarget.data.map((entry, idx) => (
        <p key={`tooltip-entry-${idx}`}>

          <b>{entry.name}</b>: {
            +entry.value
              ? Math.round(entry.value * 100) / 100
              : entry.value
            }
        </p>
      ))}
    </div>
  );
}

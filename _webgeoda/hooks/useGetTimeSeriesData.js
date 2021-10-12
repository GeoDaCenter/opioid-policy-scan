import { useSelector, useDispatch } from "react-redux";
import { useState, useEffect } from 'react';
import { 
    dataFn, 
    find, 
 } from '../utils/data';
import useGetTables from "./useGetTables";

const summarizeTable = (variableSpec, table, position) => {
    let returnArray = [];
    if (`${position}Index` in variableSpec) {
        const tableVals = Object.values(table)
        for (let i=0; i<tableVals[0].length;i++){
            let tempVal = 0;
            for (let n=0; n<tableVals.length;n++){
                tempVal+=tableVals[n][i]||0
            }
            returnArray.push(tempVal)
        }
    } else if (`${position}Property` in variableSpec) {
        const keys = Object.keys(table)
        let tempVal = 0;
        for (let i=0; i<keys.length;i++){
            tempVal += table[keys[i]][`${position}Property`]||0
        }
        returnArray = {
            [`${position}Property`]: tempVal
        }
    }
    return returnArray;
}

export default function useGetTimeSeriesData({
    dataset=false,
    variable=false,
    params={},
    geoids=[]
}) {
    const currentData = useSelector((state) => state.currentData);
    const cachedTimeSeries = useSelector((state) => state.cachedTimeSeries);
    const dataPresets = useSelector((state) => state.dataPresets);
    const dispatch = useDispatch();
    const [data, setData] = useState([]);

    const {numerator, denominator, dates} = useGetTables({
        variable,
        dataset,
        geoids
    });

    const getTimeSeries = ({
        dataset,
        numerator,
        denominator,
        variable,
        cachedTimeSeries,
        dates
    }) => {
        if (variable === false || !dates.length) return;
        if (`${variable}-${dataset}` in cachedTimeSeries){
            setData(cachedTimeSeries[`${variable}-${dataset}`])
        } else {
            const variableSpec = find(
                    dataPresets.variables,
                    (o) => o.variable === variable
                )
            const numerVals = summarizeTable(variableSpec, numerator, 'n')
            const denomVals = summarizeTable(variableSpec, denominator, 'd') 
            const timeSeriesLength = numerVals.length || denomVals.length
            let result = []
            for (let i=0; i<timeSeriesLength; i++){
                result.push({
                    value: dataFn(
                        numerVals,
                        denomVals,
                        {
                            ...variableSpec,
                            ['nIndex' in variableSpec && 'nIndex']: i,
                            ['dIndex' in variableSpec && 'dIndex']: i,
                        }
                    ),
                    date:dates[i]['$d'].toISOString().slice(0,10)
                })
            }
            dispatch({
                type:'CACHE_TIME_SERIES',
                payload: {
                    id: `${variable}-${dataset}`,
                    data: result
                }
            })
            setData(result)
        }
    }
    useEffect(() => {
        getTimeSeries({
            dataset: dataset||currentData, 
            numerator,
            denominator,
            variable, 
            geoids,
            cachedTimeSeries,
            dates
        })
    },[dataset, variable, geoids.length, numerator, denominator])
    return data
}
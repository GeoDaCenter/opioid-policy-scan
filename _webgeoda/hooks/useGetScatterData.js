import { useMemo } from 'react';
import useGetVariable from './useGetVariable';
import useGetLisa from './useGetLisa';
import { useDispatch, useSelector } from 'react-redux';
import usePanMap from './usePanMap';

const zipByKey = (var1, key1, var2, key2) => {
    if (!Object.keys(var1).length || !Object.keys(var2).length) return []
    let returnCollection = []
    const keys = Object.keys(var1)
    for (let i=0; i<keys.length; i++){
        returnCollection.push({
            [key1]: var1[keys[i]],
            [key2]: var2[keys[i]],
            id: +keys[i]
        })
    }
    return returnCollection
}

export default function useGetScatterData({
    dataset=false,
    options={},
    config={},
    id=0,
    targetRange=100,
    geoids=[]
}){
    let variables = [];
    if(config.type === 'lisaScatter') variables = [];
    else if(config.type === 'scatter3d') variables = [config.xVariable, config.yVariable, config.zVariable];
    else variables = [config.xVariable, config.yVariable];

    const currentData = useSelector((state) => state.currentData)
    const currentDataset = useSelector((state) => state.storedGeojson[dataset||currentData]);
    const idKeys = currentDataset?.order||[];
    const dispatch = useDispatch();
    const panToGeoid = usePanMap();
    const xData = useGetVariable({
        variable: config.type === 'lisaScatter'
            ? false
            : config.xVariable,
        dataset,
        geoids: config.type === 'heatmap'? geoids : []
    });

    const yData = useGetVariable({
        variable: config.type === 'lisaScatter'
            ? false
            : config.yVariable,
        dataset,
        geoids: config.type === 'heatmap'? geoids : []
    });

    const zData = useGetVariable({
        variable: config.type === 'scatter3d'
            ? config.zVariable
            : false,
        dataset
    });

    const lisaData = useGetLisa({
        variable: config.type === 'lisaScatter'
            ? config.variable
            : false,
        dataset,
        getScatterPlot: true
    })

    if (config.type === "scatter3d"){
        const {
            data,
            xScale,
            yScale,
            zScale
        } = useMemo(() => zipAndScale(
            xData,
            yData,
            zData,
            targetRange
        ),[Object.keys(xData).length, Object.keys(yData).length, Object.keys(zData).length, config, options])
        
        return {
            xScale,
            yScale,
            zScale,
            data
        }
    } else {
        const chartData = zipByKey(xData, 'x', yData, 'y')
        return {
            chartData
        }
    }
}
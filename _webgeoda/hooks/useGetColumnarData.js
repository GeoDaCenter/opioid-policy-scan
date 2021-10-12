import { useState, useEffect } from 'react';
import useGetVariable from './useGetVariable';

const formatData = (data) => {
    if (!data) return [];
    let returnArray = [];
    const vals = Object.values(data)
    const ids = Object.keys(data)
    for (let i=0; i<vals.length;i++){
        returnArray.push({value:vals[i], id: +ids[i]})
    }
    return returnArray
}

export default function useGetColumnarData({
    variable=false,
    dataset=false,
}){
    const [data, setData] = useState([])
    const columnData = useGetVariable({
        variable,
        dataset
    });
    
    useEffect(() => {
        setData(formatData(columnData))
    }, [columnData, variable, dataset])

    return {
        chartData: data
    }
}

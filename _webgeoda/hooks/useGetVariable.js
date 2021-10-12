import { useSelector, useDispatch } from "react-redux";
import { useEffect, useState } from "react";
import { find, parseColumnData, zip} from '../utils/data';
import useGetTables from './useGetTables';
import useFetchData from "./useFetchData";

export default function useGetVariable({
    dataset=false,
    variable=false,
    geoids=[],
    priority=true
}){
    const currentData = useSelector((state) => state.currentData);
    const storedGeojson = useSelector((state) => state.storedGeojson);
    const dataPresets = useSelector((state) => state.dataPresets);
    // const cachedVariables = useSelector((state) => state.cachedVariables);
    const fetchData = useFetchData();
    const dispatch = useDispatch();
    const {numerator, denominator} = useGetTables({
        dataset,
        variable,
        geoids,
        priority
    });
    const [data, setData] = useState([]); 

    const getColumn = async (
        dataset,
        variable,
        geoids
    ) => {
        if (variable === false) return;
        // variable already exists
        // if (dataset in cachedVariables && variable in cachedVariables[dataset]){
        //     if (geoids.length){
        //         let tempData = {};
        //         for (let i=0; i<geoids.length; i++) {
        //             tempData[geoids[i]] = cachedVariables[dataset][variable][geoids[i]]
        //         }
        //         setData(tempData)
        //     } else {
        //         setData(cachedVariables[dataset][variable])
        //     }
        // } else {
            const variableSpec = find(
                dataPresets.variables,
                (o) => o.variable === variable
            )

            if (Object.keys(numerator).length === 0 || (
                variableSpec.denominator && Object.keys(denominator).length === 0
            )) return;

            const order = storedGeojson[dataset]?.order || Object.keys(numerator)

            const result = parseColumnData({
                numeratorData: numerator,
                denominatorData: denominator,
                dataParams: variableSpec,
                fixedOrder: order
            })

            
            dispatch({
                type:'CACHE_VARIABLE',
                payload:{
                    dataset: dataset,
                    cachedVariable: {
                        variable: variable,
                        geoidOrder: order,
                        data: result
                    }
                }
            })
            setData(zip(order, result))
        // }
    }

    useEffect(() => {
        getColumn(
            dataset||currentData, 
            variable, 
            geoids
        )
    },[dataset, variable, geoids.length, numerator, denominator])
    
    return data
}
import { useState, useMemo, useEffect, useContext } from 'react';
import useGetVariable from './useGetVariable';
import { GeodaContext } from "@webgeoda/contexts";
import useGetLisa from './useGetLisa';
import { getBins } from '../utils/geoda-helpers';
import { useDispatch, useSelector } from 'react-redux';

import { 
    getMapData 
} from "../utils/map";

export default function useGetMapData({
    currentData=false,
    dataParams={},
    mapParams={}
}){
    const [mapData, setMapData] = useState({data:{},params:''});
    const [lisaData, setLisaData] = useState([]);
    const [binning, setBinning] = useState({
        bins:{
            bins: [],
            breaks: []
        },
        colorScale: []
    });
    const storedLisaData = useSelector((state) => state.storedLisaData);
    const storedGeojson = useSelector((state) => state.storedGeojson);
    const currentMapGeography = storedGeojson[currentData]?.data || [];
    const currentTiles = useSelector((state) => state.currentTiles);
    const geoda = useContext(GeodaContext);

    const variableData = useGetVariable({
        variable: dataParams.variable,
        dataset: currentData
    });
    
    // Side effect 1 - update bins on state change - data or map params
    useEffect(() => {
        if (!Object.keys(variableData).length) return;

        if (!!dataParams.fixedScale){
            setBinning({
                bins: {
                    bins: dataParams.fixedLabels || dataParams.fixedScale,
                    binData: null,
                    breaks: dataParams.fixedScale
                },
                colorScale: dataParams.colorScale.length ? dataParams.colorScale : dataParams.colorScale[dataParams.numberOfBins]
              })
        } else if (!!dataParams.lisa) {
        // todo
        } else {
            getBins({
                geoda,
                dataParams,
                binData: Object.values(variableData)
            }).then(bins => setBinning({
                bins, 
                colorScale: dataParams.colorScale.length ? dataParams.colorScale : dataParams.colorScale[dataParams.numberOfBins]
            }))
        }
    },[
        currentData,
        JSON.stringify(mapParams),
        JSON.stringify(dataParams),
        Object.keys(variableData).length
    ])

    // Side effect 2 - update map data on binning change
    useEffect(() => {
        if (Object.keys(binning).length){
            setMapData(
                getMapData({
                    dataParams,
                    mapParams: {
                        ...mapParams,
                        ...binning
                    },
                    variableData,
                    currentData,
                    storedGeojson,
                    storedLisaData
                })
            )
        }
    }, [
        JSON.stringify(binning)
    ]);
    
    return { 
        binning,
        currentMapGeography,
        currentTiles,
        mapData
    }
}
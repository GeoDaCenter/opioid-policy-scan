import { useSelector, useDispatch } from "react-redux";
import { useContext } from 'react';
import { GeodaContext, useSetViewport } from "../contexts";
import { fitBounds } from "@math.gl/web-mercator";

import {
    find,    
    handleLoadData,
    indexGeoProps,
} from '../utils/data';

const getIdOrder = (features, idProp) => {
    let returnArray = [];
    for (let i=0; i<features.length; i++) {
      returnArray.push(features[i].properties[idProp])
    }
    return returnArray
};
  
export default function useFetchData(){
    const geoda = useContext(GeodaContext);
    const dispatch = useDispatch();
    const dataPresets = useSelector((state) => state.dataPresets);
    const setViewport = useSetViewport();
    
    const fetchData = async ({
        req=undefined,
        dateIndices=false,
        geoOrder=false
    }) => {
        if (req === undefined) return {}
        // geodata
        if ("string" === typeof req) {
            const dataSpec =  find(
                dataPresets.data,
                (o) => o.geodata === req
            )            
            if (req.includes('tiles')) {
                console.log('Error: Tiled data cannot have attached data.')
                return {}
            }
            const dataUrl = req.slice(0,4) === 'http' 
                ? req
                : `${window.location.origin}/geojson/${req}`
            const [mapId, geojsonData]  = await geoda.loadGeoJSON(
                dataUrl,
                dataSpec.id
                )  
                
                
            const geojsonProperties = indexGeoProps(geojsonData,dataSpec.id)
            const geojsonOrder = getIdOrder(geojsonData.features,dataSpec.id) 
            
            const bounds = mapId === null
                ? [-180,180,-70,80]
                : dataSpec.bounds 
                ? dataSpec.bounds 
                : await geoda.getBounds(mapId);

            let initialViewState = window !== undefined
                ? fitBounds({
                    width: window.innerWidth,
                    height: window.innerHeight,
                    bounds: [
                    [bounds[0], bounds[2]],
                    [bounds[1], bounds[3]],
                    ],
                })
                : null;

            setViewport((viewState) => {
                return {
                    bearing:0,
                    pitch:0,
                    ...viewState,
                    ...initialViewState,   
                    zoom: initialViewState.zoom*.9
                }
            })

            dispatch({
                type:'ADD_GEOJSON',
                payload: {
                    data: {
                        [req]: {
                            data: geojsonData,
                            properties: geojsonProperties,
                            order: geojsonOrder,
                            id: mapId,
                            weights: {}
                        }
                    }
                }
            })

            if (geoOrder) {
                return {
                    properties: geojsonProperties,
                    order: geojsonOrder
                }
            }

            return geojsonProperties
        // tabular data
        } else {
            const data = await handleLoadData(req);            
            dispatch({
                type:'ADD_TABLES',
                payload: {
                    [req.file]: data
                }
            })
            if (dateIndices) {
                return data
            }
            return data
        }
    }

    return fetchData
}
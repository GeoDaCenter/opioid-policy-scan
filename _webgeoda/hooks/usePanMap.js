import { useSetViewport } from '../contexts';
import { useSelector } from "react-redux";
import { fitBounds } from "@math.gl/web-mercator";
import {FlyToInterpolator} from '@deck.gl/core';

import {
    find
  } from "../utils/data";

const findBounds = (geom) => {    
    if (geom === undefined) return;
    const coords = geom[0];
    let returnArray = [[coords[0][0],coords[0][1]],[coords[0][0],coords[0][1]]]

    for (let i=1; i<coords.length; i++){
        if (coords[i][0] < returnArray[0][0]) {
            returnArray[0][0] = coords[i][0]
        } else if (coords[i][0] > returnArray[1][0]) {
            returnArray[1][0] = coords[i][0]
        }

        if (coords[i][1] < returnArray[0][1]) {
            returnArray[0][1] = coords[i][1]
        } else if (coords[i][1] > returnArray[1][1]) {
            returnArray[1][1] = coords[i][1]
        }
    }
    return returnArray
}
export default function usePanMap(){
    const storedGeojson = useSelector((state) => state.storedGeojson);
    const currentData = useSelector((state) => state.currentData);
    const currentId = useSelector((state) => state.currentId);
    const setViewport = useSetViewport();

    const panToGeoid = (geoid, timing=250) => {
        const bounds = findBounds(
            find(
                storedGeojson[currentData].data.features,
                (o) => o.properties[currentId] === geoid
            )
            ?.geometry?.coordinates
        )
        
        if (bounds === undefined) return;
        const view = fitBounds({
            width: window.innerWidth,
            height: window.innerHeight,
            bounds
        })

        if (view === undefined) return;
        setViewport((viewState) => {
            return {
                ...viewState,
                ...view,   
                zoom: view.zoom*.9,         
                transitionDuration: timing,
                transitionInterpolator: new FlyToInterpolator()
            }
        })
    }

    return panToGeoid
}
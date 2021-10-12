import { useDispatch, useSelector } from 'react-redux';
import { useViewport } from '@webgeoda/contexts';
import { useEffect, useState } from 'react';
import {WebMercatorViewport} from '@deck.gl/core';
import useGetCentroids from './useGetCentroids';

const filterLatLon = (centroids, topLeft, bottomRight) => {
    let filteredGeoids = []
    for (let i=0; i<centroids.length; i++){
        if (
            centroids[i].pos[0] > topLeft[0] && centroids[i].pos[0] < bottomRight[0] &&
            centroids[i].pos[1] < topLeft[1] && centroids[i].pos[1] > bottomRight[1]
        ) filteredGeoids.push(centroids[i].id)
    }
    return filteredGeoids
}

export default function useBoxSelectFilter(){
    const viewport = useViewport();
    const boxSelect = useSelector((state) => state.boxSelect);
    const boxFilterGeoids = useSelector((state) => state.boxFilterGeoids);
    const showWidgetTray = useSelector((state) => state.showWidgetTray);
    const [timeoutId, setTimeoutId] = useState('');
    const dispatch = useDispatch();

    const centroids = useGetCentroids({})
    useEffect(() => {
        if (boxSelect.active){
            const tempViewport = new WebMercatorViewport({
                width: window.innerWidth - showWidgetTray*420,
                height: window.innerHeight-50,
                ...viewport
            });
            const topLeft = tempViewport.unproject([boxSelect.left, boxSelect.top])
            const bottomRight = tempViewport.unproject([boxSelect.left+boxSelect.width, boxSelect.top+boxSelect.height])
            clearTimeout(timeoutId)
            setTimeoutId(setTimeout(() => {
                dispatch({
                    type:'SET_FILTERED_GEOIDS',
                    payload: filterLatLon(
                        centroids,
                        topLeft,
                        bottomRight
                    )
                })
            }, 5))
        } else {
            dispatch({
                type:'SET_FILTERED_GEOIDS',
                payload: []
            })
        }
    },[boxSelect.active, JSON.stringify(boxSelect), JSON.stringify(viewport), Object.keys(centroids).length])

    return boxFilterGeoids
}
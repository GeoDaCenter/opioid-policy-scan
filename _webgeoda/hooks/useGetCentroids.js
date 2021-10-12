import { useContext, useEffect, useState } from 'react';
import { useSelector } from 'react-redux';
import { GeodaContext } from "../contexts";

const combineObjects = (vals1, name1, vals2, name2) => {
    let returnArray = []
    for (let i=0; i<vals1.length;i++){
        returnArray.push({
            [name1]:vals1[i],
            [name2]:vals2[i]
        })
    }
    return returnArray;
}

const getCentroids = async (id, keys, geoda) => {
    if (!id || !keys) return []
    const centroids = await geoda.getCentroids(id)
    if (centroids === null) return []
    return combineObjects(keys, 'id', centroids, 'pos')
}

export default function useGetCentroids({
    dataset=false
}){
    const currentData = useSelector((state) => state.currentData);
    const currentMapData = useSelector((state) => state.storedGeojson[dataset||currentData]);
    const [centroids, setCentroids] = useState([])
    const geoda = useContext(GeodaContext);

    useEffect(() => {
        getCentroids(currentMapData?.id, currentMapData?.order, geoda).then(result => setCentroids(result))
    },[currentData, dataset, currentMapData?.order.length])
    
    return centroids
}
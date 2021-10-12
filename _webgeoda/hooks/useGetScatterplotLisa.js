import { useSelector, useDispatch } from "react-redux";
import { useContext, useEffect } from "react";

export default function useGetScatterplotLisa(){
    const dispatch = useDispatch();
    const getCachedLisa = (dataParams) => {
        const data = useSelector((state) => state.cachedLisaScatterplotData);
        if(dataParams.variable in data) return data[dataParams.variable];
        return null;
    }

    const updateCachedLisa = (dataParams, data) => {
        // dataParams.variable
        dispatch({
            type: "CACHE_SCATTERPLOT_LISA",
            payload: {
                variableName: dataParams.variable,
                data
            }
        });
    }

    return [getCachedLisa, updateCachedLisa];
}
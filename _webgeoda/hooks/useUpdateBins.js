import { useSelector, useDispatch } from "react-redux";
import { useContext, useEffect } from "react";
import { GeodaContext } from "@webgeoda/contexts";

import {
  generateBins
} from "../utils/geoda-helpers";

export default function useUpdateBins() {
  const geoda = useContext(GeodaContext);
  const currentData = useSelector((state) => state.currentData);
  const storedGeojson = useSelector((state) => state.storedGeojson);
  const storedData = useSelector((state) => state.storedData);
  const dataParams = useSelector((state) => state.dataParams);
  const dataPresets = useSelector((state) => state.dataPresets);
  
  const dispatch = useDispatch();

  const updateBins = async () => {
    if (!storedGeojson[currentData]) return;
    
    const variablePreset = dataPresets.variables.find(
      (o) => o.variable === dataParams.variable
    )

    const {bins, colorScale} = await generateBins({
      geoda,
      dataPresets,
      currentData,
      dataParams: {
        ...dataParams,
        ...variablePreset
      }, 
      storedData,
      storedGeojson 
    })

    if (!bins) return;

    dispatch({
      type: "UPDATE_BINS",
      payload: {
        bins,
        colorScale,
      },
    });
  };

  return [updateBins];
}

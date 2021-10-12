import { useSelector, useDispatch } from "react-redux";
import { useState, useContext, useEffect } from "react";
import { GeodaContext } from "../contexts";

import {
    parseColumnData,
    findTable
} from "../utils/data";

import {
    hexToRgb
} from "../utils/map";

import {
    getLisaResults
} from "../utils/geoda-helpers";


import {
    standardize
} from "../utils/stats";

import useGetVariable from "./useGetVariable";


export default function useGetLisa({
    dataset = false,
    variable = false,
    getScatterPlot = false,
    id = 0,
    config = {},
}) {
    const geoda = useContext(GeodaContext);
    const currentData = useSelector((state) => state.currentData);
    const storedGeojson = useSelector((state) => state.storedGeojson);
    const dataPresets = useSelector((state) => state.dataPresets);
    const lisaVariable = useSelector((state) => state.lisaVariable);
    const columnData = useGetVariable({
        dataset: dataset || currentData,
        variable,
        priority: false
    })

    const [data, setData] = useState({
        weights: {},
        lisaResults: {},
        lisaData: []
    });

    const dispatch = useDispatch();

    const clusterFilter = config.clusterFilter
    const pValFilterL = config.pValFilterL
    const pValFilterU = config.pValFilterU

    let allFiltered = {};
    let lisaResultsFiltered = { clusters: [], lisaValues: [], neighbors: [], pvalues: [] };


    const getLisa = async (
        columnData,
        dataset,
        getScatterPlot = true,
    ) => {
        if (!Object.keys(columnData).length || !(dataset in storedGeojson)) return;

        // const variableSpec = find(
        //     dataPresets.variables,
        //     (o) => o.variable === variable
        // )

        const variableSpec = { variable: lisaVariable }

        const { weights, lisaResults } = await getLisaResults({
            geoda,
            storedGeojson,
            currentData: dataset,
            dataParams: variableSpec,
            lisaData: Object.values(columnData),
            dataset
        })

        let scatterPlotDataStan = [];
        const standardizedVals = standardize(Object.values(columnData));
        const spatialLags = await geoda.spatialLag(weights, standardizedVals);
        const spatialLagsNonStan = await geoda.spatialLag(weights, Object.values(columnData));
        for (let i = 0; i < standardizedVals.length; i++) {
            scatterPlotDataStan.push({
                x: standardizedVals[i],
                y: spatialLags[i],
                cluster: lisaResults.clusters[i],
                id: storedGeojson[currentData].order[i]
            })
        }

        if (config.type === 'lisaScatter') {
            if (clusterFilter != 'All') {
                const index = lisaResults.labels.findIndex(cl => cl == clusterFilter)


                for (let i = 0; i < lisaResults.clusters.length; i++) {
                    if (lisaResults.clusters[i] == index && (lisaResults.pvalues[i] > pValFilterL && lisaResults.pvalues[i] <= pValFilterU)) {
                        allFiltered[i] = columnData[storedGeojson[currentData].order[i]];
                        lisaResultsFiltered.clusters.push(lisaResults.clusters[i])
                        lisaResultsFiltered.lisaValues.push(lisaResults.lisaValues[i])
                        lisaResultsFiltered.neighbors.push(lisaResults.neighbors[i])
                        lisaResultsFiltered.pvalues.push(lisaResults.pvalues[i])
                    }
                }
            }
            else {
                for (let i = 0; i < lisaResults.clusters.length; i++) {
                    if (lisaResults.pvalues[i] > pValFilterL && lisaResults.pvalues[i] <= pValFilterU) {
                        allFiltered[i] = columnData[storedGeojson[currentData].order[i]];
                        lisaResultsFiltered.clusters.push(lisaResults.clusters[i])
                        lisaResultsFiltered.lisaValues.push(lisaResults.lisaValues[i])
                        lisaResultsFiltered.neighbors.push(lisaResults.neighbors[i])
                        lisaResultsFiltered.pvalues.push(lisaResults.pvalues[i])
                    }
                }
            }

            if (Object.values(allFiltered).length != Object.values(columnData).length) {
                dispatch({
                    type: "SET_MAP_FILTER",
                    payload: {
                        widgetIndex: id,
                        filterId: id,
                        filter: {
                            type: "set",
                            field: lisaVariable,
                            values: Object.values(allFiltered),
                        }
                    }
                });
            }
            setData({ weights, lisaResults, scatterPlotDataStan, lisaData: columnData, spatialLags: spatialLagsNonStan, order: storedGeojson[currentData].order, allFiltered, lisaResultsFiltered });
        }
        else { setData({ weights, lisaResults, scatterPlotDataStan, lisaData: columnData, order: storedGeojson[currentData].order, spatialLags: spatialLagsNonStan }) }
    }

    useEffect(() =>
        getLisa(
            columnData,
            dataset || currentData,
            getScatterPlot
        ),
        [dataset, Object.keys(columnData).length, getScatterPlot, config, variable, Object.keys(storedGeojson).length])

    return data;
}

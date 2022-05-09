import styles from "./MainMap.module.css";
import React, { useState, useCallback, useEffect, useRef } from "react";

// deck GL and helper function import
import DeckGL from "@deck.gl/react";
import { GeoJsonLayer } from "@deck.gl/layers";
import {MVTLayer} from '@deck.gl/geo-layers';
import {MapboxLayer} from '@deck.gl/mapbox';
import MapboxGLMap from "react-map-gl";
import { useDispatch, useSelector } from "react-redux";

import 'mapbox-gl/dist/mapbox-gl.css';

import Loader from "../layout/Loader";

import { useViewport, useSetViewport } from '@webgeoda/contexts';
import useLoadData from "@webgeoda/hooks/useLoadData";
import useUpdateMap from "@webgeoda/hooks/useUpdateMap";
// import usePanMap from "@webgeoda/hooks/usePanMap";

import Legend from "./Legend";
import MapControls from "./MapControls";

export default function MainMap() {
  const initialViewState = useSelector((state) => state.initialViewState);
  const dataParams = useSelector((state) => state.dataParams);
  const mapParams = useSelector((state) => state.mapParams);
  const currentData = useSelector((state) => state.currentData);
  const currentTiles = useSelector((state) => state.currentTiles);
  const currentId = useSelector((state) => state.currentId);
  const currentHoverId = useSelector((state) => state.currentHoverId);
  const storedGeojson = useSelector((state) => state.storedGeojson);
  const currentMapGeography = storedGeojson[currentData]?.data || [];
  const mapData = useSelector((state) => state.mapData);
  const mapStyle = useSelector((state) => state.mapStyle);
  const isLoading = useSelector((state) => state.isLoading);
  const [glContext, setGLContext] = useState();
  const dispatch = useDispatch();
  // const panToGeoid = usePanMap();

  // eslint-disable-next-line no-empty-pattern
  const [] = useLoadData();
  // eslint-disable-next-line no-empty-pattern
  const [] = useUpdateMap();
  // eslint-disable-next-line no-empty-pattern
  const viewport = useViewport();
  // eslint-disable-next-line no-empty-pattern
  const setViewport = useSetViewport();

  const deckRef = useRef();
  const mapRef = useRef();
  
  useEffect(() => {
    if (initialViewState.longitude)
      setViewport({
        longitude: initialViewState.longitude,
        latitude: initialViewState.latitude,
        zoom: initialViewState.zoom * 0.9,
        bearing:0,
        pitch:0
      });
  }, [initialViewState]);

  // const handleMapClick = (e) => e.object && panToGeoid(e.object?.properties[currentId])

  const handleMapHover = (e) => {
    if (e.object) {
      try {
        const value = mapData.data[e.object.properties[currentId]].value
        const label = dataParams.variable
        dispatch({
          type: "SET_HOVER_OBJECT",
          payload: {
            id: e.object?.properties[currentId],
            layer: e.layer.id,
            x: e.x,
            y: e.y,
            data: [{
              name: label,
              value: value
            }]
          },
        })
      } catch {
        dispatch({
          type: 'SET_HOVER_OBJECT',
          payload: {
            id: null,
            x: null,
            y: null
          }
        })
      }
    } else {
      dispatch({
        type: 'SET_HOVER_OBJECT',
        payload: {
          id: null,
          x: null,
          y: null
        }
      })
    }
  };

  const onMapLoad = useCallback(() => {
    const map = mapRef.current.getMap();
    const deck = deckRef.current.deck;
    
    map.addLayer(
      new MapboxLayer({ id: "choropleth", deck }),
      mapStyle.underLayerId
    );
    map.addLayer(
      new MapboxLayer({ id: "tiles layer", deck }),
      mapStyle.underLayerId
    );
    map.addLayer(
      new MapboxLayer({ id: "choropleth-hover", deck })
    );
  }, []);
  
  const layers = !mapData.params.includes(currentData)
    ? [new GeoJsonLayer({
      id: "choropleth",
      data: null
    })]
    : currentData.includes('tiles')
    ? [new MVTLayer({
        id: "tiles layer",
        // eslint-disable-next-line no-undef 
        data: `https://api.mapbox.com/v4/${currentTiles}/{z}/{x}/{y}.mvt?access_token=${process.env.NEXT_PUBLIC_MAPBOX_TOKEN}`,
        getFillColor: (d) => mapData.data[d.properties[currentId]]?.color||[0,0,0,0],
        pickable: true,
        onHover: handleMapHover,
        updateTriggers: {
          getFillColor: [mapData.params, currentId, currentData, JSON.stringify(mapParams.bins)],
        },
      })]  
    : [
      new GeoJsonLayer({
        id: "choropleth",
        data: currentMapGeography,
        getFillColor: (d) => mapData.data[d.properties[currentId]]?.color,
        getLineColor: (d) => [
          0,
          0,
          0,
          255 * (+d.properties[currentId] === currentHoverId),
        ],
        // getElevation: d => currentMapData[d.properties.GEOID].height,
        pickable: true,
        stroked: true,
        filled: true,
        lineWidthScale: 1,
        lineWidthMinPixels: 1,
        getLineWidth: 5,
        // wireframe: mapParams.vizType === '3D',
        // extruded: mapParams.vizType === '3D',
        // opacity: mapParams.vizType === 'dotDensity' ? mapParams.dotDensityParams.backgroundTransparency : 0.8,
        material: false,
        onHover: handleMapHover,
        // onClick: handleMapClick,
        updateTriggers: {
          getFillColor: [mapData.params, currentId, currentData],
          getLineColor: [mapData.params, currentHoverId]
        }
      })];

    // h
  return (
    <div className={styles.mapContainer}>
      
      {isLoading && <div className={styles.preLoader}><Loader globe={true} /></div>}
      <DeckGL
        layers={layers}
        ref={deckRef}
        initialViewState={viewport}
        controller={true}
        pickingRadius={20}
        onViewStateChange={({viewState}) => setViewport(viewState)}
        onWebGLInitialized={setGLContext}
        glOptions={{
          /* To render vector tile polygons correctly */
          stencil: true
        }}
      >
        <MapboxGLMap
          reuseMaps
          ref={mapRef}
          gl={glContext}
          mapStyle={mapStyle.mapboxStyle}
          preventStyleDiffing={true}
          onLoad={onMapLoad}
          // eslint-disable-next-line no-undef
          mapboxApiAccessToken={process.env.NEXT_PUBLIC_MAPBOX_TOKEN}
        ></MapboxGLMap>
      </DeckGL>
      <Legend
        bins={mapParams.bins.bins}
        colors={mapParams.colorScale}
        variableName={dataParams.variable}
        ordinal={dataParams.categorical||dataParams.lisa}
      />
      <MapControls
        deck={deckRef}
      />
      <div className={styles.attribution}>
        <a href="https://www.mapbox.com/about/maps/" target="_blank" rel="noopener noreferrer">© Mapbox</a>
        <a href="https://www.openstreetmap.org/about/" target="_blank" rel="noopener noreferrer">© OpenStreetMap</a>
        <a href="https://www.mapbox.com/contribute/#/?owner=csds-hiplab&id=ckmuv80qn2b6o17ltels6z7ub&access_token=pk.eyJ1IjoiY3Nkcy1oaXBsYWIiLCJhIjoiY2tkcTdlYXNsMGRhNDJybXl1MWdpejdidSJ9.mgK9yXDfhFCLh5YQuz6r_g&utm_source=https%3A%2F%2Fchichives.com%2F&utm_medium=attribution_link&utm_campaign=referrer" target="_blank" rel="noopener noreferrer">Improve this Map</a>
      </div>
    </div>
  );
}

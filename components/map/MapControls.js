import styles from "./MainMap.module.css";
import { FlyToInterpolator } from "@deck.gl/core";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPlus, faMinus, faLocationArrow, faGlobe } from "@fortawesome/free-solid-svg-icons";

import Tooltip from "@reach/tooltip";
import "@reach/tooltip/styles.css";

import {  useSetViewport } from '@webgeoda/contexts';

const handleGeolocate = async (setViewport) => {
  navigator.geolocation.getCurrentPosition((position) => {
    setViewport({
      longitude: position.coords.longitude,
      latitude: position.coords.latitude,
      zoom: 7,
      transitionDuration: 1000,
      transitionInterpolator: new FlyToInterpolator(),
    });
  });
};

const handleZoom = (zoom, setViewport) => {
  setViewport(prev => {
    return {
      ...prev,
      zoom: prev.zoom + zoom,
      transitionDuration: 250,
      transitionInterpolator: new FlyToInterpolator(),
    }});
};

const resetTilt = (setViewport) => {
  setViewport(prev => {
    return {
      ...prev,
      pitch:0,
      bearing:0,
      transitionDuration: 250,
      transitionInterpolator: new FlyToInterpolator(),
    }});
};

export default function MapControls() {
  const setViewport = useSetViewport();

  return (
    <div className={styles.mapButtonContainer}>
      <Tooltip label="Zoom In">
        <button
          className={styles.mapButton}
          title="Zoom In"
          id="zoomIn"
          onClick={() => handleZoom(0.5, setViewport)}
        >
          <FontAwesomeIcon icon={faPlus} className={styles.icon} />
        </button>
      </Tooltip>
      <Tooltip label="Zoom Out">
        <button
          className={styles.mapButton}
          title="Zoom Out"
          id="zoomOut"
          onClick={() => handleZoom(-0.5, setViewport)}
        >
          <FontAwesomeIcon icon={faMinus} className={styles.icon} />
        </button>
      </Tooltip>
      <Tooltip label="Reset Tilt">
        <button
          className={styles.mapButton}
          title="Reset Tilt"
          id="reset-tilt"
          onClick={() => resetTilt(setViewport)}
        >
          <FontAwesomeIcon icon={faLocationArrow} className={styles.icon} />
        </button>
      </Tooltip>
      <Tooltip label="GPS">
        <button
          className={styles.mapButton}
          title="Find My Location"
          id="locate-user"
          onClick={() => handleGeolocate(setViewport)}
        >
          <FontAwesomeIcon icon={faGlobe} className={styles.icon} />
        </button>
      </Tooltip>
    </div>
  );
}

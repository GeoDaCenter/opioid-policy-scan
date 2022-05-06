import { dataPresets } from "../../map-config";
import * as colors from "@webgeoda/utils/colors";

const colorScale = typeof dataPresets?.variables[0]?.colorScale === "string"
  ? colors.colorbrewer[dataPresets.variables[0].colorScale][dataPresets.variables[0].numberOfBins || 5]
  : dataPresets.variables[0].colorScale;

export const INITIAL_STATE = {
  storedGeojson: {},
  storedData: {},
  currentData: dataPresets.data[0].geodata,
  currentMethod: "natural_breaks",
  currentOverlay: "",
  currentResource: "",
  currentHoverTarget: {
    x: null,
    y: null,
    id: null,
    data: null,
  },
  mapData: {
    data: [],
    params: [],
  },
  initialViewState: {},
  dataParams: {
    ...dataPresets.variables[0],
    colorScale
  },
  dataPresets: dataPresets,
  mapParams: {
    mapType: "natural_breaks",
    bins: {
      bins: [],
      breaks: [],
    },
    binMode: "",
    fixedScale: null,
    nBins: 8,
    vizType: "2D",
    activeGeoid: "",
    overlay: "",
    resource: "",
    colorScale: [],
  },
  panelState: {
    variables: true,
    report: false,
    context: false,
    contextPos: { x: null, y: null },
  },
  selectionKeys: [],
  selectionNames: [],
  sidebarData: {},
  anchorEl: null,
  mapLoaded: false,
  mapStyle: {
    mapboxStyle: dataPresets.style?.mapboxStyle || 'mapbox://styles/dhalpern/ckp07gekw2p2317phroaarzej',
    underLayerId: dataPresets.style?.underLayerId || 'water'
  },
  notification: {
    info: null,
    location: "",
  },
  tooltipContent: {
    x: 0,
    y: 0,
    data: null,
  },
  isLoading: true,
  shouldUpdateBins: false
};

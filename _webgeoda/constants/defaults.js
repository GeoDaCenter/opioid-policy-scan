import { dataPresets } from "../../map-config";
import * as colors from "@webgeoda/utils/colors";

const {
  style,
  variables,
  defaultVariable,
  defaultData,
  data
} = dataPresets;

const dataParams = variables.find(f => f.variable === defaultVariable)
const colorScale = typeof dataParams?.colorScale === "string"
  ? colors.colorbrewer[dataParams.colorScale][dataParams.numberOfBins || 5]
  : dataParams.colorScale;


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
    ...dataParams,
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

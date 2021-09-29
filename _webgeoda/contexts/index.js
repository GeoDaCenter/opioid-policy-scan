import React, { useState, useContext, createContext} from 'react';

export const GeodaContext = createContext({});

const ViewportContext = React.createContext();
const SetViewportContext = React.createContext();

/* Wrap your app in this bad boy */
export const ViewportProvider = (
    {defaultViewport = {
        latitude:0,
        longitude:0,
        zoom:10,
        bearing:0,
        pitch:0
    }, 
    children
}) => {
  const [viewport, setViewport] = useState(defaultViewport);
  
  return (
    <ViewportContext.Provider value={viewport}>
      <SetViewportContext.Provider value={setViewport}>
        {children}
      </SetViewportContext.Provider>
    </ViewportContext.Provider>
  )
}

/** Read the viewport from anywhere */
export const useViewport = () => {
  const ctx = useContext(ViewportContext);
  if (!ctx) throw Error("Not wrapped in <ViewportProvider />.")
  return ctx;
}

/** Update the viewport from anywhere */
export const useSetViewport = () => {
  const ctx = useContext(SetViewportContext);
  if (!ctx) throw Error("Not wrapped in <ViewportProvider />.")
  return ctx;
}
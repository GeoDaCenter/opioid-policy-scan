import { useDispatch, useSelector } from "react-redux";
import { useState, useRef } from "react";
import styles from "./VariablePanel.module.css";

import TextField from "@mui/material/TextField";
import Autocomplete from "@mui/material/Autocomplete";

import { Gutter } from "../layout/Gutter";
import RemoteMarkdownModal from "@components/markdown/RemoteMarkdownModal";
import { Box, Button, Modal, Typography } from "@mui/material";

const themeCategories = [
  "Policy",
  "Health",
  "Demographic",
  "Economic",
  "Physical Environment",
  "COVID-19",
];

const modalStyle = {
  position: 'fixed',
  top: '20%',
  left: '50%',
  transform: 'translate(-50%,-50%)',
  width: 'clamp(300px, 600px, 100%)',
  background: 'white',
  padding: '1em'
  // width:'clamp(300px, 600px, 100%)',
}

export default function VariablePanel(props) {
  const dataParams = useSelector((state) => state.dataParams);
  const currentData = useSelector((state) => state.currentData);
  const dataPresets = useSelector((state) => state.dataPresets);
  const [activeThemes, setActiveThemes] = useState([])
  const autocompleteRef = useRef(null);

  const toggleTheme = (theme) => {
    setActiveThemes(activeThemes => {
      if (activeThemes.includes(theme)) {
        return activeThemes.filter((t) => t !== theme);
      } else {
        return [...activeThemes, theme];
      }
    })
  }

  const [activeDocs, setActiveDocs] = useState("");
  const [modalOpen, setModalOpen] = useState(false);
  const toggleModal = () => {
    setModalOpen(prev => !prev)
  }
  const dispatch = useDispatch();
  console.log(dataPresets.variables, activeThemes)
  return (
    <>
      <div
        className={
          styles.panelContainer +
          " " +
          (props.open ? styles.open : styles.hidden)
        }
      >
        <Typography variant="h5" sx={{ py: 0, my: 0 }} fontWeight="bold">
          {dataParams.variable}

          <Button onClick={toggleModal} variant="contained" sx={{ margin: '0 .5em', minWidth: '2em', backgroundColor: 'var(--selected-color)' }}>
            <img style={{ maxHeight: '1.25em' }} alt="Search for variables" src="/images/search.svg" />
          </Button>
        </Typography>
        <Modal
          open={modalOpen}
          onClose={toggleModal}
        >
          <Box sx={modalStyle}>
            <Typography variant="h5">
              Search for variables
            </Typography>
            <Gutter em={.5}/>
            
            <Typography variant="h6">
              Toggle Themes
            </Typography>
              {themeCategories.map((cat, i) => 
                <Button 
                  key={i} 
                  variant={activeThemes.includes(cat) ? 'contained' : 'outlined'} 
                  onClick={() => toggleTheme(cat)}
                  sx={{margin:'.25em', textTransform:'none'}}
                  >
                    {cat}
                  </Button>)}
                  <Gutter em={.5}/>
            <Autocomplete
              disablePortal
              open={true}
              ref={autocompleteRef}
              id="combo-box-demo"
              options={activeThemes.length ? dataPresets.variables.filter(f => activeThemes.includes(f.theme)) : dataPresets.variables}
              getOptionLabel={(option) => option.variable}
              groupBy={(option) => option.theme}
              // sx={{ width: 300 }}
              fullWidth
              renderInput={(params) => <TextField {...params} label="Type to search" />}
              onChange={(_event, option) => {
                if (option != undefined && option.variable != undefined) {
                  dispatch({ type: "CHANGE_VARIABLE", payload: option.variable });
                  toggleModal()
                }
              }}
            />
          </Box>
        </Modal>
        {dataPresets.data.length > 1 && (
          <>
            <Gutter em={1} />
            <p>Available Geographies</p>
            {dataPresets.data.map((entry) => (
              <button
                onClick={() =>
                  dispatch({ type: "CHANGE_DATASET", payload: entry.geodata })
                }
                key={`geography-list-${entry.geodata}`}
                disabled={
                  !(
                    dataParams.numerator in entry.tables ||
                    dataParams.numerator === "properties"
                  ) || currentData === entry.geodata
                }
                className={`${styles.pillButton} ${currentData === entry.geodata && styles.activeButton
                  }`}
              >
                {entry.name.split('US ')[1]}
              </button>
            ))}
          </>
        )}
        <Gutter em={1} />
        {/* {dataParams.numerator ? (
          <button
            className={styles.readMoreButton}
            onClick={() =>
              setActiveDocs(
                `https://raw.githubusercontent.com/GeoDaCenter/opioid-policy-scan/master/data_final/metadata/${
                  variables[activeTheme].find((f) =>
                    f.markdownPrefix.includes(
                      dataParams.numerator.split("_")[0]
                    )
                  ).markdown
                }.md`
              )
            }
          >
            Read more about this data
            <br />
            Dataset: <code>{dataParams.numerator.split("_")[0]}</code>
            <br />
            Column: <code>{dataParams.nProperty}</code>
          </button>
        ) : null}
        {dataParams.denominator ? (
          <button
            className={styles.readMoreButton}
            onClick={() =>
              setActiveDocs(
                `https://raw.githubusercontent.com/GeoDaCenter/opioid-policy-scan/master/data_final/metadata/${
                  variables[activeTheme].find((f) =>
                    f.markdownPrefix.includes(
                      dataParams.numerator.split("_")[0]
                    )
                  ).markdown
                }.md`
              )
            }
          >
            Read more about this data
            <br />
            Dataset: <code>{dataParams.denominator.split("_")[0]}</code>
            <br />
            Column: <code>{dataParams.dProperty}</code>
          </button>
        ) : null} */}
      </div>
      {activeDocs.length ? (
        <RemoteMarkdownModal
          url={activeDocs}
          reset={() => setActiveDocs(false)}
        />
      ) : null}
    </>
  );
}

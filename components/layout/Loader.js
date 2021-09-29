import PropTypes from "prop-types";
import styles from "./Loader.module.css";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faSpinner } from "@fortawesome/free-solid-svg-icons";

function Loader(props){
    return (
        <div className={`${styles.shade} ${props.displayShade ? "dimmed " : ""}`}>
            {props.globe 
                ? <img src="images/globe_min.svg" alt="" style={{width:'150px', height:'150px'}}/>
                : <FontAwesomeIcon icon={faSpinner} className={styles.spinner} />
            }
        </div>
    );
}

Loader.propTypes = {
    displayShade: PropTypes.bool,
    globe: PropTypes.bool
};
Loader.defaultProps = {
    displayShade: true,
    globe: false
};

export default Loader;
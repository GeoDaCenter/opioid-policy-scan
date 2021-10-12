import { useSelector } from "react-redux";
import styles from './FixedChart.module.css';
import HistogramWidget from "./widgets/HistogramWidget";

export default function FixedChart(props){
    const currentVariable = useSelector((state) => state.dataParams.variable);
    const currentData = useSelector((state) => state.currentData);
    return <div className={styles.fixedChart}>
        <HistogramWidget
            variable={currentVariable}
            options={{}}
            config={{
                variable: currentVariable,
            }}
            dataset={currentData}
        />
    </div>
}
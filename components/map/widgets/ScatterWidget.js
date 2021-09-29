import React from 'react';
import PropTypes from 'prop-types';
// import styles from './Widgets.module.css';
import {Scatter} from 'react-chartjs-2';

function ScatterWidgetUnwrapped(props) {
  const dataProp = {
    datasets: [
      {
        label: props.options.header,
        data: props.data,
        backgroundColor: props.options.foregroundColor
      }
    ]
  };

  const options = {
    maintainAspectRatio: false,
    animation: false,
    elements: {
      point: {
        radius: 1
      }
    },
    plugins: {
      legend: {
        display: false
      },
      tooltip: {
        callbacks: {
          label: (tooltipItem) => {
            const point = props.data[tooltipItem.dataIndex];
            return `${point.id} (${point.x}, ${point.y})`;
          }
        }
      }
    }
  };

  return (
    <div style={{height: "90%"}}>
      <Scatter data={dataProp} options={options} />
    </div>
  );
}

ScatterWidgetUnwrapped.propTypes = {
  options: PropTypes.object.isRequired,
  data: PropTypes.object.isRequired
};

const ScatterWidget = React.memo(ScatterWidgetUnwrapped);

export default ScatterWidget;
import React from 'react';
import PropTypes from 'prop-types';
// import styles from './Widgets.module.css';
import {BarChart, ResponsiveContainer, Bar, XAxis, YAxis, CartesianGrid, Tooltip} from 'recharts'; // Cell, Legend
// import { bin } from "d3-array";

function HistogramWidget(props) {
  
  return (
    <ResponsiveContainer height="90%">
      <BarChart data={props.data}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="name" />
        <YAxis />
        <Tooltip />
        <Bar dataKey="val" name={props.options.yAxisLabel} fill={props.options.foregroundColor} isAnimationActive={false} />
      </BarChart>
    </ResponsiveContainer>
  );
}

HistogramWidget.propTypes = {
  options: PropTypes.object.isRequired,
  data: PropTypes.object.isRequired
};

export default HistogramWidget;
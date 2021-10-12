import { useMemo } from 'react';
import useGetTimeSeriesData from "./useGetTimeSeriesData";
import dayjs from 'dayjs';

const formatData = (data, options) => {
    let formattedData = [];
    let labels = [];

    if (!data.length) {
        return {
            labels, 
            formattedData
        }
    }

    for (let i=0; i<data.length; i++) {
        formattedData.push(data[i].value)
        labels.push(dayjs(data[i].date).format(options.dateFormat || "YYYY-MM-DD"))
    }
    return {
        formattedData,
        labels
    };
}

const formatChart = (formattedData, labels, options, variable) => {
    return {
        chartData: {
            labels,
            datasets: [{
                    label: options.header || variable,
                    data: formattedData,
                    backgroundColor: options.foregroundColor || "#000000"
                }]
        },
        chartOptions: {
            maintainAspectRatio: false,
            animation: false,
            elements: {
                point: {
                    radius: options.pointSize || 1
                }
            },
            scales: {
                x: {
                    title: {
                        display: "xAxisLabel" in options,
                        text: options.xAxisLabel || ""
                    }
                },
                y: {
                    title: {
                        display: "yAxisLabel" in options,
                        text: options.yAxisLabel || ""
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    }
}

export default function useGetLineChartData({
    variable=false,
    dataset=false,
    options={}
}){
    const data = useGetTimeSeriesData({
        variable,
        dataset
    })

    const {
        formattedData,
        labels
    } = useMemo(() => formatData(data, options), [data, options]);

    const {
        chartData, 
        chartOptions
    } = useMemo(() => formatChart(formattedData, labels, options, variable),
    [data.length, variable, dataset, JSON.stringify(options)]);
      
    return {
        chartData,
        chartOptions
    }
}
---
title: Creating Widgets
index: 7
---

Vector comes with a set of built-in widgets for common performance metrics. PCP also exposes several metrics that are not immediately accessible through Vector, and can be extended using Performance Metric Domain Agents, or [PMDA](http://pcp.io/man/man3/pmda.3.html). In order to get access to these metrics, you could use the [Custom Metric Widget](/docs/custom-widget.html), or create a new widget that pulls one or more metrics from PCP.

In order to create a new widget, a new defintion needs to be added to Vector's source code, and a new build generated. Right now, there's no pluggable way of defining new widgets. See issue [#115](https://github.com/Netflix/vector/issues/115) for more details.

Widgets are defined in the _widget_ component, under the `definitions` array, in the `app/components/widget/widget.factory.js` file. Here's a sample definition:

```javascript
{
    name: 'kernel.all.load', // Name of the widget. An unique name that will be used to reference the widget within the application.
    title: 'Load Average', // Widget title that will be displayed in the widget title bar.
    directive: 'line-time-series', // The widget's directive, or template, in Angular's dash notation. e.g.: lineTimeSeries in this case.
    dataAttrName: 'data', // Widget data property name. This should always be "data".
    dataModelType: MetricDataModel, // The widget data model. See the "Data Model" section below for more details.
    dataModelOptions: { // Options that will be passed to the data model.
        name: 'kernel.all.load'
    },
    size: { // Default size for the widget.
        width: '25%',
        height: '250px'
    },
    enableVerticalResize: false, // Allow vertical resize of the widget.
    group: "Kernel" // Group which the widget belongs to. This will define where the widget link will be added in the "Widget" drop down menu.
}
```

### Data Model

Data models are, in a nutshell, objects that control the metrics required for each widget and how the values are used in it. Data model prototypes are relatively simple. They extend a base WidgetDataModel prototype and define their own init and destroy functions. Most of what is done in those functions is adding and removing metrics from the metric poller list, creating callback functions that deal with the data points returned from the poller itself, and referencing the right data structure to be used in the charts.

More details about the Data Model implementation can be found in the _angular-dashboard_ documentation:

[github.com/DataTorrent/malhar-angular-dashboard](https://github.com/DataTorrent/malhar-angular-dashboard#datamodeltype)

Examples can be found in the _datamodel_ component:

[src/app/components/datamodel](https://github.com/Netflix/vector/tree/master/src/app/components/datamodel)

#### Generic Data Models

In order to simplify the process of creating new widgets, a set of generic data models are available, and can be used on new widget definitions, without the need to create a specific data model for it.

* **MetricDataModel**. Polls a single metric and stores the value in a D3 compatible time series data structure.
* **CumulativeMetricDataModel**. Same as MetricDataModel, but applies a commulative function to the value.
* **CumulativeUtilizationMetricDataModel**. Same as CumulativeMetricDataModel, but applies a normalization function to the value.
* **ConvertedMetricDataModel**. Same as MetricDataModel, but applies a conversion function to the value.
* **MultipleMetricDataModel**. Same as MetricDataModel, but accepts multiple metrics and combines the values into a single data structure.
* **MultipleCumulativeMetricDataModel**. Same as CumulativeMetricDataModel, but accepts multiple metrics and combines the values into a single data structure.

The source code can be found at:

[src/app/components/datamodel](https://github.com/Netflix/vector/tree/master/src/app/components/datamodel)

### Directives/Templates

With the exception of the flame graph widgets, all Vector widgets use one of two directives, `line-time-series` or `area-stacked-time-series`. The first displaying a simple line chart, and the second, a stacked area chart. These two directives should cover most use cases, but you are free create your own.

The source code for the directives and templates can be found at:

[src/app/components/chart](https://github.com/Netflix/vector/tree/master/src/app/components/chart)
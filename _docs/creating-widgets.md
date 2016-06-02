---
title: Creating Widgets
index: 7
---

### Simple Widgets

Here is a simple example of how to create a new widget based on an existing data model.

Just append this to the definitions array under `app/components/widget/widget.factory.js`.

```javascript
{
    name: 'nfs4.client',
    title: 'NFS4',
    directive: 'line-integer-time-series',
    dataAttrName: 'data',
    dataModelType: MultipleCumulativeMetricTimeSeriesDataModel,
    dataModelOptions: {
        name: 'nfs4.client',
        metricDefinitions: {
            "calls": "nfs4.client.calls",
            "reqs": "nfs4.client.reqs"
        }
    },
    size: {
        width: '25%',
        height: '250px'
    },
    enableVerticalResize: false,
    group: "NFS4"
}
```

This polls the nfs4.client metric, assuming a cumulative value and reusing the MultipleCumulativeMetricTimeSeriesDataModel data model.

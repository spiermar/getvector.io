---
title: Creating Widgets
index: 7
---

Vector comes with a set of built-in widgets for common performance metrics. PCP also exposes many metrics that are not configured by default through Vector. PCP can also be extended using Performance Metric Domain Agents, or [PMDAs](http://pcp.io/man/man3/pmda.3.html). In order to get access to these metrics, you could use the [Custom Metric Widget](/docs/custom-widget.html), or create a new widget that pulls one or more metrics from PCP.

In order to create a new widget, a new defintion needs to be added to Vector's source code, and a new build generated. Right now, there's no pluggable way of defining new widgets. See issue [#115](https://github.com/Netflix/vector/issues/115) for more details.

Widgets are defined in the `src/app/charts/` location. Files found here are automatically loaded (see `index.js` for implementation).

To create a new menu and a new widget, the easiest approach is to look at an existing widget and copy its structure to proceed.

We will start with a simple existing example: the Runnable processes count, under the CPU column:

```javascript
  {
    chartId: 'cpu-runnable',       // each chart should have a unique chartId
    group: 'CPU',                  // defines the column which widgets will be grouped in the custom dashboard
    title: 'Runnable',             // title of the widget
    processor: simpleModel,        // the data model processor, most implementations will be simpleModel
    visualisation: Chart,          // defines the type of visualisation
    metricNames: [
      'kernel.all.runnable',
    ],
    transforms: [
      defaultTitleAndKeylabel(),
    ],
    yTickFormat: integer,
  }
```

### Metric Names

The PCP metric names that will be fetched by the simpleModel. This will match with PCP and your PMDA. You can see a sample list by inspecting the Custom Chart dropdown to search and identify a metric name. Vector will take care of fetching these metrics at regular intervals and applying the required processor to your data.

### Processor

Generally, this will be `simpleModel`. SimpleModel applies a pipeline of transforms to the input data for each render.

Other models can be built or are available, such as the custom chart and table models. Since the transform pipelines for custom charts are dynamic and must be calculated at runtime, the custom models handle this.

### Transforms

Transforms are generally the most complex part of the widget render pipeline. They can be as simple or as complex as needed in order to transform the PMDA provided raw data into something suitable for the visualisation engine.

A transform is a simple function that is applied to data. By chaining a series of these, complex behaviour can be achieved.

The available provided transforms are provided in the `src/app/processors/transforms.js` source code, and the comments explain their use. We will see a more complex example below.

### Visualisations

Data can be visualised in different ways. The transform pipeline needs to get the data ready for render. Sorry, but this is not clearly documented yet, you will need to inspect the code.
* Chart: a regular line or area chart, with time on the X axis and values on the Y.
* SimpleTable: a simple single-series data table
* MultiTable: a multi-column data table
* TextLabel: can be used to place a text label onto a dashboard
* Flamegraph: Used for triggering flamegraphs using the Vector PMDA; you can use this as an example to creating more interactive widgets.

### More complex examples

Here we have an example of a load average table, where we want to only render the most recent values, into a SimpleTable visualisation.
```javascript
  {
    chartId: 'cpu-loadavg-table',
    group: 'CPU',
    title: 'Load Average (table)',
    processor: simpleModel,
    visualisation: SimpleTable,
    metricNames: [
      'kernel.all.load',
    ],
    transforms: [
      defaultTitleAndKeylabel(),
      onlyLatestValues(),
    ],
    yTickFormat: number,
  },
```

For per container memory usage, we only need to fetch a single metric, but to make it usable we need to massage the data a little:
```javascript
    {
      chartId: 'container-percont-mem',
      group: 'Container',
      title: 'Per-Container Memory Usage (Mb)',
      processor: simpleModel,
      visualisation: Chart,

      // fetch cgroup.memory.usage metric
      // this fetches data for ALL containers on a host, so
      // we need to filter it later
      metricNames: [
        'cgroup.memory.usage',
      ],

      transforms: [
        // map the instance ids that pcp provides to a container
        // name
        mapInstanceDomains(),

        // now map a container name, in the cgroup.memory.usage
        // metric, applied over our container name resolver
        // so that the names are human friendly
        mapContainerNames(
            [ 'cgroup.memory.usage' ], containerNameResolver),

        // filter for container id - in case a container is
        // selected, we need to apply the filter so that only the
        // data is shown
        filterForContainerId([ 'cgroup.memory.usage' ]),
        
        // apply a title and key label so it makes sense
        defaultTitleAndKeylabel(),

        // we need bytes -> mb, which is the same ratio as
        // kb -> gb, so we borrow it
        kbToGb(),
      ],
      yTickFormat: integer,
    },
```

And now for a 10/10 complexity chart. We want to calculate the total usage of all containers, and separate that from host usage and show them both separately. Some data is in different units and we need to aggregate across multiple chart metrics.

This requires an understanding of the PCP data model. In PCP when you collect a metric, it will come back as a group of 'metric instances', for example if you read disk I/O and there are 5 disks, there will be 1 metric, with 5 instances, one per disk. If the concept of an 'instance' does not make sense in a given context, such as 'memory free' the instance is provided as -1. We need to use this knowledge to shuffle the data around and achieve what we need to.

Using `timesliceCalculations` is the most powerful transform available as it allows you to rename metrics, perform logic, branches, etc. However, that makes it a bit slower than other transforms, so if you find yourself using too much cleverness you might like to break it out to a custom transform step.
```javascript
    {
      chartId: 'container-total-cont-mem',
      group: 'Container',
      title: 'Total Container Memory Usage (Mb)',
      processor: simpleModel,
      visualisation: Chart,
      lineType: 'stackedarea',
      metricNames: [
        'cgroup.memory.usage', // in bytes, one per container
        'mem.util.used',       // in KB, one value for total host
        'mem.util.free',       // in KB, one value for total host
      ],
      transforms: [
        // apply cgroup name transforms in case we are looking at
        // only a single container
        mapInstanceDomains(),
        mapContainerNames([ 'cgroup.memory.usage' ],
            containerNameResolver),

        // we want to add up all the values for cgroup.memory
        // .usage across all metric instances to collapse the
        // multiple cgroup.memory.usage instances to a single
        // instance, we make sure they all share the same title
        // and then add them
        customTitleAndKeylabel(metric => metric),
        combineValuesByTitle((a, b) => a + b),

        // now we need to perform some simple normalisation to MB
        divideByOnlyMetric(1024,
            [ 'mem.util.used', 'mem.util.free' ]),
        divideByOnlyMetric(1024*1024, [ 'cgroup.memory.usage' ]),

        // now calculate the values: store them all in the -1
        // index (no context):
        // container used => result from combining cgroup.memory
        //                   .usage, use only the first value
        // free (unused) => mem.util.free instance, -1 since 
        //                  no instance context
        // host used => mem.util.used LESS what was used by
        //              all containers
        timesliceCalculations({
          'host used': (values) => ({ '-1': 
              values['mem.util.used']['-1'] -
              firstValueInObject(values['cgroup.memory.usage'])
          }),
          'free (unused)': (values) => ({ '-1':
              values['mem.util.free']['-1']
          }),
          'container used': (values) => ({ '-1':
              firstValueInObject(values['cgroup.memory.usage'])
          }),
        }),

        // add back a title and keylabel
        defaultTitleAndKeylabel(),
      ],
      yTickFormat: integer,
    },

```

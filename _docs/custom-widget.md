---
title: Custom Widget
index: 11
---

### Custom Widget

Apart from adding widgets to widget definitions for permanent use, widgets can be temporarily added to the dashboard using a simple GUI.

You can enable the GUI feature by changing the constant `enableCustomWidgetFeature` to `true` in the file `/src/app/config.js` and rebuilding.

Once enabled follow these steps to add a custom widget with a metric on the dashboard.

* Open the Dashboard dropdown, and select _Custom chart_ or _Custom table_ under the _Custom_ section. This will add a new chart panel to your dash.
* Click the cog icon to open the settings panel for the widget.

Note: If you refresh, your custom widget will be present but you will need to reconfigure it.

* In the field _Select Metric_, type the name of the metric and press return.
* Select from the following options to customise the view:
** Stacked Area - is the chart an area or line chart. (This is ignored for a table).
** Cumulative - is the data source cumulative over time (such as total bytes written) or non-cumulative (such as load average).
** Converted - provide a javascript conversion function to convert the format (eg multiply by 1024)
** Format - customise the Y axis formatting. (This is ignored for a table).
* Once all the options are set as needed, click on OK button to start collecting data.

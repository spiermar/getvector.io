---
title: Custom Widget
index: 11
---

### Custom Widget

Apart from adding widgets to widget definitions for permanent use, widgets can be temporarily added to the dashboard using a simple GUI.

You can enable the GUI feature by changing the constant `enableCustomWidgetFeature` to `true` in the file `app/index.config.js`.

Once enabled follow these steps to add a custom widget with a metric on the dashboard.

**Caution:** The dashboard will reload as soon as you add a custom widget, so prevailing data will be lost.

* Open the widget dropdown, and select _Ad-Hoc Metric_. This will open up a modal window to add a Custom Widget.
* In the field _Select Metric_, type the name of the metric and press return.
*  If the metric is cumulative, the checkbox will be auto-ticked. You can change it to cumulative or non-cumulative as per your choice.
*  Advanced Options for further customizations are given under _Advanced Options_. And a few UI changes can be made by using the _UI Options_.
* Once all the options are set as needed, click on Add button to add the custom widget to the dashboard.

You can add as many custom widgets needed, they will appear under Widgets dropdown under the _Custom_ tag.
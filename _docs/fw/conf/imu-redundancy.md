---
conf: IMU/Sensors
title: Sensors redundancy
---

>Configuration: `IMU/Sensors`
> | Nodes: [`nav`](../../hw/nodes/nav.md)

This section configures the fusion priorities of different sensors of the same kind,
installed in one node. For example, if the board have two different gyro sensors,
you may setup which one to use as *primary* source for local data.

There is still another redundancy level present, related to data sources from different
physical nodes, specified in `prio` setting of the corresponding sensor configuration group.

After changing the sensor source, it is usually required to adjust corresponding
tuning values (bias, hard-iron calibration, etc.)
---
conf: Airspeed
title: Airspeed sensor
---

>Configuration: `Airspeed`
> | Nodes: [`cas`](../../hw/nodes/cas.md) [`xhawk`](../../hw/nodes/xhawk.md)

Dynamic pressure sensor estimates airspeed from pressure readings.

- **pt**        - this setting enables the driver
    - *off* - the pressure sensor is powered off and there's no data output
    - *airspeed* - the sensor provides airspeed fixes for autopilot, the output is sent through variables `*airspeed*`.
    - *buoyancy* - the sensor provides filtered pressure measurements and the data is sent to variable `*buoyancy*` [Pa]. this option is used mainly for Blimps.
- **prio**      - redundancy priority for sensor.
    - *primary*   - data will be used when available.
    - *secondary* - data will be used when *primary* is unavailable.
    - *low*       - level3 priority, used when *primary* and *secondary* is unavailable.
    - *safety*    - used when no other sources are available.
- **kalman**    - filter settings for data (Q=0.05, R=30)
- **calib**     - calibration mode
    - *auto* - the zero bias will be estimated on power on
    - *fixed* - the zero bias is set up in `bias` setting
- **bias**      - the bias value, used for *fixed* calibration mode.

The use of *fixed* calibration mode is strongly recommended. To perform the calibration, follow these steps:

- change the `calib` setting to *auto*
- reboot device
- execute node command `Recalibrate differential sensor`
- reload nodes configuration values on GCU to refresh data
- change the `calib` setting to *fixed*

*** Pre-flight check should always include Airspeed sensor test.**
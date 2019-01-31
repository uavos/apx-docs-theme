---
conf: Altimeter
title: Altimeter
---

>Configuration: `Altimeter`
> | Nodes: [`xhawk`](../../hw/nodes/xhawk.md) [`ers`](../../hw/nodes/ers.md) [`nav`](../../hw/nodes/nav.md) [`cas`](../../hw/nodes/cas.md)

Static pressure sensor estimates altitude from pressure readings.

- **ps**        - this setting enables the driver
    - *off* - the static pressure sensor is powered off and there's no data output
    - *altimeter* - the sensor provides altitude and vertical speed fixes for autopilot, the output is sent through variables `altps` and `vario`.
    - *meteo* - the sensor provides altitude for ground control, and the output is sent through variable `altitude`.
- **prio**      - redundancy priority for sensor.
    - *primary*   - data will be used when available.
    - *secondary* - data will be used when *primary* is unavailable.
    - *low*       - level3 priority, used when *primary* and *secondary* is unavailable.
    - *safety*    - used when no other sources are available.
- **AT** - the sensor will update the variable `AT` (ambient temperature) with the temperature of the sensor itself. This is used on small UAVs where the outside temperature sensor is not available.
- **tbaro** - the altitude estimator will use the ambient temperature from the variable `AT` to compensate the air density. **Note**, this setting should be turned off if you don't have the outside air temperature sensor.
- **kalman** - filter settings for altitude estimations (Q=0.5, R=20 for AP10)
- **kvfs** - filter settings for vertical speed estimations (normally is off =0)

To estimate real noise of the sensor, you may need to **temporally** setup [AHRS](ahrs.md) as follows:

- **AHRS/hGPS** = `baro`
- **AHRS/fbar** = `none`

The raw pressure readings will be shown in `altitude` and `vspeed` variables.

On normal operation, the output of the sensor is filtered through [AHRS](ahrs.md) subsystem to provide high precision estimates.
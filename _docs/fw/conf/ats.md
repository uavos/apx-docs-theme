---
conf: ATS
title: Antenna Tracking System
---

>Configuration: `ATS`
> | Nodes: [`mhx`](../../hw/nodes/mhx.md)

This feature controls servo motors to point directional antenna to currently selected UAV. this driver works together with [Datalink](#datalink) protocol to track selected vehicle and its coordinates.

To estimate the direction, where to point the antenna, this feature uses different sources of information, depending of its availability in the following order:

- built-in [GPS receiver](/hw/nodes/gps.md), connected to local CAN bus
- Magnetometer, present on gps module (above) to know its current direction
- currently selected vehicle **home position**, aquired from datastream variables `*home_lat*`, `*home_lon*`, `*home_hmsl*`
- [encoder readings](#encoder-interface) from servo motors, when the `hdg` setting is fixed (*north*)

The following parameters tune ATS behavior:

- **mode** - current mode of operation:
    - *off* - the subsystem is off.
    - *gps* - will track the vehicle direction, based on GPS coordinates of *home* and *vehicle*.
    - *RSS* - will track the heading, based on received signal strength indication from modem.
- **hdg** - the source of current antenna heading estimation:
    - *mag* - will use built-in magnetometer (usually provided by GPS node)
    - *north* - will use local encoder values from variable `*yaw*`. The encoder `bind` setting should be set to this variable.
- **hbias** - antenna heading bias, used to correct antenna alignment with the current ATS yaw.
- **timeout** - this feature enables the automatic *search* of vehicle when theres's no data available for more than specified time period.
- **debug** - used to get telemetry from the ATS for debugging purposes. This option should be turned off for normal operation.


The [motors](#servo) should be tuned to maintain the speed `*atsctr_yaw*`, `*atsctr_pitch*` and output encoder values in `*atsenc_yaw*`, `*atsenc_pitch*`.

The ATS is tracking the currently selected in GCU and active vehicle, based on its *downstream* telemetry data.
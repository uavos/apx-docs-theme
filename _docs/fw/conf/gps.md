---
conf: GPS
title: GPS Receiver
---

>Configuration: `GPS`
> | Nodes: [`gps`](../../hw/nodes/gps.md) [`xhawk`](../../hw/nodes/xhawk.md)

This feature provides [U-Blox](http://ublox.com) GNSS module management. The driver provides data for autopilot's AHRS system, reports some statistics (used/visible satellites), and synchronizes the time with *GPS Time*.

- **gps**       - current receiver mode of operation:
    - *no* - the receiver power is off
    - *yes* - normal operation, send position and velocity fixes to the autopilot
    - *debug* - print ublox debug messages in the console (for development)
- **prio**      - redundancy priority for sensor.
    - *primary*   - data will be used when available.
    - *secondary* - data will be used when *primary* is unavailable.
    - *low*       - level3 priority, used when *primary* and *secondary* is unavailable.
    - *safety*    - used when no other sources are available.
- **model** - the physical model setting (normally - *Aurborne4g*)
- **Jamming** - the anti-jamming feature tuning of the ublox module
    - **itfm** - on/off control of this feature
    - **bb** - broadband threshold [dB] (default=3)
    - **cw** - continuous wave threshold [dB] (default=15)
    - **aux** - scan auxilary bands [yes/no]


The node supports the command `Report satellites info` which outputs current radio channels signal levels. It also measures noise, when the option `itfm` is on.
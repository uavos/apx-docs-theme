---
conf: mhx/function
title: Modem function
---

>Configuration: `mhx/function`
> | Nodes: [`mhx`](../../hw/nodes/mhx.md)

The [modem](../../hw/nodes/mhx.md) node could be configured for different roles:

- **onboard** - radio modem for telemetry, installed onboard
- **gcu** - radio modem for telemetry, connected to Ground Control
- **autopilot** - full function autopilot and onboard modem. After turning on this function, the virtual node [`.shiva`](shiva.md) will be created, to provide AP configuration capability. This mode is useful when IMU is provided from [gps](../../hw/nodes/gps.md) unit and the whole system configuration could be as simple as [mhx](../../hw/nodes/mhx.md) + [cas](../../hw/nodes/cas.md) + [gps](../../hw/nodes/gps.md).
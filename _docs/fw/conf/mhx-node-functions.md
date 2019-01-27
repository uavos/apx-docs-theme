---
title: MHX Node functions
---

### `mhx/function`

This [node](/hw/nodes/mhx.md) could be configured for different functionality.

- **onboard** - radio modem for telemetry and uplink, installed onboard
- **gcu** - radio modem for telemetry and uplink on the ground
- **autopilot** - full function autopilot and onboard modem. After turning on this function, the virtual node .shiva will be created, to provide AP configuration capability. This mode is useful when IMU is provided from [gps](/hw/nodes/gps.md) unit and the whole configuration could be as simple as [mhx](/hw/nodes/mhx.md) + [cas](/hw/nodes/cas.md) + [gps](/hw/nodes/gps.md).

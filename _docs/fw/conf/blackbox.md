---
conf: Blackbox
title: Onboard data recorder
---

>Configuration: `Blackbox`
> | Nodes: [`nav`](../../hw/nodes/nav.md)

This section configures the onboard flight data recorder. Once enabled, it records telemetry stream to internal non-volatile memory. Data download capability is also provided through high-speed interface from nodes configuration menu and service commands.

Configuration parameters:

- **blackbox**  - enable/disable recording:
    - *off*         - no data will be recorded
    - *full*        - all network stream will be recorded
    - *downstream*  - only data sent to ground will be recorded
- **reset**     - controls the automatic memory erase behavior:
    - *auto*        - data erased in `TAKEOFF` mode phase `Start`
    - *manual*      - data erased manually by user command

The recorded data can be read or erased by using GCU menu on specific node. During read procedure, the telemetry file will be created with all read data.
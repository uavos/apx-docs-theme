---
conf: .shiva
title: Autopilot controls
---

>Configuration: `.shiva`
> | Nodes: [`ifc`](../../hw/nodes/ifc.md) [`nav`](../../hw/nodes/nav.md) [`ghanta`](../../hw/nodes/ghanta.md) [`mhx`](../../hw/nodes/mhx.md) [`xhawk`](../../hw/nodes/xhawk.md)

Autopilot capability. Processes PIDs and control algorithms for the vehicle. The settings are available in dedicated *virtual node* named as `<node>.shiva`.

This feature allows `node` to act as redundant autopilot if more than one physical device with such feature exist in the system network.
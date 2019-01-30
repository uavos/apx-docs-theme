---
conf: .shiva
title: Autopilot controls
---

>Configuration: `.shiva`
> | Nodes: [`mhx`](../../hw/nodes/mhx.md) [`ifc`](../../hw/nodes/ifc.md) [`xhawk`](../../hw/nodes/xhawk.md) [`ghanta`](../../hw/nodes/ghanta.md) [`nav`](../../hw/nodes/nav.md)

Autopilot capability. Processes PIDs and control algorithms for the vehicle. The settings are available in dedicated *virtual node* named as `<node>.shiva`.

This feature allows `node` to act as redundant autopilot if more than one physical device with such feature exist in the system network.
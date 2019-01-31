---
conf: CANaerospace
title: CANaerospace
---

>Configuration: `CANaerospace`
> | Nodes: [`servo`](../../hw/nodes/servo.md) [`cas`](../../hw/nodes/cas.md) [`ers`](../../hw/nodes/ers.md)

This feature provides support for [CANaerospace](https://en.wikipedia.org/wiki/CANaerospace) protocol.

For physical layer, this protocol uses the same CAN bus as AP system (not virtual port), i.e.
both system bus and CANas can operate simulaneously, because CANas uses IDE=0, but AP uses extended CAN messages.

Please, refer to protocol [documentation](http://www.stockflightsystems.com/canaerospace.html) for more details.
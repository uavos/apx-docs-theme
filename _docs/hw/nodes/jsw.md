---
badge: jsw
order: 160
title: HID controller
---

This device is used to build Ground Control interface panels with joysticks, buttons, etc. It connects ground [modem](mhx.md) with human controls hardware (buttons, displays, joysticks, handles etc.) and can control UAV in case the main PC with [Ground Control](../../gcs) software is failed.

## Node Features

- Digital inputs/outputs for keyboards and buttons
- Analog inputs
- Quadrature encoder interfaces
- Serial and USB ports

#### System features

- Industrial [CAN](https://en.wikipedia.org/wiki/CAN_bus) interface
- Extended temperature range -40..+80°C
- 4.5V...30V input power supply
- Power supply reverse-polarity protection (self-recoverable)

## Capabilities

- [Analog inputs](../../fw/conf/ain.md)
- [Auxilary CAN](../../fw/conf/can2.md)
- [Downlink](../../fw/conf/downlink.md)
- [Ports and controls](../../fw/conf/ports.md)
- [Power monitor](../../fw/conf/imon.md)
- [USB Interface](../../fw/conf/usb.md)
- [Virtual Machine](../../fw/conf/vm.md)

## PCB Pinouts

- [jsw-RS1](pinouts/jsw-RS1.PDF)

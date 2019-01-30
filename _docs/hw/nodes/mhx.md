---
badge: mhx
order: 20
title: Datalink Radio Modem
---

The telemetry data and command line is tranferred to the GCU through this node.

The radio modem module used for data transmission between GCU and UAVs is [Microhard's 900/400MHz OEM radio modem](http://microhardcorp.com). The interface board has compact dimensions of the modem and is designed to provide power supply to the modem and to interface it to the CAN bus.

On the GCU side, the system uses the same modem hardware.


## Node Features

- 100 km LOS range
- 230 kbaud data rate
- 12x GPIO ports (3V)
- RS232, RS485, 2xCAN interfaces
- PC USB interface (USB powered)
- Bluetooth 4.0/BTLE radio

#### System features

- Industrial [CAN](https://en.wikipedia.org/wiki/CAN_bus) interface
- Extended temperature range -40..+80°C
- 4.5V...30V input power supply
- Power supply reverse-polarity protection (self-recoverable)

## Capabilities

- [Antenna Tracking System](../../fw/conf/ats.md)
- [Autopilot controls](../../fw/conf/shiva.md)
- [Auxilary CAN](../../fw/conf/can2.md)
- [Downlink](../../fw/conf/downlink.md)
- [Inertial Navigation](../../fw/conf/ahrs.md)
- [Modem function](../../fw/conf/mhx.md)
- [Ports and controls](../../fw/conf/ports.md)
- [Power monitor](../../fw/conf/imon.md)
- [Radio](../../fw/conf/radio.md)
- [Serial Ports](../../fw/conf/serial.md)
- [Serial Protocols](../../fw/conf/protocols.md)
- [USB Interface](../../fw/conf/usb.md)
- [Virtual Machine](../../fw/conf/vm.md)

## PCB Pinouts

- [mhx-AP10](pinouts/mhx-AP10.pdf)
- [mhx-AP9](pinouts/mhx-AP9.pdf)
- [mhx-AP9R1](pinouts/mhx-AP9R1.pdf)

---
title: Datalink Radio Modem (mhx)
---

The telemetry data and command line is tranferred to the GCU through this node.

The radio modem module used for data transmission between GCU and UAV is [Microhard's P400 - 900/400MHz OEM radio modem](http://microhardcorp.com). The interface board has compact dimensions of the modem and is designed to provide power supply to the modem and to interface it to the CAN bus.

On the GCU side, the system uses the same modem hardware.


## MHX Features

- 100 km LOS range
- 230 kbaud data rate
- 12x GPIO ports (3V)
- RS232, RS485, 2xCAN interfaces
- PC USB interface (USB powered)
- Bluetooth 4.0/BTLE radio

{% include_relative standard_features.md %}

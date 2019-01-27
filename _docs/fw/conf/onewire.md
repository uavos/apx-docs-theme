---
title: OneWire
---

This feature have ability to collect data from 1-wire sensors (temperature).

Once enabled `cnt`>0, the device enumerates 1-wire bus and detects connected sensors. If the number of recognized sensors on boot-up sequence is not equal to `cnt` - the device reports error and stops further processing.

Each temperature sensor could be binded to mandala variable in `bind` setting.

Some sensors provide CRC functionality to protect data from noise errors, this could be enabled in `crc` property.

---
title: Airspeed and pressure sensor (cas)
---

Airspeed Sensor - temperature compensated, high-accuracy sensor, connects to the pitot tube of the aircraft. This sensor is required for auto-landing and flights without GPS.

Altitude sensor is integrated with accelerometers and complexed by MEKF to achieve 1cm resolution and fast response for variometer.

Pitot Tube's heater control is equipped with ADC and power switch to stabilize the temperature.

![CAS](img/cas-pcb.png)

## CAS Features

- Pitot tube heater control circuit
- RS485 interface (NMEA, raw data)
- Temperature compensation (AT/RT)

{% include_relative standard_features.md %}

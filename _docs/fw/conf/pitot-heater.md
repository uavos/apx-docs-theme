---
title: Pitot heater
---

### `Heater`

This feature provides control of pitot probe heating.

- **heater**    - heater switch control type:
    - *off*       - the internal switch is turned off
    - *auto*      - turn on switch if the **MSL altitude** is higher than `altitude` setting
    - *force*     - switch is always turned on
- **temp_out**  - variable for pitot temperature output (for debugging and monitoring on GCU)
- **mult**      - multiplier for temperature (0= no multiplier) to adjust/recalibrate temperatre sensor
- **altitude**  - when mode is `auto` this sets the *absolute MSL altitude* [m] where to turn the swith on, the altitude is taken from `*altps*` variable
- **temp**      - target temperature to hold [C], usually set to 150C
- **ocp**       - overcurrent protection (shortcircuit), usually set to 10 [A], will report shortcircuit condition to the console
- **uvp**       - undervoltage protection (battery discharge), will turn off the switch if the voltage is below this value, common value is 7 [V]
- **pwm**       - when this value is set to non-zero, the switch will operate in PWM mode with ~50Hz frequency (used to decrease output power)

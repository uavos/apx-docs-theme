---
title: Analog inputs
---

This feature measures analog voltages (**up to 30V**) and updates the Mandala variables with configured `rate`.

Useful for battery voltage measurements.

Options:

- **rate** - variable update rate. Setting this option to *off* will disable the ADC
- **AINx** - analog channel mapping:
    - **bind** -  variable binding. The value of binded variable will be updated with measured voltage
    - **pga** -   Programmable Gain Amplifier. The analog input voltage range selector
    - **mux** -   Analog Channel Multiplexer:
        - *AIN12* - analog channels 1-2 as differential pair
        - *AIN14* - analog channels 1-4 as differential pair
        - *AIN24* - analog channels 2-4 as differential pair
        - *AIN34* - analog channels 3-4 as differential pair
        - *AIN1* - analog channel 1
        - *AIN2* - analog channel 2
        - *AIN3* - analog channel 3
        - *AIN4* - analog channel 4

---
conf: Encoder
title: Encoder interface
---

>Configuration: `Encoder`
> | Nodes: [`servo`](../../hw/nodes/servo.md)

This interface reads data from different encoders. Encoder measures position, calculates speed (derivative) and provides filtered values to [Servo Regulator](#servo-regulator). The output position value is normalized from -1 to +1.

The supported encoder types include:

- **mandala**   - the encoder values will be read from variables, binded through `bind` and `bindSpd` (optional)
- **analog**    - analog encoder (potentiometer)
- **QUAD**      - quadrature encoder
- **SPI16**     - SPI 16 bit
- **SPI13**     - SPI 13 bit
- **SPI12**     - SPI 12 bit
- **SPI20**     - SPI 20 bit
- **ASI1**      - UART ASI1 interface
- **AS5048**    - SPI for AS5048 hall grid encoder

The following parameters are available:

- **360**       - turn on 'shortest arc' derivative calculation and movement control
- **rev**       - reverse the encoder readings
- **bias**      - 16 bit bias for digital encoder types. All digital encoders are rounded to 16 bit.
- **cpr**       - counts per revolution for *QUAD* mode
- **scale**     - scale factor, the encoder value is multiplied by this factor, then normalized
- **spd**       - source of speed estimations:
    - *derivative* - calculate from position readings
    - *gyroXYZ* - read from gyro axis (mandala variables `p,q,r`)
- **flt**       - filter for position (Q=0.05, R=10)
- **fltSpd**    - filter for speed (usually off = 0)
- **bind**      - if set, will output its position to mandala
- **bindSpd**   - same as `bind`, but send speed
---
conf: Regulator/FOC
title: BLDC motor control
---

>Configuration: `Regulator/FOC`
> | Nodes: [`servo`](../../hw/nodes/servo.md)

The driver is able to control Brushless motors with [FOC algorithm](https://en.wikipedia.org/wiki/Vector_control_(motor)).

The outer control loops are managed by the [Motor control module](servo.md).

BLDC options (**FOC**):

- **regtype**   - regulator type
    - *torque*  - control the torque of motor
    - *speed*   - maintain the commanded RPM
    - *field*   - rotate the magnetic field with commanded speed and 50% power
- **enc**       - motor encoder type
    - *QUAD*      - use additional quadrature encoder for FOC loops
    - *main*      - use main servo encoder for FOC loops
- **phase**     - Motor encoder index phase shift, can be found with command `Find BLDC phase`
- **speedKd**   - speed to phase Kd coeffitient to avoid resonance [0..0.9]
- **poles**     - number of motor poles, can be found with command `Find BLDC poles`
- **gratio**    - gear ratio between motor and encoder
- **rev**       - phases swap, reverse polarity
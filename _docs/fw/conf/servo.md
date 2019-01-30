---
conf: <servo nodes>
title: Motor control
---

>Configuration: `<servo nodes>`
> | Nodes: [`servo`](../../hw/nodes/servo.md)

The regulator parameters could be adjusted to tune servo motor behavuir. This driver recieves encoder postion and speed from [Encoder interface](#encoder-interface), commanded position or speed from [Ports/controls](#ports-and-controls) module, and calculates required motor power control value.

Available generic servo parameters:

- **power** - motor power control:
    - *no* - the motor is completely shut down
    - *yes* - the motor power is controlled by the variable `*power_servo*`
- **debug** - when turned on, the servo will output it's current state to the following variables:
    - `*user1*` - current position
    - `*user2*` - current output power
    - `*user3*` - current speed
    - `*user4*` - current position error
    - `*user5*` - current control channel output from `Ports/controls`
- **type** - motor type:
    - *brushed* - regular brushed motor
    - *FOC* - Vector controlled BLDC

## Regulator parameters
> `servo/Regulator`

- **regtype**   - the type of regulator. This setting is applied on **reboot**.
    - *PPI*     - the P+PI regulator to control position, which is received from `Ports/controls` channel. The Kpp sets the commanded speed depending on position error, and Kp-Ki controls the motor power to maintain the speed.
    - *SPD*     - The output of `Ports/controls` sets commanded speed of movement.
    - *TORQUE*  - `Ports/controls` output is limited by `Lo` and sets the motor power directly.
- **regspd**    - The type of control when `regtype` is *SPD*.
    - *pos*     - the output of `ports` channel is used to increment/decement commanded position, and the position is holded the same way as when `regtype`=*PPI*
    - *speed*   - The first part of *PPI* regulator (*P*) is skipped, i.e. The output of `ports` channel is a commanded speed to *PI* regulator.
- **pwm**       - the power controller PWM frequency, is set in timer units as period, i.e. the value of 8000 is about 20kHz, the common value is 5000.
- **pwm_min**   - the minimum pulse with for motor in timer units. Must be less than `pwm`. When set to zero, the driver will automatically set this value to 10% of `pwm` period. Normally, this value should be tuned so that the motor is moving on minimum commanded power.
- **hyst**      - the hysteresis applied to commanded speed inside *PPI* regulator, i.e. when the commanded speed is less than this value, the output power is down. The common value is 0.1-0.5, and it is tuned so that the motor is not responding on [encoder](#encoder-interface) noise.
- **dyn**       - the limit of commanded speed for the motor
- **mrev**      - to reverse the sign of output motor power (the polarity of motor). The positive power should move the moter clockwise, the negative power - counter clockwise.
- **reg**       - tuning parameters of the *PPI regulator*.
    - *Kpp*     - the multiplier for the *position error* to get the commanded speed
    - *Lpp*     - the limit of commanded speed
    - *Kp*      - the multiplier for the *speed error* to get the output power
    - *Lp*      - the limit of the outut power component caused by speed error
    - *Ki*      - the bias tracking coeffitient
    - *Li*      - the limit of allowed output power bias
    - *Lo*      - the output power limit


### Safety parameters
> `servo/Safety`

The following parameters are used to shut down the motor power in some situations.

- **timeout**   - when there's no data on the bus more than this value, the motor power will be shutted down. When set to zero - this feature is off.
- **min**       - when *position* from encoder is less than this value - the motor is off
- **max**       - when *position* is more than this value - the motor is off
- **otp**       - when the temperature [C] of the internal switches is more than this value
- **fuse**:     - the integrator estimates the energy passed through the motor and can protect the motor from burning by decreasing the power if there is long-time constant power applied.
    - **time**  - the time factor
    - **level** - the power level which is safe for the motor
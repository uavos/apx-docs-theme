---
title: Gimbal
---

This subsystem controls generic gimbal and performs its gyro-stabilization.

All controls are sent throgh [CANopen](#canopen) to actuators ([servo](/hw/nodes/bldc.md)), it does not use other methods, like `Ports` to control actuators.

As controls input, gimbal accepts the following mandala variables (depending on current configuration):

- `*camctr_roll*`, `*camctr_pitch*`, `*camctr_yaw*` - controls [-1..+1]
- `*camcmd_roll*`, `*camcmd_pitch*`, `*camcmd_yaw*` - angles [deg] or speeds [deg/s]
- `*turretcmd_pitch*`, `*turretcmd_yaw*` - angles [deg]

### The available settings

- **ctype**             - gimbal control type, i.e. how gimbal reacts to input controls
    - *position*      - will hold is angular position relative to the main frame
    - *speed*         - will hold angular rate relative to the main frame
    - *cam_mode*      - current mode *speed* / *position* is set in `*cam_mode*` variable
    - *gyro*          - the gimbal is gyro stabilized, controls set the angular rates
    - *remote*        - controls ('camctr_') are directly forwarded to the actuators
- **downstream**        - for debugging - send telemetry to GCU
- **busMode**           - configuration of bus networks isolation
    - *ExtInt*        - CAN2 network is for internal gimbal sensors and actuators, no data transmitted to CAN1
    - *ExtIntSensors* - same as above, but sensors (gps, imu, pressure) are forwarded to CAN1
    - *gated*         - everything shared between CAN1 and CAN2
- **align**             - body frame alignment corrections, used in stabilization modes and when reporting current angles
- **alignBias**         - use align from `*cambias_theta*` variable in addition
- **vtype**             - type of gimbal, or which controls are active
    - *cam*           - generic surveilance gimbal, use `*camcmd_theta*`
    - *turret*        - turret, use `*turretcmd_theta*`
    - *cmaster*       - same as `cam`, but will also provide `*turretcmd_theta*` to control linked turret
- **demo**              - continuously move for testing or demonstrations
- **CamTrack**          - special section for ground object tracking gimbals
    - **ovr**         - bind variable to shut down motors for manual override
    - **Timestamps**
        - **period**      - Tk period of pulses for pictures, when below 1000 - [ms], else [us]
        - **portID**      - [Serial Port](#serial-ports) ID for NMEA telemetry
    - **Display**     - Display module support
        - **port**    - Serial Port ID for display
        - **onoff**   - bind variable for on/off button
        - **rst**     - bind variable for display reset signal
- **Regulator**         - standard P+PI regulators configuration for stabilization modes

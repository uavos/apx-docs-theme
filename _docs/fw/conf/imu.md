---
conf: IMU
title: Inertial Measurement Unit
---

>Configuration: `IMU`
> | Nodes: [`gps`](../../hw/nodes/gps.md) [`ifc`](../../hw/nodes/ifc.md) [`xhawk`](../../hw/nodes/xhawk.md) [`nav`](../../hw/nodes/nav.md)

This feature provides data from inertial sensors, which then is used by autopilot's [AHRS sub-system](#ahrs).

The module usually includes the folowing sensors:

- **gyro** - 3-axis gyroscopes [deg/s]
- **acc** - 3-axis accelerometers [m/s^2)
- **RT** - room temperature [C]
- **mag** - 3-axis magnetometer [a.u.]

One or several IMU features can present in one system. The AHRS will automatically fuse all data. **Important** requirement is that all IMUs have to be properly aligned to each other with `align`, `flip` and `hdg` setting.

The common practice is to use IMU of [GPS node](/hw/nodes/gps.md) to provide magnetometer, since it could be located in a better place (less hard-iron) than [NAV](/hw/nodes/nav.md).

### Inertial Sensors

When device boots-up (on power on or reset), the IMU is initialized, and the orientation is detected, assuming that the device is in **level position**, parallel to the ground. The detected orientation is reported to the console, f.ex. `IMU: bottom` (that means the bottom side of the device is looking down).

All yaw headings of all IMU's in the system should always be aligned physically between each other.

For safe operation it is **strongly recommended** to adjust `flip` and `hdg` settings, after device installation to the vehicle. Moreover, if the IMU used to supply only the magnetometer to AHRS, it still have to be properly aligned (using these settings) with the device used for inertial sensors.

The good practice is to check gyro bias to monitor system health after some vehicle changes or modifications, with the command `Estimate gyro bias`. The numbers should be close to zero on working temperatures.

Inertial sensors tuning:

- **imu**       - enable/disable inertial data
- **prio**      - redundancy priority for sensor.
    - *primary*   - data will be used when available.
    - *secondary* - data will be used when *primary* is unavailable.
    - *low*       - level3 priority, used when *primary* and *secondary* is unavailable.
    - *safety*    - used when no other sources are available.
- **RT**        - update and send Room Temperature data variable `*RT*`. Used for monitoring only.
- **flip**      - alignment of the sensors to bodyframe, "the side of device, which looks down". When set to *auto*, the orientation is always detected on start-up, which is not recommended for normal operation.
- **hdg**       - the yaw component of the alignment.
- **align**     - the corrections of the alignment of +/- 10 degrees. Higher numbers should never be used, also avoid the yaw component adjustments, because of gimbal-lock limitations. For yaw adjustments, use [AHRS/decl](#ahrs) setting.
- **bgyr**      - initial gyro bias compensation. MEMS gyroscopes usually have zero bias after the installation on PCB. This bias can be estimated by node command `Estimate gyro bias`. The estimated bias will then be reported to the console. Ususally, the numbers between +/- 5 deg/s are allowed, but on power-on, the AHRS does not have enough statistics to estimate gyro bias and may showincorrect attitude initially, although correcting itself after some physical body movements. To compensate this, the setting could be adjusted. After corrections, the command `Estimate gyro bias` should report numbers close to zero.
- **DLPF**      - Digital Low-pass Filter, set the cut-off frequency [Hz] for inertial sensors, used for vibrations filter.


### Magnetometer

Magnetometer uses alignment, configured in **IMU** settings. Although, it has some specific parameters:

- **mag**       - enable/disable the sensor
- **prio**      - redundancy priority for sensor.
    - *primary*   - data will be used when available.
    - *secondary* - data will be used when *primary* is unavailable.
    - *low*       - level3 priority, used when *primary* and *secondary* is unavailable.
    - *fail*      - used when no other sources are available.
- **bias**      - Hard-Iron calibration bias (default=0)
- **scale**     - Hard-Iron calibration scale factor (default=1)

The sensor outputs normalized vector of magnetic field strength. The values are within rane -1..+1. The proper hard-iron calibration is required, and can be performed with the GCU software plugin.

**Note**

The magnetometer calibration must be performed _after_ the alignment of the sensor. When the alignment parameters (`flip`, `hdg`) are changed - the hard-iron calibration must be performed again.

Before the calibration, the settings `bias` and `scale` should be set to default values: `bias`=(0,0,0), `scale`=(1,1,1).
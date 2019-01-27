---
title: AHRS
---

This feature estimates different navigation parameters, based on sensor readings from other modules. The estimations are performed wit MEKF algorithm, and the inertial navigation (in case of GPS lost) is based on airspeed sensor readings and current wind estimator values.

The current implementation is capable to have loop frequency of maximum **400Hz** (on AP10). This update rate is adjusted automatically, based on available inertial data rate and is reported to the console.

The source for inertial sensors (`acc`, `gyro`, `mag`, ...) is automatically selected, based on availability, thus making  redundancy possible.

The data source is choosen with the following priorities (high to low):

- local node sensors
- other LAN sensors
- sensor data fixes from ground control

The concept of **distributed architecture** is followed by the assumption, that all sensors monitor their health and supply data to AHRS if possible. Then AHRS automatically choose the best option and reconfigure itself to adopt to current conditions.

Estimated parameters include:

- **attitude** - bodyframe angles
- **position** - global position coordinates
- **velocity** - budyframe velocities
- **gyros** - filtered gyros with compensated drift
- **accelerations** - linear accelerations
- **wind** - current wind speed and direction (correlator)
- **airspeed** - current airspeed fused with other sensors
- **vspeed** - current vertical speed fused with other sensors
- **denergy** - compensated variometer, used for gliding with thermals
- **energy** - total vehicle energy, used for ([TECS](http://www.acronymfinder.com/Total-Energy-Control-System-(TECS).html)) control approach
- **slip** - current slip angle to aid maneuvers and coordinated turns
- **course** - current movement heading with different models
- **health** - current system health status, sensor malfunction monitor

AHRS tuning:

- **align**     - body frame align [deg]. Used to correct attitude alignment. Maximum numbers allowed are +/- **10 degrees**. The yaw component should never been used. The flip and heading corrections more than this, have to be adjusted in corresponding [IMU](#imu) units (`flip`, `hdg`).
- **gps_arm**   - gps lever arm, relative to IMU center [m]
- **decl**      - magnetic declination [deg]
- **fgyr**      - gyro filter:
    - *off* - only the gyro data drift is compensated
    - *soft* - vibrations filter weight is 'soft'
    - *strong* - vibrations filter weight is 'strong'
    - *mekf* - gyro data for autopilot control loops is estimated by derivative calculation from *attitude* output from AHRS. Usefult when the gyro bias is critical, so that integrated gyro always reflects actual attitude.
    - *raw* - gyro data is not changed at all, no drift compensation. Used for technical maintenance purposes, vibration level checks, etc. Should not be used for normal operation.
- **facc**      - accelerometers vibrations filter. This will affect `*slip*` estimations and input to MEKF filter:
    - *off* - accelerometers are not filtered at all
    - *soft* - vibrations filter weight is 'soft'
    - *strong* - vibrations filter weight is 'strong'
- **ftype**     - MEKF tuning
    - *default* - the tested configuration, proven to operate.
    - *improved* - experimental tuning, improved performance, but not tested as *default* option.
- **hAGL**      - altitude to turn on AGL [m]. The `*power_agl*` will turn on when the altitude reaches this number.
- **bAGL**      - AGL altitude on ground level [m]. The ground level altitude `*agl*`, used on [Landing procedure](tuning.md#landing) will be adjusted, using this zero level.
- **hGPS**      - preferred altitude source
    - *auto* - will use baro altitude everywhere, except final stages of Landing procedure
    - *baro* - will always use baro altitude when available
    - *gps* - will always use GPS altitude if available.
- **vsGPS**     - preferred vspeed source
    - *auto* - will always estimate vertical speed, based on pressure derivative
    - *gps* - - will use actual estimated velocity of bodyframe to estimate vertical speed
- **noGPS**     - don't wait GPS on initialization, used when there is no GPS receiver present at all.
- **noMAG**     - block magnetometer
    - *off* - never use magnetometer data
    - *auto* - turn off magnetometer according to value of mandala `*cmode_nomag*`. Used by helicopters landing procedure automatically or by operator to take-off from runways with magnetic disturbances.
    - *always* - always use magnetometer readings, never discard it
- **fbar**      - barometric altimeter filter
    - *mekf* - fuse accelerations and actual movements to aid altitude estimations
    - *none* - use altitude ([Altimeter](#altimeter)) as is, without fusion
- **crs**       - course source
    - *mekf* - estimate course heading, based on current velocities
    - *smart* - assume the vehicle is an aircraft and can't move backwards. Used on UGV/USV, or when the airspeed of the aircraft is comparable to wind speeds.
    - *mag* - use magnetometer only, i.e. for UGVs
- **cas**       - CAS sensor
    - *PsPt* - use static pressure and airspeed sensors when available
    - *Ps* - use only static pressure readings, discard dynamic
    - *Pt* - use only dynamic pressure readings, discard static
    - *off* - never use any pressure sensors for estimations
- **hspd**      - minimum airspeed to use. the `*airspeed*` variable, used for control loops, will reflect the estimated velocities and wind speed, if ground speed is below this setting number. Used for helicopters with Pitot sensor.

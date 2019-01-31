---
conf: Protocols
title: Serial Protocols
toc: true
---

>Configuration: `Protocols`
> | Nodes: [`ifc`](../../hw/nodes/ifc.md) [`mhx`](../../hw/nodes/mhx.md) [`ers`](../../hw/nodes/ers.md) [`nav`](../../hw/nodes/nav.md) [`xhawk`](../../hw/nodes/xhawk.md) [`ghanta`](../../hw/nodes/ghanta.md)

This feature provides drivers for different serial data protocols. Any serial protocol can be linked to [Virtual Communication Port](serial.md) through **portID** setting.

The common options for the protocol are:

- **[NAME]**     - protocol mode:
    - *off*       - protocol is turned off
    - *node*      - protocol can send data only within one device (node)
    - *LAN*       - protocol can send data through CAN network to Serial Ports on other nodes
- **ID**        - link protocol to specific [Virtual Communication Port](serial.md)

Some protocols and settings are described in details below.



## NMEA

This protocol is able to receive and send ASCII text messages of the following format:

$`variable name`,`value`,`*`,`CRC`

- *variable name* - the name of Mandala variable, f.ex. `altitude`
- *value* - the variable value, i.e. *123.45678*, the value could be comma-separated (f.ex. for vector type values)
- *CRC* - HEX checksum (8-bit, two characters) - sum of all bytes except starting `$` sign and ending `*` sign. If the checksum is omitted - it is not checked.

All lines are delimited with either `\n` or `\r` or `\n\r` or `space` characters.

Examples of the NMEA line output:

- `$airspeed,29.12*XX\r\n` - the airspeed is 29.12 [m/s]
- `$gps_pos,12.345678,-12.345678,123*XX\r\n` - latitude is 12.345678 [deg], longitude is -12.345678 [deg], MSL altitude is 123 [m].

The protocol is transmitting only those lines (variables) that are selected using the request `enable`.

Supported requests:

- $`enable`,`variable name` - will select the variable for reporting every 100 milliseconds
- $`disable`,`variable name` - disable transmission of selected variable
- $`variable name`,`value` - set value

Examples of valid NMEA requests:

- `$camcmd_theta,0,-10,31*DA\r\n` - 27 bytes, CRC is 0xDA. This request will set the gimbal position to 0 [deg] roll, -10 [deg] pitch and 31 [deg] yaw.
- `$cmd_altitude,1000\n` - 19 bytes, CRC is skipped, set the commanded flight altitude to 1km.
- `$enable,gps_pos\n` - will schedule GPS coordinates for continuous output every 100ms.
- `$disable, $enable,cam_theta $enable,gps_pos\n` - will disable all previously scheduled outputs and select gimbal attitude and GPS coordinates for output every 100ms.

## MODBUS

This protocol is for requesting and receiving of [MODBUS packets](https://en.wikipedia.org/wiki/Modbus). It is used for reading of different sensors via RS485 bus.

The following parameters of MODBUS protocol are configurable:

- **rate** - the READ requests will be send with this rate [ms]
- **bind** - Mandala variable for read value
- **mbID** - Modbus ID (device address)
- **addr** - register address (16 bit HEX) to read
- **type** - type of register value
- **mult** - the read value is multiplied to this number and set to mandala variable, 0 = don't multiply
- **bias** - this number is added to the value after multiplying and result is written to mandala variable

## VISCA

This protocol is output only and controls some options of [Sony-FCB cameras](https://en.wikipedia.org/wiki/VISCA_Protocol) via UART.

The following features are supported:

- **zoom**      - the zoom is controlled from `cam_zoom` mandala variable
- **flip**      - the picture flip is controlled from `cam_opt_PF`
- **NIR**       - night vision filter as per `cam_opt_NIR` value
- **display**   - display overlay `cam_opt_DSP`
- **focus**     - infinite focus mode by `cam_opt_FM`

## DST

This protocol controls [DST Gimbals](http://www.dst.se/) (OTUS).

The following features are supported:

- The connected gimbal is auto detected and initialized
- operation either in native DST stabilization mode or autopilot controlled stabilization
- Day/Night camera is switched through `cam_ch` variable
- OSD overlay with custom message
- Laser range finder initiated by `cam_opt_laser` and result value in `range` variables
- picture flip is controlled from `cam_opt_PF`
- night vision filter for day view camera as per `cam_opt_NIR` value
- infinite focus mode by `cam_opt_FM`
- focus value set from `cam_focus` variable
- zoom is controlled from `cam_zoom` mandala variable
- Computer Vision tracker is controlled in `cam_mode_track` mode (`cam_mode`)

Supported modes, controlled through `cam_mode` variable:

- `cam_mode_camoff`     - the gimbal is parked (stowed), this option is also automatically chosen when `power_payload` variable is off.
- `cam_mode_stab`       - gyro stabilization (joystick speed control)
- `cam_mode_position`   - fixed angular position (encoder positioning)
- `cam_mode_speed`      - same as `cam_mode_stab`
- `cam_mode_target`     - DST geo positioning (if available)
- `cam_mode_fixed`      - fixed Yaw and Pitch
- `cam_mode_track`      - Video Tracking

The following settings are available for the protocol:

- **mode**      - gimbal stabilization control mode
    - *DST*             - native DST stabilization
    - *siva*            - autopilot controlled, i.e. the gimbal works in **encoder positioning** mode and angles are controlled by autopilot through `camctr_roll`, `camctr_pitch`, `camctr_yaw` variables
- **osd**       - enable on screen dispay (DST native), useful when you do video stabilization and post-processing and don't need anything on the video except clean picture
- **overlay**   - text string to print on the video for reference

## VOLZ

This protocol is output only and controls [Volz servos](http://www.volz-servos.com/) via RS485.

The protocol sends a packet with commanded servo position every 5 ms. All servos must be pre-configured and channels should be assigned. The protocol will continuously update all servos with values from [Ports mixer](ports.md) and the total number of servos is set in **cnt** setting. It is recommended to assign channels in sequence, without gaps, to minimize traffic.

## HBC

This protocol controls [MGM-COMPRO industrial BLDC controllers](http://www.mgm-compro.com) (via CAN). Up to four motors could be controlled. Parking feature is also provided. The connected controllers are auto detected and monitored.

The following settings are available:

- **motors**    - motors/controllers configuration
    - **canID**         - device CAN address
    - **ch**            - channel to take value from [Ports mixer](ports.md), moreover all motors are stopped when `cmode_thrcut` is on
    - **psens**         - parking sensor variable binding, i.e. when variable value is not zero - the shaft is 'parked', if there is no binding - parking procedure is skipped
- **pval**      - value to apply for motor (power) to move shaft for parking, the motor will be stopped when variable binded in **psens** is not zero
- **pwait**     - pause [sec] to wait after `ctr_throttle` value is zero before starting the parking procedure

## SBUS

This protocol controls [Futaba SBUS servos](http://www.futabarc.com/servos/sbus.html) (via RS485). The servos must be pre-configured and channels should be assigned. The protocol will update servo positions, taken from [Ports mixer](ports.md) output channels. The SBUS packet is sent every 12 ms.

## XPDR

This protocol controls [Microair T2000UAV transponders](http://www.microair.com.au/). The transponder is auto detected and monitored, turned on and off (power controlled) according to `power_xpdr` mandala value. The absolute baromeric altitude is updated form `altps` variable. The SQUAWK must be provided, according to the regulations, in **squawk** setiing.

## JETCAT

This protocol controls [JetCat turbojet engine](http://www.jetcatusa.com/). The engine is initialized and monitored, the start procedure is initiated by `sw_starter` variable and the rpm is controlled from `ctr_throttle`. The current status is reported in the console.

The following parameters are monitored:

- `rpm`       - the turbine RPMx10
- `EGT`       - exhaust gas temperature
- `Vm`        - ECU and starter voltage

To start the turbine:

- turn on ignition `power_ignition`=1
- set throttle to zero `ctr_throttle`=0
- send command to autopilot to initiate engine start-up procedure with `ctrb_starter`=1, this will automatically set `sw_starter` when ready.

To shutdown the turbine, turn `power_ignition` off.

## LIGHTWARE

This protocol controls [LIGHTWARE SFxx laser altimeters](http://lightware.co.za/). The protocol sends requests in the form `?LD\r\n` and expects a response in either forms (altitude number in meters):

- `1.23\r\n` - f.ex. in continuous mode
- `?LD 1.23\r\n`
- `ld,0:1.23\r\n`

The following parameters are configurable:

- **bind**      - the variable to store altitude value
- **mode**:
    - **request** - protocol will send requests (10Hz)
    - **continuous** - protocol will NOT send requests, but reads altitude data

## MAVLINK

This protocol reads data encoded in [MAVLINK](https://en.wikipedia.org/wiki/MAVLink) packets.

The following messages are supported:

- **flow**      - [pix4flow](https://pixhawk.org/modules/px4flow) Optical flow messages. The data is placed in radar_vXYZ variables.
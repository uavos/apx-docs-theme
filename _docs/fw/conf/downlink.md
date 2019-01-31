---
conf: Downlink
title: Downlink
---

>Configuration: `Downlink`
> | Nodes: [`mhx`](../../hw/nodes/mhx.md) [`ghanta`](../../hw/nodes/ghanta.md) [`jsw`](../../hw/nodes/jsw.md) [`xhawk`](../../hw/nodes/xhawk.md)

This is higher-level communication protocol, used to operate multiple vehicles with one or many ground control units. It is usually used on [mhx](../../hw/nodes/mhx.md) nodes, and works together with [Radio module](radio.md) and [ATS](ats.md)

The protocol is connected to available WAN interface (radio, USB) and wraps all telemetry and uplink data to address the vehicles this data belongs to.

When the vehicle is 'selected', the GCU is requesting the downlink stream (once a second), and when the driver accepts these requests (`SQUAWK` matches), it sends the data stream, otherwise, when there's no requests for stream, the driver sends just *transponder data* (XPDR), with only basic information about the vehicle.

The XPDR data structure can be found in SDK file `node.h` and contains  the following parameters:

- *squawk* - 16 bit unique ID of the vehicle
- *lat* - vehicle current latitude [deg]
- *lon* - vehicle current longitude [deg]
- *alt* - vehicle current MSL altitude [m]
- *gSpeed* - vehicle current ground speed
- *crs* - vehicle current course heading [deg]
- *mode* - vehicle current flight mode, mandala value of `mode` variable

The GCU may change the *SQUAWK* dynamically, if it detects inconsistency (same numbers on other vehicles). This procedure is automatic and reported in the console.

The following parameters tune the behavior of this feature:

- **callsign**  - human readable text name of the vehicle. It is used in GCU menus and messages only.
- **mode**      - protocol mode of operation:
    - *local* - the feature is off and data is not wrapped
    - *dlink* - the feature is active
- **vclass**    - vehicle class, used for data and bandwidth management by the GCU and within networks:
    - *UAV* - generic Unmanned Aerial Vehicle
    - *GCU* - Ground Control Unit
    - *UGV* - Unmanned Ground Vehicle (car)
    - *USV* - Unmanned Surface Vehicle (boat)
    - *SAT* - Atmospheric Satellite
    - *RELAY* - Datalink relay (repeater) device
- **XPDR**      - transponder mode (the common setting is *auto*):
    - *auto* - when there're no requests from the GCU for telemetry data stream, the vehicle sends short XPDR packets once a second to announce its important parameters to GCUs and other vehicles.
    - *silent* - the transponder data will never be sent, although, the GCU may request for it.
    - *1sec* - XPDR period is always 1sec
    - *5sec* - XPDR is always sent every 5 seconds.
- **squawk**    - the current local vehicle SQUAWK identifier. Must be unique for all vehicles. If set to zero, the driver will randomly choose one. If this number is not unique, the GCU will try to set it up with *IDENT* procedure automatically.
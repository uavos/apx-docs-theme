---
conf: Ports/<port name>
title: Serial Ports
---

>Configuration: `Ports/<port name>`
> | Nodes: [`ifc`](../../hw/nodes/ifc.md) [`mhx`](../../hw/nodes/mhx.md) [`ers`](../../hw/nodes/ers.md) [`nav`](../../hw/nodes/nav.md) [`xhawk`](../../hw/nodes/xhawk.md) [`ghanta`](../../hw/nodes/ghanta.md)

This feature provides physical serial ports mapping to Virtual Comm Ports (VCP). All VCP ports are accessible by [Serial Protocols](protocols.md) through unique `portID` number.

The physical layer tunings are listed below:

- **[port name]** - enable/disable port (*off*) and mode selection:
    - **Virtual Comm Port**, i.e. all data sent or reseived through physical layer is available for processing to [Virtual Machine](vm.md) or [Protocols](protocols.md) subsystem.
        - *node*  - the received data is only distributed within local node (device)
        - *LAN*   - the received data is shared over CAN bus with other nodes and devices
        - *GCU*   - the received data is also shared with ground control via datalink
    - **System bus**, i.e. the port is sending and receiving messages the same way as CAN bus. This feature could be used for connecting of PC computers, satellite modems or other datalinks to the autopilot for non-standard telemetry and uplink. The GCU RS232 port uses `ESC` serial data `format`.
        - *DOWNLINK* - the port will send telemetry data stream and service messages, same as [mhx](../../hw/nodes/mhx.md) does over the radio
        - *MANDALA* - forward all messages from CAN bus (huge traffic)
        - *SERVICE* - forward only service messages, i.e. all nodes shall be visible, but no mandala synchronization and no data
- **note**      - user comment for reference
- **ID**        - unique portID identifier
- **baudratee** - physical data rate
- **parity**    - UART parity setting
- **sbits**     - number of stop bits
- **smode**     - TX/RX modes:
    - *RXTX* - both transmitter and receiver are on
    - *RX* - transmitter is shutted down, receive only, f.ex. fuel sensors.
    - *TX* - receiver is shutted down, transmit only, f.ex. RS485 - SBUS
- **format**    - serial data encapsulation (packetization):
    - *RAW* - data is sent as-is
    - *ESC* - data is wrapped to 'escape' characters:
        - *0x55 0x01* - start of packet
        - *[data]* - payload
        - *CRC8* - sum of all data bytes before escape applied
        - *0x55 0x02* - the escape sequence if there's 0x55 in [data] or [CRC]
        - *0x55 0x03* - end of packet
    - *SLIP* - data is wrapped to [SLIP](https://en.wikipedia.org/wiki/Serial_Line_Internet_Protocol) packet format:
        - *0xC0* - frame delimiter, written at start and at the end of a packet
        - *[data]* - payload
        - *CRC16* - [CRC_16_IBM](https://en.wikipedia.org/wiki/Cyclic_redundancy_check), initial value is 0xFFFF, polynom 0x8005.

Some implementations may contain additional settings for PHY configuration.

For programming reference of used ESC protocol, refer to [SDK](../../gcs) file:

`/usr/share/uavos/gcu/sdk/inc/escaped.h`
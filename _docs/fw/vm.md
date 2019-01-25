---
title: Virtual Machine
toc: true
---

This feature provides scripting engine, capable of execution of user programs or protocols on node MCU in user space. The VM is available in all major AP nodes.

The VM is based on [pawn scripting engine](http://www.compuphase.com/pawn/pawn.htm) implementation. The cell size is **32 bit**.

- [Pawn Getting Started](https://github.com/compuphase/pawn/raw/master/doc/Pawn_Getting_Started.pdf)
- [Pawn Language Guide](https://github.com/compuphase/pawn/raw/master/doc/Pawn_Language_Guide.pdf)
- [Other Pawn Documentation](https://github.com/compuphase/pawn/tree/master/doc)



Some script examples could be found here: `/usr/share/uavos/gcu/scripts`

### Exported functions

The default include file with all exported functions is located here:

`/usr/share/uavos/gcu/scripts/include/default.inc`

The standard float arithmetic and string manipulation modules are imported by default as well.

The additional (implementation specific) functions are listed below.


### Public functions

These functions are called by the VM on predefined events and the user script can redefine these functions to implement specific functionality.

#### `main()`

This function is optional and is called when VM starts. The common use of this function is to register serial port event handlers via `seriel_listen(portID,"@function")`.

----
#### `@OnTask()`

This event function is called every 0-10 ms, when the CPU is idle. The return value >0 indicated scheduled time period for the next call, i.e. **return 100;** will call this function again after 100ms.

----

### Native functions

These functions can be called from within user script.

#### `time()`

Returns current system time in ms.

----
#### `time_utc()`

Returns current GPS time in sec.

----
#### `wait(const ms)`

Suspend VM for specified time [ms].

----
#### `Float:get_var(const varmsk)`

Return value of Mandala variable. **varmsk** - is the variable index. All indexes are predefined with constants, starting with **f_...**, i.e. f_altitude, f_pitch, f_home_hmsl, etc.

----
#### `set_var(const varmsk, const Float:value, const bool:force_send=false)`

Set the value of Mandala variable. When **force_send** is true, the variable update will be announced over network and synchronized with other AP nodes. **varmsk** - is the variable index.

----
#### `serial_listen(const portID, const publicFunc[])`

This function binds a virtual port with **portID** to the event handler (public function). The function must start with '@' and have parameter **cnt** - number of bytes available for read.

----
#### `bool: serial_write(const portID, const src{}, cnt, serialmode:mode=NODE)`

Send data to serial port. The port id number is **portID**. **src{}** is the data to send (packed array). **mode** is either NODE (physical port is within same node), LAN (port reachable via network), GCU (data forwarded to GCU). Returns true if written successfully.

----
#### `serial_byte(index)`

Return one byte from serial port read buffer at **index**. This function should only be called from event handler, registered with **serial_listen(...)**.

----
#### `serial_string(dest{}, size=sizeof dest)`

Copy string from serial port buffer to **dest** string. Appends terminating \0 byte to **dest**. **size** is the maximum allowed destination buffer size. Useful for text-based protocols parsing. This function should only be called from event handler, registered with **serial_listen(...)**.

----
#### `Float:get_gpio(const index)`

Read and return gpio value of local node (Ports driver), with the specified **index** (0..n).

----
#### `set_gpio(const index, const Float:value)`

Set the gpio **value** of local node (Ports driver), with the specified **index** (0..n).

----
#### `set_control(const index, const Float:value)`

Set the control **value** of local node (Ports driver), with the specified **index** (0..n).

----
#### `get_ch(const index)`

Return value of controls channel with the specified **index** (0..n), after all mixers are applied.

----

### Reading serial ports
To read and parse data from a serial port, the user must define the public function, f.ex. **@OnDataX(cnt)** with `forward` declaration, and register it with `serial_listen` function call (usually from **main**). The registered event handler can implement parsing algorithm with reading all bytes (**cnt**) one by one with **serial_byte** native function. It is not required to read all bytes (could be just discarded).

### Accessing GPIO ports

The gpio line or pwm channel could be binded to **local** variable, thus allowing access through the script and bypassing standard Ports behavior.

### Calling Public functions

Any public function (name begins with @..) could be defined in the script. The public function is accessible from outside of the virtual machine and could be called by programming a waypoint trigger in mission, or by sending a **vmexec** packet from the GCU (by a command).

When a virtual machine is started, it tries to find and execute **main()** function. After it returns (or not exists), the VM checks for defined public functions and if any, it continues to run (calling these functions), otherwise stops.

### Data arrays packing

Data arrays (f.ex. argument of serial_write) must all be **packed arrays**. The VM only supports packed arrays.

### CAN messages packing
The messages can be parsed with 'serial_byte' function and transmitted with 'serial_write'.

The elements of data array argument contains CAN message header and data:

* ID_0_7
* ID_8_15
* ID_16_23
* ID_24_31
* DLC (data length code 0..8) ORed with 0x80 (bit7=1) for EXT message type.
* Data bytes [0..7]

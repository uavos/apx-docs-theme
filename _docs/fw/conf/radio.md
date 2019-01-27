---
title: Radio
---

The driver configures the radio module [Microhard](http://microhardcorp.com) mhx P400/P900/n920x 900MHz spread spectrum. The common *PMP* (Point-To-Multipoint) network consist of one or mode modems, configured as a *Slave*, and the **only one** modem, configured as *Master*.

- Master always have the modem address of **1**.
- All slaves must have unique modem addresses, starting from **2**.
- All slaves can communicate to master, but not with each other (between slaves)
- Master can communicate to all slaves

The whole PMP network is isolated from another PMP network by the unique `network` ID. I.e., there could be two or more PMP networks with their dedicated Master modems. Although, the bandwidth is shared between all networks.

The following parameters are configuring the network topology:

- **master**    - the modem mode of operation:
    - *Slave* - the default, the modem is a slave in *PMP* network. The common for onboard modems.
    - *Master* - this is usually used for ground modems
    - *Repeater* - same as slave, but will retransmit data from other slaves
- **network**   - unique network ID, must be the same on all modems in the same *PMP* network
- **mask**      - password for security, must be the same on all modems in network
- **addr**      - modem address (=1 for Master, unique for slaves)
- **roaming**   - repeater modem address (=0 to disable, =65535 for full roaming), master should have any non-zero value to support repeaters
- **retr**      - each packet will be always sent this number of times (repeated) with the cost of bandwidth
- **power**     - allowed maximum output RF power
- **NarrowBand** - can be used to configure P400 modems in 400MHz NB mode. The modems communicate directly with each other on hard coded channels, with dedicated data direction (TX or RX). Please, refer to [Microhard documentation](http://microhardcorp.com) for details.
    - **nb**    - after enabling this mode, modem will reconfigure and change frequency to 400MHz
    - **freq**  - frequency table for each channel (total four)
    - **tx**    - channel number for TX data
    - **rx**    - channel number for RX data
    - **txR**   - channel number for repeater TX
    - **rxR**   - channel number for repeater RX

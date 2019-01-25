---
title: Installation
---

The [Ground Control](index.md) (GCS) application is available for different platforms from the [github repository](https://github.com/uavos/apx-releases) releases.

To get emails with announcements about new versions, visit this page: [UAVOS Updates](https://groups.google.com/forum/#!forum/uavos-updates) and subscribe.

## MacOS

 * Download the [DMG image](https://github.com/uavos/apx-releases/releases/latest).
 * Open the image and move app to the Applications folder.
 * Launch the application as usual.
 * Install serial port drivers if necessary:
   * [Silicon Labs](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers) - used for [mhx](../hw/nodes/mhx.md) and [ghanta](../hw/nodes/ghanta.md)
   * [FTDI USB to Serial port converters](https://www.ftdichip.com/FTDrivers.htm)


## Linux

The Kubuntu OS can be found here: [http://kubuntu.org](http://kubuntu.org)

Add our repository to your system (execute the following commands in console):

```bash
echo "deb http://apt.uavos.com/ all main experimental"| sudo tee /etc/apt/sources.list.d/uavos.list; gpg --keyserver keyserver.ubuntu.com --recv B5517CF1; gpg --export --armor B5517CF1 | sudo apt-key add -; sudo apt-get update
```

Repository contains two components:

- **main** - rare updates (once in 3-6 months), more bugs, but ensures it was tested on several UAVs for stable operation.
- **experimental** - most recent bugfixes and features, builds for most recent linux versions. Updates almost every week, tested on at least one UAV.

Install application and tools:

```bash
sudo apt-get install uavos
```

GCS uses serial port to communicate with the radio modem device. User must be a member of 'dialout' group to have rights to access modem device. Execute the following command in terminal to add yourself to the group, then reboot.

```bash
sudo usermod -aG dialout $USER
```

## Android

The app can be installed through [Play Market](https://play.google.com/store/apps/details?id=com.uavos.qgc). Although, it requires PC Ground Control app to communicate with UAV and is used mainly for maintenance purposes.

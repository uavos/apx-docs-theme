---
title: Simulation
---

To quickly get started with **Software in the loop simulation** (no hardware) you can follow these instructions:

- [Install Ground Control](install.md) application.
- Purchase and install [X-plane Flight Simulator](http://www.x-plane.com/)
- Run the X-plane Simulator for the first time to ensure it is working.
- Launch the *Ground Control* application.
  - Open dialog through menu `Tools/Simulator` and click `Launch` button.
  - Wait until `SIM` vehicle is recognized, select it if needed.
  - Open dialog `Windows/Vehicle parameters` and click `Download from vehicle` button.
  - Upload the configuration if it is missing or recovered, import from file if necessary (when any node is highlighted with grey or red color). You need to `Stop`/`Launch` the simulation (restart) when there was configuration reset.
  - When there is no mission downloaded from vehicle exists:
    - Click and hold on the mission button to open dialog, then click `...` button and `Load mission`, to load applicable mission, then click `Upload` button to sync mission with the vehicle.
- Inside X-Plane window, select airport and the aircraft:
    - type in to search airport: `KSEA` (for X-Plane 10) or `LOWI` (for X-Plane 9)
    - select runway: `RWY - 1 6 L` (for X-Plane 10) or `RWY - 0 8` (for X-Plane 9)
    - choose aircraft for your configuration, f.ex. `UAVOS/standard`
- If everything is ok, you will see the telemetry data and it should say that GPS is available and show to you the current position (from simulation) on the map.
- Press the keyboard shortcuts on GCS window to start mission:
    - `F8` to start takeoff procedure,
    - `Backspace` to restart takeoff,
    - `=` to start the next takeoff procedure stage, i.e. perform the takeoff.
- The UAV must perform takeoff and fly waypoints, then land automatically.



### Notes

 * X-plane and autopilot exchange data via x-plane **plugin** and TCP/IP network. The plugin is installed automatically by the GCS when you launch the simulation.

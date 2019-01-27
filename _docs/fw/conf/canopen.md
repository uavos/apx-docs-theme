---
title: CANopen
---

This feature provides support for [CANopen](https://en.wikipedia.org/wiki/CANopen) protocol.

For physical layer, this protocol uses the same CAN bus as AP system (not virtual port), i.e. both system bus and CANopen can operate simulaneously, because CANopen uses IDE=0, but AP uses extended CAN messages.

The current implementation supports **PDO only**.
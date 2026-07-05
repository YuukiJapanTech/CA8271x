# v1.1.0 Release Notes

* Support stick add : XE-99S, XG-99S, and OEMs.
* Fixed the link to GitHub in the webgui.
* Implement automatic detection of SFP+ speed. This enables support for speeds of 10Gbps, 2.5Gbps, and 1Gbps. ( auto-XFI )
* To prevent overheating, the periodic execution interval for the TrafficEnable and ForceBridge scripts has been set to 30 seconds.
* added a feature to the webgui that displays the stick's temperature and BOSA information.
* Added the [full version of the busybox command](/mod/busybox-full/), `busybox.full`.
* Improved the startup speed of the stick.
* Added `BOSA_read` and `BOSA_write` commands for XE-99S and XG-99S to dump and modify SFP eeprom information.

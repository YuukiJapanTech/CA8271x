# Switch between XGS and 10GE (XG-99S/XE99S)

The XG-99S (and OEM's) and XE-99S are hardware compatible.<br>
By replacing the Stick firmware,
it can switch between XGS-PON mode (XG-99S) and 10GE-PON mode (XE-99S).<br>
CIG's Stick cannot switch between XGS/10GE by changing only `scfg.txt`<br>

To switch between XG-99S and XE-99S, replace the following partition.
- `dtb` : mtd2 / mtd5
- `kernel` : mtd3 / mtd6
- `rootfs` : mtd4 / mtd7
- `mfginfo` : mtd9 / mtd10
- `userdata` : mtd8 (*not necessary when switching XE-99S -> XG-99S*)

## Procedure
To prevent crashes due to exhaustion of tmpfs, the following procedure is recommended. 
It is strongly recommended to backup all partitions before proceeding.<br>
***Never disconnect power to the Stick while the partition is being written. Otherwise the Stick will brick.***<br>
If Stick bricked, repair according to [mtd dump & Bricked Stick Repair](/mtd#bricked-stick-repair) <br>

1. Download the firmware to be switched from [Switch between XGS and 10GE](/XG-XE_Switch) and place it on the tftp server.

2. Log into the Stick root shell and go to `/tmp`.

3. Transfer `userdata.tar.gz`.
```
tftp -r userdata.tar.gz -g tftp-server-ip
```

4. Expand to `/userdata`.
```
tar -xvzf userdata.tar.gz -C /userdata
```

5. Delete the transferred `userdata.tar.gz`.
```
rm userdata.tar.gz
```

6. Transfer `kernel.bin`.
```
tftp -r kernel.bin -g tftp-server-ip
```

7. Write `kernel` partition.
```
flash_eraseall /dev/mtd3
flashcp -v kernel.bin /dev/mtd3
flash_eraseall /dev/mtd6
flashcp -v kernel.bin /dev/mtd6
```

8.  Delete the transferred `kernel.bin`.
```
rm kernel.bin
```

 Transfer `rootfs.bin`, `dtb.bin` and `mfginfo.bin`.
```
tftp -r rootfs.bin -g tftp-server-ip
tftp -r dtb.bin -g tftp-server-ip
tftp -r mfginfo.bin -g tftp-server-ip
```

7. Write `dtb` partition.
```
flash_eraseall /dev/mtd2
flashcp -v dtb.bin /dev/mtd2
flash_eraseall /dev/mtd5
flashcp -v dtb.bin /dev/mtd5
```

8. Write `mfginfo` partition.
```
flash_eraseall /dev/mtd9
flashcp -v mfginfo.bin /dev/mtd9
flash_eraseall /dev/mtd10
flashcp -v mfginfo.bin /dev/mtd10
```

9. Write `rootfs` partition.
```
flash_eraseall /dev/mtd4
flashcp -v rootfs.bin /dev/mtd4
flash_eraseall /dev/mtd7
flashcp -v rootfs.bin /dev/mtd7
```

10. reboot
```
reboot
```

11. Disconnect and reconnect the Stick.

12. Stick will boot with replaced firmware!

Stick's current mode can be found in the dmesg or messages log.
```
# grep "ca-pon: load PON_MAC_MODE:" /var/log/dmesg
[   10.869218] ca-pon: load PON_MAC_MODE: EPON-BI10G
```
or,
```
# grep "ca-pon: load PON_MAC_MODE:" /var/log/messages
Jan  1 00:00:13 saturn-sfpplus-eng user.warn kernel: [   13.843922] ca-pon: load PON_MAC_MODE: XGSPON
```

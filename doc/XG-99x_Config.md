# XG-99S, XG-99M configuration command

## Misc Command
To configure settings using the MISC command, execute the following command.
```
#ONT> system/misc
#ONT/system/misc>
```

---
### eqsn set "XXXXxxxxxxxx"
 Write PON S/N.
 For example, if the SN like `ZTEG21100005` (`5a54454721100005`) ,
```
#ONT/system/misc> eqsn set "ZTEG21100005"
```

The get command can also be used to retrieve the set PON S/N.
```
#ONT/system/misc> eqsn get
eqsn: ZTEG21100005
```

---
### Vendor set "XXXX"
 Write MIB OntG (256) Vendor Code.
 For example, if the Vendor like `ZTEG`,
```
#ONT/system/misc> vendor set "ZTEG"
```

The get command can also be used to retrieve the set PON S/N Vendor field.
```
#ONT/system/misc> vendor get
vendor: ZTEG
```

In the XG-99x series ONT, the MIB OntG Vendor can be set to a value different from the S/N Vendor value.
example,
```
#ONT/system/misc> eqsn get
eqsn: ECIG21100005
#ONT/system/misc> vendor get
vendor: ZTEG
```

---
### pon_passwd set "xxxxxxxxxx"
 Write Loid Password. (Max 20 bytes)
 For example, if the Loid password like `0123456789` ,
```
#ONT/system/misc> pon_passwd set 0123456789
```

The get command can also be used to retrieve the set Loid password.
```
#ONT/system/misc> pon_passwd get
eqsn: 01234567890000000000
```
---
### exeep_w8 "xxxxxxxxxx"
 Write PLOAM Password (Registration ID).
 For example, if the Loid password like `G01234567` ,
```
#ONT/system/misc> exeep_w8 "G01234567"
```

The `exeep_r8` command can also be used to retrieve the set PLOAM password.
```
#ONT/system/misc> exeep_r8
[00, 000] 44 45 46 41 55 4c 54 00 - 00 00 00 00 00 00 00 00     |  DEFAULT......
[10, 016] 00 00 00 00 00 00 00 00 - 00 00 00 00 00 00 00 00     |  .............
[20, 032] 00 00 00 00 ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[30, 048] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[40, 064] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[50, 080] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[60, 096] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[70, 112] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[80, 128] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[90, 144] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[a0, 160] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[b0, 176] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[c0, 192] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[d0, 208] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[e0, 224] ff ff ff ff ff ff ff ff - ff ff ff ff ff ff ff ff     |  .............
[f0, 240] ff ff ff ff ff ff ff ff - ff ff ff ff 15 91 f3 9f     |  ............k
```
---
### admin_ip set XXX.XXX.XXX.XXX
 Write management IP.
 For example, if the management IP like `192.168.100.2`,
```
#ONT/system/misc> admin_ip set 192.168.100.2
```
---
### admin_mask set XXX.XXX.XXX.XXX
 Write management IP netmask.
 For example, if the management IP like `255.255.0.0`,
```
#ONT/system/misc> admin_mask set 255.255.0.0
```

---


## scfg.txt
To configure settings using the `scfg.txt`

---
### CHAR CFG_ID_PON_MAC_MODE = 0xXX
Configure ONT in which PON MODE<br>
**(Not sure if it works properly)**
```
0x08 : ALL
0x07 : ETHERNET
0x06 : NGPON (HW not Supported)
0x05 : XGSPON
0x04 : XGPON (HW not Supported)
0x03 : GPON (HW not Supported)
0x02 : EPON-BI10G
0x01 : EPON-D10G
0x00 : 1G EPON (HW not Supported)
```

---
### CHAR-ARRAY CFG_ID_LOID
Define LOID.
Add the following line to `/userdata/scfg.txt`
```
CHAR-ARRAY CFG_ID_LOID = { 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX };
```

 For example, if the Loid like `0123456` ,
```
CHAR-ARRAY CFG_ID_LOID = { 0x30,0x31,0x32,0x33, 0x34,0x35,0x36,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00 };
```

---
### CHAR CFG_ID_PON_REPORT_MODE = 0xXX
Configure ONT in which PON Report mode<br>
**(Not sure if it works properly)**
```
0x05 : 2QS-4P (NTT East/West Original MODE)
0x04 : 4QS-1Q
0x03 : 2QS-1Q
0x02 : 1QS-1Q
0x01 : 1QS-8Q
0x00 : 2QS-8Q
```

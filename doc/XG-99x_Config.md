# XG-99S, XG-99M configuration command
XGS-ONU-25-20NI ONT uses the `scfg.txt` file and `misc` command for configuration.

- scfg.txt
See [ONT scfg.txt files (CORTINA SoC Configuration file)](/doc/scfg_files.md)

- Misc Command
To configure settings using the MISC command, execute the following command.
```
#ONT> system/misc
#ONT/system/misc>
```

---
## Getting/Setting ONU GPON Serial Number
This setting must be changed with the `misc` CLI option and the `eqsn set "<serialnumber>"` command.
For example, if the SN is like `GPONabcd1234` (`47504f4eabcd1234`):
```
#ONT/system/misc> eqsn set "GPONabcd1234"
```

The get command can also be used to retrieve the configured PON S/N.
```
#ONT/system/misc> eqsn get
eqsn: GPONabcd1234
```

## Getting/Setting ONU EPON MAC Address
This setting must be changed with the misc CLI option and the `mac1 set "<macaddress>"` command.
For example, if the desired S/N is 00:19:c7:00:00:01
```
#ONT/system/misc> mac1 set "00:19:c7:00:00:01"
```
The get command can also be used to retrieve the set EPON MAC.
```
#ONT/system/misc> mac1 get
mac1: "00:19:c7:00:00:01"
```

## Getting/Setting ONU GPON PLOAM password
This setting must be changed with the `misc` CLI option and the `exeep_w8 "<password>"` command.
For example, if the PLOAM password is like `0123456789`:
```
#ONT/system/misc> exeep_w8 "0123456789"
```

The `exeep_r8` command can also be used to retrieve the configured PLOAM password.

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

## Getting/Setting ONU GPON LOID
This setting must be changed in `scfg.txt`, using the key `CHAR-ARRAY CFG_ID_LOID`. 
To modify LOID username we add the following line to `/userdata/scfg.txt`:
```
CHAR-ARRAY CFG_ID_LOID = { 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX, 0xXX,0xXX,0xXX,0xXX };
```

For example, if the LOID is like `0123456`:
```
CHAR-ARRAY CFG_ID_LOID = { 0x30,0x31,0x32,0x33, 0x34,0x35,0x36,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00, 0x00,0x00,0x00,0x00 };
```

## Getting/Setting ONU GPON LOID password
This setting must be changed with the `misc` CLI option and the `pon_passwd set <password>` command.
For example, if the LOID password is like `0123456789`:
```
#ONT/system/misc> pon_passwd set 0123456789
```

The `get` option can also be used to retrieve the configured LOID password:
```
#ONT/system/misc> pon_passwd get
eqsn: 01234567890000000000
```

## Getting/Setting ONU EPON CTC LOID
This setting must be changed with the `misc` CLI option and the `ctcloid set <loid>` command.
For example, if the LOID is like `001234567890A`:
```
#ONT/system/misc> ctcloid set 001234567890A
```

The `get` option can also be used to retrieve the configured LOID:
```
#ONT/system/misc> ctcloid get
ctcloid: 001234567890A
```

## Getting/Setting ONU EPON CTC LOID password
This setting must be changed with the `misc` CLI option and the `ctcpassword set <password>` command.
For example, if the LOID password is like `000000`:
```
#ONT/system/misc> ctcpassword set 000000
```

The `get` option can also be used to retrieve the configured LOID password:
```
#ONT/system/misc> ctcpassword get
ctcpassword: 000000
```

## Getting/Setting OMCI hardware version (ME 256)
This setting must be changed with the `misc` CLI option and the `eqvid set "<hwver>"` command.
For example, if the hardware version is like `abc123`:
```
#ONT/system/misc> eqvid set "abc123"
```

The `get` option can also be used to retrieve the configured hardware version.
```
#ONT/system/misc> eqvid get
eqvid: abc123
```

## Getting/Setting OMCI vendor ID (ME 256)
This setting must be changed with the `misc` CLI option and the `vendor set "<vendor>"` command.
For example, if the vendor is like `GPON`:
```
#ONT/system/misc> vendor set "GPON"
```

The `get` option can also be used to retrieve the configured PON S/N vendor field:
```
#ONT/system/misc> vendor get
vendor: GPON
```

In this ONT, the MIB OntG Vendor can be set to a value different from the S/N vendor value:
```
#ONT/system/misc> eqsn get
eqsn: GPONabcd1234
#ONT/system/misc> vendor get
vendor: ZTEG
```

## Getting/Setting ONU PON mode
This setting must be changed in `scfg.txt`, using the key `CHAR CFG_ID_PON_MAC_MODE`. 
To modify PON mode we add the following line to `/userdata/scfg.txt`:
**Cannot be used for XGS/10GE switching.
See [Switch between XGS and 10GE](/XG-XE_Switch) for XGS/10GE switching.**
```
CHAR CFG_ID_PON_MAC_MODE = 0xXX;
```
The following values can be used for set values:
```
0x08 : ALL
0x07 : ETHERNET
0x06 : NGPON (HW not Supported)
0x05 : XGSPON
0x04 : XGPON
0x03 : GPON (HW not Supported)
0x02 : EPON-BI10G (10G/10G)
0x01 : EPON-D10G (10G/1G)
0x00 : 1G EPON (HW not Supported)
```
For example, if the PON mode set to `EPON-D10G`:
```
CHAR CFG_ID_PON_MAC_MODE = 0x01;
```

## Getting/Setting ONU EPON Report mode
This setting must be changed in `scfg.txt`, using the key `CHAR CFG_ID_PON_REPORT_MODE`. 
To modify PON report mode we add the following line to `/userdata/scfg.txt`:
```
CHAR CFG_ID_PON_REPORT_MODE = 0xXX;
```
The following values can be used for set values:
```
0x05 : 2QS-4P (NTT East/West Original MODE)
0x04 : 4QS-1Q
0x03 : 2QS-1Q
0x02 : 1QS-1Q
0x01 : 1QS-8Q
0x00 : 2QS-8Q
```
For example, if the PON report mode set to `2QS-4P (NTT mode)`:
```
CHAR CFG_ID_PON_MAC_MODE = 0x05;
```

## Setting management IP
To change the management IP, set it with the `misc` CLI option and the `admin_ip set <ip>` command.
For example, if the management IP is like `192.168.1.1`:
```
#ONT/system/misc> admin_ip set 192.168.1.1
```

To change the management IP netmask, set it with the `misc` CLI option and the `admin_mask set <netmask>` command.
For example, if the management IP mask is like `255.255.255.0`:
```
#ONT/system/misc> admin_mask set 255.255.255.0
```


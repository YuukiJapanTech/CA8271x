# How to get root CLI & root Shell

## LTF-726x-BH+

Connect via `SSH` or `UART` to obtain root shell.

## XG-99S, XG-99M

After logging in via `telnet` or `UART`, you will first get the CLI with user privileges.

```
ONT>
```

The root CLI can be obtained by executing the `enable` command on this CLI.

```
ONT> enable
#ONT>
```

can switch to the root shell by executing the following command.

```
#ONT> system/shell
#ONT/System/Shell> sh
#
```

There are several other commands in the root CLI.
The following is a list of typical commands,

- `/traffic/pon/show onu`
    Obtain ont’s authentication status, SN, LOID password, PLOAM password, etc.
- `/system/misc`
    Change the SN, vendor, PLOAM password, and other settings stored in its custom ROM (mtd9, mtd10)
- `/system/mib/show "MIB No."`
    Get MIB values.
    example,
    `#ONT> /system/mib/show 256`
    `/system/mib/show ?` command can get a list of supported MIBs.

## XE-99S

Connect via `SSH` or `UART` to obtain root shell.
can switch to the CIG CLI by executing the following command.

```
XE-99S # cig-cli
ONT> 
```

## Nokia XS-010X-Q

Connect via `Telnet`, `SSH` or `UART` to obtain root shell.

Some new devices may not allow access shell via `UART`.<br>
Use programmer to extract the firmware, then modify it using tools like WinHex.<br>
(Tested on 2023 manufactured Nokia XS-010X-Q from eBay)
1. Open WinHex, press `ALT+G` and go to offset `3500000`.<br>
2. Select range `3500000` to `3b00000`, replace with <br>
`/mtd/NOKIA_XS-010X-Q/patch/kernel0.bin`, and save the file.<br>
3. Use programmer to write the modified firmware back to flash memory.

## Nokia XS-010X-R

Send the manufacturing-test Ethernet frame first to enable factory mode and factory-test user.

1. Connect PC directly to the 10GE port.
2. Send the following Layer-2 broadcast frame:

```text
Dst MAC:   ff:ff:ff:ff:ff:ff
EtherType: 0xc199
Payload:   00 00 00 01 + 42 bytes of 00
```

3. Connect via Telnet:

```text
telnet 192.168.100.1 / 192.168.188.1
Login as: ATE
Password: CATS2388
```

4. Switch to the root shell by executing the following command.

```
#ONT> system/shell
#ONT/System/Shell>
```
The factory-test mode is volatile and will be cleared after reboot.

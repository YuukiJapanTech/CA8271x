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
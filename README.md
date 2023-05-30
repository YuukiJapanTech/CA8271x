# Hacking CA8271x XGS-PON Stick

Some information has been created with the help of `@stich86_0046`. Thanks!

- Rewrite S/N, Loid, PLOAM, etc… for your ISP FTTx
- Rewrite cheap 10G-EPON Stick to XGS-PON Stick

# XGS-PON ONT

| 10GE/XGS-PON ONT | Vender | SoC | OEM | Mgmt IP | Mgmt | Config | URL |
| --- | --- | --- | --- | --- | --- | --- | --- |
| EN-XGSFPP-OMAC | E.C.I Networks | CA8271S | CIG XG-99S | 192.168.100.1 | UART/Telnet | scfg.txt | [Link](https://ecin.ca/xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/) |
| FOX222 | Frontier | CA8271A | CIG XG-99M | 192.168.188.1 | UART | scfg.txt | -   |
| LTF-726x-BH+ | Hisense | CA8271S | -   | 192.168.0.1 | UART/SSH/Web | scfg.txt | [Link](https://www.taobao.com/list/item/658650417501.htm) |
| NSD-G3000T<br>***Separation articles is planned*** | SONY |     | Sercomm MARINER | 192.168.1.1 | UART/Web | gponctl<br>sc\_ft\_data<br>sys_data<br>(unknown) | [Link](https://www.nuro.jp/device.html) |
| HN8255Ws (So-net)<br>***Separation articles is planned*** | Synclayer |     | Huawei | 192.168.1.1 | Web/Telnet | Web (snc_admin) |     |

# Login Password
The following link summarizes Password.
- [ONT Login Password](/Password.md)

# scfg.txt
The following link summarizes scfg.txt (ONT configuration files)

- [ONT scfg.txt files (CORTINA SoC Configuration file)](/scfg_files)

# UART pin
The following link summarizes UART pin.

- Link

# How to get root CLI & root Shell
## LTF-726x-BH+
Connect via `SSH` or `UART` to obtain root shell.

## EN-XGSFPP-OMAC, FOX222 (XG-99x)
After logging in via `telnet` or `UART`, you will first get the CLI with user privileges.
```
ONT>
```
The root CLI can be obtained by executing the `enable` command on this CLI.
```
ONT> enable
#ONT>
```
The root shell can be obtained by executing the following command in the root CLI.
```
#ONT> system/shell
#ONT/System/Shell> sh
#
```

There are several other commands in the root CLI.
The following is a list of typical commands,

- `/traffic/pon/show onu`<br>
Obtain ont's authentication status, SN, LOID password, PLOAM password, etc.
- `/system/misc`<br>
Change the SN, vendor, PLOAM password, and other settings stored in its custom ROM (mtd9, mtd10)<br>
- `/system/mib/show "MIB No."`<br>
Get MIB values.<br>
example,<br>
`#ONT> /system/mib/show 256`<br>
`/system/mib/show ?` command can get a list of supported MIBs.<br>

# ONT config

The following link summarizes ONT configuration.

- [ONT Configuration](/Configuration.md)


# This document is a work in progress. More updates will follow.
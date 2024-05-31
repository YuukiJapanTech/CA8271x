# Hacking CA8271x XGS-PON Stick

- Rewrite S/N, Loid, PLOAM, etc… for your ISP FTTx
- Switch between 10GEPON and XGSPON.

This content is maintained by reverse engineering by enthusiasts. Use of this content is at your own risk!

# XGS-PON ONT

| 10GE/XGS-PON ONT | Form | PON | SoC | OEM | Mgmt IP | Mgmt |
| --- | --- | --- | --- | --- | --- | --- |
| [CIG XG-99S](https://www.cigtech.com/product_portfolio/xg-99x-3/) | SFP+ | XGS | CA8271S | -   | 192.168.100.1 | UART/Telnet |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | SFP+ | 10GE | CA8271S | -   | 192.168.0.1 | UART/Telnet/SSH |
| [ECIN EN-XGSFPP-OMAC-V1](https://ecin.ca/xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/)<br>***End of Sales*** | SFP+ | XGS | CA8271S | CIG XG-99S (old model) | 192.168.100.1 | UART/Telnet |
| [ECIN EN-XGSFPP-OMAC-V2](https://ecin.ca/custom-xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/)<br>***Not CA8271x SoC*** | SFP+ | XGS | ***MxL PRX126*** | AZORES WAS-110 | 192.168.11.1 | Telnet/Web |
| [FS XGS-ONU-25-20NI](https://www.fs.com/jp/products/185594.html) | SFP+ | XGS | CA8271S | CIG XG-99S | 192.168.100.1 | UART/Telnet |
| [Hisense LTF-7263-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | 10GE (XGS, XG) | CA8271S | -   | 192.168.0.1 | UART/SSH/Web |
| [Hisense LTF-7267-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | XGS, XG (10GE) | CA8271S | -   | 192.168.0.1 | UART/SSH/Web |
| NATYWISH LTF-7267-BH+ | SFP+ | XGS | CA8271S | Hisense LTF-7267-BH+<br>(NATYWISH Custom Farm) | 192.168.1.1 | UART/Telnet/Web |
| XGS800E | SFP+ | XGS, XG (10GE) | CA8271S | Hisense LTF-7267-BH+ | 192.168.0.1 | UART/Telnet/Web |
| [CIG XG-99M](https://www.cigtech.com/product_portfolio/xg-99m/) | ONT | XGS | CA8271A | -   | 192.168.0.1 | UART/Telnet |
| Frontier FOX222 | ONT | XGS | CA8271A | CIG XG-99M | 192.168.188.1 | UART |
| NTT 10G-EPON &lt;O&gt;C ONU &lt;4&gt; | ONT | 10GE | NLD0605APB<br>(CA8271 OEM) | - | 192.168.1.1 | UART |
| NTT 10G-EPON &lt;M&gt;C ONU &lt;4&gt; | ONT | 10GE | NLD0605APB<br>(CA8271 OEM) | - | 192.168.1.1 | UART |

The CIG XE-99S and CIG XG-99S (and OEM’s) have the same hardware and can be switched by replacing the firmware.

# Quick Start
## XGS-PON
For the quick start of XGS-PON, we are porting it to **[Hack-GPON.org](https://hack-gpon.org/xgs/ont-fs-XGS-ONU-25-20NI/)** !<br>

## Quick script
A useful script has been developed by [@rssor](https://github.com/rssor)
[FS.com XGS-ONU-25-20NI / CIG XG-99S Modification Utility](https://github.com/rssor/fs_xgspon_mod)

## xPON SFP ONU (RTL960x)
The RLT960x hacking was carried out by [@anime4000](https://github.com/Anime4000) <br>
For RTL960x xPON Hacking, checkout [@anime4000](https://github.com/Anime4000) on **[Hacking RTL960x](https://github.com/Anime4000/RTL960x)** !

## AZORES WAS-110 (MxL PRX126)
The RLT960x hacking was carried out by 8311 community.<br>
For WAS-110 Hacking, checkout **[PON dot WIKI](https://pon.wiki/category/was-110/)** !

# Menu

- [UART pin](/doc/UART.md)
- [ONT Login Password](/doc/Password.md)
    - [emulate CIG ONT in QEMU](/emulate_CIG)
- [How to get root CLI & root Shell](/doc/rootShell.md)
- [ONT scfg.txt files (CORTINA SoC Configuration file)](/doc/scfg_files.md)
    - [default scfg.txt dump](/default_scfg)
- [ONT Configuration](/doc/Configuration.md)
    - [XG-99x Config Command](/doc/XG-99x_Config.md)
- [NAND dump](/NAND_dump)
    - [Switch between XGS and 10GE](/XG-XE_Switch)
    - [mtd dump & Bricked Stick Repair](/mtd)
- [Picture](/ONT_Picture) 

# switches dependent

- This Stick is reported to the SFP as an "unknown module". For this reason, some switches such as Alaxala will not link up. (i2c-0xA0 0x03 : 0x00)
- This Stick has its own vendor name registered in the vendor information, so it will not link up on switches with vendor lock enabled.
- Some switches may refuse to link up if the SFP LOS pin is High. In this case, fiber must be connected to the Stick.

# Collaborator
Some information has been created with the help of :
- [@stich86](https://github.com/stich86) 
- [@missing233](https://github.com/missing233) 
- [rssor](https://github.com/rssor)

Thanks!



* * *

# This document is a work in progress. More updates will follow.
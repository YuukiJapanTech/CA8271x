# Hacking CA8271x XGS-PON Stick

Some information has been created with the help of `@stich86_0046`. Thanks!

- Rewrite S/N, Loid, PLOAM, etc… for your ISP FTTx

# XGS-PON ONT

| 10GE/XGS-PON ONT | Form | PON | SoC | OEM | Mgmt IP | Mgmt |
| --- | --- | --- | --- | --- | --- | --- |
| [CIG XG-99S](https://www.cigtech.com/product_portfolio/xg-99x-3/) | SFP+ | XGS | CA8271S | -   | 192.168.100.1 | UART/Telnet |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | SFP+ | 10GE | CA8271S | -   | 192.168.0.1 | UART/Telnet |
| [ECIN EN-XGSFPP-OMAC](https://ecin.ca/xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/) | SFP+ | XGS | CA8271S | CIG XG-99S | 192.168.100.1 | UART/Telnet |
| [ECIN EN-XGSFPP-OMAC-V2](https://ecin.ca/custom-xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/)<br>***Not CA8271x SoC*** | SFP+ | XGS | ***MxL PRX126*** | AZORES WAS-110 | 192.168.11.1 | Telnet/Web |
| [FS XGS-ONU-25-20NI](https://www.fs.com/jp/products/185594.html) | SFP+ | XGS | CA8271S | CIG XG-99S | 192.168.100.1 | UART/Telnet |
| [Hisense LTF-726x-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | 10GE/XGS? | CA8271S | -   | 192.168.0.1 | UART/SSH/Web |
| [CIG XG-99M](https://www.cigtech.com/product_portfolio/xg-99m/) | ONT | XGS | CA8271A | -   | 192.168.0.1 | UART/Telnet |
| Frontier FOX222 | ONT | XGS | CA8271A | CIG XG-99M | 192.168.188.1 | UART |

<br>
TheCIG XE-99S and CIG XG-99S (and OEM's) have the same hardware and can be switched by replacing the firmware.<br>

# Menu

- [UART pin](/doc/UART.md)
- [ONT Login Password](/doc/Password.md)
    - [emulate CIG ONT in QEMU](/emulate_CIG)
- [How to get root CLI & root Shell](/doc/rootShell.md)
- [ONT scfg.txt files (CORTINA SoC Configuration file)](/doc/scfg_files.md)
    - [default scfg.txt dump](/default_scfg)
- [ONT Configuration](/doc/Configuration.md)
    - [XG-99x Config Command](/doc/XG-99x_Config.md)
    - LTF-726x-BH+ Config
- [NAND dump](/NAND_dump)

# Picture

### FS XGS-ONU-25-20NI

![XGS-ONU-25-20NI Stick](/Picture/FSCOM_XGS-ONU-25-20NI/Stick.jpg)

### CIG XE-99S

![XE-99S Stick](/Picture/XE-99S/Stick.jpg)

### Hisense LTF-726x-BH+

![LTF-726x-BH+ Stick](/Picture/LTF726x/Stick.jpg)

* * *

# This document is a work in progress. More updates will follow.
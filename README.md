# Hacking CA8271x and CA8289x XGS-PON/10GE-PON ONT

- Rewrite S/N, Loid, PLOAM, etc… for your ISP FTTx
- Switch between 10GEPON and XGS-PON.

> [!CAUTION]
> Use of this content is at your own risk!
> * This content is maintained by reverse engineering by enthusiasts.
> * If ISP service is suspended due to modified ONT connected, you may be subject to punishment under the laws of your country.
> * The creator of this content assumes no responsibility for any problems that may arise from this content.

# CA8271 / CA8289 SoC ONT
| Device | Form | SoC | PON | Mode | Kernel | OEM | Mgmt IP | Mgmt |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [CIG XG-99S](https://www.cigtech.com/product_portfolio/xg-99x-3/) | SFP+ | CA8271S | XGS | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | - | 192.168.100.1 | UART/Telnet |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | SFP+ | CA8271S | 10GE | SFU EPON | Linux-4.4.198.cig-R1.0.2.8 | - | 192.168.0.1 | UART/Telnet/SSH |
| [ECIN EN-XGSFPP-OMAC-V1](https://ecin.ca/xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/)<br>***End of Sales*** | SFP+ | CA8271S | XGS | PPTP | Linux-4.4.140.saturn-sfpplus-R1 | CIG XG-99S (old model) | 192.168.100.1 | UART/Telnet |
| [FS XGS-ONU-25-20NI](https://www.fs.com/jp/products/185594.html) | SFP+ | CA8271S | XGS | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | CIG XG-99S | 192.168.100.1 | UART/Telnet |
| [Hisense LTF-7263-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | CA8271S | 10GE | SFU EPON | Linux-4.4.198.saturn-sfpplus-r1 | - | 192.168.0.1 | UART/SSH/Web |
| [Hisense LTF-7267-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | CA8271S | XGS, XG | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | - | 192.168.0.1 | UART/SSH/Web |
| NATYWISH LTF-7267-BH+ | SFP+ | CA8271S | XGS | PPTP | Linux-4.14.172.saturn-sfpplus-r1 | Hisense LTF-7267-BH+<br>(NATYWISH Custom Farm) | 192.168.1.1 | UART/Telnet/Web |
| XGS800E | SFP+ | CA8271S | XGS, XG | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | Hisense LTF-7267-BH+ | 192.168.0.1 | UART/Telnet/Web |
| [CIG XG-99M](https://www.cigtech.com/product_portfolio/xg-99m/) | ONT | CA8271A | XGS | PPTP | Linux-4.4.140.saturn-sfu-R1.0.0 | - | 192.168.0.1 | UART/Telnet |
| Frontier FOX222 | ONT | CA8271A | XGS | PPTP | Linux-4.4.140.saturn-sfu-R1.0.0 | CIG XG-99M | 192.168.188.1 | UART |
| NTT 10G-EPON &lt;O&gt;C ONU &lt;4&gt; | ONT | NLD0605APB (CA8271 OEM) | 10GE | SFU EPON<br>(SIEPON-B) | Linux-4.14.172.saturn2-sfu-r2.1 | - | 192.168.1.1 | UART |
| NTT 10G-EPON &lt;M&gt;C ONU &lt;4&gt; | ONT | NLD0605APB (CA8271 OEM) | 10GE | SFU EPON<br>(SIEPON-B) | Linux-4.14.172.saturn2-sfu-r2.1 | - | 192.168.1.1 | UART |
| HOSECOM X67S | ONT | RTL9615C (CA8289 Customize) | XGS, XG | PPTP/VEIP | RTK arm64 kernel 5.10.70 | - | 192.168.1.1 | UART/Telnet/SSH/Web |
| NEC BL3000HM | HGU | CA8289 | 10GE | HGU EPON<br>(SIEPON-C) | Poky (Yocto Project Reference Distro)/4.14/venus-eng-emmc | - | 192.168.0.1 | UART/Telnet/Web |
| [Nokia XS-2426X-A](https://device.report/m/0d8026c89c07e6bfca963368c018fd8b4ca689ef2bcf32f56794b3ab2b78b119/) | HGU | CA8289 | XGS | PPTP/VEIP | ? | - | ? | Web |
| [Nokia XS-2426G-B](https://fcc.report/FCC-ID/2ADZRXS2426GB/5593067.pdf) | HGU | CA8289 | XGS | PPTP/VEIP | ? | - | ? | Web |
| [Nokia WiFi Beacon G6](https://device.report/m/89a7e8e644b326c7030274954d16a3452c2f5c2d0792383bb53eae670b3cae78/) | AP | CA8289 | - | - | ? | - | ? | UART |
| [NTT XG-100NE](https://web116.jp/shop/hikari_r/xg_100ne/xg_100ne_00.html) | Router | CA7774 | - | - | Poky (Yocto Project Reference Distro)/4.4/g3-eng-emmc | - | 192.168.1.1 | Telnet/Web/RCE |

> [!TIP]
> The CIG XE-99S and CIG XG-99S (and OEM’s) have the same hardware and can be switched by replacing the firmware.

# Gide, Info
1. Shell access
    * [How to get root CLI & root Shell](/doc/rootShell.md)
    * [ONT Login Password](/doc/Password.md)
    * [emulate CIG ONT in QEMU](/emulate_CIG/README.md)
2. Configration
    * [ONT scfg.txt files (CORTINA SoC Configuration file)](/doc/scfg_files.md)
      * [default scfg.txt dump](/default_scfg)
    * [XG-99x Config Command](/doc/XG-99x_Config.md)
3. Firmware Modify & Reaper
    * [Dump images & Bricked Stick Repair](/mtd/README.md)
    * [Switch between XGS and 10GE](/XG-XE_Switch/)
    * [UART pin](/doc/UART.md)
4. Device & SoC info
    * [ONT devices Picture](/ONT_Picture/README.md)
    * [Device-tree Source code](/dts/)

> [!NOTE]
> Hardware dependent.
> * This Stick is reported to the SFP as an "unknown module". For this reason, some switches such as Alaxala will not link up. (i2c-0xA0 0x03 : 0x00)
> * This Stick has its own vendor name registered in the vendor information, so it will not link up on switches with vendor lock enabled.
> * Some switches may refuse to link up if the SFP LOS pin is High. In this case, fiber must be connected to the Stick.

# CORTINA family
| family | CPU | Applications |
| --- | --- | --- |
| CA8271 | MIPS R3000 | This is an SoC optimized for SFU ONTs, providing the minimum PHY ports required for a bridge device, and the CPU uses the power-efficient MIPS architecture. |
| CA8289 | AArch64 Cortex-A55</br>4 Cores | This SoC is optimized for HGU ONT, equipped with PHY for connecting multiple LAN devices, USB3.0, and PCIe for connecting WiFi SoC. The CPU uses high-performance ARM architecture. |
| RTL9615C | AArch64 Cortex-A55</br>2 Cores | This SoC is a low-cost version customized based on the CA8289. The ARM core and memory channels are halved, and the interfaces are two XFIs and one 1G LAN. USB and PCIe are probably omitted. |
| CA7774 | AArch64 Cortex-A53</br>4 Cores | This SoC is optimized for HGU routers. It has almost the same functions as the CA8289, and the CPU is Cortex-A53. It is for routers, so the PON IF is omitted. |

# SoC CodeName
| SoC | family | CodeName | OEM Vendor | Applications |
| --- | --- |--- | --- | --- |
| CA8271A | CA8271 | SATURN | CORTINA | Cable TV RF / PON SFU ONT |
| CA8271S | CA8271 | SATURN | CORTINA | SFP+ ONT Stick |
| NLD0605APB | CA8271 | SATURN2 | NTT Electronics | NTT-East/West 10GE-PON ONU in japan
| CA8289 | CA8289 | VENUS | CORTINA | PON HGU ONT |
| RTL9615C | CA8289 base | TAURUS | Realtek | Realtek XG/XGS PON ONT |
| CA7774 | CA7774 | G3 | CORTINA | Router ( Without PON ) |

# Links
* XGS-PON quick start
    For the quick start of XGS-PON.
    * **[Hack-GPON.org](https://hack-gpon.org/xgs/ont-fs-XGS-ONU-25-20NI/)**
* Quick script
    A useful script has been developed by [@rssor](https://github.com/rssor)
    * **[FS.com XGS-ONU-25-20NI / CIG XG-99S Modification Utility](https://github.com/rssor/fs_xgspon_mod)**
* xPON SFP ONU (RTL960x)
    The RLT960x hacking was carried out by [@anime4000](https://github.com/Anime4000)
    * **[Hacking RTL960x](https://github.com/Anime4000/RTL960x)**
* AZORES WAS-110 (MxL PRX126)
    The WAS-110 hacking was carried out by 8311 community.
    * **[PON dot WIKI](https://pon.wiki/category/was-110/)**

# Collaborator
Some information has been created with the help of :
* [@stich86](https://github.com/stich86) 
* [@missing233](https://github.com/missing233) 
* [rssor](https://github.com/rssor)

Thanks!

* * *

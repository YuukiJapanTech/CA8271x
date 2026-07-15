# Hacking CA8271x / CA8289x XGS-PON & 10G-EPON ONTs

![OGI](/Picture/OPENPON/ONF_TMP.png)
This project is a member of the OPEN PON FOUNDATION, led by [Hacking RTL960x](https://github.com/Anime4000/RTL960x).

## Features

- 🔓 Rewrite Serial Number, LOID, PLOAM and ISP credentials
- 🔄 Switch between **10G-EPON** and **XGS-PON**
- 🛠 Root shell, firmware modification and recovery
- 📚 Device compatibility database
- 🌏 Support SIEPON-A ISPs ( **auひかり, eoひかり, コミュファひかり, Free/Iliad, etc** )

## Table of Contents

- [EPON](#epon-ont)
- [GPON](#gpon-ont)
- [Guide, Document](#guide-document)
- [SoC Family](#cortina-family)

> [!CAUTION]
> Use of this content is at your own risk!
> * This content is maintained by reverse engineering by enthusiasts.
> * If ISP service is suspended due to modified ONT connected, you may be subject to punishment under the laws of your country.
> * The creator of this content assumes no responsibility for any problems that may arise from this content.
> 
> **This project promotes open knowledge and interoperability.**<br>
> **Do not endanger shared infrastructure, Do not disrupt others.**

---

# EPON ONT
10G EPON can be broadly categorized into the following three standards defined by IEEE 1904.1:
* **SIEPON-A ( CableLabs DOCSIS DPoE-OAM )**
  Used by ISPs in the United States, Europe, Japan, and many other countries worldwide.
    * [auひかり 🇯🇵](https://www.au.com/internet/)
    * [eo光 🇯🇵](https://eonet.jp/)
    * [コミュファ光 🇯🇵](https://www.commufa.jp/)
    * [MegaEGG 🇯🇵](https://www.megaegg.jp/)
    * [Free/Iliad 🇫🇷 🇮🇹](https://www.iliad.fr/)
    * [Xfinity 🇺🇸](https://www.xfinity.com/learn/internet-service)
    * [Spectrum 🇺🇸](https://www.spectrum-isp.com/)
* **SIEPON-B ( NTT-OAM )**
  Used exclusively by NTT East and NTT West in Japan.
    * [NTT東日本 🇯🇵](https://www.ntt-east.co.jp/)
    * [NTT西日本 🇯🇵](https://www.ntt-west.co.jp/)
* **SIEPON-C ( ChinaTelecom-OAM )**
  Used only by ISPs within China.
    * [中国电信 🇨🇳](https://www.chinatelecom.com.cn/)
    * [中国联通 🇨🇳](https://www.chinaunicom.com/)
    * [中国移动 🇨🇳](https://www.10086.cn/index/bj/index_100_100.html)

Most commercially available ONTs are manufactured in China and support only SIEPON-C.
However, by flashing custom firmware onto these ONTs, it is possible to enable support for SIEPON-A.

## CA8271S Devices ( Stick )
| Device | Default EPON | Mgmt IP | SIEPON-A Firm Support |
| ------ | ------------ | ------- |------------- |
| [Hisense LTF-7263-BH+](https://ja.aliexpress.com/item/1005005067825095.html) | SIEPON-C | 192.168.0.1 | ✅ |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | SIEPON-C | 192.168.0.1 | ✅ |

> [!TIP]
> The following devices use the same hardware and can be switched by changing the firmware.
> * **CIG XE-99S compatible.**
>   * [FS XGSPON ONU Stick SFP+,N1,Ind (SKU:185594)](https://www.fs.com/jp/products/185594.html)
>   * CIG XG-99S
>   * ECIN EN-XGSFPP-OMAC-V1
> * **Hisense LTF-7263-BH+ compatible.**
>   * Hisense LTF-7267-BH+
>   * XGS800E
>
> You can also flash the SIEPON-A firmware onto these devices.

## CA8271 / CA8289 EPON Devices
All SIEPON-A ONTs in the table below can be replaced with stick-type custom firmware.
| Device | EPON | SoC |
| ------ | ------------ | --- |
| NTT 10G-EPON &lt;O&gt;C ONU &lt;4&gt; | SIEPON-B | NLD0605APB (CA8271 OEM) |
| NTT 10G-EPON &lt;M&gt;C ONU &lt;4&gt; | SIEPON-B | NLD0605APB (CA8271 OEM) |
| NEC BL3000HM | SIEPON-A | CA8289 |
| Sumitomo FTE7263R | SIEPON-A | CA8271A |

## Other EPON Devices
All SIEPON-A ONTs in the table below can be replaced with stick-type custom firmware.
| Device | EPON | SoC |
| ------ | ---- | --- |
| NEC H03XS1 | SIEPON-A | BCM55030 |
| NEC H03XS2 | SIEPON-A | BCM55030 |
| Sercomm BL4000HM | SIEPON-A | BCM68572 |
| DASAN H710 | SIEPON-A | BCM55030 |
| NOKIA XE-040G-A | SIEPON-A | BCM55030 |
| NOKIA NKFN11AEL | SIEPON-A | Broadcom ? |
| Free/Iliad F-MDCONU3A (v1) | SIEPON-A | BCM55030 |
| Free/Iliad F-MDCONU5A (v2) | SIEPON-A | BCM55030 |
| Free/Iliad P-MDONU4B (pro) | SIEPON-A | ? |

# GPON ONT
XG-PON / XGS-PON mainly use the following two transmission modes:
* PPTP
* VEIP

While many ISPs adopt VEIP, most ONTs based on the CA8271x currently do not support VEIP.

## CA8271S Devices ( Stick )
| Device | GPON | Mgmt IP | Info |
| ------ | ---- | ------- | ---- |
| CIG XG-99S | PPTP | 192.168.100.1 | |
| ECIN EN-XGSFPP-OMAC-V1 | PPTP |192.168.100.1 | CIG XG-99S OEM |
| [FS XGSPON ONU Stick SFP+,N1,Ind (SKU:185594)](https://www.fs.com/jp/products/185594.html) | PPTP |192.168.100.1 | CIG XG-99S OEM, **NOT SKU:378865** |
| Hisense LTF-7267-BH+ | PPTP | 192.168.0.1 | |
| NATYWISH LTF-7267-BH+ | PPTP | 192.168.1.1 | Hisense LTF-7267-BH+ NATYWISH Custom Firm |
| XGS800E | PPTP |192.168.0.1 | Hisense LTF-7267-BH+ OEM |

> [!TIP]
> The following devices use the same hardware and can be switched by changing the firmware.
> * **CIG XG-99S compatible.**
>   * CIG XE-99S
> * **Hisense LTF-7267-BH+ compatible.**
>   * Hisense LTF-7263-BH+

## CA8271 / CA8289 GPON Devices
| Device | GPON | Mgmt IP | SoC | Info |
| ------ | ---- | ------- | --- | ---- |
| CIG XG-99M | PPTP | 192.168.0.1 | CA8271A | |
| Frontier FOX222 | PPTP | 192.168.188.1 | CA8271A | CIG XG-99M OEM |
| HOSECOM X67S | PPTP VEIP | 192.168.1.1 | RTL9615C | |
| Nokia XS-2426X-A | PPTP VEIP | | CA8289 | |
| Nokia XS-2426G-B | PPTP VEIP | | CA8289 | |

# Guide, Document
1. SIEPON-A Custom Firmware
    * [Quick Start](/mod/siepon_a/)
    * [SIEPON-A Firmware Configuration](/mod/siepon_a/config.md)
    * [au-hikari (Japan) ONT MAC Address](/mod/siepon_a/kddi.md)
    * [sample ONT TLV List (pdf)](/mod/siepon_a/TLV_LIST.pdf)
2. Shell access
    * [How to get root CLI & root Shell](/doc/rootShell.md)
    * [ONT Login Password](/doc/Password.md)
    * [emulate CIG ONT in QEMU](/emulate_CIG/README.md)
3. Configuration
    * [ONT scfg.txt files (CORTINA SoC Configuration file)](/doc/scfg_files.md)
      * [default scfg.txt dump](/default_scfg)
    * [XG-99x Config Command](/doc/XG-99x_Config.md)
4. Firmware Modification & Recovery
    * [Dump images & Bricked Stick Repair](/mtd/README.md)
    * [Switch between XGS and 10GE](/XG-XE_Switch/)
    * [UART pin](/doc/UART.md)
5. Device & SoC info
    * [CA8271 / CA8289 ONT list](/doc/ONT_List.md)
    * [ONT devices Picture](/ONT_Picture/README.md)
    * [Device-tree Source code](/dts/)

> [!NOTE]
> Hardware dependent.
> * This stick has a unique vendor name registered in its vendor information, the vendor information needs to be rewritten when connecting it to a switch with vendor locking enabled.
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
* Utility Script
    A useful script has been developed by [@rssor](https://github.com/rssor)
    * **[FS.com XGS-ONU-25-20NI / CIG XG-99S Modification Utility](https://github.com/rssor/fs_xgspon_mod)**
* xPON SFP ONU (RTL960x)
    The RLT960x hacking was carried out by [@anime4000](https://github.com/Anime4000)
    * **[Hacking RTL960x](https://github.com/Anime4000/RTL960x)**
* AZORES WAS-110 (MxL PRX126)
    The WAS-110 hacking was carried out by 8311 community.
    * **[PON dot WIKI](https://pon.wiki/category/was-110/)**
* CableLabs DPoE 1.0
    * **[DPoE OAM Extensions Specification
Version C01 (newest version)](https://www.cablelabs.com/specifications/dpoe-oam-extensions-specification)**
* CableLabs DPoE 2.0
    * **[DPoE OAM Extensions Specification
Version I15 (newest version)](https://www.cablelabs.com/specifications/DPoE-SP-OAMv2.0)**

# Contributors
Some information has been created with the help of :
* [@stich86](https://github.com/stich86) 
* [@missing233](https://github.com/missing233) 
* [rssor](https://github.com/rssor)

Thanks!

* * *

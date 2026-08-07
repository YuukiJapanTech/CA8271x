
# CA8271 / CA8289 SoC ONT
| Device | Form | SoC | PON | Mode | Kernel | OEM | Mgmt IP | Mgmt |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [CIG XG-99S](https://www.cigtech.com/product_portfolio/xg-99x-3/) | SFP+ | CA8271S | XGS | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | - | 192.168.100.1 | UART/Telnet |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | SFP+ | CA8271S | 10GE | SFU EPON | Linux-4.4.198.cig-R1.0.2.8 | - | 192.168.0.1 | UART/Telnet/SSH |
| [ECIN EN-XGSFPP-OMAC-V1](https://ecin.ca/xgs-pon-sfp-stick-module-xgspon-ont-w-t-mac-function-mounted-on-sfp-package/)<br>***End of Sales*** | SFP+ | CA8271S | XGS | PPTP | Linux-4.4.140.saturn-sfpplus-R1 | CIG XG-99S (old model) | 192.168.100.1 | UART/Telnet |
| [FS XGSPON ONU Stick SFP+,N1,Ind (SKU:185594)](https://www.fs.com/jp/products/185594.html) | SFP+ | CA8271S | XGS | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | CIG XG-99S | 192.168.100.1 | UART/Telnet |
| [Hisense LTF-7263-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | CA8271S | 10GE | SFU EPON | Linux-4.4.198.saturn-sfpplus-r1 | - | 192.168.0.1 | UART/SSH/Web |
| [Hisense LTF-7267-BH+](https://www.taobao.com/list/item/658650417501.htm) | SFP+ | CA8271S | XGS, XG | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | - | 192.168.0.1 | UART/SSH/Web |
| NATYWISH LTF-7267-BH+ | SFP+ | CA8271S | XGS | PPTP | Linux-4.14.172.saturn-sfpplus-r1 | Hisense LTF-7267-BH+<br>(NATYWISH Custom Farm) | 192.168.1.1 | UART/Telnet/Web |
| XGS800E | SFP+ | CA8271S | XGS, XG | PPTP | Linux-4.4.198.saturn-sfpplus-r1 | Hisense LTF-7267-BH+ | 192.168.0.1 | UART/Telnet/Web |
| [CIG XG-99M](https://www.cigtech.com/product_portfolio/xg-99m/) | ONT | CA8271A | XGS | PPTP | Linux-4.4.140.saturn-sfu-R1.0.0 | - | 192.168.0.1 | UART/Telnet |
| Frontier FOX222 | ONT | CA8271A | XGS | PPTP | Linux-4.4.140.saturn-sfu-R1.0.0 | CIG XG-99M | 192.168.188.1 | UART |
| Nokia XS-010X-R | ONT | CA8271NI | XGS | PPTP | Linux-4.14.172.saturn2-sfu-r2.2.1.3 | CIG XG-99YR | 192.168.100.1 / 192.168.188.1 | Telnet/Web |
| NTT 10G-EPON &lt;O&gt;C ONU &lt;4&gt; | ONT | NLD0605APB (CA8271 OEM) | 10GE | SFU EPON<br>(SIEPON-B) | Linux-4.14.172.saturn2-sfu-r2.1 | - | 192.168.1.1 | UART |
| NTT 10G-EPON &lt;M&gt;C ONU &lt;4&gt; | ONT | NLD0605APB (CA8271 OEM) | 10GE | SFU EPON<br>(SIEPON-B) | Linux-4.14.172.saturn2-sfu-r2.1 | - | 192.168.1.1 | UART |
| HOSECOM X67S | ONT | RTL9615C (CA8289 Customize) | XGS, XG | PPTP/VEIP | RTK arm64 kernel 5.10.70 | - | 192.168.1.1 | UART/Telnet/SSH/Web |
| NEC BL3000HM | HGU | CA8289 | 10GE | HGU EPON<br>(SIEPON-C) | Poky (Yocto Project Reference Distro)/4.14/venus-eng-emmc | - | 192.168.0.1 | UART/Telnet/Web |
| [Nokia XS-2426X-A](https://device.report/m/0d8026c89c07e6bfca963368c018fd8b4ca689ef2bcf32f56794b3ab2b78b119/) | HGU | CA8289 | XGS | PPTP/VEIP | ? | - | ? | Web |
| [Nokia XS-2426G-B](https://fcc.report/FCC-ID/2ADZRXS2426GB/5593067.pdf) | HGU | CA8289 | XGS | PPTP/VEIP | ? | - | ? | Web |
| [Nokia WiFi Beacon G6](https://device.report/m/89a7e8e644b326c7030274954d16a3452c2f5c2d0792383bb53eae670b3cae78/) | AP | CA8289 | - | - | ? | - | ? | UART |
| [NTT XG-100NE](https://web116.jp/shop/hikari_r/xg_100ne/xg_100ne_00.html) | Router | CA7774 | - | - | Poky (Yocto Project Reference Distro)/4.4/g3-eng-emmc | - | 192.168.1.1 | Telnet/Web/RCE |

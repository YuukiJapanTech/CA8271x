# au-hikari (Japan) ONT MAC Address
For au Hikari, a SIEPON-A ISP in Japan, the ONT’s MAC address is not printed on the device enclosure.
Therefore, when using a stick, you must determine the ONT’s EPON MAC address by other means.

## BL3000HM
If you are using a BL3000HM as the ONT, the EPON MAC address can be derived from the label on the back of the device.

The EPON MAC address is equal to the "MACアドレス(WAN)" + `1`.

Example:
MACアドレス(WAN) : `11:22:33:AA:BB:CC`
EPON MAC Address : `11:22:33:AA:BB:CD`

![BL3000HM Label](/Picture/kddi_mac/BL3k_MAC.JPG)

## BL4000HM
If you are using a BL4000HM as the ONT, the EPON MAC address can be derived from the label on the back of the device.

The EPON MAC address is equal to the "MACアドレス(WAN)" + `1`.

Example:
MACアドレス(WAN) : `11:22:33:AA:BB:CC`
EPON MAC Address : `11:22:33:AA:BB:CD`

![BL4000HM Label](/Picture/kddi_mac/BL4k_MAC.JPG)

## H03XS1 / H03XS2
If you are using an H03XS1 / H03XS2, you need to access the internal UART interface to obtain the MAC address.

### 1. Disassemble the ONT
The ONT can be opened by removing a single screw on the back panel.

![BL3000HM Label](/Picture/kddi_mac/H03XS2_Unit.JPG)

### 2. Connect to UART
Use a USB-to-UART adapter and connect as follows:

* TXD : Pin 1 (input)
* RXD : Pin 2 (output)
* GND : pin 4 or a ground via (through-hole)
* Bps : `57600 bps`

![BL3000HM Label](/Picture/kddi_mac/H03XS2_UART.JPG)

### 3. Run Command
Execute the following command to display the EPON MAC address:
```
2000/>mac
2000/mac/>epon
EPON  MAC: 112233AABBCC
2000/mac/>
```

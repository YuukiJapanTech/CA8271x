# SIEPON-A Firmware Configuration

In addition to the PON MAC address, the SIEPON-A custom firmware allows configuration of PON behavior and TLV information reported to the OLT.

## SSH
You can access the stick via SSH:

| IP | User | Password |
| -- | ---- | -------- |
| 192.168.0.1 | `root` | `ca8271` |

## WebUI
The custom firmware provides two Web UIs:

* Main Web UI (Custom Firmware)
  Used to configure the stick and monitor PON status.

  | URL | User | Password |
  | --- | ---- | -------- |
  | http://192.168.0.1 | admin | admin |

* Base Firmware Web UI
  This is the original Hisense firmware Web UI. It is mainly used to check temperature and optical module information.

  | URL | User | Password |
  | --- | ---- | -------- |
  | http://192.168.0.1:88 | admin | system |

## Main WebUI menu
![SIEPON-A Firm WebUI](/Picture/siepon_a/menu.png)

### Status
Displays PON status and ONT information.

#### PON Status
* AUTH : Becomes *OK* when the ONT is authenticated by the OLT and MPCP upstream traffic is enabled.
* PON : Becomes *OK* when the ONT connects to the OLT and completes MPCP registration.
* POWER : Indicates the power state of the stick. Always *OK* if the Web UI is accessible.

#### OLT Info
* OLT MAC : Displays the MAC address of the connected OLT.

#### ONU Info
* Version : Custom firmware version
* Base Version : Version of the underlying Hisense firmware

### PON MAC Address
Sets the EPON MAC address of the ONT.<br>
Stored in:
* `/config/scfg.txt`
   * `MAC CFG_ID_MAC_ADDRESS`

### Forced Bridge mode
#### Forced Bridge mode (Enable / Disable)
When enabled, the stick ignores packet forwarding rules from the OLT and forcibly bridges LLID 0–15 with the UNI interface.
If the ISP requires 802.1X authentication, it will be bypassed.<br>
Stored in:
* `UbootENV`
   * `CA8271_FORCE_BRIDGE`

#### MAC Filter
When configured, the stick forwards only packets sent from the specified MAC address to the OLT.
***If your ISP provides an HGW (Home Gateway), it is recommended to configure the MAC filter to maintain proper network behavior.***
Setting `00:00:00:00:00:00` disables the MAC filter.<br>

Stored in:
* `UbootENV`
   * `CA8271_FORCE_BRIDGE_MAC`

### Forced Traffic mode
When enabled, the stick ignores OLT authentication and forcibly enables MPCP upstream traffic.
This allows packet transmission even from ONTs that are not authorized (e.g., banned by the ISP).<br>

Stored in:
* `UbootENV`
   * `CA8271_FORCE_TRAFFIC`

### Firmware Info (D7/03)
Spoofs the ONT firmware information reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0003.<br>

Stored in:
* `UbootENV`
   * `CA8271_FW_BOOTVER`
   * `CA8271_FW_BOOTCRC`
   * `CA8271_FW_FWVER`
   * `CA8271_FW_FWCRC`

### Chipset Info (D7/04)
Spoofs the ONT chipset information reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0004.

Typical chipset identifiers:
| Chip | JDECID | Chip Model | Chip Version |
| ---- | ------ | ---------- | ------------ |
| CA8289 / CA8271 | 0879 | 4701 | 00001000 |
| BCM55030 | 0203 | 4701 | B2110816 |
| FTE7653R (CA8271) | 01F2 | 6858 | A17C0449 |

Stored in:
* `UbootENV`
   * `CA8271_CHIP_ID`
   * `CA8271_CHIP_MODEL`
* `/config/scfg.txt`
   * `CHAR-ARRAY CFG_ID_HW_VERSION`

### Date of Manufacture (D7/05)
Spoofs the manufacturing date reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0005.<br>

Stored in:
* `UbootENV`
   * `CA8271_MANU_YEAR`
   * `CA8271_MANU_MON`

### Manufacture Info (D7/06)
Spoofs vendor-specific ONT information reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0006.<br>

Stored in:
* `/etc/onu_manu_modle.ini`
   * `manu_info`


### Vendor Name (D7/11)
Spoofs the ONT vendor name reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0011.<br>

Stored in:
* `UbootENV`
   * `CA8271_VEN_NAME`

### Model Number (D7/12)
Spoofs the ONT model name reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0012.<br>

Stored in:
* `/etc/onu_manu_modle.ini`
   * `model`

### Hardware Version (D7/13)
Spoofs the ONT hardware version reported to the OLT.
This corresponds to DPoE 1.0 TLV D7/0013.<br>

Stored in:
* `UbootENV`
   * `CA8271_HW_VER`

### System IP
Changes the IP address of the ONT management interface.<br>

Stored in:
* `/etc/network/interfaces`
   * `eth0`

### Login Password
Changes the login password for the Main Web UI.

### ReBoot
Reboots the stick.


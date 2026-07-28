# SIEPON-A Firm QuickStart

This is custom firmware designed to enable SIEPON-A support on China-made stick-type ONTs.
By flashing it onto a supported device, the stick can operate with SIEPON-A.

![SIEPON-A Firm WebUI](/Picture/siepon_a/menu.png)

> [!WARNING]
> ***Never disconnect power from the stick while writing to flash. Doing so will brick the device.***
> 
> If the stick becomes bricked, refer to [mtd dump & Bricked Stick Repair](/mtd#bricked-stick-repair) <br>

## Support Stick
| Device | Mgmt IP | User | Password | Support |
| ------ | ------- | ---- | --------- |-------- |
| [Hisense LTF-7263-BH+](https://ja.aliexpress.com/item/1005005067825095.html) | 192.168.0.1 | `root` | `hbmtsfp` | ✅ |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | 192.168.0.1 | `root` | none | ✅ |
| [FS XGSPON ONU Stick SFP+,N1,Ind (SKU:185594)](https://www.fs.com/jp/products/185594.html) | 192.168.100.1 | `PON S/N` | [8digit HMAC-MD5 (PON S/N uppercase)](https://hack-gpon.org/xgs/ont-fs-XGS-ONU-25-20NI/#login-and-enable) | ✅ |
| CIG XG-99S | 192.168.100.1 | `PON S/N` | [8digit HMAC-MD5 (PON S/N uppercase)](https://hack-gpon.org/xgs/ont-fs-XGS-ONU-25-20NI/#login-and-enable) | ✅ |

> [!WARNING]
> FS currently sells PON Sticks under SKU:185594 and SKU:378865.<br>
> SKU:185594, which uses a built-in Cortina chip, supports custom firmware.<br>
> **SKU:378865 (Maxliear Chip) is not supported!**

## QuickStart
### 1. Obtain the Stick
Purchase the stick from AliExpress, Taobao, or FScom.
* https://ja.aliexpress.com/item/1005005067825095.html
* https://item.taobao.com/item.htm?id=695062358407
* https://www.fs.com/jp/products/185594.html

### 2. Configure IP Address
Set your PC’s IP address to :
* Hisense LTF-7263-BH+ / CIG XE-99S : `192.168.0.5/24`
* FS XGSPON ONU Stick / CIG XG-99S : `192.168.100.5/24`.

### 3. Download Custom Firmware
Download the following firmware files and place them on a TFTP server (e.g., 3CDaemon):
* `SIEPONA_rootfs.bin`
* `SIEPONA_kernel.bin`

### 4. Log in to the Stick root shell
Access the stick via SSH or telnet.

#### Hisense LTF-7263-BH+
```
$ ssh root@192.168.0.1
root@192.168.0.1's password: hbmtsfp

root@saturn-sfpplus-eng:~#
```

#### CIG XE-99S
```
$ ssh root@192.168.0.1

root@XE-99S:~#
```

#### FS XGSPON ONU Stick / CIG XG-99S
```
$ telnet 192.168.100.1

User: GPON2350004B
Password: UzwugGYT

ONT> enable
#ONT>system/shell
#ONT/System/Shell> sh
#
```

### 5. Upload Firmware to the Stick
Run the following commands to download the firmware via TFTP:
#### Hisense LTF-7263-BH+ / CIG XE-99S
```
cd /tmp
tftp -r SIEPONA_kernel.bin -g 192.168.0.5
tftp -r SIEPONA_rootfs.bin -g 192.168.0.5
```
#### FS XGSPON ONU Stick / CIG XG-99S
```
cd /tmp
tftp -r SIEPONA_kernel.bin -g 192.168.100.5
tftp -r SIEPONA_rootfs.bin -g 192.168.100.5
mkdir /userdata/upper
```

### 6. Reset Configuration
Reset the configuration files:
```
rm -r /overlay/upper/*
```

### 7. Flash the Firmware
Execute the following commands to write the firmware:
```
flash_erase /dev/$(awk -F: '$2 ~ /"kernel1"/ {print $1}' /proc/mtd) 0 0
nandwrite -p /dev/$(awk -F: '$2 ~ /"kernel1"/ {print $1}' /proc/mtd) /tmp/SIEPONA_kernel.bin
flash_erase /dev/$(awk -F: '$2 ~ /"rootfs1"/ {print $1}' /proc/mtd) 0 0
nandwrite -p /dev/$(awk -F: '$2 ~ /"rootfs1"/ {print $1}' /proc/mtd) /tmp/SIEPONA_rootfs.bin

flash_erase /dev/$(awk -F: '$2 ~ /"kernel0"/ {print $1}' /proc/mtd) 0 0
nandwrite -p /dev/$(awk -F: '$2 ~ /"kernel0"/ {print $1}' /proc/mtd) /tmp/SIEPONA_kernel.bin
flash_erase /dev/$(awk -F: '$2 ~ /"rootfs0"/ {print $1}' /proc/mtd) 0 0
nandwrite -p /dev/$(awk -F: '$2 ~ /"rootfs0"/ {print $1}' /proc/mtd) /tmp/SIEPONA_rootfs.bin
```

### 8. Reboot the Stick
Reboot or power off the device:
```
reboot
```
The reboot process takes approximately 180 seconds.
> [!TIP]
> If an error occurs with the reboot command, simply turn off the power.

### 9. Access the Web UI
Open the following URL in your browser:
* http://192.168.0.1

| User | Password |
| ---- | -------- |
| `admin` | `admin` |

### 10. Set PON MAC Address
From the menu, select "PON MAC Address" and configure the EPON MAC address of your ONT.

### 11. Configure Forced Bridge Mode
From the menu, select "Forced Bridge mode" and enable it.<br>
If your ISP provides an HGW (Home Gateway), set the HGW’s WAN MAC address in "MAC Filter".

### 12. Reboot the Stick
Select "Reboot" from the menu.
The reboot process takes approximately 180 seconds.

### 13. Connect the Fiber
Connect the ISP fiber cable to the stick.

### 14. ONT Authentication
Once authentication is successful, the "PON" and "AUTH" status indicators under the "Status" menu will show "OK".<br>
At this point, the stick is successfully connected to the ISP network.

### 15. Disguise as Cisco SFP+ module ( Optional )
To disguise an SFP as a genuine Cisco SFP module, execute the following command on the Stick:

```
$ ssh root@192.168.0.1
root@192.168.0.1's password: ca8271

root@saturn-sfpplus-eng:~# BOSA_Write /script/BOSA/cisco.txt
Start write. Stop SFP-IF...
```
> [!TIP]
> The Stick will automatically restart once the process is complete.

> [!CAUTION]
> The Hisense LTF-726x-BH+ does not support this command.

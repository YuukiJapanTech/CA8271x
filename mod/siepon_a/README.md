# SIEPON-A Firm QuickStart

This is custom firmware designed to enable SIEPON-A support on China-made stick-type ONTs.
By flashing it onto a supported device, the stick can operate with SIEPON-A.

![SIEPON-A Firm WebUI](/Picture/siepon_a/menu.png)

> [!WARNING]
> ***Never disconnect power from the stick while writing to flash. Doing so will brick the device.***
> 
> If the stick becomes bricked, refer to [mtd dump & Bricked Stick Repair](/mtd#bricked-stick-repair) <br>

## Support Stick
| Device | Default EPON | Mgmt IP | SIEPON-A Firm Support |
| ------ | ------------ | ------- |------------- |
| [Hisense LTF-7263-BH+](https://ja.aliexpress.com/item/1005005067825095.html) | SIEPON-C | 192.168.0.1 | ✅ |
| [CIG XE-99S](https://item.taobao.com/item.htm?id=695062358407) | SIEPON-C | 192.168.0.1 | ❌ |

## QuickStart
### 1. Obtain the Stick
Purchase a Hisense LTF-7263-BH+ from AliExpress or Taobao.
* https://ja.aliexpress.com/item/1005005067825095.html

### 2. Configure IP Address
Set your PC’s IP address to `192.168.0.2/24`.

### 3. Download Custom Firmware
Download the following firmware files and place them on a TFTP server (e.g., 3CDaemon):
* `SIEPONA_rootfs.bin`
* `SIEPONA_kernel.bin`

### 4. Log in to the Stick
Access the stick via SSH:

| IP | User | Password |
| -- | ---- | -------- |
| 192.168.0.1 | `root` | `hbmtsfp` |

### 5. Upload Firmware to the Stick
Run the following commands to download the firmware via TFTP:
```
cd /tmp
tftp -r SIEPONA_kernel.bin -g 192.168.0.2
tftp -r SIEPONA_rootfs.bin -g 192.168.0.2
```
### 6. Flash the Firmware
Execute the following commands to write the firmware:
```
flash_eraseall /dev/mtd6
flashcp -v /tmp/SIEPONA_kernel.bin /dev/mtd6
flash_eraseall /dev/mtd7
flashcp -v /tmp/SIEPONA_rootfs.bin /dev/mtd7

flash_eraseall /dev/mtd3
flashcp -v /tmp/SIEPONA_kernel.bin /dev/mtd3
flash_eraseall /dev/mtd4
flashcp -v /tmp/SIEPONA_rootfs.bin /dev/mtd4
```

### 7. Reset Configuration
Reset the configuration files:
```
rm -r /overlay/upper*
```

### 8. Reboot the Stick
Reboot the device:
```
reboot
```
The reboot process takes approximately 180 seconds.

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

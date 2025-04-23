# Dump images
This dump images can be used to repair bricked sticks, replace firmware, switch between XGS-PON and 10GE-PON, etc.

## Mtd dump files and partition list
* [CIG XE-99S](/mtd/CIG_XE-99S/README.md)
* [CIG XG-99C](/mtd/CIG_XG-99C/README.md)
* [CIG XG-99M](/mtd/CIG_XG-99M/README.md)
* [ECIN EN-XGSFPP-OMAC](/mtd/ECIN_EN-XGSFPP-OMAC/README.md)
* [FS XGS-ONU-25-20NI](/mtd/FS_XGS-ONU-25-20NI/README.md)
* [Hisense LTF-7263-BH+](/mtd/LTF7263/README.md)
* [NATYWISH LTF-7267-BH+](/mtd/NATYWISH_LTF7267/README.md)
* [NOKIA XS-010X-Q](/mtd/NOKIA_XS-010X-Q/README.md)
* [XGS800E](/mtd/XGS800E/README.md)
* [NTT 10G-EPON &lt;O&gt;C ONU &lt;4&gt;](/mtd/NTT_OCONU4/README.md)
* [NTT 10G-EPON &lt;M&gt;C ONU &lt;4&gt; (Hardware v1)](/mtd/NTT_MCONU4_HWVer01/README.md)
* [NTT 10G-EPON &lt;M&gt;C ONU &lt;4&gt; (Hardware v2)](/mtd/NTT_MCONU4_HWVer02/README.md)

## How to dump / write firmware from a Linux shell
To obtain a dump, use the `dd` command to save it on `/tmp`,
or use the cat command to transfer it via netcast.
```
# dd if=/dev/mtdX of=/tmp/mtdX.bin
# tftp -l /tmp/mtdX.bin -r remotehost-ip
```
```
# cat /dev/mtdX | nc remotehost-ip 10000
```
When partition writing to the stick, use the flash command set.
(Do not write with the `dd` command because ecc is enabled)
```
# flash_eraseall /dev/mtdX
# flashcp -v targetfile /dev/mtdX
```

## How to write firmware using uboot
When writing firmware using uboot, enter the uboot menu during boot, transfer the file using kermit, and write it to the flash.

1. While the following screen is displayed on the UART serial console, press any key to enter the uboot menu.
    ```
    Hit any key to stop autoboot:  0
    ```
2. Use the `loadb Free-RAM-space-address` command to transfer the firmware via kermit.
    ```
    # loadb 0x80000000
    ## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
    ```
3. Erase the flash area where the firmware will be written with the `spi_nand erase Start-Addr Size` command.
    > [!NOTE]
    > Commands may differ depending on the type of uboot and flash.
    > check the uboot help in advance.
    ```
    # spi_nand erase 0x000000600000 0x600000
    ```
4. Write the firmware transferred to RAM to the flash using the `spi_nand write RAM-address Start-Addr Size` command.
    ```
    # spi_nand write 0x80000000 0x000000600000 0x600000
    ```

## Bricked Stick Repair
If the stick is bricked, it can be repaired by accessing uboot from the UART.
> [!NOTE]
> There is no way to repair a bricked stick other than via UART.

### CIG XG-99S, CIG XE-99S
1. Access to uboot
    If Stick fails to boot, uboot will enable text input.
    ```
    ERROR: can't get kernel image!
    SATURN#
    ```
    Alternatively, on some Sticks (LTF-726x-BH, CIG old models), it can access the uboot by pressing any key while the following is displayed.
    ```
    Hit any key to stop autoboot:  0
    ```
    For new CIG models (XGS-ONU-25-20NI, XE-99S, etc.), uboot can be accessed by sending `0x1b 0x1d 0x0f 0x0b` raw binary while the above message is displayed. [^1]
    RAW binaries can usually be sent using Teraterm Macro or PComm Terminal Emulator.
    [^1]: [@rssor](https://github.com/rssor) analysis revealed!
2. Restore Prepare
    Next, download Stick's mtd dump from [mtd dump](https://github.com/YuukiJapanTech/CA8271x/tree/main/mtd).
    or, prepare a backup of the mtd partition obtained beforehand.
    Enable nand with the following command.
    ```
    SATURN# spi_nand probe 0
    SPI_NAND ID: 0x12c200
    SPI-NAND: MX35LF1GE4AB is found.
    MX35LF1GE4AB
    spinand_oob_size:0x40
    spinand_page_size:0x800
    spinand_blk_size:0x20000
    spinand_size:0x8000000
    SATURN#
    ```
3. Restore Kernel
    Receive the file with the loadb command.
    ```
    SATURN# loadb 0x80000000
    ## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
    ```
    Using Tera Term, send the Kernel image (mtd3 or mtd6) by kermit transfer. 
    Erase NAND and write the transferred kernel.
    ```
    SATURN# spi_nand erase 0x000000600000 0x600000
    SATURN# spi_nand erase 0x000003500000 0x600000
    SATURN# spi_nand write 0x80000000 0x000000600000 0x600000
    SATURN# spi_nand write 0x80000000 0x000003500000 0x600000
    ```
4. Restore dtb (optional)
    Receive the file with the loadb command.
    ```
    SATURN# loadb 0x80000000
    ## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
    ```
    Using Tera Term, send the dtb image (mtd2 or mtd5) by kermit transfer. <br>
    Erase NAND and write the transferred dtb.
    ```
    SATURN# spi_nand erase 0x000000500000 0x100000
    SATURN# spi_nand erase 0x000003400000 0x100000
    SATURN# spi_nand write 0x80000000 0x000000500000 0x100000
    SATURN# spi_nand write 0x80000000 0x000003400000 0x100000
    ```
5. Restore mfginfo (optional)
    Receive the file with the loadb command.
    ```
    SATURN# loadb 0x80000000
    ## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
    ```
    Using Tera Term, send the mfginfo image (mtd9 or mtd10) by kermit transfer.
    Erase NAND and write the transferred mfginfo.
    ```
    SATURN# spi_nand erase 0x000007700000 0x100000
    SATURN# spi_nand erase 0x000007800000 0x100000
    SATURN# spi_nand write 0x80000000 0x000007700000 0x100000
    SATURN# spi_nand write 0x80000000 0x000007800000 0x100000
    ```
6. Restore rootfs
    Receive the file with the loadb command.
    and Using Tera Term, send the rootfs image (mtd4 or mtd7) by kermit transfer.
    ```
    SATURN# loadb 0x80000000
    ## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
    ```
    Erase NAND and write the transferred rootfs.
    ```
    SATURN# spi_nand erase 0x000000c00000 0x2800000
    SATURN# spi_nand erase 0x000003b00000 0x2800000
    SATURN# spi_nand write 0x80000000 0x000000c00000 0x2800000
    SATURN# spi_nand write 0x80000000 0x000003b00000 0x2800000
    ```
7. Restore userdata (optional)
    If tmpfs or userdata is ReadOnlyFileSystem, restore userdata (mtd8).<br>
    Receive the file with the loadb command.
    ```
    SATURN# loadb 0x80000000
    ## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
    ```
    Using Tera Term, send the userdata image (mtd8) by kermit transfer.
    Erase NAND and write the transferred userdata.
    ```
    SATURN# spi_nand erase 0x000006300000 0x1400000
    SATURN# spi_nand write 0x80000000 0x000006300000 0x1400000
    ```
8. Restore partitions layout and bootargs for uboot environment (optional)
    The following command restores the partitions layout and bootargs env.
   - **XG-99S**
    ```
    env set more_args ubi.mtd=rootfs0 root=/dev/mtdblock12 rootfstype=squashfs
    env set setpartlayout setenv partitions ${flash_id}:4M@0x0(ssb),1M(uboot-env),1M(dtb${active_part}),6M(kernel${active_part}),40M(rootfs${active_part}),1M(dtb${standby_part}),6M(kernel${standby_part}),40M(rootfs${standby_part}),20M(userdata),1M(mfginfo1)
    env set setpartlayout ${setpartlayout},1M(mfginfo2),1M(uboot-env2)
    env save
    ```
   - **XE-99S**
    ```
    env set more_args ubi.mtd=rootfs0 root=/dev/mtdblock11 rootfstype=squashfs
    env set setpartlayout setenv partitions ${flash_id}:4M@0x0(ssb),1M(uboot-env),1M(dtb${active_part}),6M(kernel${active_part}),40M(rootfs${active_part}),1M(dtb${standby_part}),6M(kernel${standby_part}),40M(rootfs${standby_part}),20M(userdata),1M(mfginfo1)
    env set setpartlayout ${setpartlayout},1M(mfginfo2)
    env save
    ```
9. Reboot
    Disconnect and reconnect the Stick, it will boot with the transferred kernel and rootfs.

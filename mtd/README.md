# mtd files

This mtd dump can be used to repair bricked Stick and switch between XG-99S and XE-99S.

To obtain a backup, use the `dd` command to save it on `/tmp`,
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


## ECIN EN-XGSFPP-OMAC

| mtd No. | mtd Name | Start Addr | End Addr | Size |
| --- | --- | --- | --- | --- |
| mtd0 | ssb | 0x000000000000 | 0x000000400000 | 0x400000 |
| mtd1 | uboot-env | 0x000000400000 | 0x000000500000 | 0x100000 |
| mtd2 | dtb0 | 0x000000500000 | 0x000000600000 | 0x100000 |
| mtd3 | kernel0 | 0x000000600000 | 0x000000c00000 | 0x600000 |
| mtd4 | rootfs0 | 0x000000c00000 | 0x000003400000 | 0x2800000 |
| mtd5 | dtb1 | 0x000003400000 | 0x000003500000 | 0x100000 |
| mtd6 | kernel1 | 0x000003500000 | 0x000003b00000 | 0x600000 |
| mtd7 | rootfs1 | 0x000003b00000 | 0x000006300000 | 0x2800000 |
| mtd8 | userdata | 0x000006300000 | 0x000007700000 | 0x1400000 |
| mtd9 | mfginfo1 | 0x000007700000 | 0x000007800000 | 0x100000 |
| mtd10 | mfginfo2 | 0x000007800000 | 0x000007900000 | 0x100000 |
| mtd11 | uboot-env2 | 0x000007900000 | 0x000007a00000 | 0x100000 |

<br>

## FS XGS-ONU-25-20NI

| mtd No. | mtd Name | Start Addr | End Addr | Size |
| --- | --- | --- | --- | --- |
| mtd0 | ssb | 0x000000000000 | 0x000000400000 | 0x400000 |
| mtd1 | uboot-env | 0x000000400000 | 0x000000500000 | 0x100000 |
| mtd2 | dtb0 | 0x000000500000 | 0x000000600000 | 0x100000 |
| mtd3 | kernel0 | 0x000000600000 | 0x000000c00000 | 0x600000 |
| mtd4 | rootfs0 | 0x000000c00000 | 0x000003400000 | 0x2800000 |
| mtd5 | dtb1 | 0x000003400000 | 0x000003500000 | 0x100000 |
| mtd6 | kernel1 | 0x000003500000 | 0x000003b00000 | 0x600000 |
| mtd7 | rootfs1 | 0x000003b00000 | 0x000006300000 | 0x2800000 |
| mtd8 | userdata | 0x000006300000 | 0x000007700000 | 0x1400000 |
| mtd9 | mfginfo1 | 0x000007700000 | 0x000007800000 | 0x100000 |
| mtd10 | mfginfo2 | 0x000007800000 | 0x000007900000 | 0x100000 |
| mtd11 | uboot-env2 | 0x000007900000 | 0x000007a00000 | 0x100000 |

<br>

## CIG XE-99S

| mtd No. | mtd Name | Start Addr | End Addr | Size |
| --- | --- | --- | --- | --- |
| mtd0 | ssb | 0x000000000000 | 0x000000400000 | 0x400000 |
| mtd1 | uboot-env | 0x000000400000 | 0x000000500000 | 0x100000 |
| mtd2 | dtb0 | 0x000000500000 | 0x000000600000 | 0x100000 |
| mtd3 | kernel0 | 0x000000600000 | 0x000000c00000 | 0x600000 |
| mtd4 | rootfs0 | 0x000000c00000 | 0x000003400000 | 0x2800000 |
| mtd5 | dtb1 | 0x000003400000 | 0x000003500000 | 0x100000 |
| mtd6 | kernel1 | 0x000003500000 | 0x000003b00000 | 0x600000 |
| mtd7 | rootfs1 | 0x000003b00000 | 0x000006300000 | 0x2800000 |
| mtd8 | userdata | 0x000006300000 | 0x000007700000 | 0x1400000 |
| mtd9 | mfginfo1 | 0x000007700000 | 0x000007800000 | 0x100000 |
| mtd10 | mfginfo2 | 0x000007800000 | 0x000007900000 | 0x100000 |

<br>

## CIG XG-99M

| mtd No. | mtd Name | Start Addr | End Addr | Size |
| --- | --- | --- | --- | --- |
| mtd0 | ssb | 0x000000000000 | 0x000000400000 | 0x400000 |
| mtd1 | uboot-env | 0x000000400000 | 0x000000500000 | 0x100000 |
| mtd2 | dtb0 | 0x000000500000 | 0x000000600000 | 0x100000 |
| mtd3 | kernel0 | 0x000000600000 | 0x000000c00000 | 0x600000 |
| mtd4 | rootfs0 | 0x000000c00000 | 0x000003400000 | 0x2800000 |
| mtd5 | dtb1 | 0x000003400000 | 0x000003500000 | 0x100000 |
| mtd6 | kernel1 | 0x000003500000 | 0x000003b00000 | 0x600000 |
| mtd7 | rootfs1 | 0x000003b00000 | 0x000006300000 | 0x2800000 |
| mtd8 | userdata | 0x000006300000 | 0x000007700000 | 0x1400000 |
| mtd9 | mfginfo1 | 0x000007700000 | 0x000007800000 | 0x100000 |
| mtd10 | mfginfo2 | 0x000007800000 | 0x000007900000 | 0x100000 |
| mtd11 | uboot-env2 | 0x000007900000 | 0x000007a00000 | 0x100000 |

<br>

## Hisense LTF-7263-BH+

| mtd No. | mtd Name | Start Addr | End Addr | Size |
| --- | --- | --- | --- | --- |
| mtd0 | ssb | 0x000000000000 | 0x000000400000 | 0x400000 |
| mtd1 | uboot-env | 0x000000400000 | 0x000000500000 | 0x100000 |
| mtd2 | dtb0 | 0x000000500000 | 0x000000600000 | 0x100000 |
| mtd3 | kernel0 | 0x000000600000 | 0x000000c00000 | 0x600000 |
| mtd4 | rootfs0 | 0x000000c00000 | 0x000003400000 | 0x2800000 |
| mtd5 | dtb1 | 0x000003400000 | 0x000003500000 | 0x100000 |
| mtd6 | kernel1 | 0x000003500000 | 0x000003b00000 | 0x600000 |
| mtd7 | rootfs1 | 0x000003b00000 | 0x000006300000 | 0x2800000 |
| mtd8 | userdata | 0x000006300000 | 0x000007700000 | 0x1400000 |

<br>

# Bricked Stick Repair
If the stick is bricked, it can be repaired by accessing uboot from the UART.

## XG-99S, XE-99S
If Stick fails to boot, uboot will enable text input.
```
ERROR: can't get kernel image!
SATURN#
```

Alternatively, on some Sticks (mainly those other than XGS-ONU-25-20NI), it can access the uboot by pressing any key while the following is displayed.
```
Hit any key to stop autoboot:  0
```

XGS-ONU-25-20NI stick and if a broken kernel starts up, enter the following command to intentionally erase the kernel and access uboot.
```
flash_eraseall /dev/mtd3
flash_eraseall /dev/mtd6
reboot
```

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

### Restore Kernel
Receive the file with the loadb command.
```
SATURN# loadb 0x80000000
## Ready for binary (kermit) download to 0x80000000 at 115200 bps...
```

Using Tera Term, send the Kernel image (mtd3 or mtd6) by kermit transfer. <br>

Erase NAND and write the transferred kernel.
```
SATURN# spi_nand erase 0x000000600000 0x600000
SATURN# spi_nand erase 0x000003500000 0x600000
SATURN# spi_nand write 0x80000000 0x000000600000 0x600000
SATURN# spi_nand write 0x80000000 0x000003500000 0x600000
```

### Restore dtb (optional)
Receive the file with the loadb command.
```
SATURN# loadb 0x80700000
## Ready for binary (kermit) download to 0x80700000 at 115200 bps...
```

Using Tera Term, send the dtb image (mtd2 or mtd5) by kermit transfer. <br>

Erase NAND and write the transferred dtb.
```
SATURN# spi_nand erase 0x000000500000 0x100000
SATURN# spi_nand erase 0x000003400000 0x100000
SATURN# spi_nand write 0x80700000 0x000000500000 0x100000
SATURN# spi_nand write 0x80700000 0x000003400000 0x100000
```

### Restore mfginfo (optional)
Receive the file with the loadb command.
```
SATURN# loadb 0x80800000
## Ready for binary (kermit) download to 0x80800000 at 115200 bps...
```

Using Tera Term, send the mfginfo image (mtd9 or mtd10) by kermit transfer. <br>

Erase NAND and write the transferred mfginfo.
```
SATURN# spi_nand erase 0x000007700000 0x100000
SATURN# spi_nand erase 0x000007800000 0x100000
SATURN# spi_nand write 0x80800000 0x000007700000 0x100000
SATURN# spi_nand write 0x80800000 0x000007800000 0x100000
```

### Restore rootfs
Receive the file with the loadb command.
and Using Tera Term, send the rootfs image (mtd4 or mtd7) by kermit transfer.
```
SATURN# loadb 0x81000000
## Ready for binary (kermit) download to 0x81000000 at 115200 bps...
```

Erase NAND and write the transferred rootfs.
```
SATURN# spi_nand erase 0x000000c00000 0x2800000
SATURN# spi_nand erase 0x000003b00000 0x2800000
SATURN# spi_nand write 0x81000000 0x000000c00000 0x2800000
SATURN# spi_nand write 0x81000000 0x000003b00000 0x2800000
```

### Restore userdata (optional)
If tmpfs or userdata is ReadOnlyFileSystem, restore userdata (mtd8).<br>
Receive the file with the loadb command.
```
SATURN# loadb 0x84000000
## Ready for binary (kermit) download to 0x84000000 at 115200 bps...
```

Using Tera Term, send the userdata image (mtd8) by kermit transfer. <br>

Erase NAND and write the transferred userdata.
```
SATURN# spi_nand erase 0x000006300000 0x1400000
SATURN# spi_nand write 0x84000000 0x000006300000 0x1400000
```

Disconnect and reconnect the Stick, it will boot with the transferred kernel and rootfs.

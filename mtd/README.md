# mtd files

This mtd dump can be used to repair bricked Stick and switch between XG-99S and XE-99S.

To obtain a backup, use the `dd` command to save it on /tmp,
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

If Stick fails to boot, uboot will enable text input.
```
ERROR: can't get kernel image!
SATURN#
```

Download Stick's mtd dump from [mtd dump.](https://github.com/YuukiJapanTech/CA8271x/tree/main/mtd)

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

When the Stick is turned back on, it will boot with the transferred kernel and rootfs.

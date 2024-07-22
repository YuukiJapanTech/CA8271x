[    0.516166] SPI-NAND io-mode:a00
[    0.520335] SPI-NAND flash mfr-name: Macronix, mdr_id: 0xc2, dev_id: 0x12
[    0.529978] spi_nand_base: SPI-NAND: MX35LF1GE4AB is found.
[    0.535905] Bad block table found at page 65472, version 0x01
[    0.541911] Bad block table found at page 65408, version 0x01
[    0.547955] nand_read_bbt: bad block at 0x000005c60000
[    0.552927] nand_read_bbt: bad block at 0x000006860000
[    0.558140] 12 cmdlinepart partitions found on MTD device ca_spinand_flash
[    0.564935] Creating 12 MTD partitions on "ca_spinand_flash":
[    0.570658] 0x000000000000-0x000000400000 : "ssb"
[    0.576521] 0x000000400000-0x000000500000 : "uboot-env"
[    0.582632] 0x000000500000-0x000000600000 : "dtb0"
[    0.588460] 0x000000600000-0x000000c00000 : "kernel0"
[    0.594502] 0x000000c00000-0x000003400000 : "rootfs0"
[    0.600515] 0x000003400000-0x000003500000 : "dtb1"
[    0.606324] 0x000003500000-0x000003b00000 : "kernel1"
[    0.612274] 0x000003b00000-0x000006300000 : "rootfs1"
[    0.618403] 0x000006300000-0x000007700000 : "userdata"
[    0.624617] 0x000007700000-0x000007800000 : "mfginfo1"
[    0.630662] 0x000007800000-0x000007900000 : "mfginfo2"
[    0.636807] 0x000007900000-0x000007a00000 : "uboot-env2"
[    0.643434] spi-ca77xx b2224098.s
pi: resource - [mem 0xb2224098-0xb22240d7 flags 0x200] mapped at 0xb2224098

SN：ALCLf9ffa28b
ONTUSER
RhhXnacss7QiuRCr

# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00400000 00020000 "ssb"
mtd1: 00100000 00020000 "uboot-env"
mtd2: 00100000 00020000 "dtb0"
mtd3: 00600000 00020000 "kernel0"
mtd4: 02800000 00020000 "rootfs0"
mtd5: 00100000 00020000 "dtb1"
mtd6: 00600000 00020000 "kernel1"
mtd7: 02800000 00020000 "rootfs1"
mtd8: 01400000 00020000 "userdata"
mtd9: 00100000 00020000 "mfginfo1"
mtd10: 00100000 00020000 "mfginfo2"
mtd11: 00100000 00020000 "uboot-env2"
mtd12: 00be1000 0001f000 "squashfs_ubi"
mtd13: 01078000 0001f000 "userdata"
mtd14: 00b09000 0001f000 "squashfs_ubi"
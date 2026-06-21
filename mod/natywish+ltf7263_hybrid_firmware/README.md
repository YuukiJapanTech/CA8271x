# NATYWISH_LTF7267 / LTF7263 hybrid firmware
## Hardware Compatibility & Flashing Guide
This hybrid firmware is cross-compatible with both CIG and Hisense hardware variants.

To flash the entire firmware, follow these steps:

1. Flash the U-Boot (`mtd0` and `mtd1`) first to initialize the custom U-Boot environment.

2. Flash `mtd2` - `mtd8` using the mechanism as detailed in the  [mtd dump & Bricked Stick Repair](/mtd#bricked-stick-repair) .

## Mtd partition

| mtd No. | mtd Name | Start Addr | End Addr | Size | Description |
| --- | --- | --- | --- | --- | --- |
| mtd0 | ssb | 0x000000000000 | 0x000000400000 | 0x400000 | U-Boot |
| mtd1 | uboot-env | 0x000000400000 | 0x000000500000 | 0x100000 | U-Boot env |
| mtd2 | dtb0 | 0x000000500000 | 0x000000600000 | 0x100000 | NATYWISH_LTF7267 DTB |
| mtd3 | kernel0 | 0x000000600000 | 0x000000c00000 | 0x600000 | NATYWISH_LTF7267 4.14.172.saturn Kernel |
| mtd4 | rootfs0 | 0x000000c00000 | 0x000003400000 | 0x2800000 | NATYWISH_LTF7267 Rootfs + Overlay |
| mtd5 | dtb1 | 0x000003400000 | 0x000003500000 | 0x100000 | LTF7263 DTB |
| mtd6 | kernel1 | 0x000003500000 | 0x000003b00000 | 0x600000 | LTF7263 4.4.198.saturn Kernel |
| mtd7 | rootfs1 | 0x000003b00000 | 0x000006300000 | 0x2800000 | LTF7263 Rootfs |
| mtd8 | Userdata | 0x000006300000 | 0x000007700000 | 0x1400000 | LTF7263 Overlay |
| mtd9 | mfginfo1 | 0x000007700000 | 0x000007800000 | 0x100000 | CIG only (Empty, flashing not required) |
| mtd10 | mfginfo2 | 0x000007800000 | 0x000007900000 | 0x100000 | CIG only (Empty, flashing not required) |

## Switch slot
* NATYWISH_LTF7267 (Default) : 

    ```
    SATURN# setenv active_slot 0
    SATURN# saveenv
    SATURN# run boot_slot0
    ```

* LTF7263 : 

    ```
    SATURN# setenv active_slot 1
    SATURN# saveenv
    SATURN# run boot_slot1
    ```
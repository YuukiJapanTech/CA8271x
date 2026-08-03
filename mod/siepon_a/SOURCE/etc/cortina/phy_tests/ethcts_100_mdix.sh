#!/bin/sh

source ./phy_regs.sh

# ethcts_100_mdix
# 0xA40 0x27[15:0] = 0x8011 // SRAM address 0x8011
# 0xA40 0x28[15] = 0 // SRAM data, just modify bit15 = 0, disable green table update
# 0xA43 0x24[2] = 0 // disable GPHY ALDPS mode
# 0x000 0x0[15:0] = 0x2100 // force 100 Base-TX FullDuplex
# 0xA43 0x24[9] = 0x1 // disable Auto-MDIX
# 0xA43 0x24[8] = 0x0 // MDIX
# 0x000 0x9[15:0] = 0x0E00 // disable Giga Test Mode
devmem ${SWITCH_PAGE[$id]} h 0xA40
devmem ${PA40_R27[$id]} h 0x8011
reg=$(devmem ${PA40_R28[$id]})
reg=$(($reg&0x7FFF))
devmem ${PA40_R28[$id]} h $reg
devmem ${SWITCH_PAGE[$id]} h 0xA43
reg=$(devmem ${PA43_R24[$id]})
reg=$(($reg&0xFFFB))
devmem ${PA43_R24[$id]} h $reg
devmem ${SWITCH_PAGE[$id]} h 0x0
devmem ${P000_R0[$id]} h 0x2100
reg=$(devmem ${PA43_R24[$id]})
reg=$(($reg|0x0200))
reg=$(($reg&0xFEFF))
devmem ${SWITCH_PAGE[$id]} h 0xA43
devmem ${PA43_R24[$id]} h $reg
devmem ${SWITCH_PAGE[$id]} h 0x0
devmem ${P000_R9[$id]} h 0x0E00

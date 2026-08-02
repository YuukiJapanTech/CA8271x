
###############################################################
# This file contains some common definitions.
###############################################################

##### aging #####

set HASHLITE_AGING_INVALID		0
set HASHLITE_AGING_START		14
set HASHLITE_AGING_STATIC		15

##### hash mask index #####

# NOTE: It must exist in HW already. Check with /proc/driver/cortina/aal/aal_table.

set HM_L3_GATEWAY			0
set HM_L3_NEIGHBOR			1

##### hash action group mask #####

# group 8, 11, 13, 18, 19
set HL_ACTGRP_L3_GENERIC		0x000c2900



#LAN port 0 <=> WAN
source /etc/cortina/iros/api/l2_addr/l2_addr_entry_add_wan.tcl
source /etc/cortina/iros/api/intf/add_lan.tcl
source /etc/cortina/iros/api/intf/add_wan.tcl
source /etc/cortina/iros/api/nat/nat_entry_add_lan_to_wan.tcl
source /etc/cortina/iros/api/nat/nat_entry_add_wan_to_lan.tcl
source /etc/cortina/iros/api/route/add_route_0.tcl
source /etc/cortina/iros/api/route/add_nexthop_0.tcl
#LAN port 1 <=> WAN
source /etc/cortina/iros/api/nat/nat_entry_add_lan_to_wan_1.tcl
source /etc/cortina/iros/api/nat/nat_entry_add_wan_to_lan_1.tcl
source /etc/cortina/iros/api/route/add_nexthop_1.tcl
#LAN port 2 <=> WAN
source /etc/cortina/iros/api/nat/nat_entry_add_lan_to_wan_2.tcl
source /etc/cortina/iros/api/nat/nat_entry_add_wan_to_lan_2.tcl
source /etc/cortina/iros/api/route/add_nexthop_2.tcl

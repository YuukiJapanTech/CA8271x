# tunnel type 3 (IPSec)

set LOCAL_IP 0x01010101
set REMOTE_IP 0x02020202
# L4 port is for NATT only
set LOCAL_L4_PORT 4500
set REMOTE_L4_PORT 4500
set SPI_ENCRYPT 0x11223344
set SPI_DECRYPT 0xaabbccdd
set SRC_MAC [ ca_mac_addr_create 0x00 0x13 0x25 0x00 0x00 0x01 ]
set DEST_MAC [ ca_mac_addr_create 0x00 0x00 0x00 0x00 0x64 0x64 ]
set PARENT_INTF_ID 4

set src [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip $LOCAL_IP
ca_ip_address_set_addr_len $src 32
ca_ip_address_set_afi $src 0
ca_ip_address_set_ip_addr $src $ip

set dest [ ca_ip_address_create ]
set ip [ ca_l3_ip_addr_create ]
ca_l3_ip_addr_set_ipv4_addr $ip $REMOTE_IP
ca_ip_address_set_addr_len $dest 32
ca_ip_address_set_afi $dest 0
ca_ip_address_set_ip_addr $dest $ip

# sa_id for encryption

set sa [ ca_ipsec_sa_create ]
ca_ipsec_sa_set_replay_window $sa 0
ca_ipsec_sa_set_spi $sa $SPI_ENCRYPT
ca_ipsec_sa_set_sequence_number $sa 0

ca_ipsec_sa_set_ekey $sa 0x00 0
ca_ipsec_sa_set_ekey $sa 0x01 1
ca_ipsec_sa_set_ekey $sa 0x02 2
ca_ipsec_sa_set_ekey $sa 0x03 3
ca_ipsec_sa_set_ekey $sa 0x04 4
ca_ipsec_sa_set_ekey $sa 0x05 5
ca_ipsec_sa_set_ekey $sa 0x06 6
ca_ipsec_sa_set_ekey $sa 0x07 7
ca_ipsec_sa_set_ekey $sa 0x08 8
ca_ipsec_sa_set_ekey $sa 0x09 9
ca_ipsec_sa_set_ekey $sa 0x0a 10
ca_ipsec_sa_set_ekey $sa 0x0b 11
ca_ipsec_sa_set_ekey $sa 0x0c 12
ca_ipsec_sa_set_ekey $sa 0x0d 13
ca_ipsec_sa_set_ekey $sa 0x0e 14
ca_ipsec_sa_set_ekey $sa 0x0f 15

ca_ipsec_sa_set_akey $sa 0x00 0
ca_ipsec_sa_set_akey $sa 0x01 1
ca_ipsec_sa_set_akey $sa 0x02 2
ca_ipsec_sa_set_akey $sa 0x03 3
ca_ipsec_sa_set_akey $sa 0x04 4
ca_ipsec_sa_set_akey $sa 0x05 5
ca_ipsec_sa_set_akey $sa 0x06 6
ca_ipsec_sa_set_akey $sa 0x07 7
ca_ipsec_sa_set_akey $sa 0x08 8
ca_ipsec_sa_set_akey $sa 0x09 9
ca_ipsec_sa_set_akey $sa 0x0a 10
ca_ipsec_sa_set_akey $sa 0x0b 11
ca_ipsec_sa_set_akey $sa 0x0c 12
ca_ipsec_sa_set_akey $sa 0x0d 13
ca_ipsec_sa_set_akey $sa 0x0e 14
ca_ipsec_sa_set_akey $sa 0x0f 15

ca_ipsec_sa_set_ip_version $sa 0
# proto: 0=ESP, 1=AH
ca_ipsec_sa_set_protocol $sa 0
# tunnel: 0=Transport, 1=Tunnel
ca_ipsec_sa_set_tunnel $sa 0
# sa_dir: 0=Encrypt, 1=Decrypt
ca_ipsec_sa_set_sa_dir $sa 0
# ealg: 0=NULL, 1=DES, 2=AES
ca_ipsec_sa_set_ealg $sa 2
# ealg_mode: 0=ECB, 1=CBC, 2=CTR, 3=CCM, 4=GCM, 5=OFB, 6=CFB
ca_ipsec_sa_set_ealg_mode $sa 1
# encryption_keylen: the value multiple 4 is key len
ca_ipsec_sa_set_encryption_keylen $sa 4
# iv_len: the value multiple 4 is IV len. For CBC.
ca_ipsec_sa_set_iv_len $sa 2
# aalg: 0=NULL, 1=MD5, 2=SHA1
ca_ipsec_sa_set_aalg $sa 0
ca_ipsec_sa_set_auth_keylen $sa 4
# icv_trunclen: the value multiple 4 is actual ICV trunclen
ca_ipsec_sa_set_icv_trunclen $sa 2
ca_ipsec_sa_set_etherIP $sa 1
ca_ipsec_sa_set_is_natt $sa 0
ca_ipsec_sa_set_src_l4_port $sa $LOCAL_L4_PORT
ca_ipsec_sa_set_dest_l4_port $sa $REMOTE_L4_PORT

set ret_sa_id [ ca_uint32_create 0 ]
set ret [ ca_ipsec_sa_add 0 $sa $ret_sa_id ]
if {$ret != 0} {
	puts "ca_ipsec_sa_add() for encrypt is failed! (ret=$ret)"
} else {
	set sa_id_encrypt [ ca_uint32_get $ret_sa_id ]
	puts "sa_id_encrypt=$sa_id_encrypt"
}

# sa_id for decryption

set sa_decrypt [ ca_ipsec_sa_create ]
ca_ipsec_sa_set_replay_window $sa 0
ca_ipsec_sa_set_spi $sa $SPI_DECRYPT
ca_ipsec_sa_set_sequence_number $sa 0

ca_ipsec_sa_set_ekey $sa 0x00 0
ca_ipsec_sa_set_ekey $sa 0x01 1
ca_ipsec_sa_set_ekey $sa 0x02 2
ca_ipsec_sa_set_ekey $sa 0x03 3
ca_ipsec_sa_set_ekey $sa 0x04 4
ca_ipsec_sa_set_ekey $sa 0x05 5
ca_ipsec_sa_set_ekey $sa 0x06 6
ca_ipsec_sa_set_ekey $sa 0x07 7
ca_ipsec_sa_set_ekey $sa 0x08 8
ca_ipsec_sa_set_ekey $sa 0x09 9
ca_ipsec_sa_set_ekey $sa 0x0a 10
ca_ipsec_sa_set_ekey $sa 0x0b 11
ca_ipsec_sa_set_ekey $sa 0x0c 12
ca_ipsec_sa_set_ekey $sa 0x0d 13
ca_ipsec_sa_set_ekey $sa 0x0e 14
ca_ipsec_sa_set_ekey $sa 0x0f 15

ca_ipsec_sa_set_akey $sa 0x00 0
ca_ipsec_sa_set_akey $sa 0x01 1
ca_ipsec_sa_set_akey $sa 0x02 2
ca_ipsec_sa_set_akey $sa 0x03 3
ca_ipsec_sa_set_akey $sa 0x04 4
ca_ipsec_sa_set_akey $sa 0x05 5
ca_ipsec_sa_set_akey $sa 0x06 6
ca_ipsec_sa_set_akey $sa 0x07 7
ca_ipsec_sa_set_akey $sa 0x08 8
ca_ipsec_sa_set_akey $sa 0x09 9
ca_ipsec_sa_set_akey $sa 0x0a 10
ca_ipsec_sa_set_akey $sa 0x0b 11
ca_ipsec_sa_set_akey $sa 0x0c 12
ca_ipsec_sa_set_akey $sa 0x0d 13
ca_ipsec_sa_set_akey $sa 0x0e 14
ca_ipsec_sa_set_akey $sa 0x0f 15

ca_ipsec_sa_set_ip_version $sa 0
# proto: 0=ESP, 1=AH
ca_ipsec_sa_set_protocol $sa 0
# tunnel: 0=Transport, 1=Tunnel
ca_ipsec_sa_set_tunnel $sa 0
# sa_dir: 0=Encrypt, 1=Decrypt
ca_ipsec_sa_set_sa_dir $sa 1
# ealg: 0=NULL, 1=DES, 2=AES
ca_ipsec_sa_set_ealg $sa 2
# ealg_mode: 0=ECB, 1=CBC, 2=CTR, 3=CCM, 4=GCM, 5=OFB, 6=CFB
ca_ipsec_sa_set_ealg_mode $sa 1
# encryption_keylen: the value multiple 4 is key len
ca_ipsec_sa_set_encryption_keylen $sa 4
# iv_len: the value multiple 4 is IV len. For CBC.
ca_ipsec_sa_set_iv_len $sa 2
# aalg: 0=NULL, 1=MD5, 2=SHA1
ca_ipsec_sa_set_aalg $sa 0
ca_ipsec_sa_set_auth_keylen $sa 4
# icv_trunclen: the value multiple 4 is actual ICV trunclen
ca_ipsec_sa_set_icv_trunclen $sa 2
ca_ipsec_sa_set_etherIP $sa 1
ca_ipsec_sa_set_is_natt $sa 0
ca_ipsec_sa_set_src_l4_port $sa $REMOTE_L4_PORT
ca_ipsec_sa_set_dest_l4_port $sa $LOCAL_L4_PORT

set ret_sa_id [ ca_uint32_create 0 ]
set ret [ ca_ipsec_sa_add 0 $sa $ret_sa_id ]
if {$ret != 0} {
	puts "ca_ipsec_sa_add() for decrypt is failed! (ret=$ret)"
} else {
	set sa_id_decrypt [ ca_uint32_get $ret_sa_id ]
	puts "sa_id_decrypt=$sa_id_decrypt"
}

# tunnel_cfg

set tcfg_union [ ca_tunnel_cfg_union_create ]
set tcfg_ipsec [ ca_ipsec_tunnel_cfg_create ]
ca_ipsec_tunnel_cfg_set_sa_id_encrypt $tcfg_ipsec $sa_id_encrypt
ca_ipsec_tunnel_cfg_set_sa_id_decrypt $tcfg_ipsec $sa_id_decrypt

ca_tunnel_cfg_union_set_ipsec $tcfg_union $tcfg_ipsec

set tcfg [ ca_tunnel_cfg_create ]
ca_tunnel_cfg_set_type $tcfg 3
ca_tunnel_cfg_set_src_addr $tcfg $src
ca_tunnel_cfg_set_dest_addr $tcfg $dest
ca_tunnel_cfg_set_parent_l3_intf_id $tcfg $PARENT_INTF_ID
ca_tunnel_cfg_set_tunnel $tcfg $tcfg_union

set ret_tunnel_id [ ca_uint16_create 0 ]
set ret [ ca_tunnel_add 0 $tcfg $ret_tunnel_id ]
if {$ret != 0} {
	puts "ca_tunnel_add() is failed! (ret=$ret)"
} else {
	set tunnel_id [ ca_uint16_get $ret_tunnel_id ]
	puts "tunnel_id=$tunnel_id"
}




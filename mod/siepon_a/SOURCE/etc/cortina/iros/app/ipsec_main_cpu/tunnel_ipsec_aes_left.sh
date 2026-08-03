#!/bin/sh

if [ "$4" == "" ]; then
    echo "usage: $0 <local_ip> <remote_ip> <local_net/XX> <remote_net/XX>"
    echo "creates an ipsec tunnel between two machines"
    exit 1
fi

SRC="$1"; shift
DST="$1"; shift
LOCAL="$1"; shift
REMOTE="$1"; shift
PROTO=esp
#PROTO=ah
ENC="cbc(aes)"
EKEY1=0xE20102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e00
EKEY2=0xE10102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e00
#AUTH="sha256"
#AKEY1=0xA10102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f
#AKEY2=0xA20102030405060708090a0b0c0d0e0f000102030405060708090a0b0c0d0e0f
AUTH="sha1"
AKEY1=0xA20102030405060708090a0b0c0d0e0f00010200
AKEY2=0xA10102030405060708090a0b0c0d0e0f00010200
ID1=0x11223300
ID2=0x33221100


ip xfrm state flush
ip xfrm policy flush
ip xfrm state add src $SRC dst $DST proto $PROTO spi $ID1 reqid $ID1 mode tunnel auth $AUTH $AKEY1 enc $ENC $EKEY1
ip xfrm state add src $DST dst $SRC proto $PROTO spi $ID2 reqid $ID2 mode tunnel auth $AUTH $AKEY2 enc $ENC $EKEY2
ip xfrm policy add src $LOCAL dst $REMOTE dir out tmpl src $SRC dst $DST proto $PROTO reqid $ID1 mode tunnel
#ip xfrm policy add src $LOCAL dst $REMOTE dir fwd tmpl src $SRC dst $DST proto $PROTO reqid $ID1 mode tunnel
ip xfrm policy add src $REMOTE dst $LOCAL dir in tmpl src $DST dst $SRC proto $PROTO reqid $ID2 mode tunnel
ip xfrm policy add src $REMOTE dst $LOCAL dir fwd tmpl src $DST dst $SRC proto $PROTO reqid $ID2 mode tunnel
ip route del $REMOTE  
ip route add $REMOTE dev eth0 src $SRC
ip xfrm state

[ 0 == 1 ] && {
ssh $DST /bin/bash << EOF
    ip xfrm policy flush
    ip xfrm policy flush
    ip xfrm state add src $SRC dst $DST proto $PROTO spi $ID2 reqid $ID2 mode tunnel auth sha256 $AKEY2 enc aes $EKEY2
    ip xfrm state add src $DST dst $SRC proto $PROTO spi $ID1 reqid $ID1 mode tunnel auth sha256 $AKEY1 enc aes $EKEY1
    ip xfrm policy add src $REMOTE dst $LOCAL dir out tmpl src $DST dst $SRC proto $PROTO reqid $ID1 mode tunnel
    ip xfrm policy add src $LOCAL dst $REMOTE dir in tmpl src $SRC dst $DST proto $PROTO reqid $ID2 mode tunnel
    ip route add $LOCAL dev eth0 src $DST
EOF
}


#!/bin/sh

I2CFLAG=/tmp/i2c_lock

if [ ! -f $I2CFLAG ]; then
  IROSStatus=$(iros <<'EOF'
source /script/tcl/BOSA.tcl
wca_epon_mpcp_registration_status_get -device_id 0 -port_id 0x20007 -llid 0
wca_epon_llid_traffic_enable_get -device_id 0 -port_id 0x20007 -llid 0x0
BOSA_read_dom
EOF
  )
else
  :
fi

Regist=$(echo "$IROSStatus" | grep "reg_state" | sed -E 's/.*= ([^]]+).*/\1/')
OLT=$(echo "$IROSStatus" | grep "olt_mac_addr" | sed -E 's/.*= ([^]]+).*/\1/')
UPLink=$(echo "$IROSStatus" | grep "upstream" | sed -E 's/.*= ([^]]+).*/\1/')
SVER=$(cat /etc/8271version)
BVER=$(cat /etc/version)
MODEL=$(cat /tmp/stick)

TEMP=$(echo "$IROSStatus" | awk '/Temperature/ {print $3}')
Vcc=$(echo "$IROSStatus" | awk '/Vcc/ {print $3}')
TxBias=$(echo "$IROSStatus" | awk '/TxBias/ {print $3}')
TXLVL=$(echo "$IROSStatus" | awk '/TxPower/ {print $3}')
RXLVL=$(echo "$IROSStatus" | awk '/RxPower/ {print $3}')

case "$Regist" in
  1)
    REG_STR="OK"
    ;;
  *)
    REG_STR="-"
    ;;
esac

case "$UPLink" in
  1)
    UP_STR="OK"
    ;;
  *)
    UP_STR="-"
    ;;
esac

echo "Content-Type: application/json"
echo ""

echo "{"
echo "  \"Regist\": \"$REG_STR\","
echo "  \"OLT\": \"$OLT\","
echo "  \"UPLink\": \"$UP_STR\","
echo "  \"SVER\": \"$SVER\","
echo "  \"BVER\": \"$BVER\","
echo "  \"MODEL\": \"$MODEL\","
echo "  \"TEMP\": \"$TEMP\","
echo "  \"Vcc\": \"$Vcc\","
echo "  \"TxBias\": \"$TxBias\","
echo "  \"RXLVL\": \"$RXLVL\","
echo "  \"TXLVL\": \"$TXLVL\""
echo "}"


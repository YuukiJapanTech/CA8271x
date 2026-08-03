<!- Copyright (C) 1991-2016 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   "http://www.gnu.org/licenses/".  ->
<!- This header is separate from features.h so that the compiler can
   include it implicitly at the start of every compilation.  It must
   not itself include "features.h" or any other header that includes
   "features.h" because the implicit include comes before any feature
   test macros that may be defined in a source file before it first
   explicitly includes a system header.  GCC knows the name of this
   header in order to preinclude it.  ->
<!- glibc's intent is to support the IEC 559 math functionality, real
   and complex.  If the GCC (4.9 and later) predefined macros
   specifying compiler intent are available, use them to determine
   whether the overall intent is to support these features; otherwise,
   presume an older compiler has intent to support these features and
   define these macros by default.  ->
<!- wchar_t uses Unicode 8.0.0.  Version 8.0 of the Unicode Standard is
   synchronized with ISO/IEC 10646:2014, plus Amendment 1 (published
   2015-05-15).  ->
<!- We do not support C11 "threads.h".  ->
<html>
<! Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("12" "LANG_DSL_WAN"); %> <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script type="text/javascript" src="base64_code.js"></script>
<script language="javascript">
var initConnectMode;
var pppConnectStatus=0;
var dgwstatus;
var gtwy;
var interfaceInfo = '';
var gtwyIfc ='';
var gwInterface=0;
var ipver=1;
function pppTypeSelection()
{
 if ( document.adsl.pppConnectType.selectedIndex == 2) {
  document.adsl.pppIdleTime.value = "";
  disableTextField(document.adsl.pppIdleTime);
 }
 else {
  if (document.adsl.pppConnectType.selectedIndex == 1) {
   enableTextField(document.adsl.pppIdleTime);
  }
  else {
   document.adsl.pppIdleTime.value = "";
   disableTextField(document.adsl.pppIdleTime);
  }
 }
}
function checkDefaultGW() {
 with (document.forms[0]) {
  if (droute[0].checked == false && droute[1].checked == false && gwStr[0].checked == false && gwStr[1].checked == false) {
   alert('<% multilang("1887" "LANG_A_DEFAULT_GATEWAY_HAS_TO_BE_SELECTED"); %>');
   return false;
  }
  if (droute[1].checked == true) {
   if (gwStr[0].checked == true) {
    if (isValidIpAddress(dstGtwy.value, "Default Gateway IP Address") == false)
     return false;
   }
  }
 }
 return true;
}
function addClick()
{
 <% checkWrite("checkVC"); %>
 if (( document.adsl.adslConnectionMode.value == 2 ) ||
 ( document.adsl.adslConnectionMode.value == 3 )) {
  if(isAllStar(document.adsl.pppPassword.value)){
   alert('<% multilang("1910" "LANG_INVALID_PPP_PASSWORD"); %>');
   document.adsl.pppPassword.focus();
   document.adsl.pppPassword.value = "";
   return false;
  }
 }
 return vcCheck();
}
function deleteClick()
{
 disableUsernamePassword();
 return true;
}
// Jenny, check decimal
function validateInt(str)
{
 for (var i=0; i<str.length; i++) {
  if (str.charAt(i) == '.' )
   return 0;
 }
 return 1;
}
function isAllStar(str)
{
  for (var i=0; i<str.length; i++) {
   if ( str.charAt(i) != '*' ) {
   return false;
 }
  }
  return true;
}
function disableUsernamePassword()
{
 //avoid sending username/password without encode
 disableTextField(document.adsl.pppUserName);
 if(!isAllStar(document.adsl.pppPassword.value))
  disableTextField(document.adsl.pppPassword);
}
function applyClick()
{
 disableUsernamePassword();
 return true;
}
function vcCheck()
{
 var ptmap = 0;
 var pmchkpt = document.getElementById("tbl_pmap");
 if (pmchkpt) {
  with (document.forms[0]) {
   for(var i = 0; i < 14; i ++) if(chkpt[i].checked == true) ptmap |= (0x1 << i);
   itfGroup.value = ptmap;
  }
 }
 if (checkDefaultGW()==false)
  return false;
 if (validateInt(document.adsl.vpi.value) == 0) { // Jenny,  buglist B056, check if input VPI is a decimal		
  alert('<% multilang("1928" "LANG_INVALID_VPI_VALUE_VPI_SHOULD_NOT_BE_A_DECIMAL"); %>');
  document.adsl.vpi.value = document.adsl.vpi.defaultValue;
  document.adsl.vpi.focus();
  return false;
 }
 digitVPI = getDigit(document.adsl.vpi.value, 1);
 if ( validateKey(document.adsl.vpi.value) == 0 ||
  (digitVPI > 255 || digitVPI < 0) ) {
  alert('<% multilang("1929" "LANG_INVALID_VPI_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_0_255"); %>');
  document.adsl.vpi.focus();
  return false;
 }
 if (validateInt(document.adsl.vci.value) == 0) { // Jenny,  buglist B056, check if input VCI is a decimal		
  alert('<% multilang("1930" "LANG_INVALID_VCI_VALUE_VCI_SHOULD_NOT_BE_A_DECIMAL"); %>');
  document.adsl.vci.value = document.adsl.vci.defaultValue;
  document.adsl.vci.focus();
  return false;
 }
 digitVCI = getDigit(document.adsl.vci.value, 1);
 if ( validateKey(document.adsl.vci.value) == 0 ||
  (digitVCI > 65535 || digitVCI < 0) ) {
  alert('<% multilang("1931" "LANG_INVALID_VCI_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_0_65535"); %>');
  document.adsl.vci.focus();
  return false;
 }
 if ( (digitVPI == 0 && digitVCI == 0) ) {
  alert('<% multilang("1932" "LANG_INVALID_VPI_VCI_VALUE"); %>');
  document.adsl.vpi.focus();
  return false;
 }
 if (( document.adsl.adslConnectionMode.value == 2 ) ||
  ( document.adsl.adslConnectionMode.value == 3 )) {
  if (document.adsl.pppUserName.value=="") {
   alert('<% multilang("1905" "LANG_PPP_USER_NAME_CANNOT_BE_EMPTY"); %>');
   document.adsl.pppUserName.focus();
   return false;
  }
  if (includeSpace(document.adsl.pppUserName.value)) {
   alert('<% multilang("1906" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PPP_USER_NAME"); %>');
   document.adsl.pppUserName.focus();
   return false;
  }
  if (checkString(document.adsl.pppUserName.value) == 0) {
   alert('<% multilang("1907" "LANG_INVALID_PPP_USER_NAME"); %>');
   document.adsl.pppUserName.focus();
   return false;
  }
  document.adsl.encodePppUserName.value=encode64(document.adsl.pppUserName.value);
  if (document.adsl.pppPassword.value=="") {
   alert('<% multilang("1908" "LANG_PPP_PASSWORD_CANNOT_BE_EMPTY"); %>');
   document.adsl.pppPassword.focus();
   return false;
  }
  if(!isAllStar(document.adsl.pppPassword.value)){
   if (includeSpace(document.adsl.pppPassword.value)) {
    alert('<% multilang("1909" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PPP_PASSWORD"); %>');
    document.adsl.pppPassword.focus();
    return false;
   }
   if (checkString(document.adsl.pppPassword.value) == 0) {
    alert('<% multilang("1910" "LANG_INVALID_PPP_PASSWORD"); %>');
    document.adsl.pppPassword.focus();
    return false;
   }
   document.adsl.encodePppPassword.value=encode64(document.adsl.pppPassword.value);
  }
  if (document.adsl.pppConnectType.selectedIndex == 1) {
   if (document.adsl.pppIdleTime.value <= 0) {
    alert('<% multilang("1911" "LANG_INVALID_PPP_IDLE_TIME"); %>');
    document.adsl.pppIdleTime.focus();
    return false;
   }
  }
 }
 if (document.adsl.dns1.value !="")
 {
  if (!checkHostIP(document.adsl.dns1, 1))
  {
   document.adsl.dns1.focus();
   return false;
  }
 }
 if (document.adsl.dns2.value !="")
 {
  if (!checkHostIP(document.adsl.dns2, 1))
  {
   document.adsl.dns2.focus();
   return false;
  }
 }
 // Mason Yu:20110307 ipv6 setting
 if (<% checkWrite("IPv6Show"); %>) {
  if(document.adsl.IpProtocolType.value & 1){
   if (( document.adsl.adslConnectionMode.value == 1 ) ||
    ( document.adsl.adslConnectionMode.value == 4 )) {
    if (document.adsl.ipMode[0].checked) {
     if ( document.adsl.ipUnnum.disabled || ( !document.adsl.ipUnnum.disabled && !document.adsl.ipUnnum.checked )) {
      if (!checkHostIP(document.adsl.ip, 1))
       return false;
      if (document.adsl.remoteIp.visiblity == "hidden") {
       if (!checkHostIP(document.adsl.remoteIp, 1))
       return false;
      }
      if (document.adsl.adslConnectionMode.value == 1 && !checkNetmask(document.adsl.netmask, 1))
       return false;
     }
    }
   }
  }
 }
 /* Mason Yu:20110307 START ipv6 setting */
 if (<% checkWrite("IPv6Show"); %>) {
  if ( document.adsl.adslConnectionMode.value != 0 ) {
   if(document.adsl.IpProtocolType.value & 2)
   {
    if (document.adsl.adslConnectionMode.value != 0 && document.adsl.adslConnectionMode.value != 6 && document.adsl.adslConnectionMode.value != 8) {
     if(document.adsl.slacc.checked == false && document.adsl.itfenable.checked == false && document.adsl.staticIpv6.checked == false){
      alert('<% multilang("1912" "LANG_PLEASE_INPUT_IPV6_ADDRESS_OR_SELECT_DHCPV6_CLIENT_OR_CLICK_SLAAC"); %>');
      document.adsl.slacc.focus();
      return false;
     }
    }
    if(document.adsl.itfenable.checked) {
     if(document.adsl.iana.checked == false && document.adsl.iapd.checked == false ) {
      alert('<% multilang("1913" "LANG_PLEASE_SELECT_IANA_OR_IAPD"); %>');
      document.adsl.iana.focus();
      return false;
     }
    }
    if(document.adsl.staticIpv6.checked) {
     if(document.adsl.Ipv6Addr.value == "" || document.adsl.Ipv6PrefixLen.value == "") {
      alert('<% multilang("1914" "LANG_PLEASE_INPUT_IPV6_ADDRESS_AND_PREFIX_LENGTH"); %>');
      document.adsl.Ipv6Addr.focus();
      return false;
     }
     if(document.adsl.Ipv6Addr.value != ""){
      if (! isGlobalIpv6Address( document.adsl.Ipv6Addr.value) ){
       alert('<% multilang("1915" "LANG_INVALID_IPV6_ADDRESS"); %>');
       document.adsl.Ipv6Addr.focus();
       return false;
      }
      var prefixlen= getDigit(document.adsl.Ipv6PrefixLen.value, 1);
      if (prefixlen > 128 || prefixlen <= 0) {
       alert('<% multilang("1916" "LANG_INVALID_IPV6_PREFIX_LENGTH"); %>');
       document.adsl.Ipv6PrefixLen.focus();
       return false;
      }
     }
     if(document.adsl.Ipv6Gateway.value != "" ){
      if (! isUnicastIpv6Address( document.adsl.Ipv6Gateway.value) ){
       alert('<% multilang("1917" "LANG_INVALID_IPV6_GATEWAY_ADDRESS"); %>');
       document.adsl.Ipv6Gateway.focus();
       return false;
      }
     }
     if(document.adsl.Ipv6Dns1.value != "" ){
      if (! isUnicastIpv6Address( document.adsl.Ipv6Dns1.value) ){
       alert('<% multilang("1918" "LANG_INVALID_PRIMARY_IPV6_DNS_ADDRESS"); %>');
       document.adsl.Ipv6Dns1.focus();
       return false;
      }
     }
     if(document.adsl.Ipv6Dns2.value != "" ){
      if (! isUnicastIpv6Address( document.adsl.Ipv6Dns2.value) ){
       alert('<% multilang("1919" "LANG_INVALID_SECONDARY_IPV6_DNS_ADDRESS"); %>');
       document.adsl.Ipv6Dns2.focus();
       return false;
      }
     }
    }else{
     document.adsl.Ipv6Addr.value = "";
     document.adsl.Ipv6PrefixLen.value = "";
     document.adsl.Ipv6Gateway.value = "";
     document.adsl.Ipv6Dns2.value = "";
     document.adsl.Ipv6Dns2.value = "";
    }
    if (<% checkWrite("DSLiteShow"); %>) {
     if (document.adsl.adslConnectionMode.value == 6) // DS-Lite
     {
      if(document.adsl.DSLiteLocalIP.value != ""){
       if (! isGlobalIpv6Address( document.adsl.DSLiteLocalIP.value) ){
        alert('<% multilang("1924" "LANG_INVALID_DSLITELOCALIP_ADDRESS"); %>');
        document.adsl.DSLiteLocalIP.focus();
        return false;
       }
      }
      if(document.adsl.DSLiteRemoteIP.value != ""){
       if (! isGlobalIpv6Address( document.adsl.DSLiteRemoteIP.value) ){
        alert('<% multilang("1925" "LANG_INVALID_DSLITEREMOTEIP_ADDRESS"); %>');
        document.adsl.DSLiteRemoteIP.focus();
        return false;
       }
      }
      if(document.adsl.DSLiteGateway.value != ""){
       if (! isGlobalIpv6Address( document.adsl.DSLiteGateway.value) ){
        alert('<% multilang("1926" "LANG_INVALID_DSLITEGATEWAY_ADDRESS"); %>');
        document.adsl.DSLiteGateway.focus();
        return false;
       }
      }
     }
     else{
      document.adsl.DSLiteLocalIP.value = "";
      document.adsl.DSLiteRemoteIP.value = "";
      document.adsl.DSLiteGateway.value = "";
     }
    }
   if (<% checkWrite("6rdShow"); %>) {
    if (document.adsl.adslConnectionMode.value == 8) // 6rd
    {
     if(document.adsl.SixrdBRv4IP.value == ""){
      alert('<% multilang("1920" "LANG_INVALID_6RD_BOARD_ROUTER_V4IP_ADDRESS"); %>');
      document.adsl.SixrdBRv4IP.focus();
      return false;
     }
     if(document.adsl.SixrdPrefix.value == ""){
      alert('<% multilang("1922" "LANG_INVALID_6RD_PREFIX_ADDRESS"); %>');
      document.adsl.SixrdPrefix.focus();
      return false;
     }
     if(document.adsl.SixrdIPv4MaskLen.value == ""){
      alert('<% multilang("1921" "LANG_INVALID_6RD_IPV4_MASK_LENGTH"); %>');
      document.adsl.SixrdIPv4MaskLen.focus();
      return false;
     }
     if(document.adsl.SixrdPrefixLen.value == ""){
      alert('<% multilang("1923" "LANG_INVALID_6RD_PREFIX_LENGTH"); %>');
      document.adsl.SixrdPrefixLen.focus();
      return false;
     }
    }
    else{
     document.adsl.SixrdBRv4IP.value = "";
     document.adsl.SixrdPrefix.value = "";
     document.adsl.SixrdPrefixLen.value = "";
    }
   }
   }
  }
 }
 //avoid sending username/password without encode
 disableUsernamePassword();
 return true;
}
function setPPPConnected()
{
 pppConnectStatus = 1;
}
function dnsModeClicked()
{
 if ( document.adsl.dnsMode[0].checked )
 {
  disableTextField(document.adsl.dns1);
  disableTextField(document.adsl.dns2);
 }
 if ( document.adsl.dnsMode[1].checked )
 {
  enableTextField(document.adsl.dns1);
  enableTextField(document.adsl.dns2);
 }
}
function disableFixedIpInput()
{
 disableTextField(document.adsl.ip);
 disableTextField(document.adsl.remoteIp);
 disableTextField(document.adsl.netmask);
 document.adsl.dnsMode[0].disabled = false;
 document.adsl.dnsMode[1].disabled = false;
 dnsModeClicked();
}
function enableFixedIpInput()
{
 enableTextField(document.adsl.ip);
 enableTextField(document.adsl.remoteIp);
 if (document.adsl.adslConnectionMode.value == 4)
  disableTextField(document.adsl.netmask);
 else
  enableTextField(document.adsl.netmask);
 document.adsl.dnsMode[0].disabled = true;
 document.adsl.dnsMode[1].disabled = true;
 dnsModeClicked();
}
function ipTypeSelection(init)
{
 if ( document.adsl.ipMode[0].checked ) {
  enableFixedIpInput();
 } else {
  disableFixedIpInput();
 }
 if (init == 0)
 {
  if ( document.adsl.ipMode[0].checked )
   document.adsl.dnsMode[1].checked = true;
  else
   document.adsl.dnsMode[0].checked = true;
  dnsModeClicked();
 }
}
function enable_pppObj()
{
 enableTextField(document.adsl.pppUserName);
 enableTextField(document.adsl.pppPassword);
 enableTextField(document.adsl.pppConnectType);
 document.adsl.gwStr[0].disabled = false;
 document.adsl.gwStr[1].disabled = false;
 enableTextField(document.adsl.dstGtwy);
 document.adsl.wanIf.disabled = false;
 pppTypeSelection();
 autoDGWclicked();
}
function pppSettingsEnable()
{
 document.getElementById('tbl_ppp').style.display='block';
 enable_pppObj();
}
function disable_pppObj()
{
 disableTextField(document.adsl.pppUserName);
 disableTextField(document.adsl.pppPassword);
 disableTextField(document.adsl.pppIdleTime);
 disableTextField(document.adsl.pppConnectType);
 document.adsl.gwStr[0].disabled = true;
 document.adsl.gwStr[1].disabled = true;
 disableTextField(document.adsl.dstGtwy);
 document.adsl.wanIf.disabled = true;
}
function pppSettingsDisable()
{
 document.getElementById('tbl_ppp').style.display='none';
 disable_pppObj();
}
function enable_ipObj()
{
 if ( document.adsl.adslConnectionMode.value == 4 ) {
  document.adsl.ipMode[0].checked = true;
  if (document.adsl.naptEnabled.checked)
   document.adsl.ipUnnum.disabled = true;
  else
   document.adsl.ipUnnum.disabled = false;
  document.adsl.ipMode[0].disabled = true;
  document.adsl.ipMode[1].disabled = true;
 }
 else {
  document.adsl.ipMode[0].disabled = false;
  document.adsl.ipMode[1].disabled = false;
 }
 document.adsl.gwStr[0].disabled = false;
 document.adsl.gwStr[1].disabled = false;
 enableTextField(document.adsl.dstGtwy);
 document.adsl.wanIf.disabled = false;
 ipTypeSelection(1);
 autoDGWclicked();
}
function ipSettingsEnable()
{
 if (ipver == 2)
  return;
 document.getElementById('tbl_ip').style.display='block';
 enable_ipObj();
}
function disable_ipObj()
{
 document.adsl.ipMode[0].disabled = true;
 document.adsl.ipMode[1].disabled = true;
 document.adsl.gwStr[0].disabled = true;
 document.adsl.gwStr[1].disabled = true;
 disableTextField(document.adsl.dstGtwy);
 document.adsl.wanIf.disabled = true;
 disableFixedIpInput();
}
function ipSettingsDisable()
{
 document.getElementById('tbl_ip').style.display='none';
 disable_ipObj();
}
function ipModeSelection()
{
 if (document.adsl.ipUnnum.checked) {
  disable_pppObj();
  disable_ipObj();
  document.adsl.gwStr[0].disabled = false;
  document.adsl.gwStr[1].disabled = false;
  enableTextField(document.adsl.dstGtwy);
  document.adsl.wanIf.disabled = false;
 }
 else
  enable_ipObj();
}
function adslConnectionModeSelection()
{
 document.adsl.naptEnabled.disabled = false;
 document.adsl.igmpEnabled.disabled = false;
 document.adsl.ipUnnum.disabled = true;
 document.adsl.adslEncap[0].disabled = false;
 document.adsl.adslEncap[1].disabled = false;
 <% checkWrite("naptEnable"); %>
 document.adsl.droute[0].disabled = false;
 document.adsl.droute[1].disabled = false;
 document.getElementById('tbl_ppp').style.display='none';
 document.getElementById('tbl_ip').style.display='none';
 document.getElementById('6rdDiv').style.display='none';
 if (<% checkWrite("IPv6Show"); %>) {
  ipv6SettingsEnable();
  document.getElementById('tbprotocol').style.display="block";
  document.adsl.IpProtocolType.disabled = false;
  if (<% checkWrite("DSLiteShow"); %>) {
   document.getElementById('DSLiteDiv').style.display="none";
  }
 }
 //e = document.getElementById("qosEnabled");
 //if (e) e.disabled = false;
 if (( document.adsl.adslConnectionMode.value == 2 ) ||
  ( document.adsl.adslConnectionMode.value == 3 )) {
  document.getElementById('tbl_ppp').style.display='block';
  ipSettingsDisable();
  pppSettingsEnable();
 }
 else if ( document.adsl.adslConnectionMode.value == 0 || document.adsl.adslConnectionMode.value == 6) {
  // bridge mode or DS-Lite
  document.adsl.naptEnabled.disabled = true;
  document.adsl.igmpEnabled.disabled = true;
  document.adsl.droute[0].disabled = true;
  document.adsl.droute[1].disabled = true;
  pppSettingsDisable();
  ipSettingsDisable();
  //if (e) e.disabled = true;
  if (<% checkWrite("IPv6Show"); %>) {
   ipv6SettingsDisable();
   document.getElementById('tbprotocol').style.display="none";
  }
  // For DS-Lite only
  if (<% checkWrite("IPv6Show"); %> && <% checkWrite("DSLiteShow"); %>) {
   if ( document.adsl.adslConnectionMode.value == 6 )
   {
    document.getElementById('DSLiteDiv').style.display='block';
    document.adsl.droute[0].disabled = false;
    document.adsl.droute[1].disabled = false;
    //document.getElementById('tbprotocol').style.display="block";
    // Set some values for DS-Lite mer mode only
    document.adsl.IpProtocolType.value = 2; // IPV6 only
    //document.adsl.IpProtocolType.disabled = true;
    document.adsl.slacc.checked = false; // not use slaac
    document.adsl.staticIpv6.checked = false; // not use static IP
    document.adsl.itfenable.checked = false; // not enable DHCPv6 client
   }
  }
 }
 else if ( document.adsl.adslConnectionMode.value == 4 ) {
  // Route1483
  document.adsl.ipMode[0].checked = true;
  document.adsl.ipUnnum.disabled = false;
  pppSettingsDisable();
  ipSettingsEnable();
  document.adsl.ipMode[0].disabled = true;
  document.adsl.ipMode[1].disabled = true;
  disableTextField(document.adsl.netmask);
 }
 else if ( document.adsl.adslConnectionMode.value == 5 ) {
  // Route1577
  document.adsl.ipMode[0].checked = true;
  pppSettingsDisable();
  ipSettingsEnable();
  document.adsl.ipMode[0].disabled = true;
  document.adsl.ipMode[1].disabled = true;
  document.adsl.adslEncap[0].disabled = true;
  document.adsl.adslEncap[1].disabled = true;
  document.adsl.adslEncap[0].checked = true;
  document.adsl.adslEncap.value = 1;
 }
 else if ( document.adsl.adslConnectionMode.value == 8 ) { //6rd
  if (<% checkWrite("IPv6Show"); %> && <% checkWrite("6rdShow"); %>)
  {
   document.getElementById('6rdDiv').style.display='block';
   document.adsl.droute[0].checked = false;
   document.adsl.droute[1].checked = true;
   document.adsl.IpProtocolType.value = 3; // IPV4/IPV6
   document.adsl.slacc.checked = false; // not use slaac
   document.adsl.staticIpv6.checked = false; // not use static IP
   document.adsl.itfenable.checked = false; // not enable DHCPv6 client
   ipSettingsEnable();
   enableFixedIpInput();
   ipv6SettingsDisable();
      document.getElementById('tbprotocol').style.display="none";
  }
    }
 else {
  pppSettingsDisable();
  ipSettingsEnable();
 }
}
function naptClicked()
{
 if (document.adsl.adslConnectionMode.value == 4) {
  // Route1483
  if (document.adsl.naptEnabled.checked == true) {
   document.adsl.ipUnnum.checked = false;
   document.adsl.ipUnnum.disabled = true;
  }
  else
   document.adsl.ipUnnum.disabled = false;
  ipModeSelection();
 }
}
function clearAll()
{
 document.adsl.vpi.value = 0;
 document.adsl.vci.value = "";
 document.adsl.adslEncap.value = 1;
 document.adsl.naptEnabled.checked = false;
 document.adsl.igmpEnabled.checked = false;
 document.adsl.adslConnectionMode.value = 0;
 document.adsl.pppUserName.value = "";
 document.adsl.pppPassword.value = "";
 document.adsl.pppConnectType.value = 0;
 document.adsl.pppIdleTime.value = "";
 document.adsl.ipUnnum.checked = false;
 document.adsl.ipMode.value = 0;
 document.adsl.ip.value = "";
 document.adsl.remoteIp.value = "";
 document.adsl.netmask.value = "";
 document.adsl.adslEncap[0].disabled = false;
 document.adsl.adslEncap[1].disabled = false;
}
function postVC(vpi,vci,encap,napt,ctype,vlan,vid,vprio,igmp,qos,mode,username,passwd,pppType,idletime,ipunnum,ipmode,ipaddr,remoteip,netmask,dnsMode,dns1Addr,dns2Addr,droute,status,enable,ptmap)
{
 var pmchkpt = document.getElementById("tbl_pmap");
 clearAll();
 document.adsl.vpi.value = vpi;
 document.adsl.vci.value = vci;
 if (encap == "LLC")
  document.adsl.adslEncap[0].checked = true;
 else
  document.adsl.adslEncap[1].checked = true;
 if (mode == "br1483")
  document.adsl.adslConnectionMode.value = 0;
 else if (mode == "mer1483")
  document.adsl.adslConnectionMode.value = 1;
 else if (mode == "PPPoE")
  document.adsl.adslConnectionMode.value = 2;
 else if (mode == "PPPoA")
  document.adsl.adslConnectionMode.value = 3;
 else if (mode == "rt1483")
  document.adsl.adslConnectionMode.value = 4;
 else if (mode == "rt1577")
  document.adsl.adslConnectionMode.value = 5;
 adslConnectionModeSelection();
 if (napt == "On")
  document.adsl.naptEnabled.checked = true;
 else
  document.adsl.naptEnabled.checked = false;
 if (igmp == "On")
  document.adsl.igmpEnabled.checked = true;
 else
  document.adsl.igmpEnabled.checked = false;
 if (qos == "On")
  document.adsl.qosEnabled.checked = true;
 else
  document.adsl.qosEnabled.checked = false;
 if (enable == 0)
  document.adsl.chEnable[1].checked = true;
 else
  document.adsl.chEnable[0].checked = true;
 if (mode == "PPPoE" || mode == "PPPoA")
 {
  document.adsl.pppUserName.value = decode64(username);
  document.adsl.pppPassword.value = passwd;
  if (pppType == "conti")
   document.adsl.pppConnectType.value = 0;
  else if (pppType == "demand")
   document.adsl.pppConnectType.value = 1;
  else
  {
   document.adsl.pppConnectType.value = 2;
  }
  pppTypeSelection();
  if (pppType == "demand")
   document.adsl.pppIdleTime.value = idletime;
 }
 else if (mode == "mer1483" || mode == "rt1483" || mode == "rt1577")
 {
  document.adsl.ipMode[ipmode].checked = true;
  ipTypeSelection();
  if (ipmode == 0)
  {
   document.adsl.ip.value=ipaddr;
   document.adsl.remoteIp.value=remoteip;
   document.adsl.netmask.value=netmask;
  }
  if (dnsMode == 1)
   document.adsl.dnsMode[0].checked = true;
  else
   document.adsl.dnsMode[1].checked = true;
  document.adsl.dns1.value = dns1Addr;
  document.adsl.dns2.value = dns2Addr;
  if (mode == "rt1483")
  {
   if (ipunnum == 1)
    document.adsl.ipUnnum.checked = true;
   else
    document.adsl.ipUnnum.checked = false;
   ipModeSelection();
   disableTextField(document.adsl.netmask);
  }
 }
 if (pmchkpt)
  for(var i = 0; i < 14; i ++) document.adsl.chkpt[i].checked = (ptmap & (0x1 << i));
 <% checkWrite("pppoeProxyEnable"); %>
 <% checkWrite("dgw"); %>
}
function postVC2(vpi,vci,encap,napt,ctype,vlan,vid,vprio,igmp,qos,mode,username,passwd,pppType,idletime,ipunnum,ipmode,ipaddr,remoteip,netmask,dnsMode,dns1Addr,dns2Addr,droute,status,enable,ptmap,
                protocoltype, ipv6type, ipv6add, ipv6gw, ipv6dns1, ipv6dns2, ipv6End, ipv6prefix, ipv6dhcpcenable, ipv6request, SixrdBRv4IP, SixrdIPv4MaskLen,SixrdPrefix,SixrdPrefixLen)
{
 var pmchkpt = document.getElementById("tbl_pmap");
 clearAll();
 document.adsl.vpi.value = vpi;
 document.adsl.vci.value = vci;
 if (vlan == 0)
  document.adsl.vlan[0].checked = true;
 else
  document.adsl.vlan[1].checked = true;
 document.adsl.vid.value = vid;
 document.adsl.vprio.selectedIndex=vprio;
 if (document.adsl.vlan[0].checked){
  document.adsl.vid.disabled=true;
  document.adsl.vprio.disabled=true;}
 else{
  document.adsl.vid.disabled=false;
  document.adsl.vprio.disabled=false;}
 if (encap == "LLC")
  document.adsl.adslEncap[0].checked = true;
 else
  document.adsl.adslEncap[1].checked = true;
 if (mode == "br1483")
  document.adsl.adslConnectionMode.value = 0;
 else if (mode == "mer1483")
  document.adsl.adslConnectionMode.value = 1;
 else if (mode == "PPPoE")
  document.adsl.adslConnectionMode.value = 2;
 else if (mode == "PPPoA")
  document.adsl.adslConnectionMode.value = 3;
 else if (mode == "rt1483")
  document.adsl.adslConnectionMode.value = 4;
 else if (mode == "rt1577")
  document.adsl.adslConnectionMode.value = 5;
 else if (mode == "DS-Lite-mer")
  document.adsl.adslConnectionMode.value = 6;
 if (ctype == "None")
  document.adsl.ctype.value = 0;
 else if (ctype == "TR069")
  document.adsl.ctype.value = 1;
 else if (ctype == "INTERNET")
  document.adsl.ctype.value = 2;
 else if (ctype == "OTHER")
  document.adsl.ctype.value = 4;
 else if (ctype == "VOICE")
  document.adsl.ctype.value = 8;
 else if (ctype == "INTERNET_TR069")
  document.adsl.ctype.value = 3;
 else if (ctype == "VOICE_TR069")
  document.adsl.ctype.value = 9;
 else if (ctype == "VOICE_INTERNET")
  document.adsl.ctype.value = 10;
 else if (ctype == "VOICE_INTERNET_TR069")
  document.adsl.ctype.value = 11;
 adslConnectionModeSelection();
 if (mode == "DS-Lite-mer")
 {
  document.adsl.DSLiteLocalIP.value = ipv6add;
  document.adsl.DSLiteRemoteIP.value = ipv6End;
  document.adsl.DSLiteGateway.value = ipv6gw;
 }
 if (napt == "On")
  document.adsl.naptEnabled.checked = true;
 else
  document.adsl.naptEnabled.checked = false;
 if (igmp == "On")
  document.adsl.igmpEnabled.checked = true;
 else
  document.adsl.igmpEnabled.checked = false;
 if (qos == "On")
  document.adsl.qosEnabled.checked = true;
 else
  document.adsl.qosEnabled.checked = false;
 if (enable == 0)
  document.adsl.chEnable[1].checked = true;
 else
  document.adsl.chEnable[0].checked = true;
 if (mode == "PPPoE" || mode == "PPPoA")
 {
  document.adsl.pppUserName.value = decode64(username);
  document.adsl.pppPassword.value = passwd;
  if (pppType == "conti")
   document.adsl.pppConnectType.value = 0;
  else if (pppType == "demand")
   document.adsl.pppConnectType.value = 1;
  else
  {
   document.adsl.pppConnectType.value = 2;
  }
  pppTypeSelection();
  if (pppType == "demand")
   document.adsl.pppIdleTime.value = idletime;
 }
 else if (mode == "mer1483" || mode == "rt1483" || mode == "rt1577")
 {
  document.adsl.ipMode[ipmode].checked = true;
  ipTypeSelection();
  if (ipmode == 0)
  {
   document.adsl.ip.value=ipaddr;
   document.adsl.remoteIp.value=remoteip;
   document.adsl.netmask.value=netmask;
  }
  if (dnsMode == 1)
   document.adsl.dnsMode[0].checked = true;
  else
   document.adsl.dnsMode[1].checked = true;
  document.adsl.dns1.value = dns1Addr;
  document.adsl.dns2.value = dns2Addr;
  if (mode == "rt1483")
  {
   if (ipunnum == 1)
    document.adsl.ipUnnum.checked = true;
   else
    document.adsl.ipUnnum.checked = false;
   ipModeSelection();
   disableTextField(document.adsl.netmask);
  }
 }
 else if (mode == "6rd")
 {
  document.getElementById('6rdDiv').style.display='block';
  document.adsl.droute[0].checked = false;
  document.adsl.droute[1].checked = true;
  document.adsl.IpProtocolType.value = 3; // IPV4/IPV6
  document.adsl.slacc.checked = false; // not use slaac
  document.adsl.staticIpv6.checked = false; // not use static IP
  document.adsl.itfenable.checked = false; // not enable DHCPv6 client
  ipSettingsEnable();
  enableFixedIpInput();
  ipv6SettingsDisable();
  document.getElementById('tbprotocol').style.display="none";
  document.adsl.ip.value=ipaddr;
  document.adsl.remoteIp.value=remoteip;
  document.adsl.netmask.value=netmask;
  document.adsl.SixrdBRv4IP.value= SixrdBRv4IP;
  document.adsl.SixrdIPv4MaskLen.value = SixrdIPv4MaskLen;
  document.adsl.SixrdPrefix.value = SixrdPrefix;
  document.adsl.SixrdPrefixLen.value = SixrdPrefixLen;
 }
 <% checkWrite("pppoeProxyEnable"); %>
 <% checkWrite("dgw"); %>
 /* Mason Yu:20110307 START ipv6 setting */
 if(mode != "br1483" && mode != "DS-Lite-mer"){
  document.adsl.IpProtocolType.value = protocoltype;
  ipver = protocoltype;
  protocolChange();
  if(protocoltype != 1){
   //document.adsl.Ipv6AddrType.value = ipv6type;
   if ( (ipv6type & 0x1) == 0x1 )
    document.adsl.slacc.checked = true;
   if ( (ipv6type & 0x2) == 0x2 )
    document.adsl.staticIpv6.checked = true;
   //if(ipv6type == 1){
   if( (ipv6type & 0x2) == 0x2){
    document.adsl.Ipv6Addr.value = ipv6add;
    document.adsl.Ipv6PrefixLen.value = ipv6prefix;
    document.adsl.Ipv6Gateway.value = ipv6gw;
    document.adsl.Ipv6Dns1.value = ipv6dns1;
    document.adsl.Ipv6Dns2.value = ipv6dns2;
   }
   if(ipv6dhcpcenable==1)
    document.adsl.itfenable.checked = true;
   else
    document.adsl.itfenable.checked = false;
   ipv6WanUpdate();
   if(ipv6dhcpcenable==1){
    //if(ipv6requestaddr != 0)
    if( (ipv6request & 0x1) == 0x1 )
     document.adsl.iana.checked = true;
    else
     document.adsl.iana.checked = false;
    //if(ipv6requestprefix != 0)
    if( (ipv6request & 0x2) == 0x2 )
     document.adsl.iapd.checked = true;
    else
     document.adsl.iapd.checked = false;
   }
  }
 }
 /* Mason Yu:20110307 END */
 if (pmchkpt)
  for(var i = 0; i < 14; i ++) document.adsl.chkpt[i].checked = (ptmap & (0x1 << i));
}
function updatepvcState()
{
  if (document.adsl.autopvc.checked == true) {
   document.adsl.autopvc.value="ON";
 document.adsl.enablepvc.value = 1;
 enableTextField(document.adsl.autopvcvci);
 enableTextField(document.adsl.autopvcvpi);
 enableButton(document.adsl.autopvcadd);
  } else {
   document.adsl.autopvc.value="OFF";
 document.adsl.enablepvc.value = 0;
 disableTextField(document.adsl.autopvcvci);
 disableTextField(document.adsl.autopvcvpi);
 disableButton(document.adsl.autopvcadd);
  }
}
function updatepvcState2()
{
  if (document.adsl.autopvc.checked == true) {
   document.adsl.autopvc.value="ON";
 document.adsl.enablepvc.value = 1;
 //enableTextField(document.adsl.autopvcvci);
 //enableTextField(document.adsl.autopvcvpi);
 //enableButton(document.adsl.autopvcadd);
  } else {
   document.adsl.autopvc.value="OFF";
 document.adsl.enablepvc.value = 0;
 //disableTextField(document.adsl.autopvcvci);
 //disableTextField(document.adsl.autopvcvpi);
 //disableButton(document.adsl.autopvcadd);
  }
}
function autopvcEnableClick()
{
 disableUsernamePassword();
 return true;
}
function autopvcCheckClick()
{
 var dVPI,dVCI;
 if (document.adsl.autopvc.checked == true) {
  document.adsl.enablepvc.value = 1;
  dVPI = getDigit(document.adsl.autopvcvpi.value, 1);
  if ( validateKey(document.adsl.autopvcvpi.value) == 0 ||
   (dVPI > 255 || dVPI < 0) ) {
   alert('<% multilang("1929" "LANG_INVALID_VPI_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_0_255"); %>');
   document.adsl.autopvcvpi.focus();
   return false;
  }
  dVCI = getDigit(document.adsl.autopvcvci.value, 1);
  if ( validateKey(document.adsl.autopvcvci.value) == 0 ||
   (dVCI > 65535 || dVCI < 0) ) {
   alert('<% multilang("1931" "LANG_INVALID_VCI_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_0_65535"); %>');
   document.adsl.autopvcvci.focus();
   return false;
  }
  if ( (dVPI == 0 && dVCI == 0) ) {
   alert('<% multilang("1932" "LANG_INVALID_VPI_VCI_VALUE"); %>');
   document.adsl.autopvcvpi.focus();
   return false;
  }
  document.adsl.addVPI.value = dVPI;
  document.adsl.addVCI.value = dVCI;
  disableUsernamePassword();
 }else {
  alert('<% multilang("1933" "LANG_YOU_SHOULD_ENABLE_AUTO_PVC_SEARCH_FIRST"); %>');
  return false;
 }
}
function hideGWInfo(hide) {
 var status = false;
 if (hide == 1)
  status = true;
 changeBlockState('gwInfo', status);
 if (hide == 0) {
  with (document.forms[0]) {
   if (dgwstatus == 255) {
    if (isValidIpAddress(gtwy) == true) {
     gwStr[0].checked = true;
     gwStr[1].checked = false;
     dstGtwy.value=gtwy;
     wanIf.disabled=true
    } else {
     gwStr[0].checked = false;
     gwStr[1].checked = true;
     dstGtwy.value = '';
    }
   }
   else if (dgwstatus != 239) {
     gwStr[1].checked = true;
     gwStr[0].checked = false;
     wanIf.disabled=false;
     wanIf.value=dgwstatus;
     dstGtwy.disabled=true;
   } else {
     gwStr[1].checked = false;
     gwStr[0].checked = true;
     wanIf.disabled=true;
     dstGtwy.disabled=false;
   }
  }
 }
}
function autoDGWclicked() {
 if (document.adsl.droute[0].checked == true) {
  hideGWInfo(1);
 } else {
  hideGWInfo(0);
 }
}
function gwStrClick() {
 with (document.forms[0]) {
  if (gwStr[1].checked == true) {
   dstGtwy.disabled = true;
   wanIf.disabled = false;
  }
  else {
   dstGtwy.disabled = false;
   wanIf.disabled = true;
  }
       }
}
/* Mason Yu:20110307 START ipv6 setting */
function dhcp6cEnable()
{
 if(document.adsl.itfenable.checked)
  document.getElementById('dhcp6c_block').style.display="block";
 else
  document.getElementById('dhcp6c_block').style.display="none";
}
function ipv6StaticUpdate()
{
 if(document.adsl.staticIpv6.checked)
  document.getElementById('secIPv6Div').style.display="block";
 else
  document.getElementById('secIPv6Div').style.display="none";
}
function ipv6WanUpdate()
{
 ipv6StaticUpdate();
 dhcp6cEnable();
}
function ipv6SettingsDisable()
{
 document.getElementById('tbipv6wan').style.display="none";
 document.getElementById('secIPv6Div').style.display="none";
 document.getElementById('dhcp6c_ctrlblock').style.display="none";
}
function ipv6SettingsEnable()
{
 if(document.adsl.IpProtocolType.value != 1){
  document.getElementById('tbipv6wan').style.display="block";
  document.getElementById('dhcp6c_ctrlblock').style.display="block";
  ipv6WanUpdate();
   }
}
function protocolChange()
{
 ipver = document.adsl.IpProtocolType.value;
 if(document.adsl.IpProtocolType.value == 1){
  if( document.adsl.adslConnectionMode.value ==1 ||
   document.adsl.adslConnectionMode.value ==4 ||
   document.adsl.adslConnectionMode.value ==5)
   ipSettingsEnable();
   ipv6SettingsDisable();
 }else if(document.adsl.adslConnectionMode.value !=8 ){
  if(document.adsl.IpProtocolType.value == 2){
   ipSettingsDisable();
  }else{
   if( document.adsl.adslConnectionMode.value ==1 ||
    document.adsl.adslConnectionMode.value ==4 ||
    document.adsl.adslConnectionMode.value ==5)
    ipSettingsEnable();
  }
  ipv6SettingsEnable();
 }
}
/* Mason Yu:20110307 END */
/*
function SubmitWANMode() // Magician: ADSL/Ethernet WAN mode switch
{
	var wmmap = 0;
	var config_num = 3;

	with (document.forms[0])
	{
		for(var i = 0; i < config_num; i ++)
			if(wmchkbox[i].checked == true)
				wmmap |= (0x1 << i);

		if(wmmap == 0 || wmmap == wanmode)
			return false;

		wan_mode.value = wmmap;
	}

	return confirm("It needs rebooting to change WAN mode.");
}
*/
function click1q()
{
 if (document.adsl.vlan[0].checked){
  document.adsl.vid.disabled=true;
  document.adsl.vprio.disabled=true;}
 else{
  document.adsl.vid.disabled=false;
  document.adsl.vprio.disabled=false;
  document.adsl.vprio.selectedIndex=0;}
}
function check1q(str)
{
 for (var i=0; i<str.length; i++) {
  if ((str.charAt(i) >= '0' && str.charAt(i) <= '9'))
   continue;
  return false;
 }
 d = parseInt(str, 10);
 if (d < 0 || d > 4095)
  return false;
 return true;
}
function apply1q()
{
 if (!check1q(document.adsl.vid.value)) {
  alert('<% multilang("1934" "LANG_INVALID_VLAN_ID"); %>');
  document.adsl.vid.focus();
  return false;
 }
 return true;
}
</script>
</head>
<BODY>
<blockquote>
<h2><font color="#0000FF"><% multilang("12" "LANG_DSL_WAN"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/admin/formWanAdsl method=POST name="adsl">
<input type="hidden" name="encodePppUserName" value="">
<input type="hidden" name="encodePppPassword" value="">
<table border="0" cellspacing="4" width="800">
 <tr><td><font size=2>
    <% multilang("213" "LANG_PAGE_DESC_CONFIGURE_PARAMETERS"); %><% multilang("214" "LANG_WAN_MODE"); %>
 </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<!--<table border="0" cellspacing="4" width="800" <% WANConditions(); %>>
 <tr>
  <td>
   <b><% multilang("214" "LANG_WAN_MODE"); %>:</b>
   <span <% checkWrite("wan_mode_atm"); %>><input type="checkbox" value=1 name="wmchkbox">ATM</span>
   <span <% checkWrite("wan_mode_ethernet"); %>><input type="checkbox" value=2 name="wmchkbox">Ethernet</span>
   <span <% checkWrite("wan_mode_ptm"); %>><input type="checkbox" value=4 name="wmchkbox">PTM</span>&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="hidden" name="wan_mode" value=0>
   <input type="submit" value="Submit" name="submitwan" onClick="return SubmitWANMode()">
  </td>
 </tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table> -->
<table border=0 width="800" cellspacing=4 cellpadding=0>
 <tr>
  <td>
   <font size=2><b>VPI: </b>
   <input type="text" name="vpi" size="4" maxlength="3" value=0>&nbsp;&nbsp;
   <b>VCI: </b>
   <input type="text" name="vci" size="6" maxlength="5"></font></td>
  <td><font size=2><b><% multilang("74" "LANG_ENCAPSULATION"); %>: </b>
   <input type="radio" value="1" name="adslEncap" checked>LLC&nbsp;&nbsp;
   <input type="radio" value="0" name="adslEncap">VC-Mux</font></td>
  <td>
  <% ShowChannelMode("adslcmode"); %>
  </td>
 </tr>
 <tr>
  <td>
  <% ShowNAPTSetting(); %>
  </td>
  <td <% checkWrite("IPQoS"); %>><font size=2>
   <b>Enable QoS: </b>
   <input type="checkbox" name="qosEnabled" size="2" maxlength="2" value="ON" >
  </font></td>
 </tr>
 <tr>
  <td>
   <font size=2><b><% multilang("222" "LANG_ADMIN_STATUS"); %>:</b>
   <input type="radio" value=1 name="chEnable" checked><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
   <input type="radio" value=0 name="chEnable"><% multilang("206" "LANG_DISABLE"); %></font>
  </td>
 </tr>
 <% ShowConnectionType() %>
</table>
<div ID=vlan_show style="display:none">
<table>
 <td><font size=2><b>Enable VLAN:</b>
  <input type=radio value=0 name="vlan" checked onClick=click1q()>Disable&nbsp;&nbsp;
  <input type=radio value=1 name="vlan" onClick=click1q()>Enable
 </font></td><td></td>
 <td><font size=2>
  VLAN ID(0-4095):&nbsp;&nbsp;
  <input type=text name=vid size=6 maxlength=4 value=0 disabled>
 </font></td><td></td>
 <td><font size=2><% multilang("243" "LANG_802_1P_MARK"); %>:
   <select style="WIDTH: 60px" name="vprio">
  <option value="0" > </option>
  <option value="1" > 0 </option>
  <option value="2" > 1 </option>
  <option value="3" > 2 </option>
  <option value="4" > 3 </option>
  <option value="5" > 4 </option>
  <option value="6" > 5 </option>
  <option value="7" > 6 </option>
  <option value="8" > 7 </option>
   </select>
 </font></td>
</table>
</div>
<div ID=dgwshow style="display:none">
<table>
<td><font size=2><b><% multilang("221" "LANG_DEFAULT_ROUTE"); %>:</b>
 <input type=radio value=0 name="droute"><% multilang("206" "LANG_DISABLE"); %>
 <input type=radio value=1 name="droute" checked><% multilang("207" "LANG_ENABLE"); %></font>
</td>
</table>
</div>
<div ID=IGMPProxy_show style="display:none">
<table>
 <% ShowIGMPSetting(); %>
</table>
</div>
<!-- Mason Yu:20110307 ipv6 setting -->
<% ShowIpProtocolType(); %>
<% ShowPPPIPSettings("atm"); %>
<% ShowDefaultGateway("p2p"); %>
<% Show6rdSetting(); %>
<!-- Mason Yu:20110307 ipv6 setting -->
<% ShowIPV6Settings(); %>
<% ShowPortMapping(); %>
<% ShowDSLiteSetting(); %>
<BR>
<input type="hidden" value=<% getInfo("url_wanadsl"); %> name="submit-url">
<input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="add" onClick="return addClick()">
<input type="submit" value="<% multilang("261" "LANG_MODIFY"); %>" name="modify" onClick="return vcCheck()">
<BR>
<BR>
<table border="0" width=900>
 <tr><font size=2><b><% multilang("258" "LANG_CURRENT_ATM_VC_TABLE"); %>:</b></font></tr>
 <% atmVcList2(); %>
</table>
<br>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delvc" onClick="return deleteClick()">
<% ShowAutoPVC(); %>
 <input type="hidden" name="itfGroup" value=0>
<script>
 initConnectMode = document.adsl.adslConnectionMode.selectedIndex;
 <% initPage("dgw"); %>
 <% GetDefaultGateway(); %>
 autoDGWclicked();
 adslConnectionModeSelection();
 <% checkWrite("devType");
    checkWrite("vcCount"); %>
</script>
</form>
<form action=/boaform/admin/formWanAdsl method=POST name="actionForm">
<input type="hidden" value="/wanadsl.asp" name="submit-url">
<input type="hidden" name="action">
<input type="hidden" name="idx">
<!--<script>
 var wanmode = <% getInfo("wan_mode"); %>;
 if((wanmode & 1) == 1)
  document.adsl.wmchkbox[0].checked = true;
 if((wanmode & 2) == 2)
  document.adsl.wmchkbox[1].checked = true;
 if((wanmode & 4) == 4)
  document.adsl.wmchkbox[2].checked = true;
</script> -->
</form>
</blockquote>
</body>
</html>

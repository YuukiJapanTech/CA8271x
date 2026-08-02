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
<title><% getWanIfDisplay(); %> <% multilang("10" "LANG_WAN"); %></title>
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
var curlink = null;
var ctype = 4;
var cgi = new Object();
var links = new Array();
with(links){<% initPageWaneth(); %>}
function pppTypeSelection()
{
 if ( document.ethwan.pppConnectType.selectedIndex == 2) {
  document.ethwan.pppIdleTime.value = "";
  disableTextField(document.ethwan.pppIdleTime);
 }
 else {
  if (document.ethwan.pppConnectType.selectedIndex == 1) {
   enableTextField(document.ethwan.pppIdleTime);
  }
  else {
   document.ethwan.pppIdleTime.value = "";
   disableTextField(document.ethwan.pppIdleTime);
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
function check_dhcp_opts()
{
 with (document.forms[0])
 {
  /* Option 60 */
  if(typeof enable_opt_60 !== 'undefined' &&enable_opt_60.checked)
  {
   if (opt60_val.value=="") {
    alert('<% multilang("1888" "LANG_VENDOR_ID_CANNOT_BE_EMPTY"); %>');
    opt60_val.focus();
    return false;
   }
   if (checkString(opt60_val.value) == 0) {
    alert('<% multilang("1889" "LANG_INVALID_VENDOR_ID"); %>');
    opt60_val.focus();
    return false;
   }
  }
  /* Option 61 */
  if(typeof enable_opt_61 !== 'undefined'&&enable_opt_61.checked)
  {
   if (iaid.value=="") {
    alert('<% multilang("1890" "LANG_IAID_CANNOT_BE_EMPTY"); %>');
    iaid.focus();
    return false;
   }
   if (checkDigit(iaid.value) == 0) {
    alert('<% multilang("1891" "LANG_IAID_SHOULD_BE_A_NUMBER"); %>');
    iaid.focus();
    return false;
   }
   if(duid_type[1].checked)
   {
    /* Enterprise number + Identifier*/
    if (duid_ent_num.value=="") {
     alert('<% multilang("1892" "LANG_ENTERPRISE_NUMBER_CANNOT_BE_EMPTY"); %>');
     duid_ent_num.focus();
     return false;
    }
    if (checkDigit(duid_ent_num.value) == 0) {
     alert('<% multilang("1893" "LANG_ENTERPRISE_NUMBER_SHOULD_BE_A_NUMBER"); %>');
     duid_ent_num.focus();
     return false;
    }
    if (duid_id.value=="") {
     alert('<% multilang("1894" "LANG_DUID_IDENTIFIER_CANNOT_BE_EMPTY"); %>');
     duid_id.focus();
     return false;
    }
    if (checkString(duid_id.value) == 0) {
     alert('<% multilang("1895" "LANG_INVALID_DUID_IDENTIFIER"); %>');
     duid_id.focus();
     return false;
    }
   }
  }
  if(typeof enable_opt_125 !== 'undefined' &&enable_opt_125.checked)
  {
   if (manufacturer.value=="") {
    alert('<% multilang("1896" "LANG_MANUFACTURER_OUI_CANNOT_BE_EMPTY"); %>');
    manufacturer.focus();
    return false;
   }
   if (checkString(manufacturer.value) == 0) {
    alert('<% multilang("1897" "LANG_INVALID_MANUFACTURER_OUI"); %>');
    manufacturer.focus();
    return false;
   }
   if (product_class.value=="") {
    alert('<% multilang("1898" "LANG_PRODUCT_CLASS_CANNOT_BE_EMPTY"); %>');
    product_class.focus();
    return false;
   }
   if (checkString(product_class.value) == 0) {
    alert('<% multilang("1899" "LANG_INVALID_PRODUCT_CLASS"); %>');
    product_class.focus();
    return false;
   }
   if (model_name.value=="") {
    alert('<% multilang("1900" "LANG_MODEL_NAME_CANNOT_BE_EMPTY"); %>');
    model_name.focus();
    return false;
   }
   if (checkString(model_name.value) == 0) {
    alert('<% multilang("1901" "LANG_INVALID_MODEL_NAME"); %>');
    model_name.focus();
    return false;
   }
   if (serial_num.value=="") {
    alert('<% multilang("1902" "LANG_SERIAL_NUMBER_CANNOT_BE_EMPTY"); %>');
    serial_num.focus();
    return false;
   }
   if (checkString(serial_num.value) == 0) {
    alert('<% multilang("1902" "LANG_SERIAL_NUMBER_CANNOT_BE_EMPTY"); %>');
    serial_num.focus();
    return false;
   }
  }
 }
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
 disableTextField(document.ethwan.pppUserName);
 if(!isAllStar(document.ethwan.pppPassword.value))
  disableTextField(document.ethwan.pppPassword);
}
function applyCheck()
{
 var tmplst = "";
 var ptmap = 0;
 var pmchkpt = document.getElementById("tbl_pmap");
 if (pmchkpt) {
  with (document.forms[0]) {
   for (var i = 0; i < 14; i++) {
    /* chkpt do not always have 14 elements */
    if (!chkpt[i])
     break;
    if (chkpt[i].checked == true)
     ptmap |= (0x1 << i);
   }
   itfGroup.value = ptmap;
  }
 }
 if (checkDefaultGW()==false)
  return false;
 if (document.ethwan.vlan.checked == true) {
  if (document.ethwan.vid.value == "") {
   alert('<% multilang("1904" "LANG_VID_SHOULD_NOT_BE_EMPTY"); %>');
   document.ethwan.vid.focus();
   return false;
  }
 }
 if ( document.ethwan.adslConnectionMode.value == 2 ) {
  if (document.ethwan.pppUserName.value=="") {
   alert('<% multilang("1905" "LANG_PPP_USER_NAME_CANNOT_BE_EMPTY"); %>');
   document.ethwan.pppUserName.focus();
   return false;
  }
  if (includeSpace(document.ethwan.pppUserName.value)) {
   alert('<% multilang("1906" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PPP_USER_NAME"); %>');
   document.ethwan.pppUserName.focus();
   return false;
  }
  if (checkString(document.ethwan.pppUserName.value) == 0) {
   alert('<% multilang("1907" "LANG_INVALID_PPP_USER_NAME"); %>');
   document.ethwan.pppUserName.focus();
   return false;
  }
  document.ethwan.encodePppUserName.value=encode64(document.ethwan.pppUserName.value);
  if (document.ethwan.pppPassword.value=="") {
   alert('<% multilang("1908" "LANG_PPP_PASSWORD_CANNOT_BE_EMPTY"); %>');
   document.ethwan.pppPassword.focus();
   return false;
  }
  if(!isAllStar(document.ethwan.pppPassword.value)){
   if (includeSpace(document.ethwan.pppPassword.value)) {
    alert('<% multilang("1909" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PPP_PASSWORD"); %>');
    document.ethwan.pppPassword.focus();
    return false;
   }
   if (checkString(document.ethwan.pppPassword.value) == 0) {
    alert('<% multilang("1910" "LANG_INVALID_PPP_PASSWORD"); %>');
    document.ethwan.pppPassword.focus();
    return false;
   }
   document.ethwan.encodePppPassword.value=encode64(document.ethwan.pppPassword.value);
  }
  if (document.ethwan.pppConnectType.selectedIndex == 1) {
   if (document.ethwan.pppIdleTime.value <= 0) {
    alert('<% multilang("1911" "LANG_INVALID_PPP_IDLE_TIME"); %>');
    document.ethwan.pppIdleTime.focus();
    return false;
   }
  }
 }
 if (document.ethwan.dns1.value !="")
 {
  if (!checkHostIP(document.ethwan.dns1, 1))
  {
   document.ethwan.dns1.focus();
   return false;
  }
 }
 if (document.ethwan.dns2.value !="")
 {
  if (!checkHostIP(document.ethwan.dns2, 1))
  {
   document.ethwan.dns2.focus();
   return false;
  }
 }
 if (<% checkWrite("IPv6Show"); %>) {
  if(document.ethwan.IpProtocolType.value & 1){
   if ( document.ethwan.adslConnectionMode.value == 1 ) {
    if (document.ethwan.ipMode[0].checked)
    {
     /*Fixed IP*/
     if ( document.ethwan.ipUnnum.disabled || ( !document.ethwan.ipUnnum.disabled && !document.ethwan.ipUnnum.checked )) {
      if (!checkHostIP(document.ethwan.ip, 1))
       return false;
      if (document.ethwan.remoteIp.visiblity == "hidden") {
       if (!checkHostIP(document.ethwan.remoteIp, 1))
       return false;
      }
      if (document.ethwan.adslConnectionMode.value == 1 && !checkNetmask(document.ethwan.netmask, 1))
       return false;
     }
    }
    else
    {
     /* DHCP */
     if(check_dhcp_opts() == false)
      return false;
    }
   }
  }
 }
 if (<% checkWrite("IPv6Show"); %>) {
  if(document.ethwan.IpProtocolType.value & 2)
  {
   if (document.ethwan.adslConnectionMode.value != 0 && document.ethwan.adslConnectionMode.value != 6 && document.ethwan.adslConnectionMode.value != 8) {
    if(document.ethwan.slacc.checked == false && document.ethwan.itfenable.checked == false && document.ethwan.staticIpv6.checked == false){
     alert('<% multilang("1912" "LANG_PLEASE_INPUT_IPV6_ADDRESS_OR_SELECT_DHCPV6_CLIENT_OR_CLICK_SLAAC"); %>');
     document.ethwan.slacc.focus();
     return false;
    }
   }
   if(document.ethwan.itfenable.checked) {
    if(document.ethwan.iana.checked == false && document.ethwan.iapd.checked == false ) {
     alert('<% multilang("1913" "LANG_PLEASE_SELECT_IANA_OR_IAPD"); %>');
     document.ethwan.iana.focus();
     return false;
    }
   }
   if(document.ethwan.staticIpv6.checked) {
    if(document.ethwan.Ipv6Addr.value == "" || document.ethwan.Ipv6PrefixLen.value == "") {
     alert('<% multilang("1914" "LANG_PLEASE_INPUT_IPV6_ADDRESS_AND_PREFIX_LENGTH"); %>');
     document.ethwan.Ipv6Addr.focus();
     return false;
    }
    if(document.ethwan.Ipv6Addr.value != ""){
     if (! isGlobalIpv6Address( document.ethwan.Ipv6Addr.value) ){
      alert('<% multilang("1915" "LANG_INVALID_IPV6_ADDRESS"); %>');
      document.ethwan.Ipv6Addr.focus();
      return false;
     }
     var prefixlen= getDigit(document.ethwan.Ipv6PrefixLen.value, 1);
     if (prefixlen > 128 || prefixlen <= 0) {
      alert('<% multilang("1916" "LANG_INVALID_IPV6_PREFIX_LENGTH"); %>');
      document.ethwan.Ipv6PrefixLen.focus();
      return false;
     }
    }
    if(document.ethwan.Ipv6Gateway.value != "" ){
     if (! isUnicastIpv6Address( document.ethwan.Ipv6Gateway.value) ){
      alert('<% multilang("1917" "LANG_INVALID_IPV6_GATEWAY_ADDRESS"); %>');
      document.ethwan.Ipv6Gateway.focus();
      return false;
     }
    }
    if(document.ethwan.Ipv6Dns1.value != "" ){
     if (! isUnicastIpv6Address( document.ethwan.Ipv6Dns1.value) ){
      alert('<% multilang("1918" "LANG_INVALID_PRIMARY_IPV6_DNS_ADDRESS"); %>');
      document.ethwan.Ipv6Dns1.focus();
      return false;
     }
    }
    if(document.ethwan.Ipv6Dns2.value != "" ){
     if (! isUnicastIpv6Address( document.ethwan.Ipv6Dns2.value) ){
      alert('<% multilang("1919" "LANG_INVALID_SECONDARY_IPV6_DNS_ADDRESS"); %>');
      document.ethwan.Ipv6Dns2.focus();
      return false;
     }
    }
   }
   else{
    document.ethwan.Ipv6Addr.value = "";
    document.ethwan.Ipv6PrefixLen.value = "";
    document.ethwan.Ipv6Gateway.value = "";
    document.ethwan.Ipv6Dns1.value = "";
    document.ethwan.Ipv6Dns2.value = "";
   }
            if (<% checkWrite("6rdShow"); %>) {
    if (document.ethwan.adslConnectionMode.value == 8) // 6rd
    {
     if(document.ethwan.SixrdBRv4IP.value == ""){
      alert('<% multilang("1920" "LANG_INVALID_6RD_BOARD_ROUTER_V4IP_ADDRESS"); %>');
      document.ethwan.SixrdBRv4IP.focus();
      return false;
     }
     if(document.ethwan.SixrdIPv4MaskLen.value == ""){
      alert('<% multilang("1921" "LANG_INVALID_6RD_IPV4_MASK_LENGTH"); %>');
      document.ethwan.SixrdIPv4MaskLen.focus();
      return false;
     }
     if(document.ethwan.SixrdPrefix.value == ""){
      alert('<% multilang("1922" "LANG_INVALID_6RD_PREFIX_ADDRESS"); %>');
      document.ethwan.SixrdPrefix.focus();
      return false;
     }
     if(document.ethwan.SixrdPrefixLen.value == ""){
      alert('<% multilang("1923" "LANG_INVALID_6RD_PREFIX_LENGTH"); %>');
      document.ethwan.SixrdPrefixLen.focus();
      return false;
     }
    }
    else{
     document.ethwan.SixrdBRv4IP.value = "";
     document.ethwan.SixrdIPv4MaskLen.value = "";
     document.ethwan.SixrdPrefix.value = "";
     document.ethwan.SixrdPrefixLen.value = "";
    }
   }
   if (<% checkWrite("DSLiteShow"); %>) {
    if (document.ethwan.adslConnectionMode.value == 6) // DS-Lite
    {
     if(document.ethwan.DSLiteLocalIP.value != ""){
      if (! isGlobalIpv6Address( document.ethwan.DSLiteLocalIP.value) ){
       alert('<% multilang("1924" "LANG_INVALID_DSLITELOCALIP_ADDRESS"); %>');
       document.ethwan.DSLiteLocalIP.focus();
       return false;
      }
     }
     if(document.ethwan.DSLiteRemoteIP.value != ""){
      if (! isGlobalIpv6Address( document.ethwan.DSLiteRemoteIP.value) ){
       alert('<% multilang("1925" "LANG_INVALID_DSLITEREMOTEIP_ADDRESS"); %>');
       document.ethwan.DSLiteRemoteIP.focus();
       return false;
      }
     }
     if(document.ethwan.DSLiteGateway.value != ""){
      if (! isGlobalIpv6Address( document.ethwan.DSLiteGateway.value) ){
       alert('<% multilang("1926" "LANG_INVALID_DSLITEGATEWAY_ADDRESS"); %>');
       document.ethwan.DSLiteGateway.focus();
       return false;
      }
     }
    }
    else{
     document.ethwan.DSLiteLocalIP.value = "";
     document.ethwan.DSLiteRemoteIP.value = "";
     document.ethwan.DSLiteGateway.value = "";
    }
   }
  }
 }
 if(document.ethwan.lkname.value != "new") tmplst = curlink.name;
 document.ethwan.lst.value = tmplst;
 //avoid sending username/password without encode
 disableUsernamePassword();
 return true;
}
function deleteCheck()
{
 var tmplst = "";
 if ( document.ethwan.lkname.value == "new" )
 {
  alert('<% multilang("1927" "LANG_NO_LINK_SELECTED"); %>');
  return false;
 }
 tmplst = curlink.name;
 document.ethwan.lst.value = tmplst;
 disableUsernamePassword();
 return true;
}
function setPPPConnected()
{
 pppConnectStatus = 1;
}
function dnsModeClicked()
{
 if ( document.ethwan.dnsMode[0].checked )
 {
  disableTextField(document.ethwan.dns1);
  disableTextField(document.ethwan.dns2);
 }
 if ( document.ethwan.dnsMode[1].checked )
 {
  enableTextField(document.ethwan.dns1);
  enableTextField(document.ethwan.dns2);
 }
}
function disableFixedIpInput()
{
 disableTextField(document.ethwan.ip);
 disableTextField(document.ethwan.remoteIp);
 disableTextField(document.ethwan.netmask);
 document.ethwan.dnsMode[0].disabled = false;
 document.ethwan.dnsMode[1].disabled = false;
 dnsModeClicked();
}
function enableFixedIpInput()
{
 enableTextField(document.ethwan.ip);
 enableTextField(document.ethwan.remoteIp);
 if (document.ethwan.adslConnectionMode.value == 4)
  disableTextField(document.ethwan.netmask);
 else
  enableTextField(document.ethwan.netmask);
 document.ethwan.dnsMode[0].disabled = true;
 document.ethwan.dnsMode[1].disabled = true;
 dnsModeClicked();
}
function ipTypeSelection(init)
{
 if ( document.ethwan.ipMode[0].checked ) {
  enableFixedIpInput();
  showDhcpOptSettings(0);
 } else {
  disableFixedIpInput();
  showDhcpOptSettings(1);
 }
 if (init == 0)
 {
  if ( document.ethwan.ipMode[0].checked )
   document.ethwan.dnsMode[1].checked = true;
  else
   document.ethwan.dnsMode[0].checked = true;
  dnsModeClicked();
 }
}
function enable_pppObj()
{
 enableTextField(document.ethwan.pppUserName);
 enableTextField(document.ethwan.pppPassword);
 enableTextField(document.ethwan.pppConnectType);
 document.ethwan.gwStr[0].disabled = false;
 document.ethwan.gwStr[1].disabled = false;
 enableTextField(document.ethwan.dstGtwy);
 document.ethwan.wanIf.disabled = false;
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
 disableTextField(document.ethwan.pppUserName);
 disableTextField(document.ethwan.pppPassword);
 disableTextField(document.ethwan.pppIdleTime);
 disableTextField(document.ethwan.pppConnectType);
 document.ethwan.gwStr[0].disabled = true;
 document.ethwan.gwStr[1].disabled = true;
 disableTextField(document.ethwan.dstGtwy);
 document.ethwan.wanIf.disabled = true;
}
function pppSettingsDisable()
{
 document.getElementById('tbl_ppp').style.display='none';
 disable_pppObj();
}
function enable_ipObj()
{
 document.ethwan.ipMode[0].disabled = false;
 document.ethwan.ipMode[1].disabled = false;
 document.ethwan.gwStr[0].disabled = false;
 document.ethwan.gwStr[1].disabled = false;
 enableTextField(document.ethwan.dstGtwy);
 document.ethwan.wanIf.disabled = false;
 ipTypeSelection(1);
 autoDGWclicked();
}
function ipSettingsEnable()
{
 //if (ipver == 2)
 //	return;
 document.getElementById('tbl_ip').style.display='block';
 enable_ipObj();
}
function disable_ipObj()
{
 document.ethwan.ipMode[0].disabled = true;
 document.ethwan.ipMode[1].disabled = true;
 document.ethwan.gwStr[0].disabled = true;
 document.ethwan.gwStr[1].disabled = true;
 disableTextField(document.ethwan.dstGtwy);
 document.ethwan.wanIf.disabled = true;
 disableFixedIpInput();
}
function ipSettingsDisable()
{
 document.getElementById('tbl_ip').style.display='none';
 showDhcpOptSettings(0);
 disable_ipObj();
}
function showDuidType2(show)
{
 if(show == 1)
 {
  document.getElementById('duid_t2_ent').style.display = '';
  document.getElementById('duid_t2_id').style.display = '';
 }
 else
 {
  document.getElementById('duid_t2_ent').style.display = 'none';
  document.getElementById('duid_t2_id').style.display = 'none';
 }
}
function showDhcpOptSettings(show)
{
 var dhcp_opt = document.getElementById('tbl_dhcp_opt');
 if(dhcp_opt == null)
  return ;
 if(show == 1)
 {
  document.getElementById('tbl_dhcp_opt').style.display='block';
  if(document.ethwan.duid_type[1].checked == true)
   showDuidType2(1);
  else
   showDuidType2(0);
 }
 else
  document.getElementById('tbl_dhcp_opt').style.display='none';
}
function ipModeSelection()
{
 if (document.ethwan.ipUnnum.checked) {
  disable_pppObj();
  disable_ipObj();
  document.ethwan.gwStr[0].disabled = false;
  document.ethwan.gwStr[1].disabled = false;
  enableTextField(document.ethwan.dstGtwy);
  document.ethwan.wanIf.disabled = false;
 }
 else
  enable_ipObj();
}
function updateBrMode(isLinkChanged)
{
 var brmode_ops = document.getElementById('brmode');
 if(!brmode_ops)
  return ;
 // reset to transparent bridge
 if(!isLinkChanged)
 {
  document.ethwan.br.checked = false;
  brmode_ops.value = 0;
  brmode_ops.disabled = true;
 }
 if(document.ethwan.adslConnectionMode.value == 0)
 {
  document.getElementById('br_row').style.display = "none";
  brmode_ops.disabled = false;
 }
 else
 {
  document.getElementById('br_row').style.display = "";
 }
}
function brClicked()
{
 var brmode_ops = document.getElementById('brmode');
 if(!brmode_ops)
  return ;
 if(document.ethwan.br.checked)
  brmode_ops.disabled = false;
 else
  brmode_ops.disabled = true;
}
function adslConnectionModeSelection(isLinkChanged)
{
 document.ethwan.naptEnabled.disabled = false;
 document.ethwan.igmpEnabled.disabled = false;
 document.ethwan.ipUnnum.disabled = true;
 document.ethwan.droute[0].disabled = false;
 document.ethwan.droute[1].disabled = false;
 document.getElementById('tbl_ppp').style.display='none';
 document.getElementById('tbl_ip').style.display='none';
 if(document.getElementById('tbl_dhcp_opt') != null)
  document.getElementById('tbl_dhcp_opt').style.display='none';
 document.getElementById('6rdDiv').style.display='none';
 if (<% checkWrite("IPv6Show"); %>) {
  ipv6SettingsEnable();
  document.getElementById('tbprotocol').style.display="block";
  document.ethwan.IpProtocolType.disabled = false;
  if (<% checkWrite("DSLiteShow"); %>) {
   document.getElementById('DSLiteDiv').style.display="none";
  }
 }else
  document.getElementById('tbprotocol').style.display="none";
 //e = document.getElementById("qosEnabled");
 //if (e) e.disabled = false;
 //alert(document.ethwan.adslConnectionMode.value);
 switch(document.ethwan.adslConnectionMode.value){
  case '0':// bridge mode
   document.getElementById('tbprotocol').style.display="none";
  //case '3':// DS-Lite
  case '6':// DS-Lite
   document.ethwan.naptEnabled.disabled = true;
   document.ethwan.igmpEnabled.disabled = true;
   document.ethwan.droute[0].disabled = true;
   document.ethwan.droute[1].disabled = true;
   pppSettingsDisable();
   ipSettingsDisable();
   if (<% checkWrite("IPv6Show"); %>) {
    ipv6SettingsDisable();
    document.getElementById('tbprotocol').style.display="none";
   }
   // For DS-Lite only
   if (<% checkWrite("IPv6Show"); %> && <% checkWrite("DSLiteShow"); %>) {
    if ( document.ethwan.adslConnectionMode.value == 6 )
    {
     document.getElementById('DSLiteDiv').style.display='block';
     document.ethwan.droute[0].disabled = false;
     document.ethwan.droute[1].disabled = false;
     //document.ethwan.qosEnabled.disabled = true;
     //document.getElementById('tbprotocol').style.display="block";
     // Set some values for DS-Lite mer mode only
     document.ethwan.IpProtocolType.value = 2; // IPV6 only
     //document.ethwan.IpProtocolType.disabled = true;
     document.ethwan.slacc.checked = false; // not use slaac
     document.ethwan.staticIpv6.checked = false; // not use static IP
     document.ethwan.itfenable.checked = false; // not enable DHCPv6 client
    }
   }
   //if (e) e.disabled = false;
   break;
  case '8': //6rd
   if (<% checkWrite("IPv6Show"); %> && <% checkWrite("6rdShow"); %>)
   {
    document.getElementById('6rdDiv').style.display='block';
    document.ethwan.droute[0].checked = false;
    document.ethwan.droute[1].checked = true;
    // Set some values for DS-Lite mer mode only
    document.ethwan.IpProtocolType.value = 3; // IPV4/IPV6
    //document.ethwan.IpProtocolType.disabled = true;
    document.ethwan.slacc.checked = false; // not use slaac
    document.ethwan.staticIpv6.checked = false; // not use static IP
    document.ethwan.itfenable.checked = false; // not enable DHCPv6 client
    ipSettingsEnable();
    enableFixedIpInput();
    ipv6SettingsDisable();
    document.getElementById('tbprotocol').style.display="none";
   }
            break;
  case '1'://1483mer
   pppSettingsDisable();
   if (<% checkWrite("IPv6Show"); %>) {
    if(document.ethwan.IpProtocolType.value != 2) // It is not IPv6 only
     ipSettingsEnable();
   }
   else
    ipSettingsEnable();
   if(!isLinkChanged)
    document.ethwan.naptEnabled.checked = true;
   break;
  case '2'://pppoe
   document.getElementById('tbl_ppp').style.display='block';
   ipSettingsDisable();
   pppSettingsEnable();
   if(!isLinkChanged)
    document.ethwan.naptEnabled.checked = true;
   break;
  default:
   pppSettingsDisable();
   ipSettingsEnable();
 }
 updateBrMode(isLinkChanged);
}
function naptClicked()
{
 if (document.ethwan.adslConnectionMode.value == 3) {
  // Route1483
  if (document.ethwan.naptEnabled.checked == true) {
   document.ethwan.ipUnnum.checked = false;
   document.ethwan.ipUnnum.disabled = true;
  }
  else
   document.ethwan.ipUnnum.disabled = false;
  ipModeSelection();
 }
}
function vlanClicked()
{
 if (document.ethwan.vlan.checked)
 {
  document.ethwan.vid.disabled = false;
  document.ethwan.vprio.disabled = false;
 }
 else {
  document.ethwan.vid.disabled = true;
  document.ethwan.vprio.disabled = true;
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
 if (document.ethwan.droute[0].checked == true) {
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
function dhcp6cEnable()
{
 if(document.ethwan.itfenable.checked)
  document.getElementById('dhcp6c_block').style.display="block";
 else
  document.getElementById('dhcp6c_block').style.display="none";
}
function ipv6StaticUpdate()
{
 if(document.ethwan.staticIpv6.checked)
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
 if(document.ethwan.IpProtocolType.value != 1){
  document.getElementById('tbipv6wan').style.display="block";
  document.getElementById('dhcp6c_ctrlblock').style.display="block";
  ipv6WanUpdate();
   }
}
function protocolChange()
{
 ipver = document.ethwan.IpProtocolType.value;
 if(document.ethwan.IpProtocolType.value == 1){
  if( document.ethwan.adslConnectionMode.value ==1 ||
   document.ethwan.adslConnectionMode.value ==4 ||
   document.ethwan.adslConnectionMode.value ==5)
   ipSettingsEnable();
   ipv6SettingsDisable();
 }else{
  if(document.ethwan.IpProtocolType.value == 2){
   ipSettingsDisable();
  }else{
   if( document.ethwan.adslConnectionMode.value ==1 ||
    document.ethwan.adslConnectionMode.value ==4 ||
    document.ethwan.adslConnectionMode.value ==5)
    ipSettingsEnable();
  }
  ipv6SettingsEnable();
 }
}
/* Mason Yu:20110307 END */
function on_linkchange(itlk)
{
 var pmchkpt = document.getElementById("tbl_pmap");
 with ( document.forms[0] )
 {
  if(itlk == null)
  {
   //select
   adslConnectionMode.value = pppConnectType.value = 0;
   if(typeof brmode != "undefined") // "undefined" refer to an object is not defined and defined but without a value. Be careful!
    brmode.value = 0;
   IpProtocolType.value = 1;
   // ctype
   ctype.value = 4;
   //radio
   ipMode[0].checked = droute[0].checked = dnsMode[1].checked = true;
   chEnable[0].checked = true;
   if(typeof duid_type !== 'undefined')
    duid_type[1].checked = true;
   //checkbox
   naptEnabled.checked = vlan.checked = qosEnabled.checked = igmpEnabled.checked = false;
   if(typeof enable_opt_60 !== 'undefined')
    enable_opt_60.checked = enable_opt_61.checked = enable_opt_125.checked = false;
   //input number
   vprio.value = vid.value = "0";
   vid.value = "";
   //input ip
   ip.value = remoteIp.value = "0.0.0.0";
   netmask.value = "255.255.255.0";
   //input text
   pppUserName.value = pppPassword.value = dns1.value = dns2.value = "";
   //checkbox
   slacc.checked = staticIpv6.checked = itfenable.checked = false;
   if(typeof document.ethwan.br != "undefined") // "undefined" refer to an object is not defined and defined but without a value. Be careful!
    document.ethwan.br.checked = false;
   //port mapping
   if (pmchkpt)
    for (var i = 0; i < 14; i++) {
     /* chkpt do not always have 14 elements */
     if (!chkpt[i])
      break;
     chkpt[i].checked = false;
    }
  }
  else
  {
   //sji_onchanged(document, itlk);
   //select
   adslConnectionMode.value = itlk.cmode;
   //ctype
   ctype.value = itlk.applicationtype;
   //brmode
   if(document.ethwan.br)
   {
    document.ethwan.br.checked = false;
    if(itlk.brmode == 2)
    {
     // Disable Bridge
     brmode.value = 0;
     brmode.disabled = true;
    }
    else
    {
     // Enable Bridge
     if(itlk.cmode != 0)
      document.ethwan.br.checked = true;
     brmode.value = itlk.brmode;
     brmode.disabled = false;
    }
   }
   //checkbox
   if (itlk.napt == 1)
    naptEnabled.checked = true;
   else
    naptEnabled.checked = false;
   if (itlk.enableIGMP == 1)
    igmpEnabled.checked = true;
   else
    igmpEnabled.checked = false;
   if (itlk.enableIpQos == 1)
    qosEnabled.checked = true;
   else
    qosEnabled.checked = false;
   if (itlk.vlan == 1)
   {
    vlan.checked = true;
    vid.value = itlk.vid;
    vprio.value = itlk.vprio;
   }
   else
   {
    vlan.checked = false;
    <% checkWrite("show_vlan_id"); %>
   }
   //radio
   if (itlk.dgw == 1)
    droute[1].checked = true;
   else
    droute[0].checked = true;
   if (itlk.enable == 1)
    chEnable[0].checked = true;
   else
    chEnable[1].checked = true;
   //radio
   if(itlk.cmode != 0)//not bridge
   {
    IpProtocolType.value = itlk.IpProtocol;
    if (IpProtocolType.value != 1)
    {
     if (itlk.AddrMode & 1)
      slacc.checked = true;
     else
      slacc.checked = false;
     if (itlk.AddrMode & 2)
     {
      staticIpv6.checked = true;
      Ipv6Addr.value = itlk.Ipv6Addr;
      Ipv6PrefixLen.value = itlk.Ipv6AddrPrefixLen;
      Ipv6Gateway.value = itlk.RemoteIpv6Addr;
      Ipv6Dns1.value = itlk.Ipv6Dns1;
      Ipv6Dns2.value = itlk.Ipv6Dns2;
     }
     else
     {
      staticIpv6.checked = false;
      Ipv6Addr.value = "";
      Ipv6PrefixLen.value = "";
      Ipv6Gateway.value = "";
      Ipv6Dns1.value = "";
      Ipv6Dns2.value = "";
     }
     if (itlk.Ipv6Dhcp)
     {
      itfenable.checked = true;
      if (itlk.Ipv6DhcpRequest & 1)
       iana.checked = true;
      else
       iana.checked = false;
      if (itlk.Ipv6DhcpRequest & 2)
       iapd.checked = true;
      else
       iapd.checked = false;
     }
     else
      itfenable.checked = false;
     // DS-Lite
     if (itlk.AddrMode & 4)
     {
      DSLiteLocalIP.value = itlk.Ipv6Addr;
      DSLiteRemoteIP.value = itlk.RemoteIpv6EndPointAddr;
      DSLiteGateway.value = itlk.RemoteIpv6Addr;
      adslConnectionMode.value = 6;
     }
     // 6rd
     if (itlk.AddrMode & 8)
     {
      adslConnectionMode.value = 8;
      SixrdBRv4IP.value = itlk.SixrdBRv4IP;
      SixrdIPv4MaskLen.value = itlk.SixrdIPv4MaskLen;
      SixrdPrefix.value = itlk.SixrdPrefix;
      SixrdPrefixLen.value = itlk.SixrdPrefixLen;
      ip.value = itlk.ipAddr;
      remoteIp.value = itlk.remoteIpAddr;
      netmask.value = itlk.netMask;
     }
    }
    if (itlk.cmode == 1)//IPoE
    {
     if (itlk.ipDhcp == 1)
     {
      ipMode[1].checked = true;
      ip.value = "";
      remoteIp.value = "";
      netmask.value = "";
     }
     else
     {
      ipMode[0].checked = true;
      ip.value = itlk.ipAddr;
      remoteIp.value = itlk.remoteIpAddr;
      netmask.value = itlk.netMask;
     }
     if (itlk.dnsMode == 1)
       dnsMode[0].checked = true;
      else
       dnsMode[1].checked = true;
     dns1.value = itlk.v4dns1;
     dns2.value = itlk.v4dns2;
    }
    else if (itlk.cmode == 2)
    {
     pppUserName.value = decode64(itlk.pppUsername);
     pppPassword.value = itlk.pppPassword;
     pppConnectType.value = itlk.pppCtype;
     pppIdleTime.value = itlk.pppIdleTime;
     auth.value = itlk.pppAuth;
     acName.value = itlk.pppACName;
     serviceName.value = itlk.pppServiceName;
    }
    protocolChange();
   }
   //DHCP options
   if(typeof enable_opt_60 !== 'undefined')
   {
    //assume all other elements are existed if enable_opt_60 is existed
    if(itlk.enable_opt_60)
     enable_opt_60.checked = true;
    opt60_val.value = itlk.opt60_val;
    if(itlk.enable_opt_61)
     enable_opt_61.checked = true;
    iaid.value = itlk.iaid;
    if(itlk.duid_type == 0)
     duid_type[0].checked = true;
    else
     duid_type[itlk.duid_type - 1].checked = true;
    duid_ent_num.value = itlk.duid_ent_num;
    duid_id.value = itlk.duid_id;
    if(itlk.enable_opt_125)
     enable_opt_125.checked = true;
    manufacturer.value = itlk.manufacturer;
    product_class.value = itlk.product_class;
    model_name.value = itlk.model_name;
    serial_num.value = itlk.serial_num;
   }
   //port mapping
   if (pmchkpt)
    for (var i = 0; i < 14; i++) {
     /* chkpt do not always have 14 elements */
     if (!chkpt[i])
      break;
     chkpt[i].checked = (itlk.itfGroup & (0x1 << i));
    }
  }
 }
 ipver = document.ethwan.IpProtocolType.value;
 vlanClicked();
 autoDGWclicked();
 adslConnectionModeSelection(true);
}
function on_ctrlupdate()
{
 with ( document.forms[0] )
 {
  if(lkname.value == "new")
  {
   curlink = null;
   on_linkchange(curlink);
  }
  else
  {
   curlink = links[lkname.value];
   on_linkchange(curlink);
  }
 }
}
function on_init()
{
 sji_docinit(document, cgi);
 with ( document.forms[0] )
 {
  for(var k in links)
  {
   var lk = links[k];
   lkname.options.add(new Option(lk.name, k));
  }
  lkname.options.add(new Option("new link", "new"));
  if(links.length > 0) lkname.selectedIndex = 0;
  on_ctrlupdate();
 }
}
/*
function SubmitWANMode() // Magician: ADSL/Ethernet WAN mode switch
{
	var wmmap = 0;
	var config_num = 4;

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
}*/
</script>
</head>
<BODY onLoad="on_init();">
<blockquote>
<h2><font color="#0000FF"><% getWanIfDisplay(); %> <% multilang("10" "LANG_WAN"); %></font></h2>
<form action=/boaform/admin/formWanEth method=POST name="ethwan">
<table border="0" cellspacing="4" width="800">
  <tr><td><font size=2>
    <% multilang("213" "LANG_PAGE_DESC_CONFIGURE_PARAMETERS"); %><% getWanIfDisplay(); %><% multilang("10" "LANG_WAN"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<!--<table border="0" cellspacing="4" width="800" <% WANConditions(); %>>
 <tr>
  <td>
   <b><% multilang("214" "LANG_WAN_MODE"); %>:</b>
   <span <% checkWrite("wan_mode_atm"); %>><input type="checkbox" value=1 name="wmchkbox">ATM</span>
   <span <% checkWrite("wan_mode_ethernet"); %>><input type="checkbox" value=2 name="wmchkbox">Ethernet</span>
   <span <% checkWrite("wan_mode_ptm"); %>><input type="checkbox" value=4 name="wmchkbox">PTM</span>
   <span <% checkWrite("wan_mode_bonding"); %>><input type="checkbox" value=8 name="wmchkbox">Bonding</span>&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="hidden" name="wan_mode" value=0>
   <input type="submit" value="Submit" name="submitwan" onClick="return SubmitWANMode()">
  </td>
 </tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>-->
<table border=0 width="800" cellspacing=4 cellpadding=0>
 <tr>
  <td>
   <select name="lkname" onChange="on_ctrlupdate()" size="1">
   <!--<option value="new" selected>new link</option></select>-->
  </td>
 </tr>
 <tr>
  <td>
   <font size=2><b><% multilang("216" "LANG_ENABLE_VLAN"); %>: </b><input type="checkbox" name="vlan" size="2" maxlength="2" value="ON" onClick=vlanClicked()>
  </td>
 </tr>
 <tr>
  <td>
   <font size=2><b><% multilang("217" "LANG_VLAN"); %> ID: </b><input type="text" name="vid" size="10" maxlength="15">
  </td>
  <td><font size=2><b><% multilang("243" "LANG_802_1P_MARK"); %> </b>
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
  </td>
 </tr>
 <tr>
 </tr>
 <tr>
  <td>
  <% ShowChannelMode("ethcmode"); %>
  </td>
 </tr>
 <% ShowBridgeMode(); %>
 <tr>
  <td>
  <% ShowNAPTSetting(); %>
  </td>
  <td <% checkWrite("IPQoS"); %>><font size=2>
   <b><% multilang("256" "LANG_ENABLE_QOS"); %>: </b>
   <input type="checkbox" name="qosEnabled" size="2" maxlength="2" value="ON" >
  </font></td>
 </tr>
 <tr>
  <td><font size=2><b><% multilang("222" "LANG_ADMIN_STATUS"); %>:</b>
   <input type=radio value=1 name="chEnable"><% multilang("207" "LANG_ENABLE"); %>
   <input type=radio value=0 name="chEnable" checked><% multilang("206" "LANG_DISABLE"); %></font>
  </td>
 </tr>
 <% ShowConnectionType() %>
</table>
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
<% ShowIpProtocolType(); %>
<% ShowPPPIPSettings(); %>
<% ShowDefaultGateway("p2p"); %>
<% Show6rdSetting(); %>
<% ShowIPV6Settings(); %>
<% ShowPortMapping(); %>
<% ShowDSLiteSetting(); %>
<BR>
<input type="hidden" value="/admin/multi_wan_generic.asp" name="submit-url">
<input type="hidden" id="lst" name="lst" value="">
<input type="hidden" name="encodePppUserName" value="">
<input type="hidden" name="encodePppPassword" value="">
<input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply" onClick="return applyCheck()">&nbsp; &nbsp; &nbsp; &nbsp;
<input type="submit" value="<% multilang("239" "LANG_DELETE"); %>" name="delete" onClick="return deleteCheck()">
<input type="hidden" name="itfGroup" value=0>
<BR>
<BR>
<script>
 <% DisplayDGW(); %>
/*
	var wanmode = <% getInfo("wan_mode"); %>;

	if((wanmode & 1) == 1)
		document.ethwan.wmchkbox[0].checked = true;

	if((wanmode & 2) == 2)
		document.ethwan.wmchkbox[1].checked = true;

	if((wanmode & 4) == 4)
		document.ethwan.wmchkbox[2].checked = true;

	if((wanmode & 8) == 8)
		document.ethwan.wmchkbox[3].checked = true;
*/
 var isConfigRTKRG = <% checkWrite("config_rtk_rg"); %>;
 if(isConfigRTKRG == "yes")
 {
  var mbt_dec = <% getInfo("mac_based_tag_decision"); %>-1+1;
  if(mbt_dec == 1)
   document.getElementById("div_pmap").style.display = "inline";
  else
   document.getElementById("div_pmap").style.display = "none";
 }
</script>
</form>
</blockquote>
</body>
</html>

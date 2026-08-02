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
<title><% multilang("158" "LANG_WLAN_SECURITY_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<style>
.on {display:on}
.off {display:none}
.bggrey {
 BACKGROUND: #FFFFFF
}
</style>
<script>
var defPskLen, defPskFormat;
var wps20, ssid_num;
var wps20_use_version=<% getInfo("wpsUseVersion"); %>;
var oldMethod;
var wlanMode;
var _wlan_mode=new Array();
var _encrypt=new Array();
var _enable1X=new Array();
var _wpaAuth=new Array();
var _wpaPSKFormat=new Array();
var _wpaPSK=new Array();
var _wpaGroupRekeyTime=new Array();
var _rsPort=new Array();
var _rsIpAddr=new Array();
var _rsPassword=new Array();
var _uCipher=new Array();
var _wpa2uCipher=new Array();
var _wepAuth=new Array();
var _wepLen=new Array();
var _wepKeyFormat=new Array();
var _wlan_isNmode=new Array();
var new_wifi_sec=<% checkWrite("new_wifi_security"); %>;
var support_11w=<% checkWrite("11w_support"); %>;
var _dotIEEE80211W=new Array();
var _sha256=new Array();
var is_wlan_qtn = <% checkWrite("is_wlan_qtn"); %>;
function show_8021x_settings()
{
 var security = get_by_id("security_method");
 var enable_1x = get_by_id("use1x");
 var form1 = document.formEncrypt ;
 var dF=document.forms[0];
 if (enable_1x.checked) {
  if (security.value == 1) /* WIFI_SEC_WEP */
   get_by_id("show_1x_wep").style.display = "";
  else
   get_by_id("show_1x_wep").style.display = "none";
  get_by_id("setting_wep").style.display = "none";
  get_by_id("show_8021x_eap").style.display = "";
  dF.auth_type[2].checked = true;
  dF.auth_type[0].disabled = true;
  dF.auth_type[1].disabled = true;
  dF.auth_type[2].disabled = true;
 }
 else {
  if (security.value == 1) /* WIFI_SEC_WEP */
   get_by_id("setting_wep").style.display = "";
  else
   get_by_id("setting_wep").style.display = "none";
  get_by_id("show_1x_wep").style.display = "none";
  get_by_id("show_8021x_eap").style.display = "none";
  if (security.value == 2 || security.value == 4 || security.value == 6){ /* WIFI_SEC_WPA/WIFI_SEC_WPA2/WIFI_SEC_WPA2_MIXED */
   if(dF.wpaAuth[1].checked==true)
    get_by_id("show_8021x_eap").style.display = "none";
   else
    get_by_id("show_8021x_eap").style.display = "";
  }
  //get_by_id("show_8021x_eap").style.display = "none";
  //dF.auth_type[2].checked = true;
  dF.auth_type[0].disabled = false;
  dF.auth_type[1].disabled = false;
  dF.auth_type[2].disabled = false;
 }
}
function show_wpa_settings()
{
 var dF=document.forms[0];
 var allow_tkip=0;
 get_by_id("show_wpa_gk_rekey").style.display = "";
 get_by_id("show_wpa_psk1").style.display = "none";
 get_by_id("show_wpa_psk2").style.display = "none";
 get_by_id("show_8021x_eap").style.display = "none";
 if (dF.wpaAuth[1].checked)
 {
  get_by_id("show_wpa_psk1").style.display = "";
  get_by_id("show_wpa_psk2").style.display = "";
 }
 else{
  if (wlanMode != 1)
  get_by_id("show_8021x_eap").style.display = "";
 }
}
function show_wapi_settings()
{
        var dF=document.forms[0];
        get_by_id("show_wapi_psk1").style.display = "none";
        get_by_id("show_wapi_psk2").style.display = "none";
        get_by_id("show_8021x_wapi").style.display = "none";
        if (dF.wapiAuth[1].checked){
                get_by_id("show_wapi_psk1").style.display = "";
                get_by_id("show_wapi_psk2").style.display = "";
        }
        else{
                if (wlanMode != 1)
                {
                 get_by_id("show_8021x_wapi").style.display = "";
   if(''=='true')
   {
    get_by_id("show_8021x_wapi_local_as").style.display = "";
   }
   else
   {
    get_by_id("show_8021x_wapi_local_as").style.display = "none";
    dF.uselocalAS.checked=false;
   }
                }
  if (dF.wapiASIP.value == "192.168.1.1")
  {
   dF.uselocalAS.checked=true;
  }
        }
}
function show_wapi_ASip()
{
 var dF=document.forms[0];
 if (dF.uselocalAS.checked)
 {
  dF.wapiASIP.value = "192.168.1.1";
        }
 else
 {
  dF.wapiASIP.value = "";
 }
}
function show_sha256_settings()
{
 if(document.formEncrypt.dotIEEE80211W[1].checked == true)
  get_by_id("show_sha256").style.display = "";
 else
  get_by_id("show_sha256").style.display = "none";
}
function show_authentication()
{
 var security = get_by_id("security_method");
 var enable_1x = get_by_id("use1x");
 var form1 = document.formEncrypt ;
 if (wlanMode==1 && security.value == 6) { /* client and WIFI_SEC_WPA2_MIXED */
  alert("<% multilang("2399" "LANG_NOT_ALLOWED_FOR_THE_CLIENT_MODE"); %>");
  security.value = oldMethod;
  return false;
 }
 oldMethod = security.value;
 get_by_id("show_wep_auth").style.display = "none";
 get_by_id("setting_wep").style.display = "none";
 get_by_id("setting_wpa").style.display = "none";
 get_by_id("setting_wapi").style.display = "none";
 get_by_id("show_wpa_cipher").style.display = "none";
 get_by_id("show_wpa2_cipher").style.display = "none";
 get_by_id("show_wpa_gk_rekey").style.display = "none";
 get_by_id("enable_8021x").style.display = "none";
 get_by_id("show_8021x_eap").style.display = "none";
 get_by_id("show_8021x_wapi").style.display = "none";
 get_by_id("show_1x_wep").style.display = "none";
        get_by_id("show_wapi_psk1").style.display = "none";
        get_by_id("show_wapi_psk2").style.display = "none";
        get_by_id("show_8021x_wapi").style.display = "none";
 if(support_11w){
  get_by_id("show_dotIEEE80211W").style.display = "none";
  get_by_id("show_sha256").style.display = "none";
 }
 if (security.value == 1){ /* WIFI_SEC_WEP */
  get_by_id("show_wep_auth").style.display = "";
  if (wlanMode == 1)
   get_by_id("setting_wep").style.display = "";
  else {
   get_by_id("enable_8021x").style.display = "";
   if(enable_1x.checked){
    get_by_id("show_8021x_eap").style.display = "";
    get_by_id("show_1x_wep").style.display = "";
    get_by_id("setting_wep").style.display = "none";
    form1.auth_type[2].checked = true;
    form1.auth_type[0].disabled = true;
    form1.auth_type[1].disabled = true;
    form1.auth_type[2].disabled = true;
   }else{
    get_by_id("setting_wep").style.display = "";
   }
  }
 }else if (security.value == 2 || security.value == 4 || security.value == 6){ /* WIFI_SEC_WPA/WIFI_SEC_WPA2/WIFI_SEC_WPA2_MIXED */
  form1.ciphersuite_t.disabled = false;
  form1.wpa2ciphersuite_t.disabled = false;
  get_by_id("setting_wpa").style.display = "";
  if (security.value == 2) { /* WIFI_SEC_WPA */
   get_by_id("show_wpa_cipher").style.display = "";
   if ( form1.isNmode.value == 1 ) {
    //alert("Select wpa and is Nmode");
    form1.ciphersuite_t.disabled = true;
    form1.ciphersuite_t.checked = false;
    form1.wpa2ciphersuite_t.disabled = true;
    form1.wpa2ciphersuite_t.checked = false;
   }
  }
  if(security.value == 4) { /* WIFI_SEC_WPA2 */
   get_by_id("show_wpa2_cipher").style.display = "";
   if(support_11w){
    get_by_id("show_dotIEEE80211W").style.display = "";
    if(form1.dotIEEE80211W[1].checked == true)
     get_by_id("show_sha256").style.display = "";
   }
   if(new_wifi_sec){
     form1.wpa2ciphersuite_t.disabled = true;
     form1.wpa2ciphersuite_t.checked = false;
     form1.wpa2ciphersuite_a.disabled = true;
     form1.wpa2ciphersuite_a.checked = true;
   }
   else{
    if ( form1.isNmode.value == 1 ) {
     //alert("Select wpa2 and is Nmode");
     form1.ciphersuite_t.disabled = true;
     form1.ciphersuite_t.checked = false;
     form1.wpa2ciphersuite_t.disabled = true;
     form1.wpa2ciphersuite_t.checked = false;
    }
   }
  }
  if(security.value == 6){ /* WIFI_SEC_WPA2_MIXED */
   get_by_id("show_wpa_cipher").style.display = "";
   get_by_id("show_wpa2_cipher").style.display = "";
   if(new_wifi_sec){
    form1.ciphersuite_t.disabled = true;
    form1.ciphersuite_t.checked = true;
    form1.ciphersuite_a.disabled = true;
    form1.ciphersuite_a.checked = true;
    form1.wpa2ciphersuite_t.disabled = true;
    form1.wpa2ciphersuite_t.checked = true;
    form1.wpa2ciphersuite_a.disabled = true;
    form1.wpa2ciphersuite_a.checked = true;
   }
   else{
    form1.ciphersuite_t.disabled = false;
    form1.wpa2ciphersuite_t.disabled = false;
   }
  }
  show_wpa_settings();
 }else if(security.value == 8 ) /* WIFI_SEC_WAPI */
 {
  get_by_id("setting_wapi").style.display = "";
  show_wapi_settings();
 }
 if (security.value == 0) { /* WIFI_SEC_NONE */
  if (wlanMode != 1 && !is_wlan_qtn) {
   get_by_id("enable_8021x").style.display = "";
   if(enable_1x.checked){
    get_by_id("show_8021x_eap").style.display = "";
   }
   else {
    get_by_id("show_8021x_eap").style.display = "none";
   }
  }
 }
}
function setDefaultKeyValue(form, wlan_id)
{
  if (form.elements["length"+wlan_id].selectedIndex == 0) {
 if ( form.elements["format"+wlan_id].selectedIndex == 0) {
  form.elements["key"+wlan_id].maxLength = 5;
  form.elements["key"+wlan_id].value = "*****";
/*		
		form.elements["key1"+wlan_id].maxLength = 5;
		form.elements["key2"+wlan_id].maxLength = 5;
		form.elements["key3"+wlan_id].maxLength = 5;
		form.elements["key4"+wlan_id].maxLength = 5;
		form.elements["key1"+wlan_id].value = "*****";
		form.elements["key2"+wlan_id].value = "*****";
		form.elements["key3"+wlan_id].value = "*****";
		form.elements["key4"+wlan_id].value = "*****";
*/
 }
 else {
  form.elements["key"+wlan_id].maxLength = 10;
  form.elements["key"+wlan_id].value = "**********";
/*		
		form.elements["key1"+wlan_id].maxLength = 10;
		form.elements["key2"+wlan_id].maxLength = 10;
		form.elements["key3"+wlan_id].maxLength = 10;
		form.elements["key4"+wlan_id].maxLength = 10;
		form.elements["key1"+wlan_id].value = "**********";
		form.elements["key2"+wlan_id].value = "**********";
		form.elements["key3"+wlan_id].value = "**********";
		form.elements["key4"+wlan_id].value = "**********";
*/
 }
  }
  else {
   if ( form.elements["format"+wlan_id].selectedIndex == 0) {
  form.elements["key"+wlan_id].maxLength = 13;
  form.elements["key"+wlan_id].value = "*************";
/*		
		form.elements["key1"+wlan_id].maxLength = 13;
		form.elements["key2"+wlan_id].maxLength = 13;
		form.elements["key3"+wlan_id].maxLength = 13;
		form.elements["key4"+wlan_id].maxLength = 13;
		form.elements["key1"+wlan_id].value = "*************";
		form.elements["key2"+wlan_id].value = "*************";
		form.elements["key3"+wlan_id].value = "*************";
		form.elements["key4"+wlan_id].value = "*************";
*/
 }
 else {
  form.elements["key"+wlan_id].maxLength = 26;
  form.elements["key"+wlan_id].value ="**************************";
/*		
		form.elements["key1"+wlan_id].maxLength = 26;
		form.elements["key2"+wlan_id].maxLength = 26;
		form.elements["key3"+wlan_id].maxLength = 26;
		form.elements["key4"+wlan_id].maxLength = 26;
		form.elements["key1"+wlan_id].value ="**************************";
		form.elements["key2"+wlan_id].value ="**************************";
		form.elements["key3"+wlan_id].value ="**************************";
		form.elements["key4"+wlan_id].value ="**************************";
*/
 }
  }
}
function updateWepFormat(form, wlan_id)
{
 if (form.elements["length" + wlan_id].selectedIndex == 0) {
  form.elements["format" + wlan_id].options[0].text = 'ASCII (5 characters)';
  form.elements["format" + wlan_id].options[1].text = 'Hex (10 characters)';
  form.wepKeyLen[0].checked = true;
 }
 else {
  form.elements["format" + wlan_id].options[0].text = 'ASCII (13 characters)';
  form.elements["format" + wlan_id].options[1].text = 'Hex (26 characters)';
  form.wepKeyLen[1].checked = true;
 }
 //form.elements["format" + wlan_id].selectedIndex =  wep_key_fmt;
 // Mason Yu. TBD
 //form.elements["format" + wlan_id].selectedIndex =  0;
 setDefaultKeyValue(form, wlan_id);
}
function check_wepkey()
{
 form = document.formEncrypt;
 var keyLen;
 if (form.length0.selectedIndex == 0) {
    if ( form.format0.selectedIndex == 0)
   keyLen = 5;
  else
   keyLen = 10;
 }
 else {
   if ( form.format0.selectedIndex == 0)
  keyLen = 13;
 else
  keyLen = 26;
 }
 if (form.key0.value.length != keyLen) {
  alert('<% multilang("2400" "LANG_INVALID_LENGTH_OF_KEY_VALUE"); %>');
  form.key0.focus();
  return 0;
 }
 if ( form.key0.value == "*****" ||
  form.key0.value == "**********" ||
  form.key0.value == "*************" ||
  form.key0.value == "**************************" )
  return 1;
 if (form.format0.selectedIndex==0)
  return 1;
 for (var i=0; i<form.key0.value.length; i++) {
  if ( (form.key0.value.charAt(i) >= '0' && form.key0.value.charAt(i) <= '9') ||
   (form.key0.value.charAt(i) >= 'a' && form.key0.value.charAt(i) <= 'f') ||
   (form.key0.value.charAt(i) >= 'A' && form.key0.value.charAt(i) <= 'F') )
   continue;
  alert("<% multilang("2394" "LANG_INVALID_KEY_VALUE_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F"); %>");
  form.key0.focus();
  return 0;
 }
 return 1;
}
function check_rs()
{
 form = document.formEncrypt;
 if (checkHostIP(form.radiusIP, 1) == false) {
  return false;
 }
 if (form.radiusPort.value=="") {
  alert("<% multilang("2401" "LANG_RADIUS_SERVER_PORT_NUMBER_CANNOT_BE_EMPTY_IT_SHOULD_BE_A_DECIMAL_NUMBER_BETWEEN_1_65535"); %>");
  form.radiusPort.focus();
  return false;
   }
 if (validateKey(form.radiusPort.value)==0) {
  alert("<% multilang("2401" "LANG_RADIUS_SERVER_PORT_NUMBER_CANNOT_BE_EMPTY_IT_SHOULD_BE_A_DECIMAL_NUMBER_BETWEEN_1_65535"); %>");
  form.radiusPort.focus();
  return false;
 }
        port = parseInt(form.radiusPort.value, 10);
  if (port > 65535 || port < 1) {
  alert("<% multilang("2402" "LANG_INVALID_PORT_NUMBER_OF_RADIUS_SERVER_IT_SHOULD_BE_A_DECIMAL_NUMBER_BETWEEN_1_65535"); %>");
  form.radiusPort.focus();
  return false;
   }
 return true;
}
function saveChanges()
{
  form = document.formEncrypt;
  wpaAuth = form.wpaAuth;
  if (form.security_method.value == 0) { /* WIFI_SEC_NONE */
   alert("<% multilang("2403" "LANG_WARNING_SECURITY_IS_NOT_SETTHIS_MAY_BE_DANGEROUS"); %>");
  }
  else if (form.security_method.value == 1) { /* WIFI_SEC_WEP */
   if (form.use1x.checked == false) {
    if (check_wepkey() == false)
     return false;
   }
   else {
    if (check_rs() == false)
     return false;
   }
 if (wps20 && wps20_use_version!=0 && form.wpaSSID.value==0)
  alert("<% multilang("2404" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_WEP"); %>");
  }
  else if (form.security_method.value == 2 || form.security_method.value == 4 || form.security_method.value == 6) { /* WPA or WPA2 or WPA2 mixed */
    if (form.security_method.value == 2) { /* WIFI_SEC_WPA */
     if(form.ciphersuite_t.checked == false && form.ciphersuite_a.checked == false )
  {
   alert("<% multilang("2405" "LANG_WPA_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>");
   return false;
  }
  if (form.isNmode.value == 1 && form.ciphersuite_t.checked == true && form.ciphersuite_a.checked == true)
  {
   alert("<% multilang("2406" "LANG_CAN_NOT_SELECT_TKIP_AND_AES_IN_THE_SAME_TIME"); %>");
   return false;
  }
  if (wps20 && wps20_use_version!=0 && form.wpaSSID.value==0)
   alert("<% multilang("2407" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_WPA_ONLY"); %>");
    }
    if (form.security_method.value == 4) { /* WIFI_SEC_WPA2 */
     if(form.wpa2ciphersuite_t.checked == false && form.wpa2ciphersuite_a.checked == false )
  {
   alert("<% multilang("2408" "LANG_WPA2_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>");
   return false;
  }
  if (form.isNmode.value == 1 && form.wpa2ciphersuite_t.checked == true && form.wpa2ciphersuite_a.checked == true)
  {
   alert("<% multilang("2406" "LANG_CAN_NOT_SELECT_TKIP_AND_AES_IN_THE_SAME_TIME"); %>");
   return false;
  }
  if (form.wpa2ciphersuite_t.checked == true) {
   if (wps20 && wps20_use_version!=0 && form.wpaSSID.value==0 && form.wpa2ciphersuite_a.checked == false)
    alert("<% multilang("2409" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_TKIP_ONLY"); %>");
  }
    }
 if (form.security_method.value == 6) { /* WIFI_SEC_WPA2_MIXED */
  if(wlanMode == 1 && ((form.ciphersuite_t.checked == true && form.ciphersuite_a.checked == true)
   || (form.wpa2ciphersuite_t.checked == true && form.wpa2ciphersuite_a.checked == true)))
  {
   alert("<% multilang("2410" "LANG_IN_THE_CLIENT_MODE_YOU_CAN_T_SELECT_TKIP_AND_AES_IN_THE_SAME_TIME"); %>");
   return false;
  }
     if(form.ciphersuite_t.checked == false && form.ciphersuite_a.checked == false )
  {
   alert("<% multilang("2405" "LANG_WPA_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>");
   return false;
  }
  if(form.wpa2ciphersuite_t.checked == false && form.wpa2ciphersuite_a.checked == false )
  {
   alert("<% multilang("2408" "LANG_WPA2_CIPHER_SUITE_CAN_NOT_BE_EMPTY"); %>");
   return false;
  }
  if (wps20 && wps20_use_version!=0 && form.wpaSSID.value==0 && form.ciphersuite_t.checked == true && form.wpa2ciphersuite_t.checked == true
   && form.ciphersuite_a.checked == false && form.wpa2ciphersuite_a.checked == false)
   alert("<% multilang("2409" "LANG_INFO_WPS_WILL_BE_DISABLED_WHEN_USING_TKIP_ONLY"); %>");
    }
 var str = form.pskValue.value;
 if (form.pskFormat.selectedIndex==1) {
  if (str.length != 64) {
   alert('<% multilang("2395" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_64_CHARACTERS"); %>');
   form.pskValue.focus();
   return false;
  }
  takedef = 0;
  if (defPskFormat == 1 && defPskLen == 64) {
   for (var i=0; i<64; i++) {
        if ( str.charAt(i) != '*')
     break;
   }
   if (i == 64 )
    takedef = 1;
    }
  if (takedef == 0) {
   for (var i=0; i<str.length; i++) {
        if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
     (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
     (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
     continue;
    alert("<% multilang("2396" "LANG_INVALID_PRE_SHARED_KEY_VALUE_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F"); %>");
    form.pskValue.focus();
    return false;
     }
  }
 }
 else {
  if ( (form.security_method.value > 1) && wpaAuth[1].checked ) {
   if (str.length < 8) {
    alert('<% multilang("2397" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_SET_AT_LEAST_8_CHARACTERS"); %>');
    form.pskValue.focus();
    return false;
   }
   if (str.length > 63) {
    alert('<% multilang("2398" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_LESS_THAN_64_CHARACTERS"); %>');
    form.pskValue.focus();
    return false;
   }
   if (checkString(form.pskValue.value) == 0) {
    alert('<% multilang("2411" "LANG_INVALID_PRE_SHARED_KEY"); %>');
    form.pskValue.focus();
    return false;
   }
  }
 }
  }
   return true;
}
function postSecurity(encrypt, enable1X, wpaAuth, wpaPSKFormat, wpaPSK, wpaGroupRekeyTime, rsPort, rsIpAddr, rsPassword, uCipher, wpa2uCipher, wepAuth, wepLen, wepKeyFormat, dotIeee80211w, sh256)
{
 document.formEncrypt.security_method.value = encrypt;
 document.formEncrypt.pskFormat.value = wpaPSKFormat;
 document.formEncrypt.pskValue.value = wpaPSK;
 document.formEncrypt.gk_rekey.value = wpaGroupRekeyTime;
 document.formEncrypt.radiusIP.value = rsIpAddr;
 document.formEncrypt.radiusPort.value = rsPort;
 document.formEncrypt.radiusPass.value = rsPassword;
 if (document.formEncrypt.wepKeyLen && wepLen > 0)
  document.formEncrypt.wepKeyLen[wepLen-1].checked = true;
 if (enable1X==1)
  document.formEncrypt.use1x.checked = true;
 else
  document.formEncrypt.use1x.checked = false;
 document.formEncrypt.wpaAuth[wpaAuth-1].checked = true;
 document.formEncrypt.ciphersuite_t.checked = false;
 document.formEncrypt.ciphersuite_a.checked = false;
 if ( uCipher == 1 )
  document.formEncrypt.ciphersuite_t.checked = true;
 if ( uCipher == 2 )
  document.formEncrypt.ciphersuite_a.checked = true;
 if ( uCipher == 3 ) {
  document.formEncrypt.ciphersuite_t.checked = true;
  document.formEncrypt.ciphersuite_a.checked = true;
 }
 document.formEncrypt.wpa2ciphersuite_t.checked = false;
 document.formEncrypt.wpa2ciphersuite_a.checked = false;
 if ( wpa2uCipher == 1 )
  document.formEncrypt.wpa2ciphersuite_t.checked = true;
 if ( wpa2uCipher == 2 )
  document.formEncrypt.wpa2ciphersuite_a.checked = true;
 if ( wpa2uCipher == 3 ) {
  document.formEncrypt.wpa2ciphersuite_t.checked = true;
  document.formEncrypt.wpa2ciphersuite_a.checked = true;
 }
 document.formEncrypt.auth_type[wepAuth].checked = true;
 if ( wepLen == 0 )
  document.formEncrypt.length0.value = 1;
 else
  document.formEncrypt.length0.value = wepLen;
 document.formEncrypt.format0.value = wepKeyFormat+1;
 if(support_11w){
  document.formEncrypt.dotIEEE80211W[dotIeee80211w].checked = true;
  document.formEncrypt.sha256[sh256].checked = true;
 }
 show_authentication();
        defPskLen = document.formEncrypt.pskValue.value.length;
 defPskFormat = document.formEncrypt.pskFormat.selectedIndex;
 updateWepFormat(document.formEncrypt, 0);
}
function SSIDSelected(index)
{
 if (document.formEncrypt.wlanDisabled.value == "ON") {
  disableTextField(document.formEncrypt.wpaSSID);
  disableTextField(document.formEncrypt.security_method);
  disableCheckBox(document.formEncrypt.use1x);
  disableRadioGroup(document.formEncrypt.auth_type);
  disableTextField(document.formEncrypt.length0);
  disableTextField(document.formEncrypt.format0);
  disableTextField(document.formEncrypt.key0);
  disableRadioGroup(document.formEncrypt.wpaAuth);
  disableRadioGroup(document.formEncrypt.dotIEEE80211W);
  disableRadioGroup(document.formEncrypt.sha256);
  disableCheckBox(document.formEncrypt.ciphersuite_t);
  disableCheckBox(document.formEncrypt.ciphersuite_a);
  disableCheckBox(document.formEncrypt.wpa2ciphersuite_t);
  disableCheckBox(document.formEncrypt.wpa2ciphersuite_a);
  disableTextField(document.formEncrypt.pskFormat);
  disableTextField(document.formEncrypt.pskValue);
  disableRadioGroup(document.formEncrypt.wapiAuth);
  disableTextField(document.formEncrypt.wapiPskFormat);
  disableTextField(document.formEncrypt.wapiPskValue);
  disableRadioGroup(document.formEncrypt.wepKeyLen);
  disableTextField(document.formEncrypt.radiusIP);
  disableTextField(document.formEncrypt.radiusPort);
  disableTextField(document.formEncrypt.radiusPass);
  disableCheckBox(document.formEncrypt.uselocalAS);
  disableTextField(document.formEncrypt.wapiASIP);
  disableTextField(document.formEncrypt.save);
 }
 if (ssid_num == 0)
  return;
 wlanMode = _wlan_mode[index];
 document.formEncrypt.isNmode.value = _wlan_isNmode[index];
 postSecurity(_encrypt[index], _enable1X[index],
  _wpaAuth[index], _wpaPSKFormat[index], _wpaPSK[index],
  _wpaGroupRekeyTime[index],
  _rsPort[index], _rsIpAddr[index], _rsPassword[index],
  _uCipher[index], _wpa2uCipher[index], _wepAuth[index],
  _wepLen[index], _wepKeyFormat[index], _dotIEEE80211W[index], _sha256[index]);
}
</script>
</head>
<body onload="SSIDSelected(0);">
<blockquote>
<h2><font color="#0000FF"><% multilang("158" "LANG_WLAN_SECURITY_SETTINGS"); %></font></h2>
<form action=/boaform/admin/formWlEncrypt method=POST name="formEncrypt">
<table border=0 width="500" cellspacing=4 cellpadding=0>
    <tr><td><font size=2>
    <% multilang("159" "LANG_THIS_PAGE_ALLOWS_YOU_SETUP_THE_WLAN_SECURITY_TURN_ON_WEP_OR_WPA_BY_USING_ENCRYPTION_KEYS_COULD_PREVENT_ANY_UNAUTHORIZED_ACCESS_TO_YOUR_WIRELESS_NETWORK"); %>
    </font></td></tr>
    <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<div id="wlan_security_table" style="display:none">
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <input type=hidden name="wlanDisabled" value=<% wlanStatus(); %>>
 <input type=hidden name="isNmode" value=0 >
    <tr>
      <td width="35%"><font size="2"><b><% multilang("112" "LANG_SSID"); %> <% multilang("224" "LANG_TYPE"); %>:</b></font></td>
 <td width="65%"><font size="2">
  <select name=wpaSSID onChange="SSIDSelected( this.selectedIndex )">
  <% SSID_select(); %>
  </select>
 </font></td>
    </tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
    <tr><td><hr size=1 noshade align=top></td></tr>
    <tr>
      <td width="35%"><font size="2"><b><% multilang("160" "LANG_ENCRYPTION"); %>:&nbsp;</b>
       <select size="1" id="security_method" name="security_method" onChange="show_authentication()">
    <% checkWrite("wifiSecurity"); %>
        </select></font>
    </tr>
    <tr id="enable_8021x" style="display:none">
   <td colspan="2" width="100%">
    <table width="100%" border="0" cellpadding="0" cellspacing="4">
      <tr>
       <td width="30%" class="bgblue"><font size="2"><b>802.1x <% multilang("161" "LANG_AUTHENTICATION"); %>:</b></font></td>
       <td width="70%" class="bggrey"><font size="2">
       <input type="checkbox" id="use1x" name="use1x" value="ON" onClick="show_8021x_settings()">
        </font>
     </td></tr>
    </table>
    </td></tr>
    <tr id="show_wep_auth" style="display:none">
     <td colspan="2" width="100%">
      <table width="100%" border="0" cellpadding="0" cellspacing="4">
        <tr>
        <td width="30%"bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("161" "LANG_AUTHENTICATION"); %>:</b></font></td>
        <td width="70%" class="bggrey"><font size="2">
         <input name="auth_type" type=radio value="open"><% multilang("162" "LANG_OPEN_SYSTEM"); %>
         <input name="auth_type" type=radio value="shared"><% multilang("163" "LANG_SHARED_KEY"); %>
         <input name="auth_type" type=radio value="both"><% multilang("136" "LANG_AUTO"); %>
          </font>
       </td></tr>
      </table>
    </td></tr>
    <tr id="setting_wep" style="display:none">
  <td colspan="2" width="100%">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
         <input type="hidden" name="wepEnabled" value="ON" checked>
     <tr bgcolor="#FFFFFF">
     <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("164" "LANG_KEY_LENGTH"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
     <select size="1" name="length0" id="length" onChange="updateWepFormat(document.formEncrypt, 0)">
       <option value=1> 64-bit</option>
       <option value=2>128-bit</option>
     </select></font>
    </td></tr>
    <tr bgcolor="#FFFFFF">
     <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("165" "LANG_KEY_FORMAT"); %>:</b></font></td>
     <td width="70%" class="bggrey">
     <select id="format" name="format0" onChange="setDefaultKeyValue(document.formEncrypt, 0)">
           <option value="1">ASCII</option>
      <option value="2">Hex</option>
     </select>
    </td></tr>
    <tr bgcolor="#FFFFFF">
     <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("166" "LANG_ENCRYPTION_KEY"); %>:</b></font></td>
     <td width="70%" class="bggrey">
      <input type="text" id="key" name="key0" maxlength="26" size="26" value="">
    </td></tr>
   </table>
 </td></tr>
 <tr id="setting_wpa" style="display:none">
  <td colspan="2">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
    <tr>
     <td width="30%" class="bgblue"><font size="2"><b><% multilang("167" "LANG_AUTHENTICATION_MODE"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
      <input name="wpaAuth" type="radio" value="eap" onClick="show_wpa_settings()">Enterprise (RADIUS)
      <input name="wpaAuth" type="radio" value="psk" onClick="show_wpa_settings()">Personal (Pre-Shared Key)
       </font>
    </td></tr>
    <tr id="show_dotIEEE80211W" style="display:none">
     <td width="30%" class="bgblue"><font size="2"><b><% multilang("174" "LANG_IEEE_802_11W"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
      <input name="dotIEEE80211W" type="radio" value="0" onClick="show_sha256_settings()">None
      <input name="dotIEEE80211W" type="radio" value="1" onClick="show_sha256_settings()">Capable
      <input name="dotIEEE80211W" type="radio" value="2" onClick="show_sha256_settings()">Required
       </font>
    </td></tr>
    <tr id="show_sha256" style="display:none">
     <td width="30%" class="bgblue"><font size="2"><b><% multilang("175" "LANG_SHA256"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
      <input name="sha256" type="radio" value="0">Disable
      <input name="sha256" type="radio" value="1">Enable
       </font>
    </td></tr>
    <tr id="show_wpa_cipher" style="display:none">
     <td width="30%" class="bgblue"><font size="2"><b>WPA <% multilang("168" "LANG_CIPHER_SUITE"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
      <input type="checkbox" name="ciphersuite_t" value=1>TKIP&nbsp;
      <input type="checkbox" name="ciphersuite_a" value=1>AES
       </font>
    </td></tr>
    <tr id="show_wpa2_cipher" style="display:none">
     <td width="30%"class="bgblue"><font size="2"><b>WPA2 <% multilang("168" "LANG_CIPHER_SUITE"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
      <input type="checkbox" name="wpa2ciphersuite_t" value=1>TKIP&nbsp;
      <input type="checkbox" name="wpa2ciphersuite_a" value=1>AES
       </font>
    </td></tr>
    <tr id="show_wpa_gk_rekey" style="display:none">
    <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("169" "LANG_GROUP_KEY_UPDATE_TIMER"); %>:</b></font></td>
    <td width="70%" class="bggrey"><input type="text" name="gk_rekey" size="32" maxlength="10" value="">
    </td></tr>
    <tr id="show_wpa_psk1" style="display:none">
     <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("170" "LANG_PRE_SHARED_KEY_FORMAT"); %>:</b></font></td>
     <td width="70%" class="bggrey">
     <select id="psk_fmt" name="pskFormat" onChange="">
      <option value="0">Passphrase</option>
      <option value="1">HEX (64 characters)</option>
      </select>
    </td></tr>
    <tr id="show_wpa_psk2" style="display:none">
     <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("171" "LANG_PRE_SHARED_KEY"); %>:</b></font></td>
     <td width="70%" class="bggrey"><input type="password" name="pskValue" id="wpapsk" size="32" maxlength="64" value="">
    </td></tr>
   </table>
 </td></tr>
        <tr id="setting_wapi" style="display:none">
                <td colspan="2">
                        <table width="100%" border="0" cellpadding="0" cellspacing="4">
                                <tr>
                                        <td width="30%" class="bgblue"><font size="2"><b><% multilang("167" "LANG_AUTHENTICATION_MODE"); %>:</b></font></td>
                                        <td width="70%" class="bggrey"><font size="2">
                                                <input name="wapiAuth" type="radio" value="eap" onClick="show_wapi_settings()">Enterprise (AS Server)
                                                <input name="wapiAuth" type="radio" value="psk" onClick="show_wapi_settings()">Personal (Pre-Shared Key)
                                                        </font>
                                </td></tr>
    <tr id="show_wapi_psk1" style="display:none">
    <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("170" "LANG_PRE_SHARED_KEY_FORMAT"); %>:</b></font></td>
                                        <td width="70%" class="bggrey">
                                        <select id="wapi_psk_fmt" name="wapiPskFormat" onChange="">
                                                <option value="0">Passphrase</option>
                                                <option value="1">HEX (64 characters)</option>
                                                </select>
                                </td></tr>
                                <tr id="show_wapi_psk2" style="display:none">
                                        <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b><% multilang("171" "LANG_PRE_SHARED_KEY"); %>:</b></font></td>
                                        <td width="70%" class="bggrey"><input type="password" name="wapiPskValue" id="wapipsk" size="32" maxlength="64" value="">
                                </td></tr>
                        </table>
 </td></tr>
 <tr id="show_1x_wep" style="display:none">
  <td colspan="2">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
    <tr>
     <td width="30%" class="bgblue"><font size="2"><b><% multilang("164" "LANG_KEY_LENGTH"); %>:</b></font></td>
     <td width="70%" class="bggrey"><font size="2">
      <input name="wepKeyLen" type="radio" value="wep64">64 Bits
      <input name="wepKeyLen" type="radio" value="wep128">128 Bits
       </font>
    </td></tr>
    </table>
 </td></tr>
 <tr id="show_8021x_eap" style="display:none">
  <td colspan="2">
   <table width="100%" border="0" cellpadding="0" cellspacing="4">
    <tr>
      <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b>RADIUS <% multilang("71" "LANG_SERVER"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>:</b></font></td>
      <td width="70%" bgcolor="#FFFFFF" class="bggrey"><input id="radius_ip" name="radiusIP" size="16" maxlength="15" value="0.0.0.0"></td>
     </tr>
    <tr>
     <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b>RADIUS <% multilang("71" "LANG_SERVER"); %> <% multilang("172" "LANG_PORT"); %>:</b></font></td>
     <td width="70%" class="bggrey"><input type="text" id="radius_port" name="radiusPort" size="5" maxlength="5" value="1812"></td>
     </tr>
    <tr>
     <td width="30%" class="bgblue"><font size="2"><b>RADIUS <% multilang("71" "LANG_SERVER"); %> <% multilang("49" "LANG_PASSWORD"); %>:</b></font></td>
     <td width="70%" class="bggrey"><input type="password" id="radius_pass" name="radiusPass" size="32" maxlength="64" value="12345"></td>
    </tr>
   </table>
 </td></tr>
        <tr id="show_8021x_wapi" style="display:none">
                <td colspan="2">
                        <table width="100%" border="0" cellpadding="0" cellspacing="4">
                                <tr id="show_8021x_wapi_local_as" style="">
                                <td width="30%" class="bgblue"><font size="2"><b><% multilang("173" "LANG_USE_LOCAL_AS_SERVER"); %>:</b></font></td>
                                <td width="70%" class="bggrey"><font size="2">
                                <input type="checkbox" id="uselocalAS" name="uselocalAS" value="ON" onClick="show_wapi_ASip()">
                                </font>
                                </td></tr>
    <tr>
                                         <td width="30%" bgcolor="#FFFFFF" class="bgblue"><font size="2"><b>AS <% multilang("71" "LANG_SERVER"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>:</b></font></td>
                                         <td width="70%" bgcolor="#FFFFFF" class="bggrey"><input id="wapiAS_ip" name="wapiASIP" size="16" maxlength="15" value="0.0.0.0"></td></tr>
                        </table>
        </td></tr>
        <tr>
         <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
            <input type=hidden value="/admin/wlwpa.asp" name="submit-url">
           <td width="100%" colspan="2"><input type=submit value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name=save onClick="return saveChanges()">&nbsp;
           </td>
        </tr>
</table>
</div>
    <script>
 <% initPage("wlwpa_mbssid"); %>
 <% checkWrite("wpsVer"); %>
 show_authentication();
 defPskLen = document.formEncrypt.pskValue.value.length;
 defPskFormat = document.formEncrypt.pskFormat.selectedIndex;
 updateWepFormat(document.formEncrypt, 0);
    </script>
</form>
</blockquote>
</body>
</html>

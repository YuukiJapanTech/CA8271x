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
<title><% multilang("628" "LANG_WLAN_SITE_SURVEY"); %></title>
<script type="text/javascript" src="share.js"> </script>
<script>
var connectEnabled=0, autoconf=0;
function show_wpa_settings()
{
 var dF=document.forms[0];
 var allow_tkip=0;
 get_by_id("show_wpa_psk1").style.display = "none";
 get_by_id("show_wpa_psk2").style.display = "none";
 get_by_id("show_8021x_eap").style.display = "none";
 if (dF.wpaAuth[1].checked)
 {
  get_by_id("show_wpa_psk1").style.display = "";
  get_by_id("show_wpa_psk2").style.display = "";
 }
 //else{
 //	if (wlanMode != 1)
 //	get_by_id("show_8021x_eap").style.display = "";
 //}	
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
   /*
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
				*/
  if (dF.wapiASIP.value == "192.168.1.1")
  {
   dF.uselocalAS.checked=true;
  }
        }
}
function show_authentication()
{
 var security = get_by_id("security_method");
 var enable_1x = get_by_id("use1x");
 var form1 = document.forms[0] ;
 //if (wlanMode==1 && security.value == 6) {	/* client and WIFI_SEC_WPA2_MIXED */
 //	alert("Not allowed for the Client mode.");
 //	security.value = oldMethod;
 //	return false;
 //}
 //oldMethod = security.value;
 get_by_id("show_wep_auth").style.display = "none";
 get_by_id("setting_wep").style.display = "none";
 get_by_id("setting_wpa").style.display = "none";
 get_by_id("setting_wapi").style.display = "none";
 get_by_id("show_wpa_cipher").style.display = "none";
 get_by_id("show_wpa2_cipher").style.display = "none";
 get_by_id("enable_8021x").style.display = "none";
 get_by_id("show_8021x_eap").style.display = "none";
 get_by_id("show_8021x_wapi").style.display = "none";
 get_by_id("show_1x_wep").style.display = "none";
        get_by_id("show_wapi_psk1").style.display = "none";
        get_by_id("show_wapi_psk2").style.display = "none";
        get_by_id("show_8021x_wapi").style.display = "none";
 disableTextField(form1.security_method);
 if (security.value == 1){ /* WIFI_SEC_WEP */
  get_by_id("show_wep_auth").style.display = "";
  //disableRadioGroup(form1.auth_type);
  get_by_id("setting_wep").style.display = "";
  //if (wlanMode == 1) 
  /*
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
		}*/
 }else if (security.value == 2 || security.value == 4 || security.value == 6){ /* WIFI_SEC_WPA/WIFI_SEC_WPA2/WIFI_SEC_WPA2_MIXED */
  //form1.ciphersuite_t.disabled = false;
  //form1.wpa2ciphersuite_t.disabled = false;
  get_by_id("setting_wpa").style.display = "";
  disableRadioGroup(form1.wpaAuth);
  if (security.value == 2) { /* WIFI_SEC_WPA */
   get_by_id("show_wpa_cipher").style.display = "";
   disableCheckBox(form1.ciphersuite_t);
   disableCheckBox(form1.ciphersuite_a);
   /*
			if ( form1.isNmode.value == 1 ) {
				//alert("Select wpa and is Nmode");
				form1.ciphersuite_t.disabled = true;
				form1.ciphersuite_t.checked = false;
				form1.wpa2ciphersuite_t.disabled = true;
				form1.wpa2ciphersuite_t.checked = false;
			}
			*/
  }
  if(security.value == 4) { /* WIFI_SEC_WPA2 */
   get_by_id("show_wpa2_cipher").style.display = "";
   disableCheckBox(form1.wpa2ciphersuite_t);
   disableCheckBox(form1.wpa2ciphersuite_a);
   /*
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
			*/
  }
  if(security.value == 6){ /* WIFI_SEC_WPA2_MIXED */
   get_by_id("show_wpa_cipher").style.display = "";
   get_by_id("show_wpa2_cipher").style.display = "";
   disableCheckBox(form1.ciphersuite_t);
   disableCheckBox(form1.ciphersuite_a);
   disableCheckBox(form1.wpa2ciphersuite_t);
   disableCheckBox(form1.wpa2ciphersuite_a);
   /*
			if(new_wifi_sec){
				form1.ciphersuite_t.disabled = true;
				form1.ciphersuite_t.checked = true;
				form1.ciphersuite_a.disabled = true;
				form1.ciphersuite_a.checked = false;
				form1.wpa2ciphersuite_t.disabled = true;
				form1.wpa2ciphersuite_t.checked = false;
				form1.wpa2ciphersuite_a.disabled = true;
				form1.wpa2ciphersuite_a.checked = true;
			}
			else{
				form1.ciphersuite_t.disabled = false;
				form1.wpa2ciphersuite_t.disabled = false;
			}
			*/
  }
  show_wpa_settings();
 }else if(security.value == 8 ) /* WIFI_SEC_WAPI */
 {
  get_by_id("setting_wapi").style.display = "";
  show_wapi_settings();
 }
/*	
	if (security.value == 0) {	// WIFI_SEC_NONE 
		if (wlanMode != 1) {
			get_by_id("enable_8021x").style.display = "";
			if(enable_1x.checked){		
				get_by_id("show_8021x_eap").style.display = "";
			}
			else {
				get_by_id("show_8021x_eap").style.display = "none";			
			}
		}
	}
	*/
}
function saveClickSSID()
{
 var dF=document.forms[0];
 //wizardHideDiv();
 //show_div(true, ("wlan_security_div"));	
 get_by_id("wlan_security_div").style.display="";
 get_by_id("top_div").style.display="none";
 if(document.getElementById("pocket_encrypt").value == "no"){
  get_by_id("security_method").value = 0;
  dF.wlan_encrypt.value = 0;
 }
 else if(document.getElementById("pocket_encrypt").value == "WEP"){
  get_by_id("security_method").value = 1;
  dF.wlan_encrypt.value = 1;
 }
 else if(document.getElementById("pocket_encrypt").value.indexOf("WPA2") != -1){
  get_by_id("security_method").value = 4;
  dF.wlan_encrypt.value = 4;
  //if((client_mode_support_1x==1)&&(document.getElementById("pocket_encrypt").value.indexOf("-1X") !=-1)){
  //	dF.wpaAuth<% getIndex("wlan_idx"); %>[0].checked=true;
  //	dF.wpaAuth<% getIndex("wlan_idx"); %>[1].checked=false;
  //}
  //else
  {
   dF.wpaAuth[0].checked=false;
   dF.wpaAuth[1].checked=true;
  }
  if(document.getElementById("pocket_wpa2_tkip_aes").value.indexOf("aes")!=-1){
   dF.wpa2ciphersuite_t.checked=false;
   dF.wpa2ciphersuite_a.checked=true;
   dF.wpa2_tkip_aes.value = 2;
  }
  else if(document.getElementById("pocket_wpa2_tkip_aes").value.indexOf("tkip")!=-1){
   dF.wpa2ciphersuite_t.checked=true;
   dF.wpa2ciphersuite_a.checked=false;
   dF.wpa2_tkip_aes.value = 1;
  }
  else{
   alert("<% multilang("2381" "LANG_ERROR_NOT_SUPPORTED_WPA2_CIPHER_SUITE"); %>");//Added for test
  }
 }
 else if(document.getElementById("pocket_encrypt").value.indexOf("WPA") != -1){
  get_by_id("security_method").value = 2;
  dF.wlan_encrypt.value = 2;
  //if((client_mode_support_1x==1)&&(document.getElementById("pocket_encrypt").value.indexOf("-1X") !=-1)){
  //	dF.wpaAuth[0].checked=true;
  //	dF.wpaAuth[1].checked=false;
  //}
  //else
  {
   dF.wpaAuth[0].checked=false;
   dF.wpaAuth[1].checked=true;
  }
  if(document.getElementById("pocket_wpa_tkip_aes").value.indexOf("aes")!=-1){
   dF.ciphersuite_t.checked=false;
   dF.ciphersuite_a.checked=true;
   dF.wpa_tkip_aes.value = 2;
  }
  else if(document.getElementById("pocket_wpa_tkip_aes").value.indexOf("tkip")!=-1){
   dF.ciphersuite_t.checked=true;
   dF.ciphersuite_a.checked=false;
   dF.wpa_tkip_aes.value = 1;
  }
  else{
   alert("<% multilang("2382" "LANG_ERROR_NOT_SUPPORTED_WPA_CIPHER_SUITE"); %>");//Added for test
  }
 }
 else{
  alert("<% multilang("2383" "LANG_ERROR_NOT_SUPPORTED_ENCRYPT"); %>");//Added for test
 }
 show_authentication();
 enableButton(document.dF.connect);
}
/*
function enableConnect()
{ 
  if (autoconf == 0) {
  enableButton(document.formWlSiteSurvey.connect);
  connectEnabled=1;
}
}
*/
function enableConnect(selId)
{
 if(document.getElementById("select"))
  document.getElementById("select").value = "sel"+selId;
//	if(document.getElementById("next"))
//		enableTextField(parent.document.getElementById("next"));
 if(document.getElementById("pocket_ssid"))
  document.getElementById("pocket_ssid").value = document.getElementById("selSSID_"+selId).value;
  //document.getElementById("pocket_channel").value = document.getElementById("selChannel_"+selId).value;
//alert("pocket_channel="+parent.document.getElementById("pocket_channel").value);  
 if(document.getElementById("pocketAP_ssid"))
  document.getElementById("pocketAP_ssid").value = document.getElementById("selSSID_"+selId).value;
  document.getElementById("pocket_encrypt").value = document.getElementById("selEncrypt_"+selId).value;
  if(document.getElementById("pocket_wpa_tkip_aes"))
  document.getElementById("pocket_wpa_tkip_aes").value = document.getElementById("wpa_tkip_aes_"+selId).value;
  if(document.getElementById("pocket_wpa2_tkip_aes"))
  document.getElementById("pocket_wpa2_tkip_aes").value = document.getElementById("wpa2_tkip_aes_"+selId).value;
  if(document.wizardPocketGW)
  {
   if(document.getElementById("wpa_tkip_aes_"+selId).value == "aes/tkip")
    document.wizardPocketGW.elements["ciphersuite0"].value = "aes";
   else if(document.getElementById("wpa_tkip_aes_"+selId).value == "tkip")
    document.wizardPocketGW.elements["ciphersuite0"].value = "tkip";
   else if(document.getElementById("wpa_tkip_aes_"+selId).value == "aes")
    document.wizardPocketGW.elements["ciphersuite0"].value = "aes";
   if(document.getElementById("wpa2_tkip_aes_"+selId).value == "aes/tkip")
    document.wizardPocketGW.elements["wpa2ciphersuite0"].value = "aes";
   else if(document.getElementById("wpa2_tkip_aes_"+selId).value == "tkip")
    document.wizardPocketGW.elements["wpa2ciphersuite0"].value = "tkip";
   else if(document.getElementById("wpa2_tkip_aes_"+selId).value == "aes")
    document.wizardPocketGW.elements["wpa2ciphersuite0"].value = "aes";
  }
  connectEnabled=1;
  enableButton(document.forms[0].next);
}
function connectClick()
{
  if (connectEnabled==1)
 return true;
  else
   return false;
}
function updateState()
{
  if (document.formWlSiteSurvey.wlanDisabled.value == 1) {
 disableButton(document.formWlSiteSurvey.refresh);
 disableButton(document.formWlSiteSurvey.next);
 disableButton(document.formWlSiteSurvey.connect);
  }
}
function backClick()
{
 var dF=document.forms[0];
 get_by_id("wlan_security_div").style.display="none";
 get_by_id("top_div").style.display="";
 //disableButton(document.formWlSiteSurvey.connect);
 dF.ciphersuite_t.checked=false;
 dF.ciphersuite_a.checked=false;
 dF.wpa2ciphersuite_t.checked=false;
 dF.wpa2ciphersuite_a.checked=false;
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("628" "LANG_WLAN_SITE_SURVEY"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr><td><font size=2>
 <% multilang("629" "LANG_THIS_PAGE_PROVIDES_TOOL_TO_SCAN_THE_WIRELESS_NETWORK_IF_ANY_ACCESS_POINT_OR_IBSS_IS_FOUND_YOU_COULD_CHOOSE_TO_CONNECT_IT_MANUALLY_WHEN_CLIENT_MODE_IS_ENABLED"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/admin/formWlSiteSurvey method=POST name="formWlSiteSurvey">
  <input type=hidden name="wlanDisabled" value=<% getInfo("wlanDisabled"); %>>
  <input type=hidden id="pocket_encrypt" name="pocket_encrypt" value="">
  <input type=hidden id="pocket_wpa_tkip_aes" name="pocket_wpa_tkip_aes" value="">
  <input type=hidden id="pocket_wpa2_tkip_aes" name="pocket_wpa2_tkip_aes" value="">
  <input type=hidden id="wlan_encrypt" name="wlan_encrypt" value="">
  <input type=hidden id="wpa_tkip_aes" name="wpa_tkip_aes" value="">
  <input type=hidden id="wpa2_tkip_aes" name="wpa2_tkip_aes" value="">
  <input type=hidden id="select" name="select" value="">
<span id = "top_div">
<table border=1 width="500">
  <% wlSiteSurveyTbl(); %>
</table>
<br>
  <input type="submit" value="<% multilang("362" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
  <input type="button" value="<% multilang("1122" "LANG_NEXT_STEP"); %>" name="next" onClick="saveClickSSID()">
</span>
<span id = "wlan_security_div" style="display:none">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
      <td width="35%"><font size="2"><b><% multilang("160" "LANG_ENCRYPTION"); %>:&nbsp;</b>
       <select size="1" id="security_method" name="security_method" onChange="show_authentication()">
    <% checkWrite("wifiClientSecurity"); %>
        </select></font>
       </td>
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
         <input name="auth_type" type=radio value="open" checked><% multilang("162" "LANG_OPEN_SYSTEM"); %>
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
  <br>
  </table>
  <br>
  <input type="button" value="<% multilang("1123" "LANG_BACK"); %>" name="back" onClick="return backClick()">
  <input type="submit" value="<% multilang("78" "LANG_CONNECT"); %>" name="connect" onClick="return connectClick()">
  </span>
  <input type="hidden" value="/admin/wlsurvey.asp" name="submit-url">
  <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
 <script>
  <% initPage("wlsurvey"); %>
 disableButton(document.formWlSiteSurvey.next);
 //disableButton(document.formWlSiteSurvey.connect);					
 updateState();
 </script>
</form>
</blockquote>
</body>
</html>

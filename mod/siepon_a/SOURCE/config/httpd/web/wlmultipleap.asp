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
<meta HTTP-EQUIV='Pragma' CONTENT='no-cache'>
<meta HTTP-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>Multiple AP</title>
<style>
.on {display:on}
.off {display:none}
</style>
<script type="text/javascript" src="share.js"> </script>
<script language="JavaScript" type="text/javascript">
var wlan_idx=<% checkWrite("wlan_idx"); %> ;
var WiFiTest=<% getInfo("WiFiTest"); %> ;
var val;
var bandIdx=new Array();
var virtual_bandIdx=new Array();
var virtual_wmm_enable=new Array();
var virtual_wlan_enable=new Array();
var virtual_access=new Array();
var aclist_index;
var mssid_num=<% checkWrite("wlan_mssid_num"); %>;
var fon=<%checkWrite("wlan_fon");%>;
var chanwid=<% getInfo("chanwid"); %>;
val = <% checkWrite("mband"); %>;
if (val > 0)
 val = val-1;
bandIdx[wlan_idx] = val;
if (mssid_num >= 1) {
 val = <% getVirtualIndex("band", "1"); %>;
 if (val > 0)
  val = val-1;
 virtual_bandIdx[1] = val;
 val = <% getVirtualIndex("wmmEnabled", "1"); %>;
 virtual_wmm_enable[1] = val;
 val = <% getVirtualIndex("wlanDisabled", "1"); %>;
 if (val) val = 0;
 else val = 1;
 virtual_wlan_enable[1] = val;
 val = <% getVirtualIndex("wlanAccess", "1"); %>;
 virtual_access[1] = val;
}
if (mssid_num > 1) {
 val = <% getVirtualIndex("band", "2"); %>;
 if (val > 0)
  val = val-1;
 virtual_bandIdx[2] = val;
 val = <% getVirtualIndex("wmmEnabled", "2"); %>;
 virtual_wmm_enable[2] = val;
 val = <% getVirtualIndex("wlanDisabled", "2"); %>;
 if (val) val = 0;
 else val = 1;
 virtual_wlan_enable[2] = val;
 val = <% getVirtualIndex("wlanAccess", "2"); %>;
 virtual_access[2] = val;
}
if (mssid_num > 1) {
 val = <% getVirtualIndex("band", "3"); %>;
 if (val > 0)
  val = val-1;
 virtual_bandIdx[3] = val;
 val = <% getVirtualIndex("wmmEnabled", "3"); %>;
 virtual_wmm_enable[3] = val;
 val = <% getVirtualIndex("wlanDisabled", "3"); %>;
 if (val) val = 0;
 else val = 1;
 virtual_wlan_enable[3] = val;
 val = <% getVirtualIndex("wlanAccess", "3"); %>;
 virtual_access[3] = val;
}
if (mssid_num > 1) {
 val = <% getVirtualIndex("band", "4"); %>;
 if (val > 0)
  val = val-1;
 virtual_bandIdx[4] = val;
 val = <% getVirtualIndex("wmmEnabled", "4"); %>;
 virtual_wmm_enable[4] = val;
 val = <% getVirtualIndex("wlanDisabled", "4"); %>;
 if (val) val = 0;
 else val = 1;
 virtual_wlan_enable[4] = val;
 val = <% getVirtualIndex("wlanAccess", "4"); %>;
 virtual_access[4] = val;
}
var rate_mask = [31,1,1,1,1,2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4,8,8,8,8,8,8,8,8];
var rate_name =["Auto","1M","2M","5.5M","11M","6M","9M","12M","18M","24M","36M","48M","54M", "MCS0", "MCS1"
    , "MCS2", "MCS3", "MCS4", "MCS5", "MCS6", "MCS7", "MCS8", "MCS9", "MCS10", "MCS11", "MCS12", "MCS13", "MCS14", "MCS15"];
var vht_rate_name=["NSS1-MCS0","NSS1-MCS1","NSS1-MCS2","NSS1-MCS3","NSS1-MCS4",
  "NSS1-MCS5","NSS1-MCS6","NSS1-MCS7","NSS1-MCS8","NSS1-MCS9",
  "NSS2-MCS0","NSS2-MCS1","NSS2-MCS2","NSS2-MCS3","NSS2-MCS4",
  "NSS2-MCS5","NSS2-MCS6","NSS2-MCS7","NSS2-MCS8","NSS2-MCS9"];
function DisplayTxRate(v_index, band, auto, txrate, rf_num, channel_width)
{
 var mask, defidx, i, rate;
 mask=0;
 if (auto)
  txrate=0;
 if (band & 1)
  mask |= 1;
 if ((band&2) || (band&4))
  mask |= 2;
 if (band & 8) {
  if (rf_num == 2)
   mask |= 12;
  else
   mask |= 4;
 }
 if(band & 64){
  mask |= 16;
 }
 defidx=0;
 for (idx=0, i=0; i<rate_name.length; i++) {
  if (rate_mask[i] & mask) {
   if (i == 0)
    rate = 0;
   else
    rate = (1 << (i-1));
   if (txrate == rate)
    defidx = idx;
   document.write('<option value="' + i + '">' + rate_name[i] + '\n');
   idx++;
  }
 }
 if(band & 64){
  for (i=0; i<vht_rate_name.length; i++) {
    rate = (((1 << 31)>>>0) + i);
    if (txrate == rate)
     defidx = idx;
    if(channel_width!=0 || (i!=9 && i!=19))//no MCS9 when 20M
    {
     document.write('<option value="' + (i+30) + '">' + vht_rate_name[i] + '\n');
     idx++;
    }
  }
 }
 document.MultipleAP.elements["TxRate"+v_index].selectedIndex=defidx;
}
function openWindow(url, windowName, wide, high) {
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
  var xMax = 640, yMax=500;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open(url, windowName, settings);
}
function open_client_table(id)
{
 aclist_index = id;
 openWindow('/admin/wlstatbl_vap.asp?id='+id, 'showWirelessClient', 700, 400);
}
function click_reset()
{
 for (i=1; i<=4; i++) {
  document.MultipleAP["wl_disable" + i].checked = (virtual_wlan_enable[i] ? true : false);
  UpdateVirtualStatus(document.MultipleAP, i);
 }
}
function saveChanges(form, wlan_id)
{
 var idx;
  for (idx=1; idx<=4; idx++) {
  if (form.elements["wl_disable"+idx].checked) {
   ssid = form.elements["wl_ssid"+idx];
   if (ssid.value == "") {
    alert("<% multilang("2370" "LANG_SSID_CANNOT_BE_EMPTY"); %>");
    ssid.value = ssid.defaultValue;
    ssid.focus();
    return false;
   }
  }
 }
}
function showtxrate_updated_virtual(form, wlan_id, original_wmm_enable, channel_width)
{
   var idx=0;
   var i;
   var txrate_str;
 var band, current_value, txrate_idx;
 var rf_num= <% checkWrite("rf_used"); %> ;
 txrate_idx = form.elements["TxRate"+wlan_id].selectedIndex;
 current_value = form.elements["TxRate"+wlan_id].options[txrate_idx].value;
 i = form.elements["wl_band"+wlan_id].selectedIndex;
 band = form.elements["wl_band"+wlan_id].options[i].value;
 form.elements["TxRate"+wlan_id].length=0;
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("Auto", "0", false, false);
 if (band == 0 || band ==2 || band ==10) {
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("1M", "1", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("2M", "2", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("5.5M", "3", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("11M", "4", false, false);
 }
 if (band ==9 || band ==10 || band ==1 || band ==2 || band==3 || band==11 || band==75) {
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("6M", "5", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("9M", "6", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("12M", "7", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("18M", "8", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("24M", "9", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("36M", "10", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("48M", "11", false, false);
  form.elements["TxRate"+wlan_id].options[idx++] = new Option("54M", "12", false, false);
 }
 if (band ==7 || band ==9 || band ==10 || band==11 || band==63 || band==71 || band==75) {
  if (band ==7 || band ==9 || band ==10 || band==11 || band==71 || band==75) {
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS0", "13", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS1", "14", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS2", "15", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS3", "16", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS4", "17", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS5", "18", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS6", "19", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS7", "20", false, false);
   if (rf_num == 2) {
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS8", "21", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS9", "22", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS10", "23", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS11", "24", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS12", "25", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS13", "26", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS14", "27", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("MCS15", "28", false, false);
   }
  }
  if (band==63 || band==71 || band == 75) {
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS0", "30", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS1", "31", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS2", "32", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS3", "33", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS4", "34", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS5", "35", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS6", "36", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS7", "37", false, false);
   form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS8", "38", false, false);
   if(channel_width!=0)
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS1-MCS9", "39", false, false);
   if (rf_num == 2) {
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS0", "40", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS1", "41", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS2", "42", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS3", "43", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS4", "44", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS5", "45", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS6", "46", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS7", "47", false, false);
    form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS8", "48", false, false);
    if(channel_width!=0)
     form.elements["TxRate"+wlan_id].options[idx++] = new Option("NSS2-MCS9", "49", false, false);
   }
  }
  form.elements["wl_wmm_capable"+wlan_id].selectedIndex = 1;
  disableTextField(form.elements["wl_wmm_capable"+wlan_id]);
 }
 else {
  if (original_wmm_enable)
   form.elements["wl_wmm_capable"+wlan_id].selectedIndex = 1;
  else
   form.elements["wl_wmm_capable"+wlan_id].selectedIndex = 0;
  if (form.elements["wl_band"+wlan_id].selectedIndex == 2 ||
   form.elements["wl_band"+wlan_id].selectedIndex >= 4) {
   form.elements["wl_wmm_capable"+wlan_id].selectedIndex = 1;
   disableTextField(form.elements["wl_wmm_capable"+wlan_id]);
  }
  else
   enableTextField(form.elements["wl_wmm_capable"+wlan_id]);
 }
 form.elements["TxRate"+wlan_id].length = idx;
  for (i=0; i<idx; i++) {
  txrate_str = form.elements["TxRate"+wlan_id].options[i].value;
  if (current_value == txrate_str)
   form.elements["TxRate"+wlan_id].selectedIndex = i;
  else
   form.elements["TxRate"+wlan_id].selectedIndex = 0;
 }
}
function showBand_MultipleAP(form, wlan_id, band_root, index_id)
{
 var idx = 0;
 var band_value = virtual_bandIdx[index_id];
/*
	if (band_root == 11) {	//11:5G
		form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A+N)", "11", false, false);
	}
	else {
		form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B)", "0", false, false);
		form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G)", "1", false, false);
		form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (N)", "7", false, false);
		form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B+G)", "2", false, false);
		form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G+N)", "9", false, false);
		form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B+G+N)", "10", false, false);
	}
*/
 if (band_root ==0) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B)", "0", false, false);
 }
 else if (band_root ==1) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G)", "1", false, false);
 }
 else if (band_root ==2) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B)", "0", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G)", "1", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B+G)", "2", false, false);
 }
 else if (band_root ==9) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G)", "1", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (N)", "7", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G+N)", "9", false, false);
 }
 else if (band_root ==10) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B)", "0", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G)", "1", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B+G)", "2", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (N)", "7", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (G+N)", "9", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (B+G+N)", "10", false, false);
 }
 else if (band_root ==3) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A)", "3", false, false);
 }
 else if (band_root ==7) {
  var Band2G5GSupport=<% checkWrite("Band2G5GSupport"); %>;
  if(Band2G5GSupport==1)//2g
   form.elements["wl_band"+index_id].options[idx++] = new Option("2.4 GHz (N)", "7", false, false);
  else if(Band2G5GSupport==2)//5g
   form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (N)", "7", false, false);
 }
 else if (band_root ==11) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A)", "3", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (N)", "7", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A+N)", "11", false, false);
 }
 else if (band_root ==63) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (AC)", "63", false, false);
 }
 else if (band_root ==71) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (N)", "7", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (AC)", "63", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (N+AC)", "71", false, false);
 }
 else if (band_root ==75) {
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A)", "3", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (N)", "7", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A+N)", "11", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (AC)", "63", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (N+AC)", "71", false, false);
  form.elements["wl_band"+index_id].options[idx++] = new Option("5 GHz (A+N+AC)", "75", false, false);
 }
 if (band_value > band_root)
  band_value = band_root;
 for (i=0 ; i<idx ; i++) {
  if (form.elements["wl_band"+index_id].options[i].value == band_value) {
   form.elements["wl_band"+index_id].selectedIndex = i;
   break;
  }
 }
}
function enableVirtualWLAN(form, virtual_id)
{
 enableTextField(form.elements["wl_band"+virtual_id]);
 enableTextField(form.elements["wl_ssid"+virtual_id]);
 enableTextField(form.elements["TxRate"+virtual_id]);
 enableTextField(form.elements["wl_hide_ssid"+virtual_id]);
 if (form.elements["wl_band"+virtual_id].selectedIndex == 2 ||
  form.elements["wl_band"+virtual_id].selectedIndex >= 4) {
   form.elements["wl_wmm_capable"+virtual_id].selectedIndex = 1;
   disableTextField(form.elements["wl_wmm_capable"+virtual_id]);
 }
 else
  enableTextField(form.elements["wl_wmm_capable"+virtual_id]);
 enableTextField(form.elements["wl_access"+virtual_id]);
 enableTextField(form.elements["aclient"+virtual_id]);
 var i;
    i = form.elements["wl_band"+virtual_id].selectedIndex;
 band = form.elements["wl_band"+virtual_id].options[i].value;
    if(band ==7 || band ==9 || band ==10 || band==11 || band==63|| band==71|| band==75)
    {
        form.elements["wl_wmm_capable"+virtual_id].selectedIndex = 1;
        disableTextField(form.elements["wl_wmm_capable"+virtual_id]);
    }
}
function disableVirtualWLAN(form, virtual_id)
{
 disableTextField(form.elements["wl_band"+virtual_id]);
 disableTextField(form.elements["wl_ssid"+virtual_id]);
 disableTextField(form.elements["TxRate"+virtual_id]);
 disableTextField(form.elements["wl_hide_ssid"+virtual_id]);
 disableTextField(form.elements["wl_wmm_capable"+virtual_id]);
 disableTextField(form.elements["wl_access"+virtual_id]);
 disableTextField(form.elements["aclient"+virtual_id]);
}
function UpdateVirtualStatus(form, virtual_id)
{
 if (!form.elements["wl_disable"+virtual_id].checked)
  disableVirtualWLAN(form, virtual_id);
 else
  enableVirtualWLAN(form, virtual_id);
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">Multiple APs</font></h2>
<table border=0 width="700" cellspacing=0 cellpadding=0>
<tr><font size=2>
 This page shows and updates the wireless setting for multiple APs.
</tr>
<tr><hr size=1 noshade align=top></tr>
</table>
<form action=/boaform/admin/formWlanMultipleAP method=POST name="MultipleAP">
<input type="hidden" value="<% checkWrite("wlan_idx"); %>" name="wlanIdx">
<BR>
  <% checkWrite("blockingvap"); %>
<!--
 <tr>
  <td><b><% multilang("205" "LANG_BLOCKING_BETWEEN_VAP"); %>:</b></td>
  <td><input type="radio" name="mbssid_block" value="disable" ><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" name="mbssid_block" value="enable" ><% multilang("207" "LANG_ENABLE"); %></td>
 </tr>
-->
<table border='1' width="700">
<tr bgcolor=#7f7f7f>
   <td align="center"><font size=2><b>No.</b></td>
   <td align="center"><font size=2><b>Enable</b></td>
   <td <% checkWrite("wlan_qtn_hidden_function"); %> align="center"><font size=2><b>Band</b></td>
   <td align="center"><font size=2><b>SSID</b></td>
   <td <% checkWrite("wlan_qtn_hidden_function"); %> align="center"><font size=2><b>Data Rate</b></td>
   <td align="center"><font size=2><b>Broadcast SSID</b></td>
   <td align="center"><font size=2><b>WMM</b></td>
   <td align="center"><font size=2><b>Relay Blocking</b></td>
   <td align="center"><font size=2><b>Active Client List</b></td>
</tr>
<tr>
 <td height="25" bgcolor="#FFFFFF" align="center">AP1</td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <script type="text/javascript">
   var wlanDisabled = <% getVirtualIndex("wlanDisabled", "1"); %>;
   if (wlanDisabled == "0") {
    document.write('<input type="checkbox" name="wl_disable1" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 1)" checked="checked">');
   }
   else {
    document.write('<input type="checkbox" name="wl_disable1" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 1)">');
   }
  </script>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_band1 onChange="showtxrate_updated_virtual(document.MultipleAP, 1, virtual_wmm_enable[1] , chanwid)">
   <script>
    showBand_MultipleAP(document.MultipleAP, wlan_idx, bandIdx[wlan_idx], 1);
        </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="text" name="wl_ssid1" size="10" maxlength="32" value=<% SSIDStr("vap0"); %>>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name="TxRate1">
   <script>
        band = <% getVirtualIndex("band", "1"); %>;
        auto = <% getVirtualIndex("rateAdaptiveEnabled", "1"); %>;
         txrate = <% getVirtualIndex("fixTxRate", "1"); %>;
         rf_num = <% checkWrite("rf_used"); %>;
    DisplayTxRate(1, band, auto, txrate, rf_num, chanwid);
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_hide_ssid1>
   <option value="1">Disabled</option>
   <option value="0">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_wmm_capable1>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
   <script>
    if (virtual_wmm_enable[1])
     document.MultipleAP.elements["wl_wmm_capable1"].selectedIndex=1;
    else
     document.MultipleAP.elements["wl_wmm_capable1"].selectedIndex=0;
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_access1>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="hidden" value="1" name="vap">
  <input type="button" value="Show" name="aclient1" onClick="open_client_table(1);">
      </td>
</tr>
<script>
  if (mssid_num == 1) {
 document.write("</table>\n");
 document.write("<span id = \"hide_div\" class = \"off\">\n");
 document.write("<table border=\"1\" width=700>\n");
  }
</script>
<tr>
 <td height="25" bgcolor="#FFFFFF" align="center">AP2</td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <script type="text/javascript">
   var wlanDisabled = <% getVirtualIndex("wlanDisabled", "2"); %>;
   if (wlanDisabled == "0") {
    document.write('<input type="checkbox" name="wl_disable2" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 2)" checked="checked">');
   }
   else {
    document.write('<input type="checkbox" name="wl_disable2" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 2)">');
   }
  </script>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_band2 onChange="showtxrate_updated_virtual(document.MultipleAP, 2, virtual_wmm_enable[2], chanwid)">
   <script>
    showBand_MultipleAP(document.MultipleAP, wlan_idx, bandIdx[wlan_idx], 2);
        </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="text" name="wl_ssid2" size="10" maxlength="32" value=<% SSIDStr("vap1"); %>>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name="TxRate2">
   <script>
    band = <% getVirtualIndex("band", "2"); %>;
    auto = <% getVirtualIndex("rateAdaptiveEnabled", "2"); %>;
    txrate = <% getVirtualIndex("fixTxRate", "2"); %>;
    rf_num = <% checkWrite("rf_used"); %>;
    DisplayTxRate(2, band, auto, txrate, rf_num, chanwid);
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_hide_ssid2>
   <option value="1">Disabled</option>
   <option value="0">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_wmm_capable2>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
   <script>
    if (virtual_wmm_enable[2])
     document.MultipleAP.elements["wl_wmm_capable2"].selectedIndex=1;
    else
     document.MultipleAP.elements["wl_wmm_capable2"].selectedIndex=0;
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_access2>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="button" value="Show" name="aclient2" onClick="open_client_table(2);">
      </td>
</tr>
<tr>
 <td height="25" bgcolor="#FFFFFF" align="center">AP3</td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <script type="text/javascript">
   var wlanDisabled = <% getVirtualIndex("wlanDisabled", "3"); %>;
   if (wlanDisabled == "0") {
    document.write('<input type="checkbox" name="wl_disable3" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 3)" checked="checked">');
   }
   else {
    document.write('<input type="checkbox" name="wl_disable3" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 3)">');
   }
  </script>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_band3 onChange="showtxrate_updated_virtual(document.MultipleAP, 3, virtual_wmm_enable[3], chanwid)">
   <script>
    showBand_MultipleAP(document.MultipleAP, wlan_idx, bandIdx[wlan_idx], 3);
        </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="text" name="wl_ssid3" size="10" maxlength="32" value=<% SSIDStr("vap2"); %>>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name="TxRate3">
   <script>
    band = <% getVirtualIndex("band", "3"); %>;
    auto = <% getVirtualIndex("rateAdaptiveEnabled", "3"); %>;
    txrate = <% getVirtualIndex("fixTxRate", "3"); %>;
    rf_num = <% checkWrite("rf_used"); %>;
    DisplayTxRate(3, band, auto, txrate, rf_num, chanwid);
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_hide_ssid3>
   <option value="1">Disabled</option>
   <option value="0">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_wmm_capable3>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
   <script>
    if (virtual_wmm_enable[3])
     document.MultipleAP.elements["wl_wmm_capable3"].selectedIndex=1;
    else
     document.MultipleAP.elements["wl_wmm_capable3"].selectedIndex=0;
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_access3>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="button" value="Show" name="aclient3" onClick="open_client_table(3);">
      </td>
</tr>
<script>
  if (fon == 1) {
 document.write("</table>\n");
 document.write("<span id = \"hide_div\" class = \"off\">\n");
 document.write("<table border=\"1\" width=700>\n");
  }
</script>
<tr>
 <td height="25" bgcolor="#FFFFFF" align="center">AP4</td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <script type="text/javascript">
   var wlanDisabled = <% getVirtualIndex("wlanDisabled", "4"); %>;
   if (wlanDisabled == "0") {
    document.write('<input type="checkbox" name="wl_disable4" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 4)" checked="checked">');
   }
   else {
    document.write('<input type="checkbox" name="wl_disable4" value="ON" onClick="UpdateVirtualStatus(document.MultipleAP, 4)">');
   }
  </script>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_band4 onChange="showtxrate_updated_virtual(document.MultipleAP, 4, virtual_wmm_enable[4], chanwid)">
   <script>
    showBand_MultipleAP(document.MultipleAP, wlan_idx, bandIdx[wlan_idx], 4);
        </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="text" name="wl_ssid4" size="10" maxlength="32" value=<% SSIDStr("vap3"); %>>
 </td>
 <td <% checkWrite("wlan_qtn_hidden_function"); %> height="25" align="center" bgcolor="#FFFFFF">
  <select name="TxRate4">
   <script>
    band = <% getVirtualIndex("band", "4"); %>;
    auto = <% getVirtualIndex("rateAdaptiveEnabled", "4"); %>;
    txrate = <% getVirtualIndex("fixTxRate", "4"); %>;
    rf_num = <% checkWrite("rf_used"); %>;
    DisplayTxRate(4, band, auto, txrate, rf_num, chanwid);
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_hide_ssid4>
   <option value="1">Disabled</option>
   <option value="0">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_wmm_capable4>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
   <script>
    if (virtual_wmm_enable[4])
     document.MultipleAP.elements["wl_wmm_capable4"].selectedIndex=1;
    else
     document.MultipleAP.elements["wl_wmm_capable4"].selectedIndex=0;
   </script>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <select name=wl_access4>
   <option value="0">Disabled</option>
   <option value="1">Enabled</option>
  </select>
 </td>
 <td height="25" align="center" bgcolor="#FFFFFF">
  <input type="button" value="Show" name="aclient4" onClick="open_client_table(4);">
      </td>
</tr>
<script>
 <% initPage("wlmultipleap"); %>
 for (i=1; i<=mssid_num; i++)
  UpdateVirtualStatus(document.MultipleAP, i);
 if (mssid_num == 1 || fon == 1) {
  document.write("</table>\n");
  document.write("</span>\n");
  document.write("<table border=\"1\" width=700>\n");
 }
</script>
</table>
<p></p>
<input type="hidden" value="/admin/wlmultipleap.asp" name="submit-url">
  <input type="submit" value="Apply Changes" name="save" onClick="return saveChanges(document.MultipleAP, wlan_idx)">&nbsp;&nbsp;
  <input type="button" value="Reset" name="reset1" onClick="click_reset();">&nbsp;&nbsp;
  <!-- <input type="button" value=" Close " name="close" onClick="javascript: window.close();"> -->
</form>
</blockquote>
</body>
</html>

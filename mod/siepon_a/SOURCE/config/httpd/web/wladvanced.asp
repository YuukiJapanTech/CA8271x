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
<title><% multilang("130" "LANG_WLAN_ADVANCED_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
var rootBand=<% checkWrite("band"); %>;
var is_wlan_qtn = <% checkWrite("is_wlan_qtn"); %>;
function validateNum(str)
{
  for (var i=0; i<str.length; i++) {
    if ( !(str.charAt(i) >='0' && str.charAt(i) <= '9')) {
  alert("<% multilang("2366" "LANG_INVALID_VALUE_IT_SHOULD_BE_IN_DECIMAL_NUMBER_0_9"); %>");
  return false;
   }
  }
  return true;
}
function saveChanges()
{
  if ( validateNum(document.advanceSetup.fragThreshold.value) == 0 ) {
   document.advanceSetup.fragThreshold.focus();
 return false;
  }
  num = parseInt(document.advanceSetup.fragThreshold.value);
  if (document.advanceSetup.fragThreshold.value == "" || num < 256 || num > 2346) {
   alert("<% multilang("2367" "LANG_INVALID_VALUE_OF_FRAGMENT_THRESHOLD_INPUT_VALUE_SHOULD_BE_BETWEEN_256_2346_IN_DECIMAL"); %>");
   document.advanceSetup.fragThreshold.focus();
 return false;
  }
  if ( validateNum(document.advanceSetup.rtsThreshold.value) == 0 ) {
   document.advanceSetup.rtsThreshold.focus();
 return false;
  }
  num = parseInt(document.advanceSetup.rtsThreshold.value);
  if (document.advanceSetup.rtsThreshold.value=="" || num > 2347) {
   alert("<% multilang("2368" "LANG_INVALID_VALUE_OF_RTS_THRESHOLD_INPUT_VALUE_SHOULD_BE_BETWEEN_0_2347_IN_DECIMAL"); %>");
   document.advanceSetup.rtsThreshold.focus();
 return false;
  }
  if ( validateNum(document.advanceSetup.beaconInterval.value) == 0 ) {
   document.advanceSetup.beaconInterval.focus();
 return false;
  }
  num = parseInt(document.advanceSetup.beaconInterval.value);
  if (document.advanceSetup.beaconInterval.value=="" || num < 20 || num > 1024) {
   alert("<% multilang("2369" "LANG_INVALID_VALUE_OF_BEACON_INTERVAL_INPUT_VALUE_SHOULD_BE_BETWEEN_20_1024_IN_DECIMAL"); %>");
   document.advanceSetup.beaconInterval.focus();
 return false;
  }
  return true;
}
function updateState()
{
  if (document.advanceSetup.wlanDisabled.value == "ON") {
    disableTextField(document.advanceSetup.fragThreshold);
    disableTextField(document.advanceSetup.rtsThreshold);
    disableTextField(document.advanceSetup.beaconInterval);
    disableTextField(document.advanceSetup.txRate);
    disableRadioGroup(document.advanceSetup.preamble);
    disableRadioGroup(document.advanceSetup.hiddenSSID);
    disableRadioGroup(document.advanceSetup.block);
    disableRadioGroup(document.advanceSetup.protection);
    disableRadioGroup(document.advanceSetup.aggregation);
    disableRadioGroup(document.advanceSetup.shortGI0);
    disableRadioGroup(document.advanceSetup.WmmEnabled);
    disableButton(document.advanceSetup.save);
  }
  else if (document.advanceSetup.WmmEnabled) {
   if (rootBand == 7 || rootBand == 9 || rootBand == 10 || rootBand == 11 || rootBand == 63 || rootBand == 71 || rootBand == 75) {
  document.advanceSetup.WmmEnabled[0].checked = true;
      disableRadioGroup(document.advanceSetup.WmmEnabled);
   }
  }
}
</SCRIPT>
<blockquote>
<body>
<h2><font color="#0000FF"><% multilang("130" "LANG_WLAN_ADVANCED_SETTINGS"); %></font></h2>
<form action=/boaform/admin/formAdvanceSetup method=POST name="advanceSetup">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
 <% multilang("131" "LANG_THESE_SETTINGS_ARE_ONLY_FOR_MORE_TECHNICALLY_ADVANCED_USERS_WHO_HAVE_A_SUFFICIENT_KNOWLEDGE_ABOUT_WLAN_THESE_SETTINGS_SHOULD_NOT_BE_CHANGED_UNLESS_YOU_KNOW_WHAT_EFFECT_THE_CHANGES_WILL_HAVE_ON_YOUR_ACCESS_POINT"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <input type=hidden name="wlanDisabled" value=<% wlanStatus(); %>>
    <tr <% checkWrite("wlan_qtn_hidden_function"); %>>
      <td width="30%"><font size=2><b><% multilang("132" "LANG_FRAGMENT_THRESHOLD"); %>:</b></td>
      <td width="70%"><font size=2><input type="text" name="fragThreshold" size="10" maxlength="4" value=<% getInfo("fragThreshold"); %>>(256-2346)</td>
    </tr>
    <tr>
      <td width="30%"><font size=2><b><% multilang("133" "LANG_RTS_THRESHOLD"); %>:</b></td>
      <td width="70%"><font size=2><input type="text" name="rtsThreshold" size="10" maxlength="4" value=<% getInfo("rtsThreshold"); %>>(0-2347)</td>
    </tr>
    <tr>
      <td width="30%"><font size=2><b><% multilang("134" "LANG_BEACON_INTERVAL"); %>:</b></td>
      <td width="70%"><font size=2><input type="text" name="beaconInterval" size="10" maxlength="4" value=<% getInfo("beaconInterval"); %>> (20-1024 <% multilang("872" "LANG_MS"); %>)</td>
    </tr>
    <tr>
      <td width="30%"><font size=2><b><% multilang("135" "LANG_DATA_RATE"); %>:</b></td>
      <td width="70%"><select size="1" name="txRate">
 <SCRIPT>
 <% checkWrite("wl_txRate"); %>
if(!is_wlan_qtn){
 rate_mask = [31,1,1,1,1,2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4,8,8,8,8,8,8,8,8];
 rate_name =["<% multilang("136" "LANG_AUTO"); %>","1M","2M","5.5M","11M","6M","9M","12M","18M","24M","36M","48M","54M", "MCS0", "MCS1",
  "MCS2", "MCS3", "MCS4", "MCS5", "MCS6", "MCS7", "MCS8", "MCS9", "MCS10", "MCS11", "MCS12", "MCS13", "MCS14", "MCS15"];
 vht_rate_name=["NSS1-MCS0","NSS1-MCS1","NSS1-MCS2","NSS1-MCS3","NSS1-MCS4",
  "NSS1-MCS5","NSS1-MCS6","NSS1-MCS7","NSS1-MCS8","NSS1-MCS9",
  "NSS2-MCS0","NSS2-MCS1","NSS2-MCS2","NSS2-MCS3","NSS2-MCS4",
  "NSS2-MCS5","NSS2-MCS6","NSS2-MCS7","NSS2-MCS8","NSS2-MCS9"];
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
    if(chanwid!=0 || (i!=9 && i!=19))//no MCS9 when 20M
    {
     document.write('<option value="' + (i+30) + '">' + vht_rate_name[i] + '\n');
     idx++;
    }
  }
 }
 document.advanceSetup.txRate.selectedIndex=defidx;
}
else{
 idx=0, i=0;
 document.write('<option value="' + (i) + '">' +'<% multilang("136" "LANG_AUTO"); %>'+ '\n');
 idx++;
 defidx=0;
 if ((band & 8) || (band&4)) {
  for (i=1; i<78; i++) { //MCS0~76
   if(i!=32){
    if ((txrate+1) == i && !auto)
     defidx = idx;
    document.write('<option value="' + (i) + '">MCS' +(i-1)+ '\n');
    idx++;
   }
  }
 }
 if(band & 64){
  for(j=1;j<5;j++){
   for(i=(j*100); i<(j*100+10);i++){
     if (txrate == i && !auto)
      defidx = idx;
     document.write('<option value="' + (i) + '">NSS'+j+'-MCS' +(i-j*100)+ '\n');
     idx++;
   }
  }
 }
 document.advanceSetup.txRate.selectedIndex=defidx;
}
 </SCRIPT>
 </select>
     </td>
   </tr>
  <!-- for WiFi test, start --
    <tr>
      <td width="30%"><font size=2><b><% multilang("137" "LANG_TX_OPERATION_RATE"); %>:</b></td>
      <td width="70%"><font size=2>
        <input type="checkbox" name="operRate1M" value="1M">1M&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="operRate2M" value="2M">2M&nbsp;&nbsp;
 <input type="checkbox" name="operRate5M" value="5M">5.5M&nbsp;&nbsp;
        <input type="checkbox" name="operRate11M" value="11M">11M&nbsp;&nbsp;
 <input type="checkbox" name="operRate6M" value="6M">6M&nbsp;&nbsp;
        <input type="checkbox" name="operRate9M" value="9M">9M&nbsp;&nbsp;
       <br>
        <input type="checkbox" name="operRate12M" value="12M">12M&nbsp;&nbsp;
        <input type="checkbox" name="operRate18M" value="18M">18M&nbsp;&nbsp;
 <input type="checkbox" name="operRate24M" value="24M">24M&nbsp;&nbsp;
        <input type="checkbox" name="operRate36M" value="36M">36M&nbsp;&nbsp;
 <input type="checkbox" name="operRate48M" value="48M">28M&nbsp;&nbsp;
        <input type="checkbox" name="operRate54M" value="54M">54M&nbsp;&nbsp;
       </td>
    </tr>
    <tr>
      <td width="30%"><font size=2><b><% multilang("138" "LANG_TX_BASIC_RATE"); %>:</b></td>
      <td width="70%"><font size=2>
        <input type="checkbox" name="basicRate1M" value="1M">1M&nbsp;&nbsp;&nbsp;
        <input type="checkbox" name="basicRate2M" value="2M">2M&nbsp;&nbsp;
 <input type="checkbox" name="basicRate5M" value="5M">5.5M&nbsp;&nbsp;
        <input type="checkbox" name="basicRate11M" value="11M">11M&nbsp;&nbsp;
       <input type="checkbox" name="basicRate6M" value="6M">6M&nbsp;&nbsp;
        <input type="checkbox" name="basicRate9M" value="9M">9M&nbsp;&nbsp;
       <br>
        <input type="checkbox" name="basicRate12M" value="12M">12M&nbsp;&nbsp;
        <input type="checkbox" name="basicRate18M" value="18M">18M&nbsp;&nbsp;
 <input type="checkbox" name="basicRate24M" value="24M">24M&nbsp;&nbsp;
        <input type="checkbox" name="basicRate36M" value="36M">36M&nbsp;&nbsp;
 <input type="checkbox" name="basicRate48M" value="48M">28M&nbsp;&nbsp;
        <input type="checkbox" name="basicRate54M" value="54M">54M&nbsp;&nbsp;
       </td>
    </tr>
    <tr>
      <td width="30%"><font size=2><b><% multilang("139" "LANG_DTIM_PERIOD"); %>:</b></td>
      <td width="70%"><font size=2><input type="text" name="dtimPeriod" size="5" maxlength="3" value=<% getInfo("dtimPeriod"); %>>(1-255)</td>
    </tr>
-- for WiFi test, end -->
     <% write_wladvanced(); %>
 <% ShowWmm(); %>
  </table>
  <p>
  <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
  <input type="hidden" value="/admin/wladvanced.asp" name="submit-url">
  <input type="hidden" value=<% checkWrite("wlan_idx"); %> name="wlan_idx">
  </p>
  <script>
 <% initPage("wladv"); %>
 updateState();
  </script>
</form>
</blockquote>
</body>
</html>

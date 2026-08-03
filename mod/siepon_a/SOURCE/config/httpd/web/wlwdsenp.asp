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
<! Copyright (c) Realtek Semiconductor Corp., 2004. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("724" "LANG_WDS_SECURITY_SETTINGS"); %></title>
<script type="text/javascript" src="share.js"> </script>
<SCRIPT>
var defPskLen=new Array()
var defPskFormat=new Array();
var wlan_idx= <% checkWrite("wlan_idx"); %> ;
function validateKey_wep(form, idx, str, len, wlan_id)
{
 if (idx >= 0) {
  if (form.elements["defaultTxKeyId"+wlan_id].selectedIndex==idx && str.length==0) {
 alert("<% multilang("2391" "LANG_THE_ENCRYPTION_KEY_YOU_SELECTED_AS_THE__TX_DEFAULT_KEY_CANNOT_BE_BLANK"); %>");
 return 0;
  }
  if (str.length ==0)
   return 1;
  if ( str.length != len) {
   idx++;
 alert("<% multilang("2392" "LANG_INVALID_LENGTH_OF_KEY_CHARACTERS"); %>");
 return 0;
  }
  }
  else {
 if ( str.length != len) {
  alert("<% multilang("2393" "LANG_INVALID_LENGTH_OF_WEP_KEY_VALUE"); %>");
  return 0;
   }
  }
  if ( str == "*****" ||
       str == "**********" ||
       str == "*************" ||
       str == "**************************" )
       return 1;
  if (form.elements["format"+wlan_id].selectedIndex==0)
       return 1;
  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
   (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
   (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
   continue;
 alert("<% multilang("2394" "LANG_INVALID_KEY_VALUE_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F"); %>");
 return 0;
  }
  return 1;
}
function updateFormatWds(form, wlan_idx)
{
  format=form.elements["format"+wlan_idx];
  if (form.elements["encrypt"+wlan_idx].selectedIndex == 1) {
 format.options[0].text = 'ASCII (5 characters)';
 format.options[1].text = 'Hex (10 characters)';
  }
  else {
 format.options[0].text = 'ASCII (13 characters)';
 format.options[1].text = 'Hex (26 characters)';
  }
}
function setWepKeyLen(form)
{
  updateFormatWds(form, wlan_idx);
  if (form.elements["encrypt"+wlan_idx].selectedIndex == 1) {
 if ( form.elements["format"+wlan_idx].selectedIndex == 0) {
  form.elements["wepKey"+wlan_idx].maxLength = 5;
  form.elements["wepKey"+wlan_idx].value = "*****";
 }
 else {
  form.elements["wepKey"+wlan_idx].maxLength = 10;
  form.elements["wepKey"+wlan_idx].value = "**********";
 }
  }
  else {
 if ( form.elements["format"+wlan_idx].selectedIndex == 0) {
  form.elements["wepKey"+wlan_idx].maxLength = 13;
  form.elements["wepKey"+wlan_idx].value = "*************";
 }
 else {
  form.elements["wepKey"+wlan_idx].maxLength = 26;
  form.elements["wepKey"+wlan_idx].value = "**************************";
 }
  }
}
function disableWEP(form)
{
  disableTextField(form.elements["format"+wlan_idx]);
  disableTextField(form.elements["wepKey"+wlan_idx]);
}
function disableWPA(form)
{
  disableTextField(form.elements["pskFormat"+wlan_idx]);
  disableTextField(form.elements["pskValue"+wlan_idx]);
}
function enableWEP(form)
{
  enableTextField(form.elements["format"+wlan_idx]);
  enableTextField(form.elements["wepKey"+wlan_idx]);
}
function enableWPA(form)
{
  enableTextField(form.elements["pskFormat"+wlan_idx]);
  enableTextField(form.elements["pskValue"+wlan_idx]);
}
function updateEncryptState(form)
{
  if (form.elements["encrypt"+wlan_idx].value == 0) {
   disableWEP(form);
 disableWPA(form);
  }
  if (form.elements["encrypt"+wlan_idx].value == 1 || form.elements["encrypt"+wlan_idx].value == 2) {
 setWepKeyLen(document.formWdsEncrypt);
  enableWEP(form);
 disableWPA(form);
  }
  if (form.elements["encrypt"+wlan_idx].value == 3 || form.elements["encrypt"+wlan_idx].value == 4) {
  disableWEP(form);
 enableWPA(form);
  }
}
function saveChangesWep(form)
{
  var keyLen;
  if (form.elements["encrypt"+wlan_idx].value == 1) {
   if ( form.elements["format"+wlan_idx].selectedIndex == 0)
  keyLen = 5;
 else
  keyLen = 10;
  }
  else {
   if ( form.elements["format"+wlan_idx].selectedIndex == 0)
  keyLen = 13;
 else
  keyLen = 26;
  }
  if (validateKey_wep(form, -1,form.elements["wepKey"+wlan_idx].value, keyLen, wlan_idx)==0) {
 form.elements["wepKey"+wlan_idx].focus();
 return false;
  }
  return true;
}
function check_wpa_psk(form, wlan_id)
{
 var str = form.elements["pskValue"+wlan_id].value;
 if (form.elements["pskFormat"+wlan_id].value==1) {
  if (str.length != 64) {
   alert("<% multilang("2395" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_64_CHARACTERS"); %>");
   form.elements["pskValue"+wlan_id].focus();
   return false;
  }
  takedef = 0;
  if (defPskFormat[wlan_id] == 1 && defPskLen[wlan_id] == 64) {
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
    form.elements["pskValue"+wlan_id].focus();
    return false;
     }
  }
 }
 else {
  if (str.length < 8) {
   alert("<% multilang("2397" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_SET_AT_LEAST_8_CHARACTERS"); %>");
   form.elements["pskValue"+wlan_id].focus();
   return false;
  }
  if (str.length > 63) {
   alert("<% multilang("2398" "LANG_PRE_SHARED_KEY_VALUE_SHOULD_BE_LESS_THAN_64_CHARACTERS"); %>");
   form.elements["pskValue"+wlan_id].focus();
   return false;
  }
 }
  return true;
  }
function saveChanges(form)
{
  if (form.elements["encrypt"+wlan_idx].value == 0)
   return true;
  else if (form.elements["encrypt"+wlan_idx].value == 1 || form.elements["encrypt"+wlan_idx].value == 2)
  return saveChangesWep(form, wlan_idx);
  else
   return check_wpa_psk(form,wlan_idx );
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("724" "LANG_WDS_SECURITY_SETTINGS"); %> <% if (getIndex("wlan_num")>1) write("-wlan"+(checkWrite("wlan_idx")+1));
%></font></h2>
<form action=/boaform/formWdsEncrypt method=POST name="formWdsEncrypt">
<table border=0 width="500" cellspacing=4>
  <tr><td><font size=2>
    <% multilang("725" "LANG_THIS_PAGE_ALLOWS_YOU_SETUP_THE_WLAN_SECURITY_FOR_WDS_WHEN_ENABLED_YOU_MUST_MAKE_SURE_EACH_WDS_DEVICE_HAS_ADOPTED_THE_SAME_ENCRYPTION_ALGORITHM_AND_KEY"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4>
  <tr>
      <td width="30%"><font size=2><b><% multilang("160" "LANG_ENCRYPTION"); %>:</b></font></td>
      <td width="70%"><font size=2><b>
       <select size="1" name="encrypt<% checkWrite("wlan_idx"); %>" onChange="updateEncryptState(document.formWdsEncrypt)">
          <% checkWrite("wdsEncrypt"); %>
      </b></font></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>WEP <% multilang("165" "LANG_KEY_FORMAT"); %>:</b></font></td>
      <td width="70%"><font size=2><select size="1" name="format<% checkWrite("wlan_idx"); %>" ONCHANGE=setWepKeyLen(document.formWdsEncrypt)>
 <% checkWrite("wdsWepFormat"); %>
       </select></font></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>WEP <% multilang("202" "LANG_KEY"); %>:</b></font></td>
      <td width="70%"><font size=2>
      <input type="text" name="wepKey<% checkWrite("wlan_idx"); %>" size="26" maxlength="26">
      </font></td>
  </tr>
  <tr>
      <td width="30%"><font size="2"><b><% multilang("170" "LANG_PRE_SHARED_KEY_FORMAT"); %>:</b></font></td>
      <td width="70%"><font size="2"><select size="1" name="pskFormat<% checkWrite("wlan_idx"); %>">
          <% checkWrite("wdsPskFormat"); %>
      </select></font></td>
  </tr>
  <tr>
      <td width="30%"><font size="2"><b><% multilang("171" "LANG_PRE_SHARED_KEY"); %>:</b></font></td>
      <td width="70%"><font size="2"><input type="password" name="pskValue<% checkWrite("wlan_idx"); %>" size="40" maxlength="64" value=<% getInfo("wdsPskValue"); %>>
      </font></td>
  </tr>
  <script>
      form = document.formWdsEncrypt ;
     updateEncryptState(document.formWdsEncrypt);
 defPskLen[wlan_idx] = form.elements["pskValue"+wlan_idx].value.length;
 defPskFormat[wlan_idx] = form.elements["pskFormat"+wlan_idx].selectedIndex;
  </script>
  <tr>
     <td colspan=2 width="100%"><br>
     <input type="hidden" value="/wlwdsenp.asp" name="submit-url">
     <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges(document.formWdsEncrypt)">&nbsp;&nbsp;
     <input type="button" value="<% multilang("644" "LANG_CLOSE"); %>" name="close" OnClick=window.close()>&nbsp;&nbsp;
     <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset">
     <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
     </td>
  </tr>
</table>
</form>
</blockquote>
</body>
</html>

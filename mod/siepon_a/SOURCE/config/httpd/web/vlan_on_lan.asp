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
<title>VLAN on LAN <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function saveClick()
{
 if (document.formVLANonLAN.lan1_vid_cap[1].checked == true) {
  if (document.formVLANonLAN.lan1_vid.value == "") {
   alert("<% multilang("2341" "LANG_VID1_SHOULD_NOT_BE_EMPTY"); %>");
   document.formVLANonLAN.lan1_vid.focus();
   return false;
  }
  if (!isNumber(document.formVLANonLAN.lan1_vid.value)) {
   alert("<% multilang("2342" "LANG_VID1_SHOULD_BE_NUMBER"); %>");
   document.formVLANonLAN.lan1_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan1_vid.value >= 7 && document.formVLANonLAN.lan1_vid.value <= 9) {
   alert("<% multilang("2343" "LANG_VID1_7_9_ARE_RESERVED"); %>");
   document.formVLANonLAN.lan1_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan1_vid.value < 0 || document.formVLANonLAN.lan1_vid.value >= 4096) {
   alert("<% multilang("2344" "LANG_VID1_SHOULD_BE_0_4095"); %>");
   document.formVLANonLAN.lan1_vid.focus();
   return false;
  }
 }
 if (document.formVLANonLAN.lan2_vid_cap[1].checked == true) {
  if (document.formVLANonLAN.lan2_vid.value == "") {
   alert("<% multilang("2345" "LANG_VID2_SHOULD_NOT_BE_EMPTY"); %>");
   document.formVLANonLAN.lan2_vid.focus();
   return false;
  }
  if (!isNumber(document.formVLANonLAN.lan2_vid.value)) {
   alert("<% multilang("2346" "LANG_VID2_SHOULD_BE_NUMBER"); %>");
   document.formVLANonLAN.lan2_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan2_vid.value >= 7 && document.formVLANonLAN.lan2_vid.value <= 9) {
   alert("<% multilang("2347" "LANG_VID2_7_9_ARE_RESERVED"); %>");
   document.formVLANonLAN.lan2_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan2_vid.value < 0 || document.formVLANonLAN.lan2_vid.value >= 4096) {
   alert("<% multilang("2348" "LANG_VID2_SHOULD_BE_0_4095"); %>");
   document.formVLANonLAN.lan2_vid.focus();
   return false;
  }
 }
 if (document.formVLANonLAN.lan3_vid_cap[1].checked == true) {
  if (document.formVLANonLAN.lan3_vid.value == "") {
   alert("<% multilang("2349" "LANG_VID3_SHOULD_NOT_BE_EMPTY"); %>");
   document.formVLANonLAN.lan3_vid.focus();
   return false;
  }
  if (!isNumber(document.formVLANonLAN.lan3_vid.value)) {
   alert("<% multilang("2350" "LANG_VID3_SHOULD_BE_NUMBER"); %>");
   document.formVLANonLAN.lan3_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan3_vid.value >= 7 && document.formVLANonLAN.lan3_vid.value <= 9) {
   alert("<% multilang("2351" "LANG_VID3_7_9_ARE_RESERVED"); %>");
   document.formVLANonLAN.lan3_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan3_vid.value < 0 || document.formVLANonLAN.lan3_vid.value >= 4096) {
   alert("<% multilang("2352" "LANG_VID3_SHOULD_BE_0_4095"); %>");
   document.formVLANonLAN.lan3_vid.focus();
   return false;
  }
 }
 if (document.formVLANonLAN.lan4_vid_cap[1].checked == true) {
  if (document.formVLANonLAN.lan4_vid.value == "") {
   alert("<% multilang("2353" "LANG_VID4_SHOULD_NOT_BE_EMPTY"); %>");
   document.formVLANonLAN.lan4_vid.focus();
   return false;
  }
  if (!isNumber(document.formVLANonLAN.lan4_vid.value)) {
   alert("<% multilang("2354" "LANG_VID4_SHOULD_BE_NUMBER"); %>");
   document.formVLANonLAN.lan4_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan4_vid.value >= 7 && document.formVLANonLAN.lan4_vid.value <= 9) {
   alert("<% multilang("2355" "LANG_VID4_7_9_ARE_RESERVED"); %>");
   document.formVLANonLAN.lan4_vid.focus();
   return false;
  }
  if (document.formVLANonLAN.lan4_vid.value < 0 || document.formVLANonLAN.lan4_vid.value >= 4096) {
   alert("<% multilang("2356" "LANG_VID4_SHOULD_BE_0_4095"); %>");
   document.formVLANonLAN.lan4_vid.focus();
   return false;
  }
 }
 return true;
}
function updateState()
{
 if (document.formVLANonLAN.lan1_vid_cap[1].checked)
  enableTextField(document.formVLANonLAN.lan1_vid);
 else
  disableTextField(document.formVLANonLAN.lan1_vid);
 if (document.formVLANonLAN.lan2_vid_cap[1].checked)
  enableTextField(document.formVLANonLAN.lan2_vid);
 else
  disableTextField(document.formVLANonLAN.lan2_vid);
 if (document.formVLANonLAN.lan3_vid_cap[1].checked)
  enableTextField(document.formVLANonLAN.lan3_vid);
 else
  disableTextField(document.formVLANonLAN.lan3_vid);
 if (document.formVLANonLAN.lan4_vid_cap[1].checked)
  enableTextField(document.formVLANonLAN.lan4_vid);
 else
  disableTextField(document.formVLANonLAN.lan4_vid);
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">VLAN on LAN <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr><td><font size=2>
 <% multilang("353" "LANG_THIS_PAGE_BE_USED_TO_CONFIGURE_VLAN_ON_LAN"); %>
 </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formVLANonLAN method=POST name="formVLANonLAN">
 <table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr>
  <td><font size=2><b>LAN1 <% multilang("217" "LANG_VLAN"); %> <% multilang("602" "LANG_ID"); %>: </b></font></td>
  <td><input type="text" name="lan1_vid" size="10" maxlength="15" value=<% getInfo("lan1-vid"); %>></td>
  <td><font size=2>
  <input type="radio" value="0" name="lan1_vid_cap" <% checkWrite("lan1-vid-cap0"); %> onClick="updateState()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="lan1_vid_cap" <% checkWrite("lan1-vid-cap1"); %> onClick="updateState()"><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
  </font></td>
 </tr>
 <tr>
  <td><font size=2><b>LAN2 <% multilang("217" "LANG_VLAN"); %> <% multilang("602" "LANG_ID"); %>: </b></font></td>
  <td><input type="text" name="lan2_vid" size="10" maxlength="15" value=<% getInfo("lan2-vid"); %>></td>
  <td><font size=2>
  <input type="radio" value="0" name="lan2_vid_cap" <% checkWrite("lan2-vid-cap0"); %> onClick="updateState()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="lan2_vid_cap" <% checkWrite("lan2-vid-cap1"); %> onClick="updateState()"><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
  </font></td>
 </tr>
 <tr>
  <td><font size=2><b>LAN3 <% multilang("217" "LANG_VLAN"); %> <% multilang("602" "LANG_ID"); %>: </b></font></td>
  <td><input type="text" name="lan3_vid" size="10" maxlength="15" value=<% getInfo("lan3-vid"); %>></td>
  <td><font size=2>
  <input type="radio" value="0" name="lan3_vid_cap" <% checkWrite("lan3-vid-cap0"); %> onClick="updateState()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="lan3_vid_cap" <% checkWrite("lan3-vid-cap1"); %> onClick="updateState()"><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
  </font></td>
 </tr>
 <tr>
  <td><font size=2><b>LAN4 <% multilang("217" "LANG_VLAN"); %> <% multilang("602" "LANG_ID"); %>: </b></font></td>
  <td><input type="text" name="lan4_vid" size="10" maxlength="15" value=<% getInfo("lan4-vid"); %>></td>
  <td><font size=2>
  <input type="radio" value="0" name="lan4_vid_cap" <% checkWrite("lan4-vid-cap0"); %> onClick="updateState()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="lan4_vid_cap" <% checkWrite("lan4-vid-cap1"); %> onClick="updateState()"><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
  </font></td>
 </tr>
 </table>
 <br>
 <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveClick()">
 <input type="hidden" value="/vlan_on_lan.asp" name="submit-url">
 <script>updateState();</script>
</form>
</blockquote>
</body>
</html>

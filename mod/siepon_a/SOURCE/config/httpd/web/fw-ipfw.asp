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
<title><% multilang("22" "LANG_NAT_IP_FORWARDING"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function addClick()
{
  if (!document.formIPFwAdd.enabled.checked)
   return true;
  if (document.formIPFwAdd.l_ip.value=="" && document.formIPFwAdd.r_ip.value=="" )
 return true;
  if (document.formIPFwAdd.l_ip.value=="") {
 alert('<% multilang("2081" "LANG_EMPTY_LOCAL_IP_ADDRESS"); %>');
 document.formIPFwAdd.l_ip.focus();
 return false;
  }
  if ( validateKey( document.formIPFwAdd.l_ip.value ) == 0 ) {
 alert('<% multilang("2082" "LANG_INVALID_LOCAL_IP_ADDRESS_VALUE_"); %>');
 document.formIPFwAdd.l_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.l_ip.value,1,0,255) ) {
 alert('<% multilang("2083" "LANG_INVALID_LOCAL_IP_ADDRESS_RANGE_IN_1ST_DIGIT"); %>');
 document.formIPFwAdd.l_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.l_ip.value,2,0,255) ) {
 alert('<% multilang("2084" "LANG_INVALID_LOCAL_IP_ADDRESS_RANGE_IN_2ND_DIGIT"); %>');
 document.formIPFwAdd.l_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.l_ip.value,3,0,255) ) {
 alert('<% multilang("2085" "LANG_INVALID_LOCAL_IP_ADDRESS_RANGE_IN_3RD_DIGIT"); %>');
 document.formIPFwAdd.l_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.l_ip.value,4,1,254) ) {
 alert('<% multilang("2086" "LANG_INVALID_LOCAL_IP_ADDRESS_RANGE_IN_4TH_DIGIT"); %>');
 document.formIPFwAdd.l_ip.focus();
 return false;
  }
  if (document.formIPFwAdd.r_ip.value=="") {
 alert('<% multilang("2087" "LANG_EMPTY_EXTERNAL_IP_ADDRESS"); %>');
 document.formIPFwAdd.r_ip.focus();
 return false;
  }
  if ( validateKey( document.formIPFwAdd.r_ip.value ) == 0 ) {
 alert('<% multilang("2088" "LANG_INVALID_EXTERNAL_IP_ADDRESS_VALUE_"); %>');
 document.formIPFwAdd.r_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.r_ip.value,1,0,255) ) {
 alert('<% multilang("2089" "LANG_INVALID_EXTERNAL_IP_ADDRESS_RANGE_IN_1ST_DIGIT"); %>');
 document.formIPFwAdd.r_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.r_ip.value,2,0,255) ) {
 alert('<% multilang("2090" "LANG_INVALID_EXTERNAL_IP_ADDRESS_RANGE_IN_2ND_DIGIT"); %>');
 document.formIPFwAdd.r_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.r_ip.value,3,0,255) ) {
 alert('<% multilang("2091" "LANG_INVALID_EXTERNAL_IP_ADDRESS_RANGE_IN_3RD_DIGIT"); %>');
 document.formIPFwAdd.r_ip.focus();
 return false;
  }
  if ( !checkDigitRange(document.formIPFwAdd.r_ip.value,4,1,254) ) {
 alert('<% multilang("2092" "LANG_INVALID_EXTERNAL_IP_ADDRESS_RANGE_IN_4TH_DIGIT"); %>');
 document.formIPFwAdd.r_ip.focus();
 return false;
  }
   return true;
}
function disableDelButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.formIPFwDel.delSelEntry);
 disableButton(document.formIPFwDel.delAllEntry);
  }
}
function updateState()
{
  if (document.formIPFwAdd.enabled.checked) {
  enableTextField(document.formIPFwAdd.l_ip);
 enableTextField(document.formIPFwAdd.r_ip);
  }
  else {
  disableTextField(document.formIPFwAdd.l_ip);
 disableTextField(document.formIPFwAdd.r_ip);
  }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("22" "LANG_NAT_IP_FORWARDING"); %></font></h2>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><font size=2>
 <% multilang("542" "LANG_ENTRIES_IN_THIS_TABLE_ALLOW_YOU_TO_AUTOMATICALLY_REDIRECT_TRAFFIC_TO_A_SPECIFIC_MACHINE_BEHIND_THE_NAT_FIREWALL_THESE_SETTINGS_ARE_ONLY_NECESSARY_IF_YOU_WISH_TO_HOST_SOME_SORT_OF_SERVER_LIKE_A_WEB_SERVER_OR_MAIL_SERVER_ON_THE_PRIVATE_LOCAL_NETWORK_BEHIND_YOUR_GATEWAY_S_NAT_FIREWALL"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<form action=/boaform/formIPFw method=POST name="formIPFwAdd">
<tr><td><font size=2><b>
    <input type="checkbox" name="enabled" value="ON" <% checkWrite("ipFwEn"); %>
     ONCLICK=updateState()>&nbsp;&nbsp;<% multilang("207" "LANG_ENABLE"); %> <% multilang("22" "LANG_NAT_IP_FORWARDING"); %></b><br>
    </td>
</tr>
<tr><td>
    <font size=2><b><% multilang("241" "LANG_LOCAL"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>:</b> <input type="text" name="l_ip" size="10" maxlength="15"></td>
</tr>
<tr><td>
    <font size=2><b><% multilang("543" "LANG_EXTERNAL"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>:</b> <input type="text" name="r_ip" size="10" maxlength="15"></td>
</tr>
<tr><td>
  <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="addEntry" onClick="return addClick()">&nbsp;&nbsp;
  <input type="hidden" value="/fw-ipfw.asp" name="submit-url">
</td></tr>
  <script> updateState(); </script>
</form>
</table>
<br>
<form action=/boaform/formIPFw method=POST name="formIPFwDel">
<table border=0 width=500>
  <tr><font size=2><b><% multilang("544" "LANG_CURRENT_NAT_IP_FORWARDING_TABLE"); %>:</b></font></tr>
  <% ipFwList(); %>
</table>
 <br><input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSelEntry" onClick="return deleteClick()">&nbsp;&nbsp;
     <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delAllEntry" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
     <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset">
 <script>
    <% checkWrite("ipFwNum"); %>
 </script>
     <input type="hidden" value="/fw-ipfw.asp" name="submit-url">
</form>
</td></tr></table>
</blockquote>
</body>
</html>

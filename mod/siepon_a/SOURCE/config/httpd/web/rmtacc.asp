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
<title><% multilang("40" "LANG_REMOTE_ACCESS"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function addClick()
{
 dTelnet = getDigit(document.acc.w_telnet_port.value, 1);
 dFtp = getDigit(document.acc.w_ftp_port.value, 1);
 dWeb = getDigit(document.acc.w_web_port.value, 1);
 if (dTelnet == dFtp || dTelnet == dWeb) {
  alert("<% multilang("2272" "LANG_DUPLICATED_PORT_NUMBER"); %>");
  document.acc.w_telnet_port.focus();
  return false;
 }
 if (dFtp == dWeb) {
  alert("<% multilang("2272" "LANG_DUPLICATED_PORT_NUMBER"); %>");
  document.acc.w_ftp_port.focus();
  return false;
 }
 if (document.acc.w_telnet.checked) {
  if (document.acc.w_telnet_port.value=="") {
   alert("<% multilang("2273" "LANG_PORT_RANGE_CANNOT_BE_EMPTY_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>");
   document.acc.w_telnet_port.focus();
   return false;
  }
  if ( validateKey( document.acc.w_telnet_port.value ) == 0 ) {
   alert("<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.acc.w_telnet_port.focus();
   return false;
  }
  //d1 = getDigit(document.acc.w_telnet_port.value, 1);
  //if (d1 > 65535 || d1 < 1) {
  if (dTelnet > 65535 || dTelnet < 1) {
   alert("<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>");
   document.acc.w_telnet_port.focus();
   return false;
  }
  }
 if (document.acc.w_ftp.checked) {
  if (document.acc.w_ftp_port.value=="") {
   alert("<% multilang("2273" "LANG_PORT_RANGE_CANNOT_BE_EMPTY_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>");
   document.acc.w_ftp_port.focus();
   return false;
  }
  if ( validateKey( document.acc.w_ftp_port.value ) == 0 ) {
   alert("<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.acc.w_ftp_port.focus();
   return false;
  }
  //d1 = getDigit(document.acc.w_ftp_port.value, 1);
  //if (d1 > 65535 || d1 < 1) {
  if (dFtp > 65535 || dFtp < 1) {
   alert("<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>");
   document.acc.w_ftp_port.focus();
   return false;
  }
 }
 if (document.acc.w_web.checked) {
  if (document.acc.w_web_port.value=="") {
   alert("<% multilang("2273" "LANG_PORT_RANGE_CANNOT_BE_EMPTY_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>");
   document.acc.w_web_port.focus();
   return false;
  }
  if ( validateKey( document.acc.w_web_port.value ) == 0 ) {
   alert("<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
   document.acc.w_web_port.focus();
   return false;
  }
  //d1 = getDigit(document.acc.w_web_port.value, 1);
  //if (d1 > 65535 || d1 < 1) {
  if (dWeb > 65535 || dWeb < 1) {
   alert("<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>");
   document.acc.w_web_port.focus();
   return false;
  }
 }
 return true;
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("40" "LANG_REMOTE_ACCESS"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<table border=0 width=500 cellspacing=4 cellpadding=0>
<tr><td colspan=4><font size=2>
 <% multilang("375" "LANG_THIS_PAGE_IS_USED_TO_ENABLE_DISABLE_MANAGEMENT_SERVICES_FOR_THE_LAN_AND_WAN"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formSAC method=POST name=acc>
<table border=0 cellpadding=3 cellspacing=0>
<tr>
 <td width=150 align=left><font size=2><b><% multilang("308" "LANG_SERVICE"); %><% multilang("604" "LANG_NAME"); %></b></td>
 <td width=80 align=center><font size=2><b><% multilang("6" "LANG_LAN"); %></b></td>
 <td width=80 align=center><font size=2><b><% multilang("10" "LANG_WAN"); %></b></td>
 <td width=80 align=center><font size=2><b><% multilang("376" "LANG_WAN_PORT"); %></b></td>
</tr>
<% rmtaccItem(); %>
</table>
<br>
<tr>
 <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="set" onClick="return addClick()"></td>
 <td><input type="hidden" value="/rmtacc.asp" name="submit-url"></td>
</tr>
<script>
 <% accPost(); %>
</script>
</form>
</blockquote>
</body>
</html>

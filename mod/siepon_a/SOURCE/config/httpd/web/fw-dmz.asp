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
<title>DMZ <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function skip () { this.blur(); }
function saveClick()
{
//  if (!document.formDMZ.enabled.checked)
  if (document.formDMZ.dmzcap[0].checked)
  return true;
/*  if ( validateKey( document.formDMZ.ip.value ) == 0 ) {
	alert("Invalid IP address value. It should be the decimal number (0-9).");
	document.formDMZ.ip.focus();
	return false;
  }
  if( IsLoopBackIP( document.formDMZ.ip.value)==1 ) {
	alert("Invalid IP address value.");
	document.formDMZ.ip.focus();
	return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,1,0,223) ) {
      	alert('Invalid IP address range in 1st digit. It should be 0-223.');
	document.formDMZ.ip.focus();
	return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,2,0,255) ) {
      	alert('Invalid IP address range in 2nd digit. It should be 0-255.');
	document.formDMZ.ip.focus();
	return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,3,0,255) ) {
      	alert('Invalid IP address range in 3rd digit. It should be 0-255.');
	document.formDMZ.ip.focus();
	return false;
  }
  if ( !checkDigitRange(document.formDMZ.ip.value,4,1,254) ) {
      	alert('Invalid IP address range in 4th digit. It should be 1-254.');
	document.formDMZ.ip.focus();
	return false;
  }*/
  if (!checkHostIP(document.formDMZ.ip, 1))
 return false;
  return true;
}
function updateState()
{
//  if (document.formDMZ.enabled.checked) {
  if (document.formDMZ.dmzcap[1].checked) {
  enableTextField(document.formDMZ.ip);
  }
  else {
  disableTextField(document.formDMZ.ip);
  }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">DMZ <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr><td><font size=2>
 <% multilang("350" "LANG_A_DEMILITARIZED_ZONE_IS_USED_TO_PROVIDE_INTERNET_SERVICES_WITHOUT_SACRIFICING_UNAUTHORIZED_ACCESS_TO_ITS_LOCAL_PRIVATE_NETWORK_TYPICALLY_THE_DMZ_HOST_CONTAINS_DEVICES_ACCESSIBLE_TO_INTERNET_TRAFFIC_SUCH_AS_WEB_HTTP_SERVERS_FTP_SERVERS_SMTP_E_MAIL_SERVERS_AND_DNS_SERVERS"); %>
 </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formDMZ method=POST name="formDMZ">
 <table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr><td><font size=2><b><% multilang("351" "LANG_DMZ_HOST"); %>:</b></td>
       <td><font size=2>
  <input type="radio" value="0" name="dmzcap" <% checkWrite("dmz-cap0"); %> onClick="updateState()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="dmzcap" <% checkWrite("dmz-cap1"); %> onClick="updateState()"><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
       </td>
 </font></td></tr>
 <tr>
  <td><font size=2><b><% multilang("351" "LANG_DMZ_HOST"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>: </b></font></td>
  <td><input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("dmzHost"); %> ></td>
 </tr>
 </table>
 <br>
 <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveClick()">
 <input type="hidden" value="/fw-dmz.asp" name="submit-url">
 <script> updateState(); </script>
</form>
</blockquote>
</body>
</html>

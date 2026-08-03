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
<META HTTP-EQUIV=Refresh CONTENT="30; URL=ddns.asp">
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("301" "LANG_DYNAMIC"); %> DNS <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
selected=0;
function deSelected()
{
 /*
	if (document.ddns.select) {
		var len = document.ddns.select.length;
		if (len == undefined)
			document.ddns.select.checked = false;
		else {
			for (var i=0; i < len; i++)
				document.ddns.select[i].checked = false;
		}
	}
	*/
}
function addClick()
{
 if (document.ddns.hostname.value=="") {
  alert('<% multilang("1978" "LANG_PLEASE_ENTER_HOSTNAME_FOR_THIS_ACCOUNT"); %>');
  document.ddns.hostname.focus();
  deSelected();
  return false;
 }
 if (includeSpace(document.ddns.hostname.value)) {
  alert('<% multilang("1979" "LANG_INVALID_HOST_NAME"); %>');
  document.ddns.hostname.focus();
  return false;
 }
 if (checkString(document.ddns.hostname.value) == 0) {
  alert('<% multilang("1979" "LANG_INVALID_HOST_NAME"); %>');
  document.ddns.hostname.focus();
  return false;
 }
 if (document.ddns.ddnsProv.value=="0") {
  if (document.ddns.username.value=="") {
   alert('<% multilang("1980" "LANG_PLEASE_ENTER_USERNAME_FOR_THIS_ACCOUNT"); %>');
   document.ddns.username.focus();
   deSelected();
   return false;
  }
  if (includeSpace(document.ddns.username.value)) {
   alert('<% multilang("1957" "LANG_INVALID_USER_NAME"); %>');
   document.ddns.username.focus();
   return false;
  }
  if (checkString(document.ddns.username.value) == 0) {
   alert('<% multilang("1957" "LANG_INVALID_USER_NAME"); %>');
   document.ddns.username.focus();
   return false;
  }
  if (document.ddns.password.value=="") {
   alert('<% multilang("1981" "LANG_PLEASE_ENTER_PASSWORD_FOR_THIS_ACCOUNT"); %>');
   document.ddns.password.focus();
   deSelected();
   return false;
  }
    if ( includeSpace(document.ddns.password.value)) {
   alert('<% multilang("1959" "LANG_INVALID_PASSWORD"); %>');
   document.ddns.password.focus();
   return false;
   }
  if (checkString(document.ddns.password.value) == 0) {
   alert('<% multilang("1959" "LANG_INVALID_PASSWORD"); %>');
   document.ddns.password.focus();
   return false;
  }
 }
 if (document.ddns.ddnsProv.value=="1") {
  if (document.ddns.email.value=="") {
   alert('<% multilang("1982" "LANG_PLEASE_ENTER_EMAIL_FOR_THIS_ACCOUNT"); %>');
   document.ddns.email.focus();
   deSelected();
   return false;
  }
  if (includeSpace(document.ddns.email.value)) {
   alert('<% multilang("1983" "LANG_INVALID_EMAIL"); %>');
   document.ddns.email.focus();
   return false;
  }
  if (checkString(document.ddns.email.value) == 0) {
   alert('<% multilang("1983" "LANG_INVALID_EMAIL"); %>');
   document.ddns.email.focus();
   return false;
  }
  if (document.ddns.key.value=="") {
   alert('<% multilang("1984" "LANG_PLEASE_ENTER_KEY_FOR_THIS_ACCOUNT"); %>');
   document.ddns.key.focus();
   deSelected();
          return false;
         }
  if (includeSpace(document.ddns.key.value)) {
   alert('<% multilang("1985" "LANG_INVALID_KEY"); %>');
   document.ddns.key.focus();
   return false;
  }
  if (checkString(document.ddns.key.value) == 0) {
   alert('<% multilang("1985" "LANG_INVALID_KEY"); %>');
   document.ddns.key.focus();
   return false;
  }
 }
 return true;
}
function modifyClick()
{
 if (!selected) {
  alert('<% multilang("1986" "LANG_PLEASE_SELECT_AN_ENTRY_TO_MODIFY"); %>');
  return false;
 }
 return addClick();
}
function removeClick()
{
 if (!selected) {
  alert('<% multilang("1987" "LANG_PLEASE_SELECT_AN_ENTRY_TO_DELETE"); %>');
  return false;
 }
 return true;
}
function updateState()
{
  if (document.ddns.ddnsProv.value=="0") {
  enableTextField(document.ddns.username);
  enableTextField(document.ddns.password);
  disableTextField(document.ddns.email)
  disableTextField(document.ddns.key)
  }
  else {
   enableTextField(document.ddns.email);
   enableTextField(document.ddns.key);
  disableTextField(document.ddns.username);
  disableTextField(document.ddns.password);
  }
}
function postEntry(enabled, pvd, host, user, passwd, intf)
{
 if (enabled)
  document.ddns.enable.checked = true;
 else
  document.ddns.enable.checked = false;
 document.ddns.hostname.value = host;
 if (pvd == 'dyndns') {
  document.ddns.ddnsProv.value = 0;
  document.ddns.username.value = user;
  document.ddns.password.value = passwd;
  document.ddns.email.value = '';
  document.ddns.key.value = '';
  document.ddns.interface.value = intf;
 }
 else {
  document.ddns.ddnsProv.value = 1;
  document.ddns.username.value = '';
  document.ddns.password.value = '';
  document.ddns.email.value = user;
  document.ddns.key.value = passwd;
  document.ddns.interface.value = intf;
 }
 updateState();
 selected = 1;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("301" "LANG_DYNAMIC"); %> DNS <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/admin/formDDNS method=POST name="ddns">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("302" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_DYNAMIC_DNS_ADDRESS_FROM_DYNDNS_ORG_OR_TZO_HERE_YOU_CAN_ADD_REMOVE_TO_CONFIGURE_DYNAMIC_DNS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
      <td width="30%"><font size=2><b><% multilang("207" "LANG_ENABLE"); %>:</b></td>
      <td width="70%"><input type="checkbox" name="enable" value="1" checked></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>DDNS <% multilang("303" "LANG_PROVIDER"); %>:</b></td>
      <td width="70%">
      <select size="1" name="ddnsProv" onChange='updateState()'>
      <option selected value="0">DynDNS.org</option>
      <option value="1">TZO</option>
      </select>
      </td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("304" "LANG_HOSTNAME"); %>:</b></td>
      <td width="70%"><input type="text" name="hostname" size="35" maxlength="35"></td>
  </tr>
  <tr><td width="30%"><font size=2><b><% multilang("52" "LANG_INTERFACE"); %></b></td>
  <td width="35%">
   <select name="interface" >
      <% if_wan_list("rt");
      %>
      <!--<option value=100>LAN/br0</option>-->
   </select>
  </td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><hr size=1 noshade align=top></td></tr>
  <tr><font size=2><b>DynDns <% multilang("305" "LANG_SETTINGS"); %>:</b></font></tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
      <td width="70%"><input type="text" name="username" size="35" maxlength="35"></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("49" "LANG_PASSWORD"); %>:</b></td>
      <td width="70%"><input type="password" name="password" size="35" maxlength="35"></td>
  </tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><hr size=1 noshade align=top></td></tr>
  <tr><font size=2><b>TZO <% multilang("305" "LANG_SETTINGS"); %>:</b></font></tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("306" "LANG_EMAIL"); %>:</b></td>
      <td width="70%"><input type="text" name="email" size="35" maxlength="35"></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("202" "LANG_KEY"); %>:</b></td>
      <td width="70%"><input type="password" name="key" size="35" maxlength="35"></td>
  </tr>
</table>
  <br><br>
  <!--<input type="hidden" name="interface" value="all">-->
  <input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addacc" onClick="return addClick()">
  <input type="submit" value="<% multilang("261" "LANG_MODIFY"); %>" name="modify" onClick="return modifyClick()">
  <input type="submit" value="<% multilang("307" "LANG_REMOVE"); %>" name="delacc" onClick="return removeClick()">
  </tr>
  <br><br>
<table border=0 width="800" cellspacing=4 cellpadding=0>
  <tr><font size=2><b><% multilang("301" "LANG_DYNAMIC"); %> DNS <% multilang("344" "LANG__TABLE"); %>:</b></font></tr>
  <% showDNSTable(); %>
</table>
  <br>
      <input type="hidden" value="/ddns.asp" name="submit-url">
  <script>
 updateState();
 deSelected();
  </script>
</form>
</blockquote>
</body>
</html>

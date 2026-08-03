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
<title>PPTP VPN <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function checkTextStr(str)
{
 for (var i=0; i<str.length; i++)
 {
  if ( str.charAt(i) == '%' || str.charAt(i) =='&' ||str.charAt(i) =='\\' || str.charAt(i) =='?' || str.charAt(i)=='"')
   return false;
 }
 return true;
}
function pptpSelection()
{
 if (document.pptp.pptpen[0].checked) {
  document.pptp.s_auth.disabled = true;
  document.pptp.s_enctype.disabled = true;
  document.pptp.s_name.disabled = true;
  document.pptp.peeraddr.disabled = true;
  document.pptp.localaddr.disabled = true;
  document.pptp.tunnelen.disabled = true;
  document.pptp.s_username.disabled = true;
  document.pptp.s_password.disabled = true;
  document.pptp.delSelAccount.disabled = true;
  document.pptp.saveAccount.disabled = true;
  document.pptp.addServer.disabled = true;
  document.pptp.addAccount.disabled = true;
  document.pptp.c_name.disabled = true;
  document.pptp.c_username.disabled = true;
  document.pptp.c_password.disabled = true;
  document.pptp.c_auth.disabled = true;
  document.pptp.c_enctype.disabled = true;
  document.pptp.defaultgw.disabled = true;
  document.pptp.addClient.disabled = true;
  document.pptp.delSelClient.disabled = true;
 }
 else {
  document.pptp.s_auth.disabled = false;
  document.pptp.s_enctype.disabled = false;
  document.pptp.s_name.disabled = false;
  document.pptp.peeraddr.disabled = false;
  document.pptp.localaddr.disabled = false;
  document.pptp.tunnelen.disabled = false;
  document.pptp.s_username.disabled = false;
  document.pptp.s_password.disabled = false;
  document.pptp.addServer.disabled = false;
  document.pptp.addAccount.disabled = false;
  document.pptp.delSelAccount.disabled = false;
  document.pptp.saveAccount.disabled = false;
  document.pptp.c_name.disabled = false;
  document.pptp.c_username.disabled = false;
  document.pptp.c_password.disabled = false;
  document.pptp.c_auth.disabled = false;
  document.pptp.c_enctype.disabled = false;
  document.pptp.defaultgw.disabled = false;
  document.pptp.addClient.disabled = false;
  document.pptp.delSelClient.disabled = false;
 }
}
function serverEncryClick()
{
 if (document.pptp.s_auth.value==3) {
  document.pptp.s_enctype.disabled = false;
 }else
  document.pptp.s_enctype.disabled = true;
}
function clientEncryClick()
{
 if (document.pptp.c_auth.value==3) {
  document.pptp.c_enctype.disabled = false;
 }else
  document.pptp.c_enctype.disabled = true;
}
function onClickPPtpEnable()
{
 pptpSelection();
 document.pptp.lst.value = "enable";
 document.pptp.submit();
}
function setPptpServer()
{
 if(document.pptp.pptpen[0].checked)
  return false;
 if (document.pptp.peeraddr.value=="") {
  alert("<% multilang("2158" "LANG_PLEASE_ENTER_PEER_START_ADDRESS"); %>");
  document.pptp.peeraddr.focus();
  return false;
 }
 if (!checkHostIP(document.pptp.peeraddr, 0))
  return false;
 if (document.pptp.localaddr.value=="") {
  alert("<% multilang("2159" "LANG_PLEASE_ENTER_LOCAL_ADDRESS"); %>");
  document.pptp.localaddr.focus();
  return false;
 }
 if (!checkHostIP(document.pptp.localaddr, 0))
  return false;
 return true;
}
function addPptpAccount()
{
 if(document.pptp.pptpen[0].checked)
  return false;
 if (document.pptp.s_name.value=="") {
  alert("<% multilang("2241" "LANG_PLEASE_ENTER_PPTP_SERVER_RULE_NAME"); %>");
  document.pptp.c_name.focus();
  return false;
 }
 if (document.pptp.s_username.value=="")
 {
  alert("<% multilang("2242" "LANG_PLEASE_ENTER_PPTP_SERVER_USERNAME"); %>");
  document.pptp.s_username.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.s_username.value))
 {
  alert("<% multilang("2150" "LANG_INVALID_VALUE_IN_USERNAME"); %>");
  document.pptp.s_username.focus();
  return false;
 }
 if (document.pptp.s_password.value=="") {
  alert("<% multilang("2243" "LANG_PLEASE_ENTER_PPTP_SERVER_PASSWORD"); %>");
  document.pptp.s_password.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.s_password.value))
 {
  alert("<% multilang("2152" "LANG_INVALID_VALUE_IN_PASSWORD"); %>");
  document.pptp.s_password.focus();
  return false;
 }
 return true;
}
function addPptpClient()
{
 if(document.pptp.pptpen[0].checked)
  return false;
 if (document.pptp.c_name.value=="") {
  alert("<% multilang("2244" "LANG_PLEASE_ENTER_PPTP_CLIENT_RULE_NAME"); %>");
  document.pptp.c_name.focus();
  return false;
 }
 if (document.pptp.c_addr.value=="") {
  alert("<% multilang("2238" "LANG_PLEASE_ENTER_PPTP_SERVER_ADDRESS"); %>");
  document.pptp.c_addr.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.c_addr.value))
 {
  alert("<% multilang("2146" "LANG_INVALID_VALUE_IN_SERVER_ADDRESS"); %>");
  document.pptp.c_addr.focus();
  return false;
 }
 if (document.pptp.c_username.value=="")
 {
  alert("<% multilang("2239" "LANG_PLEASE_ENTER_PPTP_CLIENT_USERNAME"); %>");
  document.pptp.c_username.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.c_username.value))
 {
  alert("<% multilang("2150" "LANG_INVALID_VALUE_IN_USERNAME"); %>");
  document.pptp.c_username.focus();
  return false;
 }
 if (document.pptp.c_password.value=="") {
  alert("<% multilang("2240" "LANG_PLEASE_ENTER_PPTP_CLIENT_PASSWORD"); %>");
  document.pptp.c_password.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.c_password.value))
 {
  alert("<% multilang("2152" "LANG_INVALID_VALUE_IN_PASSWORD"); %>");
  document.pptp.c_password.focus();
  return false;
 }
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">PPTP VPN <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formPPtP method=POST name="pptp">
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr><font size=2>
    <% multilang("613" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_PPTP_MODE_VPN"); %>
  </tr>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
      <td width="120" style="font-size:16px"><b>PPTP VPN:</b></td>
      <td width="480"><font size=2>
       <input type="radio" value="0" name="pptpen" <% checkWrite("pptpenable0"); %> onClick="onClickPPtpEnable()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="pptpen" <% checkWrite("pptpenable1"); %> onClick="onClickPPtpEnable()"><% multilang("207" "LANG_ENABLE"); %>
      </td>
  </tr>
</table>
<input type="hidden" id="lst" name="lst" value="">
<br>
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
    <th align=left colspan=5 style="font-size:16px"><b>PPTP Server</b></th>
  </tr>
  <tr>
    <td rowspan=3 width="20"></td>
    <td width="100" style="font-size:12px">Auth. Type:</td>
    <td width="190">
      <select name="s_auth" onClick="serverEncryClick()">
      <option value="0">Auto</option>
      <option value="1">PAP</option>
      <option value="2">CHAP</option>
      <option value="3">MS-CHAPV2</option>
      </select>
    </td>
    <td width="100" style="font-size:12px">Encryption Mode:</td>
    <td width="190">
      <select name="s_enctype" >
      <option value="0"><% multilang("276" "LANG_NONE"); %></option>
      <option value="1">MPPE</option>
      <option value="2">MPPC</option>
      <option value="3">MPPE&MPPC</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Peer Address:</td>
    <td width="190" style="font-size:12px">start from:<input type="text" name="peeraddr" size="16" maxlength="80"></td>
    <td width="100" style="font-size:12px">Local Address:</td>
    <td width="190"><input type="text" name="localaddr" size="16" maxlength="80"></td>
  </tr>
  <tr>
    <td colspan=4>
      <input type="submit" value="Apply" name="addServer" onClick="return setPptpServer()">
    </td>
  </tr>
</table>
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr>
    <th align=left colspan=5 style="font-size:14px"><b>Server Account</b></th>
  </tr>
  <tr>
    <td rowspan=3 width="20"></td>
    <td width="100" style="font-size:12px">Name:</td>
    <td width="190"><input type="text" name="s_name" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px">Tunnel:</td>
    <td width="190" style="font-size:12px">
      <input type="radio" value="0" name="tunnelen"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="tunnelen" checked><% multilang("207" "LANG_ENABLE"); %>
    </td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Username:</td>
    <td width="190"><input type="text" name="s_username" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px">Password:</td>
    <td width="190"><input type="text" name="s_password" size="16" maxlength="256"></td>
  </tr>
  <tr>
    <td colspan=4>
      <input type="submit" value="Add" name="addAccount" onClick="return addPptpAccount()">
    </td>
  </tr>
</table>
<table border=0 width="600" cellspacing=4 cellpadding=0>
  <tr><th align=left colspan=5 style="font-size:14px"><b>PPTP Server Table:</b></th></tr>
  <tr>
    <td align=center width="3%" bgcolor="#808080"><font size=2><% multilang("185" "LANG_SELECT"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("604" "LANG_NAME"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("207" "LANG_ENABLE"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("1053" "LANG_USERNAME"); %></font></td>
    <td align=center width="8%" bgcolor="#808080"><font size=2><% multilang("49" "LANG_PASSWORD"); %></font></td>
  </tr>
 <% pptpServerList(); %>
</table>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSelAccount">&nbsp;&nbsp;
<input type="submit" value="<% multilang("758" "LANG_SAVE"); %>" name="saveAccount">
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
    <th align=left colspan=5 style="font-size:16px"><b>PPTP Client</b></th>
  </tr>
  <tr>
    <td rowspan=5 width="20"></td>
    <td width="100" style="font-size:12px">Name:</td>
    <td width="190"><input type="text" name="c_name" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px">Server Address:</td>
    <td width="190"><input type="text" name="c_addr" size="16" maxlength="256"></td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Username:</td>
    <td width="190"><input type="text" name="c_username" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px">Password:</td>
    <td width="190"><input type="text" name="c_password" size="16" maxlength="256"></td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Auth. Type:</td>
    <td width="190">
      <select name="c_auth" onClick="clientEncryClick()">
      <option value="0">Auto</option>
      <option value="1">PAP</option>
      <option value="2">CHAP</option>
      <option value="3">MS-CHAPV2</option>
      </select>
    </td>
    <td width="100" style="font-size:12px">Encryption Mode:</td>
    <td width="190">
      <select name="c_enctype" >
      <option value="0"><% multilang("276" "LANG_NONE"); %></option>
      <option value="1">MPPE</option>
      <option value="2">MPPC</option>
      <option value="3">MPPE&MPPC</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px"><b>Default Gateway:</b></td>
    <td colspan=3><input type="checkbox" name="defaultgw"></td>
  </tr>
  <tr>
    <td colspan=4>
      <input type="submit" value="Add" name="addClient" onClick="return addPptpClient()">
    </td>
  </tr>
</table>
<table border=0 width="600" cellspacing=4 cellpadding=0>
  <tr><th align=left colspan=4 style="font-size:14px"><b>PPTP Client Table:</b></th></tr>
  <tr>
    <td align=center width="3%" bgcolor="#808080"><font size=2><% multilang("185" "LANG_SELECT"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("52" "LANG_INTERFACE"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("71" "LANG_SERVER"); %></font></td>
    <td align=center width="8%" bgcolor="#808080"><font size=2><% multilang("614" "LANG_ACTION"); %></font></td>
  </tr>
 <% pptpList(); %>
</table>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSelClient">&nbsp;&nbsp;
<input type="hidden" value="/pptpd.asp" name="submit-url">
<script>
 <% initPage("pptp"); %>
 pptpSelection();
</script>
</form>
</blockquote>
</body>
</html>

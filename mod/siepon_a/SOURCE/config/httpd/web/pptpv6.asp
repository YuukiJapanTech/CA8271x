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
  document.pptp.IpProtocolType.disabled = true;
  document.pptp.server.disabled = true;
  document.pptp.username.disabled = true;
  document.pptp.password.disabled = true;
  document.pptp.auth.disabled = true;
  document.pptp.defaultgw.disabled = true;
  document.pptp.addPPtP.disabled = true;
  document.pptp.enctype.disabled = true;
 }
 else {
  document.pptp.IpProtocolType.disabled = false;
  document.pptp.server.disabled = false;
  document.pptp.username.disabled = false;
  document.pptp.password.disabled = false;
  document.pptp.auth.disabled = false;
  document.pptp.defaultgw.disabled = false;
  document.pptp.addPPtP.disabled = false;
  document.pptp.enctype.disabled = true;
 }
}
function encryClick()
{
 if (document.pptp.auth.value==3) {
  document.pptp.enctype.disabled = false;
 }else
  document.pptp.enctype.disabled = true;
}
function onClickPPtpEnable()
{
 pptpSelection();
 document.pptp.lst.value = "enable";
 document.pptp.submit();
}
function addPPtPItf()
{
 if(document.pptp.pptpen[0].checked)
  return false;
 if (document.pptp.server.value=="") {
  alert("<% multilang("2238" "LANG_PLEASE_ENTER_PPTP_SERVER_ADDRESS"); %>");
  document.pptp.server.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.server.value))
 {
  alert("<% multilang("2146" "LANG_INVALID_VALUE_IN_SERVER_ADDRESS"); %>");
  document.pptp.server.focus();
  return false;
 }
 if (document.pptp.username.value=="")
 {
  alert("<% multilang("2239" "LANG_PLEASE_ENTER_PPTP_CLIENT_USERNAME"); %>");
  document.pptp.username.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.username.value))
 {
  alert("<% multilang("2150" "LANG_INVALID_VALUE_IN_USERNAME"); %>");
  document.pptp.username.focus();
  return false;
 }
 if (document.pptp.password.value=="") {
  alert("<% multilang("2240" "LANG_PLEASE_ENTER_PPTP_CLIENT_PASSWORD"); %>");
  document.pptp.password.focus();
  return false;
 }
 if(!checkTextStr(document.pptp.password.value))
 {
  alert("<% multilang("2152" "LANG_INVALID_VALUE_IN_PASSWORD"); %>");
  document.pptp.password.focus();
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
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><font size=2>
    <% multilang("613" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_PPTP_MODE_VPN"); %>
  </tr>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
      <td width="30%"><font size=2><b>PPTP VPN:</b></td>
      <td width="70%"><font size=2>
       <input type="radio" value="0" name="pptpen" <% checkWrite("pptpenable0"); %> onClick="onClickPPtpEnable()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="pptpen" <% checkWrite("pptpenable1"); %> onClick="onClickPPtpEnable()"><% multilang("207" "LANG_ENABLE"); %>
      </td>
  </tr>
</table>
<input type="hidden" id="lst" name="lst" value="">
<br>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr>
    <td width="40%"><font size=2><b>IP <% multilang("75" "LANG_PROTOCOL"); %>:</b></td>
    <td width="60%"><select id="IpProtocolType" style="WIDTH: 130px" onChange="protocolChange()" name="IpProtocolType">
      <option value="1" > IPv4</option>
      <option value="2" > IPv6</option>
 </select></td>
  </tr>
  <tr>
    <td width="30%"><font size=2><b><% multilang("71" "LANG_SERVER"); %>:</b></td>
    <td width="70%"><input type="text" name="server" size="32" maxlength="256"></td>
  </tr>
  <tr>
    <td width="30%"><font size=2></b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
    <td width="70%"><input type="text" name="username" size="15" maxlength="35"></td>
  </tr>
  <tr>
    <td width="30%"><font size=2></b><% multilang("49" "LANG_PASSWORD"); %>:</b></td>
    <td width="70%"><input type="text" name="password" size="15" maxlength="35"></td>
  </tr>
  <tr>
    <td width="30%"><font size=2></b><% multilang("161" "LANG_AUTHENTICATION"); %>:</b></td>
    <td width="70%"><select name="auth" onClick="encryClick()">
      <option value="0"><% multilang("136" "LANG_AUTO"); %></option>
      <option value="1">PAP</option>
      <option value="2">CHAP</option>
      <option value="3">CHAPMSV2</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="30%"><font size=2></b><% multilang("160" "LANG_ENCRYPTION"); %>:</b></td>
    <td width="70%"><select name="enctype" >
      <option value="0"><% multilang("276" "LANG_NONE"); %></option>
      <option value="1">MPPE</option>
      <option value="2">MPPC</option>
      <option value="3">MPPE&MPPC</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="30%"><font size=2><b><% multilang("65" "LANG_DEFAULT_GATEWAY"); %>:</b></td>
    <td width="70%"><input type="checkbox" name="defaultgw"></td>
  </tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  </tr>
      <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="addPPtP" onClick="return addPPtPItf()">&nbsp;&nbsp;</td>
  </tr>
</table>
<br><br>
<table border=0 width="600" cellspacing=4 cellpadding=0>
  <tr><font size=2><b>PPTP <% multilang("260" "LANG_TABLE"); %>:</b></font></tr>
  <tr>
    <td align=center width="3%" bgcolor="#808080"><font size=2><% multilang("185" "LANG_SELECT"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("52" "LANG_INTERFACE"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("71" "LANG_SERVER"); %></font></td>
    <td align=center width="8%" bgcolor="#808080"><font size=2><% multilang("614" "LANG_ACTION"); %></font></td>
  </tr>
 <% pptpList(); %>
</table>
<br>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSel" onClick="return deleteClick()">&nbsp;&nbsp;
<input type="hidden" value="/pptpv6.asp" name="submit-url">
<script>
 pptpSelection();
</script>
</form>
</blockquote>
</body>
</html>

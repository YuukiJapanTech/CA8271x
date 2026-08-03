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
<title>L2TP VPN <% multilang("197" "LANG_CONFIGURATION"); %></title>
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
function pppAuthChange()
{
 if (document.l2tp.auth.selectedIndex==3)
 {
  document.l2tp.enctype.disabled = false;
 }
 else
 {
  document.l2tp.enctype.disabled = true;
 }
}
function tunnelAuthChange()
{
 if (document.l2tp.tunnel_auth.checked)
  document.l2tp.tunnel_secret.disabled = false;
 else
  document.l2tp.tunnel_secret.disabled = true;
}
function connTypeChange()
{
 if(document.l2tp.pppconntype.selectedIndex==1)
 {
  document.l2tp.idletime.disabled=false;
 }else{
  document.l2tp.idletime.disabled=true;
 }
}
function l2tpSelection()
{
 if (document.l2tp.l2tpen[0].checked) {
  document.l2tp.IpProtocolType.disabled = true;
  document.l2tp.server.disabled = true;
  document.l2tp.tunnel_auth.disabled = true;
  document.l2tp.tunnel_secret.disabled = true;
  document.l2tp.auth.disabled = true;
  document.l2tp.username.disabled = true;
  document.l2tp.password.disabled = true;
  document.l2tp.pppconntype.disabled = true;
  document.l2tp.idletime.disabled = true;
  document.l2tp.mtu.disabled = true;
  document.l2tp.defaultgw.disabled = true;
  document.l2tp.addL2TP.disabled = true;
  document.l2tp.enctype.disabled = true;
 }
 else {
  document.l2tp.IpProtocolType.disabled = false;
  document.l2tp.server.disabled = false;
  document.l2tp.tunnel_auth.disabled = false;
  document.l2tp.tunnel_secret.disabled = false;
  document.l2tp.auth.disabled = false;
  document.l2tp.username.disabled = false;
  document.l2tp.password.disabled = false;
  document.l2tp.pppconntype.disabled = false;
  document.l2tp.idletime.disabled = false;
  document.l2tp.mtu.disabled = false;
  document.l2tp.defaultgw.disabled = false;
  document.l2tp.addL2TP.disabled = false;
  document.l2tp.enctype.disabled = false;
 }
 tunnelAuthChange();
 pppAuthChange();
 connTypeChange()
}
function onClickL2TPEnable()
{
 l2tpSelection();
 if (document.l2tp.l2tpen[0].checked)
  document.l2tp.lst.value = "disable";
 else
  document.l2tp.lst.value = "enable";
 document.l2tp.submit();
}
function addL2TPItf()
{
 if(document.l2tp.l2tpen[0].checked)
  return false;
 if (document.l2tp.server.value=="") {
  alert('<% multilang("2145" "LANG_PLEASE_ENTER_L2TP_SERVER_ADDRESS"); %>');
  document.l2tp.server.focus();
  return false;
 }
 if (document.l2tp.IpProtocolType.value == 2)
 {
  if (! isGlobalIpv6Address( document.l2tp.server.value) )
  {
   alert('<% multilang("2166" "LANG_PLEASE_INPUT_IPV6_ADDRESS"); %>');
   document.l2tp.server.focus();
   return false;
  }
 }
 else if (document.l2tp.IpProtocolType.value == 1)
 {
  if (!checkTextStr(document.l2tp.server.value))
  {
   alert('<% multilang("2167" "LANG_PLEASE_INPUT_IPV4_ADDRESS"); %>');
   document.l2tp.server.focus();
   return false;
  }
 }
 if (document.l2tp.tunnel_auth.checked)
 {
  if (document.l2tp.tunnel_secret.value=="")
  {
   alert('<% multilang("2147" "LANG_PLEASE_ENTER_L2TP_TUNNEL_AUTHENTICATION_SECRET"); %>');
   document.l2tp.tunnel_secret.focus();
   return false;
  }
  if(!checkTextStr(document.l2tp.tunnel_secret.value))
  {
   alert('<% multilang("2148" "LANG_INVALID_VALUE_IN_TUNNEL_AUTHENTICATION_SECRET"); %>');
   document.l2tp.tunnel_secret.focus();
   return false;
  }
 }
 if (document.l2tp.auth.selectedIndex!=3)
 {
  if (document.l2tp.username.value=="")
  {
   alert('<% multilang("2149" "LANG_PLEASE_ENTER_L2TP_CLIENT_USERNAME"); %>');
   document.l2tp.username.focus();
   return false;
  }
  if(!checkTextStr(document.l2tp.username.value))
  {
   alert('<% multilang("2150" "LANG_INVALID_VALUE_IN_USERNAME"); %>');
   document.l2tp.username.focus();
   return false;
  }
  if (document.l2tp.password.value=="") {
   alert('<% multilang("2151" "LANG_PLEASE_ENTER_L2TP_CLIENT_PASSWORD"); %>');
   document.l2tp.password.focus();
   return false;
  }
  if(!checkTextStr(document.l2tp.password.value))
  {
   alert('<% multilang("2152" "LANG_INVALID_VALUE_IN_PASSWORD"); %>');
   document.l2tp.password.focus();
   return false;
  }
 }
 if (document.l2tp.pppconntype.selectedIndex==1)
 {
  if (document.l2tp.idletime.value=="")
  {
   alert('<% multilang("2153" "LANG_PLEASE_ENTER_L2TP_TUNNEL_IDLE_TIME"); %>');
   document.l2tp.idletime.focus();
   return false;
  }
 }
 if (document.l2tp.mtu.value=="")
 {
  alert('<% multilang("2155" "LANG_PLEASE_ENTER_L2TP_TUNNEL_MTU"); %>');
  document.l2tp.mtu.focus();
  return false;
 }
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">L2TP VPN <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formL2TP method=POST name="l2tp">
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><font size=2>
    <% multilang("615" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_L2TP_MODE_VPN"); %>
  </tr>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
      <td width="40%"><font size=2><b>L2TP VPN:</b></td>
      <td width="60%"><font size=2>
       <input type="radio" value="0" name="l2tpen" <% checkWrite("l2tpenable0"); %> onClick="onClickL2TPEnable()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="l2tpen" <% checkWrite("l2tpenable1"); %> onClick="onClickL2TPEnable()"><% multilang("207" "LANG_ENABLE"); %>
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
    <td width="40%"><font size=2><b><% multilang("71" "LANG_SERVER"); %>:</b></td>
    <td width="60%"><input type="text" name="server" size="32" maxlength="256"></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b><% multilang("616" "LANG_TUNNEL_AUTHENTICATION"); %>:</b></td>
    <td width="60%"><input type=checkbox name="tunnel_auth" value=1 onClick=tunnelAuthChange()></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b><% multilang("617" "LANG_TUNNEL_AUTHENTICATION_SECRET"); %>:</b></td>
    <td width="60%"><input type="text" name="tunnel_secret" size="15" maxlength="35"></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b>PPP <% multilang("161" "LANG_AUTHENTICATION"); %>:</b></td>
    <td width="60%"><select name="auth" onChange="pppAuthChange()">
      <option value="0"><% multilang("136" "LANG_AUTO"); %></option>
      <option value="1">PAP</option>
      <option value="2">CHAP</option>
      <option value="3">CHAPMSV2</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="30%"><font size=2></b>PPP <% multilang("160" "LANG_ENCRYPTION"); %>:</b></td>
    <td width="70%"><select name="enctype" >
      <option value="0"><% multilang("276" "LANG_NONE"); %></option>
      <option value="1">MPPE</option>
      <option value="2">MPPC</option>
      <option value="3">MPPE&MPPC</option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
    <td width="60%"><input type="text" name="username" size="15" maxlength="35"></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b><% multilang("49" "LANG_PASSWORD"); %>:</b></td>
    <td width="60%"><input type="text" name="password" size="15" maxlength="35"></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b>PPP <% multilang("215" "LANG_CONNECTION_TYPE"); %>:</b></td>
    <td width="60%"><select name="pppconntype" onChange="connTypeChange()">
      <option value="0"><% multilang("618" "LANG_PERSISTENT"); %></option>
      <option value="1"><% multilang("619" "LANG_DIAL_ON_DEMAND"); %></option>
      <option value="2"><% multilang("391" "LANG_MANUAL"); %></option>
      <option value="3"><% multilang("276" "LANG_NONE"); %></option>
      </select>
    </td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b><% multilang("273" "LANG_IDLE_TIME_MIN"); %>:</b></td>
    <td width="60%"><input type="text" name="idletime" size="32" maxlength="256"></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b>MTU:</b></td>
    <td width="60%"><input type="text" name="mtu" size="32" maxlength="256" value="1458"></td>
  </tr>
  <tr>
    <td width="40%"><font size=2><b><% multilang("65" "LANG_DEFAULT_GATEWAY"); %>:</b></td>
    <td width="60%"><input type="checkbox" name="defaultgw"></td>
  </tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  </tr>
      <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="addL2TP" onClick="return addL2TPItf()">&nbsp;&nbsp;</td>
  </tr>
</table>
<br><br>
<table border=0 width="600" cellspacing=4 cellpadding=0>
  <tr><font size=2><b>L2TP <% multilang("260" "LANG_TABLE"); %>:</b></font></tr>
  <tr>
    <td align=center width="3%" bgcolor="#808080"><font size=2><% multilang("185" "LANG_SELECT"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("52" "LANG_INTERFACE"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("71" "LANG_SERVER"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("616" "LANG_TUNNEL_AUTHENTICATION"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2>PPP <% multilang("161" "LANG_AUTHENTICATION"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2>MTU</font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("65" "LANG_DEFAULT_GATEWAY"); %></font></td>
    <td align=center width="8%" bgcolor="#808080"><font size=2><% multilang("614" "LANG_ACTION"); %></font></td>
  </tr>
 <% l2tpList(); %>
</table>
<br>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSel" onClick="return deleteClick()">&nbsp;&nbsp;
<input type="hidden" value="/l2tpv6.asp" name="submit-url">
<script>
 l2tpSelection();
</script>
</form>
</blockquote>
</body>
</html>

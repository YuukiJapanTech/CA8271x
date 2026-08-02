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
function checkTextStr(obj)
{
 if(obj.value.length > 30){
  alert('<% multilang("2156" "LANG_LENGTH_SHOULD_LESS_THEN_32"); %>');
  obj.focus();
  return false;
 }
 for (var i=0; i<obj.value.length; i++)
 {
  if ( obj.value.charAt(i) == '%' || obj.value.charAt(i) =='&' ||obj.value.charAt(i) =='\\' || obj.value.charAt(i) =='?' || obj.value.charAt(i)=='"')
  {
   alert('<% multilang("2157" "LANG_INVALID_CHARACTER_IN_TEXT_AERA"); %>');
   obj.focus();
   return false;
  }
 }
 return true;
}
function l2tpSelection()
{
 if (document.l2tp.l2tpen[0].checked) {
  document.l2tp.s_auth.disabled = true;
  document.l2tp.s_enctype.disabled = true;
  document.l2tp.peeraddr.disabled = true;
  document.l2tp.localaddr.disabled = true;
  document.l2tp.addServer.disabled = true;
  document.l2tp.s_name.disabled = true;
  document.l2tp.tunnelen.disabled = true;
  document.l2tp.s_tunnelAuth.disabled = true;
  document.l2tp.s_authKey.disabled = true;
  document.l2tp.s_username.disabled = true;
  document.l2tp.s_password.disabled = true;
  document.l2tp.addAccount.disabled = true;
  document.l2tp.delSelAccount.disabled = true;
  document.l2tp.saveAccount.disabled = true;
  document.l2tp.c_name.disabled = true;
  document.l2tp.server.disabled = true;
  document.l2tp.username.disabled = true;
  document.l2tp.password.disabled = true;
  document.l2tp.tunnel_auth.disabled = true;
  document.l2tp.tunnel_secret.disabled = true;
  document.l2tp.auth.disabled = true;
  document.l2tp.enctype.disabled = true;
  document.l2tp.pppconntype.disabled = true;
  document.l2tp.idleTime.disabled = true;
  document.l2tp.mtu.disabled = true;
  document.l2tp.defaultgw.disabled = true;
  document.l2tp.addClient.disabled = true;
  document.l2tp.delSelClient.disabled = true;
 }
 else {
  document.l2tp.s_auth.disabled = false;
  document.l2tp.s_enctype.disabled = false;
  document.l2tp.peeraddr.disabled = false;
  document.l2tp.localaddr.disabled = false;
  document.l2tp.addServer.disabled = false;
  document.l2tp.s_name.disabled = false;
  document.l2tp.tunnelen.disabled = false;
  document.l2tp.s_tunnelAuth.disabled = false;
  document.l2tp.s_authKey.disabled = false;
  document.l2tp.s_username.disabled = false;
  document.l2tp.s_password.disabled = false;
  document.l2tp.addAccount.disabled = false;
  document.l2tp.delSelAccount.disabled = false;
  document.l2tp.saveAccount.disabled = false;
  document.l2tp.c_name.disabled = false;
  document.l2tp.server.disabled = false;
  document.l2tp.username.disabled = false;
  document.l2tp.password.disabled = false;
  document.l2tp.tunnel_auth.disabled = false;
  document.l2tp.tunnel_secret.disabled = true;
  document.l2tp.auth.disabled = false;
  document.l2tp.enctype.disabled = false;
  document.l2tp.pppconntype.disabled = false;
  document.l2tp.idleTime.disabled = false;
  document.l2tp.mtu.disabled = false;
  document.l2tp.defaultgw.disabled = false;
  document.l2tp.addClient.disabled = false;
  document.l2tp.delSelClient.disabled = false;
 }
}
function serverAuthClick()
{
 if (document.l2tp.s_auth.value==3) {
  document.l2tp.s_enctype.disabled = false;
 }else
  document.l2tp.s_enctype.disabled = true;
}
function clientAuthClick()
{
 if (document.l2tp.auth.value==3) {
  document.l2tp.enctype.disabled = false;
 }else
  document.l2tp.enctype.disabled = true;
}
function connTypeChange()
{
 document.l2tp.defaultgw.checked = false;
 document.l2tp.defaultgw.disabled = false;
 if(document.l2tp.pppconntype.selectedIndex==1)
 {
  document.l2tp.idletime.disabled=false;
  document.l2tp.defaultgw.checked = true;
  document.l2tp.defaultgw.disabled = true;
 }else{
  document.l2tp.idletime.disabled=true;
 }
}
function onClickL2tpEnable()
{
 l2tpSelection();
 document.l2tp.lst.value = "enable";
 document.l2tp.submit();
}
function onClickServerTunnelAuth()
{
 if(document.l2tp.s_tunnelAuth.checked)
  document.l2tp.s_authKey.disabled = false;
 else
  document.l2tp.s_authKey.disabled = true;
}
function onClickClientTunnelAuth()
{
 if(document.l2tp.tunnel_auth.checked)
  document.l2tp.tunnel_secret.disabled = false;
 else
  document.l2tp.tunnel_secret.disabled = true;
}
function setL2tpServer()
{
 if(document.l2tp.l2tpen[0].checked)
  return false;
 if (document.l2tp.peeraddr.value=="") {
  alert('<% multilang("2158" "LANG_PLEASE_ENTER_PEER_START_ADDRESS"); %>');
  document.l2tp.peeraddr.focus();
  return false;
 }
 if (!checkHostIP(document.l2tp.peeraddr, 0))
  return false;
 if (document.l2tp.localaddr.value=="") {
  alert('<% multilang("2159" "LANG_PLEASE_ENTER_LOCAL_ADDRESS"); %>');
  document.l2tp.localaddr.focus();
  return false;
 }
 if (!checkHostIP(document.l2tp.localaddr, 0))
  return false;
 return true;
}
function addL2tpAccount()
{
 if(document.l2tp.l2tpen[0].checked)
  return false;
 if (document.l2tp.s_name.value=="") {
  alert('<% multilang("2160" "LANG_PLEASE_ENTER_L2TP_SERVER_RULE_NAME"); %>');
  document.l2tp.s_name.focus();
  return false;
 }
 if(document.l2tp.s_tunnelAuth.checked){
  if(document.l2tp.s_authKey.value ==""){
   alert('<% multilang("2161" "LANG_PLEASE_ENTER_L2TP_TUNNEL_AUTHKEY"); %>');
   document.l2tp.s_authKey.focus();
   return false;
  }
  if(!checkTextStr(document.l2tp.s_authKey))
  {
   return false;
  }
 }
 if (document.l2tp.s_username.value=="")
 {
  alert('<% multilang("2162" "LANG_PLEASE_ENTER_L2TP_SERVER_USERNAME"); %>');
  document.l2tp.s_username.focus();
  return false;
 }
 if(!checkTextStr(document.l2tp.s_username))
 {
  return false;
 }
 if (document.l2tp.s_password.value=="") {
  alert('<% multilang("2163" "LANG_PLEASE_ENTER_L2TP_SERVER_PASSWORD"); %>');
  document.l2tp.s_password.focus();
  return false;
 }
 if(!checkTextStr(document.l2tp.s_password))
 {
  return false;
 }
 return true;
}
function addL2tpClient()
{
 if(document.l2tp.l2tpen[0].checked)
  return false;
 if (document.l2tp.c_name.value=="") {
  alert('<% multilang("2164" "LANG_PLEASE_ENTER_L2TP_CLIENT_RULE_NAME"); %>');
  document.l2tp.c_name.focus();
  return false;
 }
 if (document.l2tp.server.value=="") {
  alert('<% multilang("2145" "LANG_PLEASE_ENTER_L2TP_SERVER_ADDRESS"); %>');
  document.l2tp.server.focus();
  return false;
 }
 if(!checkTextStr(document.l2tp.server))
 {
  return false;
 }
 if (document.l2tp.username.value=="")
 {
  alert('<% multilang("2149" "LANG_PLEASE_ENTER_L2TP_CLIENT_USERNAME"); %>');
  document.l2tp.username.focus();
  return false;
 }
 if(!checkTextStr(document.l2tp.username))
 {
  return false;
 }
 if (document.l2tp.password.value=="") {
  alert('<% multilang("2151" "LANG_PLEASE_ENTER_L2TP_CLIENT_PASSWORD"); %>');
  document.l2tp.password.focus();
  return false;
 }
 if(!checkTextStr(document.l2tp.password))
 {
  return false;
 }
 if(document.l2tp.tunnel_auth.checked){
  if(document.l2tp.tunnel_secret.value ==""){
   alert('<% multilang("2161" "LANG_PLEASE_ENTER_L2TP_TUNNEL_AUTHKEY"); %>');
   document.l2tp.tunnel_secret.focus();
   return false;
  }
  if(!checkTextStr(document.l2tp.tunnel_secret))
  {
   return false;
  }
 }
 if (document.l2tp.mtu.value=="") {
  alert('<% multilang("2165" "LANG_PLEASE_ENTER_L2TP_CLIENT_MTU"); %>');
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
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr><font size=2>
    <% multilang("615" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_L2TP_MODE_VPN"); %>
  </tr>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
      <td width="120" style="font-size:16px"><b>L2TP VPN:</b></td>
      <td width="480"><font size=2>
       <input type="radio" value="0" name="l2tpen" <% checkWrite("l2tpenable0"); %> onClick="onClickL2tpEnable()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="l2tpen" <% checkWrite("l2tpenable1"); %> onClick="onClickL2tpEnable()"><% multilang("207" "LANG_ENABLE"); %>
      </td>
  </tr>
</table>
<input type="hidden" id="lst" name="lst" value="">
<br>
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
    <th align=left colspan=5 style="font-size:16px"><b>L2TP Server</b></th>
  </tr>
  <tr>
    <td rowspan=4 width="20"></td>
    <td width="100" style="font-size:12px">Auth. Type:</td>
    <td width="190">
      <select name="s_auth" onClick="serverAuthClick()">
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
   <td width="100" style="font-size:12px">Tunnel with Auth</td>
    <td width="190"><input type="checkbox" name="s_tunnelAuth" value="1" onClick="onClickServerTunnelAuth()"></td>
    <td width="100" style="font-size:12px">Auth. Key</td>
    <td width="190"><input type="text" name="s_authKey" size="16" maxlength="256"></td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Peer Address:</td>
    <td width="190" style="font-size:12px">start from:<input type="text" name="peeraddr" size="16" maxlength="80"></td>
    <td width="100" style="font-size:12px">Local Address:</td>
    <td width="190"><input type="text" name="localaddr" size="16" maxlength="80"></td>
  </tr>
  <tr>
    <td colspan=4>
      <input type="submit" value="Apply" name="addServer" onClick="return setL2tpServer()">
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
      <input type="submit" value="Add" name="addAccount" onClick="return addL2tpAccount()">
    </td>
  </tr>
</table>
<table border=0 width="600" cellspacing=2 cellpadding=0>
  <tr><th align=left colspan=5 style="font-size:14px"><b>L2TP Server Table:</b></th></tr>
  <tr>
    <td align=center width="3%" bgcolor="#808080"><font size=2><% multilang("185" "LANG_SELECT"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("604" "LANG_NAME"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("207" "LANG_ENABLE"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("1053" "LANG_USERNAME"); %></font></td>
    <td align=center width="8%" bgcolor="#808080"><font size=2><% multilang("49" "LANG_PASSWORD"); %></font></td>
  </tr>
 <% l2tpServerList(); %>
  <tr>
   <td colspan=7>
     <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSelAccount">&nbsp;&nbsp;
   <input type="submit" value="<% multilang("758" "LANG_SAVE"); %>" name="saveAccount">
   </td>
  </tr>
</table>
<table border=0 width="600" cellspacing=0 cellpadding=0>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
    <th align=left colspan=5 style="font-size:16px"><b>L2TP Client</b></th>
  </tr>
  <tr>
    <td rowspan=7 width="20"></td>
    <td width="100" style="font-size:12px">Name:</td>
    <td width="190"><input type="text" name="c_name" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px">Server Address:</td>
    <td width="190"><input type="text" name="server" size="16" maxlength="256"></td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Username:</td>
    <td width="190"><input type="text" name="username" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px">Password:</td>
    <td width="190"><input type="text" name="password" size="16" maxlength="256"></td>
  </tr>
  <tr>
   <td width="100" style="font-size:12px">Tunnel with Auth</td>
    <td width="190"><input type="checkbox" name="tunnel_auth" value="1" onClick="onClickClientTunnelAuth()"></td>
    <td width="100" style="font-size:12px">Auth. Key</td>
    <td width="190"><input type="text" name="tunnel_secret" size="16" maxlength="256"></td>
  </tr>
  <tr>
    <td width="100" style="font-size:12px">Auth. Type:</td>
    <td width="190">
      <select name="auth" onClick="clientAuthClick()">
      <option value="0">Auto</option>
      <option value="1">PAP</option>
      <option value="2">CHAP</option>
      <option value="3">MS-CHAPV2</option>
      </select>
    </td>
    <td width="100" style="font-size:12px">Encryption Mode:</td>
    <td width="190">
      <select name="enctype" >
      <option value="0"><% multilang("276" "LANG_NONE"); %></option>
      <option value="1">MPPE</option>
      <option value="2">MPPC</option>
      <option value="3">MPPE&MPPC</option>
      </select>
    </td>
  </tr>
  <tr>
   <td width="100" style="font-size:12px">PPP Connection Type:</td>
    <td width="190">
      <select name="pppconntype" onChange="connTypeChange()">
      <option value="0"><% multilang("618" "LANG_PERSISTENT"); %></option>
      <option value="1"><% multilang("619" "LANG_DIAL_ON_DEMAND"); %></option>
      <option value="2"><% multilang("391" "LANG_MANUAL"); %></option>
      <option value="3"><% multilang("276" "LANG_NONE"); %></option>
      </select>
    </td>
    <td width="100" style="font-size:12px">Idle Time (min):</td>
    <td width="190"><input type="text" name="idleTime" size="16" maxlength="256"></td>
  </tr>
  <tr>
   <td width="100" style="font-size:12px"><b>MTU:</b></td>
   <td width="190"><input type="text" name="mtu" size="16" maxlength="256"></td>
    <td width="100" style="font-size:12px"><b>Default Gateway:</b></td>
    <td width="190"><input type="checkbox" name="defaultgw"></td>
  </tr>
  <tr>
    <td colspan=4>
      <input type="submit" value="Add" name="addClient" onClick="return addL2tpClient()">
    </td>
  </tr>
</table>
<table border=0 width="600" cellspacing=2 cellpadding=0>
  <tr><th align=left colspan=8 style="font-size:14px"><b>L2TP Client Table:</b></th></tr>
  <tr>
    <td align=center width="3%" bgcolor="#808080"><font size=2><% multilang("185" "LANG_SELECT"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("604" "LANG_NAME"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("71" "LANG_SERVER"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("1117" "LANG_TUNNEL_AUTH"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("1118" "LANG_PPP_AUTH"); %></font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2>MTU</font></td>
    <td align=center width="5%" bgcolor="#808080"><font size=2><% multilang("65" "LANG_DEFAULT_GATEWAY"); %></font></td>
    <td align=center width="8%" bgcolor="#808080"><font size=2><% multilang("614" "LANG_ACTION"); %></font></td>
  </tr>
 <% l2tpList(); %>
</table>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delSelClient">&nbsp;&nbsp;
<input type="hidden" value="/l2tpd.asp" name="submit-url">
<script>
 <% initPage("l2tp"); %>
 l2tpSelection();
</script>
</form>
</blockquote>
</body>
</html>

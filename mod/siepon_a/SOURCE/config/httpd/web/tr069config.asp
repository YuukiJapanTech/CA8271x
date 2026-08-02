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
<title>TR-069 <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function resetClick()
{
   document.tr069.reset;
}
function periodicSel() {
 if ( document.tr069.enable[0].checked ) {
  disableTextField(document.tr069.interval);
 } else {
  enableTextField(document.tr069.interval);
 }
}
<% TR069ConPageShow("ShowAuthSelFun"); %>
function saveChanges()
{
  if (document.tr069.url.value=="") {
 alert("<% multilang("2316" "LANG_ACS_URL_CANNOT_BE_EMPTY"); %>");
 document.tr069.url.value = document.tr069.url.defaultValue;
 document.tr069.url.focus();
 return false;
  }
 if (checkString(document.tr069.username.value) == 0) {
  alert("<% multilang("1957" "LANG_INVALID_USER_NAME"); %>");
  document.tr069.username.focus();
  return false;
 }
 if (checkString(document.tr069.password.value) == 0) {
  alert("<% multilang("1959" "LANG_INVALID_PASSWORD"); %>");
  document.tr069.password.focus();
  return false;
 }
  if (document.tr069.enable[1].checked) {
 if ( document.tr069.interval.value=="") {
  alert("<% multilang("2317" "LANG_PLEASE_INPUT_PERIODIC_INTERVAL_TIME_"); %>");
  document.tr069.interval.focus();
  return false;
 }
 if ( validateKey( document.tr069.interval.value ) == 0 ) {
  alert("<% multilang("2318" "LANG_INTERVAL_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>");
  document.tr069.interval.focus();
  return false;
 }
  }
 if (checkString(document.tr069.conreqname.value) == 0) {
  alert("<% multilang("1957" "LANG_INVALID_USER_NAME"); %>");
  document.tr069.conreqname.focus();
  return false;
 }
 if (checkString(document.tr069.conreqpw.value) == 0) {
  alert("<% multilang("1959" "LANG_INVALID_PASSWORD"); %>");
  document.tr069.conreqpw.focus();
  return false;
 }
 if (checkString(document.tr069.conreqpath.value) == 0) {
  alert("<% multilang("2319" "LANG_INVALID_PATH"); %>");
  document.tr069.conreqpath.focus();
  return false;
 }
  if (document.tr069.conreqport.value=="") {
 alert("<% multilang("2320" "LANG_PLEASE_INPUT_THE_PORT_NUMBER_FOR_CONNECTION_REQUEST_"); %>");
 document.tr069.conreqport.value = document.tr069.conreqport.defaultValue;
 document.tr069.conreqport.focus();
 return false;
  }
  if ( validateKey( document.tr069.conreqport.value ) == 0 ) {
 alert("<% multilang("2321" "LANG_INVALID_PORT_NUMBER_OF_CONNECTION_REQUEST_IT_SHOULD_BE_1_65535"); %>");
 document.tr069.conreqport.value = document.tr069.conreqport.defaultValue;
 document.tr069.conreqport.focus();
 return false;
  }
  if ( !checkDigitRange(document.tr069.conreqport.value,1,1,65535) ) {
       alert("<% multilang("2321" "LANG_INVALID_PORT_NUMBER_OF_CONNECTION_REQUEST_IT_SHOULD_BE_1_65535"); %>");
 document.tr069.conreqport.value = document.tr069.conreqport.defaultValue;
 document.tr069.conreqport.focus();
 return false;
  }
  return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">TR-069 <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formTR069Config method=POST name="tr069">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("501" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_TR_069_CPE_HERE_YOU_MAY_CHANGE_THE_SETTING_FOR_THE_ACS_S_PARAMETERS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <tr>
  <td width="40%" style="font-weight: bold; font-size: 14"><% multilang("510" "LANG_TR069_DAEMON"); %>:</td>
  <td width="60%"><font size=2>
  <input type="radio" name=autoexec value=1 <% checkWrite("tr069-autoexec-1"); %> ><% multilang("145" "LANG_ENABLED"); %>&nbsp;&nbsp;
  <input type="radio" name=autoexec value=0 <% checkWrite("tr069-autoexec-0"); %> ><% multilang("146" "LANG_DISABLED"); %></font>
  </td>
 </tr>
 <tr>
  <td style="font-weight: bold; font-size: 14"><% multilang("207" "LANG_ENABLE"); %>CWMP<% multilang("513" "LANG_PARAMETER"); %>:</td>
  <td><font size=2>
  <input type="radio" name=enable_cwmp value=1 <% checkWrite("tr069-enable-cwmp-1"); %> ><% multilang("145" "LANG_ENABLED"); %>&nbsp;&nbsp;
  <input type="radio" name=enable_cwmp value=0 <% checkWrite("tr069-enable-cwmp-0"); %> ><% multilang("146" "LANG_DISABLED"); %></font>
  </td>
 </tr>
 <% TR069ConPageShow("ShowDataModels"); %>
</table>
<div ID=WANshow style="display:none">
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <tr>
  <td width="30%" style="font-weight: bold; font-size: 14"><% multilang("354" "LANG_WAN_INTERFACE"); %>:</td>
  <td>
   <select name="tr069_itf">
    <option value=65535>&nbsp;</option>
    <% if_wan_list("rt"); %>
   </select>
  </td>
 </tr>
</table>
</div>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <tr><td colspan=2><hr size=1 noshade align=top></td><td></td></tr>
 <tr>
  <td style="font-size: 18; font-weight: bold"><% multilang("511" "LANG_ACS"); %>:</td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b><% multilang("512" "LANG_URL"); %>:</b></td>
  <td width="70%"><input type="text" name="url" size="32" maxlength="256" value=<% getInfo("acs-url"); %>></td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
  <td width="70%"><input type="text" name="username" size="32" maxlength="256" value=<% getInfo("acs-username"); %>></td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b><% multilang("49" "LANG_PASSWORD"); %>:</b></td>
  <td width="70%"><input type="text" name="password" size="32" maxlength="256" value=<% getInfo("acs-password"); %>></td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b><% multilang("502" "LANG_PERIODIC_INFORM"); %>:</b></td>
  <td width="70%"><font size=2>
  <input type="radio" name=enable value=0 <% checkWrite("tr069-inform-0"); %> onClick="return periodicSel()"><% multilang("146" "LANG_DISABLED"); %>&nbsp;&nbsp;
  <input type="radio" name=enable value=1 <% checkWrite("tr069-inform-1"); %> onClick="return periodicSel()"><% multilang("145" "LANG_ENABLED"); %></td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b><% multilang("503" "LANG_PERIODIC_INFORM_INTERVAL"); %>:</b></td>
  <td width="70%"><input type="text" name="interval" size="32" maxlength="10" value=<% getInfo("inform-interval"); %> <% checkWrite("tr069-interval"); %> ></td>
 </tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <tr><td><hr size=1 noshade align=top></td></tr>
 <tr>
   <td style="font-size: 18; font-weight: bold">
   <% multilang("504" "LANG_CONNECTION_REQUEST"); %>:
   </td>
  </tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <% TR069ConPageShow("ShowAuthSelect"); %>
  <tr>
  <td width="30%"><font size=2><b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
  <td width="70%"><input type="text" name="conreqname" size="32" maxlength="256" value=<% getInfo("conreq-name"); %> <% TR069ConPageShow("DisConReqName"); %> ></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("49" "LANG_PASSWORD"); %>:</b></td>
      <td width="70%"><input type="text" name="conreqpw" size="32" maxlength="256" value=<% getInfo("conreq-pw"); %> <% TR069ConPageShow("DisConReqPwd"); %> ></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("505" "LANG_PATH"); %>:</b></td>
      <td width="70%"><input type="text" name="conreqpath" size="32" maxlength="31" value=<% getInfo("conreq-path"); %>></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("172" "LANG_PORT"); %>:</b></td>
      <td width="70%"><input type="text" name="conreqport" size="32" maxlength="5" value=<% getInfo("conreq-port"); %>></td>
  </tr>
</table>
<!--
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><hr size=1 noshade align=top></tr>
  <tr>
      <td width="30%"><font size=2><b>Debug:</b></td>
      <td width="70%"><b></b></td>
  </tr>
  <% TR069ConPageShow("ShowACSCertCPE"); %>
  <tr>
      <td width="30%"><font size=2><b>Show Message:</b></td>
      <td width="70%"><font size=2>
      <input type="radio" name=dbgmsg value=0 <% checkWrite("tr069-dbgmsg-0"); %> >Disabled&nbsp;&nbsp;
      <input type="radio" name=dbgmsg value=1 <% checkWrite("tr069-dbgmsg-1"); %> >Enabled
      </td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>CPE Sends GetRPC:</b></td>
      <td width="70%"><font size=2>
      <input type="radio" name=sendgetrpc value=0 <% checkWrite("tr069-sendgetrpc-0"); %> >Disabled&nbsp;&nbsp;
      <input type="radio" name=sendgetrpc value=1 <% checkWrite("tr069-sendgetrpc-1"); %> >Enabled
      </td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>Skip MReboot:</b></td>
      <td width="70%"><font size=2>
      <input type="radio" name=skipmreboot value=0 <% checkWrite("tr069-skipmreboot-0"); %> >Disabled&nbsp;&nbsp;
      <input type="radio" name=skipmreboot value=1 <% checkWrite("tr069-skipmreboot-1"); %> >Enabled
      </td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>Delay:</b></td>
      <td width="70%"><font size=2>
      <input type="radio" name=delay value=0 <% checkWrite("tr069-delay-0"); %> >Disabled&nbsp;&nbsp;
      <input type="radio" name=delay value=1 <% checkWrite("tr069-delay-1"); %> >Enabled
      </td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b>Auto-Execution:</b></td>
      <td width="70%"><font size=2>
      <input type="radio" name=autoexec value=0 <% checkWrite("tr069-autoexec-0"); %> >Disabled&nbsp;&nbsp;
      <input type="radio" name=autoexec value=1 <% checkWrite("tr069-autoexec-1"); %> >Enabled
      </td>
  </tr>
  <% TR069ConPageShow("ShowCTInformExt"); %>
</table>
-->
 <br>
 <input type="submit" value=<% multilang("119" "LANG_APPLY_CHANGES"); %> name="save" onClick="return saveChanges()">&nbsp;&nbsp;
 <input type="reset" value=<% multilang("266" "LANG_UNDO"); %> name="reset" onClick="resetClick()">
 <input type="hidden" value="/tr069config.asp" name="submit-url">
</form>
<% TR069ConPageShow("ShowMNGCertTable"); %>
<script>
 ifIdx = <% getInfo("tr069_wan_intf"); %>;
 document.tr069.tr069_itf.selectedIndex = -1;
 for( i = 0; i < document.tr069.tr069_itf.options.length; i++ )
 {
  if( ifIdx == document.tr069.tr069_itf.options[i].value )
   document.tr069.tr069_itf.selectedIndex = i;
 }
 <% DisplayTR069WAN() %>
</script>
</blockquote>
</body>
</html>

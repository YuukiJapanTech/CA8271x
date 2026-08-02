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
<title><% multilang("47" "LANG_SYSTEM_LOG"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script language="javascript">
var addr = '<% getInfo("syslog-server-ip"); %>';
var port = '<% getInfo("syslog-server-port"); %>';
function getLogPort() {
 var portNum = parseInt(port);
 if (isNaN(portNum) || portNum == 0)
  portNum = 514; // default system log server port is 514
 return portNum;
}
function hideInfo(hide) {
 var status = 'visible';
 if (hide == 1) {
  status = 'hidden';
  document.forms[0].logAddr.value = '';
  document.forms[0].logPort.value = '';
  changeBlockState('srvInfo', true);
 } else {
  changeBlockState('srvInfo', false);
  document.forms[0].logAddr.value = addr;
  document.forms[0].logPort.value = getLogPort();
 }
}
function hidesysInfo(hide) {
 var status = false;
 if (hide == 1) {
  status = true;
 }
 changeBlockState('sysgroup', status);
}
function changelogstatus() {
 with (document.forms[0]) {
  if (logcap[1].checked) {
   hidesysInfo(0);
   if (logMode.selectedIndex == 0) {
    hideInfo(1);
   } else {
    hideInfo(0);
   }
  } else {
   hidesysInfo(1);
   hideInfo(1);
  }
 }
}
function cbClick(obj) {
 var idx = obj.selectedIndex;
 var val = obj.options[idx].value;
 /* 1: Local, 2: Remote, 3: Both */
 if (val == 1)
  hideInfo(1);
 else
  hideInfo(0);
}
function check_enable()
{
 if (document.formSysLog.logcap[0].checked) {
  //disableTextField(document.formSysLog.msg);
  disableButton(document.formSysLog.refresh);
 }
 else {
  //enableTextField(document.formSysLog.msg);
  enableButton(document.formSysLog.refresh);
 }
}
/*function scrollElementToEnd (element) {
   if (typeof element.scrollTop != 'undefined' &&
       typeof element.scrollHeight != 'undefined') {
     element.scrollTop = element.scrollHeight;
   }
}*/
function saveClick()
{
 <% RemoteSyslog("check-ip"); %>
//	if (document.forms[0].logAddr.disabled == false && !checkIP(document.formSysLog.logAddr))
//		return false;
//	alert("Please commit and reboot this system for take effect the System log!");
 return true;
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("47" "LANG_SYSTEM_LOG"); %></font></h2>
<form action=/boaform/formSysLog method=POST name=formSysLog>
<table border="0" cellspacing="4" width="500">
<tr><hr size=1 noshade align=top></tr>
<tr>
 <td width="25%"><font size=2><b><% multilang("47" "LANG_SYSTEM_LOG"); %>&nbsp;:</b></td>
 <td width="30%"><font size=2>
  <input type="radio" value="0" name="logcap" onClick='changelogstatus()' <% checkWrite("log-cap0"); %>><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="logcap" onClick='changelogstatus()' <% checkWrite("log-cap1"); %>><% multilang("207" "LANG_ENABLE"); %>
 </td>
</tr>
<% ShowPPPSyslog("syslogppp"); %>
<TBODY id='sysgroup'>
<tr>
 <td><font size=2><b><% multilang("755" "LANG_LOG_LEVEL"); %>&nbsp;:</b></td>
 <td><select name='levelLog' size="1">
  <% checkWrite("syslog-log"); %>
 </select></td>
</tr>
<tr>
 <td><font size=2><b><% multilang("756" "LANG_DISPLAY_LEVEL"); %>&nbsp;:</b></td>
 <td ><select name='levelDisplay' size="1">
  <% checkWrite("syslog-display"); %>
 </select></td>
</tr>
<% RemoteSyslog("syslog-mode"); %>
<tbody id='srvInfo'>
<% RemoteSyslog("server-info"); %>
</tbody>
</TBODY>
<tr>
 <td width="45%"> <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply" onClick="return saveClick()"></td>
</tr>
<tr>
 <td width="25%"><font size=2><b><% multilang("757" "LANG_SAVE_LOG_TO_FILE"); %>:</b></td>
 <td width="30%"><font size=2><input type="submit" value="<% multilang("758" "LANG_SAVE"); %>..." name="save_log"></td>
</tr>
<tr>
 <td width="25%"><font size=2><b><% multilang("759" "LANG_CLEAR_LOG"); %>:</b></td>
 <td width="30%"><font size=2><input type="submit" value="<% multilang("181" "LANG_RESET"); %>" name="clear_log"></td>
</tr>
</table>
<table border="0" cellspacing="4" width="500">
<tr><hr size=1 noshade align=top></tr>
<tr>
 <td width="25%"><font size=2><b><% multilang("47" "LANG_SYSTEM_LOG"); %></b></td>
 <td width="30%"><font size=2><input type="button" value="Refresh" name="refresh" onClick="javascript: window.location.reload()"></td>
</tr>
<tr>
 <td>
 <div style="overflow: auto; height: 500px; width: 500px; PADDING-LEFT: 10px; PADDING-TOP: 10px; PADDING-RIGHT: 10px; PADDING-BOTTOM: 10px">
 <table border="0" width="100%"><% sysLogList(); %></table>
 </td>
</tr>
</table>
<input type="hidden" value="/syslog.asp" name="submit-url">
<script>
 check_enable();
 //scrollElementToEnd(this.formSysLog.msg);
</script>
</form>
<script>
 <% initPage("syslog"); %>
 <% initPage("pppSyslog"); %>
</script>
</blockquote>
</body>
</html>

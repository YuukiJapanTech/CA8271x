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
<script>
function check_enable()
{
 if (document.formSysLog.logcap[0].checked) {
  disableTextField(document.formSysLog.msg);
  disableButton(document.formSysLog.refresh);
 }
 else {
  enableTextField(document.formSysLog.msg);
  enableButton(document.formSysLog.refresh);
 }
}
function scrollElementToEnd (element) {
   if (typeof element.scrollTop != 'undefined' &&
       typeof element.scrollHeight != 'undefined') {
     element.scrollTop = element.scrollHeight;
   }
}
function saveClick()
{
 if (!checkIP(document.formSysLog.ip))
  return false;
 alert("<% multilang("2311" "LANG_PLEASE_COMMIT_AND_REBOOT_THIS_SYSTEM_FOR_TAKE_EFFECT_THE_SYSTEM_LOG"); %>");
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">System Log</font></h2>
<form action=/boaform/formSysLog method=POST name=formSysLog>
<table border="0" cellspacing="4" width="500">
<tr>
 <td width="25%"><font size=2><b>System Log</b></td>
 <td width="30%"><font size=2>
  <input type="radio" value="0" name="logcap" <% checkWrite("log-cap0"); %>>Disable&nbsp;&nbsp;
  <input type="radio" value="1" name="logcap" <% checkWrite("log-cap1"); %>>Enable
 </td>
 <!--
 <td width="45%"> <input type="submit" value="Apply Changes" name="apply" onClick="return saveClick()"></td>
        -->
</tr>
<tr>
       <td width="25%"><font size=2><b>Log Server(FTP Server):</b></td>
       <td width="30%"><input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("log-server-ip"); %>></td>
</tr>
<tr>
      <td width="25%"><font size=2><b>User Name:</b></td>
      <td width="30%"><font size=2><input type="text" name="username" size="20" maxlength="30" value=<% getInfo("log-server-username"); %>></td>
</tr>
<tr>
      <td width="25%"><font size=2><b>Password:</b></td>
      <td width="30%"><font size=2><input type="password" name="passwd" size="20" maxlength="30"></td>
</tr>
<tr>
 <td width="45%"> <input type="submit" value="Apply Changes" name="apply" onClick="return saveClick()"></td>
</tr>
<tr>
 <td width="25%"><font size=2><b>Save Log to File:</b></td>
 <td width="30%"><font size=2><input type="submit" value="Save..." name="save_log"></td>
</tr>
<tr>
 <td width="25%"><font size=2><b>Clear Log:</b></td>
 <td width="30%"><font size=2><input type="submit" value="Reset" name="clear_log"></td>
</tr>
</table>
<textarea rows="15" name="msg" cols="80" wrap="virtual"><% sysLogList(); %></textarea>
<p>
<input type="button" value="Refresh" name="refresh" onClick="javascript: window.location.reload()">
<input type="hidden" value="/syslog_server.asp" name="submit-url">
<script>
 check_enable();
 scrollElementToEnd(this.formSysLog.msg);
</script>
</form>
</blockquote>
</body>
</html>

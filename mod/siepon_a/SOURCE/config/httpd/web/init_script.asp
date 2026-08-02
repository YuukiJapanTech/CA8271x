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
<title><% multilang(LANG_system_initial_script); %></title>
<script type="text/javascript" src="share.js">
</script>
<script language="javascript">
function openWindow(url, windowName)
{
 var wide=640;
 var high=800;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=800;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, windowName, settings );
}
function ShowStartScriptClick(url)
{
 openWindow(url, 'ShowStartScript');
}
function ShowEndScriptClick(url)
{
 openWindow(url, 'ShowEndScript');
}
function confirmAction()
{
 return confirm("Are you sure to delete the script file?")
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang(LANG_system_initial_script); %></font></h2>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("1108" "LANG_SET_SCRIPTS_THAT_ARE_EXECUTED_IN_SYSTEM_INITIALING"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=8 cellpadding=0>
  <tr>
      <td colspan=4><font size=3><b>Init Start Script:</b></font></td>
      <td></td>
  </tr>
  <tr>
      <td colspan=4><font size=2>This script is used to run before system initiating.</font></td>
      <td></td>
  </tr>
  <tr>
  <form action=/boaform/formInitStartScript method=POST enctype="multipart/form-data" name="init_st_script">
  <td colspan=3><input type="file" value=<% multilang("461" "LANG_CHOOSE_FILE"); %> name="start_text" size=36></td>
  <td><input type="submit" value=<% multilang("509" "LANG_UPLOAD"); %> name="start_upload"></td>
  </form>
  </tr>
  <tr valign="top">
  <td width=50>
   <input type="submit" value=<% multilang("1109" "LANG_SHOW_SCRIPT_CONTENT"); %> name="start_show" onClick=ShowStartScriptClick("/StartScriptContent.asp")>&nbsp;
  </td>
  <td>
   <form action=/boaform/formInitStartScriptDel method=POST name="init_st_script_del" onSubmit="return confirmAction()">
   <input type="submit" value=<% multilang("1110" "LANG_DELETE_SCRIPT"); %> name="start_delete"></td>
   </form>
  </td>
  <td colspan=2>&nbsp;</td>
  </tr>
</table>
<hr size=1 noshade align=top>
<table border=0 width="500" cellspacing=8 cellpadding=0>
  <tr>
  <td colspan=4><font size=3><b>Init End Script:</b></font></td>
  <td></td>
  </tr>
  <tr>
  <td colspan=4><font size=2>This script is used to run after system initiating.</font></td>
  <td></td>
  </tr>
  <tr>
  <form action=/boaform/formInitEndScript method=POST enctype="multipart/form-data" name="init_ed_script">
  <td colspan=3><input type="file" value=<% multilang("461" "LANG_CHOOSE_FILE"); %> name="end_text" size=36></td>
  <td><input type="submit" value=<% multilang("509" "LANG_UPLOAD"); %> name="end_upload"></td>
  </form>
  </tr>
  <tr valign="top">
  <td width=50>
   <input type="submit" value=<% multilang("1109" "LANG_SHOW_SCRIPT_CONTENT"); %> name="end_show" onClick=ShowEndScriptClick("/EndScriptContent.asp")>&nbsp;
  </td>
  <td>
   <form action=/boaform/formInitEndScriptDel method=POST name="init_ed_script_del" onSubmit="return confirmAction()">
   <input type="submit" value=<% multilang("1110" "LANG_DELETE_SCRIPT"); %> name="end_delete"></td>
   </form>
  </td>
  <td colspan=2>&nbsp;</td>
  </tr>
</table>
</blockquote>
</body>
</html>

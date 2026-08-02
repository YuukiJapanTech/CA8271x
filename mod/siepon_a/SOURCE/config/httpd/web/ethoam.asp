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
<title><% multilang("1039" "LANG_ETHERNETOAM_Y_1731"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function saveChanges(){
 if ((document.Y1731.myid<1)) {
   alert('<% multilang("2077" "LANG_MYID_MUST_MORE_THAN_0"); %>');
   return false;
 }
 if (document.Y1731.megid.length == 0) {
   alert('<% multilang("2078" "LANG_MEGID_MUST_HAVE_VALUE"); %>');
   return false;
 }
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("1039" "LANG_ETHERNETOAM_Y_1731"); %></font></h2>
<form action=/boaform/formY1731 method=POST name="Y1731">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("1040" "LANG_HERE_YOU_CAN_CONFIGURE_ETHERNETOAM_Y_1731"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <tr>
  <td width="30%"><font size=2><b><% multilang("207" "LANG_ENABLE"); %>:</b></td>
  <td width="70%"><input type="checkbox" name="oamMode" id="oamMode" value="1" checked></td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b>MEG <% multilang("761" "LANG_LEVEL"); %>:</b></td>
  <td width="70%">
   <select size="1" name="meglevel" id="meglevel">
   <option value="7">7</option><option value="6">6</option><option value="5">5</option><option value="4">4</option>
   <option value="3">3</option><option value="2">2</option><option value="1">1</option><option value="0">0</option>
   </select>
  </td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b>MyID:</b></td>
  <td width="70%"><input type="text" name="myid" id="myid" size="5" maxlength="5"></td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b>MEG ID:</b></td>
  <td width="70%"><input type="text" name="megid" id="megid" size="14" maxlength="14"></td>
 </tr>
  <tr>
  <td width="30%"><font size=2><b>CCM Interval:</b></td>
  <td width="70%">
   <select size="1" name="ccminterval" id="ccminterval">
   <option value="1">3.33ms</option><option value="2">10ms</option><option value="3">100ms</option>
   <option value="4">1s</option><option value="5">10s</option><option value="6">1min</option><option value="7">10min</option>
   </select>
  </td>
 </tr>
 <tr>
  <td width="30%"><font size=2><b>Log Level:</b></td>
  <td width="70%">
   <select size="1" name="loglevel" id="loglevel">
   <option value="none">none</option><option value="medium">medium</option><option value="xtra">extra</option><option value="all">all</option>
   </select>
  </td>
 </tr>
</table>
 <br>
 <input type=submit value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">
 <input type=hidden value="/ethoam.asp" name="submit-url">
<script>
  document.getElementById('oamMode').checked = <% getInfo("y1731_mode"); %>;
  document.getElementById('myid').value = "<% getInfo("y1731_myid"); %>";
  document.getElementById('meglevel').value = "<% getInfo("y1731_meglevel"); %>";
  document.getElementById('megid').value = "<% getInfo("y1731_megid"); %>";
  document.getElementById('ccminterval').value = "<% getInfo("y1731_ccminterval"); %>";
  document.getElementById('loglevel').value = "<% getInfo("y1731_loglevel"); %>";
</script>
</form>
</blockquote>
</body>
</html>

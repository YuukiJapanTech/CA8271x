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
<title><% multilang("291" "LANG_PORT_BASED_FILTER"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function saveChanges()
{
 var ptmap = 0;
 var pmchkpt = document.getElementById("tbl_pmap");
 if (pmchkpt) {
  with (document.forms[0]) {
   for(var i = 0; i < 14; i ++) {
    if (!chkpt[i])
     continue;
    if(chkpt[i].checked == true) ptmap |= (0x1 << i);
   }
   dhcpPortFilter.value = ptmap;
  }
 }
 return true;
}
function on_init()
{
 return true;
}
</SCRIPT>
</head>
<body onLoad="on_init();">
<blockquote>
<h2><font color="#0000FF"><% multilang("291" "LANG_PORT_BASED_FILTER"); %></font></h2>
<table border=0 width="480" cellspacing=0 cellpadding=0>
  <tr><td><font color="#00FFFF" size=2>
 <% multilang("292" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PORT_BASED_FILTERING"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formmacBase method=POST name="stbIp">
 <% ShowPortBaseFiltering(); %>
 <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
 <input type="hidden" value="/portBaseFilterDhcp.asp" name="submit-url">
 <input type="hidden" name="dhcpPortFilter" value=0>
 <input type="button" value="<% multilang("644" "LANG_CLOSE"); %>" name="close" onClick="javascript: window.close();">
<script>
 var mode = <% getInfo("dhcp_port_filter"); %>;
 var pmchkpt = document.getElementById("tbl_pmap");
 with ( document.forms[0] )
 {
  //port mapping
  if (pmchkpt)
   for(var i = 0; i < 14; i ++) {
    if (!chkpt[i])
     continue;
    chkpt[i].checked = (mode & (0x1 << i));
   }
 }
</script>
</form>
</blockquote>
</body>
</html>

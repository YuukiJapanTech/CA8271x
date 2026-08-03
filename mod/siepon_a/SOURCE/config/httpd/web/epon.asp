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
<title><% multilang("1103" "LANG_EPON_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function applyclick()
{
 var mac_addr = document.formepon_llid_mac_mapping.elements["mac_addr[]"];
 for(var i=0;i<mac_addr.length;i++)
 {
  if ( (mac_addr[i].value=="") || (!mac_addr[i].value.contains(":")) || (mac_addr[i].value.length!=17))
  {
    alert('<% multilang("2066" "LANG_INVALID_MAC_ADDRESS"); %>');
    mac_addr[i].focus();
    return false;
  }
 }
 return true;
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("1103" "LANG_EPON_SETTINGS"); %></font></h2>
<form action=/boaform/admin/formeponConf method=POST name="formeponconf">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("1104" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_EPON_NETWORK_ACCESS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
      <td width="30%"><font size=2><b><% multilang("454" "LANG_LOID"); %>:</b></td>
      <td width="70%"><input type="text" name="fmepon_loid" size="24" maxlength="24" value="<% fmepon_checkWrite("fmepon_loid"); %>"></td>
  </tr>
<tr>
      <td width="30%"><font size=2><b><% multilang("455" "LANG_LOID_PASSWORD"); %>:</b></td>
      <td width="70%"><input type="text" name="fmepon_loid_password" size="12" maxlength="12" value="<% fmepon_checkWrite("fmepon_loid_password"); %>"></td>
  </tr>
</table>
      <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply" onclick="return applyclick()">&nbsp;&nbsp;
      <input type="hidden" value="/epon.asp" name="submit-url">
</form>
<table border=0 width="600" cellspacing=4 cellpadding=0>
  <tr><font size=2><b><% multilang("1105" "LANG_LLID_MAC_MAPPING_TABLE"); %>:</b></font></tr>
<form action=/boaform/admin/formepon_llid_mac_mapping method=POST name="formepon_llid_mac_mapping">
  <% showepon_LLID_MAC(); %> <br>
<tr><td>
      <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply" onClick="return applyclick()">&nbsp;&nbsp;
      <input type="hidden" value="/epon.asp" name="submit-url">
</td></tr>
</form>
</table>
</blockquote>
</body>
</html>

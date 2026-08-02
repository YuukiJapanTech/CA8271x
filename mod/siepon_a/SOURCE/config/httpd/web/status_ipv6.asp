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
<title>IPv6 <% multilang("3" "LANG_STATUS"); %></title>
<script type="text/javascript" src="share.js">
</script>
</head>
<body>
<blockquote>
<h2><b><font color="#0000FF">IPv6 <% multilang("3" "LANG_STATUS"); %></font></b></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr><td><font size=2>
 <% multilang("82" "LANG_THIS_PAGE_SHOWS_THE_CURRENT_SYSTEM_STATUS_OF_IPV6"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top><br></td></tr>
</table>
<table width=400 border=0>
  <tr>
    <td width=100% colspan="2" bgcolor="#008000"><font color="#FFFFFF" size=2><b><% multilang("6" "LANG_LAN"); %><% multilang("197" "LANG_CONFIGURATION"); %></b></font></td>
  </tr>
  <tr bgcolor="#EEEEEE">
    <td width=40%><font size=2><b><% multilang("83" "LANG_IPV6_ADDRESS"); %></b></td>
    <td width=60%><font size=2><% getInfo("ip6_global"); %></td>
  </tr>
  <tr bgcolor="#DDDDDD">
    <td width=40%><font size=2><b><% multilang("84" "LANG_IPV6_LINK_LOCAL_ADDRESS"); %></b></td>
    <td width=60%><font size=2><% getInfo("ip6_ll"); %></td>
  </tr>
</table>
<br>
<table width=400 border=0>
  <tr>
    <td width=100% colspan="2" bgcolor="#008000"><font color="#FFFFFF" size=2><b><% multilang("85" "LANG_PREFIX_DELEGATION"); %></b></font></td>
  </tr>
  <tr bgcolor="#EEEEEE">
    <td width=40%><font size=2><b><% multilang("86" "LANG_PREFIX"); %></b></td>
    <td width=60%><font size=2><% checkWrite("prefix_delegation_info"); %></td>
  </tr>
</table>
<br>
<form action=/boaform/admin/formStatus_ipv6 method=POST name="status_ipv6">
<table width=600 border=0>
 <tr>
    <td width=100% colspan=6 bgcolor="#008000"><font color="#FFFFFF" size=2><b><% multilang("10" "LANG_WAN"); %><% multilang("197" "LANG_CONFIGURATION"); %></b></font></td>
  </tr>
  <% wanip6ConfList(); %>
</table>
  <input type="hidden" value="/admin/status_ipv6.asp" name="submit-url">
  <input type="submit" value="<% multilang("362" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
</form>
</blockquote>
</body>
</html>

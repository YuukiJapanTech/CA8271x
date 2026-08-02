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
<title>DHCP <% multilang("111" "LANG_MODE"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">DHCP <% multilang("111" "LANG_MODE"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formDhcpMode method=POST name="dhcpmode">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("652" "LANG_THIS_PAGE_IS_USED_TO_SET_AND_CONFIGURE_THE_DYNAMIC_HOST_CONFIGURATION_PROTOCOL_MODE_FOR_YOUR_DEVICE_WITH_DHCP_IP_ADDRESSES_FOR_YOUR_LAN_ARE_ADMINISTERED_AND_DISTRIBUTED_AS_NEEDED_BY_THIS_DEVICE_OR_AN_ISP_DEVICE"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
  <tr>
      <td width="30%"><font size=2><b>DHCP <% multilang("111" "LANG_MODE"); %>:</b>
      <select size="1" name="dhcpMode">
      <% checkWrite("dhcpMode"); %>
      </select>
      </td>
  </tr>
</table>
  <br>
      <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save"">&nbsp;&nbsp;
      <input type="hidden" value="/dhcpmode.asp" name="submit-url">
 </form>
</blockquote>
</body>
</html>

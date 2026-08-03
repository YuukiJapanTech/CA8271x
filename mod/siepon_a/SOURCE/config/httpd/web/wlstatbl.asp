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
<title><% multilang("123" "LANG_ACTIVE_WLAN_CLIENTS"); %></title>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("123" "LANG_ACTIVE_WLAN_CLIENTS"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
 <% multilang("124" "LANG_THIS_TABLE_SHOWS_THE_MAC_ADDRESS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/admin/formWirelessTbl method=POST name="formWirelessTbl">
<table border='1' width="500">
<tr bgcolor=#7f7f7f><td width="25%"><font size=2><b><% multilang("72" "LANG_MAC_ADDRESS"); %></b></td>
<td width="15%"><font size=2><b><% multilang("125" "LANG_TX_PACKETS"); %></b></td>
<td width="15%"><font size=2><b><% multilang("126" "LANG_RX_PACKETS"); %></b></td>
<td width="15%"><font size=2><b><% multilang("124" "LANG_THIS_TABLE_SHOWS_THE_MAC_ADDRESS"); %></b></td>
<td width="15%"><font size=2><b><% multilang("128" "LANG_POWER_SAVING"); %></b></td>
<td width="15%"><font size=2><b><% multilang("129" "LANG_EXPIRED_TIME_SEC"); %></b></td></tr>
<% wirelessClientList(); %>
</table>
<input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
<input type="hidden" value="/admin/wlstatbl.asp" name="submit-url">
  <p><input type="submit" value="Refresh" name="refresh">&nbsp;&nbsp;
  <input type="button" value=" Close " name="close" onClick="javascript: window.close();"></p>
</form>
</blockquote>
</body>
</html>

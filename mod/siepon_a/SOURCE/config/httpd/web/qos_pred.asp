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
<! Copyright (c) Realtek Semiconductor Corp., 2008. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("763" "LANG_IP_PRECEDENCE_PRIORITY_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
</head>
<BODY>
<blockquote>
<h2><font color="#0000FF"><% multilang("763" "LANG_IP_PRECEDENCE_PRIORITY_SETTINGS"); %></font></h2>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><font size=2>
<% multilang("764" "LANG_THIS_PAGE_IS_USED_TO_CONFIG_IP_PRECEDENCE_PRIORITY"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formIPQoS method=POST name=qos_set1p>
<table border="0" width=500>
<tr><font size=2><% multilang("765" "LANG_IP_PRECEDENCE_RULE"); %>:</font></tr>
<% settingpred(); %>
</table>
<input type="hidden" value="/qos_pred.asp" name="submit-url">
<td><input type="submit" value="<% multilang("261" "LANG_MODIFY"); %>" name=setpred ></td>
<input type="button" value="<% multilang("644" "LANG_CLOSE"); %>" name="close" onClick="javascript: window.close();"></p>
</form>
</blockquote>
</body>
</html>

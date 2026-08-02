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
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("42" "LANG_PACKET_DUMP"); %></title>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("42" "LANG_PACKET_DUMP"); %></font></h2>
<form action=/boaform/formCapture method=POST name="ping">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
 <% multilang("707" "LANG_THIS_PAGE_IS_USED_TO_START_OR_STOP_A_WIRESHARK_PACKET_CAPTURE"); %><br>
    <% multilang("708" "LANG_YOU_NEED_TO_RETURN_TO_THIS_PAGE_TO_STOP_IT"); %><br>
 <a href ="http://www.tcpdump.org/tcpdump_man.html" target=_blank"><% multilang(LANG_CLICK_HERE_FOR_THE_DOCUMENTATION_OF_THE_ADDITIONAL_ARGUMENTS); %></a>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
  <tr>
      <td width="30%"><font size=2><b><% multilang("710" "LANG_ADDITIONAL_ARGUMENTS"); %>:</b></td>
      <td width="70%"><input type="text" name="tcpdumpArgs" value="-s 1500" size="50" maxlength="50"></td>
      <input type="hidden" value="yes" name="dostart">
  </tr>
</table>
  <br>
      <input type="submit" value="<% multilang("434" "LANG_START"); %>" name="start">
      <input type="hidden" value="/pdump.asp" name="submit-url">
 </form>
<p>
<form action=/boaform/formCapture method=POST name="ping">
      <input type="submit" value="<% multilang("711" "LANG_STOP"); %>" name="stop">
      <input type="hidden" value="/pdump.asp" name="submit-url">
      <input type="hidden" value="no" name="dostart">
 </form>
</blockquote>
</body>
</html>

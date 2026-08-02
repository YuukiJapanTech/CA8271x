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
<HEAD>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("25" "LANG_MLD_SNOOPING"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
</HEAD>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
 <blockquote>
  <h2><font color="#0000FF"><% multilang("25" "LANG_MLD_SNOOPING"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
  <DIV align="left" style="padding-left:20px; padding-top:5px">
   <form id="form" action=/boaform/formMLDSnooping method=POST name="mldsnoop">
    <table border=0 width="500" cellspacing=4 cellpadding=0>
    <tr><td><font size=2><% multilang("355" "LANG_THIS_PAGE_BE_USED_TO_CONFIGURE_MLD_SNOOPING"); %></font></td></tr>
    <tr><td><hr size=1 noshade align=top></td></tr>
    </table>
    <table border=0 width="500" cellspacing=4 cellpadding=0>
     <tr><td width=150><font size=2><b><% multilang("25" "LANG_MLD_SNOOPING"); %>:</b></td>
      <td width=350><font size=2>
      <input type="radio" name=snoop value=0><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" name=snoop value=1><% multilang("207" "LANG_ENABLE"); %></td>
    </tr></table>
    <br>
    <input type="submit" class="button" name="apply" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>">
    <input type="hidden" name="submit-url" value="/app_mld_snooping.asp">
   <script>
    <% initPage("mldsnooping"); %>
   </script>
   </form>
  </DIV>
 </blockquote>
</body>
</html>

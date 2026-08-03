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
<title><% multilang("50" "LANG_FIRMWARE_UPGRADE"); %></title>
<script>
function sendClicked()
{
 if (document.password.binary.value=="") {
  alert('<% multilang("2130" "LANG_SELECTED_FILE_CANNOT_BE_EMPTY"); %>');
  document.password.binary.focus();
  return false;
 }
 if (!confirm('<% multilang("2424" "LANG_DO_YOU_REALLY_WANT_TO_UPGRADE_THE_FIRMWARE"); %>'))
  return false;
 else
  return true;
}
</script>
</head>
<BODY>
<blockquote>
<h2><font color="#0000FF"><% multilang("50" "LANG_FIRMWARE_UPGRADE"); %></font></h2>
<form action=/boaform/admin/formUpload method=POST enctype="multipart/form-data" name="password">
<table border="0" cellspacing="4" width="500">
 <tr><td><font size=2>
 <% multilang("475" "LANG_PAGE_DESC_UPGRADE_FIRMWARE"); %>
 </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border="0" cellspacing="4" width="500">
  <tr>
      <td><font size=2><input type="file" value="<% multilang("461" "LANG_CHOOSE_FILE"); %>" name="binary" size=20></td>
  </tr>
  </table>
    <p> <input type="submit" value="<% multilang("476" "LANG_UPGRADE"); %>" name="send" onclick="return sendClicked()">&nbsp;&nbsp;
 <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset">
    </p>
 </form>
 </blockquote>
</body>
</html>

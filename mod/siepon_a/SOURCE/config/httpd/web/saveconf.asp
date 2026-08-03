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
<title><% multilang("460" "LANG_BACKUP_AND_RESTORE_SETTINGS"); %></title>
<script>
function resetClick()
{
 return confirm("<% multilang("2429" "LANG_DO_YOU_REALLY_WANT_TO_RESET_THE_CURRENT_SETTINGS_TO_FACTORY_DEFAULT"); %>");
}
function uploadClick()
{
    if (document.saveConfig.binary.value.length == 0) {
  alert('<% multilang("461" "LANG_CHOOSE_FILE"); %>!');
  document.saveConfig.binary.focus();
  return false;
 }
 return true;
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("460" "LANG_BACKUP_AND_RESTORE_SETTINGS"); %></font></h2>
  <table border="0" cellspacing="4" width="500">
  <tr><td><font size=2>
 <% multilang("462" "LANG_THIS_PAGE_ALLOWS_YOU_TO_BACKUP_CURRENT_SETTINGS_TO_A_FILE_OR_RESTORE_THE_SETTINGS_FROM_THE_FILE_WHICH_WAS_SAVED_PREVIOUSLY_BESIDES_YOU_COULD_RESET_THE_CURRENT_SETTINGS_TO_FACTORY_DEFAULT"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
  </table>
  <table border="0" cellspacing="4" width="500">
  <form action=/boaform/formSaveConfig method=POST name="saveCSConfig">
  <tr>
    <td width="40%"><font size=2><b><% multilang("463" "LANG_BACKUP_SETTINGS_TO_FILE"); %>:</b></font></td>
    <td width="30%"><font size=2>
      <input type="submit" value="<% multilang("466" "LANG_BACKUP"); %>..." name="save_cs">
    </font></tr>
  </form>
  <form action=/boaform/formSaveConfig enctype="multipart/form-data" method=POST name="saveConfig">
  <tr>
    <td width="40%"><font size=2><b><% multilang("467" "LANG_RESTORE_SETTINGS_FROM_FILE"); %>:</b></font></td>
    <td width="30%"><font size=2><input type="file" value="<% multilang("461" "LANG_CHOOSE_FILE"); %>" name="binary" size=24></font></td>
    <td width="20%"><font size=2><input type="submit" value="<% multilang("468" "LANG_RESTORE"); %>" name="load" onclick="return uploadClick()"></font></td>
    <input type="hidden" value="/saveconf.asp" name="submit-url">
  </tr>
  </form>
  <form action=/boaform/formSaveConfig method=POST name="resetConfig">
  <tr>
    <td width="70%"><font size=2><b><% multilang("469" "LANG_RESET_SETTINGS_TO_DEFAULT"); %>:</b></font></td>
    <td width="30%"><font size=2>
    <input type="submit" value="<% multilang("181" "LANG_RESET"); %>" name="reset" onclick="return resetClick()"></font></td>
    <input type="hidden" value="/saveconf.asp" name="submit-url">
   </tr>
  </form>
</table>
</blockquote>
</body>
</html>

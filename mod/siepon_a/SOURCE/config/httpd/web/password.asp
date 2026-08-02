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
<meta HTTP-EQUIV='Pragma' CONTENT='no-cache'>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("474" "LANG_PASSWORD_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function saveChanges()
{
   if ( document.password.newpass.value != document.password.confpass.value) {
 alert("<% multilang("1954" "LANG_PASSWORD_IS_NOT_MATCHED_PLEASE_TYPE_THE_SAME_PASSWORD_BETWEEN_NEW_AND_CONFIRMED_BOX"); %>");
 document.password.newpass.focus();
 return false;
  }
  if ( document.password.newpass.value.length == 0) {
 alert("<% multilang("1955" "LANG_PASSWORD_CANNOT_BE_EMPTY_PLEASE_TRY_IT_AGAIN"); %>");
 document.password.newpass.focus();
 return false;
  }
  if (includeSpace(document.password.newpass.value)) {
 alert("<% multilang("1958" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PASSWORD_PLEASE_TRY_IT_AGAIN"); %>");
 document.password.newpass.focus();
 return false;
  }
  if (checkString(document.password.newpass.value) == 0) {
 alert("<% multilang("1959" "LANG_INVALID_PASSWORD"); %>");
 document.password.newpass.focus();
 return false;
  }
  return true;
}
</SCRIPT>
</head>
<BODY>
<blockquote>
<h2><font color="#0000FF"><% multilang("474" "LANG_PASSWORD_CONFIGURATION"); %></font></h2>
<form action=/boaform/formPasswordSetup method=POST name="password">
 <table border="0" cellspacing="4" width="500">
  <tr><td><font size=2>
 <% multilang("470" "LANG_PAGE_DESC_SET_ACCOUNT_PASSWORD"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
  </table>
  <table border="0" cellspacing="4" width="500">
    <tr>
      <td width="20%"><font size=2><b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b>
      <select size="1" name="userMode">
      <% checkWrite("userMode"); %>
      </select>
      </td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("471" "LANG_OLD_PASSWORD"); %>:</b></td>
      <td width="50%"><font size=2><input type="password" name="oldpass" size="20" maxlength="22"></td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("472" "LANG_NEW_PASSWORD"); %>:</b></td>
      <td width="50%"><font size=2><input type="password" name="newpass" size="20" maxlength="22"></td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("473" "LANG_CONFIRMED_PASSWORD"); %>:</b></td>
      <td width="50%"><font size=2><input type="password" name="confpass" size="20" maxlength="22"></td>
    </tr>
  </table>
   <input type="hidden" value="/password.asp" name="submit-url">
  <p><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">&nbsp;&nbsp;</p>
</form>
<blockquote>
</body>
</html>

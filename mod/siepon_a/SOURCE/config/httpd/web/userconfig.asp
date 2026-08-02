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
<title><% multilang("48" "LANG_USER_ACCOUNT"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
selected=0;
sdefault = 0;
function saveChanges()
{
  /*if (document.userconfig.username.value == "admin" ||
  		document.userconfig.username.value == "user") {
	alert("<% multilang(LANG_CONFLICT_USER_NAME); %>");
	document.userconfig.newpass.focus();
	return false;
  }*/
  if (document.userconfig.username.value.length > 0 &&
    document.userconfig.newpass.value.length == 0) {
 alert("<% multilang("1955" "LANG_PASSWORD_CANNOT_BE_EMPTY_PLEASE_TRY_IT_AGAIN"); %>");
 document.userconfig.newpass.focus();
 return false;
  }
   if (document.userconfig.newpass.value != document.userconfig.confpass.value) {
 alert("<% multilang("2336" "LANG_PASSWORD_IS_NOT_MATCHED_PLEASE_TYPE_THE_SAME_PASSWORD_BETWEEN__NEW_AND__CONFIRMED_BOX"); %>");
 document.userconfig.newpass.focus();
 return false;
  }
  if (includeSpace(document.userconfig.username.value)) {
 alert("<% multilang("1956" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_USER_NAME_PLEASE_TRY_IT_AGAIN"); %>");
 document.userconfig.username.focus();
 return false;
  }
  if (checkString(document.userconfig.username.value) == 0) {
 alert("<% multilang("1957" "LANG_INVALID_USER_NAME"); %>");
 document.userconfig.username.focus();
 return false;
  }
  if (includeSpace(document.userconfig.newpass.value)) {
 alert("<% multilang("1958" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_PASSWORD_PLEASE_TRY_IT_AGAIN"); %>");
 document.userconfig.newpass.focus();
 return false;
  }
  if (checkString(document.userconfig.newpass.value) == 0) {
 alert("<% multilang("1959" "LANG_INVALID_PASSWORD"); %>");
 document.userconfig.newpass.focus();
 return false;
  }
  if (sdefault == 1)
  document.userconfig.privilege.disabled = false;
  return true;
}
function modifyClick()
{
 if (!selected) {
  alert("<% multilang("1986" "LANG_PLEASE_SELECT_AN_ENTRY_TO_MODIFY"); %>");
  return false;
 }
 /*if (document.userconfig.oldpass.value != document.userconfig.hiddenpass.value) {
		alert("<% multilang(LANG_INCORRECT_OLD_PASSWORD_PLEASE_TRY_IT_AGAIN); %>");
		document.userconfig.oldpass.focus();
		return false;
	}*/
 return saveChanges();
}
function delClick()
{
 if (!selected) {
  alert("<% multilang("1987" "LANG_PLEASE_SELECT_AN_ENTRY_TO_DELETE"); %>");
  return false;
 }
 if (document.userconfig.username.value == document.userconfig.suser.value ||
    document.userconfig.username.value == document.userconfig.nuser.value) {
  alert("<% multilang("2338" "LANG_THE_ACCOUNT_CANNOT_BE_DELETED"); %>");
  return false;
 }
 return true;
}
//function postEntry(user, priv, pass)
function postEntry(user, priv)
{
 document.userconfig.privilege.value = priv;
 if (user == document.userconfig.suser.value || user == document.userconfig.nuser.value) {
  document.userconfig.privilege.disabled = true;
  sdefault = 1;
  //document.userconfig.username.disabled = true;
 }
 else {
  document.userconfig.privilege.disabled = false;
  //document.userconfig.username.disabled = false;
 }
 document.userconfig.oldpass.disabled = false;
 document.userconfig.username.value = user;
//	document.userconfig.hiddenpass.value = pass;
 selected = 1;
}
function disablePriv()
{
 document.userconfig.privilege.value = 0;
 document.userconfig.privilege.disabled = true;
}
function resetConfig()
{
//	disablePriv();
 document.userconfig.privilege.value = 0;
 document.userconfig.privilege.disabled = false;
 document.userconfig.oldpass.disabled = true;
}
function checkAction()
{
//	disablePriv();
//	if (document.userconfig.hiddenpass.value.length == 0)
 if (!selected)
  document.userconfig.oldpass.disabled = true;
}
</SCRIPT>
</head>
<BODY>
<blockquote>
<h2><font color="#0000FF"><% multilang("48" "LANG_USER_ACCOUNT"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formAccountConfig method=POST name="userconfig">
 <table border="0" cellspacing="4" width="500">
  <tr><td><font size=2>
 <% multilang("734" "LANG_THIS_PAGE_IS_USED_TO_ADD_USER_ACCOUNT_TO_ACCESS_THE_WEB_SERVER_OF_THE_DEVICE_EMPTY_USER_NAME_OR_PASSWORD_IS_NOT_ALLOWED"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
 </table>
 <table border="0" cellspacing="4" width="500">
    <tr>
      <td width="20%"><font size=2><b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</b></td>
      <td width="50%"><font size=2><input type="text" name="username" size="20" maxlength="30"></td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("735" "LANG_PRIVILEGE"); %>:</b></td>
      <td width="50%">
      <select size="1" name="privilege">
      <option value="0"><% multilang("736" "LANG_USER"); %></option>
      <option value="1"><% multilang("737" "LANG_SUPPORT"); %></option>
      <option value="2"><% multilang("43" "LANG_ADMIN"); %></option>
      </select>
      </td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("471" "LANG_OLD_PASSWORD"); %>:</b></td>
      <td width="50%"><font size=2><input type="password" name="oldpass" size="20" maxlength="30"></td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("472" "LANG_NEW_PASSWORD"); %>:</b></td>
      <td width="50%"><font size=2><input type="password" name="newpass" size="20" maxlength="30"></td>
    </tr>
    <tr>
      <td width="20%"><font size=2><b><% multilang("473" "LANG_CONFIRMED_PASSWORD"); %>:</b></td>
      <td width="50%"><font size=2><input type="password" name="confpass" size="20" maxlength="30"></td>
    </tr>
  </table>
  <p><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="adduser" onClick="return saveChanges()">
  <input type="submit" value="<% multilang("261" "LANG_MODIFY"); %>" name="modify" onClick="return modifyClick()">
<input type="submit" value="<% multilang("239" "LANG_DELETE"); %>" name="deluser" onClick="return delClick()">
  <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset" onClick="resetConfig()"></p>
  <br><br>
<table border=0 width="500">
  <tr><font size=2><b><% multilang("48" "LANG_USER_ACCOUNT"); %><% multilang("1046" "LANG_TABLE_2"); %>:</b></font></tr>
  <% accountList(); %>
</table>
  <br>
   <input type="hidden" name="suser" value=<% getInfo("super-user"); %>>
   <input type="hidden" name="nuser" value=<% getInfo("normal-user"); %>>
   <input type="hidden" value="/userconfig.asp" name="submit-url">
<script>
 checkAction();
</script>
</form>
<blockquote>
</body>
</html>

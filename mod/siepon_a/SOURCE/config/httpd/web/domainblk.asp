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
<title><% multilang("19" "LANG_DOMAIN_BLOCKING"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function addClick()
{
 if (document.domainblk.blkDomain.value=="") {
  alert('<% multilang("2061" "LANG_PLEASE_ENTER_THE_BLOCKED_DOMAIN"); %>');
  document.domainblk.blkDomain.focus();
  return false;
 }
 if ( document.domainblk.blkDomain.value.length == 0 ) {
  if ( !confirm('<% multilang("2422" "LANG_DOMAIN_STRING_IS_EMPTY_NPLEASE_ENTER_THE_BLOCKED_DOMAIN"); %>') ) {
   document.domainblk.blkDomain.focus();
   return false;
    }
  else
   return true;
   }
   if ( includeSpace(document.domainblk.blkDomain.value)) {
  alert('<% multilang("2062" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_BLOCKED_DOMAIN_PLEASE_TRY_IT_AGAIN"); %>');
  document.domainblk.blkDomain.focus();
  return false;
  }
 if (checkString(document.domainblk.blkDomain.value) == 0) {
  alert('<% multilang("2063" "LANG_INVALID_BLOCKED_DOMAIN"); %>');
  document.domainblk.blkDomain.focus();
  return false;
 }
 return true;
}
function disableDelButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.domainblk.delDomain);
 disableButton(document.domainblk.delAllDomain);
  }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("19" "LANG_DOMAIN_BLOCKING"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formDOMAINBLK method=POST name="domainblk">
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("348" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_BLOCKED_DOMAIN_HERE_YOU_CAN_ADD_DELETE_THE_BLOCKED_DOMAIN"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr>
 <td><font size=2><b><% multilang("19" "LANG_DOMAIN_BLOCKING"); %>:</b></td>
 <td><font size=2>
  <input type="radio" value="0" name="domainblkcap" <% checkWrite("domainblk-cap0"); %>><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="domainblkcap" <% checkWrite("domainblk-cap1"); %>><% multilang("207" "LANG_ENABLE"); %>
 </td>
 <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply">&nbsp;&nbsp;</td>
  </tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
 <font size=2><b><% multilang("349" "LANG_DOMAIN"); %>:</b>
 <input type="text" name="blkDomain" size="15" maxlength="50">&nbsp;&nbsp;
 <input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addDomain" onClick="return addClick()">
<br>
<br>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><font size=2><b><% multilang("19" "LANG_DOMAIN_BLOCKING"); %><% multilang("197" "LANG_CONFIGURATION"); %>:</b></font></tr>
  <% showDOMAINBLKTable(); %>
</table>
<br>
 <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delDomain" onClick="return deleteClick()">&nbsp;&nbsp;
 <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delAllDomain" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
 <input type="hidden" value="/domainblk.asp" name="submit-url">
 <script>
  <% checkWrite("domainNum"); %>
  </script>
</form>
</blockquote>
</body>
</html>

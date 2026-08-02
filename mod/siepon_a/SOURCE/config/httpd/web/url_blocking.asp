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
<title>URL <% multilang("341" "LANG_BLOCKING"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function addClick()
{
 return true;
}
function addFQDNClick()
{
 if (document.url.urlFQDN.value=="") {
  alert("<% multilang("2329" "LANG_PLEASE_ENTER_THE_BLOCKED_FQDN"); %>");
  document.url.urlFQDN.focus();
  return false;
 }
 if (document.url.urlFQDN.value.length == 0 ) {
  if (!confirm('<% multilang("2433" "LANG_FQDN_IS_EMPTY_NPLEASE_ENTER_THE_BLOCKED_FQDN"); %>') ) {
   document.url.urlFQDN.focus();
   return false;
    }
  else
   return true;
   }
   if (includeSpace(document.url.urlFQDN.value)) {
  alert("<% multilang("2330" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_BLOCKED_FQDN_PLEASE_TRY_IT_AGAIN"); %>");
  document.url.urlFQDN.focus();
  return false;
  }
 if (checkString(document.url.urlFQDN.value) == 0) {
  alert("<% multilang("2331" "LANG_INVALID_BLOCKED_FQDN"); %>");
  document.url.urlFQDN.focus();
  return false;
 }
 return true;
}
function addKeywordClick()
{
 if (document.url.Keywd.value=="") {
  alert("<% multilang("2332" "LANG_PLEASE_ENTER_THE_BLOCKED_KEYWORD"); %>");
  document.url.Keywd.focus();
  return false;
 }
 if (document.url.Keywd.value.length == 0 ) {
  if (!confirm('<% multilang("2434" "LANG_KEYWORD_IS_EMPTY_NPLEASE_ENTER_THE_BLOCKED_KEYWORD"); %>') ) {
   document.url.Keywd.focus();
   return false;
    }
  else
   return true;
   }
   if (includeSpace(document.url.Keywd.value)) {
  alert("<% multilang("2333" "LANG_CANNOT_ACCEPT_SPACE_CHARACTER_IN_BLOCKED_KEYWORD_PLEASE_TRY_IT_AGAIN"); %>");
  document.url.Keywd.focus();
  return false;
  }
 if (checkString(document.url.Keywd.value) == 0) {
  alert("<% multilang("2334" "LANG_INVALID_BLOCKED_KEYWORD"); %>");
  document.url.Keywd.focus();
  return false;
 }
 return true;
}
function disableDelFQDNButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.url.delFQDN);
 disableButton(document.url.delFAllQDN);
  }
}
function disableDelKeywdButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.url.delKeywd);
 disableButton(document.url.delAllKeywd);
  }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">URL<% multilang("341" "LANG_BLOCKING"); %></font></h2>
<form action=/boaform/formURL method=POST name="url">
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("342" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_BLOCKED_FQDN_SUCH_AS_TW_YAHOO_COM_AND_FILTERED_KEYWORD_HERE_YOU_CAN_ADD_DELETE_FQDN_AND_FILTERED_KEYWORD"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr>
 <td><font size=2><b>URL <% multilang("341" "LANG_BLOCKING"); %>:</b></td>
 <td><font size=2>
  <input type="radio" value="0" name="urlcap" <% checkWrite("url-cap0"); %>><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="urlcap" <% checkWrite("url-cap1"); %>><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
 </td>
 <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply">&nbsp;&nbsp;<td>
</tr>
<tr><td colspan=3><hr size=1 noshade align=top></td></tr>
</table>
<tr>
 <td><font size=2><b><% multilang("343" "LANG_FQDN"); %>:</b></font><td>
 <td><input type="text" name="urlFQDN" size="15" maxlength="125">&nbsp;&nbsp;</td>
 <td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addFQDN" onClick="return addFQDNClick()"></td>
</tr>
<br>
<br>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><font size=2><b>URL <% multilang("341" "LANG_BLOCKING"); %><% multilang("1046" "LANG_TABLE_2"); %>:</b></font></tr>
  <% showURLTable(); %>
</table>
<br>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr><td>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delFQDN" onClick="return deleteClick()">&nbsp;&nbsp;
<input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delFAllQDN" onClick="return deleteAllClick()"></td>
</tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
 <script>
  <% checkWrite("FQDNNum"); %>
  </script>
<tr>
 <td><font size=2><b><% multilang("345" "LANG_KEYWORD"); %>:</b></td>
 <td><input type="text" name="Keywd" size="15" maxlength="18">&nbsp;&nbsp;</td>
 <td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addKeywd" onClick="return addKeywordClick()"></td>
</tr>
<br>
<br>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><font size=2><b><% multilang("346" "LANG_KEYWORD_FILTERING_TABLE"); %>:</b></font></tr>
  <% showKeywdTable(); %>
</table>
<br>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delKeywd" onClick="return deleteClick()">&nbsp;&nbsp;
<input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delAllKeywd" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
<input type="hidden" value="/url_blocking.asp" name="submit-url">
 <script>
  <% checkWrite("keywdNum"); %>
  </script>
</form>
</blockquote>
</body>
</html>

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
<title>RIP <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
var ifnum;
function selected()
{
 document.rip.ripDel.disabled = false;
}
function resetClicked()
{
 document.rip.ripDel.disabled = true;
}
function disableDelButton()
{
 if (verifyBrowser() != "ns") {
  disableButton(document.rip.ripDel);
  disableButton(document.rip.ripDelAll);
 }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">RIP <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formRip method=POST name="rip">
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("357" "LANG_ENABLE_THE_RIP_IF_YOU_ARE_USING_THIS_DEVICE_AS_A_RIP_ENABLED_DEVICE_TO_COMMUNICATE_WITH_OTHERS_USING_THE_ROUTING_INFORMATION_PROTOCOL_THIS_PAGE_IS_USED_TO_SELECT_THE_INTERFACES_ON_YOUR_DEVICE_IS_THAT_USE_RIP_AND_THE_VERSION_OF_THE_PROTOCOL_USED"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr>
  <td><font size=2><b><% multilang("28" "LANG_RIP"); %>:</b></font></td>
  <td><font size=2>
   <input type="radio" value="0" name="rip_on" <% checkWrite("rip-on-0"); %> ><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
   <input type="radio" value="1" name="rip_on" <% checkWrite("rip-on-1"); %> ><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
  </font></td>
  <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="ripSet"></td>
 </tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr>
  <td><font size=2><b><% multilang("52" "LANG_INTERFACE"); %>:</b></td>
  <td>
   <select name="rip_if">
   <option value="65535">br0</option>
   <% if_wan_list("rt"); %>
   </select>
  </td>
 </tr>
 <tr>
  <td><font size=2><b><% multilang("358" "LANG_RECEIVE_MODE"); %>:</b></td>
  <td>
   <select size="1" name="receive_mode">
   <option value="0"><% multilang("276" "LANG_NONE"); %></option>
   <option value="1">RIP1</option>
   <option value="2">RIP2</option>
   <option value="3"><% multilang("327" "LANG_BOTH"); %></option>
   </select>
  </td>
 </tr>
 <tr>
  <td><font size=2><b><% multilang("359" "LANG_SEND_MODE"); %>:</b></td>
  <td>
   <select size="1" name="send_mode">
   <option value="0"><% multilang("276" "LANG_NONE"); %></option>
   <option value="1">RIP1</option>
   <option value="2">RIP2</option>
   <option value="4">RIP1COMPAT</option>
  </select>
  </td>
 </tr>
</table>
 <br>
 <td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="ripAdd"></td>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <tr><td><hr size=1 noshade align=top></td></tr>
 <tr><td><font size=2><b><% multilang("360" "LANG_RIP_CONFIG_TABLE"); %>:</b></font></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
 <% showRipIf(); %>
</table>
 <br>
 <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="ripDel" onClick="return deleteClick()">&nbsp;&nbsp;
 <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="ripDelAll" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
 <input type="hidden" value="/rip.asp" name="submit-url">
 <script>
  <% checkWrite("ripNum"); %>
 </script>
</form>
</blockquote>
</body>
</html>

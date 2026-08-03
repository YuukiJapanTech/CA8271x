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
<title><% multilang("411" "LANG_OTHER_ADVANCED"); %> <% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function saveChanges()
{
 if ( checkDigit(document.others.ltime.value) == 0) {
  alert("<% multilang("2227" "LANG_INVALID_LEASE_TIME"); %>");
  document.others.ltime.focus();
  return false;
 }
 return true;
}
function ipptSelected()
{
 document.others.ltime.value = <% getInfo("ippt-lease"); %>;
 //if (document.others.ippt.value == 255) {
 if (document.others.ippt.value == 65535) {
  document.others.ltime.disabled = true;
  document.others.lan_acc.disabled = true;
  /* open it, if need singlePC
		// check dependency
		if (document.others.singlePC.checked && document.others.IPtype[1].checked) {
			document.others.singlePC.checked=false;
			document.others.IPtype[0].disabled = true;
		}
		document.others.IPtype[1].disabled = true;
		*/
 }
 else {
  document.others.ltime.disabled = false;
  document.others.lan_acc.disabled = false;
  /* open it, if need singlePC
		// check dependency
		if (document.others.singlePC.checked)
			document.others.IPtype[1].disabled = false;
		*/
 }
}
function singlePCSelected()
{
 if (document.others.singlePC.checked) {
  document.others.IPtype[0].disabled = false;
  // check dependency
  //if (document.others.ippt.value==255) {
  if (document.others.ippt.value==65535) {
   document.others.IPtype[1].disabled = true;
   document.others.IPtype[0].checked = true;
  }
  else
   document.others.IPtype[1].disabled = false;
 }
 else {
  document.others.IPtype[0].disabled = true;
  document.others.IPtype[1].disabled = true;
 }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("411" "LANG_OTHER_ADVANCED"); %> <% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formOthers method=POST name="others">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("412" "LANG_HERE_YOU_CAN_SET_SOME_OTHER_ADVANCED_SETTINGS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
      <th align=left><font size=2><b><% multilang("413" "LANG_IP_PASSTHROUGH"); %>:</b></th>
      <td>
       <select name="ippt" onChange=ipptSelected()>
         <option value=65535><% multilang("276" "LANG_NONE"); %></option>
          <% if_wan_list("p2p"); %>
       </select>&nbsp;&nbsp;&nbsp;&nbsp;
       <% multilang("414" "LANG_LEASE_TIME"); %>:&nbsp;&nbsp;
        <input type="text" name="ltime" size=10 maxlength=9 value="<% getInfo("ippt-lease"); %>"> <% multilang("287" "LANG_SECONDS"); %>
      </td>
  </tr>
  <tr>
      <th></th>
      <td>
        <input type="checkbox" name="lan_acc" value="ON">&nbsp;&nbsp;<% multilang("415" "LANG_ALLOW_LAN_ACCESS"); %>
      </td>
  </tr>
</table>
  <br>
      <input type=submit value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">
<!--
      <input type=reset value="Undo" name="reset">
-->
      <input type=hidden value="/others.asp" name="submit-url">
  <script>
 ifIdx = <% getInfo("ippt-itf"); %>;
 document.others.ippt.selectedIndex = -1;
 for( i = 0; i < document.others.ippt.options.length; i++ )
 {
  if( ifIdx == document.others.ippt.options[i].value )
   document.others.ippt.selectedIndex = i;
 }
 <% initPage("others"); %>
  </script>
</form>
</blockquote>
</body>
</html>

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
<title>MAC <% multilang("309" "LANG_FILTERING"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function skip () { this.blur(); }
function addClick()
{
//  if (document.formFilterAdd.srcmac.value=="" )
//	return true;
  if (document.formFilterAdd.srcmac.value=="" && document.formFilterAdd.dstmac.value=="") {
 alert('<% multilang("2109" "LANG_INPUT_MAC_ADDRESS"); %>');
 return false;
  }
 if (document.formFilterAdd.srcmac.value != "") {
  if (!checkMac(document.formFilterAdd.srcmac, 0))
   return false;
 }
 if (document.formFilterAdd.dstmac.value != "") {
  if (!checkMac(document.formFilterAdd.dstmac, 0))
   return false;
 }
 return true;
/*  var str = document.formFilterAdd.srcmac.value;
  if ( str.length < 12) {
	alert("Input MAC address is not complete. It should be 12 digits in hex.");
	document.formFilterAdd.srcmac.focus();
	return false;
  }

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert("Invalid MAC address. It should be in hex number (0-9 or a-f).");
	document.formFilterAdd.srcmac.focus();
	return false;
  }
  return true;*/
}
function disableDelButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.formFilterDel.deleteSelFilterMac);
 disableButton(document.formFilterDel.deleteAllFilterMac);
  }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("1065" "LANG_MAC_FILTERING_FOR_BRIDGE_MODE"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr><td><font size=2>
 <% multilang("324" "LANG_ENTRIES_IN_THIS_TABLE_ARE_USED_TO_RESTRICT_CERTAIN_TYPES_OF_DATA_PACKETS_FROM_YOUR_LOCAL_NETWORK_TO_INTERNET_THROUGH_THE_GATEWAY_USE_OF_SUCH_FILTERS_CAN_BE_HELPFUL_IN_SECURING_OR_RESTRICTING_YOUR_LOCAL_NETWORK"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
<form action=/boaform/admin/formFilter method=POST name="formFilterDefault">
<tr><td><font size=2><b><% multilang("311" "LANG_OUTGOING_DEFAULT_ACTION"); %></b>&nbsp;&nbsp;
    <input type="radio" name="outAct" value=0 <% checkWrite("macf_out_act0"); %>><% multilang("312" "LANG_DENY"); %>&nbsp;&nbsp;
    <input type="radio" name="outAct" value=1 <% checkWrite("macf_out_act1"); %>><% multilang("313" "LANG_ALLOW"); %>&nbsp;&nbsp;
</font></td><tr>
<tr><td><font size=2><b><% multilang("314" "LANG_INCOMING_DEFAULT_ACTION"); %></b>&nbsp;&nbsp;
    <input type="radio" name="inAct" value=0 <% checkWrite("macf_in_act0"); %>><% multilang("312" "LANG_DENY"); %>&nbsp;&nbsp;
    <input type="radio" name="inAct" value=1 <% checkWrite("macf_in_act1"); %>><% multilang("313" "LANG_ALLOW"); %>&nbsp;&nbsp;
 <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="setMacDft">&nbsp;&nbsp;
 <input type="hidden" value="/admin/fw-macfilter.asp" name="submit-url">
</font></td></tr>
</form>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<form action=/boaform/admin/formFilter method=POST name="formFilterAdd">
<br>
<tr>
 <td><font size=2>
 <b><% multilang("315" "LANG_DIRECTION"); %>: </b></font>
 </td>
 <td>
 <select name=dir>
  <option select value=0><% multilang("316" "LANG_OUTGOING"); %></option>
  <option value=1><% multilang("317" "LANG_INCOMING"); %></option>
 </select>
 </td>
</tr>
<tr>
 <td><font size=2>
 <b><% multilang("319" "LANG_SOURCE"); %> <% multilang("72" "LANG_MAC_ADDRESS"); %>: </b></font>
 </td>
 <td>
 <input type="text" name="srcmac" size="15" maxlength="12">&nbsp;&nbsp;
 </td>
</tr>
<tr>
 <td><font size=2>
        <b><% multilang("320" "LANG_DESTINATION"); %> <% multilang("72" "LANG_MAC_ADDRESS"); %>: </b></font>
        </td>
        <td>
        <input type="text" name="dstmac" size="15" maxlength="12">&nbsp;&nbsp;
 </td>
</tr>
<tr>
 <td><font size=2>
 <b> <% multilang("318" "LANG_RULE_ACTION"); %></b></font>
 </td>
 <td><font size=2>
 <input type="radio" name="filterMode" value="Deny" checked>&nbsp;&nbsp;<% multilang("312" "LANG_DENY"); %>
 <input type="radio" name="filterMode" value="Allow">&nbsp;&nbsp;<% multilang("313" "LANG_ALLOW"); %></b><br></font>
 </td>
 <td><font size=2>
 <input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addFilterMac" onClick="return addClick()">&nbsp;&nbsp;
 <input type="hidden" value="/admin/fw-macfilter.asp" name="submit-url"></font>
 </td>
</tr>
<tr><td colspan=3><hr size=1 noshade align=top></td></tr>
</form>
</table>
<form action=/boaform/admin/formFilter method=POST name="formFilterDel">
 <table border="0" width=500>
 <tr><font size=2><b><% multilang("321" "LANG_CURRENT_FILTER_TABLE"); %>:</b></font></tr>
 <% macFilterList(); %>
 </table>
 <br>
 <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="deleteSelFilterMac" onClick="return deleteClick()">&nbsp;&nbsp;
 <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="deleteAllFilterMac" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
 <input type="hidden" value="/admin/fw-macfilter.asp" name="submit-url">
 <script>
  <% checkWrite("macFilterNum"); %>
 </script>
</form>
</blockquote>
</body>
</html>

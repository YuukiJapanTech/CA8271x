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
<title><% multilang("176" "LANG_WLAN_ACCESS_CONTROL"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function skip () { this.blur(); }
function addClick()
{
//  var str = document.formWlAcAdd.mac.value;
// if (!document.formWlAcAdd.wlanAcEnabled.checked)
//  if (!document.formWlAcAdd.wlanAcEnabled.selectedIndex)
//	return true;
 if (!checkMac(document.formWlAcAdd.mac, 1))
  return false;
 return true;
/*  if ( str.length == 0)
  	return true;

  if ( str.length < 12) {
	alert("<% multilang(LANG_INVALID_MAC_ADDR_NOT_COMPLETE); %>");
	document.formWlAcAdd.mac.focus();
	return false;
  }

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert("<% multilang(LANG_INVALID_MAC_ADDRESS_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F_); %>");
	document.formWlAcAdd.mac.focus();
	return false;
  }
  return true;*/
}
function disableDelButton()
{
 disableButton(document.formWlAcDel.deleteSelFilterMac);
 disableButton(document.formWlAcDel.deleteAllFilterMac);
}
function enableAc()
{
  enableTextField(document.formWlAcAdd.mac);
}
function disableAc()
{
  disableTextField(document.formWlAcAdd.mac);
}
function updateState()
{
  if(wlanDisabled || wlanMode == 1 || wlanMode ==2){
 disableDelButton();
 //disableButton(document.formWlAcDel.reset);
 disableButton(document.formWlAcAdd.reset);
 disableButton(document.formWlAcAdd.setFilterMode);
 disableButton(document.formWlAcAdd.addFilterMac);
   disableTextField(document.formWlAcAdd.wlanAcEnabled);
   disableAc();
  }
  else{
    if (document.formWlAcAdd.wlanAcEnabled.selectedIndex) {
 enableButton(document.formWlAcAdd.reset);
 enableButton(document.formWlAcAdd.addFilterMac);
  enableAc();
    }
    else {
 disableButton(document.formWlAcAdd.reset);
 disableButton(document.formWlAcAdd.addFilterMac);
   disableAc();
    }
  }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("176" "LANG_WLAN_ACCESS_CONTROL"); %></font></h2>
<form action=/boaform/admin/formWlAc method=POST name="formWlAcAdd">
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><font size=2>
 <% multilang("177" "LANG_PAGE_DESC_WLAN_ALLOW_DENY_LIST"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr>
   <td><font size=2><b>
    <% multilang("111" "LANG_MODE"); %>: &nbsp;&nbsp;&nbsp;&nbsp;
 <select size="1" name="wlanAcEnabled" onclick="updateState()">
          <option value=0 ><% multilang("146" "LANG_DISABLED"); %></option>
          <option value=1 selected ><% multilang("178" "LANG_ALLOW_LISTED"); %></option>
          <option value=2 ><% multilang("179" "LANG_DENY_LISTED"); %></option>
        </select></font></b>
   </td>
   <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="setFilterMode">&nbsp;&nbsp;</td>
</tr>
<tr>
</table>
<td>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><hr size=1 noshade align=top></td></tr>
<tr><p><font size=2><b><% multilang("72" "LANG_MAC_ADDRESS"); %>: </b><input type="text" name="mac" size="15" maxlength="12">
     &nbsp;&nbsp;(ex. 00E086710502)</font></p>
     <p><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addFilterMac" onClick="return addClick()">&nbsp;&nbsp;
        <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset">&nbsp;&nbsp;&nbsp;
        <input type="hidden" value="/admin/wlactrl.asp" name="submit-url">
        <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
     </p>
  </form>
<br>
<form action=/boaform/admin/formWlAc method=POST name="formWlAcDel">
  <table border="0" width=440>
  <tr><font size=2><b><% multilang("182" "LANG_CURRENT_ACCESS_CONTROL_LIST"); %>:</b></font></tr>
  <% wlAcList(); %>
  </table>
  <br>
  <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="deleteSelFilterMac" onClick="return deleteClick()">&nbsp;&nbsp;
  <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="deleteAllFilterMac" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
  <input type="hidden" value="/admin/wlactrl.asp" name="submit-url">
  <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
 <script>
  <% checkWrite("wlanAcNum"); %>
 <% initPage("wlactrl"); %>
 updateState();
 </script>
</form>
</blockquote>
</body>
</html>

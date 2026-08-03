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
<title><% multilang("999" "LANG_VLAN_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
var vlan_manu_pri= <% fmvlan_checkWrite("vlan_manu_tag_pri"); %>;
function vlan_cfg_type_change()
{
 with (document.forms[0])
 {
  if(vlan_cfg_type[0].checked == true){
   disableRadioGroup(vlan_manu_mode);
   vlan_manu_tag_pri.disabled = true;
   disableTextField(vlan_manu_tag_vid);
  }
  else{
   enableRadioGroup(vlan_manu_mode);
   vlan_manu_mode_change();
  }
 }
}
function vlan_manu_mode_change()
{
 with (document.forms[0])
 {
  if(vlan_manu_mode[1].checked == true){
   vlan_manu_tag_pri.disabled = false;
   enableTextField(vlan_manu_tag_vid);
  }
  else{
   vlan_manu_tag_pri.disabled = true;
   disableTextField(vlan_manu_tag_vid);
  }
 }
}
function on_init()
{
 with (document.forms[0])
 {
  vlan_manu_tag_pri.value = vlan_manu_pri + 1;
  if(vlan_cfg_type[0].checked == true)
   refresh.disabled = false;
  else
   refresh.disabled = true;
 }
 vlan_cfg_type_change();
}
function saveChanges()
{
 with (document.forms[0])
 {
  if (vlan_cfg_type[1].checked == true) {
   if(vlan_manu_mode[1].checked == true){
    if(vlan_manu_tag_vid.value == ""){
     alert("<% multilang("2339" "LANG_VID_CANNOT_BE_EMPTY"); %>");
     vlan_manu_tag_vid.focus();
     return false;
    }
    if(vlan_manu_tag_pri.value == 0){
     alert("<% multilang("2340" "LANG_VLAN_PRIORITY_CANNOT_BE_EMPTY"); %>");
     vlan_manu_tag_pri.focus();
     return false;
    }
   }
  }
 }
 return true;
}
</SCRIPT>
</head>
<body onLoad="on_init();">
<blockquote>
<h2><font color="#0000FF"><% multilang("999" "LANG_VLAN_SETTINGS"); %></font></h2>
<form action=/boaform/formVlan method=POST name="vlan">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("1000" "LANG_PAGE_DESC_CONFIGURE_VLAN_SETTINGS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr>
<td width="10%"><input type="radio" name="vlan_cfg_type" value=0 disabled="disabled" OnClick="vlan_cfg_type_change()" <% fmvlan_checkWrite("vlan_cfg_type_auto"); %> ></td>
<td width="10%"><font size=2><b><% multilang("136" "LANG_AUTO"); %></b></td>
<td><input type="submit" value="<% multilang("362" "LANG_REFRESH"); %>" name="refresh"></td>
</tr>
<tr style="vertical-align:top"><td height="50px" width="10%"></td><td height="50px" colspan=2><% omciVlanInfo(); %></td></tr>
<tr>
<td width="10%"><input type="radio" name="vlan_cfg_type" value=1 disabled="disabled" OnClick="vlan_cfg_type_change()" <% fmvlan_checkWrite("vlan_cfg_type_manual"); %>></td>
<td colspan="2" width="90%"><font size=2><b><% multilang("391" "LANG_MANUAL"); %></b></td>
</tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr>
<td width="10%"></td>
<td width="10%"><input type="radio" name="vlan_manu_mode" value=0 OnClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_trans"); %>></td>
<td width="80%"><font size=2><b><% multilang("1001" "LANG_TRANSPARENT_MODE"); %></b></td>
</tr>
<tr>
<td width="10%"></td>
<td width="10%"><input type="radio" name="vlan_manu_mode" value=1 OnClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_tag"); %>></td>
<td width="80%"><font size=2><b><% multilang("1002" "LANG_TAGGING_MODE"); %></b>:
<input type="text" name="vlan_manu_tag_vid" size="5" maxlength="5" value="<% fmvlan_checkWrite("vlan_manu_tag_vid"); %>">[0~4095]&nbsp;&nbsp;
<% multilang("1005" "LANG_VLAN_PRIORITY"); %>:
 <select style="WIDTH: 60px" name="vlan_manu_tag_pri">
 <option value="0" > </option>
 <option value="1" > 0 </option>
 <option value="2" > 1 </option>
 <option value="3" > 2 </option>
 <option value="4" > 3 </option>
 <option value="5" > 4 </option>
 <option value="6" > 5 </option>
 <option value="7" > 6 </option>
 <option value="8" > 7 </option>
 </select>
</td>
</tr>
<tr>
<td width="10%"></td>
<td width="10%"><input type="radio" name="vlan_manu_mode" value=2 OnClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_srv"); %>></td>
<td width="80%"><font size=2><b><% multilang("1003" "LANG_REMOTE_ACCESS_MODE"); %></b></td>
</tr>
<tr>
<td width="10%"></td>
<td width="10%"><input type="radio" name="vlan_manu_mode" value=3 OnClick="vlan_manu_mode_change()" <% fmvlan_checkWrite("vlan_manu_mode_sp"); %>></td>
<td width="80%"><font size=2><b><% multilang("1004" "LANG_SPECIAL_CASE_MODE"); %></b></td>
</tr>
</table>
<br>
      <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">
      <input type="hidden" value="/vlan.asp" name="submit-url">
</form>
</blockquote>
</body>
</html>

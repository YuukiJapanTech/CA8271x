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
<title><% multilang("549" "LANG_ADDRESS_MAPPING_RULE"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function saveClick()
{
 var ls, le, gs, ge;
 var ls1, le1, gs1, ge1;
 var ls2, le2, gs2, ge2;
 var ls3, le3, gs3, ge3;
 ls = getDigit(document.addressMap.lsip.value,4);
   le = getDigit(document.addressMap.leip.value,4);
   gs = getDigit(document.addressMap.gsip.value,4);
   ge = getDigit(document.addressMap.geip.value,4);
   ls1 = getDigit(document.addressMap.lsip.value,1);
   le1 = getDigit(document.addressMap.leip.value,1);
   gs1 = getDigit(document.addressMap.gsip.value,1);
   ge1 = getDigit(document.addressMap.geip.value,1);
   ls2 = getDigit(document.addressMap.lsip.value,2);
   le2 = getDigit(document.addressMap.leip.value,2);
   gs2 = getDigit(document.addressMap.gsip.value,2);
   ge2 = getDigit(document.addressMap.geip.value,2);
   ls3 = getDigit(document.addressMap.lsip.value,3);
   le3 = getDigit(document.addressMap.leip.value,3);
   gs3 = getDigit(document.addressMap.gsip.value,3);
   ge3 = getDigit(document.addressMap.geip.value,3);
 if ( document.addressMap.addressMapType.selectedIndex == 0 ) {
  //alert('You select none.');			
   } else if ( document.addressMap.addressMapType.selectedIndex == 1 ) {
  //alert('You select One-to-One.');  		
    if ( !checkIP(document.addressMap.lsip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.gsip)) {
     return false;
    }
   } else if ( document.addressMap.addressMapType.selectedIndex == 2 ) {
  //alert('You select Many-to-One.');  		
    if ( !checkIP(document.addressMap.lsip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.leip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.gsip)) {
     return false;
    }
    if ( ls1 != le1 || ls2 != le2 || ls3 != le3 ) {
   alert('<% multilang("1946" "LANG_LOCAL_START_IP_DOMAIN_IS_DIFFERENT_FROM_LOCAL_END_IP"); %>');
     document.addressMap.lsip.focus();
     return false;
    }
    if ( le <= ls ) {
   alert('<% multilang("1947" "LANG_INVALID_LOCAL_IP_RANGE"); %>');
     document.addressMap.lsip.focus();
     return false;
    }
   } else if ( document.addressMap.addressMapType.selectedIndex == 3 ) {
  //alert('You select Many-to-Many.');		
  if ( !checkIP(document.addressMap.lsip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.leip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.gsip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.geip)) {
     return false;
    }
    if ( ls1 != le1 || ls2 != le2 || ls3 != le3 ) {
   alert('<% multilang("1946" "LANG_LOCAL_START_IP_DOMAIN_IS_DIFFERENT_FROM_LOCAL_END_IP"); %>');
     document.addressMap.lsip.focus();
     return false;
    }
    if ( gs1 != ge1 || gs2 != ge2 || gs3 != ge3 ) {
   alert('<% multilang("1949" "LANG_GLOBAL_START_IP_DOMAIN_IS_DIFFERENT_FROM_GLOBAL_END_IP"); %>');
     document.addressMap.gsip.focus();
     return false;
    }
    if ( le <= ls ) {
   alert('<% multilang("1947" "LANG_INVALID_LOCAL_IP_RANGE"); %>');
     document.addressMap.lsip.focus();
     return false;
    }
    if ( ge <= gs ) {
   alert('<% multilang("1950" "LANG_INVALID_GLOBAL_IP_RANGE"); %>');
     document.addressMap.gsip.focus();
     return false;
    }
   } else if ( document.addressMap.addressMapType.selectedIndex == 4 ) {
  //alert('You select Many One-to-Many.');		
  if ( !checkIP(document.addressMap.lsip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.gsip)) {
     return false;
    }
    if ( !checkIP(document.addressMap.geip)) {
     return false;
    }
    if ( gs1 != ge1 || gs2 != ge2 || gs3 != ge3 ) {
   alert('<% multilang("1949" "LANG_GLOBAL_START_IP_DOMAIN_IS_DIFFERENT_FROM_GLOBAL_END_IP"); %>');
     document.addressMap.gsip.focus();
     return false;
    }
    if ( ge <= gs ) {
   alert('<% multilang("1950" "LANG_INVALID_GLOBAL_IP_RANGE"); %>');
     document.addressMap.gsip.focus();
     return false;
    }
   }
   //alert("Please commit and reboot this system for take effect the address mapping rule!");
}
function checkState()
{
 if ( document.addressMap.addressMapType.selectedIndex == 0 ) {
  //alert('You select none.');		
  disableTextField(document.addressMap.lsip);
    disableTextField(document.addressMap.leip);
    disableTextField(document.addressMap.gsip);
    disableTextField(document.addressMap.geip);
    //document.addressMap.lsip.value = "N/A";		
   } else if ( document.addressMap.addressMapType.selectedIndex == 1 ) {
  //alert('You select One-to-One.');				
    enableTextField(document.addressMap.lsip);
    disableTextField(document.addressMap.leip);
    enableTextField(document.addressMap.gsip);
    disableTextField(document.addressMap.geip);
   } else if ( document.addressMap.addressMapType.selectedIndex == 2 ) {
  //alert('You select Many-to-One.');				
    enableTextField(document.addressMap.lsip);
    enableTextField(document.addressMap.leip);
    enableTextField(document.addressMap.gsip);
    disableTextField(document.addressMap.geip);
   } else if ( document.addressMap.addressMapType.selectedIndex == 3 ) {
  //alert('You select Many-to-Many.');
  enableTextField(document.addressMap.lsip);
    enableTextField(document.addressMap.leip);
    enableTextField(document.addressMap.gsip);
    enableTextField(document.addressMap.geip);
   } else if ( document.addressMap.addressMapType.selectedIndex == 4 ) {
  //alert('You select Many One-to-Many.');
  enableTextField(document.addressMap.lsip);
    disableTextField(document.addressMap.leip);
    enableTextField(document.addressMap.gsip);
    enableTextField(document.addressMap.geip);
   }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("549" "LANG_ADDRESS_MAPPING_RULE"); %></font></h2>
<form action=/boaform/formAddressMap method=POST name="addressMap">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><font size=2>
    <% multilang("550" "LANG_THIS_PAGE_IS_USED_TO_SET_AND_CONFIGURE_THE_ADDRESS_MAPPING_RULE_FOR_YOUR_DEVICE"); %>
  </tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
      <td width="30%"><font size=2><b>Type:</b>
      <select size="1" name="addressMapType" onChange="checkState()">
      <% checkWrite("addressMapType"); %>
      </select>
      </td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("556" "LANG_LOCAL_START_IP"); %>:</b></td>
      <td width="70%"><input type="text" name="lsip" size="15" maxlength="15" value=<% getInfo("local-s-ip"); %>></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("557" "LANG_LOCAL_END_IP"); %>:</b></td>
      <td width="70%"><input type="text" name="leip" size="15" maxlength="15" value=<% getInfo("local-e-ip"); %>></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("558" "LANG_GLOBAL_START_IP"); %>:</b></td>
      <td width="70%"><input type="text" name="gsip" size="15" maxlength="15" value=<% getInfo("global-s-ip"); %>></td>
  </tr>
  <tr>
      <td width="30%"><font size=2><b><% multilang("559" "LANG_GLOBAL_END_IP"); %>:</b></td>
      <td width="70%"><input type="text" name="geip" size="15" maxlength="15" value=<% getInfo("global-e-ip"); %>></td>
  </tr>
</table>
  <br>
      <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveClick()">&nbsp;&nbsp;
      <input type="hidden" value="/addr_mapping.asp" name="submit-url">
  <script>
 <% initPage("addressMap"); %>
  </script>
 </form>
</blockquote>
</body>
</html>

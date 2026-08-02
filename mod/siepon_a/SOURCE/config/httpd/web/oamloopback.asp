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
<title><% multilang("419" "LANG_ATM_LOOPBACK_DIAGNOSTICS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function isHexDecimal(num)
{
 var string="1234567890ABCDEF";
 if (string.indexOf(num.toUpperCase()) != -1)
 {
  return true;
 }
 return false;
}
function isValidID(val)
{
 for(var i=0; i < val.length; i++)
 {
  if ((!isHexDecimal(val.charAt(i))))
  {
   return false;
  }
 }
 return true;
}
function goClick()
{
 retval = isValidID(document.oamlb.oam_llid.value);
 if((document.oamlb.oam_llid.value=="")|| (retval==false))
 {
  alert("<% multilang("2226" "LANG_INVALID_LOOPBACK_LOCATION_ID"); %>");
  document.oamlb.oam_llid.focus()
  return false
 }
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("419" "LANG_ATM_LOOPBACK_DIAGNOSTICS"); %> - <% multilang("420" "LANG_CONNECTIVITY_VERIFICATION"); %></font></h2>
<form action=/boaform/formOAMLB method=POST name="oamlb">
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("421" "LANG_CONNECTIVITY_VERIFICATION_IS_SUPPORTED_BY_THE_USE_OF_THE_ATM_OAM_LOOPBACK_CAPABILITY_FOR_BOTH_VP_AND_VC_CONNECTIONS_THIS_PAGE_IS_USED_TO_PERFORM_THE_VCC_LOOPBACK_FUNCTION_TO_CHECK_THE_CONNECTIVITY_OF_THE_VCC"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr><td>
      <font size=2><b><% multilang("185" "LANG_SELECT"); %> PVC:</b></font>
        <% oamSelectList(); %>
      </td>
  </tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
  <tr>
   <td>
  <font size=2><b><% multilang("422" "LANG_FLOW_TYPE"); %>:</b>
  </td>
  <td>
  <input type="radio" value="3" name="oam_flow"><% multilang("1051" "LANG_F4_SEGMENT"); %>&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="radio" value="4" name="oam_flow" ><% multilang("1052" "LANG_F4_END_TO_END"); %>
  </td>
  </tr>
  <tr>
   <td>&nbsp;</td>
  <td>
  <input type="radio" value="0" name="oam_flow" checked><% multilang("423" "LANG_F5_SEGMENT"); %>&nbsp;&nbsp;&nbsp;&nbsp;
  <input type="radio" value="1" name="oam_flow" ><% multilang("424" "LANG_F5_END_TO_END"); %>
  </td>
  </tr>
  <tr><td colspan=2>
      <font size=2><b><% multilang("425" "LANG_LOOPBACK_LOCATION_ID"); %>: </b>
      <input type="text" name="oam_llid" value="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" size=40 maxlength=32 onFocus="this.select()">
      </td>
  </tr>
</table>
  <br>
      <input type="submit" value=" <% multilang("418" "LANG_GO"); %> ! " name="go" onClick="return goClick()">
      <input type="hidden" value="/oamloopback.asp" name="submit-url">
</form>
</blockquote>
</body>
</html>

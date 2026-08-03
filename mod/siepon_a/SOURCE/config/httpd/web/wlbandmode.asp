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
<title><% multilang("646" "LANG_WIRELESS_BAND_MODE"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("646" "LANG_WIRELESS_BAND_MODE"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><font size=2>
  <!--Support switchable 802.11n dual-band radio frequency (2.4GHz/5GHz). -->
  <% multilang("647" "LANG_THIS_PAGE_IS_USED_TO_SWITCH_802_11N_SINGLE_BAND_OR_DUAL_BAND_RADIO_FREQUENCY"); %>
  </tr>
  <tr><hr size=1 noshade align=top></tr>
</table>
<form action=/boaform/admin/formWlanBand2G5G method=POST name="fmWlBandMode">
<table border="0" width=500>
<!--
 <tr>
  <td width ="35%" valign="top">
  <input type="radio" value="0" name="wlBandMode" onClick="" ></input>
  <font size=2> <b> 2.4GHz Only: </b> </font>
  </td>
  <td>
   <font size=2>This mode supports 802.11 b/g/n wireless network connection.</font>
  </td>
 </tr>
 <td colspan="2" height="10"></tr>
 <tr>
  <td width ="35%" valign="top">
  <input type="radio" value="1" name="wlBandMode" onClick="" ></input>
  <font size=2> <b> 5GHz Only: </b> </font>
  </td>
  <td>
   <font size=2>This mode supports both 802.11 a/n wireless network connection.</font>
  </td>
 </tr>
 <td colspan="2" height="10"></tr>
-->
 <tr>
  <td width ="35%" valign="top">
  <input type="radio" value="1" name="wlBandMode" onClick="" ></input>
  <font size=2> <b> <% multilang("648" "LANG_SIGNLE_BAND"); %>: </b> </font>
  </td>
  <td>
   <font size=2><% multilang("649" "LANG_THIS_MODE_CAN_SUPPORT_SINGLE_MODE_BY_2X2"); %></font>
  </td>
 </tr>
 <tr><td colspan="2" height="10"></tr>
<% checkWrite("onoff_dmdphy_comment_start"); %>
 <tr>
  <td width ="35%" valign="top">
  <input type="radio" value="0" name="wlBandMode" onClick="" ></input>
  <font size=2> <b> <% multilang("650" "LANG_DUAL_BAND"); %>: </b> </font>
  </td>
  <td>
   <font size=2><% multilang("651" "LANG_THIS_MODE_CAN_SIMULTANEOUSLY_SUPPORT_802_11_A_B_G_N_WIRELESS_NETWORK_CONNECTION"); %></font>
  </td>
 </tr>
<% checkWrite("onoff_dmdphy_comment_end"); %>
</table>
<script>
 wlBandMode = <% checkWrite("wlanBand2G5GSelect"); %> ;
 var radioIndex=0;
 while(document.fmWlBandMode.wlBandMode[radioIndex])
 {
  if(document.fmWlBandMode.wlBandMode[radioIndex].value == wlBandMode)
  {
   document.fmWlBandMode.wlBandMode[radioIndex].defaultChecked= true;
   document.fmWlBandMode.wlBandMode[radioIndex].checked= true;
   break;
  }
  radioIndex++;
 }
</script>
  <input type="hidden" value="/admin/wlbandmode.asp" name="submit-url">
  <p><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply">
&nbsp;&nbsp;
  <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="set" >
&nbsp;&nbsp;
</form>
</blockquote>
</font>
</body>
</html>

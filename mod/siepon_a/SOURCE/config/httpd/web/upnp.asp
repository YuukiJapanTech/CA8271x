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
<title>UPnP <% multilang("197" "LANG_CONFIGURATION"); %></title>
<SCRIPT>
function proxySelection()
{
 if (document.upnp.daemon[0].checked) {
  document.upnp.ext_if.disabled = true;
  if(typeof(document.upnp.tr_064_sw) != "undefined")
  {
   document.upnp.tr_064_sw[0].disabled = true;
   document.upnp.tr_064_sw[1].disabled = true;
  }
 }
 else {
  document.upnp.ext_if.disabled = false;
  if(typeof(document.upnp.tr_064_sw) != "undefined")
  {
   document.upnp.tr_064_sw[0].disabled = false;
   document.upnp.tr_064_sw[1].disabled = false;
  }
 }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2 style="color:#0000FF">UPnP <% multilang("197" "LANG_CONFIGURATION"); %></h2>
<form action=/boaform/formUpnp method=POST name="upnp">
<table border=0 width="500" cellspacing=4 cellpadding=4 style="font-size: 13">
  <tr>
   <td>
    <% multilang("356" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_UPNP_THE_SYSTEM_ACTS_AS_A_DAEMON_WHEN_YOU_ENABLE_IT_AND_SELECT_WAN_INTERFACE_UPSTREAM_THAT_WILL_USE_UPNP"); %>
   </td>
  </tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=4 style="font-size: 13">
 <tr>
  <td><b><% multilang("27" "LANG_UPNP"); %>:</b></td>
  <td>
   <input type="radio" value="0" name="daemon" <% checkWrite("upnp0"); %> onClick="proxySelection()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
   <input type="radio" value="1" name="daemon" <% checkWrite("upnp1"); %> onClick="proxySelection()"><% multilang("207" "LANG_ENABLE"); %>
  </td>
 </tr>
 <% checkWrite("tr064_switch"); %>
 <tr>
  <td><b><% multilang("354" "LANG_WAN_INTERFACE"); %>:</b></td>
  <td>
   <select name="ext_if" <% checkWrite("upnp0d"); %>>
    <% if_wan_list("rt"); %>
   </select>
  </td>
 </tr>
 <tr>
  <td>
   <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save">
  </td>
 </tr>
</table>
<input type="hidden" value="/upnp.asp" name="submit-url">
<script>
 initUpnpDisable = document.upnp.daemon[0].checked;
 ifIdx = <% getInfo("upnp-ext-itf"); %>;
 document.upnp.ext_if.selectedIndex = -1;
 for( i = 0; i < document.upnp.ext_if.options.length; i++ )
 {
  if( ifIdx == document.upnp.ext_if.options[i].value )
   document.upnp.ext_if.selectedIndex = i;
 }
 proxySelection();
</script>
</form>
</blockquote>
</body>
</html>

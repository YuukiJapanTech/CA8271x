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
<title><% multilang("26" "LANG_IGMP_PROXY"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<SCRIPT>
function proxySelection()
{
 if (document.igmp.proxy[0].checked) {
  document.igmp.proxy_if.disabled = true;
 }
 else {
  document.igmp.proxy_if.disabled = false;
 }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("26" "LANG_IGMP_PROXY"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<form action=/boaform/formIgmproxy method=POST name="igmp">
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("667" "LANG_IGMP_PROXY_ENABLES_THE_SYSTEM_TO_ISSUE_IGMP_HOST_MESSAGES_ON_BEHALF_OF_HOSTS_THAT_THE_SYSTEM_DISCOVERED_THROUGH_STANDARD_IGMP_INTERFACES_THE_SYSTEM_ACTS_AS_A_PROXY_FOR_ITS_HOSTS_WHEN_YOU_ENABLE_IT_BY_DOING_THE_FOLLOWS"); %>:
    <br>. <% multilang("668" "LANG_ENABLE_IGMP_PROXY_ON_WAN_INTERFACE_UPSTREAM_WHICH_CONNECTS_TO_A_ROUTER_RUNNING_IGMP"); %>
    <br>. <% multilang("669" "LANG_ENABLE_IGMP_ON_LAN_INTERFACE_DOWNSTREAM_WHICH_CONNECTS_TO_ITS_HOSTS"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
  <tr>
      <td width><font size=2><b><% multilang("26" "LANG_IGMP_PROXY"); %>:</b></td>
      <td width><font size=2>
       <input type="radio" value="0" name="proxy" <% checkWrite("igmpProxy0"); %> onClick="proxySelection()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
      <input type="radio" value="1" name="proxy" <% checkWrite("igmpProxy1"); %> onClick="proxySelection()"><% multilang("207" "LANG_ENABLE"); %>
      </td>
  </tr>
  <tr>
      <td><font size=2><b><% multilang("670" "LANG_PROXY_INTERFACE"); %>:</b></td>
      <td>
       <select name="proxy_if" <% checkWrite("igmpProxy0d"); %>>
          <% if_wan_list("rt"); %>
       </select>
      </td>
      <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save">&nbsp;&nbsp;</td>
  </tr>
</table>
      <input type="hidden" value="/igmproxy.asp" name="submit-url">
<script>
 ifIdx = <% getInfo("igmp-proxy-itf"); %>;
 if (ifIdx != 255)
  document.igmp.proxy_if.value = ifIdx;
 else
  document.igmp.proxy_if.selectedIndex = 0;
</script>
</form>
</blockquote>
</body>
</html>

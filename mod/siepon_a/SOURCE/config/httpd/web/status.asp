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
<! Copyright (c) Realtek Semiconductor Corp., 2003. All Rights Reserved. >
<head>
<META HTTP-EQUIV=Refresh CONTENT="10; URL=status.asp">
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("54" "LANG_DEVICE_STATUS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
var getObj = null;
function modifyClick(url)
{
 var wide=600;
 var high=400;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=480;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, 'Status_Modify', settings );
}
function disButton(id)
{
       getObj = document.getElementById(id);
       window.setTimeout("getObj.disabled=true", 100);
 return false;
}
function on_init()
{
 // Mason Yu for IPv6
 if (!<% checkWrite("IPv6Show"); %>) {
  if (document.getElementById) // DOM3 = IE5, NS6
  {
   document.getElementById('ipv6DefaultGW').style.display = 'none';
  }
  else {
   if (document.layers == false) // IE4
   {
    document.all.ipv6DefaultGW.style.display = 'none';
   }
  }
 }
 return true;
}
</script>
</head>
<body onLoad="on_init();">
<blockquote>
<h2><b><font color="#0000FF"><% multilang("54" "LANG_DEVICE_STATUS"); %></font></b></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr><td><font size=2>
 <% multilang("55" "LANG_PAGE_DESC_DEVICE_STATUS_SETTING"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top><br></td></tr>
</table>
<form action=/boaform/admin/formStatus method=POST name="status2">
<table width=400 border=0>
  <tr>
    <td width=100% colspan="2" bgcolor="#008000"><font color="#FFFFFF" size=2><b><% multilang("56" "LANG_SYSTEM"); %></b></font></td>
  </tr>
  <tr bgcolor="#EEEEEE">
    <td width=40%><font size=2><b><% multilang("79" "LANG_DEVICE_NAME"); %></b></td>
    <td width=60%><font size=2><% getInfo("name"); %></td>
  </tr>
  <tr bgcolor="#DDDDDD">
    <td width=40%><font size=2><b><% multilang("58" "LANG_UPTIME"); %></b></td>
    <td width=60%><font size=2><% getInfo("uptime"); %></td>
  </tr>
<!--
  <tr bgcolor="#EEEEEE">
    <td width=40%><font size=2><b><% multilang("59" "LANG_DATE"); %>/<% multilang("60" "LANG_TIME"); %></b></td>
    <td width=60%><font size=2><% getInfo("date"); %></td>
  </tr>
-->
  <tr bgcolor="#EEEEEE">
    <td width=40%><font size=2><b><% multilang("61" "LANG_FIRMWARE_VERSION"); %></b></td>
    <td width=60%><font size=2><% getInfo("fwVersion"); %></td>
  </tr>
</table>
<table width=400 border=0>
  <% DSLStatus(); %>
  <tr>
    <td width=100% colspan="2" bgcolor="#008000"><font color="#FFFFFF" size=2><b><% multilang("6" "LANG_LAN"); %><% multilang("197" "LANG_CONFIGURATION"); %></b></font></td>
  </tr>
  <tr bgcolor="#EEEEEE">
    <td width=40%><font size=2><b><% multilang("69" "LANG_IP_ADDRESS"); %></b></td>
    <td width=60%><font size=2><% getInfo("lan-ip"); %></td>
  </tr>
  <tr bgcolor="#DDDDDD">
    <td width=40%><font size=2><b><% multilang("70" "LANG_SUBNET_MASK"); %></b></td>
    <td width=60%><font size=2><% getInfo("lan-subnet"); %></td>
  </tr>
  <% DHCPSrvStatus(); %>
  <tr bgcolor="#DDDDDD">
    <td width=40%><font size=2><b><% multilang("72" "LANG_MAC_ADDRESS"); %></b></td>
    <td width=60%><font size=2><% getInfo("elan-Mac"); %></td>
  </tr>
</table>
</form>
<br>
<form action=/boaform/admin/formStatus method=POST name="status">
<table width=600 border=0 <% checkWrite("bridge-only"); %>>
 <tr>
    <td width=100% colspan=7 bgcolor="#008000"><font color="#FFFFFF" size=2><b><% multilang("10" "LANG_WAN"); %><% multilang("197" "LANG_CONFIGURATION"); %></b></font></td>
  </tr>
  <% wanConfList(); %>
</table>
  <% wan3GTable(); %>
  <% wanPPTPTable(); %>
  <% wanL2TPTable(); %>
  <% wanIPIPTable(); %>
  <input type="hidden" value="/admin/status.asp" name="submit-url">
  <input type="submit" value="<% multilang("362" "LANG_REFRESH"); %>" name="refresh">&nbsp;&nbsp;
  <!--
  <input type="button" value="Modify" name="modify" onClick="modifyClick('/admin/date.asp')">
  -->
</form>
</blockquote>
</body>
</html>

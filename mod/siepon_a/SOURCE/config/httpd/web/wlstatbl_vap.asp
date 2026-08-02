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
<meta http-equiv="Content-Type" content="text/html">
<meta HTTP-EQUIV='Pragma' CONTENT='no-cache'>
<meta HTTP-equiv="Cache-Control" content="no-cache">
<title>Active Wireless Client Table</title>
<script type="text/javascript" src="share.js"> </script>
<style>
.on {display:on}
.off {display:none}
</style>
<script language="JavaScript" type="text/javascript">
var vap_num;
var vap_id;
function init()
{
 var url_tmp = location.href;
 var url_tmp_1 = url_tmp.split("?");
 var found = url_tmp_1[1].indexOf("%3D");
 if (found == -1) {
  var id = url_tmp_1[1].split("=");
  vap_id = id[1]*1;
 }
 else
  vap_id = parseInt(url_tmp_1[1].substring(5, 6));
 get_by_id("submit-url").value = "/admin/wlstatbl_vap.asp?id="+vap_id;
}
</script>
</head>
<body>
<form action=/boaform/admin/formWirelessVAPTbl method=POST name="formWirelessVAPTbl">
<input type="hidden" value="" id="submit-url" name="submit-url">
<blockquote>
<h2><font color="#0000FF">Active Wireless Client Table
<script>
 init();
 if (vap_id == 1) {
  document.write(" - AP1");
  vap_num = 1;
 }
 else if (vap_id == 2) {
  document.write(" - AP2");
  vap_num = 2;
 }
 else if (vap_id == 3) {
  document.write(" - AP3");
  vap_num = 3;
 }
 else if (vap_id == 4) {
  document.write(" - AP4");
  vap_num = 4;
 }
 else {
  alert("<% multilang("2380" "LANG_WE_CAN_NOT_PROCESS_AP_THE_WINDOWS_WILL_BE_CLOSED"); %>");
  window.opener=null;
  window.open("","_self");
  window.close();
 }
</script>
</font></h2>
<table border=0 width="600" cellspacing=0 cellpadding=0>
 <tr><font size=2>
 This table shows the MAC address, transmission, receiption packet counters and encrypted
 status for each associated wireless client.
 </tr>
 <tr><hr size=1 noshade align=top></tr>
</table>
<script> if (vap_num != 1) document.write("</table><span class = \"off\" ><table>"); </script>
<table border='1' width="600">
<tr bgcolor=#7f7f7f>
<td width="100"><font size=2><b>MAC Address</b></td>
<td width="60"><font size=2><b>Mode</b></td>
<td width="60"><font size=2><b>Tx Packet</b></td>
<td width="60"><font size=2><b>Rx Packet</b></td>
<td width="60"><font size=2><b>Tx Rate (Mbps)</b></td>
<td width="60"><font size=2><b>Power Saving</b></td>
<td width="60"><font size=2><b>Expired Time (s)</b></td></tr>
<% wirelessVAPClientList(" ", "1"); %>
<script> if (vap_num != 1) document.write("</table></span><table border='1' width=\"600\">"); </script>
<script> if (vap_num != 2) document.write("</table><span class = \"off\" ><table>"); </script>
<tr bgcolor=#7f7f7f><td width="100"><font size=2><b>MAC Address</b></td>
<td width="60"><font size=2><b>Mode</b></td>
<td width="60"><font size=2><b>Tx Packet</b></td>
<td width="60"><font size=2><b>Rx Packet</b></td>
<td width="60"><font size=2><b>Tx Rate (Mbps)</b></td>
<td width="60"><font size=2><b>Power Saving</b></td>
<td width="60"><font size=2><b>Expired Time (s)</b></td></tr>
<% wirelessVAPClientList(" ", "2"); %>
<script> if (vap_num != 2) document.write("</table></span><table border='1' width=\"600\">"); </script>
<script> if (vap_num != 3) document.write("</table><span class = \"off\" ><table>"); </script>
<tr bgcolor=#7f7f7f><td width="100"><font size=2><b>MAC Address</b></td>
<td width="60"><font size=2><b>Mode</b></td>
<td width="60"><font size=2><b>Tx Packet</b></td>
<td width="60"><font size=2><b>Rx Packet</b></td>
<td width="60"><font size=2><b>Tx Rate (Mbps)</b></td>
<td width="60"><font size=2><b>Power Saving</b></td>
<td width="60"><font size=2><b>Expired Time (s)</b></td></tr>
<% wirelessVAPClientList(" ", "3"); %>
<script> if (vap_num != 3) document.write("</table></span><table border='1' width=\"600\">"); </script>
<script> if (vap_num != 4) document.write("</table><span class = \"off\" ><table>"); </script>
<tr bgcolor=#7f7f7f><td width="100"><font size=2><b>MAC Address</b></td>
<td width="60"><font size=2><b>Mode</b></td>
<td width="60"><font size=2><b>Tx Packet</b></td>
<td width="60"><font size=2><b>Rx Packet</b></td>
<td width="60"><font size=2><b>Tx Rate (Mbps)</b></td>
<td width="60"><font size=2><b>Power Saving</b></td>
<td width="60"><font size=2><b>Expired Time (s)</b></td></tr>
<% wirelessVAPClientList(" ", "4"); %>
<script> if (vap_num != 4) document.write("</table></span><table border='1' width=\"600\">"); </script>
</table>
  <p><input type="submit" value="Refresh" name="refresh">&nbsp;&nbsp;
  <input type="button" value=" Close " name="close" onClick="javascript: window.close();"></p>
</form>
</blockquote>
</body>
</html>

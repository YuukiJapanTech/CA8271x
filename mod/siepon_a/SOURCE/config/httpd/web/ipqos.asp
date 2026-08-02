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
<title>IP QoS <% multilang("37" "LANG_CLASSIFICATION"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function adminClick()
{
 var i, num;
 num = document.qos.elements.length;
 if (document.qos.qosen[0].checked) {
  for (i=2; i<num; i++) {
   document.qos[i].disabled = true;
  }
  document.qos.admin.disabled = false;
  document.qos[num-1].disabled = false;
 }
 else {
  for (i=2; i<num; i++) {
   document.qos[i].disabled = false;
  }
  if (document.qos.prot.value != 1 && document.qos.prot.value != 2) {
   document.qos.sport.disabled = true;
   document.qos.dport.disabled = true;
  }
  if (document.qos.dscpenable[0].checked) {
   document.qos.dscp.disabled = true;
   document.qos.ipprio.disabled = false;
   document.qos.tos.disabled = false;
  }
  else {
   document.qos.dscp.disabled = false;
   document.qos.ipprio.disabled = true;
   document.qos.tos.disabled = true;
  }
 }
}
function addClick()
{
 if (document.qos.sip.value == "" && document.qos.smask.value == "" && document.qos.sport.value == ""
  && document.qos.dip.value == "" && document.qos.dmask.value == "" && document.qos.dport.value == ""
  && document.qos.prot.value == 0 && document.qos.phyport.value == 0) {
  alert('<% multilang("2135" "LANG_TRAFFIC_CLASSIFICATION_RULES_CAN_T_BE_EMPTY"); %>');
  document.qos.sip.focus();
  return false;
 }
 //var i;  
 if ( document.qos.sip.value!="" ) {
  if (!checkHostIP(document.qos.sip, 0))
   return false;
  if ( document.qos.smask.value != "" ) {
   if (!checkNetmask(document.qos.smask, 0))
    return false;
  }
  /*if ( validateKey( document.qos.sip.value ) == 0 ) {
			alert("Invalid source IP address.");
			document.qos.sip.focus();
			return false;
		}
		for (i=1; i<=4; i++) {
			if ( !checkDigitRange(document.qos.sip.value,i,0,255) ) {
				alert('Invalid source IP address.');
				document.qos.sip.focus();
				return false;
			}
		}
		
		if ( document.qos.smask.value!="" ) {
			if ( validateKey( document.qos.smask.value ) == 0 ) {
				alert("Invalid source IP mask.");
				document.qos.smask.focus();
				return false;
			}
			for (i=1; i<=4; i++) {
				if ( !checkDigitRange(document.qos.smask.value,i,0,255) ) {
					alert('Invalid source IP mask.');
					document.qos.smask.focus();
					return false;
				}
			}
		}*/
 }
 if ( document.qos.dip.value!="" ) {
  if (!checkHostIP(document.qos.dip, 0))
   return false;
  if ( document.qos.dmask.value != "" ) {
   if (!checkNetmask(document.qos.dmask, 0))
    return false;
  }
  /*if ( validateKey( document.qos.dip.value ) == 0 ) {
			alert("Invalid destination IP address.");
			document.qos.dip.focus();
			return false;
		}
		for (i=1; i<=4; i++) {
			if ( !checkDigitRange(document.qos.dip.value,i,0,255) ) {
				alert('Invalid destinationIP address.');
				document.qos.dip.focus();
				return false;
			}
		}
		
		if ( document.qos.dmask.value!="" ) {
			if ( validateKey( document.qos.dmask.value ) == 0 ) {
				alert("Invalid destination IP mask.");
				document.qos.dmask.focus();
				return false;
			}
			for (i=1; i<=4; i++) {
				if ( !checkDigitRange(document.qos.dmask.value,i,0,255) ) {
					alert('Invalid destination IP mask.');
					document.qos.dmask.focus();
					return false;
				}
			}
		}*/
 }
 if ( document.qos.sport.value!="" ) {
  if ( validateKey( document.qos.sport.value ) == 0 ) {
   alert('<% multilang("2047" "LANG_INVALID_SOURCE_PORT"); %>');
   document.qos.sport.focus();
   return false;
  }
  d1 = getDigit(document.qos.sport.value, 1);
  if (d1 > 65535 || d1 < 1) {
   alert('<% multilang("2048" "LANG_INVALID_SOURCE_PORT_NUMBER"); %>');
   document.qos.sport.focus();
   return false;
  }
 }
 if ( document.qos.dport.value!="" ) {
  if ( validateKey( document.qos.dport.value ) == 0 ) {
   alert('<% multilang("2049" "LANG_INVALID_DESTINATION_PORT"); %>');
   document.qos.dport.focus();
   return false;
  }
  d1 = getDigit(document.qos.dport.value, 1);
  if (d1 > 65535 || d1 < 1) {
   alert('<% multilang("2050" "LANG_INVALID_DESTINATION_PORT_NUMBER"); %>');
   document.qos.dport.focus();
   return false;
  }
 }
 if( document.qos.queuekey.value ==-1) {
  alert('<% multilang("2136" "LANG_PLEASE_SELECT_QUEUE"); %>');
  document.qos.queuekey.focus();
  return false;
 }
 return true;
}
function dscpClick()
{
 if (document.qos.dscpenable[0].checked) {
  document.qos.dscp.disabled = true;
  document.qos.ipprio.disabled = false;
  document.qos.tos.disabled = false;
 }
 else {
  document.qos.dscp.disabled = false;
  document.qos.ipprio.disabled = true;
  document.qos.tos.disabled = true;
 }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">IP QoS <% multilang("37" "LANG_CLASSIFICATION"); %></font></h2>
<table border=0 width=600 cellspacing=4 cellpadding=0>
<font size=2>
<% multilang("576" "LANG_CONFIGURATION_OF_CLASSIFICATION_TABLE_FOR_IPQOS"); %>
</font>
<tr><td colspan=4><hr size=1 noshade align=top></td></tr>
<form action=/boaform/formIPQoS method=POST name=qos>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<tr>
 <td><font size=2><b>IP QoS:</b>
  <input type="radio" name=qosen value=0 onClick="return adminClick()"><% multilang("146" "LANG_DISABLED"); %>&nbsp;&nbsp;
  <input type="radio" name=qosen value=1 onClick="return adminClick()"><% multilang("145" "LANG_ENABLED"); %>
 </td>
  <% dft_qos(); %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <td><input type=submit value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name=admin></td>
</tr>
</table>
<table border=0 width=600 cellspacing=4 cellpadding=0>
<tr><td colspan=4><hr size=1 noshade align=top></td></tr>
<tr>
<th colspan=4><u><% multilang("566" "LANG_SPECIFY_TRAFFIC_CLASSIFICATION_RULES"); %></u></th>
</tr>
<tr>
 <td colspan=4>
  <align=left><font size=2><b><% multilang("319" "LANG_SOURCE"); %> IP:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
  <align=left><input type=text name=sip size=20 maxlength=15>
  <align=left><font size=2><b><% multilang("577" "LANG_NETMASK"); %>: </b>
  <align=left><input type=text name=smask size=20 maxlength=15>
  <align=left><font size=2><b><% multilang("172" "LANG_PORT"); %>: </b>
  <align=left><input type=text name=sport size=6 maxlength=5>
 </td>
</tr>
<tr>
 <td colspan=4><font size=2><b><% multilang("320" "LANG_DESTINATION"); %> IP: </b>
  <align=left><input type=text name=dip size=20 maxlength=15>
  <align=left><font size=2><b><% multilang("577" "LANG_NETMASK"); %>: </b>
  <align=left><input type=text name=dmask size=20 maxlength=15>
  <align=left><font size=2><b><% multilang("172" "LANG_PORT"); %>: </b>
  <align=left><input type=text name=dport size=6 maxlength=5>
 </td>
</tr>
<tr>
 <td colspan=4><font size=2><b><% multilang("75" "LANG_PROTOCOL"); %>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
 <align=left><select name=prot onClick="return adminClick()">
  <option value=0></option>
  <option value=1>TCP</option>
  <option value=2>UDP</option>
  <option value=3>ICMP</option>
 </select>
 <align=left><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <% multilang("569" "LANG_PHYSICAL_PORT"); %>:</b>
 <align=left><font size=2><select name=phyport>
  <option value=0></option>
  <% if_lan_list("all"); %>
 </select>
 </td>
</tr>
 <% pr_egress(); %>
<tr><th colspan=4>&nbsp;</th></tr>
<tr>
<th colspan=4><u><% multilang("578" "LANG_CLASSIFICATION_RESULTS"); %></u></th>
</tr>
<tr>
 <td align=left><font size=2><b><% multilang("579" "LANG_CLASSQUEUE"); %>:</b></td>
 <td align=left>
 <% pq_egress(); %>
 </td>
 <td align=left><font size=2><b>802.1p_Mark:</b></td>
 <td><select name=m1p>
  <option value=0></option>
  <option value=1>0</option>
  <option value=2>1</option>
  <option value=3>2</option>
  <option value=4>3</option>
  <option value=5>4</option>
  <option value=6>5</option>
  <option value=7>6</option>
  <option value=8>7</option>
 </select>
 </td>
</tr>
<% mark_dscp(); %>
<!--tr>
 <td align=left><font size=2><b>IP Precedence:</b></td>
 <td align=left><select name=ipprio>
  <option value=0></option>
  <option value=1>0</option>
  <option value=2>1</option>
  <option value=3>2</option>
  <option value=4>3</option>
  <option value=5>4</option>
  <option value=6>5</option>
  <option value=7>6</option>
  <option value=8>7</option>
 </select>
 </td>
 <td align=left><font size=2><b>IP Type of Service:</b></td>
 <td align=left><select name=tos>
  <option value=255></option>
  <option value=0>Normal Service</option>
  <option value=2>Minimize Cost</option>
  <option value=4>Maximize Reliability</option>
  <option value=8>Maximize Throughput</option>
  <option value=16>Minimize Delay</option>
 </select>
 </td>
</tr-->
<tr>
 <td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name=addqos onClick="return addClick()"></td>
 <td><input type="hidden" value="/ipqos.asp" name="submit-url"></td>
</tr>
</table>
</form>
</table>
<form action=/boaform/formIPQoS method=POST name=qostbl>
  <table border="0" width=600>
  <tr><font size=2><b>IP QoS <% multilang("572" "LANG_RULES"); %>:</b></font></tr>
  <% ipQosList(); %>
  </table>
  <br>
  <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name=delSel onClick="return deleteClick()">&nbsp;&nbsp;
  <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name=delAll onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
  <input type="hidden" value="/ipqos.asp" name="submit-url">
</form>
<script>
 <% initPage("ipqos"); %>
 adminClick();
</script>
</blockquote>
</body>
</html>

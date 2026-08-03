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
function dscp_st(val, name) {
 this.val = val;
 this.name = name;
}
var dscps=new Array();
dscps.push(new dscp_st(0, ""));
dscps.push(new dscp_st(1, "default(000000)"));
dscps.push(new dscp_st(57, "AF13(001110)"));
dscps.push(new dscp_st(49, "AF12(001100)"));
dscps.push(new dscp_st(41, "AF11(001010)"));
dscps.push(new dscp_st(33, "CS1(001000)"));
dscps.push(new dscp_st(89, "AF23(010110)"));
dscps.push(new dscp_st(81, "AF22(010100)"));
dscps.push(new dscp_st(73, "AF21(010010)"));
dscps.push(new dscp_st(65, "CS2(010000)"));
dscps.push(new dscp_st(121, "AF33(011110)"));
dscps.push(new dscp_st(113, "AF32(011100)"));
dscps.push(new dscp_st(105, "AF31(011010)"));
dscps.push(new dscp_st(97, "CS3(011000)"));
dscps.push(new dscp_st(153, "AF43(100110)"));
dscps.push(new dscp_st(145, "AF42(100100)"));
dscps.push(new dscp_st(137, "AF41(100010)"));
dscps.push(new dscp_st(129, "CS4(100000)"));
dscps.push(new dscp_st(185, "EF(101110)"));
dscps.push(new dscp_st(161, "CS5(101000)"));
dscps.push(new dscp_st(193, "CS6(110000)"));
dscps.push(new dscp_st(225, "CS7(111000)"));
function writeDscpList()
{
 for (var i = 0; i < dscps.length; i++)
 {
  document.writeln('<option value=' + dscps[i].val + '>' + dscps[i].name + '</option>');
 }
}
function onchange_sel1()
{
 //document.qos.s_m1p.value = 0;
}
function onchange_sel2()
{
 with (document.forms[0] )
 {
  prot.value = 0;
  s_dscp.value = 0;
  sip.value = smask.value = sport.value = "";
  dip.value = dmask.value = dport.value = "";
  phyport.value = 0;
 }
}
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
 onchange_sel1();
}
function addClick()
{
 if ((document.qos.sip.value == "") && (document.qos.smask.value == "") && (document.qos.sport.value == "")
  && (document.qos.dip.value == "") && (document.qos.dmask.value == "") && (document.qos.dport.value == "")
  && (document.qos.prot.value == 0) && (document.qos.phyport.value == 0) && (document.qos.s_dscp.value == 0)
  /*&& (document.qos.s_m1p.value == 0)*/) {
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
 }
 if ( document.qos.dip.value!="" ) {
  if (!checkHostIP(document.qos.dip, 0))
   return false;
  if ( document.qos.dmask.value != "" ) {
   if (!checkNetmask(document.qos.dmask, 0))
    return false;
  }
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
function qosClick(url)
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
 window.open( url, '', settings );
}
function enable8021psetting()
{
 if(document.qos.qosdmn.selectedIndex==1)
 {//802.1p
  if (document.getElementById) { // DOM3 = IE5, NS6
   document.getElementById('qos1p').style.display = 'block';
   document.getElementById('qosPred').style.display = 'none';
  } else if (document.layers == false) {// IE4
   document.all.qos1p.style.display = 'block';
   document.all.qosPred.style.display = 'none';
  }
 } else {
  if (document.getElementById) { // DOM3 = IE5, NS6
   document.getElementById('qos1p').style.display = 'none';
   document.getElementById('qosPred').style.display = 'block';
   } else if (document.layers == false) {// IE4
   document.all.qos1p.style.display = 'none';
   document.all.qosPred.style.display = 'block';
   }
 }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">IP QoS <% multilang("37" "LANG_CLASSIFICATION"); %></font></h2>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<tr><td><font size=2>
 <% multilang("564" "LANG_ENTRIES_IN_THIS_TABLE_ARE_USED_TO_ASSIGN_THE_PRECEDENCE_FOR_EACH_INCOMING_PACKET_IF_DISABLE_IP_QOS_TRAFFIC_SHAPING_WILL_BE_EFFECTIVE_OTHERWISE_TRAFFIC_SHAPING_IS_INVALID"); %>
</font></td></tr>
</table>
<td colspan="2"><hr size=1 width=600 noshade align=left></td>
<form action=/boaform/formIPQoS method=POST name=qos>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<tr>
 <td width=20%><font size=2>IP QoS:</td>
 <td width=60%>
  <input type="radio" name=qosen value=0 onClick="return adminClick()"><font size=2><% multilang("146" "LANG_DISABLED"); %>&nbsp;&nbsp;
  <input type="radio" name=qosen value=1 onClick="return adminClick()"><font size=2><% multilang("145" "LANG_ENABLED"); %>
 </td>
</tr>
<tr>
 <td width=20%><font size=2><% multilang("565" "LANG_POLICY"); %>:</td>
 <td width=60%>
  <input type="radio" name=qosPolicy value=0><font size=2>PRIO&nbsp;&nbsp;
  <input type="radio" name=qosPolicy value=1><font size=2>WRR&nbsp;&nbsp;
 </td>
</tr>
<tr>
 <% dft_qos(); %>
 <td><input type=submit value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name=admin></td>
</tr>
</table>
<div id="qos1p" style="display:none">
<table width=500>
<input type="button" value="802.1p Config" name="8021pTbl" onClick="qosClick('/qos_8021p.asp')">
</table>
</div>
<div id="qosPred" style="display:none">
<table width=500>
<input type="button" value="IP Pred Config" name="predTbl" onClick="qosClick('/qos_pred.asp')">
</table>
</div>
<td colspan="2"><hr size=1 width=600 noshade align=left></td>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<tr><td colspan="2"><th colspan=4><u><% multilang("566" "LANG_SPECIFY_TRAFFIC_CLASSIFICATION_RULES"); %></u></th></td></tr>
</table>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<!--<tr><td colSpan="2"><b>SET-1</b></td></tr>-->
<tr>
 <td width="200px"><% multilang("75" "LANG_PROTOCOL"); %>:</td>
 <td><select name=prot style="width:150px " onClick="return adminClick()">
  <option value=0></option>
  <option value=1>TCP</option>
  <option value=2>UDP</option>
  <option value=3>ICMP</option>
 </select>
 </td>
<tr>
<tr>
 <% match_dscp(); %>
</tr>
<tr><td><% multilang("319" "LANG_SOURCE"); %> IP:</td><td><input type=text name=sip size=20 maxlength=15 onChange="onchange_sel1();"></td></tr>
<tr><td><% multilang("567" "LANG_SOURCE_MASK"); %>:</td><td><input type=text name=smask size=20 maxlength=15 onChange="onchange_sel1();"></td></tr>
<tr><td><% multilang("322" "LANG_SOURCE_PORT"); %>:</td><td><input type=text name=sport size=10 maxlength=5 onChange="onchange_sel1();"></td></tr>
<tr><td><% multilang("320" "LANG_DESTINATION"); %> IP:</td><td><input type=text name=dip size=20 maxlength=15 onChange="onchange_sel1();"></td></tr>
<tr><td><% multilang("568" "LANG_DESTINATION_MASK"); %>:</td><td><input type=text name=dmask size=20 maxlength=15 onChange="onchange_sel1();"></td></tr>
<tr><td><% multilang("323" "LANG_DESTINATION_PORT"); %>:</td><td><input type=text name=dport size=10 maxlength=5 onChange="onchange_sel1();"></td></tr>
 <td><% multilang("569" "LANG_PHYSICAL_PORT"); %>:</td>
 <td><select style="width:150px " name=phyport onChange="onchange_sel1();">
  <option value=0></option>
  <% if_lan_list("all"); %>
 </select>
 </td>
</tr>
 <% pr_egress(); %>
<!--
<tr><td colSpan="2"><b>SET-2</b></td></tr>
<tr>
 <td width="200px ">802.1p:</td>
 <td><select name=s_m1p style="width:150px " onChange="onchange_sel2();">
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
</tr>-->
</table>
<td colspan="2"><hr size=1 width=600 noshade align=left></td>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<tr><td colspan="2"><th colspan=4><u><% multilang("570" "LANG_ASSIGN_PRIORITY_AND_OR_IP_PRECEDENCE_AND_OR_TYPE_OF_SERVICE_AND_OR_DSCP"); %></u></th></td></tr>
</table>
<table border=0 width=600 cellspacing=0 cellpadding=0>
<tr><td width="200px "><font size=2><% multilang("571" "LANG_OUTBOUND_PRIORITY"); %>:</td>
 <td>
  <% pq_egress(); %>
 </td>
</tr>
<tr><td><font size=2>802.1p:</td>
 <td><select name=m1p style="width:150px ">
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
</table>
<tr>
 <td><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name=addqos onClick="return addClick()"></td>
 <td><input type="hidden" value="/ipqos_sc.asp" name="submit-url"></td>
</tr>
</form>
<form action=/boaform/formIPQoS method=POST name=qostbl>
  <table border="0" width="700">
  <tr><font size=2><b>IP QoS <% multilang("572" "LANG_RULES"); %>:</b></font></tr>
  <% ipQosList(); %>
  </table>
  <br>
  <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name=delSel onClick="return deleteClick()">&nbsp;&nbsp;
  <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name=delAll onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
  <input type="hidden" value="/ipqos_sc.asp" name="submit-url">
</form>
<script>
 <% initPage("ipqos"); %>
 adminClick();
</script>
</blockquote>
</body>
</html>

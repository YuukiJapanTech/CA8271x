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
<! Copyright (c) Realtek Semiconductor Corp., 2008. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>IP QoS <% multilang("39" "LANG_TRAFFIC_SHAPING"); %></title>
<META http-equiv=pragma content=no-cache>
<META http-equiv=cache-control content="no-cache, must-revalidate">
<META http-equiv=content-script-type content=text/javascript>
<!--系统公共css-->
<STYLE type=text/css>
@import url(style/default.css);
.STYLE1 {color: #FF0000}
</STYLE>
<script type="text/javascript" src="share.js">
</script>
<script>
var protos = new Array("-", "ICMP", "TCP", "UDP", "TCP/UDP");
var traffictlRules = new Array();
var totalBandwidth;
var totalBandWidthEn;
function it_nr(id, inf, proto, sport, dport, srcip, dstip, uprate) {
  this.id = id;
  this.inf = inf;
  this.proto = proto;
  this.sport = sport;
  this.dport = dport;
  this.srcip = srcip;
  this.dstip = dstip;
  this.uprate = uprate;
}
<% initTraffictlPage(); %>
function on_chkdel(index) {
 if(index<0 || index>=traffictlRules.length)
  return;
 traffictlRules[index].select = !traffictlRules[index].select;
}
/********************************************************************
**          on document load
********************************************************************/
function on_init_page(){
 with(document.forms[0]) {
  if (totalBandWidthEn==0)
   totalbandwidth.value = "";
  else
   totalbandwidth.value = totalBandwidth;
  if(traffictl_tbl.rows){
   while(traffictl_tbl.rows.length > 1)
    traffictl_tbl.deleteRow(1);
  }
  for(var i = 0; i < traffictlRules.length; i++)
  {
   var row = traffictl_tbl.insertRow(i + 1);
   row.nowrap = true;
   row.vAlign = "center";
   row.align = "left";
   var cell = row.insertCell(0);
   cell.style.color = "#404040";
   cell.align = "center";
   cell.innerHTML = traffictlRules[i].id;
   cell = row.insertCell(1);
   cell.style["color"] = "#404040";
   cell.align = "center";
   cell.innerHTML = traffictlRules[i].inf;
   cell = row.insertCell(2);
   cell.style["color"] = "#404040";
   cell.align = "center";
   cell.innerHTML = protos[traffictlRules[i].proto];
   cell = row.insertCell(3);
   cell.style["color"] = "#404040";
   cell.align = "center";
   if (traffictlRules[i].sport == "0")
    cell.innerHTML = "-";
   else
    cell.innerHTML = traffictlRules[i].sport;
   cell = row.insertCell(4);
   cell.style["color"] = "#404040";
   cell.align = "center";
   if (traffictlRules[i].dport == "0")
    cell.innerHTML = "-";
   else
    cell.innerHTML = traffictlRules[i].dport;
   cell = row.insertCell(5);
   cell.style["color"] = "#404040";
   cell.align = "center";
   if ((traffictlRules[i].srcip == "0.0.0.0/32") || (traffictlRules[i].srcip == "0.0.0.0"))
    cell.innerHTML = "-";
   else
    cell.innerHTML = traffictlRules[i].srcip;
   cell = row.insertCell(6);
   cell.style["color"] = "#404040";
   cell.align = "center";
   if ((traffictlRules[i].dstip == "0.0.0.0/32") || (traffictlRules[i].dstip == "0.0.0.0"))
    cell.innerHTML = "-";
   else
    cell.innerHTML = traffictlRules[i].dstip;
   cell = row.insertCell(7);
   cell.style["color"] = "#404040";
   cell.align = "center";
   cell.innerHTML = traffictlRules[i].uprate;
   cell = row.insertCell(8);
   cell.style["color"] = "#404040";
   cell.align = "center";
   cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkdel(" + i + ");\">";
  }
 }
}
//apply total bandwidth limit
function on_apply_bandwidth(){
 with(document.forms[0]) {
  var sbmtstr = "applybandwidth&bandwidth=";
  var bandwidth = -1;
  if (totalbandwidth.value != "") {
   bandwidth = parseInt(totalbandwidth.value);
   if(bandwidth<0 || bandwidth >Number.MAX_VALUE)
    return;
   sbmtstr += bandwidth;
  } else {
   sbmtstr += 0;
  }
  lst.value = sbmtstr;
  submit();
 }
}
//submit traffic shaping rules
function on_submit(){
 var sbmtstr = "applysetting#id=";
 var firstFound = true;
 for(var i=0; i<traffictlRules.length; i++)
 {
  if(traffictlRules[i].select)
  {
   if(!firstFound)
    sbmtstr += "|";
   else
    firstFound = false;
   sbmtstr += traffictlRules[i].id;
  }
 }
 document.forms[0].lst.value = sbmtstr;
 document.forms[0].submit();
}
function onSelProt()
{
 with(document.forms[0]) {
  if (protolist.selectedIndex >= 2)
  {
   sport.disabled = false;
   dport.disabled = false;
  } else {
   sport.disabled = true;
   dport.disabled = true;
  }
 }
}
function on_Add()
{
 if (document.getElementById){ // DOM3 = IE5, NS6
  document.getElementById('tcrule').style.display = 'block';
 } else {
  if (document.layers == false) {// IE4
   document.all.tcrule.style.display = 'block';
  }
 }
 onSelProt();
}
function on_apply() {
 var sbmtstr = "addsetting#";
 with(document.forms[0]) {
  if ((srcip.value=="") && (dstip.value=="") && (sport.value=="") && (dport.value=="") &&
   (protolist.value==0))
  {
   alert("please assign at least one condition!");
   return;
  }
  if (inflist.value == 0)
  {
   inflist.focus();
   alert('<% multilang("2217" "LANG_WAN_INTERFACE_NOT_ASSIGNED"); %>');
   return;
  }
  if(srcip.value != "" && checkIP(srcip) == false)
  {
   srcip.focus();
   return;
  }
  if(dstip.value != "" && checkIP(dstip) == false)
  {
   dstip.focus();
   return;
  }
  if(srcnetmask.value != "" && checkMask(srcnetmask) == false)
  {
   srcnetmask.focus();
   return;
  }
  if(dstnetmask.value != "" && checkMask(dstnetmask) == false)
  {
   dstnetmask.focus();
   return;
  }
  if(sport.value <0 || sport.value > 65536)
  {
   sport.focus();
   alert('<% multilang("2222" "LANG_SOURCE_PORT_INVALID"); %>');
   return;
  }
  if (sport.value > 0 && sport.value < 65535)
  {
   if (protolist.value < 2) {
    sport.focus();
    alert('<% multilang("2223" "LANG_PLEASE_ASSIGN_TCP_UDP"); %>');
    return;
   }
  }
  if(dport.value <0 || dport.value > 65536)
  {
   dport.focus();
   alert('<% multilang("2224" "LANG_DESTINATION_PORT_INVALID"); %>');
   return;
  }
  if (dport.value > 0 && dport.value<65535)
  {
   if (protolist.value < 2) {
    dport.focus();
    alert('<% multilang("2223" "LANG_PLEASE_ASSIGN_TCP_UDP"); %>');
    return;
   }
  }
  if(uprate.value<0)
  {
   uprate.focus();
   alert('<% multilang("2225" "LANG_UPLINK_RATE_INVALID"); %>');
   return;
  }
  sbmtstr += "inf="+inflist.value+"&proto="+protolist.value+"&srcip="+srcip.value+"&srcnetmask="+srcnetmask.value+
   "&dstip="+dstip.value+"&dstnetmask="+dstnetmask.value+"&sport="+sport.value+"&dport="+dport.value+"&uprate="+uprate.value;
  lst.value = sbmtstr;
  submit();
 }
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000" onLoad="on_init_page();">
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px;">
<h2><font color="#0000FF">IP QoS <% multilang("39" "LANG_TRAFFIC_SHAPING"); %></font></h2>
<form action="/boaform/formQosShape" method="post" name="qosShape">
<table border=0 width=600 cellspacing=4 cellpadding=0>
<tr><td><font size=2><% multilang("573" "LANG_ENTRIES_IN_THIS_TABLE_ARE_USED_FOR_TRAFFIC_CONTROL"); %></font></td></tr>
<tr><td colspan=4><hr size=1 noshade align=top></td></tr>
</table>
<p><% multilang("597" "LANG_TOTAL_BANDWIDTH_LIMIT"); %>:<input type="text" id="totalbandwidth" size="6" maxlength="6" value="1024">Kb</p>
<table class="flat" id="traffictl_tbl" border="1" cellpadding="0" cellspacing="1">
<tr class="hdb" align="center" nowrap>
 <td bgcolor="#808080">ID</td>
 <td bgcolor="#808080"><% multilang("354" "LANG_WAN_INTERFACE"); %></td>
 <td bgcolor="#808080"><% multilang("75" "LANG_PROTOCOL"); %></td>
 <td bgcolor="#808080"><% multilang("319" "LANG_SOURCE"); %> Port</td>
 <td bgcolor="#808080"><% multilang("320" "LANG_DESTINATION"); %> Port</td>
 <td bgcolor="#808080"><% multilang("319" "LANG_SOURCE"); %> IP</td>
 <td bgcolor="#808080"><% multilang("320" "LANG_DESTINATION"); %> IP</td>
 <td bgcolor="#808080"><% multilang("574" "LANG_RATE"); %>(kb/s)</td>
 <td bgcolor="#808080"><% multilang("239" "LANG_DELETE"); %></td>
</tr>
</table>
<table>
<tr align="left">
<td>
 <input type="button" class="button" onClick="on_Add()" value="<% multilang("180" "LANG_ADD"); %>">
</td>
<td>
 <input type="button" class="button" onClick="on_submit();" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>">
</td>
<td>
 <input type="button" class="button" onClick="on_apply_bandwidth();" value="<% multilang("575" "LANG_APPLY_TOTAL_BANDWIDTH_LIMIT"); %>">
</td>
</tr>
</table>
<div id="tcrule" style="display:none">
<p></p>
<table cellSpacing="1" cellPadding="0" border="0">
<tr>
 <td>Interface：</td>
 <td>
   <select id="inflist">
     <option value=0> </option>
     <% if_wan_list("rt"); %>
   </select>
 </td>
</tr>
<tr>
 <td>Protocol：</td>
 <td>
  <select name="protolist" onClick="return onSelProt()">
   <option value="0">NONE</option>
   <option value="1">ICMP</option>
   <option value="2">TCP </option>
   <option value="3">UDP </option>
   <option value="4">TCP/UDP</option>
  </select>
 </td>
</tr>
<tr>
 <td>Src IP：</td>
 <td><input type="text" name="srcip" size="15" maxlength="15" style="width:150px"></td>
 <td>Src Mask：</td>
 <td><input type="text" name="srcnetmask" size="15" maxlength="15" style="width:150px"></td>
</tr>
<tr>
 <td>Dst IP：</td>
 <td><input type="text" name="dstip" size="15" maxlength="15" style="width:150px"></td>
 <td>Dst Mask：</td>
 <td><input type="text" name="dstnetmask" size="15" maxlength="15" style="width:150px"></td>
</tr>
<tr>
 <td>Src Port：</td>
 <td><input type="text" name="sport" size="6" style="width:80px"></td>
 <td>Dst Port：</td>
 <td><input type="text" name="dport" size="6" style="width:80px"></td>
</tr>
<tr>
 <td>uplink rate：</td>
 <td><input type="text" name="uprate" size="6" style="width:80px">kb/s</td>
</tr>
</table>
<br>
<input type="button" name="apply" value="save" onClick="on_apply();" style="width:80px">
</div>
<input type="hidden" id="lst" name="lst" value="">
<input type="hidden" name="submit-url" value="/ipqos_shape.asp">
</form>
</DIV>
</blockquote>
</body>
</html>

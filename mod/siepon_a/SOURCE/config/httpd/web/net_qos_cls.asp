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
<HTML>
<HEAD>
<TITLE>QoS <% multilang("37" "LANG_CLASSIFICATION"); %></TITLE>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<SCRIPT language="javascript" src="common.js"></SCRIPT>
<SCRIPT language="javascript" type="text/javascript">
var dscps = new it_nr("dscplst",
 new it(0, ""),
 new it(1, "Default(000000)"),
 new it(57, "AF13(001110)"),
 new it(49, "AF12(001100)"),
 new it(41, "AF11(001010)"),
 new it(33, "CS1(001000)"),
 new it(89, "AF23(010110)"),
 new it(81, "AF22(010100)"),
 new it(73, "AF21(010010)"),
 new it(65, "CS2(010000)"),
 new it(121, "AF33(011110)"),
 new it(113, "AF32(011100)"),
 new it(105, "AF31(011010)"),
 new it(97, "CS3(011000)"),
 new it(153, "AF43(100110)"),
 new it(145, "AF42(100100)"),
 new it(137, "AF41(100010)"),
 new it(129, "CS4(100000)"),
 new it(185, "EF(101110)"),
 new it(161, "CS5(101000)"),
 new it(193, "CS6(110000)"),
 new it(225, "CS7(111000)")
);
var iffs = new Array("", "LAN_1", "LAN_2", "LAN_3", "LAN_4");
<!--var protos = new Array("", "ICMP", "TCP", "UDP", "TCP/UDP");-->
var protos = new Array("", "TCP", "UDP", "ICMP", "TCP/UDP");
var rules = new Array();
<% initQosRulePage(); %>
function on_chkclick(index)
{
 if(index < 0 || index >= rules.length)
  return;
 rules[index].select = !rules[index].select;
}
function on_onedit(index)
{
 if(index < 0 || index >= rules.length)
  return;
 window.location.href = "net_qos_cls_edit.asp?rule_index="+rules[index].index+"&rule=" + rules[index].enc();
}
/********************************************************************
**          on document load
********************************************************************/
function on_init()
{
 if(lstrc.rows){while(lstrc.rows.length > 2) lstrc.deleteRow(2);}
 for(var i = 0; i < rules.length; i++)
 {
  //var bcheck = " ";
  var row = lstrc.insertRow(i + 2);
  var strprio = "";
  row.nowrap = true;
  row.vAlign = "center";
  row.align = "left";
  var cell = row.insertCell(0);
  cell.innerHTML = rules[i].index;
  cell = row.insertCell(1);
  cell.innerHTML = rules[i].name;
  cell = row.insertCell(2);
  if(rules[i].mvid==0)
   cell.innerHTML = "<br>";
  else
   cell.innerHTML = rules[i].mvid;
  cell = row.insertCell(3);
  if (rules[i].mdscp != "0") {
   cell.innerHTML = "0x"+(rules[i].mdscp-1).toString(16);
  } else
   cell.innerHTML = " <br>";
  cell = row.insertCell(4);
  if (rules[i].m1p != "0") {
   cell.innerHTML = rules[i].m1p-1;
  } else
   cell.innerHTML = "<br> ";
  cell = row.insertCell(5);
  cell.innerHTML = rules[i].prio;
  cell = row.insertCell(6);
  cell.innerHTML = rules[i].wanifname;
  cell = row.insertCell(7);
  switch(rules[i].ipqos_rule_type)
  {
   case 0:
    cell.innerHTML = "<b>Port Base<br></b>";
    switch(rules[i].phypt)
    {
     case 1:
      cell.innerHTML += "LAN1<br>";
      break;
     case 2:
      cell.innerHTML += "LAN2<br>";
      break;
     case 3:
      cell.innerHTML += "LAN3<br>";
      break;
     case 4:
      cell.innerHTML += "LAN4<br>";
      break;
    }
    break;
   case 1:
    cell.innerHTML = "<b>EtherType Base<br></b>";
    cell.innerHTML +="0x"+rules[i].ethType;
    break;
   case 2:
    cell.innerHTML = "<b>IP/Protocol Base<br></b>";
    switch(rules[i].IpProtocolType)
    {
     case 1:
      if(rules[i].sip== "0.0.0.0")
       cell.innerHTML += "Source IP: "+ " <br>";
      else
       cell.innerHTML += "Source IP: "+ rules[i].sip+"<br>";
      cell.innerHTML += "Source Mask: "+ rules[i].smsk+"<br>";
      if(rules[i].dip== "0.0.0.0")
       cell.innerHTML += "Destination IP: "+ " <br>";
      else
       cell.innerHTML += "Destination IP: "+ rules[i].dip+"<br>";
      cell.innerHTML += "Destination Mask: "+ rules[i].dmsk+"<br>";
      break;
     case 2:
      if (rules[i].sip6 == "::")
       cell.innerHTML += "Source IP: "+ " <br>";
      else {
       if(rules[i].sip6PrefixLen == "")
        cell.innerHTML += "Source IP: "+ rules[i].sip6+"<br>";
       else
        cell.innerHTML += "Source IP: "+ rules[i].sip6 + "/" + rules[i].sip6PrefixLen+"<br>";
      }
      break;
    }
    cell.innerHTML+= "Source Port: ";
    if (rules[i].spts == "0")
     cell.innerHTML+= ""+"<br>";
    else if (rules[i].spte == "0")
     cell.innerHTML += rules[i].spts+"<br>";
    else
     cell.innerHTML+= ((typeof rules[i].spte == "undefined") ? rules[i].spts : rules[i].spts + ":" + rules[i].spte)+"<br>";
    cell.innerHTML+= "Destination Port: ";
    if (rules[i].dpts == "0")
     cell.innerHTML += ""+"<br>";
    else if (rules[i].dpte == "0")
     cell.innerHTML += rules[i].dpts+"<br>";
    else
     cell.innerHTML += rules[i].dpts + ":" + rules[i].dpte+"<br>";
    break;
   case 3:
    cell.innerHTML = "<b>MAC Address Base<br></b>";
    cell.innerHTML += "Source MAC: "+ ((rules[i].smac=="00:00:00:00:00:00")?"":rules[i].smac)+"<br>";
    cell.innerHTML += "Destination MAC:"+ ((rules[i].dmac=="00:00:00:00:00:00")?"":rules[i].dmac)+"<br>";
    break;
   case 4:
    cell.innerHTML = "<b>DHCP Option Base<br></b>";
    if(typeof rules[i].dhcpopt_type_select !== "undefined")
    {
     switch(rules[i].dhcpopt_type_select)
     {
      case "0": //option 60
       cell.innerHTML += "Option 60<br>";
       cell.innerHTML += "Vendor Class ID:"+rules[i].opt60_vendorclass;
       break;
      case "1": //option 61
       cell.innerHTML += "Option 61<br>";
       switch(rules[i].dhcpopt61_DUID_select)
       {
        case "0":
         cell.innerHTML += "DUID Type: DUID_LLT<br>";
         cell.innerHTML += "IAID: "+rules[i].opt61_iaid+"<br>";
         cell.innerHTML += "Hardware Type:"+rules[i].duid_hw_type+"<br>";
         cell.innerHTML += "Time"+rules[i].duid_time+"<br>";
         cell.innerHTML += "Link-layer Address"+rules[i].duid_mac+"<br>";
         break;
        case "1":
         cell.innerHTML += "DUID Type: DUID_EN<br>";
         cell.innerHTML += "IAID: "+rules[i].opt61_iaid+"<br>";
         cell.innerHTML += "Enterprise Number: "+rules[i].duid_ent_num+"<br>";
         cell.innerHTML += "Identifier: "+rules[i].duid_ent_id+"<br>";
         break;
        case "2":
         cell.innerHTML += "DUID Type: DUID_LL<br>";
         cell.innerHTML += "IAID: "+rules[i].opt61_iaid+"<br>";
         cell.innerHTML += "Hardware Type: "+rules[i].duid_hw_type+"<br>";
         cell.innerHTML += "Link-layer Address: "+rules[i].duid_mac+"<br>";
         break;
       }
       break;
      case "2": //option 125
       cell.innerHTML += "Option 125<br>";
       cell.innerHTML += "Enterprise Number: "+rules[i].opt125_ent_num+"<br>";
       cell.innerHTML += "Manufacturer OUI: "+rules[i].opt125_manufacturer+"<br>";
       cell.innerHTML += "Product Class: "+rules[i].opt125_product_class+"<br>";
       cell.innerHTML += "Model Name: "+rules[i].opt125_model+"<br>";
       cell.innerHTML += "Serial Number: "+rules[i].opt125_serial+"<br>";
       break;
     }
    }
    break;
   default:
    break;
  }
  cell = row.insertCell(8);
  cell.align = "center";
  cell.innerHTML = "<input type=\"checkbox\" onClick=\"on_chkclick(" + i + ");\">";
  cell = row.insertCell(9);
  cell.align = "center";
  cell.innerHTML = "<input type=\"button\" onClick=\"on_onedit(" + i + ");\" value=\"Edit\">";
 }
}
function rc2string(it)
{
 return it.index + "," + Number(it.state) + "," + Number(it.select);// + "|" + it.tporte + "|" + it.oprotocol + "|" + it.oportb + "|" + it.oporte; 
}
/********************************************************************
**          on document submit
********************************************************************/
function on_submit()
{
 var tmplst = "";
 var first = true;
 if (rules.length == 0)
  return;
 with ( document.forms[0] )
 {
  for(var i = 0; i < rules.length; i++)
  {
   if(first)
   {
    first = false;
   }
   else
   {
    tmplst += "&";
   }
   tmplst += rc2string(rules[i]);
  }
  lst.value = tmplst;
  submit();
 }
}
</SCRIPT>
</HEAD>
<body onLoad="on_init();">
 <blockquote>
  <DIV align="left" style="padding-left:20px; padding-top:5px;">
   <form id="form" action="/boaform/admin/formQosRule" method="post">
    <h2><font color="#0000FF">QoS <% multilang("37" "LANG_CLASSIFICATION"); %></font></h2>
    <div class="tip" style="width:90% ">
     <% multilang("598" "LANG_PAGE_DESC_CLASSICY_QOS_RULE"); %><font color="red">(<% multilang("599" "LANG_PAGE_DESC_CLASSICY_QOS_RULE_EXTRA"); %>)</font>
    </div>
    <table border=0 width="500" border="1" cellspacing=1 cellpadding=0>
      <tr><td><hr size=1 noshade align=top></td></tr>
    </table>
    <table class="flat" id="lstrc" border="1" cellpadding="0" cellspacing="1">
       <tr class="hdb" align="center" nowrap bgcolor="#CCCCCC"><font size=2>
      <td colspan="2">&nbsp;</td>
      <td colspan="3"><b><% multilang("601" "LANG_MARK"); %></b></td>
      <td colspan="3" width="300"><b><% multilang("600" "LANG_CLASSIFICATION_RULES"); %></b></td>
      <td colspan="2">&nbsp;</td>
     </tr>
     <strong>
       <tr class="hdb" align="center" nowrap>
      <td><font size=2><% multilang("602" "LANG_ID"); %></td>
      <td><font size=2><% multilang("604" "LANG_NAME"); %></td>
      <td><font size=2><% multilang("104" "LANG_VLAN_ID"); %></td>
      <td><font size=2>DSCP <% multilang("601" "LANG_MARK"); %></td>
      <td><font size=2><% multilang("608" "LANG_802_1P"); %></td>
      <td><font size=2> <% multilang("595" "LANG_QUEUE"); %></td>
      <td><font size=2> <% multilang("609" "LANG_WANIF"); %></td>
      <td><font size=2 width="280"><% multilang("610" "LANG_RULE_DETAIL"); %></td>
      <td><font size=2><% multilang("239" "LANG_DELETE"); %></td>
      <td><font size=2><% multilang("606" "LANG_EDIT"); %></td>
     </tr>
     </strong>
    </table>
    <br>
    <input type="button" class="button" onClick="location.href='net_qos_cls_edit.asp';" value="<% multilang("180" "LANG_ADD"); %>">
    <input type="button" class="button" onClick="on_submit();" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>">
    <input type="hidden" id="lst" name="lst" value="">
    <input type="hidden" name="submit-url" value="/net_qos_cls.asp">
   </form>
  </DIV>
 </blockquote>
</body>
</html>

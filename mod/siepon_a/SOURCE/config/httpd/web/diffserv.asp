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
<title><% multilang("691" "LANG_DIFFERENTIATED_SERVICES"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script language="javascript">
function dscp_st(val, name)
{
 this.val = val;
 this.name = name;
}
var dscps=new Array();
dscps.push(new dscp_st(0, "Any"));
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
 for (var i = 0; i < dscps.length; i++) {
  document.writeln('<option value=' + dscps[i].val + '>' + dscps[i].name + '</option>');
 }
}
function phb_grp(val, name)
{
 this.val = val;
 this.name = name;
}
var phbs=new Array();
phbs.push(new phb_grp(0, ""));
phbs.push(new phb_grp(10, "AF11 PHB (001010)"));
phbs.push(new phb_grp(12, "AF12 PHB (001100)"));
phbs.push(new phb_grp(14, "AF13 PHB (001110)"));
phbs.push(new phb_grp(18, "AF21 PHB (010010)"));
phbs.push(new phb_grp(20, "AF22 PHB (010100)"));
phbs.push(new phb_grp(22, "AF23 PHB (010110)"));
phbs.push(new phb_grp(26, "AF31 PHB (011010)"));
phbs.push(new phb_grp(28, "AF32 PHB (011100)"));
phbs.push(new phb_grp(30, "AF33 PHB (011110)"));
phbs.push(new phb_grp(34, "AF41 PHB (100010)"));
phbs.push(new phb_grp(36, "AF42 PHB (100100)"));
phbs.push(new phb_grp(38, "AF43 PHB (100110)"));
phbs.push(new phb_grp(46, "EF PHB (101110)"));
function writePhbRule()
{
 var rule = 0;
 for (var k = 1; k <= 5; k ++) {
  document.writeln('<div id="markQoS' + k + '" style=\'display:none;\'>\n');
  document.writeln('<table border=0 width=600 cellspacing=6 cellpadding=0>');
  document.writeln('<tr><td colspan=6><hr size=1 noshade align=top></td></tr>');
  document.writeln('<tr><th colspan=6><u>Specify Traffic Classification Rules</u></th></tr>\n<br>\n');
  if (k == 5)
   rule = 1;
  else if (k >= 1 && k <= 4)
   rule = 3;
  for (var i = 0; i < rule; i ++) {
   var j = 3 * (k - 1) + i + 1;
   document.writeln('<tr>\n\t<td><input type=checkbox name=phb value=' + phbs[j].val + '></td>\n');
   document.writeln('\t<td><font size=2><b>PHB:</b></td>\n');
   //document.writeln('\t<td><font size=2>' + phbs[j].name + '<input type=hidden name=phb value=' + phbs[j].val + '></td>\n');
   document.writeln('\t<td><font size=2>' + phbs[j].name + '</td>\n');
   document.writeln('\t<td><font size=2><b>Protocol:</b></td>\n');
   document.writeln('\t<td><select name=prot' + phbs[j].val + ' id="idprot' + phbs[j].val + '" onClick="return checkProt(' + phbs[j].val + ')">\n');
   document.writeln('\t\t<option value=0>Any</option>\n\t\t<option value=1>TCP</option>\n');
   document.writeln('\t\t<option value=2>UDP</option>\n\t\t<option value=3>ICMP</option>\n\t</select></td>\n');
   document.writeln('\t<td><font size=2><b>DSCP:</b></td>\n');
   document.writeln('\t<td><select name=m_dscp' + phbs[j].val + ' id="iddscp' + phbs[j].val + '" size="1">\n');
   writeDscpList();
   document.writeln('</tr>\n');
   document.writeln('<tr>\n\t<td></td>\n\t<td><font size=2><b>Source IP:</b></td>\n\t<td><font size=2><input type=text name=sip' + phbs[j].val + ' id=idsip' + phbs[j].val + ' size=15 maxlength=15></td>\n');
   document.writeln('\t<td><font size=2><b>Netmask:</b></td>\n\t<td><font size=2><input type=text name=smask' + phbs[j].val + ' id=idsmask' + phbs[j].val + ' size=15 maxlength=15></td>\n');
   document.writeln('\t<td><font size=2><b>Port:</b></td>\n\t<td><font size=2><input type=text name=sport' + phbs[j].val + ' id="idsport' + phbs[j].val + '" size=6 maxlength=5 disabled></td>\n</tr>\n');
   document.writeln('<tr>\n\t<td></td>\n\t<td><font size=2><b>Destination IP:</b></td>\n\t<td><font size=2><input type=text name=dip' + phbs[j].val + ' id=iddip' + phbs[j].val + ' size=15 maxlength=15></td>\n');
   document.writeln('\t<td><font size=2><b>Netmask:</b></td>\n\t<td><font size=2><input type=text name=dmask' + phbs[j].val + ' id=iddmask' + phbs[j].val + ' size=15 maxlength=15></td>\n');
   document.writeln('\t<td><font size=2><b>Port:</b></td>\n\t<td><font size=2><input type=text name=dport' + phbs[j].val + ' id="iddport' + phbs[j].val + '" size=6 maxlength=5 disabled></td>\n</tr>\n');
   document.writeln('<tr>\n\t<td></td>\n\t<td><font size=2><b>Police Rate:</b></td>\n\t<td><font size=2><input type=text name=rate' + phbs[j].val + ' id=idrate' + phbs[j].val + ' size=6>Kb/s</td>\n');
   document.writeln('\t<td><font size=2><b>Police Action:</b></td>\n\t<td><select name=bhv' + phbs[j].val + ' id="idbhv' + phbs[j].val + '">\n');
   document.writeln('\t\t<option value=0></option>\n\t\t<option value=1>Drop</option>\n\t\t<option value=2>Continue</option>\n\t</select></td>\n</tr>\n');
  }
  document.writeln('</table>\n</div>\n');
 }
}
function checkProt(val)
{
 with (document.forms[0]) {
  var ddl = document.getElementById('idprot' + val);
  var idx = ddl.selectedIndex;
  var vlu = ddl.options[idx].value;
  if (vlu == 1 || vlu == 2) {
   document.getElementById('idsport' + val).disabled = false;
   document.getElementById('iddport' + val).disabled = false;
  }
  else {
   document.getElementById('idsport' + val).disabled = true;
   document.getElementById('iddport' + val).disabled = true;
  }
 }
}
function showItem()
{
 with (document.forms[0]) {
  for (var i = 1; i <= 5; i++) {
   document.getElementById('markQoS' + i).style.display = 'none';
   if (i == 5)
    phb[12].checked = false;
   else {
    for (var j = 0; j < 3; j++)
     phb[3 * (i - 1) + j].checked = false;
   }
  }
  if (phbclass.value == 0)
   return;
  document.getElementById('markQoS' + phbclass.value).style.display = 'block';
  phb[3 * (phbclass.value - 1)].checked = true;
  if (phbclass.value < 5)
   phb[3 * (phbclass.value - 1) + 1].checked = true;
 }
}
function check_enable()
{
 var status = false;
 if (document.diffserv.qoscap[1].checked)
  status = true;
 changeBlockState('markQoS', status);
}
function hideQoSInfo(hide) {
 var status = false;
 if (hide == 1) {
  status = true;
 }
 changeBlockState('diffservSetting', status);
}
function adminClick()
{
 /*var i, num;
	num = document.diffserv.elements.length;
	if (document.diffserv.qoscap[0].checked) {
		for (i=2; i<num; i++) {
			document.diffserv[i].disabled = true;
		}
		document.diffserv.addqos.disabled = false;
		document.diffserv[num-1].disabled = false;
	}
	else {
		for (i=2; i<num; i++) {
			document.diffserv[i].disabled = false;
		}
	}*/
 with (document.forms[0]) {
  if (qoscap[1].checked) {
   hideQoSInfo(0);
  } else {
   hideQoSInfo(1);
  }
 }
}
function addClick(phb)
{
 var lst = '';
 if (document.diffserv.qoscap[0].checked)
  return true;
 if (typeof phb == 'undefined')
  return false;
 var has_selected_items = 0;
    if (phb.length > 0) {
  for (var i = 0; i < phb.length; i++) {
   if (phb[i].checked == true) {
    with (document.forms[0]) {
     var protlist = document.getElementById('idprot' + phb[i].value);
     var dscplist = document.getElementById('iddscp' + phb[i].value);
     var bhvlist = document.getElementById('idbhv' + phb[i].value);
     if (document.getElementById('idsip' + phb[i].value).value == ""
      && document.getElementById('idsmask' + phb[i].value).value == ""
      && document.getElementById('idsport' + phb[i].value).value == ""
      && document.getElementById('iddip' + phb[i].value).value == ""
      && document.getElementById('iddmask' + phb[i].value).value == ""
      && document.getElementById('iddport' + phb[i].value).value == ""
      && document.getElementById('idrate' + phb[i].value).value == ""
      && protlist.options[protlist.selectedIndex].value == 0
      && dscplist.options[dscplist.selectedIndex].value == 0
      && bhvlist.options[bhvlist.selectedIndex].value == 0
     ) {
      alert("Traffic Classification Rules can't be empty");
      document.getElementById('idsip' + phb[i].value).focus();
      return false;
     }
     if (validateKey(totalbandwidth.value) == 0) {
      alert("Invalid total bandwidth limit!");
      totalbandwidth.focus();
       return false;
     }
     var dbw = getDigit(totalbandwidth.value, 1);
     if (totalbandwidth.value == "" || dbw <= 0) {
      totalbandwidth.focus();
      alert("Total bandwidth limit not assigned!");
      return false;
     }
     if (validateKey(htbrate.value) == 0) {
      alert("Invalid class rate limit!");
      htbrate.focus();
       return false;
     }
     var dhr = getDigit(htbrate.value, 1);
     if (htbrate.value == "" || dhr <= 0) {
      htbrate.focus();
      alert("Class rate limit not assigned!");
      return false;
     }
      if (dhr > dbw - 100 || dhr < 100) {
      htbrate.focus();
      alert("Class rate must between 100K to (total bandwidth limit-100K) !");
      return false;
     }
     if (validateKey(latency.value) == 0) {
      alert("Invalid max desired latency!");
      latency.focus();
       return false;
     }
     var dlatency = getDigit(latency.value, 1);
     if (latency.value == "" || dlatency <= 0) {
      latency.focus();
      alert("Max desired latency not assigned!");
      return false;
     }
     if (validateKey(document.getElementById('idrate' + phb[i].value).value) == 0) {
      alert("Invalid police rate!");
      document.getElementById('idrate' + phb[i].value).focus();
       return false;
     }
     /*if (document.getElementById('idrate' + phb[i].value).value == "" || drate <= 0) {
						document.getElementById('idrate' + phb[i].value).focus();
						alert("Police rate not assigned!");
						return false;
					}*/
     var drate = getDigit(document.getElementById('idrate' + phb[i].value).value, 1);
     if (drate > 0) {
      if (bhvlist.options[bhvlist.selectedIndex].value == 0) {
       document.getElementById('idbhv' + phb[i].value).focus();
       alert("Police action not assigned!");
       return false;
      }
     }
     else if (drate > dbw) {
      document.getElementById('idrate' + phb[i].value).focus();
      alert("Police rate can't be greater than total bandwidth limit !");
      return false;
     }
     if (document.getElementById('idsip' + phb[i].value).value != "") {
      if (!checkHostIP(document.getElementById('idsip' + phb[i].value), 0))
       return false;
      if (document.getElementById('idsmask' + phb[i].value).value != "") {
       if (!checkNetmask(document.getElementById('idsmask' + phb[i].value), 0))
        return false;
      }
     }
     if (document.getElementById('iddip' + phb[i].value).value!="") {
      if (!checkHostIP(document.getElementById('iddip' + phb[i].value), 0))
       return false;
      if (document.getElementById('iddmask' + phb[i].value).value != "") {
       if (!checkNetmask(document.getElementById('iddmask' + phb[i].value), 0))
        return false;
      }
     }
     if (document.getElementById('idsport' + phb[i].value).value!="") {
      if (validateKey(document.getElementById('idsport' + phb[i].value).value) == 0) {
       alert("Invalid source port!");
       document.getElementById('idsport' + phb[i].value).focus();
        return false;
      }
      d1 = getDigit(document.getElementById('idsport' + phb[i].value).value, 1);
      if (d1 > 65535 || d1 < 1) {
       alert("Invalid source port number!");
       document.getElementById('idsport' + phb[i].value).focus();
       return false;
      }
     }
     if (document.getElementById('iddport' + phb[i].value).value!="") {
      if (validateKey(document.getElementById('iddport' + phb[i].value).value) == 0) {
       alert("Invalid destination port!");
       document.getElementById('iddport' + phb[i].value).focus();
       return false;
      }
      d1 = getDigit(document.getElementById('iddport' + phb[i].value).value, 1);
      if (d1 > 65535 || d1 < 1) {
       alert("Invalid destination port number!");
       document.getElementById('iddport' + phb[i].value).focus();
       return false;
      }
     }
    }
    has_selected_items ++;
    lst += phb[i].value + ',';
   }
  }
    }
 else if (phb.checked == true) {
  has_selected_items ++;
  lst = phb.value;
 }
 with (document.forms[0])
  phblst.value = lst;
 var chklst = lst.split(',');
 if (has_selected_items < 1) {
  alert("At least one PHB has to be seleted!");
  return false;
 }
 else if (has_selected_items < 2 && chklst[0] != 46) { // AF
  alert("At least two PHB has to be seleted for AF class!");
  return false;
 }
 return true;
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("691" "LANG_DIFFERENTIATED_SERVICES"); %></font></h2>
<table border=0 width=600 cellspacing=4 cellpadding=0>
<tr><td colspan=4><font size=2>
 <% multilang("692" "LANG_ENTRIES_IN_THIS_TABLE_ARE_USED_TO_ASSIGN_THE_PRECEDENCE_FOR_EACH_INCOMING_PACKET_BASED_ON_TCP_UDP_PORT_NUMBER_SOURCE_DESTINATION_IP_ADDRESS_SUBNET_MASKS"); %>
</font></td></tr>
<tr><td colspan=4><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formDiffServ method=POST name=diffserv>
<table border="0" width="700">
<% diffservList(); %>
</table>
<br>
<input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name=delSel onClick="return deleteClick()">
<table border=0 width=600 cellspacing=4 cellpadding=0>
<tr><td colspan=4><hr size=1 noshade align=top></td></tr>
<tr>
 <td><font size=2><b><% multilang("691" "LANG_DIFFERENTIATED_SERVICES"); %>:</b></td>
 <td><font size=2>
  <input type="radio" name=qoscap value=0 onClick="return adminClick()"><% multilang("146" "LANG_DISABLED"); %>&nbsp;&nbsp;
  <input type="radio" name=qoscap value=1 onClick="return adminClick()"><% multilang("145" "LANG_ENABLED"); %>
 </td>
</tr>
<TBODY id='diffservSetting'>
<tr>
 <td><font size=2><b><% multilang("693" "LANG_PHB_GROUPS"); %>:</b></td>
 <td><font size=2><select name="phbclass" onChange="showItem();">
  <option value=0></option>
  <option value=1>AF Class 1</option>
  <option value=2>AF Class 2</option>
  <option value=3>AF Class 3</option>
  <option value=4>AF Class 4</option>
  <option value=5>EF</option>
 </select></td>
 <td><font size=2><b><% multilang("694" "LANG_RATE_LIMIT"); %>:</b></td>
 <td><font size=2><input type="text" name="htbrate" size="6" maxlength="6" value="512">Kb</td>
</tr>
<tr>
 <td><font size=2><b><% multilang("354" "LANG_WAN_INTERFACE"); %>:</b></td>
 <td><font size=2><select name="interface">
  <% if_wan_list("all"); %>
 </select></td>
 <td></td>
 <td><font size=2><b><% multilang("495" "LANG_MIN"); %>:</b> 100Kb; <b><% multilang(LANG_MAX); %></b>: <% multilang("597" "LANG_TOTAL_BANDWIDTH_LIMIT"); %> - 100Kb</td>
</tr>
<tr>
 <td><font size=2><b><% multilang("597" "LANG_TOTAL_BANDWIDTH_LIMIT"); %>:</b></td>
 <td><font size=2><input type="text" name="totalbandwidth" size="6" maxlength="6" value="1024">Kb</td>
</tr>
<tr>
 <td><font size=2><b><% multilang("695" "LANG_MAX_DESIRED_LATENCY"); %>:</b></td>
 <td><font size=2><input type="text" name="latency" size="6" maxlength="6" value="500">ms</td>
</tr>
</table>
<script>
 writePhbRule();
</script>
</TBODY>
<input type="hidden" name="phblst" id="check_phblst">
<p><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name=addqos onClick="return addClick(this.form.phb)">
<input type="hidden" value="/diffserv.asp" name="submit-url"></p>
</form>
<script>
 <% initPage("diffserv"); %>
 adminClick();
 //check_enable();
</script>
</blockquote>
</body>
</html>

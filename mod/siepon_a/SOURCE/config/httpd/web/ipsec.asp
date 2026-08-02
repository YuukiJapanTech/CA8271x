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
<title>IPsec VPN Configuration</title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function checkit(obj){
 if(obj.value=="")
  obj.value=obj.defaultValue;
}
function clearit(obj){
 if(obj.value==obj.defaultValue)
  obj.value="";
}
function checkKey(obj, len)
{
 if(obj.value==""){
  alert('<% multilang("2137" "LANG_PLEASE_ENTER_KEY"); %>');
  obj.focus();
  return false;
 }
 for (var i=0; i<obj.value.length; i++) {
  if ((obj.value.charAt(i) >= '0' && obj.value.charAt(i) <= '9')||(obj.value.charAt(i) >= 'a' && obj.value.charAt(i) <= 'f')||(obj.value.charAt(i) >= 'A' && obj.value.charAt(i) <= 'F'))
   continue;
  alert('<% multilang("2138" "LANG_PLEASE_ENTER_HEXADECIMAL_NUMBER"); %>');
  obj.focus();
  return false;
 }
 if(obj.value.length != len){
  alert("Error, key length should be "+len+" !");
  obj.focus();
  return false;
 }
}
function ipsecSelection()
{
 onClicknegoType();
 onTransModeChange();
 onClickAdvOption();
 onProtocolChange();
 onEncapsTypeChange();
 document.ipsec.ikeProposal0.options[1].selected = true;
 document.ipsec.ikeProposal1.options[2].selected = true;
 document.ipsec.ikeProposal2.options[3].selected = true;
 document.ipsec.ikeProposal3.options[4].selected = true;
 document.ipsec.saProposal0.options[1].selected = true;
 document.ipsec.saProposal1.options[0].selected = true;
 document.ipsec.saProposal2.options[0].selected = true;
 document.ipsec.saProposal3.options[0].selected = true;
}
function onClicknegoType()
{
 if(document.ipsec.negoType[1].checked){
  document.getElementById('manualHead').style.display='';
  document.getElementById('manualAlgorithms').style.display='';
  document.getElementById('autoHead').style.display='none';
  document.getElementById('pskTable').style.display='none';
  if(document.ipsec.advOption.checked)
   document.getElementById('autoAdv').style.display='none';
 }
 else{
  document.getElementById('manualHead').style.display='none';
  document.getElementById('manualAlgorithms').style.display='none';
  document.getElementById('autoHead').style.display='';
  document.getElementById('pskTable').style.display='';
  if(document.ipsec.advOption.checked)
   document.getElementById('autoAdv').style.display='';
 }
}
function onClickAdvOption()
{
 if(document.ipsec.advOption.checked){
  document.getElementById('adv').style.display='block';
  if(document.ipsec.negoType[1].checked)
   document.getElementById('autoAdv').style.display='block';
 }
 else{
  document.getElementById('adv').style.display='none';
  document.getElementById('autoAdv').style.display='none';
 }
}
function onProtocolChange()
{
 if(document.ipsec.filterProtocol.value=="0"||document.ipsec.filterProtocol.value=="3"){
  document.ipsec.filterPort.disabled = true;
 }
 else{
  document.ipsec.filterPort.disabled = false;
 }
}
function onTransModeChange()
{
 if(document.ipsec.transMode.value =="0"){
  document.getElementById('remoteTunnel').style.display='';
  document.getElementById('localTunnel').style.display='';
 }else{
  document.getElementById('remoteTunnel').style.display='none';
  document.getElementById('localTunnel').style.display='none';
 }
}
function onESPAuthChange(){
 if(document.ipsec.esp_a_algo.value=="0"){
  if(document.ipsec.esp_e_algo.value!="0"){
   document.ipsec.esp_akey.value = "";
   document.ipsec.esp_akey.disabled = true;
  }else{
   alert('<% multilang("2139" "LANG_NEITHER_ENCRYPT_NOR_AUTH_IS_SELECTED"); %>');
   document.ipsec.esp_a_algo.focus();
   document.ipsec.esp_a_algo.options[1].selected = true;
  }
 }
 else{
  document.ipsec.esp_akey.disabled = false;
 }
}
function onESPEncryptChange(){
 var objEncrypt = document.getElementByName("esp_e_algo");
 var objAuth = document.getElementByName("esp_a_algo");
 if(document.ipsec.esp_e_algo.value=="0"){
  if(document.ipsec.esp_a_algo.value!="0"){
   document.ipsec.esp_ekey.value = "";
   document.ipsec.esp_ekey.disabled = true;
  }else{
   alert('<% multilang("2139" "LANG_NEITHER_ENCRYPT_NOR_AUTH_IS_SELECTED"); %>');
   document.ipsec.esp_e_algo.focus();
   document.ipsec.esp_e_algo.options[1].selected = true;
  }
 }
 else{
  document.ipsec.esp_ekey.disabled = false;
 }
}
function onEncapsTypeChange()
{
 if(document.ipsec.encapsType.value=="1" ||document.ipsec.encapsType.value=="3"){
  document.getElementById('espEncr').style.display='';
  document.getElementById('espEncrKey').style.display='';
  document.getElementById('espAuth').style.display='';
  document.getElementById('espAuthKey').style.display='';
  document.getElementById('espSPI1').style.display='';
  document.getElementById('espSPI2').style.display='';
 }else{
  document.getElementById('espEncr').style.display='none';
  document.getElementById('espEncrKey').style.display='none';
  document.getElementById('espAuth').style.display='none';
  document.getElementById('espAuthKey').style.display='none';
  document.getElementById('espSPI1').style.display='none';
  document.getElementById('espSPI2').style.display='none';
 }
 if(document.ipsec.encapsType.value=="2" ||document.ipsec.encapsType.value=="3"){
  document.getElementById('ahAuth').style.display='';
  document.getElementById('ahAuthKey').style.display='';
  document.getElementById('ahSPI1').style.display='';
  document.getElementById('ahSPI2').style.display='';
 }else{
  document.getElementById('ahAuth').style.display='none';
  document.getElementById('ahAuthKey').style.display='none';
  document.getElementById('ahSPI1').style.display='none';
  document.getElementById('ahSPI2').style.display='none';
 }
}
function onClickSaveConfig()
{
 var keyLen;
 var objEncrypt;
 var objAuth;
 if(checkIP(document.ipsec.remotegw)==false)
  return false;
 if(!checkHostIP(document.ipsec.remoteip, 1))
  return false;
 if(!checkNetmask(document.ipsec.remotemask, 1))
  return false;
 if(!checkHostIP(document.ipsec.localip, 1))
  return false;
 if(!checkNetmask(document.ipsec.remotemask, 1))
  return false;
 // manual
 if(document.ipsec.negoType[0].checked){
  if(document.ipsec.encapsType.value=="1" || document.ipsec.encapsType.value=="3"){
   objEncrypt = document.getElementByName("esp_e_algo");
   objAuth = document.getElementByName("esp_a_algo");
   if(document.ipsec.esp_e_algo.value != 0){
    if(document.ipsec.esp_e_algo.value == 1)
     keyLen = 16;
    else if(document.ipsec.esp_e_algo.value == 2)
     keyLen = 48;
    if(checkKey(document.ipsec.esp_ekey, keyLen)==false)
     return false;
   }
   if(document.ipsec.esp_a_algo.value != 0){
    if(document.ipsec.esp_a_algo.value == 1)
     keyLen = 32;
    else if(document.ipsec.esp_a_algo.value == 2)
     keyLen = 40;
    if(checkKey(document.ipsec.esp_akey, keyLen)==false)
     return false;
   }
   if(checkDigit(document.ipsec.spi_out_esp.value)==false){
    alert('<% multilang("2140" "LANG_SPI_SHOULD_BE_A_DIGIT_NUMBER"); %>');
    document.ipsec.spi_out_esp.focus();
    return false;
   }
   if(checkDigit(document.ipsec.spi_in_esp.value)==false){
    alert('<% multilang("2140" "LANG_SPI_SHOULD_BE_A_DIGIT_NUMBER"); %>');
    document.ipsec.spi_in_esp.focus();
    return false;
   }
   if(Number(document.ipsec.spi_out_esp.value)>=0 && Number(document.ipsec.spi_out_esp.value)<=255){
    alert('<% multilang("2141" "LANG_SPI_0_255_IS_RESERVED"); %>');
    document.ipsec.spi_out_esp.focus();
    return false;
   }
   if(Number(document.ipsec.spi_in_esp.value)>=0 && Number(document.ipsec.spi_in_esp.value)<=255){
    alert('<% multilang("2141" "LANG_SPI_0_255_IS_RESERVED"); %>');
    document.ipsec.spi_in_esp.focus();
    return false;
   }
  }
  else if(document.ipsec.encapsType.value=="2" || document.ipsec.encapsType.value=="3"){
   if(document.ipsec.ah_algo.value == 1)
    keyLen = 32;
   else if(document.ipsec.ah_algo.value == 2)
    keyLen = 40;
   if(checkKey(document.ipsec.ah_key, keyLen)==false)
    return false;
   if(checkDigit(document.ipsec.spi_out_ah.value)==false){
    alert('<% multilang("2140" "LANG_SPI_SHOULD_BE_A_DIGIT_NUMBER"); %>');
    document.ipsec.spi_out_ah.focus();
    return false;
   }
   if(checkDigit(document.ipsec.spi_in_ah.value)==false){
    alert('<% multilang("2140" "LANG_SPI_SHOULD_BE_A_DIGIT_NUMBER"); %>');
    document.ipsec.spi_in_ah.focus();
    return false;
   }
   if(Number(document.ipsec.spi_out_ah.value)>=0 && Number(document.ipsec.spi_out_ah.value)<=255){
    alert('<% multilang("2141" "LANG_SPI_0_255_IS_RESERVED"); %>');
    document.ipsec.spi_out_ah.focus();
    return false;
   }
   if(Number(document.ipsec.spi_in_ah.value)>=0 && Number(document.ipsec.spi_in_ah.value)<=255){
    alert('<% multilang("2141" "LANG_SPI_0_255_IS_RESERVED"); %>');
    document.ipsec.spi_in_ah.focus();
    return false;
   }
  }
 }
 if(Number(document.ipsec.filterPort.value)<0 && Number(document.ipsec.filterPort.value)>65535){
  alert('<% multilang("2142" "LANG_PORT_SHOULD_BE_0_65535"); %>');
  document.ipsec.filterPort.focus();
  return false;
 }
 if(document.ipsec.negoType[1].checked){
  if(document.ipsec.psk.value.length > 128){
   alert('<% multilang("2143" "LANG_PSK_LENGTH_SHOULD_LESS_THAN_128"); %>');
   document.ipsec.filterPort.focus();
   return false;
  }
 }
 return true;
}
function onClickChangeConfig()
{
 /*
	var obj = document.getElementById("infoTable");
	var rows = obj.rows.length;
	var perfix = "row_";
	var checked = "0";

	for (var i=0; i<rows; i++){
		var s = i.toString();
		var name = perfix.concat(s);
		if(document.getElementById(name).checked==true){
			checked = "1";
			break;
		}
	}
	if(checked == "0"){
		alert("don't select a element!");
		return false;
	}
	*/
 return true;
}
</SCRIPT>
<style>
.titleStyle{color:#0000FF}
.tableStyle{width:600px;border-width:0px;font-size:13px}
.tableTitle{border-width:0px;font-size:13px;font-style:italic;font-weight:bold}
.leftBlank{width:80px;border-width:0px;float:left;font-size:13px}
.topFrame{width:600px;border-width:0px;font-size:13px;font-weight:bold}
.rightFrame{width:520px;border-width:0px;float:right;font-size:13px}
.leftContent{width:120px;border-width:0px;text-align:left;font-size:13px}
.rightContent{width:400px;border-width:0px;text-align:left;font-size:13px}
.inputStyle{boder:1px solid #808080;font-size:12px;width:130px;height:20px}
.selectStyle{width:130px;}
.buttomStyle{width=100px;height:24px}
.infoTitle{font-size:13px;text-align:center;background-color:#808080;}
.infoContent{font-size:13px;text-align:center;background-color:#C0C0C0;}
.liststyle{width:600px;boder:1px dashed #808080;}
.leftHalf{width:50%;border-width:0px;float:left;font-size:14px}
.rightHalf{width:50%;border-width:0px;float:left;font-size:14px;text-align:right}
.clearfix:after {
content: ".";
display: block;
height: 0;
clear: both;
visibility: hidden;
}
.clearfix {display: inline-block;}
</style>
</head>
<body>
<blockquote>
<h2 class="titleStyle">IPsec VPN Configuration</h2>
<form action=/boaform/formIPsec method=POST name="ipsec">
<table class="tableStyle">
 <tr><td colspan="3">This page is used to configure the parameters for IPsec mode VPN.</td></tr>
 <tr><td colspan="3"><hr size=1 noshade align=top></td></tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Negotiation Type</td>
  <td class="rightContent">
  <input name="negoType" type="radio" value="0" checked onClick="onClicknegoType()">Automatic&nbsp;
  <input name="negoType" type="radio" value="1" onClick="onClicknegoType()">Manual&nbsp;
  </td>
 </tr>
</table>
<table id="manualHead" class="tableStyle">
 <tr>
  <td class="topFrame" colspan="3">Manual Configure: </td>
 </tr>
</table>
<table id="autoHead" class="tableStyle">
 <tr>
  <td class="topFrame" colspan="3">Auto Configure: </td>
 </tr>
</table>
<table class="tableStyle">
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Mode</td>
  <td class="rightContent">
   <select name="transMode" class="selectStyle" onchange="onTransModeChange()">
     <option value="0" selected>Tunnel Mode</option>
     <option value="1">Transport Mode</option>
   </select>
  </td>
 </tr>
 <tr>
  <td colspan="3"><hr size=1 noshade align=top /></td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">Remote:</td>
 </tr>
 <tr id="remoteTunnel">
  <td class="leftBlank"></td>
  <td class="leftContent">Tunnel Addr.</td>
  <td class="rightContent">
   <input name="rtunnelAddr" class="inputStyle" type="text" value="0.0.0.0" onblur="checkit(this)" onfocus="clearit(this)" />
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Internal IPaddr</td>
  <td class="rightContent">
   <input name="remoteip" class="inputStyle" type="text" value="0.0.0.0" onblur="checkit(this)" onfocus="clearit(this)" />
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Subnet Mask</td>
  <td class="rightContent">
   <input name="remotemask"class="inputStyle" type="text" value="255.255.255.0" onblur="checkit(this)" onfocus="clearit(this)" />
  </td>
 </tr>
 <tr>
  <td colspan="3"><hr size=1 noshade align=top /></td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">Local:</td>
 </tr>
 <tr id="localTunnel">
  <td class="leftBlank"></td>
  <td class="leftContent">Tunnel Addr.</td>
  <td class="rightContent">
   <input name="ltunnelAddr" class="inputStyle" type="text" value="0.0.0.0" onblur="checkit(this)" onfocus="clearit(this)" />
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Internal IPaddr</td>
  <td class="rightContent">
   <input name="localip" class="inputStyle" type="text" value="0.0.0.0" onblur="checkit(this)" onfocus="clearit(this)" />
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Subnet Mask</td>
  <td class="rightContent">
   <input name="localmask" class="inputStyle" type="text" value="255.255.255.0" onblur="checkit(this)" onfocus="clearit(this)" />
  </td>
 </tr>
 <tr>
  <td colspan="3"><hr size=1 noshade align=top /></td>
 </tr>
</table>
<table class="tableStyle">
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">Security Option:</td>
 </tr>
  <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Encapsulation Type</td>
  <td class="rightContent">
   <select name="encapsType" class="selectStyle" onchange="onEncapsTypeChange()">
     <option value="1" selected>ESP</option>
     <option value="2">AH</option>
     <option value="3">ESP+AH</option>
   </select>
  </td>
 </tr>
</table>
<table id="pskTable" class="tableStyle">
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Pre shared key</td>
  <td class="rightContent">
   <input name="psk" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Security Algorithm</td>
  <td class="rightContent">
  <select name="saProposal0" class="selectStyle">
   <% ipsec_saPropList(); %>
  </select>
  </td>
 </tr>
</table>
<table id="manualAlgorithms" class="tableStyle">
 <tr id="espEncr">
  <td class="leftBlank"></td>
  <td class="leftContent">ESP Encrypt Algorithm</td>
  <td class="rightContent">
  <select name="esp_e_algo" class="selectStyle" onchange="onESPEncryptChange()">
    <option value="0">null</option>
    <option value="1" selected>des-cbc</option>
    <option value="2">3des-cbc</option>
    <option value="3">aes-cbc</option>
  </select>
  </td>
 </tr>
 <tr id="espEncrKey">
  <td class="leftBlank"></td>
  <td class="leftContent">ESP Encrypt Key</td>
  <td class="rightContent">
   <input name="esp_ekey" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr id="espAuth">
  <td class="leftBlank"></td>
  <td class="leftContent">ESP Auth Algorithm</td>
  <td class="rightContent">
  <select name="esp_a_algo" class="selectStyle" onchange="onESPAuthChange()">
    <option value="0">null</option>
    <option value="1" selected>hmac-md5</option>
    <option value="2">hmac-sha1</option>
  </select>
  </td>
 </tr>
 <tr id="espAuthKey">
  <td class="leftBlank"></td>
  <td class="leftContent">ESP Auth Key</td>
  <td class="rightContent">
   <input name="esp_akey" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr id="ahAuth">
  <td class="leftBlank"></td>
  <td class="leftContent">AH Auth Algorithm</td>
  <td class="rightContent">
  <select name="ah_algo" class="selectStyle">
    <option value="1" selected>md5</option>
    <option value="2">sha1</option>
  </select>
  </td>
 </tr>
 <tr id="ahAuthKey">
  <td class="leftBlank"></td>
  <td class="leftContent">AH Auth Key</td>
  <td class="rightContent">
   <input name="ah_key" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr>
  <td colspan="3"><hr size=1 noshade align=top /></td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">SPI Configration:</td>
 </tr>
 <tr id="espSPI1">
  <td class="leftBlank"></td>
  <td class="leftContent" rowspan="2">ESP</td>
  <td class="rightContent">
   outbound&nbsp;<input name="spi_out_esp" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr id="espSPI2">
  <td class="leftBlank"></td>
  <td class="rightContent">
   inbound&nbsp;&nbsp;<input name="spi_in_esp" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr id="ahSPI1">
  <td class="leftBlank"></td>
  <td class="leftContent" rowspan="2">AH</td>
  <td class="rightContent">
   outbound&nbsp;<input name="spi_out_ah" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr id="ahSPI2">
  <td class="leftBlank"></td>
  <td class="rightContent">
   inbound&nbsp;&nbsp;<input name="spi_in_ah" class="inputStyle" type="text" />
  </td>
 </tr>
 <tr>
  <td colspan="3"><hr size=1 noshade align=top /></td>
 </tr>
</table>
<table class="tableStyle">
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Advanced Option</td>
  <td class="rightContent">
   <input name="advOption" type="checkbox" value="1" onClick="onClickAdvOption()" />
  </td>
 </tr>
</table>
<table id="adv" class="tableStyle">
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">Filter Option:</td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Protocol</td>
  <td class="rightContent">
  <select name="filterProtocol" class="selectStyle" onChange=onProtocolChange()>
   <option value="0" selected>any</option>
   <option value="1">tcp</option>
   <option value="2">udp</option>
   <option value="3">icmp</option>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Port</td>
  <td class="rightContent">
   <input name="filterPort" class="inputStyle" value="0" onblur="checkit(this)" onfocus="clearit(this)" type="text" />
  </td>
 </tr>
</table>
<table id="autoAdv" class="tableStyle">
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">IKE Phase 1:</td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Negotiation Mode</td>
  <td class="rightContent">
  <select name="negoMode" class="selectStyle">
   <option value="0" selected>main</option>
   <option value="1">aggressive</option>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Keepalive Time</td>
  <td class="rightContent">
   <input name="ikeAliveTime"class="inputStyle" value="28800" onblur="checkit(this)" onfocus="clearit(this)" type="text" />&nbsp;seconds
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">IKE Algorithm 1</td>
  <td class="rightContent">
  <select name="ikeProposal0" class="selectStyle">
   <% ipsec_ikePropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">IKE Algorithm 2</td>
  <td class="rightContent">
  <select name="ikeProposal1" class="selectStyle">
   <% ipsec_ikePropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">IKE Algorithm 3</td>
  <td class="rightContent">
  <select name="ikeProposal2" class="selectStyle">
   <% ipsec_ikePropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">IKE Algorithm 4</td>
  <td class="rightContent">
  <select name="ikeProposal3" class="selectStyle">
   <% ipsec_ikePropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="tableTitle" colspan="2">IKE Phase 2:</td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Security Algorithm 2</td>
  <td class="rightContent">
  <select name="saProposal1" class="selectStyle">
   <% ipsec_saPropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Security Algorithm 3</td>
  <td class="rightContent">
  <select name="saProposal2" class="selectStyle">
   <% ipsec_saPropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Security Algorithm 4</td>
  <td class="rightContent">
  <select name="saProposal3" class="selectStyle">
   <% ipsec_saPropList(); %>
  </select>
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Keepalive Time</td>
  <td class="rightContent">
   <input name="saAliveTime" class="inputStyle" value="3600" onblur="checkit(this)" onfocus="clearit(this)" type="text" />&nbsp;seconds
  </td>
 </tr>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">Keepalive Byte</td>
  <td class="rightContent">
   <input name="saAliveByte" class="inputStyle" value="4194300" onblur="checkit(this)" onfocus="clearit(this)" type="text" />&nbsp;KB
  </td>
 </tr>
</table>
<table>
 <tr>
  <td class="leftBlank"></td>
  <td class="leftContent">
   <input name="saveConf" class="buttomStyle" type="submit" value="Add/Save" onClick="return onClickSaveConfig()">
  </td>
  <td class="rightContent"></td>
 </tr>
</table>
<table id="infoTable" class="liststyle">
 <tr>
  <td class="topFrame" colspan="10">IPsec Information List:</td>
 </tr>
 <tr>
  <td class="infoTitle">&nbsp;&nbsp;&nbsp;&nbsp;</td>
  <td class="infoTitle">Enable</td>
  <td class="infoTitle">State</td>
  <td class="infoTitle">Type</td>
  <td class="infoTitle">RemoteGW</td>
  <td class="infoTitle">RemoteIP</td>
  <td class="infoTitle">Interface</td>
  <td class="infoTitle">LocalIP</td>
  <td class="infoTitle">EncapMode</td>
  <td class="infoTitle">filterProtocol</td>
  <td class="infoTitle">filterPort</td>
 </tr>
 <% ipsec_infoList(); %>
 <tr>
  <td colspan="4">
   <input name="delConf" class="buttomStyle" type="submit" value="Delete Selected" onClick="return onClickChangeConfig()" />
  </td>
  <td style={align:right} colspan="6">
   <input name="enableConf" class="buttomStyle" type="submit" value="Enable" onClick="return onClickChangeConfig()" />
   <input name="disableConf" class="buttomStyle" type="submit" value="Disable" onClick="return onClickChangeConfig()" />
  </td>
 </tr>
</table>
<input name="submit-url" type="hidden" value="/ipsec.asp" />
<script>
 ipsecSelection();
</script>
</form>
</blockquote>
</body>
</html>

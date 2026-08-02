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
<title><% multilang("18" "LANG_PORT_FORWARDING"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function skip () { this.blur(); }
/*function postFW( localIP, localport_from, localport_to, protocol, comment, enable, remoteIP, remotePort, interface, select )
{
	if ( document.formPortFwAdd.enabled.checked==true )
	{
		document.formPortFwAdd.ip.value=localIP;
		document.formPortFwAdd.toPort.value=localport_to;
		document.formPortFwAdd.protocol.value=protocol;
		document.formPortFwAdd.comment.value=comment;
		if( enable==0 )
			document.formPortFwAdd.fw_enable.checked=false;
		else
			document.formPortFwAdd.fw_enable.checked=true;

		document.formPortFwAdd.remoteIP.value=remoteIP;
		document.formPortFwAdd.remotePort.value=remotePort;
		document.formPortFwAdd.interface.value=interface;
		document.formPortFwAdd.select_id.value=select;

	}
}*/
function addClick()
{
 var mutli_comment = document.formPortFwAdd.elements["comment[]"];
 var mutli_localIPAddr = document.formPortFwAdd.elements["localIPaddr[]"];
 var mutli_localFromPort = document.formPortFwAdd.elements["localFromPort[]"];
 var mutli_localToPort = document.formPortFwAdd.elements["localToPort[]"];
 var mutli_protocol = document.formPortFwAdd.elements["protocol[]"];
 var mutli_remoteIPAddr = document.formPortFwAdd.elements["remoteIPaddr[]"];
 var mutli_remoteFromPort = document.formPortFwAdd.elements["remoteFromPort[]"];
 var mutli_remoteToPort = document.formPortFwAdd.elements["remoteToPort[]"];
 var mutli_interface = document.formPortFwAdd.elements["interface[]"];
 //  if (!document.formPortFwAdd.enabled.checked)
 if (document.formPortFwAdd.portFwcap[0].checked)
  return true;
    if (mutli_localIPAddr[0].value=="" && mutli_localFromPort[0].value=="" &&
      mutli_localToPort[0].value=="" && mutli_comment[0].value=="" ) {
     alert('<% multilang("2112" "LANG_LOCAL_SETTINGS_CANNOT_BE_EMPTY"); %>');
   return false;
 }
 for(var i=0;i<mutli_localFromPort.length;i++)
 {
  if (mutli_comment[i].value=="")
   continue;
  /*if (document.formPortFwAdd.ip.value=="") {
		  alert("IP address cannot be empty! It should be filled with 4 digit numbers as xxx.xxx.xxx.xxx.");
		  document.formPortFwAdd.ip.focus();
		  return false;
		  }
		  if ( validateKey( document.formPortFwAdd.ip.value ) == 0 ) {
		  alert("Invalid IP address value. It should be the decimal number (0-9).");
		  document.formPortFwAdd.ip.focus();
		  return false;
		  }
		  if ( !checkDigitRange(document.formPortFwAdd.ip.value,1,0,255) ) {
		  alert('Invalid IP address range in 1st digit. It should be 0-255.');
		  document.formPortFwAdd.ip.focus();
		  return false;
		  }
		  if ( !checkDigitRange(document.formPortFwAdd.ip.value,2,0,255) ) {
		  alert('Invalid IP address range in 2nd digit. It should be 0-255.');
		  document.formPortFwAdd.ip.focus();
		  return false;
		  }
		  if ( !checkDigitRange(document.formPortFwAdd.ip.value,3,0,255) ) {
		  alert('Invalid IP address range in 3rd digit. It should be 0-255.');
		  document.formPortFwAdd.ip.focus();
		  return false;
		  }
		  if ( !checkDigitRange(document.formPortFwAdd.ip.value,4,1,254) ) {
		  alert('Invalid IP address range in 4th digit. It should be 1-254.');
		  document.formPortFwAdd.ip.focus();
		  return false;
		  }*/
  if (mutli_localIPAddr[i].value!="")
  {
   if (!checkHostIP(mutli_localIPAddr[i], 1))
   {
    alert('<% multilang("2113" "LANG_INVALID_LOCAL_IP_ADDRESS"); %>');
    mutli_localIPAddr[i].focus();
    return false;
   }
  }
  if ( mutli_remoteIPAddr[i].value!="" ) {
   if (!checkHostIP(mutli_remoteIPAddr[i], 0))
            {
    alert('<% multilang("2114" "LANG_INVALID_REMOTE_IP_ADDRESS"); %>');
    mutli_remoteIPAddr[i].focus();
    return false;
            }
  }
        console.debug("multi_localFromPort "+mutli_localFromPort[i].value);
  if (mutli_localFromPort[i].value!="") {
   if ( validateKey( mutli_localFromPort[i].value ) == 0 ) {
    alert('<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>');
    mutli_localFromPort[i].focus();
    return false;
   }
   d2 = getDigit(mutli_localFromPort[i].value, 1);
   if (d2 > 65535 || d2 < 1) {
    alert('<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>');
    mutli_localFromPort[i].focus();
    return false;
   }
  }
        console.debug("multi_remoteFromPort "+mutli_remoteFromPort[i].value);
  if (mutli_remoteFromPort[i].value!="") {
   if ( validateKey( mutli_remoteFromPort[i].value ) == 0 ) {
    alert('<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>');
    mutli_remoteFromPort[i].focus();
    return false;
   }
   d2 = getDigit(mutli_remoteFromPort[i].value, 1);
   if (d2 > 65535 || d2 < 1) {
    alert('<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>');
    mutli_remoteFromPort[i].focus();
    return false;
   }
  }
  if (mutli_localToPort[i].value!="") {
   if ( validateKey( mutli_localToPort[i].value ) == 0 ) {
    alert('<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>');
    mutli_localToPort[i].focus();
    return false;
   }
   d2 = getDigit(mutli_localToPort[i].value, 1);
   if (d2 > 65535 || d2 < 1) {
    alert('<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>');
    mutli_localToPort[i].focus();
    return false;
   }
  }
  if (mutli_remoteToPort[i].value!="") {
   if ( validateKey( mutli_remoteToPort[i].value ) == 0 ) {
    alert('<% multilang("2115" "LANG_INVALID_PORT_NUMBER_IT_SHOULD_BE_THE_DECIMAL_NUMBER_0_9"); %>');
    mutli_remoteToPort[i].focus();
    return false;
   }
   d2 = getDigit(mutli_remoteToPort[i].value, 1);
   if (d2 > 65535 || d2 < 1) {
    alert('<% multilang("2116" "LANG_INVALID_PORT_NUMBER_YOU_SHOULD_SET_A_VALUE_BETWEEN_1_65535"); %>');
    mutli_remoteToPort[i].focus();
    return false;
   }
  }
 }
 return true;
}
function disableDelButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.formPortFwDel.deleteSelPortFw);
 disableButton(document.formPortFwDel.deleteAllPortFw);
  }
}
function updateState()
{
 var mutli_comment = document.formPortFwAdd.elements["comment[]"];
 var mutli_localIPAddr = document.formPortFwAdd.elements["localIPaddr[]"];
 var mutli_localFromPort = document.formPortFwAdd.elements["localFromPort[]"];
 var mutli_localToPort = document.formPortFwAdd.elements["localToPort[]"];
 var mutli_protocol = document.formPortFwAdd.elements["protocol[]"];
 var mutli_remoteIPAddr = document.formPortFwAdd.elements["remoteIPaddr[]"];
 var mutli_remoteFromPort = document.formPortFwAdd.elements["remoteFromPort[]"];
 var mutli_remoteToPort = document.formPortFwAdd.elements["remoteToPort[]"];
 var mutli_interface = document.formPortFwAdd.elements["interface[]"];
 if (document.formPortFwAdd.portFwcap[1].checked)
 {
  for(var i=0;i<mutli_localFromPort.length;i++)
  {
   enableTextField(mutli_comment[i]);
   mutli_comment[i].value = "";
   enableTextField(mutli_localIPAddr[i]);
   mutli_localIPAddr[i].value = "";
   enableTextField(mutli_localFromPort[i]);
   mutli_localFromPort[i].value = "";
   enableTextField(mutli_localToPort[i]);
   mutli_localToPort[i].value = "";
   enableTextField(mutli_protocol[i]);
   mutli_protocol[i].selectedIndex = 0;
   enableTextField(mutli_remoteIPAddr[i]);
   mutli_remoteIPAddr[i].value = "";
   enableTextField(mutli_remoteFromPort[i]);
   mutli_remoteFromPort[i].value = "";
   enableTextField(mutli_remoteToPort[i]);
   mutli_remoteToPort[i].value = "";
   enableTextField(mutli_interface[i]);
   mutli_interface[i].selectedIndex = 0;
  }
  document.formPortFwAdd.app.disabled=false;
  document.formPortFwAdd.fw_enable.disabled=false;
  document.formPortFwAdd.addPortFw.disabled=false;
 }
 else
 {
  for(var i=0;i<mutli_localFromPort.length;i++ )
  {
   disableTextField(mutli_comment[i]);
   mutli_comment[i].value = "";
   disableTextField(mutli_localIPAddr[i]);
   mutli_localIPAddr[i].value = "";
   disableTextField(mutli_localFromPort[i]);
   mutli_localFromPort[i].value = "";
   disableTextField(mutli_localToPort[i]);
   mutli_localToPort[i].value = "";
   disableTextField(mutli_protocol[i]);
   mutli_protocol[i].selectedIndex = 0;
   disableTextField(mutli_remoteIPAddr[i]);
   mutli_remoteIPAddr[i].value = "";
   disableTextField(mutli_remoteFromPort[i]);
   mutli_remoteFromPort[i].value = "";
   disableTextField(mutli_remoteToPort[i]);
   mutli_remoteToPort[i].value = "";
   disableTextField(mutli_interface[i]);
   mutli_interface[i].selectedIndex = 0;
  }
  document.formPortFwAdd.app.disabled=true;
  document.formPortFwAdd.fw_enable.disabled=true;
  document.formPortFwAdd.addPortFw.disabled=true;
 }
}
function portFWClick(url)
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
 window.open( url, 'portFWTbl', settings );
}
var app_array = //protocol 1: TCP 2: UDP 4:Both
[
 //Active Worlds
 [
  [3000, 3000, 3000, 3000, 1],
  [5670, 5670, 5670, 5670, 1],
  [7777, 7777, 7777, 7777, 1],
  [7000, 7100, 7000, 7100, 1]
 ],
 //Age of Empires II
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Age of Empires Expansion: This Rise of Rome
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Age of Empires II Expansion: The Conquerors
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Age of Empires II Expansion: The Age of Kings
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Age of Kings
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Age of Wonders
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Aliens vs. Predator
 [
  [80, 80, 80, 80, 1],
  [2300, 2400, 2300, 2400, 2],
  [8000, 8999, 8000, 8999, 2]
 ],
 //AOL Instant Messenger
 [
  [443, 443, 443, 443, 1]
 ],
 //Audiogalaxy Satellite
 [
  [41000, 50000, 41000, 50000, 1],
  [1117, 5190, 1117, 5190, 1]
 ],
 //AUTH
 [
  [113, 113, 113, 113, 1],
 ],
 //Baldur's Gate
 [
  [47624, 47624, 47624, 47624, 4]
 ],
 //BattleCom
 [
  [47624, 47624, 47624, 47624, 1],
  [47624, 47624, 47624, 47624, 2],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Battlefield Communicator
 [
  [47624, 47624, 47624, 47624, 1],
  [47624, 47624, 47624, 47624, 2],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Black and White
 [
  [2611, 2612, 2611, 2612, 1],
  [6667, 6667, 6667, 6667, 1],
  [6500, 6500, 6500, 6500, 2],
  [27900, 27900, 27900, 27900, 2]
 ],
 //Blazzard Battle.net
 [
  [4000, 4000, 4000, 4000, 1],
  [6112, 6112, 6112, 6112, 1],
  [6112, 6112, 6112, 6112, 2]
 ],
 //Buddy Phone
 [
  [700, 701, 700, 701, 1]
 ],
 //Bungie.net
 [
  [3453, 3453, 3453, 3453, 1]
 ],
 //Camerades
 [
  [2047, 2048, 2047, 2048, 1],
  [2047, 2048, 2047, 2048, 2]
 ],
 //CART Precision Racing
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Close Combat for Windows
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Close Combat III: The Russian Front
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Close Combat: A Bridge Too Far
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Combat Flight Simulator 2: WWW II Pacific Theater
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Combat Flight Simulator 2: WWW II Europe Series
 [
  [47624, 47624, 47624, 47624, 1],
  [6073, 6073, 6073, 6073, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
 //Crimson Skies
 [
  [1121, 1121, 1121, 1121, 1],
  [3040, 3040, 3040, 3040, 1],
  [28801, 28801, 28801, 28801, 1],
  [28805, 28805, 28805, 28805, 1]
 ],
 //CuSeeMe
 [
  [1414, 1414, 1414, 1414, 2],
  [1424, 1424, 1424, 1424, 2],
  [1503, 1503, 1503, 1503, 1],
  [1720, 1720, 1720, 1720, 1],
  [1812, 1813, 1812, 1813, 2],
  [7640, 7640, 7640, 7640, 2],
  [7642, 7642, 7642, 7642, 2],
  [7648, 7648, 7648, 7648, 4],
  [7649, 7649, 7649, 7649, 1],
  [24032, 24032, 24032, 24032, 2],
  [56800, 56800, 56800, 56800, 2]
 ],
 //Dark Reign 2
 [
        [26214, 26214, 26214, 26214, 1],
        [26214, 26214, 26214, 26214, 2]
 ],
    //Delta Force 2
 [
        [3568, 3569, 3568, 3569, 2]
 ],
  //Delta Three PC to Phone
 [
        [12053, 12053, 12053, 12053, 1],
        [12080, 12080, 12080, 12080, 1],
        [12083, 12083, 12083, 12083, 2],
        [12120, 12120, 12120, 12120, 2],
        [12122, 12122, 12122, 12122, 2],
        [24150, 24179, 24150, 24179, 2]
 ],
  //Descent 3
 [
        [7170, 7170, 7170, 7170, 1],
        [2092, 2092, 2092, 2092, 2],
        [3445, 3445, 3445, 3445, 2]
 ],
  //Descent Freespace
 [
        [3440, 3440, 3440, 3440, 2],
        [3493, 3493, 3493, 3493, 2],
        [3999, 3999, 3999, 3999, 1],
        [4000, 4000, 4000, 4000, 2],
        [7000, 7000, 7000, 7000, 2]
 ],
  //Diablo I
 [
        [6112, 6112, 6112, 6112, 1],
        [6112, 6112, 6112, 6112, 2]
 ],
  //Diablo II
 [
        [6112, 6112, 6112, 6112, 4]
 ],
  //DialPad.Com
 [
        [1584, 1585, 1584, 1585, 1],
        [7175, 7175, 7175, 7175, 1],
        [8680, 8686, 8680, 8686, 1],
        [51200, 51201, 51200, 51201, 2],
        [51210, 51210, 51210, 51210, 1]
 ],
  //DirectX 7 Games
 [
  [47624, 47624, 47624, 47624, 1],
  [2300, 2400, 2300, 2400, 4]
 ],
  //DirectX 8 Games
 [
  [47624, 47624, 47624, 47624, 1],
  [2300, 2400, 2300, 2400, 2]
 ],
  //Domain Name Server (DNS)
 [
        [53, 53, 53, 53, 4]
 ],
  //Doom
 [
        [666, 666, 666, 666, 4]
 ],
  //Dune 2000
 [
        [1140, 1140, 1140, 1140, 2],
        [4000, 4000, 4000, 4000, 1]
 ],
  //Dwyoo Video Conferencing
 [
        [1024, 5000, 1024, 5000, 1],
        [6700, 6702, 6700, 6702, 1],
        [6880, 6880, 6880, 6880, 1],
        [12000, 16090, 12000, 16090, 2]
 ],
  //Elite Force
 [
        [26000, 26000, 26000, 26000, 2],
        [27500, 27500, 27500, 27500, 2],
        [27910, 27910, 27910, 27910, 2],
        [27960, 27960, 27960, 27960, 2]
 ],
  //Everquest
 [
        [1024, 6000, 1024, 6000, 4],
        [6001, 7000, 6001, 7000, 1]
 ],
  //F-16
 [
        [3862, 3863, 3862, 3863, 2]
 ],
  //F-22 Lightning 3
 [
        [3875, 3875, 3875, 3875, 2],
        [4533, 4534, 4533, 4534, 2],
        [4660, 4670, 4660, 4670, 2]
 ],
 //F-22 Raptor
 [
        [3874, 3875, 3874, 3875, 2]
 ],
 //F22 Raptor (Novalogic)
 [
        [3874, 3875, 3874, 3875, 2]
 ],
 //Falcon 4.0
 [
        [2934, 2934, 2934, 2934, 2]
 ],
 //Fighter Ace II
 [
        [50000, 50100, 50000, 50100, 4],
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Flight Simulator 2000
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Freetel
 [
        [21300, 21303, 21300, 21303, 2]
    ],
 //FTP Server
 [
        [21, 21, 21, 21, 1]
    ],
 //GNUtella
 [
        [6346, 6347, 6346, 6347, 4]
    ],
 //Golf 2001 Edition
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Go2Call
 [
        [2090, 2090, 2090, 2090, 4]
 ],
 //Half Life
 [
        [6003, 6003, 6003, 6003, 1],
        [6003, 6003, 6003, 6003, 2],
        [7001, 7001, 7001, 7001, 4],
        [27005, 27005, 27005, 27005, 2],
        [27010, 27010, 27010, 27010, 2]
 ],
 //Half Life Server
 [
        [27015, 27015, 27015, 27015, 2]
 ],
 //Heretic II Server
 [
  [28910, 28910, 28910, 28910, 4]
 ],
 //I76
 [
        [21154, 21156, 21154, 21156, 2]
 ],
 //ICUII Client
 [
        [2019, 2019, 2019, 2019, 1],
        [2000, 2000, 2000, 2000, 1],
        [2050, 2051, 2050, 2051, 1],
        [2069, 2069, 2069, 2069, 1],
        [2085, 2085, 2085, 2085, 1],
        [3010, 3030, 3010, 3030, 1]
 ],
 //Ivisit
 [
        [9943, 9943, 9943, 9943, 2],
  [56768, 56768, 56768, 56768, 2]
 ],
 //IPSEC
 [
        [500, 500, 500, 500, 2]
 ],
 //IRC
 [
        [1024, 5000, 1024, 5000, 1],
        [6660, 6669, 6660, 6669, 1],
  [113, 113, 113, 113, 2]
 ],
 //IStreamVideo2HP
 [
        [8076, 9943, 8077, 8077, 4]
 ],
 //KaZaA
 [
        [1024, 1024, 1024, 1024, 1]
 ],
 //Kohan Immortal Sovereigns
 [
        [3855, 3855, 3855, 3855, 4],
        [17437, 17437, 17437, 17437, 4]
 ],
 //LapLink Gold
 [
        [1547, 1547, 1547, 1547, 1]
 ],
 //Links 2001
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Lotus Notes Server
 [
        [1352, 1352, 1352, 1352, 1]
 ],
 //Mail (POP3)
 [
        [110, 110, 110, 110, 1]
 ],
 //Mail (SMTP)
 [
        [25, 25, 25, 25, 1]
 ],
 //MechCommander 2.0
 //Links 2001
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //MechWarrior 4
 //Links 2001
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Media Player 7
 [
        [1755, 1755, 1755, 1755, 1],
        [70, 7000, 70, 7000, 2],
 ],
 //Midtown Madness 2
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Mig 29
 [
        [3862, 3863, 3862, 3863, 2]
 ],
 //Monster Truck Madness 2
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Motocross Madness 2
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //Motorhead Server
 [
        [16000, 16000, 16000, 16000, 1],
        [16000, 16000, 16000, 16000, 2]
 ],
 //MSN Gaming Zone
 [
        [6667, 6667, 6667, 6667, 1],
        [28800, 28800, 28800, 28800, 1],
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //MSN Messenger
 [
        [6891, 6901, 6891, 6901, 1],
        [1863, 1963, 1863, 1963, 1],
        [1863, 1863, 1863, 1863, 2],
        [5190, 5190, 5190, 5190, 2],
        [6901, 6901, 6901, 6901, 2]
 ],
 //Myth
 [
        [3453, 3453, 3453, 3453, 1]
 ],
 //Myth II Server
 [
        [3453, 3453, 3453, 3453, 1]
 ],
 //Myth: The Fallen Lords
 [
        [3453, 3453, 3453, 3453, 1]
 ],
 //Need for Speed
 [
  [9442, 9442, 9442, 9442, 1],
        [6112, 6112, 6112, 6112, 2]
 ],
 //NetMech
 [
        [21154, 21154, 21154, 21154, 2]
 ],
 //Netmeeting 2.0, 3.0, Intel Video Phone
 [
        [1024, 65534, 1024, 65534, 2],
        [1024, 1502, 1024, 1502, 1],
        [1504, 1730, 1504, 1730, 1],
        [1732, 65534, 1732, 65534, 1],
        [1503, 1503, 1503, 1503, 1],
        [1731, 1731, 1731, 1731, 1]
 ],
 //Network Time Protocol (NTP)
 [
        [123, 123, 123, 123, 1]
 ],
 //News Server (NNTP)
 [
        [119, 119, 119, 119, 1]
 ],
 //OKWeb
 [
        [80, 80, 80, 80, 1],
        [443, 443, 443, 443, 1],
        [5210, 5220, 5210, 5220, 1]
 ],
 //OKWin
 [
        [80, 80, 80, 80, 1],
        [1729, 1729, 1729, 1729, 1],
        [1909, 1909, 1909, 1909, 1]
 ],
 //Outlaws
 [
        [5310, 5310, 5310, 5310, 4]
 ],
 //Pal Talk
 [
        [2090, 2090, 2090, 2090, 4],
        [2091, 2091, 2091, 1729, 4],
        [2095, 2095, 2095, 2095, 1]
 ],
 //pcAnywhere v7.5
 [
        [5631, 5631, 5631, 5631, 1],
        [5631, 5631, 5631, 5631, 2]
 ],
 //PhoneFree
 [
        [1034, 1035, 1034, 1035, 1],
        [2090, 2090, 2090, 2090, 2],
        [9900, 9901, 9900, 9901, 2],
        [2644, 2644, 2644, 2644, 1],
        [8000, 8000, 8000, 8000, 1]
 ],
 //Polycom ViaVideo H.323
 [
        [3230, 3235, 3230, 3235, 1]
 ],
 //Polycom ViaVideo H.324
 [
        [3230, 3235, 3230, 3235, 1]
 ],
 //PPTP
 [
        [1723, 1723, 1723, 1723, 1]
 ],
 //Quake
 [
        [26000, 26000, 26000, 26000, 4]
 ],
 //Quake II (Client and Server)
 [
        [27660, 27680, 27660, 27680, 2]
 ],
 //Quake III
 [
        [27660, 27680, 27660, 27680, 2]
 ],
 //RealAudio
 [
        [6790, 32000, 6790, 32000, 2]
 ],
 //Real Player 8 Plus
 [
        [7070, 7070, 7070, 7070, 2]
 ],
 //Red Alert
 [
        [5009, 5009, 5009, 5009, 2]
 ],
 //Rise of Rome
 [
        [47624, 47624, 47624, 47624, 4]
 ],
 //Roger Wilco
 [
        [3782, 3783, 3782, 3783, 4]
 ],
 //Rogue Spear
 [
        [2346, 2346, 2346, 2346, 1]
 ],
 //Secure Shell Server (SSH)
 [
        [22, 22, 22, 22, 1]
 ],
 //Secure Web Server (HTTPS)
 [
        [443, 443, 443, 443, 1]
 ],
 //ShoutCast
 [
        [8000, 8005, 8000, 8005, 1]
 ],
 //SNMP
 [
        [161, 161, 161, 161, 2]
 ],
 //SNMP Trap
 [
        [162, 162, 161, 161, 2]
 ],
 //Speak Freely
 [
        [2074, 2076, 2074, 2076, 2]
 ],
 //StarCraft
 [
        [6112, 6112, 6112, 6112, 2]
 ],
 //Starfleet Command
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //StarLancer
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //SWAT3
 [
        [16639, 16639, 16639, 16639, 1],
        [16638, 16638, 16638, 16638, 2]
 ],
 //Telnet Server
 [
        [23, 23, 23, 23, 1]
 ],
 //The 4th Coming
 [
        [11677, 11677, 11677, 11677, 2],
        [11679, 11679, 11679, 11679, 2]
 ],
 //TFTP
 [
        [69, 69, 69, 69, 1]
 ],
 //Tiberian Sun: C&C III
 [
        [1234, 1234, 1234, 1234, 2]
 ],
 //Total Annihilation
 [
        [47624, 47624, 47624, 47624, 2]
 ],
 //Ultima
 [
        [5001, 5010, 5001, 5010, 1],
        [7775, 7777, 7775, 7777, 1],
        [8800, 8900, 8800, 8900, 1],
        [9999, 9999, 9999, 9999, 1],
        [7875, 7875, 7875, 7875, 1]
 ],
 //Unreal Tournament
 [
        [7777, 7790, 7777, 7790, 2],
        [27900, 27900, 27900, 27900, 2],
        [8080, 8080, 8080, 8080, 1]
 ],
 //Urban Assault
 [
        [47624, 47624, 47624, 47624, 1],
        [6073, 6073, 6073, 6073, 1],
        [2300, 2400, 2300, 2400, 4]
 ],
 //VoxPhone 3.0
 [
        [12380, 12380, 12380, 12380, 1],
        [12380, 12380, 12380, 12380, 2]
 ],
 //Warbirds 2
 [
        [912, 912, 912, 912, 1]
 ],
 //Web Server (HTTP)
 [
        [80, 80, 80, 80, 1]
 ],
 //WebPhone 3.0
 [
        [21845, 21845, 21845, 21845, 1]
 ],
 //Westwood Online
 [
        [4000, 4000, 4000, 4000, 2],
        [1140, 1234, 1140, 1234, 4]
 ],
 //Windows 2000 Terminal Server
 [
        [3389, 3389, 3389, 3389, 4]
 ],
 //Xbox LIVE
 [
        [80, 80, 80, 80, 1],
        [88, 88, 88, 88, 2],
        [53, 53, 53, 53, 4],
        [3074, 3074, 3074, 3074, 4],
        [1863, 1863, 1863, 1863, 4]
 ],
 //X Windows
 [
        [6000, 6000, 6000, 6000, 4]
 ],
 //Yahoo Pager
 [
        [5050, 5050, 5050, 5050, 1]
 ],
 //Yahoo Messenger Chat
 [
        [5000, 5000, 5000, 5000, 1],
        [5055, 5055, 5055, 5055, 2]
 ]
   ];
function clearPFWD()
{
 var mutli_comment = document.formPortFwAdd.elements["comment[]"];
 var mutli_localIPAddr = document.formPortFwAdd.elements["localIPaddr[]"];
 var mutli_localFromPort = document.formPortFwAdd.elements["localFromPort[]"];
 var mutli_localToPort = document.formPortFwAdd.elements["localToPort[]"];
 var mutli_protocol = document.formPortFwAdd.elements["protocol[]"];
 var mutli_remoteIPAddr = document.formPortFwAdd.elements["remoteIPaddr[]"];
 var mutli_remoteFromPort = document.formPortFwAdd.elements["remoteFromPort[]"];
 var mutli_remoteToPort = document.formPortFwAdd.elements["remoteToPort[]"];
 with ( document.forms[0] )
 {
  for( var i=0;i<mutli_localFromPort.length;i++)
  {
   mutli_comment[i].value = "";
   mutli_localIPAddr[i].value = "";
   mutli_localFromPort[i].value = "";
   mutli_localToPort[i].value = "";
   mutli_protocol[i].value = "";
   mutli_remoteIPAddr[i].value = "";
   mutli_remoteFromPort[i].value = "";
   mutli_remoteToPort[i].value = "";
  }
 }
}
function onAppSelection()
{
 var mutli_comment = document.formPortFwAdd.elements["comment[]"];
 var mutli_localIPAddr = document.formPortFwAdd.elements["localIPaddr[]"];
 var mutli_localFromPort = document.formPortFwAdd.elements["localFromPort[]"];
 var mutli_localToPort = document.formPortFwAdd.elements["localToPort[]"];
 var mutli_protocol = document.formPortFwAdd.elements["protocol[]"];
 var mutli_remoteIPAddr = document.formPortFwAdd.elements["remoteIPaddr[]"];
 var mutli_remoteFromPort = document.formPortFwAdd.elements["remoteFromPort[]"];
 var mutli_remoteToPort = document.formPortFwAdd.elements["remoteToPort[]"];
 clearPFWD();
 with ( document.forms[0] )
 {
  for(var i=0;i<app_array[app.value].length;i++)
  {
   var sel = document.getElementById('app_id');
   mutli_comment[i].value = document.formPortFwAdd.app.options[document.formPortFwAdd.app.selectedIndex].label; // sel.options[sel.selectedIndex].label
   mutli_localFromPort[i].value = app_array[app.value][i][0].toString();
   mutli_localToPort[i].value = app_array[app.value][i][1].toString();
   mutli_remoteFromPort[i].value = app_array[app.value][i][2].toString();
   mutli_remoteToPort[i].value = app_array[app.value][i][3].toString();
   mutli_protocol[i].value = app_array[app.value][i][4];
  }
 }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("18" "LANG_PORT_FORWARDING"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
<tr><td><font size=2>
 <% multilang("326" "LANG_ENTRIES_IN_THIS_TABLE_ALLOW_YOU_TO_AUTOMATICALLY_REDIRECT_COMMON_NETWORK_SERVICES_TO_A_SPECIFIC_MACHINE_BEHIND_THE_NAT_FIREWALL_THESE_SETTINGS_ARE_ONLY_NECESSARY_IF_YOU_WISH_TO_HOST_SOME_SORT_OF_SERVER_LIKE_A_WEB_SERVER_OR_MAIL_SERVER_ON_THE_PRIVATE_LOCAL_NETWORK_BEHIND_YOUR_GATEWAY_S_NAT_FIREWALL"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
<form action=/boaform/formPortFw method=POST name="formPortFwAdd">
<tr><td><font size=2><b><% multilang("18" "LANG_PORT_FORWARDING"); %>:</b>
 <input type="radio" value="0" name="portFwcap" <% checkWrite("portFw-cap0"); %> onClick="updateState()"><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
 <input type="radio" value="1" name="portFwcap" <% checkWrite("portFw-cap1"); %> onClick="updateState()"><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
 <input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="apply">&nbsp;&nbsp;
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
<table border=0 width="500" cellspacing=0 cellpadding=0>
 <tr>
  <td><font size=2>
   <b><% multilang("207" "LANG_ENABLE"); %></b>
  </td>
  <td><font size=2>
   <input type="checkbox" name="fw_enable" value="1" checked>
  </td>
  <td><font size=2>
   <b><% multilang("334" "LANG_APPLICATION"); %></b>
  </td>
  <td><font size=2>
   <select name="app" id="app_id" onchange="onAppSelection()" >
    <option value=0 label="Active Worlds">Active Worlds</option>
    <option value=1 label="Age of Empires">Age of Empires</option>
    <option value=2 label="Age of Empires Expansion: The Rise of Rome">Age of Empires Expansion: The Rise of Rome</option>
    <option value=3 label="Age of Empires II Expansion: The Conquerors">Age of Empires II Expansion: The Conquerors</option>
    <option value=4 label="Age of Empires II: The Age of Kings">Age of Empires II: The Age of Kings</option>
    <option value=5 label="Age of Kings">Age of Kings</option>
    <option value=6 label="Age of Wonders">Age of Wonders</option>
    <option value=7 label="Aliens vs. Predator">Aliens vs. Predator</option>
    <option value=8 label="AOL Instant Messenger">AOL Instant Messenger</option>
    <option value=9 label="Audiogalaxy Satellite">Audiogalaxy Satellite</option>
    <option value=10 label="AUTH">AUTH</option>
    <option value=11 label="Baldur's Gate">Baldur's Gate</option>
    <option value=12 label="BattleCom">BattleCom</option>
    <option value=13 label="Battlefield Communicator">Battlefield Communicator</option>
    <option value=14 label="Black and White">Black and White</option>
    <option value=15 label="Blizzard Battle.net">Blizzard Battle.net</option>
    <option value=16 label="Buddy Phone">Buddy Phone</option>
    <option value=17 label="Bungie.net">Bungie.net</option>
    <option value=18 label="Camerades">Camerades</option>
    <option value=19 label="CART Precision Racing">CART Precision Racing</option>
    <option value=20 label="Close Combat for Windows">Close Combat for Windows</option>
    <option value=21 label="Close Combat III: The Russian Front">Close Combat III: The Russian Front</option>
    <option value=22 label="Close Combat: A Bridge Too Far">Close Combat: A Bridge Too Far</option>
    <option value=23 label="Combat Flight Simulator 2: WWII Pacific Theater">Combat Flight Simulator 2: WWII Pacific Theater</option>
    <option value=24 label="Combat Flight Simulator: WWII Europe Series">Combat Flight Simulator: WWII Europe Series</option>
    <option value=25 label="Crimson Skies">Crimson Skies</option>
    <option value=26 label="CuSeeMe">CuSeeMe</option>
    <option value=27 label="Dark Reign 2">Dark Reign 2</option>
    <option value=28 label="Delta Force 2">Delta Force 2</option>
    <option value=29 label="Delta Three PC to Phone">Delta Three PC to Phone</option>
    <option value=30 label="Descent 3">Descent 3</option>
    <option value=31 label="Descent Freespace">Descent Freespace</option>
    <option value=32 label="Diablo I">Diablo I</option>
    <option value=33 label="Diablo II">Diablo II</option>
    <option value=34 label="DialPad.Com">DialPad.Com</option>
    <option value=35 label="DirectX 7 Games">DirectX 7 Games</option>
    <option value=36 label="DirectX 8 Games">DirectX 8 Games</option>
    <option value=37 label="Domain Name Server (DNS)">Domain Name Server (DNS)</option>
    <option value=38 label="Doom">Doom</option>
    <option value=39 label="Dune 2000">Dune 2000</option>
    <option value=40 label="Dwyco Video Conferencing">Dwyco Video Conferencing</option>
    <option value=41 label="Elite Force">Elite Force</option>
    <option value=42 label="Everquest">Everquest</option>
    <option value=43 label="F-16">F-16</option>
    <option value=44 label="F-22 Lightning 3">F-22 Lightning 3</option>
    <option value=45 label="F-22 Raptor">F-22 Raptor</option>
    <option value=46 label="F22 Raptor (Novalogic)">F22 Raptor (Novalogic)</option>
    <option value=47 label="Falcon 4.0">Falcon 4.0</option>
    <option value=48 label="Fighter Ace II">Fighter Ace II</option>
    <option value=49 label="Flight Simulator 2000">Flight Simulator 2000</option>
    <option value=50 label="Freetel">Freetel</option>
    <option value=51 label="FTP Server">FTP Server</option>
    <option value=52 label="GNUtella">GNUtella</option>
    <option value=53 label="Golf 2001 Edition">Golf 2001 Edition</option>
    <option value=54 label="Go2Call">Go2Call</option>
    <option value=55 label="Half Life">Half Life</option>
    <option value=56 label="Half Life Server">Half Life Server</option>
    <option value=57 label="Heretic II Server">Heretic II Server</option>
    <option value=58 label="I76">I76</option>
    <option value=59 label="ICUII Client">ICUII Client</option>
    <option value=60 label="Ivisit">Ivisit</option>
    <option value=61 label="IPSEC">IPSEC</option>
    <option value=62 label="IRC">IRC</option>
    <option value=63 label="IStreamVideo2HP">IStreamVideo2HP</option>
    <option value=64 label="KaZaA">KaZaA</option>
    <option value=65 label="Kohan Immortal Sovereigns">Kohan Immortal Sovereigns</option>
    <option value=66 label="LapLink Gold">LapLink Gold</option>
    <option value=67 label="Links 2001">Links 2001</option>
    <option value=68 label="Lotus Notes Server">Lotus Notes Server</option>
    <option value=69 label="Mail (POP3)">Mail (POP3)</option>
    <option value=70 label="Mail (SMTP)">Mail (SMTP)</option>
    <option value=71 label="MechCommander 2.0">MechCommander 2.0</option>
    <option value=72 label="MechWarrior 4">MechWarrior 4</option>
    <option value=73 label="Media Player 7">Media Player 7</option>
    <option value=74 label="Midtown Madness 2">Midtown Madness 2</option>
    <option value=75 label="Mig 29">Mig 29</option>
    <option value=76 label="Monster Truck Madness 2">Monster Truck Madness 2</option>
    <option value=77 label="Motocross Madness 2">Motocross Madness 2</option>
    <option value=78 label="Motorhead Server">Motorhead Server</option>
    <option value=79 label="MSN Gaming Zone">MSN Gaming Zone</option>
    <option value=80 label="MSN Messenger">MSN Messenger</option>
    <option value=81 label="Myth">Myth</option>
    <option value=82 label="Myth II Server">Myth II Server</option>
    <option value=83 label="Myth: The Fallen Lords">Myth: The Fallen Lords</option>
    <option value=84 label="Need for Speed">Need for Speed</option>
    <option value=85 label="NetMech">NetMech</option>
    <option value=86 label="Netmeeting 2.0, 3.0, Intel Video Phone">Netmeeting 2.0, 3.0, Intel Video Phone</option>
    <option value=87 label="Network Time Protocol (NTP)">Network Time Protocol (NTP)</option>
    <option value=88 label="News Server (NNTP)">News Server (NNTP)</option>
    <option value=89 label="OKWeb">OKWeb</option>
    <option value=90 label="OKWin">OKWin</option>
    <option value=91 label="Outlaws">Outlaws</option>
    <option value=92 label="Pal Talk">Pal Talk</option>
    <option value=92 label="pcAnywhere v7.5">pcAnywhere v7.5</option>
    <option value=94 label="PhoneFree">PhoneFree</option>
    <option value=95 label="Polycom ViaVideo H.323">Polycom ViaVideo H.323</option>
    <option value=96 label="Polycom ViaVideo H.324">Polycom ViaVideo H.324</option>
    <option value=97 label="PPTP">PPTP</option>
    <option value=98 label="Quake">Quake</option>
    <option value=99 label="Quake II (Client and Server)">Quake II (Client and Server)</option>
    <option value=100 label="Quake III">Quake III</option>
    <option value=101 label="RealAudio">RealAudio</option>
    <option value=102 label="Real Player 8 Plus">Real Player 8 Plus</option>
    <option value=103 label="Red Alert">Red Alert</option>
    <option value=104 label="Rise of Rome">Rise of Rome</option>
    <option value=105 label="Roger Wilco">Roger Wilco</option>
    <option value=106 label="Rogue Spear">Rogue Spear</option>
    <option value=107 label="Secure Shell Server (SSH)">Secure Shell Server (SSH)</option>
    <option value=108 label="Secure Web Server (HTTPS)">Secure Web Server (HTTPS)</option>
    <option value=109 label="ShoutCast">ShoutCast</option>
    <option value=110 label="SNMP">SNMP</option>
    <option value=111 label="SNMP Trap">SNMP Trap</option>
    <option value=112 label="Speak Freely">Speak Freely</option>
    <option value=113 label="StarCraft">StarCraft</option>
    <option value=114 label="Starfleet Command">Starfleet Command</option>
    <option value=115 label="StarLancer">StarLancer</option>
    <option value=116 label="SWAT3">SWAT3</option>
    <option value=117 label="Telnet Server">Telnet Server</option>
    <option value=118 label="The 4th Coming">The 4th Coming</option>
    <option value=119 label="TFTP">TFTP</option>
    <option value=120 label="Tiberian Sun: C&C III">Tiberian Sun: C&C III"</option>
    <option value=121 label="Total Annihilation">Total Annihilation</option>
    <option value=122 label="Ultima">Ultima</option>
    <option value=123 label="Unreal Tournament">Unreal Tournament</option>
    <option value=124 label="Urban Assault">Urban Assault</option>
    <option value=125 label="VoxPhone 3.0">VoxPhone 3.0</option>
    <option value=126 label="Warbirds 2">Warbirds 2</option>
    <option value=127 label="Web Server (HTTP)">Web Server (HTTP)</option>
    <option value=128 label="WebPhone 3.0">WebPhone 3.0</option>
    <option value=129 label="Westwood Online">Westwood Online</option>
    <option value=130 label="Windows 2000 Terminal Server">Windows 2000 Terminal Server</option>
    <option value=131 label="Xbox LIVE">Xbox LIVE</option>
    <option value=132 label="X Windows">X Windows</option>
    <option value=133 label="Yahoo Pager">Yahoo Pager</option>
    <option value=134 label="Yahoo Messenger Chat">Yahoo Messenger Chat</option>
    </select>
   </select>
  </td>
<table border=0 width="500" cellspacing=0 cellpadding=0>
    <tr>
  <td>
   <font size=2><b><% multilang("328" "LANG_COMMENT"); %>
  </td>
  <td>
   <font size=2><b><% multilang("335" "LANG_LOCAL_IP"); %>
  </td>
  <td>
   <font size=2><b><% multilang("336" "LANG_LOCAL_PORT_FROM"); %>
  </td>
  <td>
   <font size=2><b><% multilang("337" "LANG_LOCAL_PORT_TO"); %>
  </td>
  <td>
   <font size=2><b><% multilang("75" "LANG_PROTOCOL"); %>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>>
   <font size=2><b><% multilang("338" "LANG_REMOTE_IP"); %>
  </td>
  <td>
   <font size=2><b><% multilang("339" "LANG_REMOTE_PORT_FROM"); %>
  </td>
  <td>
   <font size=2><b><% multilang("340" "LANG_REMOTE_PORT_TO"); %>
  </td>
  <td>
   <font size=2><b><% multilang("52" "LANG_INTERFACE"); %> </b><br>
  </td>
    </tr>
 <tr> <!-- 0 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
 <tr> <!-- 1 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
        <td> <input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
   </tr>
  <tr> <!-- 2 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
        <td> <input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
  <tr> <!-- 3 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
   </tr>
  <tr> <!-- 4 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
  <tr> <!-- 5 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
  <tr> <!-- 6 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
        <td> <input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
  <tr> <!-- 7 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
  </tr>
 <tr> <!-- 8 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
       <td> <input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
 <tr> <!-- 9 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
    </tr>
 <tr> <!-- 10 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
      <td> <input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
 </tr>
  <tr> <!-- 11 -->
  <td><input type="text" name="comment[]" size="30" maxlength="15"> </td>
  <td><input type="text" name="localIPaddr[]" size="15" maxlength="15"> </td>
  <td><input type="text" name="localFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="localToPort[]" size="5" maxlength="5"></td>
  <td><font size=2>
   <select name="protocol[]">
    <option select value=4><% multilang("327" "LANG_BOTH"); %></option>
    <option value=1>TCP</option>
    <option value=2>UDP</option>
   </select><br>
  </td>
  <td <% checkWrite("rg_hidden_function"); %>><input type="text" name="remoteIPaddr[]" size="15" maxlength="15"></td>
  <td><input type="text" name="remoteFromPort[]" size="5" maxlength="5"></td>
  <td><input type="text" name="remoteToPort[]" size="5" maxlength="5"></td>
  <td>
   <select name="interface[]">
    <% if_wan_list("rt-any"); %>
   </select>
   <input type="hidden" value="" name="select_id[]">
  </td>
   </tr>
 <tr>
  <td>
   <input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addPortFw" onClick="return addClick()">
   <input type="hidden" value="/fw-portfw.asp" name="submit-url">
  </td>
 </tr>
 </tr>
</table>
 <% showPFWAdvForm(); %>
 <tr><td colspan=4><hr size=1 noshade align=top></td></tr>
</table>
<script> updateState(); </script>
</form>
</table>
<form action=/boaform/formPortFw method=POST name="formPortFwDel">
 <table border=0 width=500>
  <tr><font size=2><b><% multilang("332" "LANG_CURRENT_PORT_FORWARDING_TABLE"); %>:</b></font></tr>
  <% portFwList(); %>
 </table>
 <br><input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="deleteSelPortFw" onClick="return deleteClick()">&nbsp;&nbsp;
     <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="deleteAllPortFw" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
 <script>
  <% checkWrite("portFwNum"); %>
 </script>
 <input type="hidden" value="/fw-portfw.asp" name="submit-url">
</form>
</blockquote>
</body>
</html>

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
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<link rel="stylesheet" type="text/css" href="/CSS.CSS">
<title>WAPI Key</title>
<style>
</style>
</head>
<SCRIPT src="/network.js"></SCRIPT>
<SCRIPT language=JavaScript>
var errMsg="input error!!!";
function sel_keytype()
{
  if(document.form1.KEY_TYPE_CHK[1].checked)
  {
   document.form1.MAC_INPUT.disabled=false;
   if(document.form1.MAC.value == "FF:FF:FF:FF:FF:FF")
   {
    document.form1.MAC_INPUT.value="";
   }
   else
    document.form1.MAC_INPUT.value=document.form1.MAC.value;
  }
  else
  {
   document.form1.MAC_INPUT.disabled=true;
   document.form1.MAC_INPUT.value="FF:FF:FF:FF:FF:FF"
  }
}
function key_select(sel)
{
 if (sel.selectedIndex == 0)
 {
  document.form1.KEY_TYPE_CHK[0].disabled = true;
  document.form1.KEY_TYPE_CHK[1].disabled = true;
  document.form1.MAC_INPUT.disabled = true;
  document.form1.MAC_INPUT.className = "input_txt_disabled";
  sel_keytype();
 }
 else if (sel.selectedIndex == 1)
 {
  document.form1.KEY_TYPE_CHK[0].disabled = false;
  document.form1.KEY_TYPE_CHK[1].disabled = false;
  document.form1.MAC_INPUT.disabled = false;
  document.form1.MAC_INPUT.className = "input_txt";
  sel_keytype();
 }
}
function rekey_policy_select(sel)
{
 if (sel.selectedIndex == 0)
 {
  document.form1.rekey_time.disabled = true;
  document.form1.rekey_packet.disabled = true;
  document.form1.rekey_time.className = "input_txt_disabled";
  document.form1.rekey_packet.className = "input_txt_disabled";
 }
 else if (sel.selectedIndex == 1)
 {
  document.form1.rekey_time.disabled = false;
  document.form1.rekey_packet.disabled = true;
  document.form1.rekey_time.className = "input_txt";
  document.form1.rekey_packet.className = "input_txt_disabled";
 }
 else if (sel.selectedIndex == 2)
 {
  document.form1.rekey_time.disabled = true;
  document.form1.rekey_packet.disabled = false
  document.form1.rekey_time.className = "input_txt_disabled";
  document.form1.rekey_packet.className = "input_txt";
 }
 else if (sel.selectedIndex == 3)
 {
  document.form1.rekey_time.disabled = false;
  document.form1.rekey_packet.disabled = false;
  document.form1.rekey_time.className = "input_txt";
  document.form1.rekey_packet.className = "input_txt";
 }
}
function rekey_policy_m_select(sel)
{
 if (sel.selectedIndex == 0)
 {
  document.form1.rekey_m_time.disabled = true;
  document.form1.rekey_m_packet.disabled = true;
  document.form1.rekey_m_time.className = "input_txt_disabled";
  document.form1.rekey_m_packet.className = "input_txt_disabled";
 }
 else if (sel.selectedIndex == 1)
 {
  document.form1.rekey_m_time.disabled = false;
  document.form1.rekey_m_packet.disabled = true;
  document.form1.rekey_m_time.className = "input_txt";
  document.form1.rekey_m_packet.className = "input_txt_disabled";
 }
 else if (sel.selectedIndex == 2)
 {
  document.form1.rekey_m_time.disabled = true;
  document.form1.rekey_m_packet.disabled = false
  document.form1.rekey_m_time.className = "input_txt_disabled";
  document.form1.rekey_m_packet.className = "input_txt";
 }
 else if (sel.selectedIndex == 3)
 {
  document.form1.rekey_m_time.disabled = false;
  document.form1.rekey_m_packet.disabled = false;
  document.form1.rekey_m_time.className = "input_txt";
  document.form1.rekey_m_packet.className = "input_txt";
 }
}
function get_value()
{
 document.form1.F_KEY.value = document.form1.f_key.selectedIndex ;
 if(document.form1.f_key.selectedIndex == 1)
 {
  document.form1.KEY_TYPE.value = (document.form1.KEY_TYPE_CHK[0].checked?0:1);
  document.form1.MAC.value = document.form1.MAC_INPUT.value;
 }
 document.form1.REKEY_M_POLICY.value = document.form1.rekey_m_policy.value;
 if(document.form1.rekey_m_policy.selectedIndex == 1)
 {
  document.form1.REKEY_M_TIME.value = document.form1.rekey_m_time.value;
 }
 else if(document.form1.rekey_m_policy.selectedIndex == 2)
 {
  document.form1.REKEY_M_PACKET.value = document.form1.rekey_m_packet.value;
 }
 else if(document.form1.rekey_m_policy.selectedIndex == 3)
 {
  document.form1.REKEY_M_TIME.value = document.form1.rekey_m_time.value;
  document.form1.REKEY_M_PACKET.value = document.form1.rekey_m_packet.value;
 }
 document.form1.REKEY_POLICY.value = document.form1.rekey_policy.value;
 if(document.form1.rekey_policy.selectedIndex == 1)
 {
  document.form1.REKEY_TIME.value = document.form1.rekey_time.value;
 }
 else if(document.form1.rekey_policy.selectedIndex == 2)
 {
  document.form1.REKEY_PACKET.value = document.form1.rekey_packet.value;
 }
 else if(document.form1.rekey_policy.selectedIndex == 3)
 {
  document.form1.REKEY_TIME.value = document.form1.rekey_time.value;
  document.form1.REKEY_PACKET.value = document.form1.rekey_packet.value;
 }
}
var check_rekey=0
function submit_check()
{
 if (check_rekey == 1)
 {
     return false;
 }
 if(document.form1.f_key.selectedIndex == 1)
 {
  if(document.form1.KEY_TYPE_CHK[1].checked)
  {
   if(document.form1.MAC_INPUT.value =="")
   {
    alert("<% multilang("2386" "LANG_PLEASE_INPUT_MAC_ADDRESS"); %>");
    document.form1.MAC_INPUT.focus();
    document.form1.MAC_INPUT.select();
    return false;
   }
   else if(!checkMacAddr(document.form1.MAC_INPUT, errMsg ))
   {
    //document.form1.MAC_INPUT.focus();
    //document.form1.MAC_INPUT.select();
    return false;
   }
  }
 }
 if (document.form1.rekey_m_policy.selectedIndex == 1)
 {
  if ((document.form1.rekey_m_time.value <300 ) ||(document.form1.rekey_m_time.value > 31536000))
  {
   alert("<% multilang("2387" "LANG_KEY_REGOUP_TIME_SHOUD_IN_300_31536000"); %>");
   document.form1.rekey_m_time.focus();
   return false;
  }
 }
 else if (document.form1.rekey_m_policy.selectedIndex == 2)
 {
  if (document.form1.rekey_m_packet.value <= 1048576)
  {
   alert("<% multilang("2388" "LANG_NUMBER_OF_PACKETS_SHOULD_GREAT_THAN_1048576"); %>");
   document.form1.rekey_m_packet.focus();
   return false;
  }
  if (document.form1.rekey_m_packet.value > 4294967295)
  {
   alert("<% multilang("2389" "LANG_NUMBER_OF_PACKETS_TOO_BIG"); %>");
   document.form1.rekey_m_packet.focus();
   return false;
  }
 }
 else if (document.form1.rekey_m_policy.selectedIndex == 3)
 {
  if ((document.form1.rekey_m_time.value <300 ) ||(document.form1.rekey_m_time.value > 31536000))
  {
   alert("<% multilang("2387" "LANG_KEY_REGOUP_TIME_SHOUD_IN_300_31536000"); %>");
   document.form1.rekey_m_time.focus();
   return false;
  }
  if (document.form1.rekey_m_packet.value <= 1048576)
  {
   alert("<% multilang("2388" "LANG_NUMBER_OF_PACKETS_SHOULD_GREAT_THAN_1048576"); %>");
   document.form1.rekey_m_packet.focus();
   return false;
  }
  if (document.form1.rekey_m_packet.value > 4294967295)
  {
   alert("<% multilang("2389" "LANG_NUMBER_OF_PACKETS_TOO_BIG"); %>");
   document.form1.rekey_m_packet.focus();
   return false;
  }
 }
 else
  ;
 if (document.form1.rekey_policy.selectedIndex == 1)
 {
  if ((document.form1.rekey_time.value <300 ) ||(document.form1.rekey_time.value > 31536000))
  {
   alert("<% multilang("2387" "LANG_KEY_REGOUP_TIME_SHOUD_IN_300_31536000"); %>");
   document.form1.rekey_time.focus();
   return false;
  }
 }
 else if (document.form1.rekey_policy.selectedIndex == 2)
 {
  if (document.form1.rekey_packet.value <= 1048576)
  {
   alert("<% multilang("2388" "LANG_NUMBER_OF_PACKETS_SHOULD_GREAT_THAN_1048576"); %>");
   document.form1.rekey_packet.focus();
   return false;
  }
  if (document.form1.rekey_packet.value > 4294967295)
  {
   alert("<% multilang("2389" "LANG_NUMBER_OF_PACKETS_TOO_BIG"); %>");
   document.form1.rekey_packet.focus();
   return false;
  }
 }
 else if (document.form1.rekey_policy.selectedIndex == 3)
 {
  if ((document.form1.rekey_time.value <300 ) ||(document.form1.rekey_time.value > 31536000))
  {
   alert("<% multilang("2387" "LANG_KEY_REGOUP_TIME_SHOUD_IN_300_31536000"); %>");
   document.form1.rekey_time.focus();
   return false;
  }
  if (document.form1.rekey_packet.value <= 1048576)
  {
   alert("<% multilang("2388" "LANG_NUMBER_OF_PACKETS_SHOULD_GREAT_THAN_1048576"); %>");
   document.form1.rekey_packet.focus();
   return false;
  }
  if (document.form1.rekey_packet.value > 4294967295)
  {
   alert("<% multilang("2389" "LANG_NUMBER_OF_PACKETS_TOO_BIG"); %>");
   document.form1.rekey_packet.focus();
   return false;
  }
 }
 else
  ;
 get_value();
 check_rekey=1;
 form1.submit();
}
</SCRIPT>
<BODY topMargin=0 >
<blockquote>
<h2><font color="#0000FF">Key Update</font></h2>
<form name=form1 method=POST action="/boaform/formWapiReKey">
 <table border="0" cellspacing="4" width="500">
   <tr><td><font size=2>
 This page allows you to configure for multicast key update and unicast key update. Here
 you could turn off key update, or you could choose time-based, packet-based or time-packet-based
 key update.
 </font></td></tr>
   <table border=0 width=500>
   <tr><td><hr size=1 noshade align=top></td></tr>
   </table>
   <table border=0 width=500>
       <tr>
        <td width="30%"><font size=2><font color="#0000FF"><b>Key Re-group</b></font></font></td>
        <td>&nbsp;</td>
       </tr>
    <tr>
    <td width="30%"><font size=2><b>Forced key:</b></font></td>
    <td>
     <select name="f_key" style="border:1px solid #C0C0C0; width:90; height:18" size="1" onChange="key_select(this)" disabled>
                    <option value="0" >OFF</option>
                     <option value="1" >ON</option>
                             </select>
    </td>
    </tr>
    <tr>
    <td width="30%">&nbsp;</td>
    <td>
     <input type="radio" name="KEY_TYPE_CHK" value="V5" checked onclick= "sel_keytype()">Muticast Key&nbsp;
    </td>
    <td>
     <input type="radio" name="KEY_TYPE_CHK" value="V6" onclick= "sel_keytype()">Unicast Key
    </td>
    </tr>
        <tr>
    <td width="30%"><font size=2><b>Mac Address:</b></font></td>
    <td><INPUT name="MAC_INPUT" class="input_txt" id=a4 size=18 maxlength=17 style="ime-mode:Disabled"></td>
        </tr>
   </table>
   <p><p>
   <table border=0 width=500>
    <tr>
          <td width="30%"><font size=2><font color="#0000FF"><b>Re-Key</b></font></font></td>
          <td>&nbsp;</td>
    </tr>
    <tr>
    <td width="30%"><font size=2><b>Muticast Key Update:</b></font></td>
    <td>
     <select name="rekey_m_policy" style="border:1px solid #C0C0C0; width:90; height:18" size="1" onChange="rekey_policy_m_select(this)">
                    <option value="1" >OFF</option>
      <option value="2" >Time</option>
                   <option value="3" >Packets</option>
                    <option value="4" >Time+Packets</option>
                 </select>
    </td>
    </tr>
    <tr>
    <td width="30%"><font size=2><b>Time:</b></font></td>
    <td><INPUT name="rekey_m_time" class="input_txt_disabled" id=a4 size=18 maxlength=17 style="ime-mode:Disabled">&nbsp;s&nbsp;<font size=2 >(300--31536000)</font></td>
    </tr>
    <tr>
    <td width="30%"><font size=2><b>Packets:</b></font></td>
    <td><INPUT name="rekey_m_packet" class="input_txt_disabled" id=a4 size=18 maxlength=10 style="ime-mode:Disabled">&nbsp;byte&nbsp;<font size="2">( >1048576 )</font></td>
    </tr>
    <tr>
    <td width="30%">&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
    <tr>
    <td width="30%"><font size=2><b>Unicast Key Update:</b></font></td>
    <td>
     <select name="rekey_policy" style="border:1px solid #C0C0C0; width:90; height:18" size="1" onChange="rekey_policy_select(this)">
                    <option value="1" >OFF</option>
      <option value="2" >Time</option>
                   <option value="3" >Packets</option>
                    <option value="4" >Time+Packets</option>
                 </select>
     </td>
    </tr>
    <tr>
    <td width="30%"><font size=2><b>Time:</b></font></td>
    <td><INPUT name="rekey_time" class="input_txt_disabled" id=a4 size=18 maxlength=17 style="ime-mode:Disabled">&nbsp;s&nbsp;<font size="2">(300--31536000)</font></td>
    </tr>
    <tr>
    <td width="30%"><font size=2><b>Packets:</b></font></td>
    <td><INPUT name="rekey_packet" class="input_txt_disabled" id=a4 size=18 maxlength=10 style="ime-mode:Disabled">&nbsp;byte&nbsp;<font size="2">(&nbsp;>1048576&nbsp;)</font></td>
    </tr>
    <tr>
    <td width="30%">&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
 </table>
 <table border=0 width=100>
   <tr>
    <td><input type="button" id="b4" name="save" onClick="return submit_check()" onFocus="this.blur()" value="Apply Changes"></td>
        <td><input type="reset" value=" Reset " name="reset"></td>
       </tr>
   </table>
  <input type="hidden" name="F_KEY" value="0">
 <input type="hidden" name="KEY_TYPE" value="${KEY_TPYE}">
 <input type="hidden" name="MAC" value="">
 <input type="hidden" name="REKEY_POLICY" value=<% getInfo("wapiUcastReKeyType"); %>>
 <input type="hidden" name="REKEY_TIME" value=<% getInfo("wapiUcastTime"); %>>
 <input type="hidden" name="REKEY_PACKET" value=<% getInfo("wapiUcastPackets"); %>>
 <input type="hidden" name="REKEY_M_POLICY" value=<% getInfo("wapiMcastReKeyType"); %>>
 <input type="hidden" name="REKEY_M_TIME" value=<% getInfo("wapiMcastTime"); %>>
 <input type="hidden" name="REKEY_M_PACKET" value=<% getInfo("wapiMcastPackets"); %>>
 <input type="hidden" name="submit-url" value="/wlwapiRekey.asp">
 <input type="hidden" name="wlan_idx" value=<% checkWrite("wlan_idx"); %>>
</form>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="36">
  <tr>
  </tr>
</table>
<SCRIPT language=JavaScript>
</script>
<SCRIPT language=JavaScript>
function init()
{
 //document.form1.KEY_TYPE_CHK[parseInt_dec(document.form1.KEY_TYPE.value)].checked=true;
 document.form1.f_key.selectedIndex = document.form1.F_KEY.value;
 key_select(document.form1.f_key);
 document.form1.rekey_m_policy.selectedIndex = document.form1.REKEY_M_POLICY.value-1;
 document.form1.rekey_policy.selectedIndex = document.form1.REKEY_POLICY.value-1;
 rekey_policy_select(document.form1.rekey_policy);
 rekey_policy_m_select(document.form1.rekey_m_policy);
 if(document.form1.rekey_m_policy.selectedIndex == 1)
 {
  document.form1.rekey_m_time.value = document.form1.REKEY_M_TIME.value;
 }
 else if(document.form1.rekey_m_policy.selectedIndex == 2)
 {
  document.form1.rekey_m_packet.value = document.form1.REKEY_M_PACKET.value;
 }
 else if(document.form1.rekey_m_policy.selectedIndex == 3)
 {
  document.form1.rekey_m_time.value = document.form1.REKEY_M_TIME.value;
  document.form1.rekey_m_packet.value = document.form1.REKEY_M_PACKET.value;
 }
 if(document.form1.rekey_policy.selectedIndex == 1)
 {
  document.form1.rekey_time.value = document.form1.REKEY_TIME.value;
 }
 else if(document.form1.rekey_policy.selectedIndex == 2)
 {
  document.form1.rekey_packet.value = document.form1.REKEY_PACKET.value;
 }
 else if(document.form1.rekey_policy.selectedIndex == 3)
 {
  document.form1.rekey_time.value = document.form1.REKEY_TIME.value;
  document.form1.rekey_packet.value = document.form1.REKEY_PACKET.value;
 }
}
init();
</script>
</blockquote>
</BODY>
</HTML>

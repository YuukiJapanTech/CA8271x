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
<title>VTU-O Settings</title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
/*
function line_onchange()
{
	document.set_vtuo_line.DSMaxSNR.disabled=document.set_vtuo_line.DSMaxSNRNoLmt.checked;
	document.set_vtuo_line.USMaxSNR.disabled=document.set_vtuo_line.USMaxSNRNoLmt.checked;
	document.set_vtuo_line.USMaxRxPwr.disabled=document.set_vtuo_line.USMaxRxPwrNoLmt.checked;
}
*/
function line_saveChanges()
{
 return true;
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF">VTU-O Settings</font></h2>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr><td><font size=2>
 This page is used to configure the parameters for VTU-O.
 </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_line>
<!--<h4>1. Line Profile Setup</h4>-->
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr>
  <td width=50% align=left><h4>* Line Profile Setup</h4></td>
  <td width=25% align=right><h5><a href="/admin/vtuo-set-chan.asp"><i>Channel Profile</i><a></h5></td>
  <td width=25% align=right><h5><a href="/admin/vtuo-set-inm.asp"><i>INM Profile</i></a></h5></td>
 </tr>
</table>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>VDSL2 Profile</th>
  <td colspan=2>
   <input type=checkbox name=Vd2Prof30a>30a&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof17a>17a&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof12a>12a&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof12b>12b&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof8a>8a&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof8b>8b&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof8c>8c&nbsp;&nbsp;
   <input type=checkbox name=Vd2Prof8d>8d
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>ADSL Protocol</th>
  <td colspan=2>
   <input type=checkbox name=AdProtG9921>G.992.1
   <input type=checkbox name=AdProtG9922>G.992.2
   <input type=checkbox name=AdProtG9923>G.992.3
   <input type=checkbox name=AdProtG9925>G.992.5
   <input type=checkbox name=AdProtANSI>ANSI T1.413
   <br>
   <input type=checkbox name=AdProtETSI>ETSI TS101 388
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0></th>
  <th align=center bgcolor=#c0c0c0>Downstream</th>
  <th align=center bgcolor=#c0c0c0>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Max SNR Margin</th>
  <td>
   <input type="text" name="DSMaxSNR" size="8" maxlength="8" value="">dB
<!--
   <input type=checkbox name=DSMaxSNRNoLmt onClick="line_onchange()">No Limit
-->
  </td>
  <td>
   <input type="text" name="USMaxSNR" size="8" maxlength="8" value="">dB
<!--
   <input type=checkbox name=USMaxSNRNoLmt onClick="line_onchange()">No Limit
-->
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Target SNR Margin</th>
  <td>
   <input type="text" name="DSTargetSNR" size="8" maxlength="8" value="">dB
  </td>
  <td>
   <input type="text" name="USTargetSNR" size="8" maxlength="8" value="">dB
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min SNR Margin</th>
  <td>
   <input type="text" name="DSMinSNR" size="8" maxlength="8" value="">dB
  </td>
  <td>
   <input type="text" name="USMinSNR" size="8" maxlength="8" value="">dB
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>OLR</th>
  <td>
   <input type="radio" name="DSBitswap" value=0 >Off&nbsp;&nbsp;
   <input type="radio" name="DSBitswap" value=1 >On&nbsp;&nbsp;
  </td>
  <td>
   <input type="radio" name="USBitswap" value=0 >Off&nbsp;&nbsp;
   <input type="radio" name="USBitswap" value=1 >On&nbsp;&nbsp;
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0>
   <font size=2>OLR Option&nbsp;&nbsp;
   <a href="/admin/vtuo-set-sra.asp"><i>[ Edit ]</i>&nbsp;</a>
  </th>
  <td id="LineSRAModeDs" >
  </td>
  <td id="LineSRAModeUs" >
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>PSD Control</th>
  <th align=center bgcolor=#c0c0c0>Downstream</th>
  <th align=center bgcolor=#c0c0c0>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0>
   <font size=2>MIB PSD Mask&nbsp;&nbsp;
   <a href="/admin/vtuo-set-psd.asp"><i>[ Edit ]</i>&nbsp;</a>
  </th>
  <td id="LineMibPsdDs" >
  </td>
  <td id="LineMibPsdUs" >
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>US0</th>
  <td></td>
  <td>
   <input type="radio" name="US0" value=0 >Disable&nbsp;&nbsp;
   <input type="radio" name="US0" value=1 >Allow&nbsp;&nbsp;
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>US0 Mask</th>
  <td></td>
  <td>
   <select size=1 name="US0Mask">
    <option value=0>EU-32</option>
    <option value=1>EU-36</option>
    <option value=2>EU-40</option>
    <option value=3>EU-44</option>
    <option value=4>EU-48</option>
    <option value=5>EU-52</option>
    <option value=6>EU-56</option>
    <option value=7>EU-60</option>
    <option value=8>EU-64</option>
    <option value=9>EU-128</option>
   </select>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>UPBO</th>
  <td></td>
  <td>
   <table border=0 cellspacing=4 cellpadding=0>
   <tr bgcolor=#f0f0f0>
    <td width=33%>
     <input type="radio" name="UPBO" value=0 >Disable
    </td>
    <td width=33%>
     <input type="radio" name="UPBO" value=1 >Auto
    </td>
    <td>
     <input type="radio" name="UPBO" value=2 >Override
    </td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td>UPBOKL</td>
    <td colspan=2>
     <input type="text" name="UPBOKL" size="8" maxlength="8" value="">dB
    </td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td></td>
    <td align=center>A</td>
    <td align=center>B</td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td>US Band 1</td>
    <td><input type="text" name="USBand1a" size="8" maxlength="8" value=""></td>
    <td><input type="text" name="USBand1b" size="8" maxlength="8" value=""></td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td>US Band 2</td>
    <td><input type="text" name="USBand2a" size="8" maxlength="8" value=""></td>
    <td><input type="text" name="USBand2b" size="8" maxlength="8" value=""></td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td>US Band 3</td>
    <td><input type="text" name="USBand3a" size="8" maxlength="8" value=""></td>
    <td><input type="text" name="USBand3b" size="8" maxlength="8" value=""></td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td>US Band 4</td>
    <td><input type="text" name="USBand4a" size="8" maxlength="8" value=""></td>
    <td><input type="text" name="USBand4b" size="8" maxlength="8" value=""></td>
   </tr>
   </table>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DS1 Mask</th>
  <td>
   <select size=1 name="LimitMask">
    <option value=0>D-32</option>
    <option value=1>D-48</option>
    <option value=2>D-64</option>
    <option value=3>D-128</option>
   </select>
  </td>
  <td></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0>
   <font size=2>DPBO&nbsp;&nbsp;
   <a href="/admin/vtuo-set-dpbo.asp"><i>[ Edit ]</i>&nbsp;</a>
  </th>
  <td id="LineDpboEnable" >
  </td>
  <td></td>
 </tr>
<!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Max Rx Power</th>
  <td></td>
  <td>
   <input type="text" name="USMaxRxPwr" size="8" maxlength="8" value="">dBm
   <input type=checkbox name=USMaxRxPwrNoLmt onClick="line_onchange()">No Limit
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Max Tx Power</th>
  <td>
   <input type="text" name="DSMaxTxPwr" size="8" maxlength="8" value="">dBm
  </td>
  <td>
   <input type="text" name="USMaxTxPwr" size="8" maxlength="8" value="">dBm
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min Overhead Rate</th>
  <td>
   <input type="text" name="DSMinOhRate" size="8" maxlength="8" value="">kbps
  </td>
  <td>
   <input type="text" name="USMinOhRate" size="8" maxlength="8" value="">kbps
  </td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Limit PSD Mask</th>
  <td colspan=2>
   <table border=0 cellspacing=4 cellpadding=0>
   <tr bgcolor=#f0f0f0>
    <td>Transmission Mode</td>
    <td>
     <select size=1 name="TransMode">
      <option value=0>G.993.2 Annex A</option>
     </select>
    </td>
   </tr>
   <tr bgcolor=#f0f0f0>
    <td>Class Mask</td>
    <td>
     <select size=1 name="ClassMask">
      <option value=0>998</option>
      <option value=1>997</option>
     </select>
    </td>
   </tr>
   </table>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Retrain Mode</th>
  <td colspan=2>
   <input type=checkbox name=RTMode>Auto
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0>
   <font size=2>Virtual Noise&nbsp;&nbsp;
   <a href="/admin/vtuo-set-vn.asp"><i>[ Edit ]</i>&nbsp;</a>
  </th>
  <td id="LineVNDs" >
  </td>
  <td id="LineVNUs" >
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0>
   <font size=2>RFI Band&nbsp;&nbsp;
   <a href="/admin/vtuo-set-rfi.asp"><i>[ Edit ]</i>&nbsp;</a>
  </th>
  <td colspan=2 id="LineRfi" >
  </td>
 </tr>
-->
</table>
<br>
<input type=submit value="Apply Changes" name="LineProfile" onClick="return line_saveChanges()">
<input type=hidden value="/admin/vtuo-set.asp" name="submit-url">
<% vtuo_checkWrite("line-init"); %>
<!--
<script>
line_onchange();
</script>
-->
</form>
<br><br>
</blockquote>
</body>
</html>

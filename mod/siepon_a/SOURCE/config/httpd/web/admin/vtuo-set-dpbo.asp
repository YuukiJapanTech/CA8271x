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
function dpbo_saveChanges()
{
}
function dpbo_load_clear()
{
 document.set_vtuo_dpbo.DpboToneId1.value='0';
 document.set_vtuo_dpbo.DpboPsd1.value='0.0';
 document.set_vtuo_dpbo.DpboToneId2.value='0';
 document.set_vtuo_dpbo.DpboPsd2.value='0.0';
 document.set_vtuo_dpbo.DpboToneId3.value='0';
 document.set_vtuo_dpbo.DpboPsd3.value='0.0';
 document.set_vtuo_dpbo.DpboToneId4.value='0';
 document.set_vtuo_dpbo.DpboPsd4.value='0.0';
 document.set_vtuo_dpbo.DpboToneId5.value='0';
 document.set_vtuo_dpbo.DpboPsd5.value='0.0';
 document.set_vtuo_dpbo.DpboToneId6.value='0';
 document.set_vtuo_dpbo.DpboPsd6.value='0.0';
 document.set_vtuo_dpbo.DpboToneId7.value='0';
 document.set_vtuo_dpbo.DpboPsd7.value='0.0';
 document.set_vtuo_dpbo.DpboToneId8.value='0';
 document.set_vtuo_dpbo.DpboPsd8.value='0.0';
 document.set_vtuo_dpbo.DpboToneId9.value='0';
 document.set_vtuo_dpbo.DpboPsd9.value='0.0';
 document.set_vtuo_dpbo.DpboToneId10.value='0';
 document.set_vtuo_dpbo.DpboPsd10.value='0.0';
 document.set_vtuo_dpbo.DpboToneId11.value='0';
 document.set_vtuo_dpbo.DpboPsd11.value='0.0';
 document.set_vtuo_dpbo.DpboToneId12.value='0';
 document.set_vtuo_dpbo.DpboPsd12.value='0.0';
 document.set_vtuo_dpbo.DpboToneId13.value='0';
 document.set_vtuo_dpbo.DpboPsd13.value='0.0';
 document.set_vtuo_dpbo.DpboToneId14.value='0';
 document.set_vtuo_dpbo.DpboPsd14.value='0.0';
 document.set_vtuo_dpbo.DpboToneId15.value='0';
 document.set_vtuo_dpbo.DpboPsd15.value='0.0';
 document.set_vtuo_dpbo.DpboToneId16.value='0';
 document.set_vtuo_dpbo.DpboPsd16.value='0.0';
}
function dpbo_load_cabansi()
{
 document.set_vtuo_dpbo.DpboToneId1.value='1';
 document.set_vtuo_dpbo.DpboPsd1.value='-60.0';
 document.set_vtuo_dpbo.DpboToneId2.value='255';
 document.set_vtuo_dpbo.DpboPsd2.value='-60.0';
 document.set_vtuo_dpbo.DpboToneId3.value='376';
 document.set_vtuo_dpbo.DpboPsd3.value='-50.0';
 document.set_vtuo_dpbo.DpboToneId4.value='511';
 document.set_vtuo_dpbo.DpboPsd4.value='-51.5';
}
function dpbo_load_cabetsi()
{
 document.set_vtuo_dpbo.DpboToneId1.value='1';
 document.set_vtuo_dpbo.DpboPsd1.value='-60.0';
 document.set_vtuo_dpbo.DpboToneId2.value='255';
 document.set_vtuo_dpbo.DpboPsd2.value='-60.0';
 document.set_vtuo_dpbo.DpboToneId3.value='323';
 document.set_vtuo_dpbo.DpboPsd3.value='-51.5';
 document.set_vtuo_dpbo.DpboToneId4.value='511';
 document.set_vtuo_dpbo.DpboPsd4.value='-53.0';
}
function dpbo_load_exansi()
{
 document.set_vtuo_dpbo.DpboToneId1.value='1';
 document.set_vtuo_dpbo.DpboPsd1.value='-40.0';
 document.set_vtuo_dpbo.DpboToneId2.value='255';
 document.set_vtuo_dpbo.DpboPsd2.value='-40.0';
 document.set_vtuo_dpbo.DpboToneId3.value='376';
 document.set_vtuo_dpbo.DpboPsd3.value='-42.0';
 document.set_vtuo_dpbo.DpboToneId4.value='511';
 document.set_vtuo_dpbo.DpboPsd4.value='-42.0';
}
function dpbo_load_exetsi()
{
 document.set_vtuo_dpbo.DpboToneId1.value='1';
 document.set_vtuo_dpbo.DpboPsd1.value='-40.0';
 document.set_vtuo_dpbo.DpboToneId2.value='255';
 document.set_vtuo_dpbo.DpboPsd2.value='-40.0';
 document.set_vtuo_dpbo.DpboToneId3.value='388';
 document.set_vtuo_dpbo.DpboPsd3.value='-61.0';
 document.set_vtuo_dpbo.DpboToneId4.value='511';
 document.set_vtuo_dpbo.DpboPsd4.value='-61.0';
}
function dpbo_load_copsd()
{
 document.set_vtuo_dpbo.DpboToneId1.value='1';
 document.set_vtuo_dpbo.DpboPsd1.value='-40.0';
 document.set_vtuo_dpbo.DpboToneId2.value='255';
 document.set_vtuo_dpbo.DpboPsd2.value='-40.0';
 document.set_vtuo_dpbo.DpboToneId3.value='376';
 document.set_vtuo_dpbo.DpboPsd3.value='-50.0';
 document.set_vtuo_dpbo.DpboToneId4.value='511';
 document.set_vtuo_dpbo.DpboPsd4.value='-51.5';
}
function dpbo_load_flatpsd()
{
 document.set_vtuo_dpbo.DpboToneId1.value='1';
 document.set_vtuo_dpbo.DpboPsd1.value='-60.0';
 document.set_vtuo_dpbo.DpboToneId2.value='511';
 document.set_vtuo_dpbo.DpboPsd2.value='-60.0';
}
function dpbo_load_mib()
{
<% vtuo_checkWrite("dpbo-init-tbl"); %>
}
/*
function dpbo_freq( id )
{
	var frequnit=43125;
	var new_freq, new_freq1,new_freq2;
	var str_freq;

	new_freq = frequnit*id;
	new_freq2 = new_freq % 10000;
	new_freq1 = (new_freq-new_freq2) / 10000;
	if(new_freq2==0)
		str_freq = new_freq1.toString() + '.0000';
	else if(new_freq2<10)
		str_freq = new_freq1.toString() + '.000' + new_freq2.toString();
	else if(new_freq2<100)
		str_freq = new_freq1.toString() + '.00' + new_freq2.toString();
	else if(new_freq2<1000)
		str_freq = new_freq1.toString() + '.0' + new_freq2.toString();
	else
		str_freq = new_freq1.toString() + '.' + new_freq2.toString();
	
	return str_freq;
}
function dpbo_update_freq()
{
document.set_vtuo_dpbo.DpboFreq1.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId1.value);
document.set_vtuo_dpbo.DpboFreq2.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId2.value);
document.set_vtuo_dpbo.DpboFreq3.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId3.value);
document.set_vtuo_dpbo.DpboFreq4.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId4.value);
document.set_vtuo_dpbo.DpboFreq5.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId5.value);
document.set_vtuo_dpbo.DpboFreq6.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId6.value);
document.set_vtuo_dpbo.DpboFreq7.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId7.value);
document.set_vtuo_dpbo.DpboFreq8.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId8.value);
document.set_vtuo_dpbo.DpboFreq9.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId9.value);
document.set_vtuo_dpbo.DpboFreq10.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId10.value);
document.set_vtuo_dpbo.DpboFreq11.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId11.value);
document.set_vtuo_dpbo.DpboFreq12.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId12.value);
document.set_vtuo_dpbo.DpboFreq13.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId13.value);
document.set_vtuo_dpbo.DpboFreq14.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId14.value);
document.set_vtuo_dpbo.DpboFreq15.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId15.value);
document.set_vtuo_dpbo.DpboFreq16.value=dpbo_freq(document.set_vtuo_dpbo.DpboToneId16.value);
}
*/
var dpbo_load = 0;
function dpbo_init()
{
<% vtuo_checkWrite("dpbo-init"); %>
 dpbo_load_clear();
 if(dpbo_load==1)
  dpbo_load_cabansi();
 else if(dpbo_load==2)
  dpbo_load_cabetsi();
 else if(dpbo_load==3)
  dpbo_load_exansi();
 else if(dpbo_load==4)
  dpbo_load_exetsi();
 else if(dpbo_load==5)
  dpbo_load_copsd();
 else if(dpbo_load==6)
  dpbo_load_flatpsd();
 else
  dpbo_load_mib();
 /*
	dpbo_update_freq();
	*/
}
function dpbo_init_all( id )
{
 dpbo_load=id;
 dpbo_init();
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
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_dpbo>
<h4>* Line Profile &nbsp;&gt;&nbsp; DPBO Setup</h4>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBO</th>
  <td>
   <input type="radio" name="DpboEnable" value=0 >Disable&nbsp;&nbsp;
   <input type="radio" name="DpboEnable" value=1 >Enable&nbsp;&nbsp;
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOESEL</th>
  <td>
   <input type="text" name="DpboESel" size="8" maxlength="8" value="">dB
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOESCMA</th>
  <td>
   <input type="text" name="DpboEScma" size="12" maxlength="12" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOESCMB</th>
  <td>
   <input type="text" name="DpboEScmb" size="12" maxlength="12" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOESCMC</th>
  <td>
   <input type="text" name="DpboEScmc" size="12" maxlength="12" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOMUS</th>
  <td>
   <input type="text" name="DpboMus" size="8" maxlength="8" value="">dB
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOFMIN</th>
  <td>
   <input type="text" name="DpboFMin" size="8" maxlength="8" value="">(unit: 4.3125kHz)
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>DPBOFMAX</th>
  <td>
   <input type="text" name="DpboFMax" size="8" maxlength="8" value="">(unit: 4.3125kHz)
  </td>
 </tr>
</table>
<br>
<input type=button value="CAB_ANSI" name="DpboLoadCabAnsi" onClick="dpbo_init_all(1);">
<input type=button value="CAB_ETSI" name="DpboLoadCabEtsi" onClick="dpbo_init_all(2);">
<input type=button value="EX_ANSI" name="DpboLoadExAnsi" onClick="dpbo_init_all(3);">
<input type=button value="EX_ETSI" name="DpboLoadExEtsi" onClick="dpbo_init_all(4);">
<input type=button value="CO_PSD" name="DpboLoadCoPsd" onClick="dpbo_init_all(5);">
<input type=button value="Flat_PSD" name="DpboLoadFlatPsd" onClick="dpbo_init_all(6);">
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0>Break<br>Point</th>
  <th align=center bgcolor=#c0c0c0>Tone<br>(Unit: 4.3125 kHz)</th>
  <th align=center bgcolor=#c0c0c0>PSD Level<br>(dBm/Hz)</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>1</th>
  <td>
   <input type="text" name="DpboToneId1" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq1" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd1" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>2</th>
  <td>
   <input type="text" name="DpboToneId2" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq2" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd2" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>3</th>
  <td>
   <input type="text" name="DpboToneId3" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq3" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd3" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>4</th>
  <td>
   <input type="text" name="DpboToneId4" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq4" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd4" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>5</th>
  <td>
   <input type="text" name="DpboToneId5" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq5" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd5" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>6</th>
  <td>
   <input type="text" name="DpboToneId6" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq6" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd6" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>7</th>
  <td>
   <input type="text" name="DpboToneId7" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq7" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd7" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>8</th>
  <td>
   <input type="text" name="DpboToneId8" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq8" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd8" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>9</th>
  <td>
   <input type="text" name="DpboToneId9" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq9" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd9" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>10</th>
  <td>
   <input type="text" name="DpboToneId10" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq10" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd10" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>11</th>
  <td>
   <input type="text" name="DpboToneId11" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq11" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd11" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>12</th>
  <td>
   <input type="text" name="DpboToneId12" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq12" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd12" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>13</th>
  <td>
   <input type="text" name="DpboToneId13" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq13" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd13" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>14</th>
  <td>
   <input type="text" name="DpboToneId14" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq14" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd14" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>15</th>
  <td>
   <input type="text" name="DpboToneId15" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq15" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd15" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>16</th>
  <td>
   <input type="text" name="DpboToneId16" size="8" maxlength="8" value="">
  </td>
 <!--
  <td>
   <input type="text" name="DpboFreq16" size="16" maxlength="16" value="" disabled>
  </td>
 -->
  <td>
   <input type="text" name="DpboPsd16" size="8" maxlength="8" value="">
  </td>
 </tr>
</table>
<br>
<input type=submit value="Apply Changes" name="DpboSetup" onClick="return dpbo_saveChanges()">
&nbsp;&nbsp;&nbsp;
<input type=button value="Back" onclick="location.assign('/admin/vtuo-set.asp')">
<input type=hidden value="/admin/vtuo-set-dpbo.asp" name="submit-url">
<SCRIPT>
dpbo_init_all(0);
</SCRIPT>
</form>
<br>
<br>
</blockquote>
</body>
</html>

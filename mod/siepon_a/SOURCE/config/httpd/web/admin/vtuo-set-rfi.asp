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
function rfi_saveChanges()
{
}
function rfi_load_clear()
{
 document.set_vtuo_rfi.ToneId1.value='0';
 document.set_vtuo_rfi.ToneId2.value='0';
 document.set_vtuo_rfi.ToneId3.value='0';
 document.set_vtuo_rfi.ToneId4.value='0';
 document.set_vtuo_rfi.ToneId5.value='0';
 document.set_vtuo_rfi.ToneId6.value='0';
 document.set_vtuo_rfi.ToneId7.value='0';
 document.set_vtuo_rfi.ToneId8.value='0';
 document.set_vtuo_rfi.ToneId9.value='0';
 document.set_vtuo_rfi.ToneId10.value='0';
 document.set_vtuo_rfi.ToneId11.value='0';
 document.set_vtuo_rfi.ToneId12.value='0';
 document.set_vtuo_rfi.ToneId13.value='0';
 document.set_vtuo_rfi.ToneId14.value='0';
 document.set_vtuo_rfi.ToneId15.value='0';
 document.set_vtuo_rfi.ToneId16.value='0';
 document.set_vtuo_rfi.ToneIdEnd1.value='0';
 document.set_vtuo_rfi.ToneIdEnd2.value='0';
 document.set_vtuo_rfi.ToneIdEnd3.value='0';
 document.set_vtuo_rfi.ToneIdEnd4.value='0';
 document.set_vtuo_rfi.ToneIdEnd5.value='0';
 document.set_vtuo_rfi.ToneIdEnd6.value='0';
 document.set_vtuo_rfi.ToneIdEnd7.value='0';
 document.set_vtuo_rfi.ToneIdEnd8.value='0';
 document.set_vtuo_rfi.ToneIdEnd9.value='0';
 document.set_vtuo_rfi.ToneIdEnd10.value='0';
 document.set_vtuo_rfi.ToneIdEnd11.value='0';
 document.set_vtuo_rfi.ToneIdEnd12.value='0';
 document.set_vtuo_rfi.ToneIdEnd13.value='0';
 document.set_vtuo_rfi.ToneIdEnd14.value='0';
 document.set_vtuo_rfi.ToneIdEnd15.value='0';
 document.set_vtuo_rfi.ToneIdEnd16.value='0';
}
function rfi_load_mib()
{
<% vtuo_checkWrite("rfi-init-tbl"); %>
}
function rfi_freq( id )
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
function rfi_update_freq()
{
document.set_vtuo_rfi.Freq1.value=rfi_freq(document.set_vtuo_rfi.ToneId1.value);
document.set_vtuo_rfi.Freq2.value=rfi_freq(document.set_vtuo_rfi.ToneId2.value);
document.set_vtuo_rfi.Freq3.value=rfi_freq(document.set_vtuo_rfi.ToneId3.value);
document.set_vtuo_rfi.Freq4.value=rfi_freq(document.set_vtuo_rfi.ToneId4.value);
document.set_vtuo_rfi.Freq5.value=rfi_freq(document.set_vtuo_rfi.ToneId5.value);
document.set_vtuo_rfi.Freq6.value=rfi_freq(document.set_vtuo_rfi.ToneId6.value);
document.set_vtuo_rfi.Freq7.value=rfi_freq(document.set_vtuo_rfi.ToneId7.value);
document.set_vtuo_rfi.Freq8.value=rfi_freq(document.set_vtuo_rfi.ToneId8.value);
document.set_vtuo_rfi.Freq9.value=rfi_freq(document.set_vtuo_rfi.ToneId9.value);
document.set_vtuo_rfi.Freq10.value=rfi_freq(document.set_vtuo_rfi.ToneId10.value);
document.set_vtuo_rfi.Freq11.value=rfi_freq(document.set_vtuo_rfi.ToneId11.value);
document.set_vtuo_rfi.Freq12.value=rfi_freq(document.set_vtuo_rfi.ToneId12.value);
document.set_vtuo_rfi.Freq13.value=rfi_freq(document.set_vtuo_rfi.ToneId13.value);
document.set_vtuo_rfi.Freq14.value=rfi_freq(document.set_vtuo_rfi.ToneId14.value);
document.set_vtuo_rfi.Freq15.value=rfi_freq(document.set_vtuo_rfi.ToneId15.value);
document.set_vtuo_rfi.Freq16.value=rfi_freq(document.set_vtuo_rfi.ToneId16.value);
document.set_vtuo_rfi.FreqEnd1.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd1.value);
document.set_vtuo_rfi.FreqEnd2.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd2.value);
document.set_vtuo_rfi.FreqEnd3.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd3.value);
document.set_vtuo_rfi.FreqEnd4.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd4.value);
document.set_vtuo_rfi.FreqEnd5.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd5.value);
document.set_vtuo_rfi.FreqEnd6.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd6.value);
document.set_vtuo_rfi.FreqEnd7.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd7.value);
document.set_vtuo_rfi.FreqEnd8.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd8.value);
document.set_vtuo_rfi.FreqEnd9.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd9.value);
document.set_vtuo_rfi.FreqEnd10.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd10.value);
document.set_vtuo_rfi.FreqEnd11.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd11.value);
document.set_vtuo_rfi.FreqEnd12.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd12.value);
document.set_vtuo_rfi.FreqEnd13.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd13.value);
document.set_vtuo_rfi.FreqEnd14.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd14.value);
document.set_vtuo_rfi.FreqEnd15.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd15.value);
document.set_vtuo_rfi.FreqEnd16.value=rfi_freq(document.set_vtuo_rfi.ToneIdEnd16.value);
}
function rfi_init()
{
 rfi_load_clear();
 rfi_load_mib();
 rfi_update_freq();
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
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_rfi>
<h4>* Line Profile &nbsp;&gt;&nbsp; RFI Setup</h4>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
   <th bgcolor=#c0c0c0></th>
   <th colspan=2 align=center bgcolor=#c0c0c0>Start</th>
  <th colspan=2 align=center bgcolor=#c0c0c0>Stop</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0>Band</th>
  <th align=center bgcolor=#c0c0c0>Tone Index</th>
  <th align=center bgcolor=#c0c0c0>Frequency<br>(kHz)</th>
  <th align=center bgcolor=#c0c0c0>Tone Index</th>
  <th align=center bgcolor=#c0c0c0>Frequency<br>(kHz)</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>1</th>
  <td>
   <input type="text" name="ToneId1" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq1" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd1" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd1" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>2</th>
  <td>
   <input type="text" name="ToneId2" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq2" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd2" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd2" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>3</th>
  <td>
   <input type="text" name="ToneId3" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq3" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd3" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd3" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>4</th>
  <td>
   <input type="text" name="ToneId4" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq4" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd4" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd4" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>5</th>
  <td>
   <input type="text" name="ToneId5" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq5" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd5" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd5" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>6</th>
  <td>
   <input type="text" name="ToneId6" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq6" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd6" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd6" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>7</th>
  <td>
   <input type="text" name="ToneId7" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq7" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd7" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd7" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>8</th>
  <td>
   <input type="text" name="ToneId8" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq8" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd8" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd8" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>9</th>
  <td>
   <input type="text" name="ToneId9" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq9" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd9" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd9" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>10</th>
  <td>
   <input type="text" name="ToneId10" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq10" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd10" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd10" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>11</th>
  <td>
   <input type="text" name="ToneId11" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq11" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd11" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd11" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>12</th>
  <td>
   <input type="text" name="ToneId12" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq12" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd12" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd12" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>13</th>
  <td>
   <input type="text" name="ToneId13" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq13" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd13" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd13" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>14</th>
  <td>
   <input type="text" name="ToneId14" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq14" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd14" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd14" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>15</th>
  <td>
   <input type="text" name="ToneId15" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq15" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd15" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd15" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=center bgcolor=#c0c0c0><font size=2>16</th>
  <td>
   <input type="text" name="ToneId16" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="Freq16" size="16" maxlength="16" value="" disabled>
  </td>
  <td>
   <input type="text" name="ToneIdEnd16" size="8" maxlength="8" value="" onchange="rfi_update_freq()">
  </td>
  <td>
   <input type="text" name="FreqEnd16" size="16" maxlength="16" value="" disabled>
  </td>
 </tr>
</table>
<br>
<input type=submit value="Apply Changes" name="RfiSetup" onClick="return rfi_saveChanges()">
&nbsp;&nbsp;&nbsp;
<input type=button value="Back" onclick="location.assign('/admin/vtuo-set.asp')">
<input type=hidden value="/admin/vtuo-set-rfi.asp" name="submit-url">
<SCRIPT>
rfi_init();
</SCRIPT>
</form>
<br>
<br>
</blockquote>
</body>
</html>

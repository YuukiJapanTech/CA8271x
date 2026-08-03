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
function sra_saveChanges()
{
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
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_sra>
<h4>* Line Profile &nbsp;&gt;&nbsp; OLR Option Setup</h4>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0></th>
  <th align=center bgcolor=#c0c0c0>Downstream</th>
  <th align=center bgcolor=#c0c0c0>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Rate Adaptive</th>
  <td>
   <input type="radio" name="DSRateAdapt" value=0 >Manual&nbsp;&nbsp;
   <input type="radio" name="DSRateAdapt" value=1 >AdaptInit&nbsp;&nbsp;
   <input type="radio" name="DSRateAdapt" value=2 >Dynamic&nbsp;&nbsp;
   <input type="radio" name="DSRateAdapt" value=3 >SOS&nbsp;&nbsp;
  </td>
  <td>
   <input type="radio" name="USRateAdapt" value=0 >Manual&nbsp;&nbsp;
   <input type="radio" name="USRateAdapt" value=1 >AdaptInit&nbsp;&nbsp;
   <input type="radio" name="USRateAdapt" value=2 >Dynamic&nbsp;&nbsp;
   <input type="radio" name="USRateAdapt" value=3 >SOS&nbsp;&nbsp;
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Dynamic Depth</th>
  <td>
   <input type="radio" name="DSDynDep" value=0 >Disable&nbsp;&nbsp;
   <input type="radio" name="DSDynDep" value=1 >Enable&nbsp;&nbsp;
  </td>
  <td>
   <input type="radio" name="USDynDep" value=0 >Disable&nbsp;&nbsp;
   <input type="radio" name="USDynDep" value=1 >Enable&nbsp;&nbsp;
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>RA_USNRM (dB)</th>
  <td><input type="text" name="DSUpShiftSNR" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USUpShiftSNR" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>RA_UTIME (sec)</th>
  <td><input type="text" name="DSUpShiftTime" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USUpShiftTime" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>RA_DSNRM (dB)</th>
  <td><input type="text" name="DSDownShiftSNR" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USDownShiftSNR" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>RA_DTIME (sec)</th>
  <td><input type="text" name="DSDownShiftTime" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USDownShiftTime" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SOS-TIME (ms)</th>
  <td><input type="text" name="DSSosTime" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USSosTime" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SOS-CRC</th>
  <td><input type="text" name="DSSosCrc" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USSosCrc" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SOS-NTONES (%)</th>
  <td><input type="text" name="DSSosnTones" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USSosnTones" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>MAX-SOS</th>
  <td><input type="text" name="DSSosMax" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USSosMax" size="8" maxlength="8" value=""></td>
 </tr>
 <!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SOS Multi-Step Tones</th>
  <td>
   <select size=1 name="DSSosMultiStep" disabled>
    <option value=0>all</option>
   </select>
   tones
  </td>
  <td>
   <select size=1 name="USSosMultiStep" disabled>
    <option value=0>all</option>
   </select>
   tones
  </td>
 </tr>
 -->
 <tr bgcolor=#f0f0f0>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>ROC Enable</th>
  <td>
   <input type="radio" name="DSRocEnable" value=0 >Disable&nbsp;&nbsp;
   <input type="radio" name="DSRocEnable" value=1 >Enable&nbsp;&nbsp;
  </td>
  <td>
   <input type="radio" name="USRocEnable" value=0 >Disable&nbsp;&nbsp;
   <input type="radio" name="USRocEnable" value=1 >Enable&nbsp;&nbsp;
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SNRMOFFSET-ROC (dB)</th>
  <td><input type="text" name="DSRocSNR" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USRocSNR" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>INPMIN-ROC (dB)</th>
  <td>
   <select size=1 name="DSRocMinINP">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6>6</option>
    <option value=7>7</option>
    <option value=8>8</option>
    <option value=9>9</option>
    <option value=10>10</option>
    <option value=11>11</option>
    <option value=12>12</option>
    <option value=13>13</option>
    <option value=14>14</option>
    <option value=15>15</option>
    <option value=16>16</option>
   </select>
  </td>
  <td>
   <select size=1 name="USRocMinINP">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6>6</option>
    <option value=7>7</option>
    <option value=8>8</option>
    <option value=9>9</option>
    <option value=10>10</option>
    <option value=11>11</option>
    <option value=12>12</option>
    <option value=13>13</option>
    <option value=14>14</option>
    <option value=15>15</option>
    <option value=16>16</option>
   </select>
  </td>
 </tr>
</table>
<br>
<input type=submit value="Apply Changes" name="SraSetup" onClick="return sra_saveChanges()">
&nbsp;&nbsp;&nbsp;
<input type=button value="Back" onclick="location.assign('/admin/vtuo-set.asp')">
<input type=hidden value="/admin/vtuo-set-sra.asp" name="submit-url">
<% vtuo_checkWrite("sra-init"); %>
</form>
<br>
<br>
</blockquote>
</body>
</html>

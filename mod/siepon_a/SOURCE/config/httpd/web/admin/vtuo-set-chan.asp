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
function chan_saveChanges()
{
 if( checkDigit(document.set_vtuo_chan.DSRateMax.value)==0 )
 {
  alert('<% multilang("1960" "LANG_INVALID_VALUE_FOR_MAX_NET_DATA_RATE"); %>');
  document.set_vtuo_chan.DSRateMax.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.DSRateMin.value)==0 )
 {
  alert('<% multilang("1961" "LANG_INVALID_VALUE_FOR_MIN_NET_DATA_RATE"); %>');
  document.set_vtuo_chan.DSRateMin.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.DSDelay.value)==0 )
 {
  alert('<% multilang("1962" "LANG_INVALID_VALUE_FOR_MAX_INTERLEAVE_DELAY"); %>');
  document.set_vtuo_chan.DSDelay.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.DSSOSRate.value)==0 )
 {
  alert('<% multilang("1963" "LANG_INVALID_VALUE_FOR_SOS_MIN_DATA_RATE"); %>');
  document.set_vtuo_chan.DSSOSRate.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.USRateMax.value)==0 )
 {
  alert('<% multilang("1960" "LANG_INVALID_VALUE_FOR_MAX_NET_DATA_RATE"); %>');
  document.set_vtuo_chan.USRateMax.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.USRateMin.value)==0 )
 {
  alert('<% multilang("1961" "LANG_INVALID_VALUE_FOR_MIN_NET_DATA_RATE"); %>');
  document.set_vtuo_chan.USRateMin.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.USDelay.value)==0 )
 {
  alert('<% multilang("1962" "LANG_INVALID_VALUE_FOR_MAX_INTERLEAVE_DELAY"); %>');
  document.set_vtuo_chan.USDelay.focus();
  return false;
 }
 if( checkDigit(document.set_vtuo_chan.USSOSRate.value)==0 )
 {
  alert('<% multilang("1963" "LANG_INVALID_VALUE_FOR_SOS_MIN_DATA_RATE"); %>');
  document.set_vtuo_chan.USSOSRate.focus();
  return false;
 }
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
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_chan>
<!--<h4>2. Channel Profile Setup</h4>-->
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr>
  <td width=50% align=left><h4>* Channel Profile Setup</h4></td>
  <td width=25% align=right><h5><a href="/admin/vtuo-set-inm.asp"><i>INM Profile</i></a></h5></td>
  <td width=25% align=right><h5><a href="/admin/vtuo-set.asp"><i>Line Profile</i><a></h5></td>
 </tr>
</table>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0></th>
  <th align=center bgcolor=#c0c0c0>Downstream</th>
  <th align=center bgcolor=#c0c0c0>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Max Net Data Rate (Kbps)</th>
  <td><input type="text" name="DSRateMax" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USRateMax" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min Net Data Rate (Kbps)</th>
  <td><input type="text" name="DSRateMin" size="8" maxlength="8" value=""></td>
  <td><input type="text" name="USRateMin" size="8" maxlength="8" value=""></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Max Interleave Delay</th>
  <td>
   <input type="text" name="DSDelay" size="8" maxlength="8" value="">ms
  </td>
  <td>
   <input type="text" name="USDelay" size="8" maxlength="8" value="">ms
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min INP</th>
  <td>
   <select size=1 name="DSINP">
    <option value=0>0</option>
    <option value=17>0.5</option>
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
   symbol
  </td>
  <td>
   <select size=1 name="USINP">
    <option value=0>0</option>
    <option value=17>0.5</option>
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
   symbol
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min INP_8 (f_sym=8k)</th>
  <td>
   <select size=1 name="DSINP8">
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
   symbol
  </td>
  <td>
   <select size=1 name="USINP8">
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
   symbol
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SOS Min Data Rate</th>
  <td>
   <input type="text" name="DSSOSRate" size="8" maxlength="8" value="">Kbps
  </td>
  <td>
   <input type="text" name="USSOSRate" size="8" maxlength="8" value="">Kbps
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0>
   <font size=2>G.INP&nbsp;&nbsp;<a href="/admin/vtuo-set-ginp.asp"><i>[ Edit ]</i></a>
  </th>
  <td id="ChanGinpDs" ></td>
  <td id="ChanGinpUs" ></td>
  </td>
 </tr>
</table>
<br>
<input type=submit value="Apply Changes" name="ChanProfile" onClick="return chan_saveChanges()">
<input type=hidden value="/admin/vtuo-set-chan.asp" name="submit-url">
<% vtuo_checkWrite("chan-init"); %>
</form>
<br><br>
</blockquote>
</body>
</html>

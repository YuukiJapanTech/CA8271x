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
function ginp_ds_mode_change()
{
 if(document.set_vtuo_ginp.DSGinpMode.selectedIndex==0)
 {
  document.set_vtuo_ginp.DSThroMax.disabled=true;
  document.set_vtuo_ginp.DSThroMin.disabled=true;
  document.set_vtuo_ginp.DSNDRMax.disabled=true;
  document.set_vtuo_ginp.DSRatio.disabled=true;
  document.set_vtuo_ginp.DSThres.disabled=true;
  document.set_vtuo_ginp.DSMaxDelay.disabled=true;
  document.set_vtuo_ginp.DSMinDelay.disabled=true;
  document.set_vtuo_ginp.DSINP.disabled=true;
  document.set_vtuo_ginp.DSReinSym.disabled=true;
  document.set_vtuo_ginp.DSReinFreq.disabled=true;
 }else{
  document.set_vtuo_ginp.DSThroMax.disabled=false;
  document.set_vtuo_ginp.DSThroMin.disabled=false;
  document.set_vtuo_ginp.DSNDRMax.disabled=false;
  document.set_vtuo_ginp.DSRatio.disabled=false;
  document.set_vtuo_ginp.DSThres.disabled=false;
  document.set_vtuo_ginp.DSMaxDelay.disabled=false;
  document.set_vtuo_ginp.DSMinDelay.disabled=false;
  document.set_vtuo_ginp.DSINP.disabled=false;
  document.set_vtuo_ginp.DSReinSym.disabled=false;
  document.set_vtuo_ginp.DSReinFreq.disabled=false;
 }
}
function ginp_us_mode_change()
{
 if(document.set_vtuo_ginp.USGinpMode.selectedIndex==0)
 {
  document.set_vtuo_ginp.USThroMax.disabled=true;
  document.set_vtuo_ginp.USThroMin.disabled=true;
  document.set_vtuo_ginp.USNDRMax.disabled=true;
  document.set_vtuo_ginp.USRatio.disabled=true;
  document.set_vtuo_ginp.USThres.disabled=true;
  document.set_vtuo_ginp.USMaxDelay.disabled=true;
  document.set_vtuo_ginp.USMinDelay.disabled=true;
  document.set_vtuo_ginp.USINP.disabled=true;
  document.set_vtuo_ginp.USReinSym.disabled=true;
  document.set_vtuo_ginp.USReinFreq.disabled=true;
 }else{
  document.set_vtuo_ginp.USThroMax.disabled=false;
  document.set_vtuo_ginp.USThroMin.disabled=false;
  document.set_vtuo_ginp.USNDRMax.disabled=false;
  document.set_vtuo_ginp.USRatio.disabled=false;
  document.set_vtuo_ginp.USThres.disabled=false;
  document.set_vtuo_ginp.USMaxDelay.disabled=false;
  document.set_vtuo_ginp.USMinDelay.disabled=false;
  document.set_vtuo_ginp.USINP.disabled=false;
  document.set_vtuo_ginp.USReinSym.disabled=false;
  document.set_vtuo_ginp.USReinFreq.disabled=false;
 }
}
function ginp_saveChanges()
{
 if(document.set_vtuo_ginp.DSGinpMode.selectedIndex!=0)
 {
  if( checkDigit(document.set_vtuo_ginp.DSThroMax.value)==0 )
  {
   alert('<% multilang("1964" "LANG_INVALID_VALUE_FOR_EFFECTIVE_THROUGHPUT"); %>');
   document.set_vtuo_ginp.DSThroMax.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.DSThroMin.value)==0 )
  {
   alert('<% multilang("1964" "LANG_INVALID_VALUE_FOR_EFFECTIVE_THROUGHPUT"); %>');
   document.set_vtuo_ginp.DSThroMin.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.DSNDRMax.value)==0 )
  {
   alert('<% multilang("1965" "LANG_INVALID_VALUE_FOR_NET_DATA_RATE"); %>');
   document.set_vtuo_ginp.DSNDRMax.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.DSRatio.value)==0 )
  {
   alert('<% multilang("1966" "LANG_INVALID_VALUE_FOR_SHINE_RATIO"); %>');
   document.set_vtuo_ginp.DSRatio.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.DSThres.value)==0 )
  {
   alert('<% multilang("1967" "LANG_INVALID_VALUE_FOR_LEFTR_THRESHOLD"); %>');
   document.set_vtuo_ginp.DSThres.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.DSMaxDelay.value)==0 )
  {
   alert('<% multilang("1968" "LANG_INVALID_VALUE_FOR_MAX_DELAY"); %>');
   document.set_vtuo_ginp.DSMaxDelay.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.DSMinDelay.value)==0 )
  {
   alert('<% multilang("1969" "LANG_INVALID_VALUE_FOR_MIN_DELAY"); %>');
   document.set_vtuo_ginp.DSMinDelay.focus();
   return false;
  }
 }
 if(document.set_vtuo_ginp.USGinpMode.selectedIndex!=0)
 {
  if( checkDigit(document.set_vtuo_ginp.USThroMax.value)==0 )
  {
   alert('<% multilang("1964" "LANG_INVALID_VALUE_FOR_EFFECTIVE_THROUGHPUT"); %>');
   document.set_vtuo_ginp.USThroMax.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.USThroMin.value)==0 )
  {
   alert('<% multilang("1964" "LANG_INVALID_VALUE_FOR_EFFECTIVE_THROUGHPUT"); %>');
   document.set_vtuo_ginp.USThroMin.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.USNDRMax.value)==0 )
  {
   alert('<% multilang("1965" "LANG_INVALID_VALUE_FOR_NET_DATA_RATE"); %>');
   document.set_vtuo_ginp.USNDRMax.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.USRatio.value)==0 )
  {
   alert('<% multilang("1966" "LANG_INVALID_VALUE_FOR_SHINE_RATIO"); %>');
   document.set_vtuo_ginp.USRatio.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.USThres.value)==0 )
  {
   alert('<% multilang("1967" "LANG_INVALID_VALUE_FOR_LEFTR_THRESHOLD"); %>');
   document.set_vtuo_ginp.USThres.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.USMaxDelay.value)==0 )
  {
   alert('<% multilang("1968" "LANG_INVALID_VALUE_FOR_MAX_DELAY"); %>');
   document.set_vtuo_ginp.USMaxDelay.focus();
   return false;
  }
  if( checkDigit(document.set_vtuo_ginp.USMinDelay.value)==0 )
  {
   alert('<% multilang("1969" "LANG_INVALID_VALUE_FOR_MIN_DELAY"); %>');
   document.set_vtuo_ginp.USMinDelay.focus();
   return false;
  }
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
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_ginp>
<h4>* Channel Profile &nbsp;&gt;&nbsp; G.INP Setup</h4>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0></th>
  <th align=center bgcolor=#c0c0c0>Downstream</th>
  <th align=center bgcolor=#c0c0c0>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>G.INP Mode</th>
  <td>
   <select size=1 name="DSGinpMode" onChange="ginp_ds_mode_change()">
    <option value=0>Forbidden</option>
    <option value=1>Preferred</option>
    <option value=2>Forced</option>
    <option value=3>Test</option>
   </select>
  </td>
  <td>
   <select size=1 name="USGinpMode" onChange="ginp_us_mode_change()">
    <option value=0>Forbidden</option>
    <option value=1>Preferred</option>
    <option value=2>Forced</option>
    <option value=3>Test</option>
   </select>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Effective Throughput</th>
  <td>
   Max<input type="text" name="DSThroMax" size="8" maxlength="8" value="">
   Min<input type="text" name="DSThroMin" size="8" maxlength="8" value="">
  </td>
  <td>
   Max<input type="text" name="USThroMax" size="8" maxlength="8" value="">
   Min<input type="text" name="USThroMin" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Net Data Rate(NDR)</th>
  <td>
   Max<input type="text" name="DSNDRMax" size="8" maxlength="8" value="">
  </td>
  <td>
   Max<input type="text" name="USNDRMax" size="8" maxlength="8" value="">
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Shine Ratio</th>
  <td>
   <input type="text" name="DSRatio" size="8" maxlength="8" value="">/1000*NDR
  </td>
  <td>
   <input type="text" name="USRatio" size="8" maxlength="8" value="">/1000*NDR
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>LEFTR Threshold</th>
  <td>
   <input type="text" name="DSThres" size="8" maxlength="8" value="">/100*NDR
  </td>
  <td>
   <input type="text" name="USThres" size="8" maxlength="8" value="">/100*NDR
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Max Delay</th>
  <td>
   <input type="text" name="DSMaxDelay" size="8" maxlength="8" value="">ms
  </td>
  <td>
   <input type="text" name="USMaxDelay" size="8" maxlength="8" value="">ms
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min Delay</th>
  <td>
   <input type="text" name="DSMinDelay" size="8" maxlength="8" value="">ms
  </td>
  <td>
   <input type="text" name="USMinDelay" size="8" maxlength="8" value="">ms
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Min INP</th>
  <td>
   <select size=1 name="DSINP">
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
    <option value=17>17</option>
    <option value=18>18</option>
    <option value=19>19</option>
    <option value=20>20</option>
    <option value=21>21</option>
    <option value=22>22</option>
    <option value=23>23</option>
    <option value=24>24</option>
    <option value=25>25</option>
    <option value=26>26</option>
    <option value=27>27</option>
    <option value=28>28</option>
    <option value=29>29</option>
    <option value=30>30</option>
    <option value=31>31</option>
   </select>
   symbol
  </td>
  <td>
   <select size=1 name="USINP">
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
    <option value=17>17</option>
    <option value=18>18</option>
    <option value=19>19</option>
    <option value=20>20</option>
    <option value=21>21</option>
    <option value=22>22</option>
    <option value=23>23</option>
    <option value=24>24</option>
    <option value=25>25</option>
    <option value=26>26</option>
    <option value=27>27</option>
    <option value=28>28</option>
    <option value=29>29</option>
    <option value=30>30</option>
    <option value=31>31</option>
   </select>
   symbol
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>REIN Config</th>
  <td>
   <select size=1 name="DSReinSym">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6>6</option>
    <option value=7>7</option>
   </select>
   symbol
   <select size=1 name="DSReinFreq">
    <option value=0>100</option>
    <option value=1>120</option>
   </select>
   Hz
  </td>
  <td>
   <select size=1 name="USReinSym">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
    <option value=4>4</option>
    <option value=5>5</option>
    <option value=6>6</option>
    <option value=7>7</option>
   </select>
   symbol
   <select size=1 name="USReinFreq">
    <option value=0>100</option>
    <option value=1>120</option>
   </select>
   Hz
  </td>
 </tr>
</table>
<br>
<input type=submit value="Apply Changes" name="GinpSetup" onClick="return ginp_saveChanges()">
&nbsp;&nbsp;&nbsp;
<input type=button value="Back" onclick="location.assign('/admin/vtuo-set-chan.asp')">
<input type=hidden value="/admin/vtuo-set-ginp.asp" name="submit-url">
<% vtuo_checkWrite("ginp-init"); %>
<script>
ginp_ds_mode_change();
ginp_us_mode_change();
</script>
</form>
<br>
<br>
</blockquote>
</body>
</html>

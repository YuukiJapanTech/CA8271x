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
function inm_saveChanges()
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
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_inm>
<!--<h4>3. Impulse Noise Moniter Setup</h4>-->
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr>
  <td width=50% align=left><h4>* Impulse Noise Moniter Setup</h4></td>
  <td width=25% align=right><h5><a href="/admin/vtuo-set.asp"><i>Line Profile</i><a></h5></td>
  <td width=25% align=right><h5><a href="/admin/vtuo-set-chan.asp"><i>Channel Profile</i></a></h5></td>
 </tr>
</table>
<table border=0 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th width=33% align=left bgcolor=#c0c0c0></th>
  <th width=33% align=center bgcolor=#c0c0c0>NearEnd</th>
  <th width=34% align=center bgcolor=#c0c0c0>FarEnd</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>InpEqMode</th>
  <td>
   <select size=1 name="NEInpEqMode">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
   </select>
  </td>
  <td>
   <select size=1 name="FEInpEqMode">
    <option value=0>0</option>
    <option value=1>1</option>
    <option value=2>2</option>
    <option value=3>3</option>
   </select>
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>INMCC</th>
  <td>
   <input type="text" name="NEInmCc" size="8" maxlength="8" value="">symbol
  </td>
  <td>
   <input type="text" name="FEInmCc" size="8" maxlength="8" value="">symbol
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>IAT Offset</th>
  <td>
   <input type="text" name="NEIatOff" size="8" maxlength="8" value="">symbol
  </td>
  <td>
   <input type="text" name="FEIatOff" size="8" maxlength="8" value="">symbol
  </td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>IAT Setup</th>
  <td>
   <input type="text" name="NEIatSet" size="8" maxlength="8" value="">symbol
  </td>
  <td>
   <input type="text" name="FEIatSet" size="8" maxlength="8" value="">symbol
  </td>
 </tr>
 <!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>ISDD Sensitivity</th>
  <td>
   <input type="text" name="NEIsddSen" size="8" maxlength="8" value="">dB
  </td>
  <td>
   <input type="text" name="FEIsddSen" size="8" maxlength="8" value="" disabled>dB
  </td>
 </tr>
 -->
</table>
<br>
<input type=submit value="Apply Changes" name="InmSetup" onClick="return inm_saveChanges()">
<input type=hidden value="/admin/vtuo-set-inm.asp" name="submit-url">
<% vtuo_checkWrite("inm-init"); %>
</form>
<br><br>
</blockquote>
</body>
</html>

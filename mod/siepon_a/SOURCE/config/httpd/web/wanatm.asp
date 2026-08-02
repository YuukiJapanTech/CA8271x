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
<title><% multilang("13" "LANG_ATM_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function addClick()
{
 var digit;
 if(document.formAtm.vpi.value.length == 0)
  return true;
 <% checkWrite("vcMax"); %>
 digit = getDigit(document.formAtm.vpi.value, 1);
 if ( validateKey(document.formAtm.vpi.value) == 0 ||
  (digit > 255 || digit < 0) ) {
  alert("<% multilang("1929" "LANG_INVALID_VPI_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_0_255"); %>");
  document.formAtm.vpi.focus();
  return false;
 }
 digit = getDigit(document.formAtm.vci.value, 1);
 if ( validateKey(document.formAtm.vci.value) == 0 ||
  (digit > 65535 || digit < 0) ) {
  alert("<% multilang("1931" "LANG_INVALID_VCI_VALUE_YOU_SHOULD_SET_A_VALUE_BETWEEN_0_65535"); %>");
  document.formAtm.vci.focus();
  return false;
 }
 digit = getDigit(document.formAtm.pcr.value, 1);
 if ( validateKey(document.formAtm.pcr.value) == 0 ||
  (digit > 6000 || digit < 1) ) {
  alert("Invalid PCR value! You should set a value between 1-6000.");
  document.formAtm.pcr.focus();
  return false;
 }
 digit = getDigit(document.formAtm.cdvt.value, 1);
 if ( validateKey(document.formAtm.cdvt.value) == 0 ||
  (digit > 4294967295 || digit < 0) ) {
  alert("Invalid CDVT value! You should set a value between 0-4294967295.");
  document.formAtm.cdvt.focus();
  return false;
 }
 if (( document.formAtm.qos.selectedIndex == 2 ) ||
  ( document.formAtm.qos.selectedIndex == 3 )) {
  digit = getDigit(document.formAtm.scr.value, 1);
  if ( validateKey(document.formAtm.scr.value) == 0 ||
   (digit > 6000 || digit < 1) ) {
   alert("Invalid SCR value! You should set a value between 1-6000.");
   document.formAtm.scr.focus();
   return false;
  }
  digit = getDigit(document.formAtm.mbs.value, 1);
  if ( validateKey(document.formAtm.mbs.value) == 0 ||
   (digit > 65535 || digit < 0) ) {
   alert("Invalid MBS value! You should set a value between 0-65535.");
   document.formAtm.mbs.focus();
   return false;
  }
 }
 return true;
}
function resetClicked()
{
 document.formAtm.qos.selectedIndex = 0;
 disableTextField(document.formAtm.scr);
 disableTextField(document.formAtm.mbs);
}
function qosSelection()
{
 if (( document.formAtm.qos.selectedIndex == 2 ) ||
  ( document.formAtm.qos.selectedIndex == 3 )) {
  enableTextField(document.formAtm.scr);
  enableTextField(document.formAtm.mbs);
 } else {
  disableTextField(document.formAtm.scr);
  disableTextField(document.formAtm.mbs);
 }
}
function clearAll()
{
 document.formAtm.vpi.value = "";
 document.formAtm.vci.value = "";
 document.formAtm.qos.selectedIndex = 0;
 document.formAtm.pcr.value = "";
 document.formAtm.cdvt.value = "";
 document.formAtm.scr.value = "";
 document.formAtm.mbs.value = "";
}
function postVC(vpi,vci,qos,pcr,cdvt,scr,mbs)
{
 clearAll();
 document.formAtm.vpi.value = vpi;
 document.formAtm.vci.value = vci;
 document.formAtm.qos.selectedIndex = qos;
 document.formAtm.pcr.value = pcr;
 document.formAtm.cdvt.value = cdvt;
 if (qos == 2 || qos == 3) {
  enableTextField(document.formAtm.scr);
  enableTextField(document.formAtm.mbs);
  document.formAtm.scr.value = scr;
  document.formAtm.mbs.value = mbs;
 }
 else {
  disableTextField(document.formAtm.scr);
  disableTextField(document.formAtm.mbs);
 }
}
</script>
</head>
<BODY>
<blockquote>
<h2><font color="#0000FF"><% multilang("13" "LANG_ATM_SETTINGS"); %></font></h2>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><font size=2>
    <% multilang("265" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_THE_ATM_OF_YOUR_DEVICE_HERE_YOU_MAY_CHANGE_THE_SETTING_FOR_VPI_VCI_QOS_ETC"); %>
</font></td></tr>
<tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/formWanAtm method=POST name="formAtm">
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td>
 <p><font size=2><b>VPI: </b> <input type="text" name="vpi" size="5" maxlength="5" disabled>&nbsp;&nbsp;
 <b><font size=2>VCI: </b> <input type="text" name="vci" size="5" maxlength="5" disabled>&nbsp;&nbsp;
 <b><font size=2><b>QoS: </b> <select size="1" name="qos" onChange="qosSelection()">
  <option selected value="0">UBR</option>
  <option value="1">CBR</option>
  <option value="2">nrt-VBR</option>
  <option value="3">rt-VBR</option>
  </select>
 <p><font size=2>PCR: </b> <input type="text" name="pcr" size="5" maxlength="5">&nbsp;&nbsp;
 <b><font size=2>CDVT: </b> <input type="text" name="cdvt" size="10" maxlength="10">&nbsp;&nbsp;
 <b><font size=2>SCR: </b> <input type="text" name="scr" size="5" maxlength="5">&nbsp;&nbsp;
 <b><font size=2>MBS: </b> <input type="text" name="mbs" size="5" maxlength="5"></font>
 <p><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="changeAtmVc" onClick="return addClick()">&nbsp;&nbsp;
  <input type="reset" value="<% multilang("266" "LANG_UNDO"); %>" name="reset" onClick="resetClicked()">
  <input type="hidden" value="/wanatm.asp" name="submit-url">
 </p>
</td><tr>
</table>
<br>
<table border="0" width=500>
 <tr><font size=2><b><% multilang("258" "LANG_CURRENT_ATM_VC_TABLE"); %>:</b></font></tr>
 <% atmVcList(); %>
</table>
<SCRIPT>
 qosSelection();
</SCRIPT>
</form>
</blockquote>
</body>
</html>

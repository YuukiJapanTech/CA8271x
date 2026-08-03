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
<title><% multilang("20" "LANG_PARENTAL_CONTROL"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
function skip () { this.blur(); }
function addClick()
{
  var ls, le;
  var ls1, le1;
  var ls2, le2;
  var ls3, le3;
  ls = getDigit(document.formParentCtrlAdd.ipstart.value,4);
  le = getDigit(document.formParentCtrlAdd.ipend.value,4);
  ls1 = getDigit(document.formParentCtrlAdd.ipstart.value,1);
  le1 = getDigit(document.formParentCtrlAdd.ipend.value,1);
  ls2 = getDigit(document.formParentCtrlAdd.ipstart.value,2);
  le2 = getDigit(document.formParentCtrlAdd.ipend.value,2);
  ls3 = getDigit(document.formParentCtrlAdd.ipstart.value,3);
  le3 = getDigit(document.formParentCtrlAdd.ipend.value,3);
  if (document.formParentCtrlAdd.usrname.value=="" )
  {
   alert("<% multilang("2228" "LANG_INPUT_USERNAME"); %>");
 document.formParentCtrlAdd.usrname.focus();
 return false;
  }
  if (document.formParentCtrlAdd.specPC[0].checked)
  {
     if (!checkHostIP(document.formParentCtrlAdd.ipstart, 1))
     {
    document.formParentCtrlAdd.ipstart.focus();
    return false;
     }
     if (!checkHostIP(document.formParentCtrlAdd.ipend, 1))
     {
    document.formParentCtrlAdd.ipend.focus();
    return false;
     }
     if ( ls1 != le1 || ls2 != le2 || ls3 != le3 )
     {
     alert("<% multilang("2229" "LANG_LOCAL_START_IP_DOMAIN_IS_DIFFERENT_FROM_END_IP"); %>");
     document.formParentCtrlAdd.ipstart.focus();
     return false;
     }
     if ( le <= ls )
     {
   alert("<% multilang("2230" "LANG_INVALID_IP_RANGE"); %>");
   document.formParentCtrlAdd.ipstart.focus();
   return false;
     }
  }
  if (document.formParentCtrlAdd.specPC[1].checked)
  {
    if (document.formParentCtrlAdd.mac.value=="" )
  {
   alert("<% multilang("2109" "LANG_INPUT_MAC_ADDRESS"); %>");
 document.formParentCtrlAdd.mac.focus();
 return false;
  }
  var str = document.formParentCtrlAdd.mac.value;
  if ( str.length < 12) {
 alert("<% multilang("2110" "LANG_INPUT_MAC_ADDRESS_IS_NOT_COMPLETE_IT_SHOULD_BE_12_DIGITS_IN_HEX"); %>");
 document.formParentCtrlAdd.mac.focus();
 return false;
  }
  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
   (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
   (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
   continue;
 alert("<% multilang("2231" "LANG_INVALID_MAC_ADDRESS_IT_SHOULD_BE_IN_HEX_NUMBER_0_9_OR_A_F"); %>");
 document.formParentCtrlAdd.mac.focus();
 return false;
  }
  }
  if ((document.formParentCtrlAdd.starthr.value=="" )
   || (document.formParentCtrlAdd.startmin.value=="" )
   ||(document.formParentCtrlAdd.endhr.value=="" )
   ||(document.formParentCtrlAdd.endmin.value=="" )){
   alert("<% multilang("2232" "LANG_INVALID_VALUE_OF_TIME_VALUE_PLEASE_INPUT_CORRENT_TIME_FORMAT_00_00_23_59"); %>");
   document.formParentCtrlAdd.starthr.focus();
 return false;
  }
 num1 = parseInt(document.formParentCtrlAdd.starthr.value,10);
 num2 = parseInt(document.formParentCtrlAdd.startmin.value,10);
 num3 = parseInt(document.formParentCtrlAdd.endhr.value,10);
 num4 = parseInt(document.formParentCtrlAdd.endmin.value,10);
  if ((num1 > 23)||(num3 > 23) ) {
   alert("<% multilang("2232" "LANG_INVALID_VALUE_OF_TIME_VALUE_PLEASE_INPUT_CORRENT_TIME_FORMAT_00_00_23_59"); %>");
   document.formParentCtrlAdd.starthr.focus();
 return false;
  }
  if ( num1 > num3 ) {
   alert("<% multilang("2233" "LANG_END_TIME_SHOULD_BE_LARGER"); %>");
   document.formParentCtrlAdd.starthr.focus();
 return false;
  }
   if (( num1 == num3 ) && (num2 >= num4)) {
   alert("<% multilang("2233" "LANG_END_TIME_SHOULD_BE_LARGER"); %>");
   document.formParentCtrlAdd.starthr.focus();
 return false;
  }
  if ((num2 > 59)||(num4 > 59) ) {
   alert("<% multilang("2234" "LANG_INVALID_VALUE_OF_TIME_VALUE_PLEASE_INPUT_CORRENT_TIME_FORMAT_EX_12_50"); %>");
   document.formParentCtrlAdd.starthr.focus();
 return false;
  }
  return true;
}
function disableDelButton()
{
  if (verifyBrowser() != "ns") {
 disableButton(document.formParentCtrlDel.deleteSelFilterMac);
 disableButton(document.formParentCtrlDel.deleteAllFilterMac);
  }
}
function updateState()
{
//  if (document.formParentCtrlAdd.enabled.checked) {
  if (document.formParentCtrlAdd.specPC[0].checked) {
  enableTextField(document.formParentCtrlAdd.ipstart);
 enableTextField(document.formParentCtrlAdd.ipend);
 disableTextField(document.formParentCtrlAdd.mac);
  }
  else {
  enableTextField(document.formParentCtrlAdd.mac);
 disableTextField(document.formParentCtrlAdd.ipstart);
 disableTextField(document.formParentCtrlAdd.ipend);
  }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("20" "LANG_PARENTAL_CONTROL"); %></font></h2>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><font size=2>
 <% multilang("523" "LANG_ENTRIES_IN_THIS_TABLE_ARE_USED_TO_RESTRICT_ACCESS_TO_INTERNET_FROM_YOUR_LOCAL_PCS_DEVICES_BY_MAC_ADDRESS_AND_TIME_INTERVAL_USE_OF_SUCH_FILTERS_CAN_BE_HELPFUL_FOR_PARENTS_TO_CONTROL_CHILDREN_S_USAGE_OF_INTERNET"); %>
</font></td></tr>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<form action=/boaform/admin/formParentCtrl method=POST name="formParentCtrl">
 <tr>
  <td><font size=2><b><% multilang("20" "LANG_PARENTAL_CONTROL"); %>:</b></font></td>
  <td><font size=2>
   <input type="radio" value="0" name="parental_ctrl_on" <% checkWrite("parental-ctrl-on-0"); %> ><% multilang("206" "LANG_DISABLE"); %>&nbsp;&nbsp;
   <input type="radio" value="1" name="parental_ctrl_on" <% checkWrite("parental-ctrl-on-1"); %> ><% multilang("207" "LANG_ENABLE"); %>&nbsp;&nbsp;
  </font></td>
  <td><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="parentalCtrlSet"></td>
  <td><input type="hidden" value="/parental-ctrl.asp" name="submit-url"></td>
 </tr>
</form>
</table>
<table border=0 width="500" cellspacing=4 cellpadding=0>
<tr><td><hr size=1 noshade align=top></td></tr>
<form action=/boaform/admin/formParentCtrl method=POST name="formParentCtrlAdd">
<tr><td>
     <p><font size=2>
        <b><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:&nbsp;&nbsp; </b> <input type="text" name="usrname" size="32" maxlength="31">&nbsp;&nbsp;
     </p>
  <p><font size=2><b><% multilang("2" "LANG_SPECIFIED_PC"); %>:</b>
  <input type="radio" value="0" name="specPC" checked onClick="updateState()"><% multilang("69" "LANG_IP_ADDRESS"); %>&nbsp;&nbsp;
  <input type="radio" value="1" name="specPC" onClick="updateState()"><% multilang("72" "LANG_MAC_ADDRESS"); %>&nbsp;&nbsp;
  </font></p>
  <p><font size=2>
  <b><% multilang("69" "LANG_IP_ADDRESS"); %>: </b><input type="text" name="ipstart" size="15" maxlength="15" value= >--
  <input type="text" name="ipend" size="15" maxlength="15" value= >
  </font></p>
     <p><font size=2>
        <b><% multilang("72" "LANG_MAC_ADDRESS"); %>:&nbsp;&nbsp; </b> <input type="text" name="mac" size="15" maxlength="12">(ex. 00e086710502)&nbsp;&nbsp;
     </p>
  <table border='0' cellpadding="0" cellspacing="0" >
               <tr>
                  <td width='120'></td>
                  <td align='center' width='60' ><font size="2"><% multilang("524" "LANG_SUN"); %></font></td>
                  <td align='center' width='60' ><font size="2"><% multilang("525" "LANG_MON"); %></font></td>
                  <td align='center' width='60' ><font size="2"><% multilang("526" "LANG_TUE"); %></font></td>
                  <td align='center' width='60' ><font size="2"><% multilang("527" "LANG_WED"); %></font></td>
                  <td align='center' width='60' ><font size="2"><% multilang("528" "LANG_THU"); %></font></td>
                  <td align='center' width='60' ><font size="2"><% multilang("529" "LANG_FRI"); %></font></td>
                  <td align='center' width='60' ><font size="2"><% multilang("530" "LANG_SAT"); %></font></td>
               </tr>
               <tr>
                  <td><font size=2><b><% multilang("532" "LANG_CONTROLLED_DAYS"); %> </b></font></td>
                  <td align='center'><input type='checkbox' name='Sun'></td>
                  <td align='center'><input type='checkbox' name='Mon'></td>
                  <td align='center'><input type='checkbox' name='Tue'></td>
                  <td align='center'><input type='checkbox' name='Wed'></td>
                  <td align='center'><input type='checkbox' name='Thu'></td>
                  <td align='center'><input type='checkbox' name='Fri'></td>
                  <td align='center'><input type='checkbox' name='Sat'></td>
               </tr>
    </table>
 <p><font size=2>
        <b><% multilang("533" "LANG_START_BLOCKING_TIME"); %>:&nbsp;&nbsp; </b> <input type="text" name="starthr" size="2" maxlength="2"><b>:</b>
         <input type="text" name="startmin" size="2" maxlength="2">
 </p>
 <p><font size=2>
        <b><% multilang("534" "LANG_END_BLOCKING_TIME"); %>:&nbsp;&nbsp; </b> <input type="text" name="endhr" size="2" maxlength="2"><b>:</b>
         <input type="text" name="endmin" size="2" maxlength="2">
 </p>
 <p><input type="submit" value="<% multilang("180" "LANG_ADD"); %>" name="addfilterMac" onClick="return addClick()">&nbsp;&nbsp;
        <!--<input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset">-->
        <input type="hidden" value="/parental-ctrl.asp" name="submit-url">
     </p>
  </td></tr>
  <script> updateState(); </script>
</form>
</table>
<br>
<form action=/boaform/admin/formParentCtrl method=POST name="formParentCtrlDel">
  <table border="0" width=500>
  <tr><font size=2><b><% multilang("535" "LANG_CURRENT_PARENT_CONTROL_TABLE"); %>:</b></font></tr>
  <% parentControlList(); %>
  </table>
  <br>
  <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="deleteSelFilterMac" onClick="return deleteClick()">&nbsp;&nbsp;
  <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="deleteAllFilterMac" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
  <input type="hidden" value="/parental-ctrl.asp" name="submit-url">
 <script>
  <% checkWrite("parentCtrlNum"); %>
 </script>
</form>
</blockquote>
</body>
</html>

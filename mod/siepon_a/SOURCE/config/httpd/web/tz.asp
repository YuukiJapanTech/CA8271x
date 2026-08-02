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
<! Copyright (c) Realtek Semiconductor Corp., 2004. All Rights Reserved. ->
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("51" "LANG_TIME_ZONE"); %><% multilang("197" "LANG_CONFIGURATION"); %></title>
<script type="text/javascript" src="share.js"> </script>
<script>
var ntp_zone_index=4;
function ntp_entry(name, value) {
 this.name = name ;
 this.value = value ;
}
function setNtpServer(field, ntpServer){
    field.selectedIndex = 0 ;
    for(i=0 ;i < field.options.length ; i++){
     if(field.options[i].value == ntpServer){
  field.options[i].selected = true;
  break;
 }
    }
}
function checkEmpty(field){
 if(field.value.length == 0){
  alert(field.name + " field can't be empty\n");
  field.value = field.defaultValue;
  field.focus();
  return false;
 }
 else
  return true;
}
function checkNumber(field){
    str =field.value ;
    for (var i=0; i<str.length; i++) {
     if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9'))
                        continue;
 field.value = field.defaultValue;
        alert("<% multilang("2322" "LANG_IT_SHOULD_BE_IN_NUMBER_0_9"); %>");
        return false;
    }
 return true;
}
function checkMonth(str) {
  d = parseInt(str, 10);
  if (d < 0 || d > 12)
       return false;
  return true;
}
function checkDay(str, month) {
  d = parseInt(str, 10);
  m = parseInt (month, 10);
  if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
   if (d < 0 || d > 31)
        return false;
  }
  else if (m == 4 || m == 6 || m == 9 || m == 11) {
   if (d < 0 || d > 31)
        return false;
  }
  else if (m == 2) {
   if (d < 0 || d > 29)
        return false;
  }
  else
   return false;
  return true;
}
function checkHour(str) {
  d = parseInt(str, 10);
  if (d < 0 || d >= 24)
       return false;
  return true;
}
function checkTime(str) {
  d = parseInt(str, 10);
  if (d < 0 || d >= 60)
       return false;
  return true;
}
function saveChanges(form){
 if((checkEmpty(form.year)& checkEmpty(form.month) & checkEmpty(form.hour)
  & checkEmpty(form.day) &checkEmpty(form.minute) & checkEmpty(form.second))== false)
   return false;
 if((checkNumber(form.year)& checkNumber(form.month) & checkNumber(form.hour)
  & checkNumber(form.day) &checkNumber(form.minute) & checkNumber(form.second))== false)
   return false;
 if(form.month.value == '0'){
  form.month.value = form.month.defaultValue;
         alert("<% multilang("2323" "LANG_INVALID_MONTH_NUMBER_IT_SHOULD_BE_IN_NUMBER_1_9"); %>");
  return false;
 }
 if (!checkMonth(form.month.value)) {
  alert("<% multilang("2324" "LANG_INVALID_MONTH_SETTING"); %>");
  form.month.focus();
  return false;
 }
 if (!checkDay(form.day.value, form.month.value)) {
  alert("<% multilang("2325" "LANG_INVALID_DAY_SETTING"); %>");
  form.day.focus();
  return false;
 }
 if (!checkHour(form.hour.value)) {
  alert("<% multilang("2326" "LANG_INVALID_HOUR_SETTING"); %>");
  form.hour.focus();
  return false;
 }
 if (!checkTime(form.minute.value) || !checkTime(form.second.value)) {
  alert("<% multilang("2327" "LANG_INVALID_TIME_SETTING"); %>");
  return false;
 }
 if (form.enabled.checked && form.ntpServerId[1].checked && form.ntpServerHost2.value != form.ntpServerHost2.defaultValue) {
  if (form.ntpServerHost2.value == "" || !checkString(form.ntpServerHost2.value)) {
   alert("<% multilang("2328" "LANG_INVALID_SERVER_STRING"); %>");
   form.ntpServerHost2.value = form.ntpServerHost2.defaultValue;
   form.ntpServerHost2.focus();
   return false;
  }
 }
 return true;
}
function updateState(form)
{
 if(form.enabled.checked){
  enableTextField(form.ntpServerHost1);
  if(form.ntpServerHost2 != null)
   enableTextField(form.ntpServerHost2);
 }
 else{
  disableTextField(form.ntpServerHost1);
  if(form.ntpServerHost2 != null)
   disableTextField(form.ntpServerHost2);
 }
}
</script>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("51" "LANG_TIME_ZONE"); %><% multilang("197" "LANG_CONFIGURATION"); %></font></h2>
<table border=0 width="500" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
  <% multilang("483" "LANG_YOU_CAN_MAINTAIN_THE_SYSTEM_TIME_BY_SYNCHRONIZING_WITH_A_PUBLIC_TIME_SERVER_OVER_THE_INTERNET"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
  </table>
<form action=/boaform/formNtp method=POST name="time">
<table border="0" width=520>
 <tr>
 <td width ="25%">
 <font size=2> <b> <% multilang("484" "LANG_CURRENT_TIME"); %> : </b> </font>
 </td>
 <td width ="75%">
                <font size =2> <b>
                <% multilang("491" "LANG_YEAR"); %><input type="text" name="year" value="<% getInfo("year"); %>" size="4" maxlength="4">
                <% multilang("492" "LANG_MONTH"); %><input type="text" name="month" value="<% getInfo("month"); %>" size="2" maxlength="2">
                <% multilang("493" "LANG_DAY"); %><input type="text" name="day" value="<% getInfo("day"); %>" size="2" maxlength="2">
  <br>
                <% multilang("494" "LANG_HOUR"); %><input type="text" name="hour" value="<% getInfo("hour"); %>" size="2" maxlength="2">
                <% multilang("495" "LANG_MIN"); %><input type="text" name="minute" value="<% getInfo("minute"); %>" size="2" maxlength="2">
                <% multilang("496" "LANG_SEC"); %><input type="text" name="second" value="<% getInfo("second"); %>" size="2" maxlength="2">
                </b> </font>
        </td>
 </tr>
 <tr><td width="25%"><font size=2> <b><% multilang("485" "LANG_TIME_ZONE_SELECT"); %> : </b> </font></td>
     <td width="75%">
            <select name="timeZone">
      <% timeZoneList(); %>
            </select>
     </td>
 </tr>
 <tr ><td height=10> </td> </tr>
 <tr><td colspan="2"><font size=2><b>
  <input type="checkbox" name="dst_enabled"
  value="ON">&nbsp;&nbsp;<% multilang("486" "LANG_ENABLE_DAYLIGHT_SAVING_TIME"); %></b></font><br>
     </td>
 </tr>
 <tr><td colspan="2"><font size=2><b>
  <input type="checkbox" name="enabled"
  value="ON"
  ONCLICK=updateState(document.time)>&nbsp;&nbsp;<% multilang("487" "LANG_ENABLE_SNTP_CLIENT_UPDATE"); %></b><br>
     </td>
 </tr>
 <tr>
  <td width="25%"><font size=2><b><% multilang("354" "LANG_WAN_INTERFACE"); %>:</b></font></td>
  <td width="75%">
   <select name="ext_if" <% checkWrite("sntp0d"); %>>
    <option value=65535><% multilang("331" "LANG_ANY"); %></option>
    <% if_wan_list("rt"); %>
   </select>
  </td>
 </tr>
 <tr>
 <td width ="25%">
 <font size=2> <b> SNTP <% multilang("71" "LANG_SERVER"); %> : </b> </font>
 </td>
 <td width ="75%">
  <input type="radio" value="0" name="ntpServerId"></input>
  <select name="ntpServerHost1">
   <option value="192.5.41.41"><% multilang("497" "LANG_192_5_41_41_NORTH_AMERICA"); %></option>
   <option value="192.5.41.209"><% multilang("498" "LANG_192_5_41_209_NORTH_AMERICA"); %></option>
   <option value="130.149.17.8"><% multilang("499" "LANG_130_149_17_8_EUROPE"); %></option>
   <option value="203.117.180.36"><% multilang("500" "LANG_203_117_180_36_ASIA_PACIFIC"); %></option>
  </select>
 </td>
 </tr>
 <tr>
 <td width ="25%"> <font size=2><b> </b></font>
 </td>
 <td width ="75%">
 <input type="radio" value="1" name="ntpServerId"></input>
 <!--ping_zhang:20081217 START:patch from telefonica branch to support WT-107-->
 <input type="text" name="ntpServerHost2" size="15" maxlength="30" value=<% getInfo("ntpServerHost2"); %>> <font size=2> (<% multilang("488" "LANG_MANUAL_SETTING"); %>) </font>
  </td>
 </tr>
</table>
  <input type="hidden" value="/tz.asp" name="submit-url">
  <p><input type="submit" value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges(document.time)">
&nbsp;&nbsp;
  <input type="button" value="<% multilang("362" "LANG_REFRESH"); %>" name="refresh" onClick="javascript: window.location.reload()">
</form>
<script>
  <% initPage("ntp"); %>
  setNtpServer(document.time.ntpServerHost1, "<% getInfo("ntpServerHost1"); %>");
  updateState(document.time);
  ifIdx = <% getInfo("ntp-ext-itf"); %>;
  document.time.ext_if.selectedIndex = 0;
  for( i = 1; i < document.time.ext_if.options.length; i++ )
  {
   if( ifIdx == document.time.ext_if.options[i].value )
    document.time.ext_if.selectedIndex = i;
  }
</script>
</blockquote>
</font>
</body>
</html>

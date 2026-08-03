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
<title><% multilang("18" "LANG_PORT_FORWARDING"); %> - <% multilang("8" "LANG_ADVANCED_SETTINGS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<SCRIPT>
function PFWRemove() {
   with ( document.portfwAdvance ) {
      var arrSelected = new Array();
      var count = 0;
      for ( i = 0; i < lstApply.options.length; i++ ) {
         if ( lstApply.options[i].selected == true ) {
            arrSelected[count] = lstApply.options[i].value;
         }
         count++;
      }
      var x = 0;
      for (i = 0; i < lstApply.options.length; i++) {
         for (x = 0; x < arrSelected.length; x++) {
            if (lstApply.options[i].value == arrSelected[x]) {
               //varOpt = new Option(lstApply.options[i].text, lstApply.options[i].value);
               //lstAvail.options[lstAvail.length] = varOpt;
               // delete the option
               lstApply.options[i] = null;
            }
         }
      }
   }
}
function PFWAdd() {
   with ( document.portfwAdvance ) {
      var arrSelected = new Array();
      var count = 0;
      var y = 0;
      for ( i = 0; i < lstAvail.options.length; i++ ) {
             if ( lstAvail.options[i].selected == true && lstApply.options.length == 0 ) {
                  arrSelected[count] = lstAvail.options[i].value;
                  count++;
            }
      }
      var x = 0;
      for (i = 0; i < lstAvail.options.length; i++) {
         for (x = 0; x < arrSelected.length; x++) {
            if (lstAvail.options[i].value == arrSelected[x]) {
               varOpt = new Option(lstAvail.options[i].text, lstAvail.options[i].value);
               lstApply.options[lstApply.length] = varOpt;
               // delete the option
               //lstAvail.options[i] = null;
            }
         }
      }
   }
}
function PFWApply() {
   //document.portfwAdvance.ruleApply.value="";    
   if (document.portfwAdvance.ip.value=="") {
 alert("<% multilang("2236" "LANG_LOCAL_IP_ADDRESS_CANNOT_BE_EMPTY"); %>");
 document.portfwAdvance.ip.focus();
 return false;
   }
   if (!checkHostIP(document.portfwAdvance.ip, 1))
 return false;
   if (document.portfwAdvance.lstApply.options.length == 0) {
 alert("<% multilang("2237" "LANG_RULE_CANNOT_BE_EMPTY_PLEASE_CHOOSE_ONE_GATEGORY_AND_SELECT_ONE_AVAILABLE_RULE_THEN_ADD_INTO_APPLIED_RULE"); %>");
 return false;
   }
   with ( document.portfwAdvance ) {
      for (i = 0; i < lstApply.options.length; i++)
         ruleApply.value+=lstApply.options[i].value + ',';
      //for (i = 0; i < lstAvail.options.length; i++)
      //   itfsAvail.value+=lstAvail.options[i].value + ',';
   }
   return true;
}
function postPFW(apply, applyval, avail, availval) {
   var interfaces;
   with ( document.portfwAdvance ) {
      interfaces = apply.split(',');
      itfvals = applyval.split(',');
      // clear a select box
      lstApply.options.length = 0;
      for ( i = 0; i < interfaces.length; i++ ) {
         if (interfaces[i] != '') {
            // create a new option
            lstApply.options[i] = new Option(interfaces[i], itfvals[i]);
         }
      }
      interfaces = avail.split(',');
      itfvals = availval.split(',');
       // clear a select box
      lstAvail.options.length = 0;
      for ( i = 0; i < interfaces.length; i++ ) {
         if (interfaces[i] != '') {
             // create a new option
            lstAvail.options[i] = new Option(interfaces[i], itfvals[i]);
         }
      }
   }
}
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("18" "LANG_PORT_FORWARDING"); %> - <% multilang("8" "LANG_ADVANCED_SETTINGS"); %></font></h2>
<form action=/boaform/formPFWAdvance method=POST name="portfwAdvance">
   <table border=0 width="500" cellspacing=4 cellpadding=0>
      <hr size=2 noshade align=top>
      <tr>
          <td><font size=2><b><% multilang("776" "LANG_CATEGORY"); %>: </b>
              <input type="radio" name=gategory value=0 onClick="postPFW('', '', 'PPTP,L2TP', '0,1')"><% multilang("16" "LANG_VPN"); %>&nbsp;&nbsp;
          </td>
      </tr>
   </table>
   <table border=0 width="500" cellspacing=4 cellpadding=0>
      <hr size=2 noshade align=top>
      <tr>
       <td><font size=2><b><% multilang("52" "LANG_INTERFACE"); %>:</b>
    <select name="interface">
     <% if_wan_list("rt-any"); %>
    </select>
    <input type="hidden" value="" name="select_id">
       </td>
      </tr>
      <br>
      <tr>
       <td><font size=2><b><% multilang("241" "LANG_LOCAL"); %> <% multilang("69" "LANG_IP_ADDRESS"); %>:</b>
    <input type="text" name="ip" size="15" maxlength="15">
       </td>
      </tr>
   </table>
   <table border=0 width="500" cellspacing=4 cellpadding=0>
      <hr size=2 noshade align=top>
      <tr>
         <td width="150"><font size=2><b><% multilang("777" "LANG_AVAILABLE_RULES"); %></b></td>
         <td width="100"></td>
         <td width="150"><font size=2><b><% multilang("778" "LANG_APPLIED_RULES"); %></b></td>
      </tr>
      <tr>
         <td>
             <select multiple name="lstAvail" size="8" style="width: 100"></select>
         </td>
         <td>
            <table border="0" cellpadding="0" cellspacing="5">
               <tr><td>
                  <input type="button" name="rmbtn" value="->" onClick="PFWAdd()" style="width: 30; height: 30">
               </td></tr>
               <tr><td>
                  <input type="button" name="adbtn" value="<-" onClick="PFWRemove()" style="width: 30; height: 30">
               </td></tr>
            </table>
         </td>
         <td>
             <select multiple name="lstApply" size="8" style="width: 100"></select>
         </td>
    </table>
    <br>
    <tr>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      <input type=submit value="<% multilang("180" "LANG_ADD"); %>" name="save" onClick="return PFWApply()">&nbsp;&nbsp;
    </tr>
   <table border=0 width="500" cellspacing=4 cellpadding=0>
    <tr><hr size=1 noshade align=top></tr>
    <tr><font size=2><b><% multilang("779" "LANG_PORT_FORWARDING_ADVANCE_TABLE"); %>:</b></font></tr>
    <% showPFWAdvTable(); %>
   </table>
   <br>
   <input type="hidden" name=ruleApply>
   <!--<input type="hidden" name=itfsAvail>-->
   <input type="hidden" value="/portfw-advance.asp" name="submit-url">
   <input type="submit" value="<% multilang("183" "LANG_DELETE_SELECTED"); %>" name="delRule">&nbsp;&nbsp;
   <input type="submit" value="<% multilang("184" "LANG_DELETE_ALL"); %>" name="delAllRule" onClick="return deleteAllClick()">&nbsp;&nbsp;&nbsp;
<script>
 document.portfwAdvance.gategory[0].checked = false;
</script>
</form>
</blockquote>
</body>
</html>

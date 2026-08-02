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
<title><% multilang("607" "LANG_VERSION"); %> </title>
<script type="text/javascript" src="share.js">
</script>
<script>
function sendClicked()
{
        if (document.password.binary.value=="") {
                alert("<% multilang("2130" "LANG_SELECTED_FILE_CANNOT_BE_EMPTY"); %>");
                document.password.binary.focus();
                return false;
        }
        if (!confirm('<% multilang("480" "LANG_PAGE_DESC_UPGRADE_CONFIRM"); %>'))
                return false;
        else
                return true;
}
function uploadClick()
{
    if (document.saveConfig.binary.value.length == 0) {
  alert('<% multilang("461" "LANG_CHOOSE_FILE"); %>!');
  document.saveConfig.binary.focus();
  return false;
 }
 return true;
}
function exportClick()
{
 alert('<% multilang("998" "LANG_PAGE_DESC_WAIT_INFO"); %>!');
 return true;
}
</script>
<STYLE type=text/css>
@import url(/style/default.css);
</STYLE>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0" alink="#000000" link="#000000" vlink="#000000">
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px">
<form action=/boaform/formVersionMod method=POST name="vermod">
 <h2><font color="#0000FF"><% multilang("607" "LANG_VERSION"); %></font></h2>
  <table cellpadding="0px" cellspacing="2px">
  <tr>
      <td width="150px">Manufacturer:</td>
      <td><input type="text" name="txt_mft" size="50" maxlength="50" value=<% getInfo("rtk_manufacturer"); %>>(ZTE)</td>
  </tr>
  <tr>
      <td width="150px">OUI:</td>
      <td><input type="text" name="txt_oui" size="50" maxlength="50" value=<% getInfo("rtk_oui"); %>>(5422F8)</td>
  </tr>
  <tr>
      <td width="150px">Product Class:</td>
      <td><input type="text" name="txt_proclass" size="50" maxlength="50" value=<% getInfo("rtk_productclass"); %>>(F660)</td>
  </tr>
    <tr>
      <td width="150px">Hardware Serial Number:</td>
      <td><input type="text" name="txt_serialno" size="50" maxlength="50" value=<% getInfo("rtk_serialno"); %>>(000000000002)</td>
  </tr>
    <tr>
      <td width="150px">Provisioning Code:</td>
      <td><input type="text" name="txt_provisioningcode" size="50" maxlength="50" value=<% getInfo("cwmp_provisioningcode"); %>>(TLCO.GRP2)</td>
  </tr>
  <tr>
      <td width="150px">Spec. <% multilang("607" "LANG_VERSION"); %></td>
      <td><input type="text" name="txt_specver" size="50" maxlength="50" value=<% getInfo("rtk_specver"); %>>(1.0)</td>
  </tr>
  <tr>
      <td width="150px">Software <% multilang("607" "LANG_VERSION"); %></td>
      <td><input type="text" name="txt_swver" size="50" maxlength="50" value=<% getInfo("rtk_swver"); %>>(V2.30.10P16T2S)</td>
  </tr>
  <tr>
      <td width="150px">Hardware <% multilang("607" "LANG_VERSION"); %></td>
      <td><input type="text" name="txt_hwver" size="50" maxlength="50" value=<% getInfo("rtk_hwver"); %>>(V3.0)</td>
  </tr>
  <tr>
      <td width="150px">GPON Serial Number</td>
      <td><input type="text" name="txt_gponsn" size="13" maxlength="13" value=<% getInfo("gpon_sn"); %>></td>
  </tr>
   <tr>
      <td width="150px">ELAN MAC Address</td>
      <td><input type="text" name="txt_elanmac" size="12" maxlength="12" value=<% getInfo("elan_mac_addr"); %>></td>
  </tr>
 </table>
      <input type="submit" value="Save" name="save" onClick="return saveChanges()">&nbsp;&nbsp;
      <!--input type="reset" value="Undo" name="reset" onClick="resetClick()"-->
      <input type="hidden" value="/vermod.asp" name="submit-url">
 </form>
 </DIV>
</blockquote>
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px">
<h2><font color="#0000FF"><% multilang("50" "LANG_FIRMWARE_UPGRADE"); %></font></h2>
<form action=/boaform/admin/formUpload method=POST enctype="multipart/form-data" name="password">
<table border="0" cellspacing="4" width="500">
 <tr><td><font size=2>
 <% multilang("475" "LANG_PAGE_DESC_UPGRADE_FIRMWARE"); %> </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border="0" cellspacing="4" width="500">
  <tr>
      <td><font size=2><input type="file" value="<% multilang("461" "LANG_CHOOSE_FILE"); %>" name="binary" size=20></td>
  </tr>
  </table>
    <p> <input type="submit" value="<% multilang("476" "LANG_UPGRADE"); %>" name="send" onclick="return sendClicked()">&nbsp;&nbsp;
        <input type="reset" value="<% multilang("181" "LANG_RESET"); %>" name="reset">
    </p>
 </form>
  </DIV>
 </blockquote>
<blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px">
<h2><font color="#0000FF"><% multilang("997" "LANG_OMCI"); %></font></h2>
  <form action=/boaform/formExportOMCIlog method=POST name="exportOMCIlog">
  <tr>
    <td width="40%"><font size=2><b><% multilang("995" "LANG_EXPORT"); %>:</b></font></td>
    <td width="30%"><font size=2>
      <input type="submit" value="<% multilang("995" "LANG_EXPORT"); %>" name="save_cs" onclick="return exportClick()">
    </font></tr>
  </form>
</DIV>
</blockquote>
 <blockquote>
<DIV align="left" style="padding-left:20px; padding-top:5px">
  <form action=/boaform/formImportOMCIShell enctype="multipart/form-data" method=POST name="saveConfig">
  <tr>
    <td width="40%"><font size=2><b><% multilang("996" "LANG_IMPORT"); %>:</b></font></td>
    <td width="30%"><font size=2><input type="file" value="<% multilang("461" "LANG_CHOOSE_FILE"); %>" name="binary" size=24></font></td>
    <td width="20%"><font size=2><input type="submit" value="<% multilang("996" "LANG_IMPORT"); %>" name="load" onclick="return uploadClick()"></font></td>
  </tr>
  </form>
</DIV>
</blockquote>
</body>
</html>

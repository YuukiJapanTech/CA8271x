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
<title><% checkWrite("adsl_set_title"); %></title>
<SCRIPT>
function dhcpTblClick(url) {
 openWindow(url, 'DHCPTbl' );
}
function adsltoneClick(url)
{
 var wide=600;
 var high=400;
 if (document.all)
  var xMax = screen.width, yMax = screen.height;
 else if (document.layers)
  var xMax = window.outerWidth, yMax = window.outerHeight;
 else
    var xMax = 640, yMax=480;
 var xOffset = (xMax - wide)/2;
 var yOffset = (yMax - high)/3;
 var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';
 window.open( url, 'ADSLTONETbl', settings );
}
function saveChanges()
{
 if (document.set_adsl.glite.checked == false
    && document.set_adsl.gdmt.checked == false
    && document.set_adsl.t1413.checked == false
    && document.set_adsl.adsl2.checked == false
<% initPage("vdsl2_check"); %>
    && document.set_adsl.adsl2p.checked == false) {
  alert("ADSL modulation cannot be empty.");
  return false;
 }
<% initPage("vdsl2_check_profile"); %>
 return true;
}
<% initPage("vdsl2_updatefn"); %>
</SCRIPT>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% checkWrite("adsl_set_title"); %></font></h2>
<form action=/boaform/formSetAdsl method=POST name=set_adsl>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr><td><font size=2>
   <% multilang("632" "LANG_THIS_PAGE_IS_USED_TO_CONFIGURE_THE_PARAMETERS_FOR_THE_BANDS_OF_YOUR_DEVICE"); %>
 </font></td></tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<table border=0 width=500 cellspacing=4 cellpadding=0>
<tr>
 <th align=left width=30%><font size=2><% checkWrite("xdsl_type"); %> <% multilang("633" "LANG_MODULATION"); %>:</th>
 <td width=70%></td>
</tr>
<tr <% checkWrite("anxb-cap"); %>>
 <th></th>
 <td><font size=2><input type=checkbox name=glite value=1>G.Lite</td>
</tr>
<tr>
 <th></th>
 <td><font size=2><input type=checkbox name=gdmt value=1>G.Dmt</td>
</tr>
<tr <% checkWrite("anxb-cap"); %>>
 <th></th>
 <td><font size=2><input type=checkbox name=t1413 value=1>T1.413</td>
</tr>
<tr>
 <th></th>
 <td><font size=2><input type=checkbox name=adsl2 value=1>ADSL2</td>
</tr>
<tr>
 <th></th>
 <td><font size=2><input type=checkbox name=adsl2p value=1>ADSL2+</td>
</tr>
<% initPage("vdsl2_opt"); %>
<tr <% checkWrite("anxb-cap"); %>>
 <th align=left width=30%><font size=2>AnnexL <% multilang("634" "LANG_OPTION"); %>:</th>
 <td width=70%><font size=2>(<% multilang("635" "LANG_NOTE_ONLY_ADSL_2_S_UPPORTS_ANNEXL"); %>)</td>
</tr>
<tr <% checkWrite("anxb-cap"); %>>
 <th></th>
 <td><font size=2><input type=checkbox name=anxl value=1><% multilang("145" "LANG_ENABLED"); %></td>
</tr>
<tr <% checkWrite("anxb-cap"); %>>
 <th align=left width=30%><font size=2>AnnexM <% multilang("634" "LANG_OPTION"); %>:</th>
 <td width=70%><font size=2>(<% multilang("636" "LANG_NOTE_ONLY_ADSL_2_2_SUPPORT_ANNEXM"); %>)</td>
</tr>
<tr <% checkWrite("anxb-cap"); %>>
 <th></th>
 <td><font size=2><input type=checkbox name=anxm value=1><% multilang("145" "LANG_ENABLED"); %></td>
</tr>
<tr <% checkWrite("ginp-cap"); %>>
 <th align=left width=30%><font size=2>G.INP <% multilang("634" "LANG_OPTION"); %>:</font></th>
 <td></td>
</tr>
<tr <% checkWrite("ginp-cap"); %>>
 <th></th>
 <td><font size=2><input type=checkbox name=ginp value=1><% multilang("145" "LANG_ENABLED"); %></font></td>
</tr>
<% initPage("vdsl2_profile"); %>
<tr>
 <th align=left><font size=2>ADSL <% multilang("482" "LANG_CAPABILITY"); %>:</th>
 <td></td>
</tr>
<tr>
 <th></th>
 <td><font size=2><input type=checkbox name=bswap value=1><% multilang("145" "LANG_ENABLED"); %> Bitswap</td>
</tr>
<tr>
 <th></th>
 <td><font size=2><input type=checkbox name=sra value=1><% multilang("145" "LANG_ENABLED"); %> SRA</td>
</tr>
<% initPage("adsl_tone_mask"); %>
<% initPage("adsl_psd_mask"); %>
<% initPage("psd_msm_mode"); %>
</table>
  <br>
 <input type=submit value="<% multilang("119" "LANG_APPLY_CHANGES"); %>" name="save" onClick="return saveChanges()">
 <input type=hidden value="/admin/adsl-set.asp" name="submit-url">
<script>
 <% initPage("setdsl"); %>
</script>
</form>
</blockquote>
</body>
</html>

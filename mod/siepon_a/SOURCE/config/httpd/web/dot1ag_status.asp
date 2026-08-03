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
<meta http-equiv="refresh" content="10" >
<title><% multilang("1066" "LANG_CFM_802_1AG_STATUS"); %></title>
<script type="text/javascript" src="share.js">
</script>
<script>
<% dot1ag_status_init() %>
function show_table()
{
 var table = document.getElementById("mep_tbl");
 for(var i = 0 ; i < meps.length ; i++)
 {
  var cell;
  var row = table.insertRow(-1);
  for(var j=0 ; j < 7 ; j++)
  {
   cell = row.insertCell(j);
   cell.setAttribute("align", "center");
   cell.setAttribute("bgColor", "#C0C0C0");
   var tmp = "<font size = 2>";
   switch(j)
   {
   case 0:
    tmp += meps[i].interface;
    break;
   case 1:
    tmp += meps[i].status;
    break;
   case 2:
    tmp += meps[i].md_name;
    break;
   case 3:
    tmp += meps[i].ma_name;
    break;
   case 4:
    tmp += meps[i].mep_id;
    break;
   case 5:
    tmp += meps[i].mac;
    break;
   }
   cell.innerHTML = tmp;
  }
 }
}
</script>
</head>
<body onLoad="show_table();">
<blockquote>
<h2><font color="#0000FF"><% multilang("1066" "LANG_CFM_802_1AG_STATUS"); %></font></h2>
<font size=2><b><% multilang("1067" "LANG_REMOTE_MEP"); %>:</b></font>
<table id="mep_tbl" border=0 width="600" cellspacing=4 cellpadding=0>
<tr><font size=1>
 <th align=center bgColor="#808080"><% multilang("52" "LANG_INTERFACE"); %></th>
 <th align=center bgColor="#808080"><% multilang("3" "LANG_STATUS"); %></th>
 <th align=center bgColor="#808080"><% multilang("1068" "LANG_MD_NAME"); %></th>
 <th align=center bgColor="#808080"><% multilang("1069" "LANG_MA_NAME"); %></th>
 <th align=center bgColor="#808080"><% multilang("1070" "LANG_REMOTE_MEP_ID"); %></th>
 <th align=center bgColor="#808080"><% multilang("1071" "LANG_SRC_MAC_ADDRESS"); %></th>
</font></tr>
</table>
</body>
</html>
<SCRIPT>

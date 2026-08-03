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
<script src="md5.js" type="text/javascript"></script>
<SCRIPT>
function setpass()
{
 <% passwd2xmit(); %>
}
</SCRIPT>
</head>
<body>
<blockquote>
<form action=/boaform/admin/formLogin method=POST name="cmlogin">
<input type="hidden" name="challenge">
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR vAlign=top>
    <TD width="50%"><A><IMG height=60 src="LoginFiles/realtek.jpg" width=170 useMap=#n1E6.$Body.0.1E8 border=0></A></TD>
  </TR>
  </TBODY>
</TABLE>
<CENTER>
  <TABLE cellSpacing=0 cellPadding=0 border=0>
    <TBODY>
      <TR vAlign=top>
        <TD width=350><BR>
          <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
            <TBODY>
              <TR vAlign=top>
                <TD vAlign=center width="29%"><DIV align=right><IMG height=32 src="LoginFiles/locker.gif" width=32><BR><BR></DIV></TD>
                <TD vAlign=center width="5%"></TD>
                <TD vAlign=center width="71%"><FONT color=#0000FF size=2><% multilang("714" "LANG_INPUT_USERNAME_AND_PASSWORD"); %></FONT><BR><BR></TD>
       </TR>
              <TR vAlign=top>
                <TD vAlign=center width="29%"><DIV align=right><FONT color=#0000FF size=2><% multilang("736" "LANG_USER"); %><% multilang("604" "LANG_NAME"); %>:</FONT></DIV></TD>
                <TD vAlign=center width="5%"></TD>
                <TD vAlign=center width="71%"><FONT><INPUT maxLength=30 size=20 name=username></FONT></TD>
              </TR>
              <TR vAlign=top>
                <TD vAlign=center width="29%"><DIV align=right><FONT color=#0000FF size=2><% multilang("49" "LANG_PASSWORD"); %>:</FONT></DIV></TD>
                <TD vAlign=center width="5%"></TD>
                <TD vAlign=center width="71%"><FONT><INPUT type=password maxLength=30 size=20 name=password></FONT></TD>
       </TR>
              <TR vAlign=top>
         <% checkWrite("loginSelinit"); %>
       </TR>
              <TR vAlign=top>
                <TD vAlign=center width="29%"></TD>
                <TD vAlign=center width="5%"></TD>
                <TD vAlign=center width="71%"><FONT size=2></FONT><BR><INPUT type=submit value="<% multilang("715" "LANG_LOGIN"); %>" name=save onClick=setpass()></TD>
       </TR>
            </TBODY>
   </TABLE>
        </TD>
      </TR>
    </TBODY>
  </TABLE>
</CENTER>
<DIV align=center></DIV>
<input type="hidden" value="/admin/login.asp" name="submit-url">
</form>
</blockquote>
</BODY>
</HTML>

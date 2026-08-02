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
<!--<META HTTP-EQUIV=Refresh CONTENT="10; URL=vtuo-stats.asp">-->
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>VTU-O DSL Statistics</title>
<SCRIPT>
var reload_page;
var btn_reload_stat=0;
function vtuo_stat_reload_cb()
{
 location.assign('/admin/vtuo-stats.asp');
}
function vtuo_stat_reload_start()
{
 btn_reload_stat=1;
 document.set_vtuo_st.btn_reload.value="Stop Auto-Refresh"
 reload_page=setTimeout("vtuo_stat_reload_cb()",10000);
}
function vtuo_stat_reload()
{
 if(btn_reload_stat)
 {
  btn_reload_stat=0;
  document.set_vtuo_st.btn_reload.value="Start Auto-Refresh"
  clearTimeout(reload_page);
 }else{
  vtuo_stat_reload_cb();
 }
}
</SCRIPT>
</head>
<body onload="vtuo_stat_reload_start()">
<blockquote>
<h2><font color="#0000FF">VTU-O DSL Statistics</font></h2>
<form action=/boaform/formSetVTUO method=POST name=set_vtuo_st>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr>
  <td align=right>
  <input type=button name="btn_reload" value="" onclick="vtuo_stat_reload();">
  </td>
 </tr>
 <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<h4>1. Port Info</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
<!-- <tr>
  <th width=30% align=left bgcolor=#c0c0c0><font size=2>Name</th>
  <td bgcolor=#f0f0f0></td>
 </tr>
-->
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>DSL Standard</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-pmd-mode"); %></td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Band Plan</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-link-type"); %></td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>DSL Link State</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-state"); %></td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Up Time</th>
  <td bgcolor=#f0f0f0><% DSLuptime(); %></td>
 </tr>
<!--
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Actual Template</th>
  <td bgcolor=#f0f0f0></td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Init Result</th>
  <td bgcolor=#f0f0f0></td>
 </tr>
-->
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>DS Mask</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-limit-mask"); %></td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>US0 Mask</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-us0-mask"); %></td>
 </tr>
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Electrical Length (dB)</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-upbokle-us"); %></td>
 </tr>
 <!--
 <tr>
  <th align=left bgcolor=#c0c0c0><font size=2>Cyclic Extension</th>
  <td bgcolor=#f0f0f0><% getInfo("adsl-drv-actualce"); %></td>
 </tr>
 -->
</table>
<br><br>
<h4>2. VDSL Status</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0></th>
  <th>Downstream</th>
  <th>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Attainable net data rate (Kbps)</th>
  <td><% getInfo("adsl-drv-attrate-ds"); %></td>
  <td><% getInfo("adsl-drv-attrate-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SNR Margin (dB)</th>
  <td><% getInfo("adsl-drv-snr-ds"); %></td>
  <td><% getInfo("adsl-drv-snr-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Signal Attenuation (dB)</th>
  <td><% getInfo("adsl-drv-signal-atn-ds"); %></td>
  <td><% getInfo("adsl-drv-signal-atn-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Line Attenuation (dB)</th>
  <td><% getInfo("adsl-drv-line-atn-ds"); %></td>
  <td><% getInfo("adsl-drv-line-atn-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Transmit Power (dBm)</th>
  <td><% getInfo("adsl-drv-power-ds"); %></td>
  <td><% getInfo("adsl-drv-power-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Trellis</th>
  <td><% getInfo("adsl-drv-trellis-ds"); %></td>
  <td><% getInfo("adsl-drv-trellis-us"); %></td>
 </tr>
<!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SNR Mode</th>
  <td></td>
  <td></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Last State</th>
  <td></td>
  <td></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Current State</th>
  <td></td>
  <td></td>
 </tr>
-->
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Actual net data rate (Kbps)</th>
  <td><% getInfo("adsl-drv-rate-ds"); %></td>
  <td><% getInfo("adsl-drv-rate-us"); %></td>
 </tr>
 <!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Prev net data rate (Kbps)</th>
  <td><% getInfo("adsl-drv-lnk-llds"); %></td>
  <td><% getInfo("adsl-drv-lnk-llus"); %></td>
 </tr>
 -->
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Actual Delay (msec)</th>
  <td><% getInfo("adsl-drv-pms-delay-ds"); %></td>
  <td><% getInfo("adsl-drv-pms-delay-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Actual INP (symbol)</th>
  <td><% getInfo("adsl-drv-inp-ds"); %></td>
  <td><% getInfo("adsl-drv-inp-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Receive Power (dBm)</th>
  <td><% getInfo("adsl-drv-rx-power-ds"); %></td>
  <td><% getInfo("adsl-drv-rx-power-us"); %></td>
 </tr>
<!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>INP Report</th>
  <td></td>
  <td></td>
 </tr>
-->
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Np</th>
  <td><% getInfo("adsl-drv-n-ds"); %></td>
  <td><% getInfo("adsl-drv-n-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Rp</th>
  <td><% getInfo("adsl-drv-pms-r-ds"); %></td>
  <td><% getInfo("adsl-drv-pms-r-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Lp</th>
  <td><% getInfo("adsl-drv-l-ds"); %></td>
  <td><% getInfo("adsl-drv-l-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Dp</th>
  <td><% getInfo("adsl-drv-pms-d-ds"); %></td>
  <td><% getInfo("adsl-drv-pms-d-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Ip</th>
  <td><% getInfo("adsl-drv-pmspara-i-ds"); %></td>
  <td><% getInfo("adsl-drv-pmspara-i-us"); %></td>
 </tr>
 <!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Actual Latency Path</th>
  <td><% getInfo("adsl-drv-data-lpid-ds"); %></td>
  <td><% getInfo("adsl-drv-data-lpid-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>PTM Status</th>
  <td><% getInfo("adsl-drv-ptm-status"); %></td>
  <td><% getInfo("adsl-drv-ptm-status"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Actual RA Mode</th>
  <td><% getInfo("adsl-drv-ra-mode-ds"); %></td>
  <td><% getInfo("adsl-drv-ra-mode-us"); %></td>
 </tr>
 -->
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>G.INP Mode</th>
  <td><% getInfo("adsl-drv-ginp-ds"); %></td>
  <td><% getInfo("adsl-drv-ginp-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>G.INP OH Rate (Kbps)</th>
  <td><% getInfo("adsl-drv-retx-ohrate-ds"); %></td>
  <td><% getInfo("adsl-drv-retx-ohrate-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>G.INP Framing Type</th>
  <td><% getInfo("adsl-drv-retx-fram-type-ds"); %></td>
  <td><% getInfo("adsl-drv-retx-fram-type-us"); %></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>G.INP INP_act_REIN (symbol)</th>
  <td><% getInfo("adsl-drv-retx-actinp-rein-ds"); %></td>
  <td><% getInfo("adsl-drv-retx-actinp-rein-us"); %></td>
 </tr>
 <!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>RS CW per DTU</th>
  <td><% getInfo("adsl-drv-retx-h-ds"); %></td>
  <td><% getInfo("adsl-drv-retx-h-us"); %></td>
 </tr>
 -->
</table>
<br><br>
<h4>3. VDSL Band</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0></th>
  <th>US0</th><th>US1</th><th>US2</th><th>US3</th><th>US4</th>
  <th>DS1</th><th>DS2</th><th>DS3</th><th>DS4</th>
 </tr>
<% vtuo_checkWrite("stat-band"); %>
</table>
<br><br>
<h4>4. DSL PM Counters</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <% vtuo_checkWrite("stat-perform"); %>
</table>
<br><br>
<h4>5. VDSL Performance History</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <td>* <a href="/boaform/formSetVTUO?StatusPage=15min" target="_blank">15 Min Interval</a></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <td>* <a href="/boaform/formSetVTUO?StatusPage=oneday" target="_blank">One Day Interval</a></td>
 </tr>
</table>
<br><br>
<h4>6. VDSL sub-carrier status</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2></th>
  <td>Downstream</td>
  <td>Upstream</td>
 </tr>
 <!--
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>HLOG</th>
  <td><a href="/boaform/formSetVTUO?StatusPage=hlog_ds" target="_blank">Show</a></td>
  <td><a href="/boaform/formSetVTUO?StatusPage=hlog_us" target="_blank">Show</a></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>QLN</th>
  <td><a href="/boaform/formSetVTUO?StatusPage=qln_ds" target="_blank">Show</a></td>
  <td><a href="/boaform/formSetVTUO?StatusPage=qln_us" target="_blank">Show</a></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>SNR</th>
  <td><a href="/boaform/formSetVTUO?StatusPage=snr_ds" target="_blank">Show</a></td>
  <td><a href="/boaform/formSetVTUO?StatusPage=snr_us" target="_blank">Show</a></td>
 </tr>
 -->
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Bi Table</th>
  <td><a href="/boaform/formSetVTUO?StatusPage=bit_ds" target="_blank">Show</a></td>
  <td><a href="/boaform/formSetVTUO?StatusPage=bit_us" target="_blank">Show</a></td>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th align=left bgcolor=#c0c0c0><font size=2>Gi Table</th>
  <td><a href="/boaform/formSetVTUO?StatusPage=gain_ds" target="_blank">Show</a></td>
  <td><a href="/boaform/formSetVTUO?StatusPage=gain_us" target="_blank">Show</a></td>
 </tr>
</table>
<br><br>
<!--
<h4>7. MEDLEY PSD</h4>
<table border=0 width=500 cellspacing=4 cellpadding=0>
 <tr bgcolor=#f0f0f0>
  <th colspan=3 bgcolor=#c0c0c0>Downstream</th>
  <th colspan=3 bgcolor=#c0c0c0>Upstream</th>
 </tr>
 <tr bgcolor=#f0f0f0>
  <th bgcolor=#c0c0c0>Break<br>Point</th>
  <th bgcolor=#c0c0c0>Tone Index</th>
  <th bgcolor=#c0c0c0>PSD Level<br>(dBm/Hz)</th>
  <th bgcolor=#c0c0c0>Break<br>Point</th>
  <th bgcolor=#c0c0c0>Tone Index</th>
  <th bgcolor=#c0c0c0>PSD Level<br>(dBm/Hz)</th>
 </tr>
 <% vtuo_checkWrite("stat-medley-psd"); %>
</table>
-->
</form>
<br><br>
</blockquote>
</body>
</html>

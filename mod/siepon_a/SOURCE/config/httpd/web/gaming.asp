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
<html><head><meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title><% multilang("23" "LANG_PORT_TRIGGERING"); %><% multilang("197" "LANG_CONFIGURATION"); %></title></head>
<script type="text/javascript" src="share.js"></script>
<script language=javascript>
 function addClick()
 {
   if (formname.ip.value=="") {
  alert('<% multilang("2117" "LANG_IP_ADDRESS_CANNOT_BE_EMPTY"); %>');
  formname.ip.focus();
  return false;
   }
   if ( validateKey( formname.ip.value ) == 0 ) {
  alert('<% multilang("1614" "LANG_INVALID_IPV4_ADDR_SHOULD_BE_DECIMAL_NUM"); %>');
  formname.ip.focus();
  return false;
   }
   if ( !checkDigitRange(formname.ip.value,1,0,255) ) {
  alert('<% multilang("2118" "LANG_INVALID_IP_ADDRESS_RANGE_IN_1ST_DIGIT"); %>');
  formname.ip.focus();
  return false;
   }
   if ( !checkDigitRange(formname.ip.value,2,0,255) ) {
  alert('<% multilang("2119" "LANG_INVALID_IP_ADDRESS_RANGE_IN_2ND_DIGIT"); %>');
  formname.ip.focus();
  return false;
   }
   if ( !checkDigitRange(formname.ip.value,3,0,255) ) {
        alert('<% multilang("2120" "LANG_INVALID_IP_ADDRESS_RANGE_IN_3RD_DIGIT"); %>');
  formname.ip.focus();
  return false;
   }
   if ( !checkDigitRange(formname.ip.value,4,1,254) ) {
        alert('<% multilang("2121" "LANG_INVALID_IP_ADDRESS_RANGE_IN_4TH_DIGIT"); %>');
  formname.ip.focus();
  return false;
   }
    return true;
 }
 function formLoad()
 {
  formname.gamelist.options[0] = new Option ("<% multilang("545" "LANG_SELECT_GAME"); %>", -1);
  formname.gamelist.options[1] = new Option ("Age of Empires", 0);
  formname.gamelist.options[2] = new Option ("Aliens vs. Predator", 2);
  formname.gamelist.options[3] = new Option ("America's Army", 1);
  formname.gamelist.options[4] = new Option ("Asheron's Call", 3);
  formname.gamelist.options[5] = new Option ("Battlefield 1942", 4);
  formname.gamelist.options[6] = new Option ("Battlefield: Vietnam", 5);
  formname.gamelist.options[7] = new Option ("BitTorrent", 63);
  formname.gamelist.options[8] = new Option ("Black and White", 6);
  formname.gamelist.options[9] = new Option ("Call of Duty", 7);
  formname.gamelist.options[10] = new Option ("Command and Conquer Generals", 8);
  formname.gamelist.options[11] = new Option ("Command and Conquer Zero Hour", 9);
  formname.gamelist.options[12] = new Option ("Counter Strike", 10);
  formname.gamelist.options[13] = new Option ("Crimson Skies", 11);
  formname.gamelist.options[14] = new Option ("Dark Reign 2", 12);
  formname.gamelist.options[15] = new Option ("Delta Force", 13);
  formname.gamelist.options[16] = new Option ("Diablo I and II", 14);
  formname.gamelist.options[17] = new Option ("Doom 3", 15);
  formname.gamelist.options[18] = new Option ("Dungeon Siege", 16);
  formname.gamelist.options[19] = new Option ("eDonkey", 65);
  formname.gamelist.options[20] = new Option ("eMule", 67);
  formname.gamelist.options[21] = new Option ("Everquest", 17);
  formname.gamelist.options[22] = new Option ("Far Cry", 18);
  formname.gamelist.options[23] = new Option ("Final Fantasy XI (PC)", 20);
  formname.gamelist.options[24] = new Option ("Final Fantasy XI (PS2)", 21);
  formname.gamelist.options[25] = new Option ("Gamespy Arcade", 76);
  formname.gamelist.options[26] = new Option ("Gamespy Tunnel", 77);
  formname.gamelist.options[27] = new Option ("Ghost Recon", 19);
  formname.gamelist.options[28] = new Option ("Gnutella", 64);
  formname.gamelist.options[29] = new Option ("Half Life", 22);
  formname.gamelist.options[30] = new Option ("Halo: Combat Evolved ", 23);
  formname.gamelist.options[31] = new Option ("Heretic II", 24);
  formname.gamelist.options[32] = new Option ("Hexen II", 25);
  formname.gamelist.options[33] = new Option ("Jedi Knight II: Jedi Outcast ", 26);
  formname.gamelist.options[34] = new Option ("Jedi Knight III: Jedi Academy ", 27);
  formname.gamelist.options[35] = new Option ("KALI", 75);
  formname.gamelist.options[36] = new Option ("Links", 28);
  formname.gamelist.options[37] = new Option ("Medal of Honor: Games", 29);
  formname.gamelist.options[38] = new Option ("MSN Game Zone", 73);
  formname.gamelist.options[39] = new Option ("MSN Game Zone (DX)", 74);
  formname.gamelist.options[40] = new Option ("Myth", 30);
  formname.gamelist.options[41] = new Option ("Need for Speed", 31);
  formname.gamelist.options[42] = new Option ("Need for Speed 3", 33);
  formname.gamelist.options[43] = new Option ("Need for Speed: Hot Pursuit 2", 32);
  formname.gamelist.options[44] = new Option ("Neverwinter Nights", 34);
  formname.gamelist.options[45] = new Option ("PainKiller ", 35);
  formname.gamelist.options[46] = new Option ("Postal 2: Share the Pain ", 36);
  formname.gamelist.options[47] = new Option ("Quake 2", 37);
  formname.gamelist.options[48] = new Option ("Quake 3", 38);
  formname.gamelist.options[49] = new Option ("Rainbow Six", 39);
  formname.gamelist.options[50] = new Option ("Rainbow Six: Raven Shield ", 40);
  formname.gamelist.options[51] = new Option ("Return to Castle Wolfenstein ", 41);
  formname.gamelist.options[52] = new Option ("Rise of Nations", 42);
  formname.gamelist.options[53] = new Option ("Roger Wilco", 78);
  formname.gamelist.options[54] = new Option ("Rogue Spear", 43);
  formname.gamelist.options[55] = new Option ("Serious Sam II", 44);
  formname.gamelist.options[56] = new Option ("Shareaza", 66);
  formname.gamelist.options[57] = new Option ("Silent Hunter II", 46);
  formname.gamelist.options[58] = new Option ("Soldier of Fortune", 47);
  formname.gamelist.options[59] = new Option ("Soldier of Fortune II: Double Helix", 48);
  formname.gamelist.options[60] = new Option ("Splinter Cell: Pandora Tomorrow",45);
  formname.gamelist.options[61] = new Option ("Star Trek: Elite Force II", 51);
  formname.gamelist.options[62] = new Option ("Starcraft", 49);
  formname.gamelist.options[63] = new Option ("Starsiege Tribes", 50);
  formname.gamelist.options[64] = new Option ("Steam", 72);
  formname.gamelist.options[65] = new Option ("TeamSpeak", 79);
  formname.gamelist.options[66] = new Option ("Tiberian Sun", 52);
  formname.gamelist.options[67] = new Option ("Tiger Woods 2K4", 53);
  formname.gamelist.options[68] = new Option ("Ubi.com", 71);
  formname.gamelist.options[69] = new Option ("Ultima", 54);
  formname.gamelist.options[70] = new Option ("Unreal", 55);
  formname.gamelist.options[71] = new Option ("Unreal Tournament", 56);
  formname.gamelist.options[72] = new Option ("Unreal Tournament 2004", 57);
  formname.gamelist.options[73] = new Option ("Vietcong ", 58);
  formname.gamelist.options[74] = new Option ("Warcraft II", 59);
  formname.gamelist.options[75] = new Option ("Warcraft III", 60);
  formname.gamelist.options[76] = new Option ("WinMX", 68);
  formname.gamelist.options[77] = new Option ("Wolfenstein: Enemy Territory ", 61);
  formname.gamelist.options[78] = new Option ("WON Servers", 69);
  formname.gamelist.options[79] = new Option ("World of Warcraft", 62);
  formname.gamelist.options[80] = new Option ("Xbox Live", 70);
 }
 function changeItem()
 {
  games = new Array();
  games[0] = new Object;
  games[0].tcpport = "2302-2400,6073"
  games[0].udpport = "2302-2400,6073"
  games[1] = new Object;
  games[1].tcpport = "20045"
  games[1].udpport = "1716-1718,8777,27900"
  games[2] = new Object;
  games[2].tcpport = "80,2300-2400,8000-8999"
  games[2].udpport = "80,2300-2400,8000-8999"
  games[3] = new Object;
  games[3].tcpport = "9000-9013"
  games[3].udpport = "2001,9000-9013"
  games[4] = new Object;
  games[4].tcpport = ""
  games[4].udpport = "14567,22000,23000-23009,27900,28900"
  games[5] = new Object;
  games[5].tcpport = ""
  games[5].udpport = "4755,23000,22000,27243-27245"
  games[6] = new Object;
  games[6].tcpport = "2611-2612,6500,6667,27900"
  games[6].udpport = "2611-2612,6500,6667,27900"
  games[7] = new Object;
  games[7].tcpport = "28960"
  games[7].udpport = "28960"
  games[8] = new Object;
  games[8].tcpport = "80,6667,28910,29900,29920"
  games[8].udpport = "4321,27900"
  games[9] = new Object;
  games[9].tcpport = "80,6667,28910,29900,29920"
  games[9].udpport = "4321,27900"
  games[10] = new Object;
  games[10].tcpport = "27030-27039"
  games[10].udpport = "1200,27000-27015"
  games[11] = new Object;
  games[11].tcpport = "1121,3040,28801,28805"
  games[11].udpport = ""
  games[12] = new Object;
  games[12].tcpport = "26214"
  games[12].udpport = "26214"
  games[13] = new Object;
  games[13].tcpport = "3100-3999"
  games[13].udpport = "3568"
  games[14] = new Object;
  games[14].tcpport = "6112-6119,4000"
  games[14].udpport = "6112-6119"
  games[15] = new Object;
  games[15].tcpport = ""
  games[15].udpport = "27666"
  games[16] = new Object;
  games[16].tcpport = ""
  games[16].udpport = "6073,2302-2400"
  games[17] = new Object;
  games[17].tcpport = "1024-6000,7000"
  games[17].udpport = "1024-6000,7000"
  games[18] = new Object;
  games[18].tcpport = ""
  games[18].udpport = "49001,49002"
  games[19] = new Object;
  games[19].tcpport = "2346-2348"
  games[19].udpport = "2346-2348"
  games[20] = new Object;
  games[20].tcpport = "25,80,110,443,50000-65535"
  games[20].udpport = "50000-65535"
  games[21] = new Object;
  games[21].tcpport = "1024-65535"
  games[21].udpport = "50000-65535"
  games[22] = new Object;
  games[22].tcpport = "6003, 7002"
  games[22].udpport = "27005,27010,27011,27015"
  games[23] = new Object;
  games[23].tcpport = ""
  games[23].udpport = "2302,2303"
  games[24] = new Object;
  games[24].tcpport = "28910"
  games[24].udpport = "28910"
  games[25] = new Object;
  games[25].tcpport = "26900"
  games[25].udpport = "26900"
  games[26] = new Object;
  games[26].tcpport = ""
  games[26].udpport = "28060,28061,28062,28070-28081"
  games[27] = new Object;
  games[27].tcpport = ""
  games[27].udpport = "28060,28061,28062,28070-28081"
  games[28] = new Object;
  games[28].tcpport = "2300-2400,47624"
  games[28].udpport = "2300-2400,6073"
  games[29] = new Object;
  games[29].tcpport = "12203-12204"
  games[29].udpport = ""
  games[30] = new Object;
  games[30].tcpport = "3453"
  games[30].udpport = "3453"
  games[31] = new Object;
  games[31].tcpport = "9442"
  games[31].udpport = "9442"
  games[32] = new Object;
  games[32].tcpport = "8511,28900"
  games[32].udpport = "1230,8512,27900,61200-61230"
  games[33] = new Object;
  games[33].tcpport = "1030"
  games[33].udpport = "1030"
  games[34] = new Object;
  games[34].tcpport = ""
  games[34].udpport = "5120-5300,6500,27900,28900"
  games[35] = new Object;
  games[35].tcpport = ""
  games[35].udpport = "3455"
  games[36] = new Object;
  games[36].tcpport = "80"
  games[36].udpport = "7777-7779,27900,28900"
  games[37] = new Object;
  games[37].tcpport = "27910"
  games[37].udpport = "27910"
  games[38] = new Object;
  games[38].tcpport = "27660"
  games[38].udpport = "27660"
  games[39] = new Object;
  games[39].tcpport = "2346"
  games[39].udpport = "2346"
  games[40] = new Object;
  games[40].tcpport = ""
  games[40].udpport = "7777-7787,8777-8787"
  games[41] = new Object;
  games[41].tcpport = ""
  games[41].udpport = "27950,27960,27965,27952"
  games[42] = new Object;
  games[42].tcpport = ""
  games[42].udpport = "34987"
  games[43] = new Object;
  games[43].tcpport = "2346"
  games[43].udpport = "2346"
  games[44] = new Object;
  games[44].tcpport = "25600-25605"
  games[44].udpport = "25600-25605"
  games[45] = new Object;
  games[45].tcpport = "40000-43000"
  games[45].udpport = "44000-45001,7776,8888"
  games[46] = new Object;
  games[46].tcpport = "3000"
  games[46].udpport = "3000"
  games[47] = new Object;
  games[47].tcpport = ""
  games[47].udpport = "28901,28910,38900-38910,22100-23000"
  games[48] = new Object;
  games[48].tcpport = ""
  games[48].udpport = "20100-20112"
  games[49] = new Object;
  games[49].tcpport = "6112-6119,4000"
  games[49].udpport = "6112-6119"
  games[50] = new Object;
  games[50].tcpport = ""
  games[50].udpport = "27999,28000"
  games[51] = new Object;
  games[51].tcpport = ""
  games[51].udpport = "29250,29256"
  games[52] = new Object;
  games[52].tcpport = "1140-1234,4000"
  games[52].udpport = "1140-1234,4000"
  games[53] = new Object;
  games[53].tcpport = "80,443,1791-1792,13500,20801-20900,32768-65535"
  games[53].udpport = "80,443,1791-1792,13500,20801-20900,32768-65535"
  games[54] = new Object;
  games[54].tcpport = "5001-5010,7775-7777,7875,8800-8900,9999"
  games[54].udpport = "5001-5010,7775-7777,7875,8800-8900,9999"
  games[55] = new Object;
  games[55].tcpport = "7777,8888,27900"
  games[55].udpport = "7777-7781"
  games[56] = new Object;
  games[56].tcpport = "7777-7783,8080,27900"
  games[56].udpport = "7777-7783,8080,27900"
  games[57] = new Object;
  games[57].tcpport = "28902"
  games[57].udpport = "7777-7778,7787-7788"
  games[58] = new Object;
  games[58].tcpport = ""
  games[58].udpport = "5425,15425,28900"
  games[59] = new Object;
  games[59].tcpport = "6112-6119,4000"
  games[59].udpport = "6112-6119"
  games[60] = new Object;
  games[60].tcpport = "6112-6119,4000"
  games[60].udpport = "6112-6119"
  games[61] = new Object;
  games[61].tcpport = ""
  games[61].udpport = "27950,27960,27965,27952"
  games[62] = new Object;
  games[62].tcpport = "3724,8086,8087,9081,9090,9091,9100"
  games[62].udpport = ""
  games[63] = new Object;
  games[63].tcpport = "6881-6889"
  games[63].udpport = ""
  games[64] = new Object;
  games[64].tcpport = "6346"
  games[64].udpport = "6346"
  games[65] = new Object;
  games[65].tcpport = "4661-4662"
  games[65].udpport = "4665"
  games[66] = new Object;
  games[66].tcpport = "6349"
  games[66].udpport = "6349"
  games[67] = new Object;
  games[67].tcpport = "4661-4662,4711"
  games[67].udpport = "4672,4665"
  games[68] = new Object;
  games[68].tcpport = "6699"
  games[68].udpport = "6257"
  games[69] = new Object;
  games[69].tcpport = "27000-27999"
  games[69].udpport = "15001,15101,15200,15400"
  games[70] = new Object;
  games[70].tcpport = "3074"
  games[70].udpport = "88,3074"
  games[71] = new Object;
  games[71].tcpport = "40000-42999"
  games[71].udpport = "41005"
  games[72] = new Object;
  games[72].tcpport = "27030-27039"
  games[72].udpport = "1200,27000-27015"
  games[73] = new Object;
  games[73].tcpport = "6667"
  games[73].udpport = "28800-29000"
  games[74] = new Object;
  games[74].tcpport = "2300-2400,47624"
  games[74].udpport = "2300-2400"
  games[75] = new Object;
  games[75].tcpport = ""
  games[75].udpport = "2213,6666"
  games[76] = new Object;
  games[76].tcpport = ""
  games[76].udpport = "6500"
  games[77] = new Object;
  games[77].tcpport = ""
  games[77].udpport = "6700"
  games[78] = new Object;
  games[78].tcpport = "3782"
  games[78].udpport = "27900,28900,3782-3783"
  games[79] = new Object;
  games[79].tcpport = ""
  games[79].udpport = "8767"
  var index = formname.gamelist.options[formname.gamelist.selectedIndex].value;
  if(index>=0)
  {
   formname.game.value=formname.gamelist.options[formname.gamelist.selectedIndex].text;
   formname.tcpopen.value=games[index].tcpport;
   formname.udpopen.value=games[index].udpport;
  }
 }
</script>
<% initPage("gaming"); %>
<form action=/boaform/formGaming method=POST name="actionForm">
<input type=hidden value="/gaming.asp" name="submit-url">
<input type=hidden name=action>
<input type=hidden name=idx>
</form>
</blockquote>
</body>
</html>

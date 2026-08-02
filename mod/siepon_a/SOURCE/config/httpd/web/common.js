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
/*
** E8-B common java script library
** Shared javascript interface
*/
JS_DEBUG = 0; /*调试开关*/
JS_ALERT = 0; /*提示开关*/
function getDigit(str, num)
{
  i=1;
  if ( num != 1 ) {
   while (i!=num && str.length!=0) {
  if ( str.charAt(0) == '.' ) {
   i++;
  }
  str = str.substring(1);
   }
   if ( i!=num )
    return -1;
  }
  for (i=0; i<str.length; i++) {
   if ( str.charAt(i) == '.' ) {
  str = str.substring(0, i);
  break;
 }
  }
  if ( str.length == 0)
   return -1;
  d = parseInt(str, 10);
  return d;
}
/********************************************************************
**          Debug functions
********************************************************************/
function sji_debug(msg)
{
    if(JS_ALERT)alert(msg);
    document.write(msg);
}
function sji_objdump(obj)
{
 if(typeof obj == "undefined")return;
 for(var key in obj) alert(key + "=" + obj[key]);
}
/********************************************************************
**          Utility functions
********************************************************************/
function sji_int(val){if(val == false) {return 0;} else if(val == true) {return 1;} else {return parseInt(val);}}
function sji_docinit(doc, cgi)
{
 var surl = doc.getElementsByName("submit-url");
 if(surl && surl.length > 0)
 {
  if(surl[0].value == "")surl[0].value = doc.location.href;
 }
 var stype = "";
 var stag = "";
 var svalue = null;
 if(typeof doc == "undefined" || typeof cgi == "undefined")return;
 for(var name in cgi)
 {
  if(typeof cgi[name] != "boolean" && typeof cgi[name] != "string" && typeof cgi[name] != "number")continue;
  svalue = cgi[name];
  var obj = doc.getElementsByName(name);
  if(typeof obj != "object")continue;
  if(obj.length == 0 || typeof obj[0].tagName == "undefined")continue;
  stag = obj[0].tagName;
  if(stag == "LABEL")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "TD")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "INPUT")
  {
   stype = obj[0].type;
   if(stype == "text" || stype == "hidden")obj[0].value = svalue;
   else if(stype == "radio")obj[sji_int(svalue)].checked = true;
   else if(stype == "checkbox")obj[0].checked = sji_int(svalue);
   else {/*warning*/}
  }
  else if(stag == "SELECT")
  {
   obj[0].value = svalue;
  }
  else {/*warning*/}
 }
}
function sji_onchanged(doc, rec)
{
 var stype = "";
 var stag = "";
 var svalue = null;
 if(typeof doc == "undefined" || typeof rec == "undefined")return;
 for(var name in rec)
 {
  if(typeof rec[name] != "boolean" && typeof rec[name] != "string" && typeof rec[name] != "number")continue;
  svalue = rec[name];
  var obj = doc.getElementsByName(name);
  if(typeof obj != "object")continue;
  if(obj.length == 0 || typeof obj[0].tagName == "undefined")continue;
  stag = obj[0].tagName;
  if(stag == "LABEL")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "TD")
  {
   obj[0].innerHTML = svalue;
  }
  else if(stag == "INPUT")
  {
   stype = obj[0].type;
   if(stype == "text" || stype == "hidden" || stype == "password")obj[0].value = svalue;
   else if(stype == "radio")obj[sji_int(svalue)].checked = true;
   else if(stype == "checkbox")obj[0].checked = sji_int(svalue);
   else {/*warning*/}
  }
  else if(stag == "SELECT")
  {
   obj[0].value = svalue;
  }
  else {/*warning*/}
 }
}
function sji_elshowbyid(id, show)
{
 if (document.getElementById)// standard
 {
  document.getElementById(id).style.display = show ? "block" : "none";
 }
 else if (document.all)// old IE
 {
  document.all[id].style.display = show ? "block" : "none";
 }
 else if (document.layers)// Netscape 4
 {
  document.layers[id].display = show ? "block" : "none";
 }
}
function sji_getchild(el, chid)
{
 if(el.childNodes)
 {
  return el.childNodes[chid];
 }
 return el.children[chid];
}
function sji_queryparam(param)
{
 var urlstr = window.location.href;
 var sar = urlstr.split("?");
 if(sar.length == 1)return null;
 var params = sar[1].split("&");
 for(var i=0; i<params.length; i++)
 {
  var pair = params[i].split("=");
  if(param == pair[0])
  {
   return pair[1];
  }
 }
 return null;
}
function sji_encode(ar, field)
{
 var senc = null;
 if(typeof ar == "undefined")return null;
 senc = "l";
 for(var i in ar)
 {
  if(!ar[i][field])continue;
  senc += ar[i].enc();
 }
 senc += "e";
 return senc;
}
/********************************************************************
**          string functions
********************************************************************/
function sji_valenc(val)
{
 var text = "";
 if(typeof val == "undefined")return null;
    else if(typeof val == "string")
    {
        text = val.length + ":" + val;
    }
    else if(typeof val == "number")
    {
        text = "i" + val + "e";
    }
 else return null;
    return text;
}
function sji_valdec(text)
{
    var type = text.charAt(0);
    var len = text.length;
    var val = '\0';
    var hlen = 1;
    var hdr = "";
    var vlen = 0;
 var cnt = 1;
 if(typeof text == "undefined")return null;
    if(text.length <= 2){return null;}
 if(type == 'i')
 {
  var subtext = "";
  while(cnt < len)
  {
   val = text.charAt(cnt);
   if(val == 'e')
   {
    subtext = text.substring(1, cnt);
    cnt++;
    break;
   }
   cnt++;
  }
  if(subtext == ""){return null;}
  if(isNaN(parseInt(subtext))){return null;}
  return new it(cnt, parseInt(subtext));
 }
 else
 {
  while(hlen < len)
  {
   val = text.charAt(hlen);
   if(val == ':')
   {
    hdr = text.substring(0, hlen);
    hlen++;
    break;
   }
   hlen++;
  }
  if(hdr == ""){return null;}
  if(isNaN(parseInt(hdr))){return null;}
  vlen = parseInt(hdr);
  if((vlen + hlen) > len){vlen = len - hlen;}
  return new it(hlen + vlen, text.substring(hlen, hlen + vlen));
 }
 return null;
}
//----------------------
//功能: 去除字符前尾的空格
//======================
function sji_killspace(str)
{
 while( str.charAt(0)==" " )
 {
  str=str.substr(1,str.length);
 }
 while( str.charAt(str.length-1)==" " )
 {
  str=str.substr(0,str.length-1);
 }
 return str;
}
//-------------------
//功能：计算字符串的长度，字符串内可以混合英文和中文
//====================
function sji_strlen(str)
{
 var len;
 var i;
 len = 0;
 for (i=0;i<str.length;i++)
 {
  if (str.charCodeAt(i)>255)
   len+=2;
  else
   len++;
 }
 return len;
}
//-----------------------
//功能：检查输入的是否为数字
//======================
function sji_checkdigit(str)
{
 if(typeof str == "undefined")return false;
 var pattern = /^-?[0-9]+((\.[0-9]+)|([0-9]*))$/;
 return pattern.test(str);
}
//-----------------------
//功能：检查输入的数值是否符合数值范围
//======================
function sji_checkdigitrange(num, dmin, dmax)
{
 if(typeof num == "undefined")return false;
 if(sji_checkdigit(num) == false)
 {
  return false;
 }
   var val = parseInt(num, 10);
 if(typeof dmin != "undefined" && val < dmin)return false;
 if(typeof dmax != "undefined" && val > dmax)return false;
 return true;
}
//-----------------------
//功能：检查输入的 str 数字是否为非负整数
//======================
function sji_checknum(str)
{
 if(typeof str == "undefined")return false;
 var pattern = /^[0-9]{1,}$/;
 return pattern.test(str);
}
//-----------------------
//功能：检查输入的 str 数字是否为16进制数值
//======================
function sji_checkhex(str, smin, smax)
{
 if(typeof str == "undefined")return false;
 if(typeof smin != "undefined" && str.length < smin)return false;
 if(typeof smax != "undefined" && str.length > smax)return false;
 var pattern = /^[0-9a-fA-F]+$/;
 return pattern.test(str);
}
//-----------------------
//功能：检查输入的字符串长度符合要求
//======================
function sji_checklen(str, smin, smax)
{
 if(typeof str == "undefined")return false;
 if(typeof smin != "undefined" && str.length < smin)return false;
 if(typeof smax != "undefined" && str.length > smax)return false;
 return true;
}
//-----------------------
//功能：检查输入的字符串是否合乎常规应用，且长度符合要求
//======================
function sji_checkstrnor(str, smin, smax)
{
 if(typeof str == "undefined")return false;
 if(typeof smin != "undefined" && str.length < smin)return false;
 if(typeof smax != "undefined" && str.length > smax)return false;
 /*ql:20080717 START: Don't restrict the length of the string*/
 //var pattern = /^[a-zA-Z0-9%@.,~+=_*&\(\)\[\]:][a-zA-Z0-9%@.,~+=_*&\s\(\)\[\]:]+[a-zA-Z0-9%@.,~+=_*&\(\)\[\]:]$/;
 var pattern = /^[a-zA-Z0-9%@.,~+=_*&\(\)\[\]:]+$/;
 /*ql:20080717 END*/
 return pattern.test(str);
}
//-----------------------
//功能：检查输入的密码是否合乎常规应用，且长度符合要求
//======================
function sji_checkpswnor(str, smin, smax)
{
 if(typeof str == "undefined")return false;
 if(typeof smin != "undefined" && str.length < smin)return false;
 if(typeof smax != "undefined" && str.length > smax)return false;
 var pattern = /^[a-zA-Z0-9%@.,~+=_*&\s\(\)\[\]:]+$/;
 return pattern.test(str);
}
//-------------------
//功能：检查用户名是否符合指定规则
//====================
function sji_checkusername(username, smin, smax)
{
 if(typeof username == "undefined")return false;
 if(typeof smin != "undefined" && username.length < smin)return false;
 if(typeof smax != "undefined" && username.length > smax)return false;
 var pattern = /^([a-zA-Z0-9_])+$/;
 return pattern.test(username);
}
//-------------------
//功能：检查域名是否符合指定规则
//====================
function sji_checkhostname(username, smin, smax)
{
 if(typeof username == "undefined")return false;
 if(typeof smin != "undefined" && username.length < smin)return false;
 if(typeof smax != "undefined" && username.length > smax)return false;
 var pattern = /^([a-zA-Z0-9@.])+$/;
 return pattern.test(username);
}
//-------------------
//功能：检查PPP帐号是否符合指定规则
//====================
function sji_checkpppacc(username, smin, smax)
{
 if(typeof username == "undefined")return false;
 if(typeof smin != "undefined" && username.length < smin)return false;
 if(typeof smax != "undefined" && username.length > smax)return false;
 var pattern = /^([a-zA-Z0-9%@.,~+=_*&])+$/;
 return pattern.test(username);
}
//-------------------
//检查 email 是否是合法的书写形式
//===================
function sji_checkemail(email)//M12 
{
 if(typeof email == "undefined")return false;
 var pattern = /^(([a-zA-Z0-9_.\-])+@([a-zA-Z0-9_\-])+(\.[a-zA-Z0-9_\-]+)+){0,1}$/;
 var email_array = email.split("\r\n");
 for (i = 0; i < email_array.length; i++)
 {
  if (!sji_killspace(email_array[i]))
   continue;
  if(!pattern.test(sji_killspace(email_array[i])))
   return false;
 }
 return true;
}
//-------------------
//检查 URL 是否是合法的书写形式
//===================
function sji_checkurl(url)
{
 if(typeof url == "undefined")return false;
 //var pattern = /^((http|ftp):\/\/)?((([\d]+.){3}[\d]+(\/[\w.\/]+)?)|([a-z]\w*((.\w+)+){2,})([\/][\w.~]*)*)$/;
 var pattern = /^((http|ftp):\/\/)?((((\d+.){3}\d+)|([a-zA-Z]\w*(.\w+){2,}))(\/\S*)*)$/;
 return pattern.test(url);
}
//-----------------------
//功能：检查输入的IP地址是否符合指定规则
//======================
function sji_checkip(ip)
{
 if(typeof ip == "undefined")return false;
 var pattern = /^([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])(\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])){3}$/;
 return pattern.test(ip);
}
//-----------------------
//功能：检查输入的IP地址是否为合法IP地址
//======================
function sji_checkvip(ip)
{
 if(typeof ip == "undefined")return false;
 var pattern1 = /^([1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])(\.([0-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])){2}(\.([1-9]|[1-9]\d|1\d\d|2[0-4]\d|25[0-4]))$/;
 if(pattern1.test(ip) == false) return false;
 var pattern2 = /^127\..+$/;
 if(pattern2.test(ip) == true) return false;
 return true;
}
//-----------------------
//功能：检查输入的IP掩码是否符合指定规则
//======================
function sji_checkmask(mask)
{
 if(typeof mask == "undefined")return false;
 var pattern = /^((128)|(192)|(224)|(240)|(248)|(252)|(254))(.0){3}$/;
 if(pattern.test(mask) == true)return true;
 pattern = /^255.((0)|(128)|(192)|(224)|(240)|(248)|(252)|(254))(.0){2}$/;
 if(pattern.test(mask) == true)return true;
 pattern = /^255.255.((0)|(128)|(192)|(224)|(240)|(248)|(252)|(254)).0$/;
 if(pattern.test(mask) == true)return true;
 pattern = /^255.255.255.((0)|(128)|(192)|(224)|(240)|(248)|(252)|(254)|(255))$/;
 return pattern.test(mask);
}
//-----------------------
//功能：检查输入的MAC地址是否符合指定规则
//======================
function sji_checkmac(mac)
{
 if(typeof mac == "undefined")return false;
 //var pattern = /^([0-9a-fA-F]{2}(:|-)){5}[0-9a-fA-F]{2}$/; 
 var pattern = /^([0-9a-fA-F]{2}(-)){5}[0-9a-fA-F]{2}$/;
 return pattern.test(mac);
}
function sji_checkmac2(mac)
{
 if(typeof mac == "undefined")return false;
 //var pattern = /^([0-9a-fA-F]{2}(:)){5}[0-9a-fA-F]{2}$/; 
 var pattern = /^([0-9a-fA-F]{2})(:[0-9a-fA-F]{2}){5}$/;
 return pattern.test(mac);
}
//-----------------------
//功能：IP地址比较，ip1 > ip2: 1; ip1 < ip2: -1; ip1 == ip2: 0; 
//======================
function sji_ipcmp(ip1, ip2)
{
 if(typeof ip1 == "undefined" || typeof ip2 == "undefined")return -2;
 if(ip1 == ip2)return 0;
 var uip1 = sji_str2ip(ip1);
 var uip2 = sji_str2ip(ip2);
 if(uip1 > 0 && uip2 < 0) return -1;
 if(uip1 < 0 && uip2 > 0) return 1;
 return (uip1 > uip2) ? 1 : -1;
}
//-----------------------
//功能：获取地址的前缀
//======================
function sji_ipprefix(ip, mask)
{
 var ipcells = ip.split(".");
 var maskcells=mask.split(".");
 var s="";
 for(var i=0;i<4;i++)
 {
  if(maskcells[i]!=0xff) break;
  s+=ipcells[i]+".";
 }
 return s;
}
//-----------------------
//功能：点分IP地址转换成integer
//======================
function sji_str2ip(str)
{
 if(sji_checkip(str) == false)return 0;
 var cells = str.split(".");
 var addr = 0;
 for(var i = 0; i < 4; i++)
 {
  addr <<= 8;
  addr |= (parseInt(cells[i], 10) & 0xff);
 }
 return addr;
}
//-----------------------
//功能：integer转换成点分IP地址
//======================
function sji_ip2str(ip)
{
 var uTemp = ip;
 var addr1 = (uTemp & 0xff);
 uTemp >>= 8;
 var addr2 = (uTemp & 0xff);
 uTemp >>= 8;
 var addr3 = (uTemp & 0xff);
 uTemp >>= 8;
 var addr4 = (uTemp & 0xff);
 var addr = addr1 + "." + addr2 + "." + addr3 + "." + addr4;
 return addr;
}
/********************************************************************
**          object constructors
********************************************************************/
//-----------------------
//说明：URL过滤对象
//URL地址 端口 选中 
//======================
function it_flturl(url, port)
{
 this.url = url;
 this.port = port;
 this.select = false;
 return this;
}
//-----------------------
//说明：桥接MAC过滤对象
//VPI/VCI 协议 目标MAC地址 源MAC地址 帧方向 选中 
//======================
function it_fltmacbr(interface, protocol, dmac, smac, dir)
{
 this.interface = interface;
 this.protocol = protocol;
 this.dmac = dmac;
 this.smac = smac;
 this.dir = dir;
 this.select = false;
 return this;
}
//-----------------------
//说明：路由MAC过滤对象
//局域网设备名 MAC 选中 
//======================
function it_fltmacrt(name, mac)
{
 this.name = name;
 this.mac = mac;
 this.select = false;
 return this;
}
//-----------------------
//说明：端口过滤对象
//过滤器名 协议 源IP地址(范围) 源子网掩码 源端口 目的IP地址(范围) 目的子网掩码 目的端口 选中 
// protocol : 0 TCP/UDP; 1 TCP; 2 UDP;
//======================
function it_fltport(name, protocol, sipb, sipe, sipm, sportb, sporte, dipb, dipe, dpim, dportb, dporte)
{
 this.name = name;
 this.protocol = protocol;
 this.sipb = sipb;
 this.sipe = sipe;
 this.sipm = sipm;
 this.sportb = sportb;
 this.sporte = sporte;
 this.dipb = dipb;
 this.dipe = dipe;
 this.dpim = dpim;
 this.dportb = dportb;
 this.dporte = dporte;
 this.select = false;
 return this;
}
//-----------------------
//说明：动态DNS
//主机名 用户名 服务 接口 选中 
//======================
function it_ddns(host, user, service, iterface)
{
 this.host = host;
 this.user = user;
 this.service = service;
 this.iterface = iterface;
 this.select = false;
 return this;
}
//-----------------------
//说明：虚拟服务器
//服务器名 外部初始端口 外部终止端口 协议 服务器IP地址 服务器端口 选中 
// protocol : 0 TCP/UDP; 1 TCP; 2 UDP;
//======================
function it_virsvr(name, oportb, oporte, protocol, server, sport)
{
 this.name = name;
 this.oportb = oportb;
 this.oporte = oporte;
 this.protocol = protocol;
 this.server = server;
 this.sport = sport;
 this.select = false;
 return this;
}
//-----------------------
//说明：端口触发
//应用程序（名字） 触发协议 触发初始端口 触发终止端口 打开协议 打开初始端口 打开终止端口  选中 
// tprotocol : 0 TCP/UDP; 1 TCP; 2 UDP;
// oprotocol : 0 TCP/UDP; 1 TCP; 2 UDP;
//======================
function it_pttrg(name, tprotocol, tportb, tporte, oprotocol, oportb, oporte)
{
 this.name = name;
 this.tprotocol = tprotocol;
 this.tportb = tportb;
 this.tporte = tporte;
 this.oprotocol = oprotocol;
 this.oportb = oportb;
 this.oporte = oporte;
 this.select = false;
 return this;
}
//-----------------------
//说明：简要连接结构
//连接名称 通用对象（如是否开启IGMP Proxy等） 选中 
//======================
function it_smlink(name, ext)
{
 this.name = name;
 this.ext = ext;
 this.select = false;
 return this;
}
//-----------------------
//说明：用于诊断的连接结构
//连接名称 测试USB连接 测试无线连接 开启"PPPOE PassThrough" 选中 
//======================
function it_tslink(name, usb, wlan, ipext)
{
 this.name = name;
 this.usb = usb;
 this.wlan = wlan;
 this.ipext = ipext;
 this.select = false;
 return this;
}
//-----------------------
//说明：键值对
//键名称 数值 
//======================
function it(key, value)
{
 this.key = key;
 this.value = value;
 return this;
}
//-----------------------
//说明：通用结构
//名称 选中
//======================
function it_nr(name)
{
 if(typeof name == "undefined")return null;
 this.name = name;
 this.select = false;
 this.add = function(kv)
 {
  this[kv.key] = kv.value;
 }
 this.enc = function()
 {
  var strenc = "d";
  for(var k in this)
  {
   var strk = sji_valenc(k);
   if(strk == null) continue;
   var strv = sji_valenc(this[k]);
   if(strv == null) continue;
   strenc += (strk + strv);
  }
  strenc += "e";
  return strenc;
 }
 this.dec = function(strenc)
 {
  if(typeof strenc == "undefined" || strenc == null)return;
  if(strenc.charAt(0) != 'd')return;
  var cnt = 1;
  while(cnt < strenc.length)
  {
   var kvk = sji_valdec(strenc.substring(cnt, strenc.length));
   if(kvk == null)break;
   cnt += kvk.key;
   var kvv = sji_valdec(strenc.substring(cnt, strenc.length));
   if(kvv == null)break;
   cnt += kvv.key;
   this[kvk.value] = kvv.value;
  }
  if(strenc.charAt(cnt) != 'e')return; // error, not terminator
 }
 this.displayname = function(ex)
 {
  var strpvc = "";
  var str1 = "";
  if(typeof this.vpi == "undefined" || typeof this.vci == "undefined" || typeof this.cmode == "undefined")return str;
  strpvc = "_0_" + this.vpi + "_" + this.vci;
  if(typeof this.applicationtype == "undefined") return strpvc;
  str1 = strpvc;
  if(this.cmode == 0) str1 = "_B" + str1;
  else str1 = "_R" + str1;
  if(this.applicationtype == 0) str1 = "TR069_INTERNET" + str1;
  else if(this.applicationtype == 1) str1 = "TR069" + str1;
  else if(this.applicationtype == 2) str1 = "INTERNET" + str1;
  else if(this.applicationtype == 3) str1 = "Other" + str1;
  if(typeof ex == "undefined" || !ex) return str1;
  var str2 = strpvc;
  if(this.cmode == 2) str2 = "ppp" + str2;
  else str2 = "nas" + str2;
  return str1 + "/" + str2;
 }
 for(var i = 1; i < arguments.length; i++)
 {
  if(typeof arguments[i].key == "undefined" || typeof arguments[i].value == "undefined")continue;
  this[arguments[i].key] = arguments[i].value;
 }
 return this;
}
//-----------------------
//说明：连接结构(通用)
//连接名称 选中
//======================
function it_lknr(name)
{
 if(typeof name == "undefined")return null;
 this.name = name;
 this.select = false;
 this.add = function(kv)
 {
  this[kv.key] = kv.value;
 }
 for(var i = 1; i < arguments.length; i++)
 {
  if(typeof arguments[i].key == "undefined" || typeof arguments[i].value == "undefined")continue;
  this[arguments[i].key] = arguments[i].value;
 }
 return this;
}
//-----------------------
//说明：连接结构
//连接名称 选中
/*	key			meaning
 *  -----------------------
 *	apptype		应用类型：0-BOTH, 1-TR069, 2-INTERNET, 3-Other
 *	brmode		桥接模式：0-transparent bridging, 1-PPPoE bridging(PPPoE路由桥混合模式)
 *	cmode		连接模式：0- bridge; (1-2)- Route; 2- PPPoE
 *	dhcp		dhcp enable：0-OFF; 1-ON
 *	encap		封装方式: 1- VC- Mux; 0- LLC;  
 *	gw			缺省网关
 *	ifgrp		端口绑定表：bit0- LAN 1; bit1- LAN 2; …; bit 7- SSID 4
 *	ip			IP地址
 *	mask		IP地址掩码
 *	mbs			最大突发信元大小
 *	napt		napt enable：0-OFF; 1-ON
 *	pcr			峰值信元速率
 *	pppauth		PPP认证模式：0-AUTO, 1-PAP, 2-CHAP
 *	pppdtype	PPP拨号类型
 *	pppidle		PPP超时检测时间
 *	pppoepxy	启用PPPoE代理
 *	pppoemax	代理用户数
 *	ppppsw		PPP密码
 *	pppusr		PPP用户名
 *	pppsvname	PPP服务名称
 *	qos			是否开启QOS：0-OFF; 1-ON
 *	scr			持续信元速率
 *	svtype		服务类型：0-"UBR Without PCR", 1-"UBR With PCR", 2-"CBR", 3-"Non Realtime VBR", 4-"Realtime VBR"
 *	vci			cvi number
 *	vlan		vlan enable?
 *	vid			VLAN ID
 *	vpass		vlan passthrough
 *	vpi			vpi number
 *	vprio		802.1p priority bits
 */
//======================
function it_link(name,apptype,brmode,cmode,dhcp,encap,gw,ifgrp,ip,mask,mbs,napt,pcr,pppauth,pppdtype,pppidle,
    pppoepxy,pppoemax,ppppsw,pppusr,pppsvname,qos,scr,svtype,vci,vlan,vid,vpass,vpi,vprio)
{
 if(typeof name == "undefined")return null;
 this.name = name;
 this["apptype"] = apptype;
 this["brmode"] = brmode;
 this["cmode"] = cmode;
 this["dhcp"] = dhcp;
 this["encap"] = encap;
 this["gw"] = gw;
 this["ifgrp"] = ifgrp;
 this["ip"] = ip;
 this["mask"] = mask;
 this["mbs"] = mbs;
 this["napt"] = napt;
 this["pcr"] = pcr;
 this["pppauth"] = pppauth;
 this["pppdtype"] = pppdtype;
 this["pppidle"] = pppidle;
 this["pppoepxy"] = pppoepxy;
 this["pppoemax"] = pppoemax;
 this["ppppsw"] = ppppsw;
 this["pppusr"] = pppusr;
 this["pppsvname"] = pppsvname;
 this["qos"] = qos;
 this["scr"] = scr;
 this["svtype"] = svtype;
 this["vci"] = vci;
 this["vlan"] = vlan;
 this["vid"] = vid;
 this["vpass"] = vpass;
 this["vpi"] = vpi;
 this["vprio"] = vprio;
 this.select = false;
 this.add = function(kv)
 {
  this[kv.key] = kv.value;
 }
 for(var i = 1; i < arguments.length; i++)
 {
  if(typeof arguments[i].key == "undefined" || typeof arguments[i].value == "undefined")continue;
  this[arguments[i].key] = arguments[i].value;
 }
 return this;
}
//-----------------------
//说明：日志记录
//日期/时间 设备 严重程度 信息 选中 
//======================
function it_logrec(date, device, level, message)
{
 this.date = date;
 this.device = device;
 this.level = level;
 this.message = message;
 this.select = false;
 return this;
}
//-----------------------
//说明：接口信息
//接口 Bytes(接收) Pkts(接收) Errs(接收) Drops(接收) Bytes(发送) Pkts(发送) Errs(发送) Drops(发送) 选中
//======================
function it_iffrec(iff, rxbytes, rxpkts, rxerrs, rxdrops, txbytes, txpkts, txerrs, txdrops)
{
 this.iff = iff;
 this.rxbytes = rxbytes;
 this.rxpkts = rxpkts;
 this.rxerrs = rxerrs;
 this.rxdrops = rxdrops;
 this.txbytes = txbytes;
 this.txpkts = txpkts;
 this.txerrs = txerrs;
 this.txdrops = txdrops;
 this.select = false;
 return this;
}
//-----------------------
//说明：设备类型-内网设备信息(通过DHCP分配的设备)
//IP地址 设备类型 [MAC地址] 选中
//======================
function it_devrec(ip, type, mac)
{
 this.ip = ip;
 this.type = type;
 if(typeof mac != "undefined")this.mac = mac;
 this.select = false;
 return this;
}
//-----------------------
//说明：多级对象结构
//名称 选中
//======================
function it_mlo(name)
{
 if(typeof name == "undefined")return null;
 this.name = name;
 this.childs = new Array();
 this.select = false;
 this.add = function(o)
 {
  if(typeof childs[o.name] != "undefined")return;
  childs[o.name] = o;
  childs.push(o);
 }
 this.destroy = function(){delete childs;childs = null;}
 for(var i = 1; i < arguments.length; i++)
 {
  if(typeof arguments[i].name != "undefined")this.childs[arguments[i].name] = arguments[i];
  this.childs.push(arguments[i]);
 }
 return this;
}
// --------------------------------
// Mason Yu. For IPv6
// --------------------------------
//star:20100825 IPV6_RELATED
function isIPv6(str)
{
return str.match(/:/g).length<=7
&&/::/.test(str)
?/^([\da-f]{1,4}(:|::)){1,6}[\da-f]{1,4}$/i.test(str)
:/^([\da-f]{1,4}:){7}[\da-f]{1,4}$/i.test(str);
}
function $(a) {
        return document.getElementById(a);
 }
 function isNumber(value)
{
 return /^\d+$/.test(value);
}
function ParseIpv6Array(str)
{
    var Num;
    var i,j;
    var finalAddrArray = new Array();
    var falseAddrArray = new Array();
    var addrArray = str.split(':');
    Num = addrArray.length;
    if (Num > 8)
    {
        return falseAddrArray;
    }
    for (i = 0; i < Num; i++)
    {
        if ((addrArray[i].length > 4)
            || (addrArray[i].length < 1))
        {
            return falseAddrArray;
        }
        for (j = 0; j < addrArray[i].length; j++)
        {
            if ((addrArray[i].charAt(j) < '0')
                || (addrArray[i].charAt(j) > 'f')
                || ((addrArray[i].charAt(j) > '9') &&
                (addrArray[i].charAt(j) < 'a')))
            {
                return falseAddrArray;
            }
        }
        finalAddrArray[i] = '';
        for (j = 0; j < (4 - addrArray[i].length); j++)
        {
            finalAddrArray[i] += '0';
        }
        finalAddrArray[i] += addrArray[i];
    }
    return finalAddrArray;
}
function getFullIpv6Address(address)
{
    var c = '';
    var i = 0, j = 0, k = 0, n = 0;
    var startAddress = new Array();
    var endAddress = new Array();
    var finalAddress = '';
    var startNum = 0;
    var endNum = 0;
    var lowerAddress;
    var totalNum = 0;
    lowerAddress = address.toLowerCase();
    var addrParts = lowerAddress.split('::');
    if (addrParts.length == 2)
    {
        if (addrParts[0] != '')
        {
            startAddress = ParseIpv6Array(addrParts[0]);
            if (startAddress.length == 0)
            {
                return '';
            }
        }
        if (addrParts[1] != '')
        {
            endAddress = ParseIpv6Array(addrParts[1]);
            if (endAddress.length == 0)
            {
               return '';
            }
        }
        if (startAddress.length + endAddress.length >= 8)
        {
            return '';
        }
    }
    else if (addrParts.length == 1)
    {
        startAddress = ParseIpv6Array(addrParts[0]);
        if (startAddress.length != 8)
        {
            return '';
        }
    }
    else
    {
        return '';
    }
    for (i = 0; i < startAddress.length; i++)
    {
        finalAddress += startAddress[i];
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    for (; i < 8 - endAddress.length; i++)
    {
        finalAddress += '0000';
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    for (; i < 8; i++)
    {
        finalAddress += endAddress[i - (8 - endAddress.length)];
        if (i != 7)
        {
            finalAddress += ':';
        }
    }
    return finalAddress;
}
function isIpv6Address(address)
{
    if (getFullIpv6Address(address) == '')
    {
        return false;
    }
    return true;
}
function isUnicastIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);
    if ((tempAddress == '')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0000')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0001')
        || (tempAddress.substring(0, 2) == 'ff'))
    {
        return false;
    }
    return true;
}
function isGlobalIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);
    if ((tempAddress == '')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0000')
        || (tempAddress == '0000:0000:0000:0000:0000:0000:0000:0001')
        || (tempAddress.substring(0, 3) == 'fe8')
        || (tempAddress.substring(0, 3) == 'fe9')
        || (tempAddress.substring(0, 3) == 'fea')
        || (tempAddress.substring(0, 3) == 'feb')
        || (tempAddress.substring(0, 2) == 'ff'))
    {
        return false;
    }
    return true;
}
function isLinkLocalIpv6Address(address)
{
    var tempAddress = getFullIpv6Address(address);
    if ( (tempAddress.substring(0, 3) == 'fe8')
        || (tempAddress.substring(0, 3) == 'fe9')
        || (tempAddress.substring(0, 3) == 'fea')
        || (tempAddress.substring(0, 3) == 'feb'))
    {
        return true;
    }
    return false;
}
//star:20100825 IPV6_RELATED END
/*
 * showhide - show or hide a element
 * @element: element to show or hide
 * @show: true if @element should be showed, false if otherwise
 */
function showhide(element, show)
{
 var status;
 status = show ? "block" : "none";
 if (document.getElementById) {
  // standard
  document.getElementById(element).style.display = status;
 } else if (document.all) {
  // old IE
  document.all[element].style.display = status;
 } else if (document.layers) {
  // Netscape 4
  document.layers[element].display = status;
 }
}
/*
 * isCharUnsafe - test a character whether is unsafe
 * @c: character to test
 */
function isCharUnsafe(c)
{
 var unsafeString = "\"\\`\+\,='\t";
 return unsafeString.indexOf(c) != -1
  || c.charCodeAt(0) <= 32
  || c.charCodeAt(0) >= 123;
}
/*
 * isIncludeInvalidChar - test a string whether includes invalid characters
 * @s: string to test
 */
function isIncludeInvalidChar(s)
{
 var i;
 for (i = 0; i < s.length; i++) {
  if (isCharUnsafe(s.charAt(i)) == true)
   return true;
 }
 return false;
}
/*
 * getSelect - get the select element, and return the selected option
 * @element: select element to get
 */
function getSelect(element)
{
 if (element.options.length > 0) {
  return element.options[element.selectedIndex].value;
 } else {
  return "";
 }
}
/*
 * setSelect - set the select element to the option with specified value
 * @element: select element to set
 * @value: value to set to @element
 */
function setSelect(element, value)
{
 var i;
 for (i = 0; i < element.options.length; i++) {
  if (element.options[i].value == value) {
   element.selectedIndex = i;
   break;
  }
 }
}

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
// Morten's JavaScript Tree Menu
// version 2.3.2-macfriendly, dated 2002-06-10
// http://www.treemenu.com/
// Copyright (c) 2001-2002, Morten Wang & contributors
// All rights reserved.
// This software is released under the BSD License which should accompany
// it in the file "COPYING".  If you do not have this file you can access
// the license through the WWW at http://www.treemenu.com/license.txt
/******************************************************************************
* Define the MenuItem object.                                                 *
******************************************************************************/
function MTMenuItem(text, url, target, tooltip, icon, openIcon) {
 this.text = text;
 this.url = url ? url : "";
 this.target = target ? target : (MTMDefaultTarget ? MTMDefaultTarget : "");
 this.tooltip = tooltip;
 this.icon = icon ? icon : "";
 this.openIcon = openIcon ? openIcon : ""; // used for addSubItem
 this.number = MTMNumber++;
 this.parentNode = null;
 this.submenu = null;
 this.expanded = false;
 this.MTMakeSubmenu = MTMakeSubmenu;
 this.makeSubmenu = MTMakeSubmenu;
 this.addSubItem = MTMAddSubItem;
 MTMLastItem = this;
}
function MTMakeSubmenu(menu, isExpanded, collapseIcon, expandIcon) {
 this.submenu = menu;
 this.expanded = isExpanded;
 this.collapseIcon = collapseIcon ? collapseIcon : "menu_folder_closed.gif";
 this.expandIcon = expandIcon ? expandIcon : "menu_folder_open.gif";
 var i;
 for(i = 0; i < this.submenu.items.length; i++) {
  this.submenu.items[i].parentNode = this;
  if(this.submenu.items[i].expanded) {
   this.expanded = true;
  }
 }
}
function MTMakeLastSubmenu(menu, isExpanded, collapseIcon, expandIcon) {
 this.items[this.items.length-1].makeSubmenu(menu, isExpanded, collapseIcon, expandIcon);
}
function MTMAddSubItem(item) {
 if(this.submenu == null){
  this.MTMakeSubmenu(new MTMenu(), false, this.icon, this.openIcon);
 }
 this.submenu.MTMAddItem(item);
}
/******************************************************************************
* Define the Menu object.                                                     *
******************************************************************************/
function MTMenu() {
 this.items = new Array();
 this.MTMAddItem = MTMAddItem;
 this.addItem = MTMAddItem;
 this.makeLastSubmenu = MTMakeLastSubmenu;
}
function MTMAddItem() {
 if(arguments[0].toString().indexOf("[object Object]") != -1) {
  this.items[this.items.length] = arguments[0];
 } else {
  this.items[this.items.length] = new MTMenuItem(arguments[0], arguments[1], arguments[2], arguments[3], arguments[4]);
 }
}
/******************************************************************************
* Define the icon list, addIcon function and MTMIcon item.                    *
******************************************************************************/
function IconList() {
 this.items = new Array();
 this.addIcon = addIcon;
}
function addIcon(item) {
 this.items[this.items.length] = item;
}
function MTMIcon(iconfile, match, type) {
 this.file = iconfile;
 this.match = match;
 this.type = type;
}
/******************************************************************************
* Define the stylesheet rules objects and methods.                            *
******************************************************************************/
function MTMstyleRuleSet() {
 this.rules = new Array();
 this.addRule = MTMaddStyleRule;
}
function MTMaddStyleRule(thisSelector, thisStyle) {
 this.rules[this.rules.length] = new MTMstyleRule(thisSelector, thisStyle);
}
function MTMstyleRule(thisSelector, thisStyle) {
 this.selector = thisSelector;
 this.style = thisStyle;
}
/******************************************************************************
* The MTMBrowser object.  A custom "user agent" that'll define the browser    *
* seen from the menu's point of view.                                         *
******************************************************************************/
function MTMBrowser() {
 // default properties and values
 this.cookieEnabled = false;
 this.preHREF = "";
 this.MTMable = false;
 this.cssEnabled = true;
 this.browserType = "other";
 this.majVersion = null;
 this.DOMable = null;
 // properties concerning output document
 this.menuFrame = null;
 this.document = null;
 this.head = null;
 this.menuTable = null;
 // methods
 this.setDocument = MTMsetDocument;
 this.getFrames = MTMgetFrames;
 this.appendElement = MTMappendElement;
 this.resolveURL = MTMresolveURL;
 if(navigator.userAgent.indexOf("Opera") != -1) {
  if(navigator.appName == "Opera") {
   this.majVersion = parseInt(navigator.appVersion);
  } else {
   this.majVersion = parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("Opera")+6));
  }
  if(this.majVersion >= 5) {
   this.MTMable = true;
   this.browserType = "O";
  }
 } else if(navigator.appName == "Netscape" && navigator.userAgent.indexOf("WebTV") == -1) {
  this.MTMable = true;
  this.browserType = "NN";
  if(parseInt(navigator.appVersion) == 3) {
   this.majVersion = 3;
   this.cssEnabled = false;
  } else if(parseInt(navigator.appVersion) >= 4) {
   this.majVersion = parseInt(navigator.appVersion) == 4 ? 4 : 5;
   if(this.majVersion >= 5) {
    this.DOMable = true;
   }
  }
 } else if(navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion) >= 4) {
  this.MTMable = true;
  if(navigator.userAgent.toLowerCase().indexOf("mac") != -1) {
   this.browserType = "NN";
   this.majVersion = 4;
   this.DOMable = false;
  } else {
   this.browserType = "IE";
   this.majVersion = navigator.appVersion.indexOf("MSIE 6.") != -1 ? 6 : (navigator.appVersion.indexOf("MSIE 5.") != -1 ? 5 : 4);
   if(this.majVersion >= 5) {
    this.DOMable = true;
   }
  }
 }
 this.preHREF = location.href.substring(0, location.href.lastIndexOf("/") +1)
}
function MTMsetDocument(menuFrame) {
 // called by function MTMgetFrames and sets
 // properties .menuFrame and .document, and for DOMable browsers also .head
 this.menuFrame = menuFrame;
 this.document = menuFrame.document;
 if(this.DOMable) {
  this.head = this.browserType == "IE" ? this.document.all.tags('head')[0] : this.document.getElementsByTagName('head').item(0);
 }
}
function MTMresolveURL(thisURL, testLocal) {
 // resolves 'thisURL' against this.preHREF depending on whether it's an absolute
 // or relative URL.  if 'testLocal' is set it'll return true for local (relative) URLs.
 var absoluteArray = new Array("http://", "https://", "mailto:", "ftp://", "telnet:", "news:", "gopher:", "nntp:", "javascript:", "file:");
 var tempString = "", i;
 for(i = 0; i < absoluteArray.length; i++) {
  if(thisURL.indexOf(absoluteArray[i]) == 0) {
   tempString = thisURL;
   break;
  }
 }
 if(testLocal) {
  return(tempString == "" ? true : false);
 }
 if(!tempString) {
  if(thisURL.indexOf("/") == 0) {
   tempString = location.protocol + "//" + location.hostname + thisURL;
  } else if(thisURL.indexOf("../") == 0) {
   tempString = this.preHREF;
   do {
    thisURL = thisURL.substr(3);
    tempString = tempString.substr(0, tempString.lastIndexOf("/", tempString.length-2) +1);
   } while(thisURL.indexOf("../") == 0);
   tempString += thisURL;
  } else {
   tempString = this.preHREF + thisURL;
  }
 }
 return(tempString);
}
/******************************************************************************
* Default values of all user-configurable options.                            *
******************************************************************************/
var MTMLinkedJSURL, MTMLinkedSS, MTMSSHREF, MTMLinkedInitFunction, MTMDOCTYPE, MTMcontentType, MTMHeader, MTMFooter, MTMrightClickMessage, MTMDefaultTarget, MTMTimeOut = 5;
var MTMuseScrollbarCSS, MTMscrollbarBaseColor, MTMscrollbarFaceColor, MTMscrollbarHighlightColor, MTMscrollbarShadowColor, MTMscrollbar3dLightColor, MTMscrollbarArrowColor, MTMscrollbarTrackColor, MTMscrollbarDarkShadowColor;
var MTMUseCookies, MTMCookieName, MTMCookieDays, MTMTrackedCookieName;
var MTMCodeFrame = "code", MTMenuFrame = "menu", MTMTableWidth = "100%", MTMenuImageDirectory = "menu-images/";
var MTMUseToolTips = true, MTMEmulateWE, MTMAlwaysLinkIfWE = true, MTMSubsGetPlus = "Submenu", MTMSubsAutoClose;
// david
//var MTMBackground = "", MTMBGColor = "#ffffff", MTMTextColor = "#000000", MTMLinkColor = "#330099", MTMTrackColor = "#000000", MTMAhoverColor = "#990000", MTMSubExpandColor = "#666699", MTMSubClosedColor = "#666699", MTMSubTextColor = "#000000";
var MTMBackground = "", MTMBGColor = "#000000", MTMTextColor = "#FFFFFF", MTMLinkColor = "#FFFFFF", MTMTrackColor = "#000000", MTMAhoverColor = "#FF0000", MTMSubExpandColor = "#0000FF", MTMSubClosedColor = "#666699", MTMSubTextColor = "#FFFFFF";
// david
//var MTMenuText = "Site contents:", MTMRootIcon = "menu_new_root.gif", MTMRootColor = "#000000";
var MTMenuText = "Site contents:", MTMRootIcon = "menu_root.gif", MTMRootColor = "#FFFFFF";
var MTMRootFont = MTMenuFont = "Arial, Helvetica, sans-serif, bold";
// david
//var MTMRootCSSize = MTMenuCSSize = "84%";
//var MTMRootFontSize = MTMenuFontSize = "-1";
var MTMRootCSSize = MTMenuCSSize = "100%";
var MTMenuCSSize = "84%";
var MTMRootFontSize = "2";
var MTMenuFontSize = "1";
/******************************************************************************
* Global variables.  Not to be altered unless you know what you're doing.     *
* User-configurable options are found in code.html                            *
******************************************************************************/
var MTMLoaded = false;
var MTMLevel;
var MTMBar = new Array();
var MTMIndices = new Array();
var MTMUA = new MTMBrowser();
var MTMExtraCSS = new MTMstyleRuleSet();
var MTMstyleRules;
var MTMLastItem; // last item added to a menu
var MTMClickedItem = false;
var MTMExpansion = false;
var MTMNumber = 1;
var MTMTrackedItem;
var MTMTrack = false;
var MTMFrameNames;
var MTMFirstRun = true;
var MTMCurrentTime = 0;
var MTMUpdating = false;
var MTMWinSize, MTMyval, MTMxval;
var MTMOutputString = "";
var MTMCookieString = "";
var MTMCookieCharNum = 0;
var MTMTCArray, MTMTrackedCookie;
/******************************************************************************
* Code that picks up frame names of frames in the parent frameset.            *
******************************************************************************/
function MTMgetFrames() {
 if(this.MTMable) {
  MTMFrameNames = new Array();
  for(i = 0; i < parent.frames.length; i++) {
   MTMFrameNames[i] = parent.frames[i].name;
   if(parent.frames[i].name == MTMenuFrame) {
    this.setDocument(parent.frames[i]);
   }
  }
 }
}
/******************************************************************************
* Functions to draw the menu.                                                 *
******************************************************************************/
function MTMSubAction(SubItem) {
 SubItem.expanded = (SubItem.expanded) ? false : true;
 if(SubItem.expanded) {
  MTMExpansion = true;
 }
 MTMClickedItem = SubItem;
 if(MTMTrackedItem && MTMTrackedItem != SubItem.number) {
  MTMTrackedItem = false;
 }
 if(MTMEmulateWE || SubItem.url == "" || !SubItem.expanded) {
  setTimeout("MTMDisplayMenu()", 10);
  return false;
 } else {
  if(SubItem.target == "_blank" || !MTMUA.resolveURL(SubItem.url, true) || (SubItem.target.indexOf("_") != 0 && MTMTrackTarget(SubItem.target) == false)) {
   setTimeout("MTMDisplayMenu()", 10);
  }
  return true;
 }
}
function MTMStartMenu(thisEvent) {
 if(MTMUA.browserType == "O" && MTMUA.majVersion == 5) {
  parent.onload = MTMStartMenu;
  if(thisEvent) {
   return;
  }
 }
 MTMLoaded = true;
 if(MTMFirstRun) {
  if(MTMCurrentTime++ == MTMTimeOut) { // notice the post-increment
   setTimeout("MTMDisplayMenu()",10);
  } else {
   setTimeout("MTMStartMenu()",100);
  }
 }
}
function MTMDisplayMenu() {
 if(MTMUA.MTMable && !MTMUpdating) {
  MTMUpdating = true;
  MTMLevel = 0;
  if(MTMFirstRun) {
   MTMUA.getFrames();
   if(MTMUseCookies) {
    MTMFetchCookies();
    if(MTMTrackedCookie) {
     MTMTCArray = MTMTrackedCookie.split("::");
     MTMTrackedItem = MTMTCArray[0];
     if(parent.frames[MTMTCArray[1]]) {
      parent.frames[MTMTCArray[1]].location = MTMTCArray[2];
     }
     MTMTCArray = null;
    }
   }
  }
  if(MTMTrack) { MTMTrackedItem = MTMTrackExpand(menu); }
  if(MTMExpansion && MTMSubsAutoClose) { MTMCloseSubs(menu); }
  if(MTMUA.DOMable) {
   if(MTMFirstRun) {
    MTMinitializeDOMDocument();
   }
  } else if(MTMFirstRun || MTMUA.browserType != "IE") {
   MTMUA.document.open("text/html", "replace");
   MTMOutputString = (MTMDOCTYPE ? (MTMDOCTYPE + "\n") : '') + "<html><head>\n";
   if(MTMcontentType) {
    MTMOutputString += '<meta http-equiv="Content-Type" content="' + MTMcontentType + '">\n';
   }
   if(MTMLinkedSS) {
    MTMOutputString += '<link rel="stylesheet" type="text/css" href="' + MTMUA.preHREF + MTMSSHREF + '">\n';
   } else {
    MTMUA.document.writeln(MTMOutputString);
    MTMOutputString = "";
    MTMcreateStyleSheet();
   }
   if(MTMUA.browserType == "IE" && MTMrightClickMessage) {
    MTMOutputString += '<scr' + 'ipt type="text/javascript">\nfunction MTMcatchRight() {\nif(event && (event.button == 2 || event.button == 3)) {\nalert("' + MTMrightClickMessage + '");\nreturn false;\n}\nreturn true;\n}\n\ndocument.onmousedown = MTMcatchRight;\n';
    MTMOutputString += '<\/scr' + 'ipt>\n';
   }
   MTMOutputString += '</head>\n<body ';
   if(MTMBackground != "") {
    MTMOutputString += 'background="' + MTMUA.preHREF + MTMenuImageDirectory + MTMBackground + '" ';
   }
   MTMOutputString += 'bgcolor="' + MTMBGColor + '" text="' + MTMTextColor + '" link="' + MTMLinkColor + '" vlink="' + MTMLinkColor + '" alink="' + MTMLinkColor + '">\n';
   MTMUA.document.writeln(MTMOutputString + (MTMHeader ? MTMHeader : "") + '\n<table border="0" cellpadding="0" cellspacing="0" width="' + MTMTableWidth + '" id="mtmtable">\n');
  }
  if(!MTMFirstRun && (MTMUA.DOMable || MTMUA.browserType == "IE")) {
   if(!MTMUA.menuTable) {
    MTMUA.menuTable = MTMUA.document.all('mtmtable');
   }
   while(MTMUA.menuTable.rows.length > 1) {
    MTMUA.menuTable.deleteRow(1);
   }
  }
  MTMOutputString = '<img src="' + MTMUA.preHREF + MTMenuImageDirectory + MTMRootIcon + '" align="left" border="0" vspace="0" hspace="0">';
  if(MTMUA.cssEnabled) {
   MTMOutputString += '<span id="root">&nbsp;' + MTMenuText + '</span>';
  } else {
   MTMOutputString += '<font size="' + MTMRootFontSize + '" face="' + MTMRootFont + '" color="' + MTMRootColor + '">' + MTMenuText + '</font>';
  }
  if(MTMFirstRun || (!MTMUA.DOMable && MTMUA.browserType != "IE")) {
   MTMAddCell(MTMOutputString);
  }
  MTMListItems(menu);
  if(!MTMUA.DOMable && (MTMFirstRun || MTMUA.browserType != "IE")) {
   MTMUA.document.writeln('</table>\n' + (MTMFooter ? MTMFooter : "") + '\n');
   if(MTMLinkedJSURL && MTMUA.browserType != "IE") {
    MTMUA.document.writeln('<scr' + 'ipt defer type="text/javascript" src="' + MTMUA.preHREF + MTMLinkedJSURL + '"></scr' + 'ipt>');
   }
   MTMUA.document.writeln('\n</body>\n</html>');
   MTMUA.document.close();
  }
  if((MTMClickedItem || MTMTrackedItem) && !(MTMUA.browserType == "NN" && MTMUA.majVersion == 3)) {
   MTMItemName = "sub" + (MTMClickedItem ? MTMClickedItem.number : MTMTrackedItem);
   if(document.layers && MTMUA.menuFrame.scrollbars) {
    var i;
    for(i = 0; i < MTMUA.document.anchors.length; i++) {
     if(MTMUA.document.links[i].name == MTMItemName) {
      MTMyval = MTMUA.document.links[i].y;
      MTMUA.document.links[i].focus();
      break;
     }
    }
    MTMWinSize = MTMUA.menuFrame.innerHeight;
   } else if(MTMUA.browserType != "O") {
    if(MTMUA.browserType == "NN" && MTMUA.majVersion == 5) {
     MTMUA.document.all = MTMUA.document.getElementsByTagName("*");
    }
    MTMyval = MTMGetYPos(MTMUA.document.all[MTMItemName]);
    MTMUA.document.all[MTMItemName].focus();
    MTMWinSize = MTMUA.browserType == "IE" ? MTMUA.document.body.offsetHeight : MTMUA.menuFrame.innerHeight;
   }
   if(MTMyval > (MTMWinSize - 60)) {
    MTMUA.menuFrame.scrollTo(0, parseInt(MTMyval - (MTMWinSize * 1/3)));
   }
  }
  if(!MTMFirstRun && MTMUA.cookieEnabled) {
   if(MTMCookieString != "") {
    setCookie(MTMCookieName, MTMCookieString.substring(0,4000), MTMCookieDays);
    if(MTMTrackedCookieName) {
     if(MTMTCArray) {
      setCookie(MTMTrackedCookieName, MTMTCArray.join("::"), MTMCookieDays);
     } else {
      setCookie(MTMTrackedCookieName, "", -1);
     }
    }
   } else {
    setCookie(MTMCookieName, "", -1);
   }
  }
  if(MTMLinkedJSURL && MTMLinkedInitFunction && !(MTMUA.browserType == "IE" && MTMUA.majVersion == 4)) {
   setTimeout('MTMUA.menuFrame.' + MTMLinkedInitFunction + '()', 10);
  }
  MTMFirstRun = false;
  MTMClickedItem = false;
  MTMExpansion = false;
  MTMTrack = false;
  MTMCookieString = "";
 }
MTMUpdating = false;
}
function MTMinitializeDOMDocument() {
 var newElement;
 if(MTMcontentType) {
  MTMUA.appendElement('head', 'meta', 'httpEquiv', 'Content-Type', 'content', MTMcontentType);
 }
 MTMdisableStyleSheets();
 if(MTMLinkedSS) {
  MTMUA.appendElement('head', 'link', 'rel', 'stylesheet', 'type', 'text/css', 'href', (MTMUA.preHREF + MTMSSHREF));
 } else {
  MTMcreateStyleSheet();
 }
 if(MTMLinkedJSURL) {
  MTMUA.appendElement('head', 'script', 'src', (MTMUA.preHREF + MTMLinkedJSURL), 'type', 'text/javascript', 'defer', true);
 }
 while(MTMUA.document.body.childNodes.length > 0) {
  MTMUA.document.body.removeChild(MTMUA.document.body.firstChild);
 }
 if(MTMHeader) {
  if(MTMUA.browserType == "IE") {
   MTMUA.document.body.insertAdjacentHTML("afterBegin", MTMHeader);
  } else {
   var myRange = MTMUA.document.createRange();
   myRange.setStart(MTMUA.document.body, 0);
   var parsedHTML = myRange.createContextualFragment(MTMHeader);
   MTMUA.document.body.appendChild(parsedHTML);
  }
 }
 MTMUA.appendElement('body', 'table', 'border', '0', 'cellPadding', '0', 'cellSpacing', '0', 'width', MTMTableWidth, 'id', 'mtmtable');
 MTMUA.menuTable = MTMUA.document.getElementById('mtmtable');
 if(MTMFooter) {
  if(MTMUA.browserType == "IE") {
   MTMUA.document.body.insertAdjacentHTML("beforeEnd", MTMFooter);
  } else {
   var myRange = MTMUA.document.createRange();
   myRange.setStart(MTMUA.document.body, 0);
   var parsedHTML = myRange.createContextualFragment(MTMFooter);
   MTMUA.document.body.appendChild(parsedHTML);
  }
 }
}
function MTMappendElement() {
 var newElement = this.document.createElement(arguments[1]);
 var j, newProperty;
 for(j = 2; j < arguments.length; j+=2) {
  newElement.setAttribute(arguments[j], arguments[j+1]);
 }
 if(arguments[0] == 'head') {
  this.head.appendChild(newElement);
 } else if(arguments[0] == 'body') {
  this.document.body.appendChild(newElement);
 }
}
function MTMListItems(menu) {
 var i, isLast;
 for (i = 0; i < menu.items.length; i++) {
  MTMIndices[MTMLevel] = i;
  isLast = (i == menu.items.length -1);
  MTMDisplayItem(menu.items[i], isLast);
  if(menu.items[i].submenu && menu.items[i].expanded) {
   MTMBar[MTMLevel] = (isLast) ? false : true;
   MTMLevel++;
   MTMListItems(menu.items[i].submenu);
   MTMLevel--;
  } else {
   MTMBar[MTMLevel] = false;
  }
 }
}
function MTMDisplayItem(item, last) {
 var i, img, subNoLink;
 var MTMfrm = "parent.frames['" + MTMCodeFrame + "']";
 var MTMref = '.menu.items[' + MTMIndices[0] + ']';
 if(MTMLevel > 0) {
  for(i = 1; i <= MTMLevel; i++) {
   MTMref += ".submenu.items[" + MTMIndices[i] + "]";
  }
 }
 if(MTMUA.cookieEnabled) {
  if(MTMFirstRun && MTMCookieString != "") {
   item.expanded = (MTMCookieString.charAt(MTMCookieCharNum++) == "1") ? true : false;
  } else {
   MTMCookieString += (item.expanded) ? "1" : "0";
  }
 }
 if(item.submenu) {
  var usePlusMinus = false;
  if(MTMSubsGetPlus.toLowerCase() == "always" || MTMEmulateWE) {
   usePlusMinus = true;
  } else if(MTMSubsGetPlus.toLowerCase() == "submenu") {
   for(i = 0; i < item.submenu.items.length; i++) {
    if(item.submenu.items[i].submenu) {
     usePlusMinus = true; break;
    }
   }
  }
  var MTMClickCmd = "return " + MTMfrm + ".MTMSubAction(" + MTMfrm + MTMref + ");";
  var MTMouseOverCmd = "parent.status='" + (item.expanded ? "Collapse " : "Expand ") + (item.text.indexOf("'") != -1 ? MTMEscapeQuotes(item.text) : item.text) + "';return true;";
  var MTMouseOutCmd = "parent.status=parent.defaultStatus;return true;";
 }
 MTMOutputString = "";
 if(MTMLevel > 0) {
  for (i = 0; i < MTMLevel; i++) {
   MTMOutputString += (MTMBar[i]) ? MTMakeImage("menu_bar.gif") : MTMakeImage("menu_pixel.gif");
  }
 }
 if(item.submenu && usePlusMinus) {
  if(item.url == "") {
   MTMOutputString += MTMakeLink(item, true, true, true, MTMClickCmd, MTMouseOverCmd, MTMouseOutCmd);
  } else {
   if(MTMEmulateWE) {
    MTMOutputString += MTMakeLink(item, true, true, false, MTMClickCmd, MTMouseOverCmd, MTMouseOutCmd);
   } else {
    if(!item.expanded) {
     MTMOutputString += MTMakeLink(item, false, true, true, MTMClickCmd);
    } else {
     MTMOutputString += MTMakeLink(item, true, true, false, MTMClickCmd, MTMouseOverCmd, MTMouseOutCmd);
    }
   }
  }
  if(item.expanded) {
   img = (last) ? "menu_corner_minus.gif" : "menu_tee_minus.gif";
  } else {
   img = (last) ? "menu_corner_plus.gif" : "menu_tee_plus.gif";
  }
 } else {
  img = (last) ? "menu_corner.gif" : "menu_tee.gif";
 }
 MTMOutputString += MTMakeImage(img);
 if(item.submenu) {
  if(MTMEmulateWE) {
   if(item.url != "") {
    MTMOutputString += '</a>' + MTMakeLink(item, false, false, true);
   } else if(!MTMAlwaysLinkIfWE) {
    subNoLink = true;
    MTMOutputString += '</a><span class="subtext">';
   }
  } else if(!usePlusMinus) {
   if(item.url == "") {
    MTMOutputString += MTMakeLink(item, true, true, true, MTMClickCmd, MTMouseOverCmd, MTMouseOutCmd);
   } else if(!item.expanded) {
    MTMOutputString += MTMakeLink(item, false, true, true, MTMClickCmd);
   } else {
    MTMOutputString += MTMakeLink(item, true, true, false, MTMClickCmd, MTMouseOverCmd, MTMouseOutCmd);
   }
  }
  img = (item.expanded) ? item.expandIcon : item.collapseIcon;
 } else {
  MTMOutputString += MTMakeLink(item, false, true, true);
  img = (item.icon != "") ? item.icon : MTMFetchIcon(item.url);
 }
 MTMOutputString += MTMakeImage(img);
 if(item.submenu && item.url != "" && item.expanded && !MTMEmulateWE) {
  MTMOutputString += '</a>' + MTMakeLink(item, false, false, true);
 }
 if(MTMUA.browserType == "NN" && MTMUA.majVersion == 3 && !MTMLinkedSS) {
  var stringColor;
  if(item.submenu && (item.url == "") && (item.number == MTMClickedItem.number)) {
   stringColor = (item.expanded) ? MTMSubExpandColor : MTMSubClosedColor;
  } else if(MTMTrackedItem && MTMTrackedItem == item.number) {
   stringColor = MTMTrackColor;
  } else {
   stringColor = MTMLinkColor;
  }
  MTMOutputString += '<font color="' + stringColor + '" size="' + MTMenuFontSize + '" face="' + MTMenuFont + '">';
 }
 MTMOutputString += '&nbsp;' + item.text + ((MTMUA.browserType == "NN" && MTMUA.majVersion == 3 && !MTMLinkedSS) ? '</font>' : '');
 MTMOutputString += subNoLink ? '</span>' : '</a>';
 MTMAddCell(MTMOutputString);
}
function MTMEscapeQuotes(myString) {
 var newString = "";
 var cur_pos = myString.indexOf("'");
 var prev_pos = 0;
 while (cur_pos != -1) {
  if(cur_pos == 0) {
   newString += "\\";
  } else if(myString.charAt(cur_pos-1) != "\\") {
   newString += myString.substring(prev_pos, cur_pos) + "\\";
  } else if(myString.charAt(cur_pos-1) == "\\") {
   newString += myString.substring(prev_pos, cur_pos);
  }
  prev_pos = cur_pos++;
  cur_pos = myString.indexOf("'", cur_pos);
 }
 return(newString + myString.substring(prev_pos, myString.length));
}
function MTMTrackExpand(thisMenu) {
 var i, targetPath, targetLocation;
 var foundNumber = false;
 for(i = 0; i < thisMenu.items.length; i++) {
  if(thisMenu.items[i].url != "" && MTMTrackTarget(thisMenu.items[i].target)) {
   targetLocation = parent.frames[thisMenu.items[i].target].location;
   targetHREF = targetLocation.href;
   if(targetHREF.indexOf("#") != -1) {
    targetHREF = targetHREF.substr(0, targetHREF.indexOf("#"));
   }
   if(MTMUA.browserType == "IE" && targetLocation.protocol == "file:") {
    var regExp = /\\/g;
    targetHREF = targetHREF.replace(regExp, "\/");
   }
   if(targetHREF == MTMUA.resolveURL(thisMenu.items[i].url)) {
    return(thisMenu.items[i].number);
   }
  }
  if(thisMenu.items[i].submenu) {
   foundNumber = MTMTrackExpand(thisMenu.items[i].submenu);
   if(foundNumber) {
    if(!thisMenu.items[i].expanded) {
     thisMenu.items[i].expanded = true;
     if(!MTMClickedItem) { MTMClickedItem = thisMenu.items[i]; }
     MTMExpansion = true;
    }
    return(foundNumber);
   }
  }
 }
return(foundNumber);
}
function MTMCloseSubs(thisMenu) {
 var i, j;
 var foundMatch = false;
 for(i = 0; i < thisMenu.items.length; i++) {
  if(thisMenu.items[i].submenu && thisMenu.items[i].expanded) {
   if(thisMenu.items[i].number == MTMClickedItem.number) {
    foundMatch = true;
    for(j = 0; j < thisMenu.items[i].submenu.items.length; j++) {
     if(thisMenu.items[i].submenu.items[j].expanded) {
      thisMenu.items[i].submenu.items[j].expanded = false;
     }
    }
   } else {
    if(foundMatch) {
     thisMenu.items[i].expanded = false;
    } else {
     foundMatch = MTMCloseSubs(thisMenu.items[i].submenu);
     if(!foundMatch) {
      thisMenu.items[i].expanded = false;
     }
    }
   }
  }
 }
 return(foundMatch);
}
function MTMFetchIcon(testString) {
 var i;
 for(i = 0; i < MTMIconList.items.length; i++) {
  if((MTMIconList.items[i].type == 'any') && (testString.indexOf(MTMIconList.items[i].match) != -1)) {
   return(MTMIconList.items[i].file);
  } else if((MTMIconList.items[i].type == 'pre') && (testString.indexOf(MTMIconList.items[i].match) == 0)) {
   return(MTMIconList.items[i].file);
  } else if((MTMIconList.items[i].type == 'post') && (testString.indexOf(MTMIconList.items[i].match) != -1)) {
   if((testString.lastIndexOf(MTMIconList.items[i].match) + MTMIconList.items[i].match.length) == testString.length) {
    return(MTMIconList.items[i].file);
   }
  }
 }
 return("menu_link_default.gif");
}
function MTMGetYPos(myObj) {
 return(myObj.offsetTop + ((myObj.offsetParent) ? MTMGetYPos(myObj.offsetParent) : 0));
}
function MTMakeLink(thisItem, voidURL, addName, addTitle, clickEvent, mouseOverEvent, mouseOutEvent) {
 var tempString = '<a href="' + (voidURL ? 'javascript:;' : MTMUA.resolveURL(thisItem.url)) + '" ';
 if(MTMUseToolTips && addTitle && thisItem.tooltip) {
  tempString += 'title="' + thisItem.tooltip + '" ';
 }
 if(addName) {
  tempString += 'name="sub' + thisItem.number + '" ';
 }
 if(clickEvent) {
  tempString += 'onclick="' + clickEvent + '" ';
 }
 if(mouseOverEvent && mouseOverEvent != "") {
  tempString += 'onmouseover="' + mouseOverEvent + '" ';
 }
 if(mouseOutEvent && mouseOutEvent != "") {
  tempString += 'onmouseout="' + mouseOutEvent + '" ';
 }
 if(thisItem.submenu && MTMClickedItem && thisItem.number == MTMClickedItem.number) {
  tempString += 'class="' + (thisItem.expanded ? "subexpanded" : "subclosed") + '" ';
 } else if(MTMTrackedItem && thisItem.number == MTMTrackedItem) {
  if(MTMTrackedCookieName) {
   MTMTCArray = new Array(thisItem.number, thisItem.target, thisItem.url);
  }
  tempString += 'class="tracked"';
 }
 if(thisItem.target != "") {
  tempString += 'target="' + thisItem.target + '" ';
 }
 return(tempString + '>');
}
function MTMakeImage(thisImage) {
// david
 return('<img src="' + MTMUA.preHREF + MTMenuImageDirectory + thisImage + '" align="left" border="0" vspace="0" hspace="0" width="18" height="18">');
//	return('<img src="' + MTMUA.preHREF + MTMenuImageDirectory + thisImage + '" align="left" border="0" vspace="0" hspace="0"  width="0" height="0">');
}
function MTMakeSVG(thisImage) {
 return('<object type="image/svg+xml" data="' + thisImage + '" NAME="Main" width="18" height="18" ><\/object>');
}
function MTMTrackTarget(thisTarget) {
 if(thisTarget.charAt(0) == "_") {
  return false;
 } else {
  for(i = 0; i < MTMFrameNames.length; i++) {
   if(thisTarget == MTMFrameNames[i]) {
    return true;
   }
  }
 }
 return false;
}
function MTMAddCell(thisHTML) {
 if(MTMUA.DOMable || (MTMUA.browserType == "IE" && !MTMFirstRun)) {
  var myRow = MTMUA.menuTable.insertRow(MTMUA.menuTable.rows.length);
  myRow.vAlign = "top";
  var myCell = myRow.insertCell(myRow.cells.length);
  myCell.noWrap = true;
  myCell.innerHTML = thisHTML;
 } else {
  MTMUA.document.writeln('<tr valign="top"><td nowrap>' + thisHTML + '<\/td><\/tr>');
 }
}
function MTMcreateStyleSheet() {
 var i;
 if(!MTMstyleRules) {
  MTMstyleRules = new MTMstyleRuleSet();
  with(MTMstyleRules) {
   addRule('body', 'color:' + MTMTextColor + ';');
   if(MTMuseScrollbarCSS && MTMUA.browserType != "NN") {
    addRule('body', 'scrollbar-3dlight-color:' + MTMscrollbar3dLightColor + ';scrollbar-arrow-color:' + MTMscrollbarArrowColor + ';scrollbar-base-color:' + MTMscrollbarBaseColor + ';scrollbar-darkshadow-color:' + MTMscrollbarDarkShadowColor + ';scrollbar-face-color:' + MTMscrollbarFaceColor + ';scrollbar-highlight-color:' + MTMscrollbarHighlightColor + ';scrollbar-shadow-color:' + MTMscrollbarShadowColor + ';scrollbar-track-color:' + MTMscrollbarTrackColor + ';');
   }
   addRule('#root', 'color:' + MTMRootColor + ';background:transparent;font-family:' + MTMRootFont + ';font-size:' + MTMRootCSSize + ';');
   addRule('.subtext', 'font-family:' + MTMenuFont + ';font-size:' + MTMenuCSSize + ';color:' + MTMSubTextColor + ';background: transparent;');
   addRule('a', 'font-family:' + MTMenuFont + ';font-size:' + MTMenuCSSize + ';text-decoration:none;color:' + MTMLinkColor + ';background:transparent;');
   addRule('a:hover', 'color:' + MTMAhoverColor + ';background:transparent;');
   addRule('a.tracked', 'color:' + MTMTrackColor + ';background:transparent;');
   addRule('a.subexpanded', 'color:' + MTMSubExpandColor + ';background:transparent;');
   addRule('a.subclosed', 'color:' + MTMSubClosedColor + ';background:transparent;');
  }
 }
 if(MTMUA.DOMable) {
  if(MTMUA.browserType == "IE") {
   MTMUA.document.createStyleSheet();
   var newStyleSheet = MTMUA.document.styleSheets(MTMUA.document.styleSheets.length-1);
  } else if(MTMUA.browserType == "NN") {
   var newStyleSheet = MTMUA.document.getElementById('mtmsheet');
   if(newStyleSheet) {
    newStyleSheet.disabled = false;
   }
  }
 } else {
  var outputHTML = '<style type="text/css">\n';
 }
 for(i = 0; i < MTMstyleRules.rules.length; i++) {
  if(MTMUA.DOMable && MTMUA.browserType == "IE") {
   newStyleSheet.addRule(MTMstyleRules.rules[i].selector, MTMstyleRules.rules[i].style);
  } else if(MTMUA.DOMable && MTMUA.browserType == "NN" && newStyleSheet) {
   newStyleSheet.sheet.insertRule((MTMstyleRules.rules[i].selector + " { " + MTMstyleRules.rules[i].style + " } "), newStyleSheet.sheet.cssRules.length);
  } else {
   outputHTML += MTMstyleRules.rules[i].selector + ' {\n' + MTMstyleRules.rules[i].style + '\n}\n';
  }
 }
 for(i = 0; i < MTMExtraCSS.rules.length; i++) {
  if(MTMUA.DOMable && MTMUA.browserType == "IE") {
   newStyleSheet.addRule(MTMExtraCSS.rules[i].selector, MTMExtraCSS.rules[i].style);
  } else if(MTMUA.DOMable && MTMUA.browserType == "NN" && newStyleSheet) {
   newStyleSheet.sheet.insertRule((MTMExtraCSS.rules[i].selector + "{" + MTMExtraCSS.rules[i].style + "}"), newStyleSheet.sheet.cssRules.length);
  } else {
   outputHTML += MTMExtraCSS.rules[i].selector + ' {\n' + MTMExtraCSS.rules[i].style + '\n}\n';
  }
 }
 if(MTMFirstRun && MTMUA.DOMable) {
  with(MTMUA.document.body) {
   bgColor = MTMBGColor;
   text = MTMTextColor;
   link = MTMLinkColor;
   vLink = MTMLinkColor;
   aLink = MTMLinkColor;
   if(MTMBackground) {
    background = MTMUA.preHREF + MTMenuImageDirectory + MTMBackground;
   }
  }
 } else if(!MTMUA.DOMable) {
  MTMUA.document.writeln(outputHTML + '</style>');
 }
}
function MTMdisableStyleSheets() {
 if(MTMUA.browserType == "IE") {
  for(i = 0; i < MTMUA.document.styleSheets.length; i++) {
   MTMUA.document.styleSheets(i).disabled = true;
  }
 } else if(MTMUA.browserType == "NN") {
  var myCollection = MTMUA.document.getElementsByTagName('style');
  for(i = 0; i < myCollection.length; i++) {
   myCollection.item(i).disabled = true;
  }
  var myCollection = MTMUA.document.getElementsByTagName('link');
  for(i = 0; i < myCollection.length; i++) {
   if(myCollection.item(i).getAttribute('type') == "text/css") {
    myCollection.item(i).disabled = true;
   }
  }
 }
}
function MTMFetchCookies() {
 var cookieString = getCookie(MTMCookieName);
 if(cookieString == null) {
  setCookie(MTMCookieName, "Say-No-If-You-Use-Confirm-Cookies");
  cookieString = getCookie(MTMCookieName);
  MTMUA.cookieEnabled = (cookieString == null) ? false : true;
  return;
 }
 MTMCookieString = cookieString;
 if(MTMTrackedCookieName) { MTMTrackedCookie = getCookie(MTMTrackedCookieName); }
 MTMUA.cookieEnabled = true;
}
// These are from Netscape's Client-Side JavaScript Guide.
// setCookie() is altered to make it easier to set expiry.
function getCookie(Name) {
 var search = Name + "="
 if (document.cookie.length > 0) { // if there are any cookies
  offset = document.cookie.indexOf(search)
  if (offset != -1) { // if cookie exists
   offset += search.length
   // set index of beginning of value
   end = document.cookie.indexOf(";", offset)
   // set index of end of cookie value
   if (end == -1)
    end = document.cookie.length
   return unescape(document.cookie.substring(offset, end))
  }
 }
}
function setCookie(name, value, daysExpire) {
 if(daysExpire) {
  var expires = new Date();
  expires.setTime(expires.getTime() + 1000*60*60*24*daysExpire);
 }
 document.cookie = name + "=" + escape(value) + (daysExpire == null ? "" : (";expires=" + expires.toGMTString())) + ";path=/";
}

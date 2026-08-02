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
var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
             "abcdefghijklmnopqrstuvwxyz" +
             "0123456789+/=";
function encode64(input) {
 var output = "";
 var i = 0, len = input.length;
 for (i = 0; i <= len - 3; i += 3)
    {
        output += keyStr.charAt(input.charCodeAt(i) >>> 2);
        output += keyStr.charAt(((input.charCodeAt(i) & 3) << 4) | (input.charCodeAt(i+1) >>> 4));
        output += keyStr.charAt(((input.charCodeAt(i+1) & 15) << 2) | (input.charCodeAt(i+2) >>> 6));
        output += keyStr.charAt(input.charCodeAt(i+2) & 63);
    }
    if (len % 3 == 2)
    {
        output += keyStr.charAt(input.charCodeAt(i) >>> 2);
        output += keyStr.charAt(((input.charCodeAt(i) & 3) << 4) | (input.charCodeAt(i+1) >>> 4));
        output += keyStr.charAt(((input.charCodeAt(i+1) & 15) << 2));
        output += keyStr.charAt(64);
    }
    else if (len % 3 == 1)
    {
        output += keyStr.charAt(input.charCodeAt(i) >>> 2);
        output += keyStr.charAt(((input.charCodeAt(i) & 3) << 4));
        output += keyStr.charAt(64);
        output += keyStr.charAt(64);
    }
 return output;
}
function decode64(input) {
 var output = "";
 var i, a, b, c, d, z;
 for (i = 0; i < input.length - 3; i += 4) {
        a = keyStr.indexOf(input.charAt(i+0));
        b = keyStr.indexOf(input.charAt(i+1));
        c = keyStr.indexOf(input.charAt(i+2));
        d = keyStr.indexOf(input.charAt(i+3));
        output += String.fromCharCode((a << 2) | (b >>> 4));
        if (input.charAt(i+2) != keyStr.charAt(64))
            output += String.fromCharCode(((b << 4) & 0xF0) | ((c >>> 2) & 0x0F));
        if (input.charAt(i+3) != keyStr.charAt(64))
            output += String.fromCharCode(((c << 6) & 0xC0) | d);
    }
 return output;
}

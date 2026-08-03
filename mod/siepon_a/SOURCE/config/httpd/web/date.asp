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
<title><% multilang("731" "LANG_SYSTEM_DATE_AND_TIME_MODIFICATION"); %></title>
</head>
<body>
<blockquote>
<h2><font color="#0000FF"><% multilang("731" "LANG_SYSTEM_DATE_AND_TIME_MODIFICATION"); %></font></h2>
<table border=0 width="480" cellspacing=0 cellpadding=0>
  <tr><td><font size=2>
    <% multilang("732" "LANG_SET_THE_SYSTEM_DATE_AND_TIME"); %>
  </font></td></tr>
  <tr><td><hr size=1 noshade align=top></td></tr>
</table>
<form action=/boaform/admin/formStatusModify method=POST name="sdate">
<table border='1' width="80%">
  <tr>
      <td width=30%><font size=2><b><% multilang("59" "LANG_DATE"); %>:</b></td>
      <td width=70%>
       <select name="sys_month">
         <option value=0>Jan</option><option value=1>Feb</option>
         <option value=2>Mar</option><option value=3>Apr</option>
         <option value=4>May</option><option value=5>Jun</option>
         <option value=6>Jul</option><option value=7>Aug</option>
         <option value=8>Sep</option><option value=9>Oct</option>
         <option value=10>Nov</option><option value=11>Dec</option>
       </select>&nbsp;
       <select name="sys_day">
         <option >1</option><option >2</option><option >3</option>
         <option >4</option><option >5</option><option >6</option>
         <option >7</option><option >8</option><option >9</option>
         <option >10</option><option >11</option><option >12</option>
         <option >13</option><option >14</option><option >15</option>
         <option >16</option><option >17</option><option >18</option>
         <option >19</option><option >20</option><option >21</option>
         <option >22</option><option >23</option><option >24</option>
         <option >25</option><option >26</option><option >27</option>
         <option >28</option><option >29</option><option >30</option>
          <option >31</option>
       </select>&nbsp;
       <select name="sys_year">
         <option >2004</option><option >2005</option><option >2006</option>
         <option >2007</option><option >2008</option><option >2009</option>
         <option >2010</option><option >2011</option><option >2012</option>
         <option >2013</option><option >2014</option><option >2015</option>
         <option >2016</option><option >2017</option><option >2018</option>
         <option >2019</option><option >2020</option><option >2021</option>
         <option >2022</option><option >2023</option><option >2024</option>
         <option >2025</option><option >2026</option><option >2027</option>
       </select>
      </td>
  </tr>
  <tr>
      <td width=30%><font size=2><b><% multilang("60" "LANG_TIME"); %>:</b></td>
      <td width=70%>
       <select name="sys_hour">
          <option >0</option><option >1</option><option >2</option>
          <option >3</option><option >4</option><option >5</option>
          <option >6</option><option >7</option><option >8</option>
          <option >9</option><option >10</option><option >11</option>
          <option >12</option><option >13</option><option >14</option>
          <option >15</option><option >16</option><option >17</option>
          <option >18</option><option >19</option><option >20</option>
          <option >21</option><option >22</option><option >23</option>
        </select>&nbsp;:
        <select name="sys_minute">
          <option >0</option><option >1</option><option >2</option>
          <option >3</option><option >4</option><option >5</option>
          <option >6</option><option >7</option><option >8</option>
          <option >9</option><option >10</option><option >11</option>
          <option >12</option><option >13</option><option >14</option>
          <option >15</option><option >16</option><option >17</option>
          <option >18</option><option >19</option><option >20</option>
          <option >21</option><option >22</option><option >23</option>
          <option >24</option><option >25</option><option >26</option>
          <option >27</option><option >28</option><option >29</option>
          <option >30</option><option >31</option><option >32</option>
          <option >33</option><option >34</option><option >35</option>
          <option >36</option><option >37</option><option >38</option>
          <option >39</option><option >40</option><option >41</option>
          <option >42</option><option >43</option><option >44</option>
          <option >45</option><option >46</option><option >47</option>
          <option >48</option><option >49</option><option >50</option>
          <option >51</option><option >52</option><option >53</option>
          <option >54</option><option >55</option><option >56</option>
          <option >57</option><option >58</option><option >59</option>
        </select>&nbsp;:
        <select name="sys_second">
          <option >0</option><option >1</option><option >2</option>
          <option >3</option><option >4</option><option >5</option>
          <option >6</option><option >7</option><option >8</option>
          <option >9</option><option >10</option><option >11</option>
          <option >12</option><option >13</option><option >14</option>
          <option >15</option><option >16</option><option >17</option>
          <option >18</option><option >19</option><option >20</option>
          <option >21</option><option >22</option><option >23</option>
          <option >24</option><option >25</option><option >26</option>
          <option >27</option><option >28</option><option >29</option>
          <option >30</option><option >31</option><option >32</option>
          <option >33</option><option >34</option><option >35</option>
          <option >36</option><option >37</option><option >38</option>
          <option >39</option><option >40</option><option >41</option>
          <option >42</option><option >43</option><option >44</option>
          <option >45</option><option >46</option><option >47</option>
          <option >48</option><option >49</option><option >50</option>
          <option >51</option><option >52</option><option >53</option>
          <option >54</option><option >55</option><option >56</option>
          <option >57</option><option >58</option><option >59</option>
        </select>
      </td>
  </tr>
  <tr>
      <td width=30%><font size=2><b><% multilang("51" "LANG_TIME_ZONE"); %>:</b></td>
      <td width=70%>
       <select name="sys_tz">
          <option >UTC</option><option >ADT</option><option >AST</option>
          <option >EST</option><option >CST</option><option >MST</option>
        </select>
      </td>
  </tr>
</table>
<input type="hidden" value="/admin/date.asp" name="submit-url">
  <p><input type="submit" value="<% multilang("733" "LANG_SUBMIT"); %>" name="set">&nbsp;&nbsp;
  <input type="button" value="<% multilang("590" "LANG_CANCEL"); %>" name="close" onClick="javascript: window.close();"></p>
</form>
</blockquote>
</body>
</html>

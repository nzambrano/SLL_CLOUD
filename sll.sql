--------------------------------------------------------
-- Archivo creado  - miércoles-febrero-10-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type ID_ROLES_ARRAY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "ID_ROLES_ARRAY" AS TABLE OF VARCHAR2(30) ;

/
--------------------------------------------------------
--  DDL for Type JSON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "JSON" as object (
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  /* Variables */
  json_data json_value_array,
  check_for_duplicate number,

  /* Constructors */
  constructor function json return self as result,
  constructor function json(str varchar2) return self as result,
  constructor function json(str in clob) return self as result,
  constructor function json(cast json_value) return self as result,
  constructor function json(l in out nocopy json_list) return self as result,

  /* Member setter methods */  
  member procedure remove(pair_name varchar2),
  member procedure put(self in out nocopy json, pair_name varchar2, pair_value json_value, position pls_integer default null),
  member procedure put(self in out nocopy json, pair_name varchar2, pair_value varchar2, position pls_integer default null),
  member procedure put(self in out nocopy json, pair_name varchar2, pair_value number, position pls_integer default null),
  member procedure put(self in out nocopy json, pair_name varchar2, pair_value boolean, position pls_integer default null),
  member procedure check_duplicate(self in out nocopy json, v_set boolean),
  member procedure remove_duplicates(self in out nocopy json),

  /* deprecated putter use json_value */
  member procedure put(self in out nocopy json, pair_name varchar2, pair_value json, position pls_integer default null),
  member procedure put(self in out nocopy json, pair_name varchar2, pair_value json_list, position pls_integer default null),

  /* Member getter methods */ 
  member function count return number,
  member function get(pair_name varchar2) return json_value, 
  member function get(position pls_integer) return json_value,
  member function index_of(pair_name varchar2) return number,
  member function exist(pair_name varchar2) return boolean,

  /* Output methods */ 
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2,
  member procedure to_clob(self in json, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true),
  member procedure print(self in json, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null), --32512 is maximum
  member procedure htp(self in json, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null),

  member function to_json_value return json_value,
  /* json path */
  member function path(json_path varchar2, base number default 1) return json_value,

  /* json path_put */
  member procedure path_put(self in out nocopy json, json_path varchar2, elem json_value, base number default 1),
  member procedure path_put(self in out nocopy json, json_path varchar2, elem varchar2  , base number default 1),
  member procedure path_put(self in out nocopy json, json_path varchar2, elem number    , base number default 1),
  member procedure path_put(self in out nocopy json, json_path varchar2, elem boolean   , base number default 1),
  member procedure path_put(self in out nocopy json, json_path varchar2, elem json_list , base number default 1),
  member procedure path_put(self in out nocopy json, json_path varchar2, elem json      , base number default 1),

  /* json path_remove */
  member procedure path_remove(self in out nocopy json, json_path varchar2, base number default 1),

  /* map functions */
  member function get_values return json_list,
  member function get_keys return json_list

) not final;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "JSON" as

  /* Constructors */
  constructor function json return self as result as
  begin
    self.json_data := json_value_array();
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json(str varchar2) return self as result as
  begin
    self := json_parser.parser(str);
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json(str in clob) return self as result as
  begin
    self := json_parser.parser(str);
    self.check_for_duplicate := 1;
    return;
  end;  

  constructor function json(cast json_value) return self as result as
    x number;
  begin
    x := cast.object_or_array.getobject(self);
    self.check_for_duplicate := 1;
    return;
  end;

  constructor function json(l in out nocopy json_list) return self as result as
  begin
    for i in 1 .. l.list_data.count loop
      if(l.list_data(i).mapname is null or l.list_data(i).mapname like 'row%') then
      l.list_data(i).mapname := 'row'||i;
      end if;
      l.list_data(i).mapindx := i;
    end loop;

    self.json_data := l.list_data;
    self.check_for_duplicate := 1;
    return;
  end;

  /* Member setter methods */  
  member procedure remove(self in out nocopy json, pair_name varchar2) as
    temp json_value;
    indx pls_integer;

    function get_member(pair_name varchar2) return json_value as
      indx pls_integer;
    begin
      indx := json_data.first;
      loop
        exit when indx is null;
        if(pair_name is null and json_data(indx).mapname is null) then return json_data(indx); end if;
        if(json_data(indx).mapname = pair_name) then return json_data(indx); end if;
        indx := json_data.next(indx);
      end loop;
      return null;
    end;
  begin
    temp := get_member(pair_name);
    if(temp is null) then return; end if;

    indx := json_data.next(temp.mapindx);
    loop 
      exit when indx is null;
      json_data(indx).mapindx := indx - 1;
      json_data(indx-1) := json_data(indx);
      indx := json_data.next(indx);
    end loop;
    json_data.trim(1);
    --num_elements := num_elements - 1;
  end;

  member procedure put(self in out nocopy json, pair_name varchar2, pair_value json_value, position pls_integer default null) as
    insert_value json_value := nvl(pair_value, json_value.makenull);
    indx pls_integer; x number;
    temp json_value;
    function get_member(pair_name varchar2) return json_value as
      indx pls_integer;
    begin
      indx := json_data.first;
      loop
        exit when indx is null;
        if(pair_name is null and json_data(indx).mapname is null) then return json_data(indx); end if;
        if(json_data(indx).mapname = pair_name) then return json_data(indx); end if;
        indx := json_data.next(indx);
      end loop;
      return null;
    end;
  begin
    --dbms_output.put_line('PN '||pair_name);

--    if(pair_name is null) then 
--      raise_application_error(-20102, 'JSON put-method type error: name cannot be null');
--    end if;
    insert_value.mapname := pair_name;
--    self.remove(pair_name);
    if(self.check_for_duplicate = 1) then temp := get_member(pair_name); else temp := null; end if;
    if(temp is not null) then
      insert_value.mapindx := temp.mapindx;
      json_data(temp.mapindx) := insert_value; 
      return;
    elsif(position is null or position > self.count) then
      --insert at the end of the list
      --dbms_output.put_line('Test');
--      indx := self.count + 1;
      json_data.extend(1);
      json_data(json_data.count) := insert_value;
--      insert_value.mapindx := json_data.count;
      json_data(json_data.count).mapindx := json_data.count;
--      dbms_output.put_line('Test2'||insert_value.mapindx);
--      dbms_output.put_line('Test2'||insert_value.mapname);
--      insert_value.print(false);
--      self.print;
    elsif(position < 2) then
      --insert at the start of the list
      indx := json_data.last;
      json_data.extend;
      loop
        exit when indx is null;
        temp := json_data(indx);
        temp.mapindx := indx+1;
        json_data(temp.mapindx) := temp;
        indx := json_data.prior(indx);
      end loop;
      json_data(1) := insert_value;
      insert_value.mapindx := 1;
    else 
      --insert somewhere in the list
      indx := json_data.last; 
--      dbms_output.put_line('Test '||indx);
      json_data.extend;
--      dbms_output.put_line('Test '||indx);
      loop
--        dbms_output.put_line('Test '||indx);
        temp := json_data(indx);
        temp.mapindx := indx + 1;
        json_data(temp.mapindx) := temp;
        exit when indx = position;
        indx := json_data.prior(indx);
      end loop;
      json_data(position) := insert_value;
      json_data(position).mapindx := position;
    end if;
--    num_elements := num_elements + 1;
  end;

  member procedure put(self in out nocopy json, pair_name varchar2, pair_value varchar2, position pls_integer default null) as
  begin
    put(pair_name, json_value(pair_value), position);
  end;

  member procedure put(self in out nocopy json, pair_name varchar2, pair_value number, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, json_value(), position);
    else 
      put(pair_name, json_value(pair_value), position);
    end if;
  end;

  member procedure put(self in out nocopy json, pair_name varchar2, pair_value boolean, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, json_value(), position);
    else 
      put(pair_name, json_value(pair_value), position);
    end if;
  end;

  member procedure check_duplicate(self in out nocopy json, v_set boolean) as
  begin
    if(v_set) then 
      check_for_duplicate := 1;
    else 
      check_for_duplicate := 0;
    end if;
  end; 

  /* deprecated putters */

  member procedure put(self in out nocopy json, pair_name varchar2, pair_value json, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, json_value(), position);
    else 
      put(pair_name, pair_value.to_json_value, position);
    end if;
  end;

  member procedure put(self in out nocopy json, pair_name varchar2, pair_value json_list, position pls_integer default null) as
  begin
    if(pair_value is null) then
      put(pair_name, json_value(), position);
    else 
      put(pair_name, pair_value.to_json_value, position);
    end if;
  end;

  /* Member getter methods */ 
  member function count return number as
  begin
    return self.json_data.count;
  end;

  member function get(pair_name varchar2) return json_value as
    indx pls_integer;
  begin
    indx := json_data.first;
    loop
      exit when indx is null;
      if(pair_name is null and json_data(indx).mapname is null) then return json_data(indx); end if;
      if(json_data(indx).mapname = pair_name) then return json_data(indx); end if;
      indx := json_data.next(indx);
    end loop;
    return null;
  end;

  member function get(position pls_integer) return json_value as
  begin
    if(self.count >= position and position > 0) then
      return self.json_data(position);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function index_of(pair_name varchar2) return number as
    indx pls_integer;
  begin
    indx := json_data.first;
    loop
      exit when indx is null;
      if(pair_name is null and json_data(indx).mapname is null) then return indx; end if;
      if(json_data(indx).mapname = pair_name) then return indx; end if;
      indx := json_data.next(indx);
    end loop;
    return -1;
  end;

  member function exist(pair_name varchar2) return boolean as
  begin
    return (self.get(pair_name) is not null);
  end;

  /* Output methods */  
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin
    if(spaces is null) then
      return json_printer.pretty_print(self, line_length => chars_per_line);
    else 
      return json_printer.pretty_print(self, spaces, line_length => chars_per_line);
    end if;
  end;

  member procedure to_clob(self in json, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin
    if(spaces is null) then 
      json_printer.pretty_print(self, false, buf, line_length => chars_per_line, erase_clob => erase_clob);
    else 
      json_printer.pretty_print(self, spaces, buf, line_length => chars_per_line, erase_clob => erase_clob);
    end if;
  end;

  member procedure print(self in json, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as --32512 is the real maximum in sqldeveloper
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer.pretty_print(self, spaces, my_clob, case when (chars_per_line>32512) then 32512 else chars_per_line end);
    json_printer.dbms_output_clob(my_clob, json_printer.newline_char, jsonp);
    dbms_lob.freetemporary(my_clob);  
  end;

  member procedure htp(self in json, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as 
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer.pretty_print(self, spaces, my_clob, chars_per_line);
    json_printer.htp_output_clob(my_clob, jsonp);
    dbms_lob.freetemporary(my_clob);  
  end;

  member function to_json_value return json_value as
  begin
    return json_value(sys.anydata.convertobject(self));
  end;

  /* json path */
  member function path(json_path varchar2, base number default 1) return json_value as
  begin
    return json_ext.get_json_value(self, json_path, base);
  end path;

  /* json path_put */
  member procedure path_put(self in out nocopy json, json_path varchar2, elem json_value, base number default 1) as
  begin
    json_ext.put(self, json_path, elem, base);
  end path_put;

  member procedure path_put(self in out nocopy json, json_path varchar2, elem varchar2, base number default 1) as
  begin
    json_ext.put(self, json_path, elem, base);
  end path_put;

  member procedure path_put(self in out nocopy json, json_path varchar2, elem number, base number default 1) as
  begin
    if(elem is null) then 
      json_ext.put(self, json_path, json_value(), base);
    else 
      json_ext.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_put(self in out nocopy json, json_path varchar2, elem boolean, base number default 1) as
  begin
    if(elem is null) then 
      json_ext.put(self, json_path, json_value(), base);
    else 
      json_ext.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_put(self in out nocopy json, json_path varchar2, elem json_list, base number default 1) as
  begin
    if(elem is null) then 
      json_ext.put(self, json_path, json_value(), base);
    else 
      json_ext.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_put(self in out nocopy json, json_path varchar2, elem json, base number default 1) as
  begin
    if(elem is null) then 
      json_ext.put(self, json_path, json_value(), base);
    else 
      json_ext.put(self, json_path, elem, base);
    end if;
  end path_put;

  member procedure path_remove(self in out nocopy json, json_path varchar2, base number default 1) as
  begin 
    json_ext.remove(self, json_path, base);
  end path_remove;

  /* Thanks to Matt Nolan */
  member function get_keys return json_list as
    keys json_list;
    indx pls_integer;
  begin
    keys := json_list();
    indx := json_data.first;
    loop
      exit when indx is null;
      keys.append(json_data(indx).mapname);
      indx := json_data.next(indx);
    end loop;
    return keys;
  end;

  member function get_values return json_list as
    vals json_list := json_list();
  begin
    vals.list_data := self.json_data;
    return vals;
  end;

  member procedure remove_duplicates(self in out nocopy json) as
  begin
    json_parser.remove_duplicates(self);
  end remove_duplicates;


end;

/
--------------------------------------------------------
--  DDL for Type JSON_LIST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "JSON_LIST" as object (
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  list_data json_value_array,
  constructor function json_list return self as result,
  constructor function json_list(str varchar2) return self as result,
  constructor function json_list(str clob) return self as result,
  constructor function json_list(cast json_value) return self as result,

  member procedure append(self in out nocopy json_list, elem json_value, position pls_integer default null),
  member procedure append(self in out nocopy json_list, elem varchar2, position pls_integer default null),
  member procedure append(self in out nocopy json_list, elem number, position pls_integer default null),
  member procedure append(self in out nocopy json_list, elem boolean, position pls_integer default null),
  member procedure append(self in out nocopy json_list, elem json_list, position pls_integer default null),

  member procedure replace(self in out nocopy json_list, position pls_integer, elem json_value),
  member procedure replace(self in out nocopy json_list, position pls_integer, elem varchar2),
  member procedure replace(self in out nocopy json_list, position pls_integer, elem number),
  member procedure replace(self in out nocopy json_list, position pls_integer, elem boolean),
  member procedure replace(self in out nocopy json_list, position pls_integer, elem json_list),

  member function count return number,
  member procedure remove(self in out nocopy json_list, position pls_integer),
  member procedure remove_first(self in out nocopy json_list),
  member procedure remove_last(self in out nocopy json_list),
  member function get(position pls_integer) return json_value,
  member function head return json_value,
  member function last return json_value,
  member function tail return json_list,

  /* Output methods */ 
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2,
  member procedure to_clob(self in json_list, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true),
  member procedure print(self in json_list, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null), --32512 is maximum
  member procedure htp(self in json_list, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null),

  /* json path */
  member function path(json_path varchar2, base number default 1) return json_value,
  /* json path_put */
  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem json_value, base number default 1),
  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem varchar2  , base number default 1),
  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem number    , base number default 1),
  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem boolean   , base number default 1),
  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem json_list , base number default 1),

  /* json path_remove */
  member procedure path_remove(self in out nocopy json_list, json_path varchar2, base number default 1),

  member function to_json_value return json_value
  /* --backwards compatibility
  ,
  member procedure add_elem(self in out nocopy json_list, elem json_value, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list, elem varchar2, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list, elem number, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list, elem boolean, position pls_integer default null),
  member procedure add_elem(self in out nocopy json_list, elem json_list, position pls_integer default null),

  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem json_value),
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem varchar2),
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem number),
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem boolean),
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem json_list),

  member procedure remove_elem(self in out nocopy json_list, position pls_integer),
  member function get_elem(position pls_integer) return json_value,
  member function get_first return json_value,
  member function get_last return json_value
--  */

) not final;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "JSON_LIST" as

  constructor function json_list return self as result as
  begin
    self.list_data := json_value_array();
    return;
  end;

  constructor function json_list(str varchar2) return self as result as
  begin
    self := json_parser.parse_list(str);
    return;
  end;

  constructor function json_list(str clob) return self as result as
  begin
    self := json_parser.parse_list(str);
    return;
  end;

  constructor function json_list(cast json_value) return self as result as
    x number;
  begin
    x := cast.object_or_array.getobject(self);
    return;
  end;


  member procedure append(self in out nocopy json_list, elem json_value, position pls_integer default null) as
    indx pls_integer;
    insert_value json_value := NVL(elem, json_value);
  begin
    if(position is null or position > self.count) then --end of list
      indx := self.count + 1;
      self.list_data.extend(1);
      self.list_data(indx) := insert_value;
    elsif(position < 1) then --new first
      indx := self.count;
      self.list_data.extend(1);
      for x in reverse 1 .. indx loop
        self.list_data(x+1) := self.list_data(x);
      end loop;
      self.list_data(1) := insert_value;
    else
      indx := self.count;
      self.list_data.extend(1);
      for x in reverse position .. indx loop
        self.list_data(x+1) := self.list_data(x);
      end loop;
      self.list_data(position) := insert_value;
    end if;

  end;

  member procedure append(self in out nocopy json_list, elem varchar2, position pls_integer default null) as
  begin
    append(json_value(elem), position);
  end;

  member procedure append(self in out nocopy json_list, elem number, position pls_integer default null) as
  begin
    if(elem is null) then
      append(json_value(), position);
    else
      append(json_value(elem), position);
    end if;
  end;

  member procedure append(self in out nocopy json_list, elem boolean, position pls_integer default null) as
  begin
    if(elem is null) then
      append(json_value(), position);
    else
      append(json_value(elem), position);
    end if;
  end;

  member procedure append(self in out nocopy json_list, elem json_list, position pls_integer default null) as
  begin
    if(elem is null) then
      append(json_value(), position);
    else
      append(elem.to_json_value, position);
    end if;
  end;

 member procedure replace(self in out nocopy json_list, position pls_integer, elem json_value) as
    insert_value json_value := NVL(elem, json_value);
    indx number;
  begin
    if(position > self.count) then --end of list
      indx := self.count + 1;
      self.list_data.extend(1);
      self.list_data(indx) := insert_value;
    elsif(position < 1) then --maybe an error message here
      null;
    else
      self.list_data(position) := insert_value;
    end if;
  end;

  member procedure replace(self in out nocopy json_list, position pls_integer, elem varchar2) as
  begin
    replace(position, json_value(elem));
  end;

  member procedure replace(self in out nocopy json_list, position pls_integer, elem number) as
  begin
    if(elem is null) then
      replace(position, json_value());
    else
      replace(position, json_value(elem));
    end if;
  end;

  member procedure replace(self in out nocopy json_list, position pls_integer, elem boolean) as 
  begin
    if(elem is null) then
      replace(position, json_value());
    else
      replace(position, json_value(elem));
    end if;
  end;

  member procedure replace(self in out nocopy json_list, position pls_integer, elem json_list) as 
  begin
    if(elem is null) then
      replace(position, json_value());
    else
      replace(position, elem.to_json_value);
    end if;
  end;

  member function count return number as
  begin
    return self.list_data.count;
  end;

  member procedure remove(self in out nocopy json_list, position pls_integer) as
  begin
    if(position is null or position < 1 or position > self.count) then return; end if;
    for x in (position+1) .. self.count loop
      self.list_data(x-1) := self.list_data(x);
    end loop;
    self.list_data.trim(1);
  end;

  member procedure remove_first(self in out nocopy json_list) as 
  begin
    for x in 2 .. self.count loop
      self.list_data(x-1) := self.list_data(x);
    end loop;
    if(self.count > 0) then 
      self.list_data.trim(1);
    end if;
  end;

  member procedure remove_last(self in out nocopy json_list) as
  begin
    if(self.count > 0) then 
      self.list_data.trim(1);
    end if;
  end;

  member function get(position pls_integer) return json_value as
  begin
    if(self.count >= position and position > 0) then
      return self.list_data(position);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function head return json_value as
  begin
    if(self.count > 0) then
      return self.list_data(self.list_data.first);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function last return json_value as
  begin
    if(self.count > 0) then
      return self.list_data(self.list_data.last);
    end if;
    return null; -- do not throw error, just return null
  end;

  member function tail return json_list as
    t json_list;
  begin
    if(self.count > 0) then
      t := json_list(self.list_data);
      t.remove(1);
      return t;
    else return json_list(); end if;
  end;

  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin
    if(spaces is null) then
      return json_printer.pretty_print_list(self, line_length => chars_per_line);
    else 
      return json_printer.pretty_print_list(self, spaces, line_length => chars_per_line);
    end if;
  end;

  member procedure to_clob(self in json_list, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin
    if(spaces is null) then 
      json_printer.pretty_print_list(self, false, buf, line_length => chars_per_line, erase_clob => erase_clob);
    else 
      json_printer.pretty_print_list(self, spaces, buf, line_length => chars_per_line, erase_clob => erase_clob);
    end if;
  end;

  member procedure print(self in json_list, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as --32512 is the real maximum in sqldeveloper
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer.pretty_print_list(self, spaces, my_clob, case when (chars_per_line>32512) then 32512 else chars_per_line end);
    json_printer.dbms_output_clob(my_clob, json_printer.newline_char, jsonp);
    dbms_lob.freetemporary(my_clob);  
  end;

  member procedure htp(self in json_list, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as 
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer.pretty_print_list(self, spaces, my_clob, chars_per_line);
    json_printer.htp_output_clob(my_clob, jsonp);
    dbms_lob.freetemporary(my_clob);  
  end;

  /* json path */
  member function path(json_path varchar2, base number default 1) return json_value as
    cp json_list := self;
  begin
    return json_ext.get_json_value(json(cp), json_path, base);
  end path;


  /* json path_put */
  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem json_value, base number default 1) as
    objlist json;
    jp json_list := json_ext.parsePath(json_path, base); 
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(json_value());
    end loop;

    objlist := json(self);
    json_ext.put(objlist, json_path, elem, base);
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem varchar2, base number default 1) as
    objlist json;
    jp json_list := json_ext.parsePath(json_path, base); 
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(json_value());
    end loop;

    objlist := json(self);
    json_ext.put(objlist, json_path, elem, base);
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem number, base number default 1) as
    objlist json;
    jp json_list := json_ext.parsePath(json_path, base); 
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(json_value());
    end loop;

    objlist := json(self);

    if(elem is null) then 
      json_ext.put(objlist, json_path, json_value, base);
    else 
      json_ext.put(objlist, json_path, elem, base);
    end if;
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem boolean, base number default 1) as
    objlist json;
    jp json_list := json_ext.parsePath(json_path, base); 
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(json_value());
    end loop;

    objlist := json(self);
    if(elem is null) then 
      json_ext.put(objlist, json_path, json_value, base);
    else 
      json_ext.put(objlist, json_path, elem, base);
    end if;
    self := objlist.get_values;
  end path_put;

  member procedure path_put(self in out nocopy json_list, json_path varchar2, elem json_list, base number default 1) as
    objlist json;
    jp json_list := json_ext.parsePath(json_path, base); 
  begin
    while(jp.head().get_number() > self.count) loop
      self.append(json_value());
    end loop;

    objlist := json(self);
    if(elem is null) then 
      json_ext.put(objlist, json_path, json_value, base);
    else 
      json_ext.put(objlist, json_path, elem, base);
    end if;
    self := objlist.get_values;
  end path_put;

  /* json path_remove */
  member procedure path_remove(self in out nocopy json_list, json_path varchar2, base number default 1) as
    objlist json := json(self);
  begin
    json_ext.remove(objlist, json_path, base);
    self := objlist.get_values;
  end path_remove;


  member function to_json_value return json_value as
  begin
    return json_value(sys.anydata.convertobject(self));
  end;

  /*--backwards compatibility
  member procedure add_elem(self in out nocopy json_list, elem json_value, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list, elem varchar2, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list, elem number, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list, elem boolean, position pls_integer default null) as begin append(elem,position); end;
  member procedure add_elem(self in out nocopy json_list, elem json_list, position pls_integer default null) as begin append(elem,position); end;

  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem json_value) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem varchar2) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem number) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem boolean) as begin replace(position,elem); end;
  member procedure set_elem(self in out nocopy json_list, position pls_integer, elem json_list) as begin replace(position,elem); end;

  member procedure remove_elem(self in out nocopy json_list, position pls_integer) as begin remove(position); end;
  member function get_elem(position pls_integer) return json_value as begin return get(position); end;
  member function get_first return json_value as begin return head(); end;
  member function get_last return json_value as begin return last(); end;
--  */

end;

/
--------------------------------------------------------
--  DDL for Type JSON_VALUE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "JSON_VALUE" as object
( 
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  typeval number(1), /* 1 = object, 2 = array, 3 = string, 4 = number, 5 = bool, 6 = null */
  str varchar2(32767),
  num number, /* store 1 as true, 0 as false */
  object_or_array sys.anydata, /* object or array in here */
  extended_str clob,

  /* mapping */
  mapname varchar2(4000),
  mapindx number(32),  

  constructor function json_value(object_or_array sys.anydata) return self as result,
  constructor function json_value(str varchar2, esc boolean default true) return self as result,
  constructor function json_value(str clob, esc boolean default true) return self as result,
  constructor function json_value(num number) return self as result,
  constructor function json_value(b boolean) return self as result,
  constructor function json_value return self as result,
  static function makenull return json_value,

  member function get_type return varchar2,
  member function get_string(max_byte_size number default null, max_char_size number default null) return varchar2,
  member procedure get_string(self in json_value, buf in out nocopy clob),
  member function get_number return number,
  member function get_bool return boolean,
  member function get_null return varchar2,

  member function is_object return boolean,
  member function is_array return boolean,
  member function is_string return boolean,
  member function is_number return boolean,
  member function is_bool return boolean,
  member function is_null return boolean,

  /* Output methods */ 
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2,
  member procedure to_clob(self in json_value, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true),
  member procedure print(self in json_value, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null), --32512 is maximum
  member procedure htp(self in json_value, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null),

  member function value_of(self in json_value, max_byte_size number default null, max_char_size number default null) return varchar2

) not final;
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "JSON_VALUE" as

  constructor function json_value(object_or_array sys.anydata) return self as result as
  begin
    case object_or_array.gettypename
      when sys_context('userenv', 'current_schema')||'.JSON_LIST' then self.typeval := 2;
      when sys_context('userenv', 'current_schema')||'.JSON' then self.typeval := 1;
      else raise_application_error(-20102, 'JSON_Value init error (JSON or JSON\_List allowed)');
    end case;
    self.object_or_array := object_or_array;
    if(self.object_or_array is null) then self.typeval := 6; end if;

    return;
  end json_value;

  constructor function json_value(str varchar2, esc boolean default true) return self as result as
  begin
    self.typeval := 3;
    if(esc) then self.num := 1; else self.num := 0; end if; --message to pretty printer
    self.str := str;
    return;
  end json_value;

  constructor function json_value(str clob, esc boolean default true) return self as result as
    amount number := 32767;
  begin
    self.typeval := 3;
    if(esc) then self.num := 1; else self.num := 0; end if; --message to pretty printer
    if(dbms_lob.getlength(str) > 32767) then
      extended_str := str;
    end if;
    dbms_lob.read(str, amount, 1, self.str);
    return;
  end json_value;

  constructor function json_value(num number) return self as result as
  begin
    self.typeval := 4;
    self.num := num;
    if(self.num is null) then self.typeval := 6; end if;
    return;
  end json_value;

  constructor function json_value(b boolean) return self as result as
  begin
    self.typeval := 5;
    self.num := 0;
    if(b) then self.num := 1; end if;
    if(b is null) then self.typeval := 6; end if;
    return;
  end json_value;

  constructor function json_value return self as result as
  begin
    self.typeval := 6; /* for JSON null */
    return;
  end json_value;

  static function makenull return json_value as
  begin
    return json_value;
  end makenull;

  member function get_type return varchar2 as
  begin
    case self.typeval
    when 1 then return 'object';
    when 2 then return 'array';
    when 3 then return 'string';
    when 4 then return 'number';
    when 5 then return 'bool';
    when 6 then return 'null';
    end case;

    return 'unknown type';
  end get_type;

  member function get_string(max_byte_size number default null, max_char_size number default null) return varchar2 as
  begin
    if(self.typeval = 3) then 
      if(max_byte_size is not null) then 
        return substrb(self.str,1,max_byte_size);
      elsif (max_char_size is not null) then
        return substr(self.str,1,max_char_size);
      else
        return self.str;
      end if;
    end if;
    return null;
  end get_string;

  member procedure get_string(self in json_value, buf in out nocopy clob) as
  begin
    if(self.typeval = 3) then 
      if(extended_str is not null) then
        dbms_lob.copy(buf, extended_str, dbms_lob.getlength(extended_str));
      else
        dbms_lob.writeappend(buf, length(self.str), self.str);      
      end if;
    end if;
  end get_string;


  member function get_number return number as
  begin
    if(self.typeval = 4) then 
      return self.num;
    end if;
    return null;
  end get_number;

  member function get_bool return boolean as
  begin
    if(self.typeval = 5) then 
      return self.num = 1;
    end if;
    return null;
  end get_bool;

  member function get_null return varchar2 as
  begin
    if(self.typeval = 6) then 
      return 'null';
    end if;
    return null;
  end get_null;

  member function is_object return boolean as begin return self.typeval = 1; end;
  member function is_array return boolean as begin return self.typeval = 2; end;
  member function is_string return boolean as begin return self.typeval = 3; end;
  member function is_number return boolean as begin return self.typeval = 4; end;
  member function is_bool return boolean as begin return self.typeval = 5; end;
  member function is_null return boolean as begin return self.typeval = 6; end;

  /* Output methods */  
  member function to_char(spaces boolean default true, chars_per_line number default 0) return varchar2 as
  begin
    if(spaces is null) then
      return json_printer.pretty_print_any(self, line_length => chars_per_line);
    else 
      return json_printer.pretty_print_any(self, spaces, line_length => chars_per_line);
    end if;
  end;

  member procedure to_clob(self in json_value, buf in out nocopy clob, spaces boolean default false, chars_per_line number default 0, erase_clob boolean default true) as
  begin
    if(spaces is null) then 
      json_printer.pretty_print_any(self, false, buf, line_length => chars_per_line, erase_clob => erase_clob);
    else 
      json_printer.pretty_print_any(self, spaces, buf, line_length => chars_per_line, erase_clob => erase_clob);
    end if;
  end;

  member procedure print(self in json_value, spaces boolean default true, chars_per_line number default 8192, jsonp varchar2 default null) as --32512 is the real maximum in sqldeveloper
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer.pretty_print_any(self, spaces, my_clob, case when (chars_per_line>32512) then 32512 else chars_per_line end);
    json_printer.dbms_output_clob(my_clob, json_printer.newline_char, jsonp);
    dbms_lob.freetemporary(my_clob);  
  end;

  member procedure htp(self in json_value, spaces boolean default false, chars_per_line number default 0, jsonp varchar2 default null) as 
    my_clob clob;
  begin
    my_clob := empty_clob();
    dbms_lob.createtemporary(my_clob, true);
    json_printer.pretty_print_any(self, spaces, my_clob, chars_per_line);
    json_printer.htp_output_clob(my_clob, jsonp);
    dbms_lob.freetemporary(my_clob);  
  end;

  member function value_of(self in json_value, max_byte_size number default null, max_char_size number default null) return varchar2 as
  begin
    case self.typeval
    when 1 then return 'json object';
    when 2 then return 'json array';
    when 3 then return self.get_string(max_byte_size,max_char_size);
    when 4 then return self.get_number();
    when 5 then if(self.get_bool()) then return 'true'; else return 'false'; end if;
    else return null;
    end case;
  end;

end;

/
--------------------------------------------------------
--  DDL for Type JSON_VALUE_ARRAY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "JSON_VALUE_ARRAY" as table of json_value;

/
--------------------------------------------------------
--  DDL for Type TABLALITIGIOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "TABLALITIGIOS" as table of varchar2 (4000); 

/
--------------------------------------------------------
--  DDL for Type T_REG_01
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_REG_01" as object (
  FILA number,
  LEGAJO varchar2(30),
  PERIODO NUMBER
);

/
--------------------------------------------------------
--  DDL for Type T_REG_02
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_REG_02" as object (
  FILA number,
  LEGAJO varchar2(30),
  PERIODO NUMBER
);

/
--------------------------------------------------------
--  DDL for Type T_REG_03
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_REG_03" as object (
  FILA number,
  LEGAJO varchar2(30)
);

/
--------------------------------------------------------
--  DDL for Type T_TABLA_01
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_TABLA_01" as table of T_REG_01;

/
--------------------------------------------------------
--  DDL for Type T_TABLA_02
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_TABLA_02" as table of T_REG_02;

/
--------------------------------------------------------
--  DDL for Type T_TABLA_03
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "T_TABLA_03" as table of T_REG_03;

/
--------------------------------------------------------
--  DDL for Sequence SEQ_M4SLL_INT_GL_TRX_L_LOTE
--------------------------------------------------------

   CREATE SEQUENCE  "SEQ_M4SLL_INT_GL_TRX_L_LOTE"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 6741 CACHE 20 NOORDER  NOCYCLE   ;
--------------------------------------------------------
--  DDL for Table MLOG$_M4SLL_ESP_CIUDADES
--------------------------------------------------------

  CREATE TABLE "MLOG$_M4SLL_ESP_CIUDADES" 
   (	"M_ROW$$" VARCHAR2(255), 
	"SNAPTIME$$" DATE, 
	"DMLTYPE$$" VARCHAR2(1), 
	"OLD_NEW$$" VARCHAR2(1), 
	"CHANGE_VECTOR$$" RAW(255), 
	"XID$$" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 30 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);

   COMMENT ON TABLE "MLOG$_M4SLL_ESP_CIUDADES"  IS 'snapshot log for master table M4GLOBAL.M4SLL_ESP_CIUDADES';
--------------------------------------------------------
--  DDL for Table MLOG$_M4SLL_LITIGIOS
--------------------------------------------------------

  CREATE TABLE "MLOG$_M4SLL_LITIGIOS" 
   (	"M_ROW$$" VARCHAR2(255), 
	"SNAPTIME$$" DATE, 
	"DMLTYPE$$" VARCHAR2(1), 
	"OLD_NEW$$" VARCHAR2(1), 
	"CHANGE_VECTOR$$" RAW(255), 
	"XID$$" NUMBER, 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"ID_ORGANIZATION" VARCHAR2(4), 
	"ECI_ID_CIUDAD" VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 30 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);

   COMMENT ON TABLE "MLOG$_M4SLL_LITIGIOS"  IS 'snapshot log for master table M4GLOBAL.M4SLL_LITIGIOS';
--------------------------------------------------------
--  DDL for Table M4SLL_ABOHON_NJ
--------------------------------------------------------

  CREATE TABLE "M4SLL_ABOHON_NJ" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ANJ_SECUENCIA" NUMBER(10,0), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"ANJ_OBSERVACION" VARCHAR2(1000 CHAR), 
	"ANJ_MONTO" NUMBER(18,4), 
	"ANJ_DT_START" DATE, 
	"ANJ_DT_END" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ASIENTOS_C
--------------------------------------------------------

  CREATE TABLE "M4SLL_ASIENTOS_C" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PAG_SECUENCIA" NUMBER(10,0), 
	"HDP_DT_PERIODO" DATE, 
	"ORIGEN" VARCHAR2(20 CHAR), 
	"GRUPO" NUMBER(9,0), 
	"LOTE" NUMBER(15,0), 
	"DESCRIP" VARCHAR2(30 CHAR), 
	"STATUS" VARCHAR2(10 CHAR), 
	"ASIENTO" NUMBER(15,0), 
	"CANT_ASIENTO" NUMBER(6,0), 
	"CREATION_DATE" DATE, 
	"ID_APPROLE2" VARCHAR2(30 CHAR), 
	"ID_SECUSER2" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE2" DATE, 
	"XX_FUN" VARCHAR2(100 CHAR), 
	"XX_EST" VARCHAR2(30 CHAR), 
	"XX_ERROR" VARCHAR2(2000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ASIENTOS_D
--------------------------------------------------------

  CREATE TABLE "M4SLL_ASIENTOS_D" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PAG_SECUENCIA" NUMBER(10,0), 
	"HDP_DT_PERIODO" DATE, 
	"ASD_SECUENCIA" NUMBER(10,0), 
	"ORIGEN" VARCHAR2(20 CHAR), 
	"GRUPO" NUMBER(10,2), 
	"LOTE" NUMBER(15,0), 
	"MONEDA" VARCHAR2(15 CHAR), 
	"FCREA" VARCHAR2(10 CHAR), 
	"UCREA" VARCHAR2(15 CHAR), 
	"CATEGORIA" VARCHAR2(25 CHAR), 
	"CTACBLE" VARCHAR2(250 CHAR), 
	"EMPRESA" VARCHAR2(3 CHAR), 
	"RENGLON" NUMBER(15,0), 
	"FECCONT" VARCHAR2(10 CHAR), 
	"PAIS" VARCHAR2(2 CHAR), 
	"DIVISION" VARCHAR2(4 CHAR), 
	"DEPTO" VARCHAR2(4 CHAR), 
	"ACTIV" VARCHAR2(1 CHAR), 
	"VALDB" VARCHAR2(20 CHAR), 
	"VALCR" VARCHAR2(20 CHAR), 
	"FGRAB" VARCHAR2(10 CHAR), 
	"HGRAB" VARCHAR2(8 CHAR), 
	"STATUS" VARCHAR2(30 CHAR), 
	"TCIDEA" VARCHAR2(4 CHAR), 
	"SCIDEA" VARCHAR2(4 CHAR), 
	"NCIDEA" VARCHAR2(15 CHAR), 
	"DLOTE" VARCHAR2(30 CHAR), 
	"IMPDB" VARCHAR2(20 CHAR), 
	"IMPCR" VARCHAR2(20 CHAR), 
	"TASACON" VARCHAR2(20 CHAR), 
	"FCONMON" VARCHAR2(10 CHAR), 
	"NOMASIEN" VARCHAR2(60 CHAR), 
	"DASIEN" VARCHAR2(60 CHAR), 
	"HISTORICO" VARCHAR2(512 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_AU_REU_ANALI
--------------------------------------------------------

  CREATE TABLE "M4SLL_AU_REU_ANALI" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"ARA_SECUENCIA" NUMBER(10,0), 
	"ARA_CENTRO_COSTO" VARCHAR2(30), 
	"ARA_SEGMENTO" VARCHAR2(30), 
	"ARA_DIVISION" VARCHAR2(30), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"ARA_REGION" VARCHAR2(30), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_AUTOR_REU
--------------------------------------------------------

  CREATE TABLE "M4SLL_AUTOR_REU" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"STD_OR_HR_PERIOD" NUMBER(10,0), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"AUR_AUTOR_REU" VARCHAR2(1), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"STD_ID_PERSON" VARCHAR2(10), 
	"AUR_EMAIL" VARCHAR2(1000), 
	"AUR_NOMBRE_ABOGADO" VARCHAR2(1000), 
	"AUR_TELEFONO" NUMBER(18,4), 
	"AUR_OBSERVACIONES" VARCHAR2(1000), 
	"AUR_CK_PRINCIPAL" VARCHAR2(1), 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"AUR_CK_SUBSIDIARIO" VARCHAR2(1), 
	"AUR_CK_SOLIDARIO" VARCHAR2(1), 
	"AUR_MONTO_INDEMNIZACION" NUMBER(14,4), 
	"AUR_CAUSA_DESVINCULACION" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"ECI_ID_CIUDAD" VARCHAR2(3 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_AUTOR_REU_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_AUTOR_REU_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"AUR_AUTOR_REU" VARCHAR2(1), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"STD_ID_PERSON" VARCHAR2(10 CHAR), 
	"AUR_EMAIL" VARCHAR2(1000), 
	"AUR_NOMBRE_ABOGADO" VARCHAR2(1000), 
	"AUR_TELEFONO" NUMBER(18,4), 
	"AUR_OBSERVACIONES" VARCHAR2(1000), 
	"AUR_CK_PRINCIPAL" VARCHAR2(1), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"AUR_CK_SUBSIDIARIO" VARCHAR2(1 CHAR), 
	"AUR_CK_SOLIDARIO" VARCHAR2(1 CHAR), 
	"AUR_MONTO_INDEMNIZACION" NUMBER(14,4), 
	"AUR_CAUSA_DESVINCULACION" VARCHAR2(254 CHAR), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3 CHAR), 
	"MAB_SECUENCIA" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_AUTOR_REU_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_AUTOR_REU_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"STD_OR_HR_PERIOD" NUMBER(10,0), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"AUR_AUTOR_REU" VARCHAR2(1), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"STD_ID_PERSON" VARCHAR2(10), 
	"AUR_EMAIL" VARCHAR2(1000), 
	"AUR_NOMBRE_ABOGADO" VARCHAR2(1000), 
	"AUR_TELEFONO" NUMBER(18,4), 
	"AUR_OBSERVACIONES" VARCHAR2(1000), 
	"AUR_CK_PRINCIPAL" VARCHAR2(1), 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"AUR_CK_SUBSIDIARIO" VARCHAR2(1), 
	"AUR_CK_SOLIDARIO" VARCHAR2(1), 
	"AUR_MONTO_INDEMNIZACION" NUMBER(14,4), 
	"AUR_CAUSA_DESVINCULACION" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_AUTOR_REU_QA
--------------------------------------------------------

  CREATE TABLE "M4SLL_AUTOR_REU_QA" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"AUR_AUTOR_REU" VARCHAR2(1), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"STD_ID_PERSON" VARCHAR2(10 CHAR), 
	"AUR_EMAIL" VARCHAR2(1000), 
	"AUR_NOMBRE_ABOGADO" VARCHAR2(1000), 
	"AUR_TELEFONO" NUMBER(18,4), 
	"AUR_OBSERVACIONES" VARCHAR2(1000), 
	"AUR_CK_PRINCIPAL" VARCHAR2(1), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_AUTOR_REU_1
--------------------------------------------------------

  CREATE TABLE "M4SLL_AUTOR_REU_1" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"AUR_AUTOR_REU" VARCHAR2(1), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"STD_ID_PERSON" VARCHAR2(10 CHAR), 
	"AUR_EMAIL" VARCHAR2(1000), 
	"AUR_NOMBRE_ABOGADO" VARCHAR2(1000), 
	"AUR_TELEFONO" NUMBER(18,4), 
	"AUR_OBSERVACIONES" VARCHAR2(1000), 
	"AUR_CK_PRINCIPAL" VARCHAR2(1), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_AUT_REU_DOC
--------------------------------------------------------

  CREATE TABLE "M4SLL_AUT_REU_DOC" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"AUR_SECUENCIA" NUMBER(10,0), 
	"ARD_SECUENCIA" NUMBER(10,0), 
	"ARD_URL_DOCUMENTO" VARCHAR2(1000), 
	"ARD_FECHA_DOCUMENTO" DATE, 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CASUIS_CTAS
--------------------------------------------------------

  CREATE TABLE "M4SLL_CASUIS_CTAS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"CCU_CASO" VARCHAR2(2), 
	"CCU_NRO_ASIENTO" VARCHAR2(2), 
	"CCU_DEBE_HABER" VARCHAR2(1), 
	"CCU_CUENTA" VARCHAR2(10), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CASUIS_CTAS_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_CASUIS_CTAS_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"CCU_CASO" VARCHAR2(2), 
	"CCU_NRO_ASIENTO" VARCHAR2(2), 
	"CCU_DEBE_HABER" VARCHAR2(1), 
	"CCU_CUENTA" VARCHAR2(10), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDC
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDC" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJC_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJC_DESPACHO" VARCHAR2(254 CHAR), 
	"RJC_PONENTE" VARCHAR2(254 CHAR), 
	"RJC_TIPO" VARCHAR2(254 CHAR), 
	"RJC_CLASE" VARCHAR2(254 CHAR), 
	"RJC_RECURSO" VARCHAR2(254 CHAR), 
	"RJC_UBICACION_EXPEDIENTE" VARCHAR2(254 CHAR), 
	"RJC_DEMANDANTE" VARCHAR2(1000 CHAR), 
	"RJC_DEMANDADO" VARCHAR2(1000 CHAR), 
	"RJC_CONTENIDO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
  GRANT UPDATE ON "M4SLL_CCB_RAMAJUDC" TO "RBLATLEG001";
  GRANT DELETE ON "M4SLL_CCB_RAMAJUDC" TO "RBLATLEG001";
  GRANT INSERT ON "M4SLL_CCB_RAMAJUDC" TO "RBLATLEG001";
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDC_10
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDC_10" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJC_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJC_DESPACHO" VARCHAR2(254 CHAR), 
	"RJC_PONENTE" VARCHAR2(254 CHAR), 
	"RJC_TIPO" VARCHAR2(254 CHAR), 
	"RJC_CLASE" VARCHAR2(254 CHAR), 
	"RJC_RECURSO" VARCHAR2(254 CHAR), 
	"RJC_UBICACION_EXPEDIENTE" VARCHAR2(254 CHAR), 
	"RJC_DEMANDANTE" VARCHAR2(1000 CHAR), 
	"RJC_DEMANDADO" VARCHAR2(1000 CHAR), 
	"RJC_CONTENIDO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDC_20
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDC_20" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJC_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJC_DESPACHO" VARCHAR2(254 CHAR), 
	"RJC_PONENTE" VARCHAR2(254 CHAR), 
	"RJC_TIPO" VARCHAR2(254 CHAR), 
	"RJC_CLASE" VARCHAR2(254 CHAR), 
	"RJC_RECURSO" VARCHAR2(254 CHAR), 
	"RJC_UBICACION_EXPEDIENTE" VARCHAR2(254 CHAR), 
	"RJC_DEMANDANTE" VARCHAR2(1000 CHAR), 
	"RJC_DEMANDADO" VARCHAR2(1000 CHAR), 
	"RJC_CONTENIDO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDD
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDD" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJD_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJD_DT_ACTUALIZACION" DATE, 
	"RJD_ACTUACION" VARCHAR2(1000 CHAR), 
	"RJD_ANOTACION" VARCHAR2(1000 CHAR), 
	"RJD_DT_INICIO_TERMINO" DATE, 
	"RJD_DT_FIN_TERMINO" DATE, 
	"RJD_DT_REGISTRO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
  GRANT UPDATE ON "M4SLL_CCB_RAMAJUDD" TO "RBLATLEG001";
  GRANT DELETE ON "M4SLL_CCB_RAMAJUDD" TO "RBLATLEG001";
  GRANT INSERT ON "M4SLL_CCB_RAMAJUDD" TO "RBLATLEG001";
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDD_10
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDD_10" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJD_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJD_DT_ACTUALIZACION" DATE, 
	"RJD_ACTUACION" VARCHAR2(1000 CHAR), 
	"RJD_ANOTACION" VARCHAR2(1000 CHAR), 
	"RJD_DT_INICIO_TERMINO" DATE, 
	"RJD_DT_FIN_TERMINO" DATE, 
	"RJD_DT_REGISTRO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDD_1000
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDD_1000" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJD_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJD_DT_ACTUALIZACION" DATE, 
	"RJD_ACTUACION" VARCHAR2(1000 CHAR), 
	"RJD_ANOTACION" VARCHAR2(1000 CHAR), 
	"RJD_DT_INICIO_TERMINO" DATE, 
	"RJD_DT_FIN_TERMINO" DATE, 
	"RJD_DT_REGISTRO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDD2
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDD2" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJD_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJD_DT_ACTUALIZACION" DATE, 
	"RJD_ACTUACION" VARCHAR2(1000 CHAR), 
	"RJD_ANOTACION" VARCHAR2(1000 CHAR), 
	"RJD_DT_INICIO_TERMINO" DATE, 
	"RJD_DT_FIN_TERMINO" DATE, 
	"RJD_DT_REGISTRO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RAMAJUDD_20
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RAMAJUDD_20" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJD_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJD_DT_ACTUALIZACION" DATE, 
	"RJD_ACTUACION" VARCHAR2(1000 CHAR), 
	"RJD_ANOTACION" VARCHAR2(1000 CHAR), 
	"RJD_DT_INICIO_TERMINO" DATE, 
	"RJD_DT_FIN_TERMINO" DATE, 
	"RJD_DT_REGISTRO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RJCC_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RJCC_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJC_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJC_DESPACHO" VARCHAR2(254 CHAR), 
	"RJC_PONENTE" VARCHAR2(254 CHAR), 
	"RJC_TIPO" VARCHAR2(254 CHAR), 
	"RJC_CLASE" VARCHAR2(254 CHAR), 
	"RJC_RECURSO" VARCHAR2(254 CHAR), 
	"RJC_UBICACION_EXPEDIENTE" VARCHAR2(254 CHAR), 
	"RJC_DEMANDANTE" VARCHAR2(1000 CHAR), 
	"RJC_DEMANDADO" VARCHAR2(1000 CHAR), 
	"RJC_CONTENIDO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CCB_RJCD_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_CCB_RJCD_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RJD_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"RJD_DT_ACTUALIZACION" DATE, 
	"RJD_ACTUACION" VARCHAR2(1000 CHAR), 
	"RJD_ANOTACION" VARCHAR2(1000 CHAR), 
	"RJD_DT_INICIO_TERMINO" DATE, 
	"RJD_DT_FIN_TERMINO" DATE, 
	"RJD_DT_REGISTRO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CIERRE_MENSUAL
--------------------------------------------------------

  CREATE TABLE "M4SLL_CIERRE_MENSUAL" 
   (	"CIM_ANIO" VARCHAR2(4), 
	"CIM_MES" VARCHAR2(2), 
	"ID_TAREA" VARCHAR2(3), 
	"ESTADO_TAREA" VARCHAR2(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING;
--------------------------------------------------------
--  DDL for Table M4SLL_CIERRES_MENS
--------------------------------------------------------

  CREATE TABLE "M4SLL_CIERRES_MENS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"CIM_ANIO" VARCHAR2(4 CHAR), 
	"CIM_MES" VARCHAR2(2 CHAR), 
	"MTC_ID_TAREA" VARCHAR2(3 CHAR), 
	"MEE_ID_EST_EJECUCION" VARCHAR2(3 CHAR), 
	"MET_ID_EST_TAREA" VARCHAR2(3 CHAR), 
	"CIM_DT_EJECUCION" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CLIENTES_OMB
--------------------------------------------------------

  CREATE TABLE "M4SLL_CLIENTES_OMB" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"CLO_ID_CLIENTE" VARCHAR2(3), 
	"CLO_NM_CLIENTE" VARCHAR2(100), 
	"CLO_DT_START" DATE, 
	"CLO_DT_END" DATE, 
	"CLO_ID_APP_ROLE" VARCHAR2(50), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CLIENTES_ROL
--------------------------------------------------------

  CREATE TABLE "M4SLL_CLIENTES_ROL" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"CLO_ID_CLIENTE" VARCHAR2(3), 
	"CLR_ID_ROLE" VARCHAR2(255), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(10), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_COMP_DETALLE
--------------------------------------------------------

  CREATE TABLE "M4SLL_COMP_DETALLE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"COM_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"COE_ID_COMP_ESTADO" VARCHAR2(3 CHAR), 
	"COR_ID_COMP_RESULTADO" VARCHAR2(3 CHAR), 
	"COD_FECHA" DATE, 
	"COD_OBSERVACION" VARCHAR2(1000 CHAR), 
	"COD_SECUENCIA" NUMBER(10,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_COMP_DOC
--------------------------------------------------------

  CREATE TABLE "M4SLL_COMP_DOC" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"TCO_ID_TP_COMPROMISO" VARCHAR2(3 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"COD_SECUENCIA" NUMBER(10,0), 
	"COM_SECUENCIA" NUMBER(10,0), 
	"COD_URL_DOCUMENTO" VARCHAR2(1000 CHAR), 
	"COD_FECHA_DOC" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_COMP_ESTADOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_COMP_ESTADOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"COE_ID_COMP_ESTADO" VARCHAR2(3), 
	"COE_NM_COMP_ESTADO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"COE_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"COE_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_COMP_RESULTA
--------------------------------------------------------

  CREATE TABLE "M4SLL_COMP_RESULTA" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"COR_ID_COMP_RESULTADO" VARCHAR2(3), 
	"COR_NM_COMP_RESULTADO" VARCHAR2(254), 
	"TCO_ID_TP_COMPROMISO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"COR_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"COR_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_COMPROMISOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_COMPROMISOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TCO_ID_TP_COMPROMISO" VARCHAR2(3), 
	"COM_SECUENCIA" NUMBER(10,0), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"COR_ID_COMP_RESULTADO" VARCHAR2(3), 
	"COM_FECHA" DATE, 
	"COM_OBSERVACION" VARCHAR2(1000), 
	"COE_ID_COMP_ESTADO" VARCHAR2(3), 
	"COM_DT_END" DATE, 
	"COM_RESPONSABLE" VARCHAR2(30), 
	"COM_DT_INICIO" DATE, 
	"COM_ACTUACION" VARCHAR2(1000 CHAR), 
	"COM_NOTAS" VARCHAR2(254), 
	"COM_DT_INICIO_TERMINO" DATE, 
	"COM_DT_FIN_TERMINO" DATE, 
	"COM_DT_REGISTRO" DATE, 
	"COM_URL_DOCUMENTO" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"COM_NM_DOCUMENTO" VARCHAR2(2000 CHAR), 
	"COM_SECUENCIAL" NUMBER(15,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_COMPROMISOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_COMPROMISOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"TCO_ID_TP_COMPROMISO" VARCHAR2(3 CHAR), 
	"COM_SECUENCIA" NUMBER(10,0), 
	"TFA_ID_TP_FASE" VARCHAR2(3 CHAR), 
	"COR_ID_COMP_RESULTADO" VARCHAR2(3 CHAR), 
	"COM_FECHA" DATE, 
	"COM_OBSERVACION" VARCHAR2(1000 CHAR), 
	"COE_ID_COMP_ESTADO" VARCHAR2(3 CHAR), 
	"COM_DT_END" DATE, 
	"COM_RESPONSABLE" VARCHAR2(30 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"COM_DT_INICIO" DATE, 
	"COM_ACTUACION" VARCHAR2(254 CHAR), 
	"COM_NOTAS" VARCHAR2(254 CHAR), 
	"COM_DT_INICIO_TERMINO" DATE, 
	"COM_DT_FIN_TERMINO" DATE, 
	"COM_DT_REGISTRO" DATE, 
	"COM_URL_DOCUMENTO" VARCHAR2(1000 CHAR), 
	"MAB_SECUENCIA" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CONVERSION
--------------------------------------------------------

  CREATE TABLE "M4SLL_CONVERSION" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"CON_REFERENCIA" VARCHAR2(254), 
	"CON_VALOR_CONVERTIDO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_COTIZACION
--------------------------------------------------------

  CREATE TABLE "M4SLL_COTIZACION" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"COT_ANIO" NUMBER(10,0), 
	"COT_MES" NUMBER(10,0), 
	"COT_COTIZACION" NUMBER(18,2), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CPE_CEJPJ_C
--------------------------------------------------------

  CREATE TABLE "M4SLL_CPE_CEJPJ_C" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAS_NRO_RADICACION" VARCHAR2(30 CHAR), 
	"CCC_DEMANDANTE" VARCHAR2(4000 CHAR), 
	"CCC_DEMANDADO" VARCHAR2(4000 CHAR), 
	"CCC_ORGANO" VARCHAR2(254 CHAR), 
	"CCC_DISTRITO" VARCHAR2(254 CHAR), 
	"CCC_JUEZ" VARCHAR2(254 CHAR), 
	"CCC_FECHA_INICIO" DATE, 
	"CCC_PROCESO" VARCHAR2(254 CHAR), 
	"CCC_ESPECIALIDAD" VARCHAR2(254 CHAR), 
	"CCC_MATERIA" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
  GRANT UPDATE ON "M4SLL_CPE_CEJPJ_C" TO "RBLATLEG001";
  GRANT SELECT ON "M4SLL_CPE_CEJPJ_C" TO "RBLATLEG001";
  GRANT DELETE ON "M4SLL_CPE_CEJPJ_C" TO "RBLATLEG001";
  GRANT INSERT ON "M4SLL_CPE_CEJPJ_C" TO "RBLATLEG001";
--------------------------------------------------------
--  DDL for Table M4SLL_CPE_CEJPJ_D
--------------------------------------------------------

  CREATE TABLE "M4SLL_CPE_CEJPJ_D" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"CCD_ID_SECUENCIA" NUMBER(10,0), 
	"CCD_SUMILLA_SEGUIMIENTO" VARCHAR2(4000 CHAR), 
	"CCD_FECHA_SEGUIMIENTO" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
  GRANT UPDATE ON "M4SLL_CPE_CEJPJ_D" TO "RBLATLEG001";
  GRANT SELECT ON "M4SLL_CPE_CEJPJ_D" TO "RBLATLEG001";
  GRANT INSERT ON "M4SLL_CPE_CEJPJ_D" TO "RBLATLEG001";
  GRANT DELETE ON "M4SLL_CPE_CEJPJ_D" TO "RBLATLEG001";
--------------------------------------------------------
--  DDL for Table M4SLL_CTRL_ERRORES
--------------------------------------------------------

  CREATE TABLE "M4SLL_CTRL_ERRORES" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"CTE_USUARIO" VARCHAR2(10 CHAR), 
	"CTE_FECHA" DATE, 
	"CTE_MODULO" VARCHAR2(254 CHAR), 
	"CTE_DESCRIPCION" CLOB, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50)
 LOB ("CTE_DESCRIPCION") STORE AS BASICFILE (ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ;
--------------------------------------------------------
--  DDL for Table M4SLL_CUADRANTE
--------------------------------------------------------

  CREATE TABLE "M4SLL_CUADRANTE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ORDINAL_10_PK" NUMBER(10,0), 
	"ARG_CSP_COD_EMPR" VARCHAR2(254 CHAR), 
	"ARG_CSP_NOM_EMPR" VARCHAR2(254 CHAR), 
	"ARG_CSP_SSN" VARCHAR2(254 CHAR), 
	"ARG_CSP_ID_HR" VARCHAR2(254 CHAR), 
	"ARG_CSP_OR_HR_PER" NUMBER(4,0), 
	"ARG_CSP_N_FIRST_NAME" VARCHAR2(254 CHAR), 
	"ARG_CSP_COD_ACT" VARCHAR2(254 CHAR), 
	"ARG_CSP_COD_DELEG" VARCHAR2(254 CHAR), 
	"ARG_CSP_NOM_DELEG" VARCHAR2(254 CHAR), 
	"ARG_CSP_ANNO_MES" VARCHAR2(254 CHAR), 
	"ARG_CSP_FEC_MOBRA" DATE, 
	"ARG_CSP_COD_CLI" VARCHAR2(254 CHAR), 
	"ARG_CSP_NOM_CLI" VARCHAR2(254 CHAR), 
	"ARG_CSP_COD_SER" VARCHAR2(254 CHAR), 
	"ARG_CSP_NOM_SER" VARCHAR2(254 CHAR), 
	"ARG_CSP_FI_SERVI" DATE, 
	"ARG_CSP_HORA_FI_SERVI" VARCHAR2(254 CHAR), 
	"ARG_CSP_FF_SERVI" DATE, 
	"ARG_CSP_HORA_FF_SERVI" VARCHAR2(254 CHAR), 
	"ARG_CSP_HORAS_NOCT" VARCHAR2(254 CHAR), 
	"ARG_CSP_HORAS_DIUR" VARCHAR2(254 CHAR), 
	"ARG_CSP_FIN_FEST" VARCHAR2(254 CHAR), 
	"ARG_CSP_ARMA" VARCHAR2(254 CHAR), 
	"ARG_CSP_DIA_SEMANA" VARCHAR2(254 CHAR), 
	"ARG_CSP_FESTIVO" VARCHAR2(254 CHAR), 
	"CUA_CK_CLIENTE" NUMBER(1,0), 
	"CUA_CK_OBJETIVO" NUMBER(1,0), 
	"CUA_CK_GT_HORAS" NUMBER(1,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_CUADRANTE_LOG
--------------------------------------------------------

  CREATE TABLE "M4SLL_CUADRANTE_LOG" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"CLG_SQLCOD_ERROR" NUMBER, 
	"CLG_SQLMSG_ERROR" VARCHAR2(500), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_DATOS_WF
--------------------------------------------------------

  CREATE TABLE "M4SLL_DATOS_WF" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ID_BPC" VARCHAR2(10 CHAR), 
	"MODULO" VARCHAR2(10 CHAR), 
	"ID_MODULE" VARCHAR2(10 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_DESTINATARIO
--------------------------------------------------------

  CREATE TABLE "M4SLL_DESTINATARIO" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"DES_ID_DESTINATARIO" VARCHAR2(3), 
	"DES_NM_DESTINATARIO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_DOC_LITIGIOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_DOC_LITIGIOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"DOL_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TDL_ID_TP_DOC_LITIGIO" VARCHAR2(3), 
	"DOL_FECHA" DATE, 
	"DOL_OBSERVACION" VARCHAR2(1000), 
	"DOL_URL_DOC_LIT" VARCHAR2(1000), 
	"DOO_ID_DOC_ORIGEN" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TFA_ID_TP_FASE" VARCHAR2(3 CHAR), 
	"DOL_CK_ASOCIA_FASE" VARCHAR2(1 CHAR) DEFAULT 'N', 
	"DOL_NOMBRE" VARCHAR2(254 CHAR), 
	"DOL_DT_NOTIFICACION" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_DOC_LITIGIOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_DOC_LITIGIOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"DOL_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TDL_ID_TP_DOC_LITIGIO" VARCHAR2(3), 
	"DOL_FECHA" DATE, 
	"DOL_OBSERVACION" VARCHAR2(1000), 
	"DOL_URL_DOC_LIT" VARCHAR2(1000), 
	"DOO_ID_DOC_ORIGEN" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TFA_ID_TP_FASE" VARCHAR2(3 CHAR), 
	"DOL_CK_ASOCIA_FASE" VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_DOC_ORIGENES
--------------------------------------------------------

  CREATE TABLE "M4SLL_DOC_ORIGENES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"DOO_ID_DOC_ORIGEN" VARCHAR2(3), 
	"DOO_NM_DOC_ORIGEN" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_DOCPAG
--------------------------------------------------------

  CREATE TABLE "M4SLL_DOCPAG" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"DCP_SECUENCIA" NUMBER(10,0), 
	"DCP_DESCRIPCION" VARCHAR2(2000), 
	"DCP_FEC_CRE" DATE, 
	"DCP_NRO_SOLICITUD" NUMBER(10,0), 
	"DCP_APROB_ABOGADO_INT" VARCHAR2(254), 
	"DCP_APROB_BACK_OFFICE" VARCHAR2(254), 
	"DCP_APROB_GERENCIAL" VARCHAR2(254), 
	"DCP_STATUS" NUMBER(1,0), 
	"DCP_NRO_IDENTIFICACION" VARCHAR2(254), 
	"DCP_DESTINATARIO" VARCHAR2(2000), 
	"DCP_TIPO_CUENTA" VARCHAR2(254), 
	"DCP_NRO_CUENTA_DES" VARCHAR2(254), 
	"DCP_EMAIL_DEST" VARCHAR2(2000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"DCP_DESTINATARI1" VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ENTIDADES
--------------------------------------------------------

  CREATE TABLE "M4SLL_ENTIDADES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"ENT_ID_ENTIDAD" VARCHAR2(3), 
	"ENT_NM_ENTIDAD" VARCHAR2(254), 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"ENT_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"ENT_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"ENT_TP_EMPLEADO" VARCHAR2(10 CHAR), 
	"ENT_ID_NEGOCIO" VARCHAR2(10 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ENTIDADES_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_ENTIDADES_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"ENT_NRO_IDENTIFICACION" VARCHAR2(254), 
	"ENT_ID_ENTIDAD" VARCHAR2(3), 
	"ENT_NM_ENTIDAD" VARCHAR2(254), 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ESP_CIUDADES
--------------------------------------------------------

  CREATE TABLE "M4SLL_ESP_CIUDADES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"ECI_NM_CIUDAD" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ESP_DELEGACI
--------------------------------------------------------

  CREATE TABLE "M4SLL_ESP_DELEGACI" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"EDE_ID_DELEGACION" VARCHAR2(3 CHAR), 
	"ECI_ID_CIUDAD" VARCHAR2(3 CHAR), 
	"EDE_NM_DELEGACION" VARCHAR2(254 CHAR), 
	"EDE_ZONA_RRLL" VARCHAR2(3 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ESP_DELEGACI_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_ESP_DELEGACI_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"EDE_ID_DELEGACION" VARCHAR2(3 CHAR), 
	"ECI_ID_CIUDAD" VARCHAR2(3 CHAR), 
	"EDE_NM_DELEGACION" VARCHAR2(254 CHAR), 
	"EDE_ZONA_RRLL" VARCHAR2(3 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ESP_LIT_PROV
--------------------------------------------------------

  CREATE TABLE "M4SLL_ESP_LIT_PROV" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"ELP_ANIO" VARCHAR2(4), 
	"ELP_MES" VARCHAR2(2), 
	"ELP_VALOR_PROVISION" NUMBER(18,4), 
	"ELP_PORCENTAJE_PROV" NUMBER(18,4), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_EST_JUR_SUB
--------------------------------------------------------

  CREATE TABLE "M4SLL_EST_JUR_SUB" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"EJU_ID_EST_JURIDICO" NUMBER(10,0), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"EJS_NM_EST_JUR_SUB" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"EJS_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"EJS_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ESTUDIO_JUR
--------------------------------------------------------

  CREATE TABLE "M4SLL_ESTUDIO_JUR" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"EJU_ID_EST_JURIDICO" NUMBER(10,0), 
	"EJU_NM_EST_JURIDICO" VARCHAR2(254), 
	"EJU_EMAIL" VARCHAR2(254), 
	"EJU_TEL_OFICINA" VARCHAR2(30), 
	"EJU_TEL_MOVIL" VARCHAR2(30), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"EJU_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"EJU_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ESTUDIO_JUR_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_ESTUDIO_JUR_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"EJU_ID_EST_JURIDICO" VARCHAR2(3), 
	"EJU_NM_EST_JURIDICO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"EJU_EMAIL" VARCHAR2(254 CHAR), 
	"EJU_TEL_OFICINA" VARCHAR2(30 CHAR), 
	"EJU_TEL_MOVIL" VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_EXEC_RP_LITIGIO
--------------------------------------------------------

  CREATE TABLE "M4SLL_EXEC_RP_LITIGIO" 
   (	"USUARIO" VARCHAR2(100), 
	"SQL" CLOB, 
	"FECHA_HORA" TIMESTAMP (6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
 LOB ("SQL") STORE AS BASICFILE (ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
--------------------------------------------------------
--  DDL for Table M4SLL_EXP_PED
--------------------------------------------------------

  CREATE TABLE "M4SLL_EXP_PED" 
   (	"LIT_ID_LEGADO" VARCHAR2(10), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"FAS_ID_FASE_ESTADO" VARCHAR2(3), 
	"FAR_ID_FASE_RESULTADO" VARCHAR2(3), 
	"FAS_FECHA" DATE, 
	"FAS_OBSERVACION" VARCHAR2(1000), 
	"FAS_DT_CITACION" DATE, 
	"FAS_NRO_RADICACION" VARCHAR2(30), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"FAS_JUEZ" VARCHAR2(254), 
	"FAS_VALOR_CONDENA" NUMBER(18,4), 
	"FAS_VALOR_HONORARIOS" NUMBER(14,4), 
	"FAS_PORC_CONDENA" NUMBER(3,0), 
	"FAS_PORC_HONORARIOS" NUMBER(3,0), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"FAS_CHK_ROBOT" VARCHAR2(1 CHAR), 
	"FAS_SECUENCIA" NUMBER(18,0), 
	"FAS_NUM_JUZGADO" VARCHAR2(10), 
	"FAS_FECHA_COND" DATE, 
	"FAS_FECHA_HON" DATE, 
	"FAS_OBS_HON" VARCHAR2(1000), 
	"FAS_DT_IMPACTO" DATE, 
	"FAS_HORA" VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"FAS_ID_FASE_ESTADO" VARCHAR2(3), 
	"FAR_ID_FASE_RESULTADO" VARCHAR2(3), 
	"FAS_FECHA" DATE, 
	"FAS_OBSERVACION" VARCHAR2(1000), 
	"FAS_DT_CITACION" DATE, 
	"FAS_NRO_RADICACION" VARCHAR2(30), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"FAS_JUEZ" VARCHAR2(254), 
	"FAS_VALOR_CONDENA" NUMBER(18,4), 
	"FAS_VALOR_HONORARIOS" NUMBER(14,4), 
	"FAS_PORC_CONDENA" NUMBER(3,0), 
	"FAS_PORC_HONORARIOS" NUMBER(3,0), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"FAS_CHK_ROBOT" VARCHAR2(1 CHAR), 
	"FAS_SECUENCIA" NUMBER(18,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_DOC
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_DOC" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"FAD_SECUENCIA" NUMBER(10,0), 
	"FAD_URL_DOCUMENTO" VARCHAR2(1000), 
	"FAS_FECHA_DOC" DATE, 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_ESTADO
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_ESTADO" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"FAS_ID_FASE_ESTADO" VARCHAR2(3), 
	"FAS_NM_FASE_ESTADO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3 CHAR), 
	"FAS_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"FAS_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_PROV
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_PROV" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"FAP_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"FAP_DT_IMPACTO" DATE, 
	"FAP_FECHA" DATE, 
	"FAP_VALOR_CONDENA" NUMBER(18,4), 
	"FAP_VALOR_HONORARIOS" NUMBER(18,4), 
	"FAP_PORC_CONDENA" NUMBER(18,4), 
	"FAP_PORC_HONORARIOS" NUMBER(18,4), 
	"FAP_FECHA_COND" DATE, 
	"FAP_FECHA_HON" DATE, 
	"FAP_OBS_COND" VARCHAR2(1000 CHAR), 
	"FAP_OBS_HON" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_PROV_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_PROV_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"FAP_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"FAP_DT_IMPACTO" DATE, 
	"FAP_FECHA" DATE, 
	"FAP_VALOR_CONDENA" NUMBER(14,4), 
	"FAP_VALOR_HONORARIOS" NUMBER(14,4), 
	"FAP_PORC_CONDENA" NUMBER(3,0), 
	"FAP_PORC_HONORARIOS" NUMBER(3,0), 
	"FAP_FECHA_COND" DATE, 
	"FAP_FECHA_HON" DATE, 
	"FAP_OBS_COND" VARCHAR2(1000), 
	"FAP_OBS_HON" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_RESULT
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_RESULT" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"FAR_ID_FASE_RESULTADO" VARCHAR2(3), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"FAR_NM_FASE_RESULTADO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3 CHAR), 
	"FAR_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"FAR_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_FASES_RESULT_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_FASES_RESULT_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"FAR_ID_FASE_RESULTADO" VARCHAR2(3), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"FAR_NM_FASE_RESULTADO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_HIS_DET_PROV
--------------------------------------------------------

  CREATE TABLE "M4SLL_HIS_DET_PROV" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"TFA_ID_TP_FASE" VARCHAR2(3 CHAR), 
	"MDP_ID_DET_PROVISION" VARCHAR2(3 CHAR), 
	"HDP_DT_PERIODO" DATE, 
	"HDP_VALOR" NUMBER(14,4), 
	"HDP_PORC_PROV" NUMBER(3,0), 
	"HDP_MONTO_A_PROVISIONAR" NUMBER(14,4), 
	"HDP_MONTO_PAGADO" NUMBER(14,4), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INI_PARAM_CALC_PROV
--------------------------------------------------------

  CREATE TABLE "M4SLL_INI_PARAM_CALC_PROV" 
   (	"IPAR_SECUENCIA" NUMBER(10,0), 
	"ID_ORGANIZATION" VARCHAR2(4), 
	"IPAR_PROCESO" VARCHAR2(100), 
	"IPAR_NOMBRE" VARCHAR2(30 CHAR), 
	"IPAR_DESC" VARCHAR2(500 CHAR), 
	"IPAR_VAL_NUMBER" NUMBER(10,0), 
	"IPAR_VAL_DATE" DATE, 
	"IPAR_VAL_CHAR" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_GL_TRX_L
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_GL_TRX_L" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ORIGEN" VARCHAR2(20 CHAR), 
	"GRUPO" NUMBER(9,0), 
	"LOTE" NUMBER(15,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"DESCRIP" VARCHAR2(30 CHAR), 
	"STATUS" VARCHAR2(10 CHAR), 
	"ASIENTO" NUMBER(15,0), 
	"CANT_ASIENTO" NUMBER(6,0), 
	"CREATION_DATE" DATE, 
	"ID_APPROLE2" VARCHAR2(30 CHAR), 
	"ID_SECUSER2" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE2" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"IGT_IMPORTE_LOTE" NUMBER(18,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_GL_TRX_L_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_GL_TRX_L_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ORIGEN" VARCHAR2(20 CHAR), 
	"GRUPO" NUMBER(9,0), 
	"LOTE" NUMBER(15,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"DESCRIP" VARCHAR2(30 CHAR), 
	"STATUS" VARCHAR2(10 CHAR), 
	"ASIENTO" NUMBER(15,0), 
	"CANT_ASIENTO" NUMBER(6,0), 
	"CREATION_DATE" DATE, 
	"ID_APPROLE2" VARCHAR2(30 CHAR), 
	"ID_SECUSER2" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE2" DATE, 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"IGT_IMPORTE_LOTE" NUMBER(18,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_GL_TRXS
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_GL_TRXS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ORIGEN" VARCHAR2(20 CHAR), 
	"GRUPO" NUMBER(9,0), 
	"LOTE" NUMBER(15,0), 
	"RENGLON" NUMBER(15,0), 
	"EMPRESA" VARCHAR2(3 CHAR), 
	"FECCONT" VARCHAR2(10 CHAR), 
	"MONEDA" VARCHAR2(15 CHAR), 
	"FCREA" VARCHAR2(10 CHAR), 
	"UCREA" VARCHAR2(15 CHAR), 
	"CATEGORIA" VARCHAR2(25 CHAR), 
	"CTACBLE" VARCHAR2(250 CHAR), 
	"PAIS" VARCHAR2(2 CHAR), 
	"DIVISION" VARCHAR2(4 CHAR), 
	"DEPTO" VARCHAR2(4 CHAR), 
	"ACTIV" VARCHAR2(1 CHAR), 
	"VALDB" VARCHAR2(20 CHAR), 
	"VALCR" VARCHAR2(20 CHAR), 
	"FGRAB" VARCHAR2(10 CHAR), 
	"HGRAB" VARCHAR2(8 CHAR), 
	"STATUS" VARCHAR2(30 CHAR), 
	"TCIDEA" VARCHAR2(4 CHAR), 
	"SCIDEA" VARCHAR2(4 CHAR), 
	"NCIDEA" VARCHAR2(15 CHAR), 
	"DLOTE" VARCHAR2(30 CHAR), 
	"IMPDB" VARCHAR2(20 CHAR), 
	"IMPCR" VARCHAR2(20 CHAR), 
	"TASACON" VARCHAR2(20 CHAR), 
	"FCONMON" VARCHAR2(10 CHAR), 
	"NOMASIEN" VARCHAR2(60 CHAR), 
	"DASIEN" VARCHAR2(60 CHAR), 
	"DLINEA" VARCHAR2(50 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_GL_TRXS_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_GL_TRXS_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ORIGEN" VARCHAR2(20 CHAR), 
	"GRUPO" NUMBER(9,0), 
	"LOTE" NUMBER(15,0), 
	"RENGLON" NUMBER(15,0), 
	"EMPRESA" VARCHAR2(3 CHAR), 
	"FECCONT" VARCHAR2(10 CHAR), 
	"MONEDA" VARCHAR2(15 CHAR), 
	"FCREA" VARCHAR2(10 CHAR), 
	"UCREA" VARCHAR2(15 CHAR), 
	"CATEGORIA" VARCHAR2(25 CHAR), 
	"CTACBLE" VARCHAR2(250 CHAR), 
	"PAIS" VARCHAR2(2 CHAR), 
	"DIVISION" VARCHAR2(4 CHAR), 
	"DEPTO" VARCHAR2(4 CHAR), 
	"ACTIV" VARCHAR2(1 CHAR), 
	"VALDB" VARCHAR2(20 CHAR), 
	"VALCR" VARCHAR2(20 CHAR), 
	"FGRAB" VARCHAR2(10 CHAR), 
	"HGRAB" VARCHAR2(8 CHAR), 
	"STATUS" VARCHAR2(30 CHAR), 
	"TCIDEA" VARCHAR2(4 CHAR), 
	"SCIDEA" VARCHAR2(4 CHAR), 
	"NCIDEA" VARCHAR2(15 CHAR), 
	"DLOTE" VARCHAR2(30 CHAR), 
	"IMPDB" VARCHAR2(20 CHAR), 
	"IMPCR" VARCHAR2(20 CHAR), 
	"TASACON" VARCHAR2(20 CHAR), 
	"FCONMON" VARCHAR2(10 CHAR), 
	"NOMASIEN" VARCHAR2(60 CHAR), 
	"DASIEN" VARCHAR2(60 CHAR), 
	"DLINEA" VARCHAR2(50 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_LIST_LITIGIOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_LIST_LITIGIOS" 
   (	"LIT_ID_LITIGIO" VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_PAG_NO_D
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_PAG_NO_D" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PNO_SECUENCIA" NUMBER(10,0), 
	"PND_SECUENCIA" NUMBER(10,0), 
	"MCO_ID_CONCEPTO" VARCHAR2(10 CHAR), 
	"PND_FECHA_DESDE" DATE, 
	"PND_FECHA_HASTA" DATE, 
	"PND_IMPORTE" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MCO_NM_CONCEPTO" VARCHAR2(1000 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_INT_PAGO_NOM
--------------------------------------------------------

  CREATE TABLE "M4SLL_INT_PAGO_NOM" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PNO_SECUENCIA" NUMBER(10,0), 
	"PNO_LOTE" NUMBER(10,0), 
	"TPA_ID_PAGO" VARCHAR2(3 CHAR), 
	"PNO_VALOR" NUMBER(18,4), 
	"PNO_FECHA" DATE, 
	"STD_ID_PERSON" VARCHAR2(10 CHAR), 
	"STD_ID_LEG_ENT" VARCHAR2(9 CHAR), 
	"PNO_PRINCIPAL_S_N" VARCHAR2(1 CHAR), 
	"PNO_INTERESES" NUMBER(18,4), 
	"PNO_SALARIO_DIA" NUMBER(18,4), 
	"PNO_COTIZACION" VARCHAR2(30 CHAR), 
	"SSP_ID_CABEC_TC1" VARCHAR2(15 CHAR), 
	"PNO_CUENTA_ABONO" VARCHAR2(30 CHAR), 
	"PNO_CODIGO_IBAN" VARCHAR2(30 CHAR), 
	"PNO_OTRAS_CUENTAS" VARCHAR2(30 CHAR), 
	"PNO_BENEFICIARIO" VARCHAR2(254 CHAR), 
	"IPN_IMPORTE_BRUTO" NUMBER(18,4), 
	"IPN_DESCUENTOS_S_S" NUMBER(18,4), 
	"LIT_NRO_PROCESO" VARCHAR2(100 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"STD_OR_HR_PERIOD" NUMBER(10,0), 
	"PNO_F_FIN_SANCION" DATE, 
	"PNO_F_INI_SANCION" DATE, 
	"PNO_APLICA_SAL_DIA" VARCHAR2(1 CHAR), 
	"PNO_F_REINCORP" DATE, 
	"PNO_ADJ_VIDA_LAB" VARCHAR2(1 CHAR), 
	"PNO_F_IMP_HASTA" DATE, 
	"PNO_F_IMP_DESDE" DATE, 
	"PNO_RECON_DERECHO" VARCHAR2(1 CHAR), 
	"IPN_DESC_IRPF" NUMBER(18,4), 
	"PNO_F_ENV_NOM" DATE, 
	"IPN_F_TRANSF" DATE, 
	"IPN_RET_JUDICIAL" NUMBER(18,4), 
	"IPN_IMP_TRANSF" NUMBER(18,4), 
	"PNO_NRO_C_JUZ" VARCHAR2(30 CHAR), 
	"PNO_F_VENCIMIENTO" DATE, 
	"PNO_ANT_RECONOCIDA" DATE, 
	"PNO_DIAS_SANCIONA" NUMBER(10,0), 
	"IPN_APLI_SAN_S_N" VARCHAR2(1 CHAR), 
	"IPN_LETRA_JUZGADO" VARCHAR2(30 CHAR), 
	"IPN_COD_IBAN_GENE" VARCHAR2(30 CHAR), 
	"IPN_NRO_EXP" VARCHAR2(30 CHAR), 
	"TPA_NM_PAGO" VARCHAR2(254 CHAR), 
	"PNO_NETO_S_N" VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LIT_HECHOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_LIT_HECHOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"LIH_SECUENCIA" NUMBER(10,0), 
	"LIH_HECHO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"LIH_DT_INICIAL" DATE, 
	"LIH_DT_FINAL" DATE, 
	"LIH_SALARIO_PERIODO" NUMBER(14,4), 
	"LIH_CK_AFILIACION_SINDICATO" VARCHAR2(1 CHAR), 
	"LIH_DESC_SINDICATO" VARCHAR2(254 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LIT_HECHOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_LIT_HECHOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"LIH_SECUENCIA" NUMBER(10,0), 
	"LIH_HECHO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"LIH_DT_INICIAL" DATE, 
	"LIH_DT_FINAL" DATE, 
	"LIH_SALARIO_PERIODO" NUMBER(14,4), 
	"LIH_CK_AFILIACION_SINDICATO" VARCHAR2(1 CHAR), 
	"LIH_DESC_SINDICATO" VARCHAR2(254 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGIOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGIOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"MCA_ID_CODIGO_ALTERNO" VARCHAR2(3), 
	"MRI_ID_RIESGO" VARCHAR2(3), 
	"MMA_ID_MATERIA" VARCHAR2(3), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"LIT_DESCRIPCION" VARCHAR2(254), 
	"LIT_BPO" VARCHAR2(254), 
	"LIT_FECHA_INICIO" DATE, 
	"LIT_FECHA_NOTIFICACION" DATE, 
	"LIT_USR_REGISTRA" VARCHAR2(30), 
	"LIT_FECHA_PRESENTACION" DATE, 
	"LIT_HORA_PRESENTACION" DATE, 
	"LIT_FECHA_CIERRE" DATE, 
	"LIT_ACUERDO" VARCHAR2(1), 
	"LIT_RELEVANTE" VARCHAR2(1), 
	"LIT_HON_CONTADOR" NUMBER(18,4), 
	"LIT_HON_JURIDICO" NUMBER(18,4), 
	"LIT_OBSERVACIONES" VARCHAR2(1000), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"EJU_ID_EST_JURIDICO" NUMBER(10,0), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"STD_ID_COUNTRY" VARCHAR2(4), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"LIT_ABOGADO_RESPONSABLE" VARCHAR2(30), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_CK_AVAL" VARCHAR2(1), 
	"LIT_CK_MINUTA" VARCHAR2(1), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3), 
	"TFL_ID_TP_FALTA" VARCHAR2(3), 
	"LIT_ID_LEGADO" VARCHAR2(10), 
	"LIT_JUEZ" VARCHAR2(60), 
	"LIT_PAZ_Y_SVC" VARCHAR2(1), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"LIT_DT_ACTUALIZACION" DATE, 
	"LIT_USER_ACTUALIZACION" VARCHAR2(30), 
	"LIT_CENTRO_COSTO" VARCHAR2(30), 
	"LIT_DIVISION" VARCHAR2(30), 
	"LIT_REGION" VARCHAR2(30), 
	"LIT_NUMERO_EJECUCION" VARCHAR2(30), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"LIT_UBICACION_FISICA" VARCHAR2(254), 
	"LIT_SECUENCIA" NUMBER(18,0), 
	"LIT_CORPORATIVO_S_N" VARCHAR2(1), 
	"LIT_SUBROGADO_S_N" VARCHAR2(1), 
	"LIT_PORCENTAJE_PROBABILIDAD" NUMBER(3,0), 
	"LIT_SUSTENTACION" VARCHAR2(1000), 
	"LIT_FLEX_CONDENA" VARCHAR2(254), 
	"LIT_FLEX_HONORARIOS" VARCHAR2(254), 
	"LIT_PREVISION" NUMBER(14,4), 
	"LIT_PROVISION" NUMBER(18,4), 
	"LIT_IMPORTE_TRANSF" NUMBER(18,4), 
	"LIT_DESCUENTOS_S_S_TOTAL" NUMBER(18,4), 
	"LIT_IMPORTE_BRUTO_TOTAL" NUMBER(18,4), 
	"LIT_RETENCION_JUDICIAL_TOTAL" NUMBER(18,4), 
	"LIT_DESCUENTOS_IRPF_TOTAL" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"LIT_CK_CALC_PROV" VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGIOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGIOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"LIT_DESCRIPCION" VARCHAR2(254), 
	"LIT_BPO" VARCHAR2(254), 
	"LIT_FECHA_INICIO" DATE, 
	"LIT_FECHA_NOTIFICACION" DATE, 
	"LIT_USR_REGISTRA" VARCHAR2(30), 
	"LIT_FECHA_PRESENTACION" DATE, 
	"LIT_HORA_PRESENTACION" DATE, 
	"LIT_FECHA_CIERRE" DATE, 
	"LIT_ACUERDO" VARCHAR2(1), 
	"LIT_RELEVANTE" VARCHAR2(1), 
	"LIT_HON_CONTADOR" NUMBER(18,4), 
	"LIT_HON_JURIDICO" NUMBER(18,4), 
	"LIT_OBSERVACIONES" VARCHAR2(1000), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"EJU_ID_EST_JURIDICO" VARCHAR2(3), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"STD_ID_COUNTRY" VARCHAR2(4), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"LIT_ABOGADO_RESPONSABLE" VARCHAR2(30), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_CK_AVAL" VARCHAR2(1), 
	"LIT_CK_MINUTA" VARCHAR2(1), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3), 
	"TFL_ID_TP_FALTA" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"LIT_ID_LEGADO" VARCHAR2(10 CHAR), 
	"LIT_JUEZ" VARCHAR2(60 CHAR), 
	"LIT_PAZ_Y_SVC" VARCHAR2(1 CHAR), 
	"EDE_ID_DELEGACION" VARCHAR2(3 CHAR), 
	"ECI_ID_CIUDAD" VARCHAR2(3 CHAR), 
	"STD_ID_LEG_ENT" VARCHAR2(9 CHAR), 
	"LIT_DT_ACTUALIZACION" DATE, 
	"LIT_USER_ACTUALIZACION" VARCHAR2(30 CHAR), 
	"LIT_CENTRO_COSTO" VARCHAR2(30 CHAR), 
	"LIT_DIVISION" VARCHAR2(30 CHAR), 
	"LIT_REGION" VARCHAR2(30 CHAR), 
	"LIT_NUMERO_EJECUCION" VARCHAR2(30 CHAR), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGIOS_BKP_COL
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGIOS_BKP_COL" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"LIT_DESCRIPCION" VARCHAR2(254), 
	"LIT_BPO" VARCHAR2(254), 
	"LIT_FECHA_INICIO" DATE, 
	"LIT_FECHA_NOTIFICACION" DATE, 
	"LIT_USR_REGISTRA" VARCHAR2(30), 
	"LIT_FECHA_PRESENTACION" DATE, 
	"LIT_HORA_PRESENTACION" DATE, 
	"LIT_FECHA_CIERRE" DATE, 
	"LIT_ACUERDO" VARCHAR2(1), 
	"LIT_RELEVANTE" VARCHAR2(1), 
	"LIT_HON_CONTADOR" NUMBER(18,4), 
	"LIT_HON_JURIDICO" NUMBER(18,4), 
	"LIT_OBSERVACIONES" VARCHAR2(1000), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"EJU_ID_EST_JURIDICO" VARCHAR2(3), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"STD_ID_COUNTRY" VARCHAR2(4), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"LIT_ABOGADO_RESPONSABLE" VARCHAR2(30), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_CK_AVAL" VARCHAR2(1), 
	"LIT_CK_MINUTA" VARCHAR2(1), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3), 
	"TFL_ID_TP_FALTA" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"LIT_ID_LEGADO" VARCHAR2(10 CHAR), 
	"LIT_JUEZ" VARCHAR2(60 CHAR), 
	"LIT_PAZ_Y_SVC" VARCHAR2(1 CHAR), 
	"EDE_ID_DELEGACION" VARCHAR2(3 CHAR), 
	"ECI_ID_CIUDAD" VARCHAR2(3 CHAR), 
	"STD_ID_LEG_ENT" VARCHAR2(9 CHAR), 
	"LIT_DT_ACTUALIZACION" DATE, 
	"LIT_USER_ACTUALIZACION" VARCHAR2(30 CHAR), 
	"LIT_CENTRO_COSTO" VARCHAR2(30 CHAR), 
	"LIT_DIVISION" VARCHAR2(30 CHAR), 
	"LIT_REGION" VARCHAR2(30 CHAR), 
	"LIT_NUMERO_EJECUCION" VARCHAR2(30 CHAR), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"LIT_UBICACION_FISICA" VARCHAR2(254), 
	"LIT_SECUENCIA" NUMBER(18,0), 
	"LIT_CORPORATIVO_S_N" VARCHAR2(1), 
	"LIT_SUBROGADO_S_N" VARCHAR2(1), 
	"MMA_ID_MATERIA" VARCHAR2(3 CHAR), 
	"MRI_ID_RIESGO" VARCHAR2(3 CHAR), 
	"MCA_ID_CODIGO_ALTERNO" VARCHAR2(3 CHAR), 
	"LIT_PORCENTAJE_PROBABILIDAD" NUMBER(3,0), 
	"LIT_SUSTENTACION" VARCHAR2(1000 CHAR), 
	"LIT_FLEX_CONDENA" VARCHAR2(254 CHAR), 
	"LIT_FLEX_HONORARIOS" VARCHAR2(254 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGIOS_GGA
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGIOS_GGA" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"MCA_ID_CODIGO_ALTERNO" VARCHAR2(3), 
	"MRI_ID_RIESGO" VARCHAR2(3), 
	"MMA_ID_MATERIA" VARCHAR2(3), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"LIT_DESCRIPCION" VARCHAR2(254), 
	"LIT_BPO" VARCHAR2(254), 
	"LIT_FECHA_INICIO" DATE, 
	"LIT_FECHA_NOTIFICACION" DATE, 
	"LIT_USR_REGISTRA" VARCHAR2(30), 
	"LIT_FECHA_PRESENTACION" DATE, 
	"LIT_HORA_PRESENTACION" DATE, 
	"LIT_FECHA_CIERRE" DATE, 
	"LIT_ACUERDO" VARCHAR2(1), 
	"LIT_RELEVANTE" VARCHAR2(1), 
	"LIT_HON_CONTADOR" NUMBER(18,4), 
	"LIT_HON_JURIDICO" NUMBER(18,4), 
	"LIT_OBSERVACIONES" VARCHAR2(1000), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"EJU_ID_EST_JURIDICO" NUMBER(10,0), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"STD_ID_COUNTRY" VARCHAR2(4), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"LIT_ABOGADO_RESPONSABLE" VARCHAR2(30), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_CK_AVAL" VARCHAR2(1), 
	"LIT_CK_MINUTA" VARCHAR2(1), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3), 
	"TFL_ID_TP_FALTA" VARCHAR2(3), 
	"LIT_ID_LEGADO" VARCHAR2(10), 
	"LIT_JUEZ" VARCHAR2(60), 
	"LIT_PAZ_Y_SVC" VARCHAR2(1), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"LIT_DT_ACTUALIZACION" DATE, 
	"LIT_USER_ACTUALIZACION" VARCHAR2(30), 
	"LIT_CENTRO_COSTO" VARCHAR2(30), 
	"LIT_DIVISION" VARCHAR2(30), 
	"LIT_REGION" VARCHAR2(30), 
	"LIT_NUMERO_EJECUCION" VARCHAR2(30), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"LIT_UBICACION_FISICA" VARCHAR2(254), 
	"LIT_SECUENCIA" NUMBER(18,0), 
	"LIT_CORPORATIVO_S_N" VARCHAR2(1), 
	"LIT_SUBROGADO_S_N" VARCHAR2(1), 
	"LIT_PORCENTAJE_PROBABILIDAD" NUMBER(3,0), 
	"LIT_SUSTENTACION" VARCHAR2(1000), 
	"LIT_FLEX_CONDENA" VARCHAR2(254), 
	"LIT_FLEX_HONORARIOS" VARCHAR2(254), 
	"LIT_PREVISION" NUMBER(14,4), 
	"LIT_PROVISION" NUMBER(18,4), 
	"LIT_IMPORTE_TRANSF" NUMBER(18,4), 
	"LIT_DESCUENTOS_S_S_TOTAL" NUMBER(18,4), 
	"LIT_IMPORTE_BRUTO_TOTAL" NUMBER(18,4), 
	"LIT_RETENCION_JUDICIAL_TOTAL" NUMBER(18,4), 
	"LIT_DESCUENTOS_IRPF_TOTAL" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGIOS_HIS
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGIOS_HIS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"LIH_SECUENCIA" NUMBER(10,0), 
	"LIH_COLUM_ALTERADA" VARCHAR2(30 CHAR), 
	"LIH_FECHA_ALTERADA" DATE, 
	"LIH_ID_OLD" VARCHAR2(3 CHAR), 
	"LIH_ID_NUEVO" VARCHAR2(3 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGIOS_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGIOS_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"MCA_ID_CODIGO_ALTERNO" VARCHAR2(3), 
	"MRI_ID_RIESGO" VARCHAR2(3), 
	"MMA_ID_MATERIA" VARCHAR2(3), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"LIT_DESCRIPCION" VARCHAR2(254), 
	"LIT_BPO" VARCHAR2(254), 
	"LIT_FECHA_INICIO" DATE, 
	"LIT_FECHA_NOTIFICACION" DATE, 
	"LIT_USR_REGISTRA" VARCHAR2(30), 
	"LIT_FECHA_PRESENTACION" DATE, 
	"LIT_HORA_PRESENTACION" DATE, 
	"LIT_FECHA_CIERRE" DATE, 
	"LIT_ACUERDO" VARCHAR2(1), 
	"LIT_RELEVANTE" VARCHAR2(1), 
	"LIT_HON_CONTADOR" NUMBER(18,4), 
	"LIT_HON_JURIDICO" NUMBER(18,4), 
	"LIT_OBSERVACIONES" VARCHAR2(1000), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"EJU_ID_EST_JURIDICO" NUMBER(10,0), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"STD_ID_COUNTRY" VARCHAR2(4), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"LIT_ABOGADO_RESPONSABLE" VARCHAR2(30), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_CK_AVAL" VARCHAR2(1), 
	"LIT_CK_MINUTA" VARCHAR2(1), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3), 
	"TFL_ID_TP_FALTA" VARCHAR2(3), 
	"LIT_ID_LEGADO" VARCHAR2(10), 
	"LIT_JUEZ" VARCHAR2(60), 
	"LIT_PAZ_Y_SVC" VARCHAR2(1), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"LIT_DT_ACTUALIZACION" DATE, 
	"LIT_USER_ACTUALIZACION" VARCHAR2(30), 
	"LIT_CENTRO_COSTO" VARCHAR2(30), 
	"LIT_DIVISION" VARCHAR2(30), 
	"LIT_REGION" VARCHAR2(30), 
	"LIT_NUMERO_EJECUCION" VARCHAR2(30), 
	"LIT_VALOR_PED_TOTAL" NUMBER(18,4), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"LIT_UBICACION_FISICA" VARCHAR2(254), 
	"LIT_SECUENCIA" NUMBER(18,0), 
	"LIT_CORPORATIVO_S_N" VARCHAR2(1), 
	"LIT_SUBROGADO_S_N" VARCHAR2(1), 
	"LIT_PORCENTAJE_PROBABILIDAD" NUMBER(3,0), 
	"LIT_SUSTENTACION" VARCHAR2(1000), 
	"LIT_FLEX_CONDENA" VARCHAR2(254), 
	"LIT_FLEX_HONORARIOS" VARCHAR2(254), 
	"LIT_PREVISION" NUMBER(14,4), 
	"LIT_PROVISION" NUMBER(18,4), 
	"LIT_IMPORTE_TRANSF" NUMBER(18,4), 
	"LIT_DESCUENTOS_S_S_TOTAL" NUMBER(18,4), 
	"LIT_IMPORTE_BRUTO_TOTAL" NUMBER(18,4), 
	"LIT_RETENCION_JUDICIAL_TOTAL" NUMBER(18,4), 
	"LIT_DESCUENTOS_IRPF_TOTAL" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"LIT_PORC_PROVISION" NUMBER(8,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LITIGOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_LITIGOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"EJS_ID_EST_JUR_SUB" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"LIT_DESCRIPCION" VARCHAR2(254), 
	"LIT_BPO" VARCHAR2(254), 
	"LIT_FECHA_INICIO" DATE, 
	"LIT_FECHA_NOTIFICACION" DATE, 
	"LIT_USR_REGISTRA" VARCHAR2(30), 
	"LIT_FECHA_PRESENTACION" DATE, 
	"LIT_HORA_PRESENTACION" DATE, 
	"LIT_FECHA_CIERRE" DATE, 
	"LIT_ACUERDO" VARCHAR2(1), 
	"LIT_RELEVANTE" VARCHAR2(1), 
	"LIT_HON_CONTADOR" NUMBER(18,4), 
	"LIT_HON_JURIDICO" NUMBER(18,4), 
	"LIT_OBSERVACIONES" VARCHAR2(1000), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"EJU_ID_EST_JURIDICO" VARCHAR2(3), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"STD_ID_COUNTRY" VARCHAR2(4), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"LIT_ABOGADO_RESPONSABLE" VARCHAR2(30), 
	"LIT_VALOR_TOTAL" NUMBER(18,4), 
	"LIT_CK_AVAL" VARCHAR2(1), 
	"LIT_CK_MINUTA" VARCHAR2(1), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3), 
	"TFL_ID_TP_FALTA" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"LIT_ID_LEGADO" VARCHAR2(10 CHAR), 
	"LIT_JUEZ" VARCHAR2(60 CHAR), 
	"LIT_PAZ_Y_SVC" VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LIT_SEGUIMIE
--------------------------------------------------------

  CREATE TABLE "M4SLL_LIT_SEGUIMIE" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"LIS_SECUENCIA" NUMBER(10,0), 
	"LIS_SEGUIMIENTO" VARCHAR2(1000), 
	"STD_ID_PERSON" VARCHAR2(10), 
	"LIS_FECHA" DATE, 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_LIT_VINCULAD
--------------------------------------------------------

  CREATE TABLE "M4SLL_LIT_VINCULAD" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"LIV_SECUENCIA" NUMBER(10,0), 
	"LIV_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"LIV_OBSERVACION" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_C
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_C" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MPC_SECUENCIA" NUMBER(15,0), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"EDE_ZONA_RRLL" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_C_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_C_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MPC_SECUENCIA" NUMBER(15,0), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"EDE_ZONA_RRLL" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_C_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MPC_SECUENCIA" NUMBER(15,0), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"EDE_ZONA_RRLL" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_D
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_D" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MPD_ANIO" VARCHAR2(4 CHAR), 
	"MPD_MES" VARCHAR2(2 CHAR), 
	"MPC_SECUENCIA" NUMBER(15,0), 
	"MPD_VALOR_TOTAL" NUMBER(14,4), 
	"MPD_VALOR_PED_TOTAL" NUMBER(14,4), 
	"MPD_CANTIDAD_EXPEDIENTE" NUMBER(10,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_D_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_D_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MPD_ANIO" VARCHAR2(4 CHAR), 
	"MPD_MES" VARCHAR2(2 CHAR), 
	"MPC_SECUENCIA" NUMBER(15,0), 
	"MPD_VALOR_TOTAL" NUMBER(14,4), 
	"MPD_VALOR_PED_TOTAL" NUMBER(14,4), 
	"MPD_CANTIDAD_EXPEDIENTE" NUMBER(10,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PREDI
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PREDI" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MPR_ANIO" VARCHAR2(4 CHAR), 
	"MPR_MES" VARCHAR2(2 CHAR), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3 CHAR), 
	"TPE_ID_PEDIDO" VARCHAR2(3 CHAR), 
	"NEG_ID_NEGOCIO" VARCHAR2(3 CHAR), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3 CHAR), 
	"EDE_ID_DELEGACION" VARCHAR2(3 CHAR), 
	"EDE_ZONA_RRLL" VARCHAR2(3 CHAR), 
	"MPR_VALOR_TOTAL" NUMBER(14,4), 
	"MPR_VALOR_PED_TOTAL" NUMBER(14,4), 
	"MPR_CANTIDAD_EXPEDIENTE" NUMBER(10,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_D_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MPD_ANIO" VARCHAR2(4 CHAR), 
	"MPD_MES" VARCHAR2(2 CHAR), 
	"MPC_SECUENCIA" NUMBER(15,0), 
	"MPD_VALOR_TOTAL" NUMBER(14,4), 
	"MPD_VALOR_PED_TOTAL" NUMBER(14,4), 
	"MPD_CANTIDAD_EXPEDIENTE" NUMBER(10,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MATRIZ_PRE_PARAM
--------------------------------------------------------

  CREATE TABLE "M4SLL_MATRIZ_PRE_PARAM" 
   (	"MPP_ID_ORDEN" NUMBER(3,0), 
	"MPP_PARAM_CAMPO" VARCHAR2(50), 
	"MPP_CAMPO_DESAGRUPAR" VARCHAR2(100), 
	"MPP_WHERE" VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MEDIO_PAGOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_MEDIO_PAGOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MEP_ID_MEDIO_PAGO" VARCHAR2(3), 
	"MEP_NM_MEDIO_PAGO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"MEP_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MEP_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MODULO_ROL
--------------------------------------------------------

  CREATE TABLE "M4SLL_MODULO_ROL" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MOR_SECUENCIA" NUMBER(10,0), 
	"MTM_ID_MODULO" NUMBER(10,0), 
	"MRA_ID_ROL_ACTOR" NUMBER(10,0), 
	"MOR_CAMPO" VARCHAR2(254 CHAR), 
	"MOR_TABLA" VARCHAR2(254 CHAR), 
	"MOR_FUNCION" VARCHAR2(3 CHAR), 
	"MOR_ESTADO" VARCHAR2(1 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MT_ABOGADOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_MT_ABOGADOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"MAB_NOMBRE" VARCHAR2(255), 
	"MAB_APELLIDO" VARCHAR2(255), 
	"MAB_EMAIL" VARCHAR2(255), 
	"MAB_CHK_INT" VARCHAR2(1), 
	"STD_ID_PERSON" VARCHAR2(10), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"MAB_DT_END" DATE, 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"MAB_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MAB_N_CEDULA" VARCHAR2(100 CHAR), 
	"MAB_N_TARJ_PROF" VARCHAR2(100 CHAR), 
	"MAB_TELEFONO" VARCHAR2(50 CHAR), 
	"MAB_CELULAR" VARCHAR2(50 CHAR), 
	"MAB_DOMICILIO" VARCHAR2(254 CHAR), 
	"MAB_EMPRESA" VARCHAR2(254 CHAR), 
	"MAB_NIT" VARCHAR2(100 CHAR), 
	"MAB_DT_INICIO_CONTRATO" DATE, 
	"MAB_DT_FIN_CONTRATO" DATE, 
	"MAB_TIPO_VINCULACION" VARCHAR2(254 CHAR), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8 CHAR), 
	"STD_ID_GEO_PLACE" VARCHAR2(9 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MT_ABOGADOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_MT_ABOGADOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"MAB_NOMBRE" VARCHAR2(255), 
	"MAB_APELLIDO" VARCHAR2(255), 
	"MAB_EMAIL" VARCHAR2(255), 
	"MAB_CHK_INT" VARCHAR2(1), 
	"STD_ID_PERSON" VARCHAR2(10), 
	"EDE_ID_DELEGACION" VARCHAR2(3), 
	"ECI_ID_CIUDAD" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"MAB_DT_END" DATE, 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_COD_ALT
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_COD_ALT" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MCA_ID_CODIGO_ALTERNO" VARCHAR2(3 CHAR), 
	"MCA_NM_CODIGO_ALTERNO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MCA_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MCA_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_COD_ALT_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_COD_ALT_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MCA_ID_CODIGO_ALTERNO" VARCHAR2(3 CHAR), 
	"MCA_NM_CODIGO_ALTERNO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_CONCEPTO
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_CONCEPTO" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MCO_ID_CONCEPTO" VARCHAR2(10), 
	"MCO_NM_CONCEPTO" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_DET_PROV
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_DET_PROV" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MDP_ID_DET_PROVISION" VARCHAR2(3 CHAR), 
	"MDP_NM_DET_PROVISION" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MDP_CUENTA_DEBE" VARCHAR2(30 CHAR), 
	"MDP_CUENTA_HABER" VARCHAR2(30 CHAR), 
	"MDP_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MDP_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_DET_PROV_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_DET_PROV_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MDP_ID_DET_PROVISION" VARCHAR2(3 CHAR), 
	"MDP_NM_DET_PROVISION" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MDP_CUENTA_DEBE" VARCHAR2(30 CHAR), 
	"MDP_CUENTA_HABER" VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_EMP_ORG
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_EMP_ORG" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"STD_ID_LEG_ENT" VARCHAR2(9 CHAR), 
	"ORG_ID" VARCHAR2(13 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MEO_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MEO_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_ESTADOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_ESTADOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MOR_ESTADO" VARCHAR2(1 CHAR), 
	"MTE_NM_ESTADO" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_EST_EJE
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_EST_EJE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MEE_ID_EST_EJECUCION" VARCHAR2(3 CHAR), 
	"MEE_NM_EST_EJECUCION" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_EST_TARE
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_EST_TARE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MET_ID_EST_TAREA" VARCHAR2(3 CHAR), 
	"MET_NM_EST_TAREA" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_FUNCION
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_FUNCION" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MOR_FUNCION" VARCHAR2(3 CHAR), 
	"MTF_NM_FUNCION" VARCHAR2(2000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_MATERIA
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_MATERIA" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MMA_ID_MATERIA" VARCHAR2(3 CHAR), 
	"MMA_NM_MATERIA" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MMA_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MMA_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_MODULOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_MODULOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MTM_ID_MODULO" NUMBER(10,0), 
	"MTM_NM_MODULO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MTM_ID_MOD_PADRE" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_PEDIDO_D
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_PEDIDO_D" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"MPD_ID_PEDIDO_DETALLE" VARCHAR2(3), 
	"MPD_NM_PEDIDO_DETALLE" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"MPD_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MPD_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MPD_PAGO_NOMINA_DET_S_N" VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_RIESGOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_RIESGOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MRI_ID_RIESGO" VARCHAR2(3 CHAR), 
	"MRI_NM_RIESGO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MRI_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MRI_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_RIESGOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_RIESGOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MRI_ID_RIESGO" VARCHAR2(3 CHAR), 
	"MRI_NM_RIESGO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_ROL_ACTO
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_ROL_ACTO" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MRA_ID_ROL_ACTOR" NUMBER(10,0), 
	"MRA_NM_ROL_ACTOR" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_SEG_INTE
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_SEG_INTE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ID_APP_ROLE" VARCHAR2(30 CHAR), 
	"MSI_SECUENCIA" NUMBER(10,0), 
	"MSI_DT_START" DATE, 
	"MSI_DT_END" DATE, 
	"MSI_COLUMNA" VARCHAR2(254 CHAR), 
	"MSI_TABLA" VARCHAR2(254 CHAR), 
	"MSI_VALOR" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MTM_ID_MODULO" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_TAR_CIE
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_TAR_CIE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MTC_ID_TAREA" VARCHAR2(3 CHAR), 
	"MTC_NM_TAREA" VARCHAR2(254 CHAR), 
	"MTC_NM_PROCEDIMIENTO" VARCHAR2(2000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MTO_TP_EMPLE
--------------------------------------------------------

  CREATE TABLE "M4SLL_MTO_TP_EMPLE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MTE_ID_TP_EMPLEADO" VARCHAR2(3 CHAR), 
	"MTE_NM_TP_EMPLEADO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MTE_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MTE_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_MT_ST_RE_PRO
--------------------------------------------------------

  CREATE TABLE "M4SLL_MT_ST_RE_PRO" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MSR_ID_STATUS_REPORTE" VARCHAR2(3 CHAR), 
	"MSR_NM_STATUS_REPORTE" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MSR_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"MSR_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_NEGOCIOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_NEGOCIOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"NEG_NM_NEGOCIO" VARCHAR2(254), 
	"LIT_CENTRO_COSTO" VARCHAR2(30), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"NEG_DIVISION" VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_NEGOCIOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_NEGOCIOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"NEG_ID_NEGOCIO" VARCHAR2(3 CHAR), 
	"NEG_NM_NEGOCIO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"LIT_CENTRO_COSTO" VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_NEGOCIOS_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_NEGOCIOS_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"NEG_ID_NEGOCIO" VARCHAR2(3), 
	"NEG_NM_NEGOCIO" VARCHAR2(254), 
	"LIT_CENTRO_COSTO" VARCHAR2(30), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_NEGOCIOS_ROL
--------------------------------------------------------

  CREATE TABLE "M4SLL_NEGOCIOS_ROL" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"NEG_ID_NEGOCIO" VARCHAR2(3 CHAR), 
	"ID_APP_ROLE" VARCHAR2(50 CHAR), 
	"SNR_CHK_SELECT" VARCHAR2(1 CHAR), 
	"SNR_CHK_INSERT" VARCHAR2(1 CHAR), 
	"SNR_CHK_UPDATE" VARCHAR2(1 CHAR), 
	"SNR_CHK_DELETE" VARCHAR2(1 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PAGOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_PAGOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"PAG_SECUENCIA" NUMBER(10,0), 
	"TSP_ID_SALIDA_PAGO" VARCHAR2(3), 
	"DCP_SECUENCIA" NUMBER(10,0), 
	"MEP_ID_MEDIO_PAGO" VARCHAR2(3), 
	"STP_ID_STATUS_PAGO" VARCHAR2(3), 
	"TPA_ID_PAGO" VARCHAR2(3), 
	"PAG_VALOR" NUMBER(18,2), 
	"PAG_FEC_EST" DATE, 
	"PAG_FEC_VTO" DATE, 
	"PAG_FEC_APR" DATE, 
	"PAG_FEC_ERP" DATE, 
	"PAG_FEC_PAG" DATE, 
	"PAG_DESCRIPCION" VARCHAR2(1000), 
	"PAG_DOCUMENTO" VARCHAR2(254), 
	"PAG_COMBINACION" VARCHAR2(254), 
	"PAG_CK_COMB" NUMBER(10,0), 
	"PAG_CK_RECUPERADO" VARCHAR2(1), 
	"PAG_CK_SOLICITADO" VARCHAR2(1), 
	"PAG_FECHA" DATE, 
	"PAG_COMPROBANTE" VARCHAR2(2000), 
	"PAG_NRO_IDENTIFICACION" VARCHAR2(254), 
	"PAG_TIPO_CUENTA_DESTNO" VARCHAR2(254), 
	"PAG_NRO_CUENTA_DESTINO" VARCHAR2(254), 
	"PAG_DESTINATARIO" VARCHAR2(2000), 
	"PAG_EMAIL_DESTINATARIO" VARCHAR2(254), 
	"PAG_NRO_SOLICITUD" NUMBER(10,0), 
	"PAG_CODIGO_IBAN" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"PAG_DESCRIPCION_DOC" VARCHAR2(1000 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PAGOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_PAGOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PAG_SECUENCIA" NUMBER(10,0), 
	"TSP_ID_SALIDA_PAGO" VARCHAR2(3 CHAR), 
	"DCP_SECUENCIA" NUMBER(10,0), 
	"MEP_ID_MEDIO_PAGO" VARCHAR2(3 CHAR), 
	"STP_ID_STATUS_PAGO" VARCHAR2(3 CHAR), 
	"TPA_ID_PAGO" VARCHAR2(3 CHAR), 
	"PAG_VALOR" NUMBER(18,2), 
	"PAG_FEC_EST" DATE, 
	"PAG_FEC_VTO" DATE, 
	"PAG_FEC_APR" DATE, 
	"PAG_FEC_ERP" DATE, 
	"PAG_FEC_PAG" DATE, 
	"PAG_DESCRIPCION" VARCHAR2(1000 CHAR), 
	"PAG_DOCUMENTO" VARCHAR2(254 CHAR), 
	"PAG_COMBINACION" VARCHAR2(254 CHAR), 
	"PAG_CK_COMB" NUMBER(10,0), 
	"PAG_CK_RECUPERADO" VARCHAR2(1 CHAR), 
	"PAG_CK_SOLICITADO" VARCHAR2(1 CHAR), 
	"PAG_FECHA" DATE, 
	"PAG_COMPROBANTE" VARCHAR2(2000 CHAR), 
	"PAG_NRO_IDENTIFICACION" VARCHAR2(254 CHAR), 
	"PAG_TIPO_CUENTA_DESTNO" VARCHAR2(254 CHAR), 
	"PAG_NRO_CUENTA_DESTINO" VARCHAR2(254 CHAR), 
	"PAG_DESTINATARIO" VARCHAR2(2000 CHAR), 
	"PAG_EMAIL_DESTINATARIO" VARCHAR2(254 CHAR), 
	"PAG_NRO_SOLICITUD" NUMBER(10,0), 
	"PAG_CODIGO_IBAN" VARCHAR2(254 CHAR), 
	"PAG_DESCRIPCION_DOC" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PAGOS_NOM_D
--------------------------------------------------------

  CREATE TABLE "M4SLL_PAGOS_NOM_D" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PNO_SECUENCIA" NUMBER(10,0), 
	"PND_SECUENCIA" NUMBER(10,0), 
	"MCO_ID_CONCEPTO" VARCHAR2(10 CHAR), 
	"PND_FECHA_DESDE" DATE, 
	"PND_FECHA_HASTA" DATE, 
	"PND_IMPORTE" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"MCO_NM_CONCEPTO" VARCHAR2(1000 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PAGOS_NOMINA
--------------------------------------------------------

  CREATE TABLE "M4SLL_PAGOS_NOMINA" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"PNO_SECUENCIA" NUMBER(10,0), 
	"PNO_LOTE" NUMBER(10,0), 
	"TPA_ID_PAGO" VARCHAR2(3 CHAR), 
	"PNO_VALOR" NUMBER(18,4), 
	"PNO_FECHA" DATE, 
	"PNO_FECHA_VENCIMIENTO" DATE, 
	"PNO_PRINCIPAL_S_N" VARCHAR2(1 CHAR), 
	"PNO_INTERESES" NUMBER(18,4), 
	"PNO_ANTIGUEDAD_RECONOCIDA" DATE, 
	"PNO_FECHA_IMPUTACION_DESDE" DATE, 
	"PNO_FECHA_IMPUTACION_HASTA" DATE, 
	"PNO_ADJUNTA_VIDA_LABORAL" VARCHAR2(1 CHAR), 
	"PNO_FECHA_REINCORPORACION" DATE, 
	"PNO_APLICA_SAL_DIA_HASTA_RES_R" VARCHAR2(1 CHAR), 
	"PNO_SALARIO_DIA" NUMBER(18,4), 
	"PNO_FECHA_INICIO_SANCION" DATE, 
	"PNO_FECHA_FIN_SANCION" DATE, 
	"PNO_DIAS_SANCIONADO" NUMBER(10,0), 
	"PNO_COTIZACION" VARCHAR2(30 CHAR), 
	"SSP_ID_CABEC_TC1" VARCHAR2(15 CHAR), 
	"PNO_RECONOCIMIENTO_DERECHO" VARCHAR2(1 CHAR), 
	"PNO_CUENTA_ABONO" VARCHAR2(30 CHAR), 
	"PNO_CODIGO_IBAN" VARCHAR2(30 CHAR), 
	"PNO_OTRAS_CUENTAS" VARCHAR2(30 CHAR), 
	"PNO_NRO_CUENTA_JUZGADO" VARCHAR2(30 CHAR), 
	"PNO_BENEFICIARIO" VARCHAR2(254 CHAR), 
	"IPN_IMPORTE_TRANSFERIDO" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"IPN_RETENCION_JUDICIAL" NUMBER(18,4), 
	"IPN_IMPORTE_BRUTO" NUMBER(18,4), 
	"IPN_DESCUENTOS_S_S" NUMBER(18,4), 
	"IPN_DESCUENTOS_IRPF" NUMBER(18,4), 
	"IPN_FECHA_TRANSFERENCIA" DATE, 
	"PNO_FECHA_ENVIO_NOMINA" DATE, 
	"PNO_APLI_SANCION_S_N" VARCHAR2(1 CHAR), 
	"PNO_LETRA_JUZGADO" VARCHAR2(30 CHAR), 
	"PNO_COD_IBAN_GENE" VARCHAR2(30 CHAR), 
	"PNO_NRO_EXP" VARCHAR2(30 CHAR), 
	"PNO_NETO_S_N" VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PAGOS_TRN
--------------------------------------------------------

  CREATE TABLE "M4SLL_PAGOS_TRN" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"PAG_SECUENCIA" NUMBER(10,0), 
	"STP_ID_STATUS_PAGO" VARCHAR2(3), 
	"NROCBTE" VARCHAR2(30), 
	"NRODOC" VARCHAR2(30), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PARAMETRICA
--------------------------------------------------------

  CREATE TABLE "M4SLL_PARAMETRICA" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"PAR_SECUENCIA" NUMBER(10,0), 
	"PAR_NM_CORTO" VARCHAR2(10 CHAR), 
	"PAR_NM_LARGO" VARCHAR2(2000 CHAR), 
	"PAR_VAL_NUMBER" NUMBER(10,0), 
	"PAR_VAL_DATE" DATE, 
	"PAR_VAL_CHAR" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PARAM_USR
--------------------------------------------------------

  CREATE TABLE "M4SLL_PARAM_USR" 
   (	"USUARIO" VARCHAR2(30), 
	"PAGINA" NUMBER, 
	"FILTRO" VARCHAR2(1000), 
	"JSON" VARCHAR2(1000), 
	"CONSULTA" CLOB, 
	"ACCION" VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
 LOB ("CONSULTA") STORE AS BASICFILE (ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
--------------------------------------------------------
--  DDL for Table M4SLL_PEDIDO_DET
--------------------------------------------------------

  CREATE TABLE "M4SLL_PEDIDO_DET" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"PDE_SECUENCIA" NUMBER(10,0), 
	"MPD_ID_PEDIDO_DETALLE" VARCHAR2(3), 
	"PDE_OBSERRVACION" VARCHAR2(2000), 
	"CLO_ID_CLIENTE" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PEDIDOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_PEDIDOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"PED_SECUENCIA" NUMBER(10,0), 
	"PED_VALOR" NUMBER(18,4), 
	"PED_OBSERVACION" VARCHAR2(254), 
	"PED_SUB_PEDIDO" VARCHAR2(254), 
	"PED_PRINCIPAL_S_N" VARCHAR2(1), 
	"PED_PERIODO" DATE, 
	"PED_VALOR_RECARGO" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PEDIDOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_PEDIDOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"PED_SECUENCIA" NUMBER(10,0), 
	"PED_VALOR" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"PED_OBSERVACION" VARCHAR2(254 CHAR), 
	"PED_SUB_PEDIDO" VARCHAR2(254 CHAR), 
	"PED_PRINCIPAL_S_N" VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PEDIDOS_PRUEBA_GABY
--------------------------------------------------------

  CREATE TABLE "M4SLL_PEDIDOS_PRUEBA_GABY" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"PED_SECUENCIA" NUMBER(10,0), 
	"PED_VALOR" NUMBER(18,4), 
	"PED_OBSERVACION" VARCHAR2(254), 
	"PED_SUB_PEDIDO" VARCHAR2(254), 
	"PED_PRINCIPAL_S_N" VARCHAR2(1), 
	"PED_PERIODO" DATE, 
	"PED_VALOR_RECARGO" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PERSONA_EXT
--------------------------------------------------------

  CREATE TABLE "M4SLL_PERSONA_EXT" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"PEX_ID_PERSONA_EXT" VARCHAR2(9), 
	"PEX_NOMBRE" VARCHAR2(254), 
	"PEX_APELLIDO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"PEX_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"PEX_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"PEX_NEGOCIO" VARCHAR2(255 CHAR), 
	"PEX_EMPRESA" VARCHAR2(255 CHAR), 
	"PEX_TP_EMPLEADO" VARCHAR2(10 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PERSONA_EXT_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_PERSONA_EXT_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"PEX_ID_PERSONA_EXT" VARCHAR2(9), 
	"PEX_NOMBRE" VARCHAR2(254), 
	"PEX_APELLIDO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PERSONA_EXT_QA
--------------------------------------------------------

  CREATE TABLE "M4SLL_PERSONA_EXT_QA" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"PEX_NRO_DOCUMENTO" VARCHAR2(20), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"PEX_ID_PERSONA_EXT" VARCHAR2(9), 
	"PEX_NOMBRE" VARCHAR2(254), 
	"PEX_APELLIDO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_PROV_ABOGADO
--------------------------------------------------------

  CREATE TABLE "M4SLL_PROV_ABOGADO" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"PRA_SECUENCIA" NUMBER(10,0), 
	"PRA_MONTO" NUMBER(18,4), 
	"PRA_PORC_PROV_MES" NUMBER(5,2), 
	"PRA_MONTO_PROV" NUMBER(18,4), 
	"PRA_DT_ALTA" DATE, 
	"PRA_OBSERVACIONES" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_REGION
--------------------------------------------------------

  CREATE TABLE "M4SLL_REGION" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"REG_SECUENCIA" NUMBER(10,0), 
	"REG_ID_REGION" VARCHAR2(30), 
	"STD_ID_GEO_DIV" VARCHAR2(8), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8), 
	"STD_ID_GEO_PLACE" VARCHAR2(9), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"NEG_ID_NEGOCIO" VARCHAR2(3 CHAR), 
	"STD_ID_LEG_ENT" VARCHAR2(9 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ROL_ACT_ROLE
--------------------------------------------------------

  CREATE TABLE "M4SLL_ROL_ACT_ROLE" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"MRA_ID_ROL_ACTOR" NUMBER(10,0), 
	"ID_APP_ROLE" VARCHAR2(30 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ROL_APROBS
--------------------------------------------------------

  CREATE TABLE "M4SLL_ROL_APROBS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"ID_APP_ROLE" VARCHAR2(30), 
	"ROA_VAL_MINIMO" NUMBER(18,4), 
	"ROA_VAL_MAXIMO" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ROLES_USRS
--------------------------------------------------------

  CREATE TABLE "M4SLL_ROLES_USRS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"ID_APP_ROLE" VARCHAR2(30), 
	"TPR_ID_TP_ROL" NUMBER(10,0), 
	"EJU_ID_EST_JURIDICO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_RP_CB_LITIGI
--------------------------------------------------------

  CREATE TABLE "M4SLL_RP_CB_LITIGI" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"RCL_MES" NUMBER(2,0), 
	"RCL_ANIO" NUMBER(4,0), 
	"RCL_CARPET_ID" VARCHAR2(10 CHAR), 
	"RCL_NO" VARCHAR2(10 CHAR), 
	"RCL_MONTO_PREV_CAUSAS_M1" NUMBER(14,4), 
	"RCL_MONTO_PREV_HONORARIOS_M1" NUMBER(14,4), 
	"RCL_CARPET_CARATULA" VARCHAR2(254 CHAR), 
	"RCL_ESTJUI_DESCRIPCION" VARCHAR2(254 CHAR), 
	"RCL_MONTO_CAUSA" NUMBER(14,4), 
	"RCL_PREVISION_CONDENA" NUMBER(3,0), 
	"RCL_FEC_DE_ALTA_PREV_CONDENA" DATE, 
	"RCL_MONTO_PREVISIONADO_CAUSA" NUMBER(14,4), 
	"RCL_VARIACION_CAUSA" NUMBER(14,4), 
	"RCL_OBSERVACIONES" VARCHAR2(254 CHAR), 
	"RCL_HONORIOS_Y_COSTAS" NUMBER(14,4), 
	"RCL_PROVISION_HONORARIOS" NUMBER(3,0), 
	"RCL_FEC_DE_ALTA_PREV_HONORARIO" DATE, 
	"RCL_MONTO_PREV_HONORARIOS" NUMBER(14,4), 
	"RCL_VARIACION_HONORARIOS" NUMBER(14,4), 
	"RCL_OBSERV_HONORARIOS" VARCHAR2(254 CHAR), 
	"RCL_JURISDICCION" VARCHAR2(254 CHAR), 
	"RCL_JUZGADO" VARCHAR2(254 CHAR), 
	"RCL_CARPET_FECESTIMTERMINACION" VARCHAR2(10 CHAR), 
	"RCL_CONTIN_DESCRIPCION" VARCHAR2(254 CHAR), 
	"RCL_FECHAMONTO" DATE, 
	"RCL_CLISEC_DESCRIPCION" VARCHAR2(254 CHAR), 
	"RCL_TIPO_CARPETA" VARCHAR2(254 CHAR), 
	"RCL_MONTOART" VARCHAR2(10 CHAR), 
	"RCL_ART" VARCHAR2(10 CHAR), 
	"RCL_LETRADOCONTRAPARTE" VARCHAR2(254 CHAR), 
	"RCL_ULTIMOMONTO" NUMBER(14,4), 
	"RCL_ABOGADO" VARCHAR2(254 CHAR), 
	"RCL_PROBALIDAD" VARCHAR2(60 CHAR), 
	"RCL_FLEX_CONDENA" VARCHAR2(254 CHAR), 
	"RCL_FLEX_HONORARIOS" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_RP_ES_FICHER
--------------------------------------------------------

  CREATE TABLE "M4SLL_RP_ES_FICHER" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"REFE" VARCHAR2(100), 
	"USUARIO" VARCHAR2(100), 
	"EMPRESA" VARCHAR2(100), 
	"IDNEGOCIO" VARCHAR2(100), 
	"NEGOCIO" VARCHAR2(100), 
	"IDDELEGACION" VARCHAR2(100), 
	"DELEGACION" VARCHAR2(100), 
	"ZONALAB" VARCHAR2(100), 
	"DEMANDANTE" VARCHAR2(100), 
	"NIF" VARCHAR2(100), 
	"CODIGO" VARCHAR2(100), 
	"ANALITICA" VARCHAR2(100), 
	"EMP" VARCHAR2(100), 
	"CTA" VARCHAR2(100), 
	"DLG" VARCHAR2(100), 
	"DIV" VARCHAR2(100), 
	"CECO" VARCHAR2(100), 
	"TIPO_DEMANDANTE" VARCHAR2(100), 
	"PERSONAL" VARCHAR2(100), 
	"FECHA_ALTA" VARCHAR2(100), 
	"PROV_S_N" VARCHAR2(100), 
	"IMPORTE_PROVISION" VARCHAR2(100), 
	"IMPORTE_PREVISTO" VARCHAR2(100), 
	"TOTAL_COSTE" VARCHAR2(100), 
	"IDASUNTO" VARCHAR2(100), 
	"ASUNTO" VARCHAR2(100), 
	"IDSUBASUNTO" VARCHAR2(100), 
	"SUBASUNTO" VARCHAR2(100), 
	"FECHA_DESPIDO_DEMANDA" VARCHAR2(100), 
	"FECHA_CONCILIACION" VARCHAR2(100), 
	"IDRESULTADO_CONCILIACION" VARCHAR2(100), 
	"RESULTADO_CONCILIACION" VARCHAR2(100), 
	"FECHA_JUZGADO" VARCHAR2(100), 
	"NRO_AUTOS" VARCHAR2(100), 
	"IDRESULTADO" VARCHAR2(100), 
	"RESULTADO" VARCHAR2(100), 
	"TRIB_SUPERIOR_FECHA" VARCHAR2(100), 
	"IDTRIB_SUPERIOR_RESULTADO" VARCHAR2(100), 
	"TRIB_SUPERIOR_RESULTADO" VARCHAR2(100), 
	"TRIB_SUPREMO_FECHA" VARCHAR2(100), 
	"IDTRIB_SUPREMO_RESULTADO" VARCHAR2(100), 
	"TRIB_SUPREMO_RESULTADO" VARCHAR2(100), 
	"FECHA_ESTADO" VARCHAR2(100), 
	"IDESTADO_FINAL" VARCHAR2(100), 
	"ESTADO_FINAL" VARCHAR2(100), 
	"IDABOGADO" VARCHAR2(100), 
	"ABOGADO" VARCHAR2(100), 
	"OBSERVACIONES" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_RP_ES_LITIGI
--------------------------------------------------------

  CREATE TABLE "M4SLL_RP_ES_LITIGI" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"REL_USUARIO" VARCHAR2(50), 
	"REL_SECUENCIA" NUMBER(10,0), 
	"REL_ID_LITIGIO" VARCHAR2(20), 
	"REL_ID_LEGADO" VARCHAR2(20), 
	"REL_EMPRESA" VARCHAR2(255), 
	"REL_NEGOCIO" VARCHAR2(255), 
	"REL_CIUDAD" VARCHAR2(255), 
	"REL_DELEGACION" VARCHAR2(255), 
	"REL_ZONA_LABORAL" VARCHAR2(255), 
	"REL_DEMANDANTE" VARCHAR2(255), 
	"REL_DEMANDANTE_NIF" VARCHAR2(20), 
	"REL_DEMANDANTE_LEGAJO" VARCHAR2(10), 
	"REL_COMBINACION_ANALITICA" VARCHAR2(255), 
	"REL_TIPO_DEMANDANTE" VARCHAR2(20), 
	"REL_TIPO_PERSONA" VARCHAR2(200), 
	"REL_FECHA_ALTA" DATE, 
	"REL_IMPORTE_PREVISTO" NUMBER(18,4), 
	"REL_ASUNTO" VARCHAR2(1000), 
	"REL_ASUNTOS_SECUNDARIOS" VARCHAR2(1000), 
	"REL_SUBASUNTO" VARCHAR2(1000), 
	"REL_FECHA_DEMANDA" DATE, 
	"REL_NRO_AUTO" VARCHAR2(255), 
	"REL_FECHA_CONCILIACION" DATE, 
	"REL_FASE_RESUL_CON" VARCHAR2(255), 
	"REL_FECHA_JUZGADO" DATE, 
	"REL_RESULTADO_JUZGADO" VARCHAR2(255), 
	"REL_FECHA_TRIBUNAL_SUPERIOR" DATE, 
	"REL_RESULTADO_TRI_SUPERIOR" VARCHAR2(255), 
	"REL_FECHA_TRIBUNAL_SUPREMO" DATE, 
	"REL_RESULTADO_TRI_SUPREMO" VARCHAR2(255), 
	"REL_COSTO_TOTAL" NUMBER(18,4), 
	"REL_FECHA_ESTADO" DATE, 
	"REL_ESTADO_CIERRE" VARCHAR2(200), 
	"REL_ABOGADO_RESPONSABLE" VARCHAR2(255), 
	"REL_OBSERVACION" VARCHAR2(1000), 
	"REL_SUBASUNTOS_SECUNDARIOS" VARCHAR2(1000), 
	"REL_FECHA_NOTIFICACION" DATE, 
	"REL_VALOR_RECARGO" NUMBER(18,4), 
	"REL_FECHA_CIERRE" DATE, 
	"REL_MATERIA" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"REL_FECHA_ACTUALIZACION" DATE, 
	"REL_EMP_LIT" VARCHAR2(255 CHAR), 
	"REL_EST_FINAL" VARCHAR2(254 CHAR), 
	"REL_CLIENTE" VARCHAR2(1000 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_RP_ES_PROVIS
--------------------------------------------------------

  CREATE TABLE "M4SLL_RP_ES_PROVIS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"REL_USUARIO" VARCHAR2(50 CHAR), 
	"REL_SECUENCIA" NUMBER(10,0), 
	"REL_ID_LITIGIO" VARCHAR2(20 CHAR), 
	"REL_EMPRESA" VARCHAR2(255 CHAR), 
	"REL_NEGOCIO" VARCHAR2(255 CHAR), 
	"REL_CIUDAD" VARCHAR2(255 CHAR), 
	"REL_DELEGACION" VARCHAR2(255 CHAR), 
	"REL_ZONA_LABORAL" VARCHAR2(255 CHAR), 
	"REL_DEMANDANTE" VARCHAR2(255 CHAR), 
	"REL_DEMANDANTE_NIF" VARCHAR2(20 CHAR), 
	"REL_DEMANDANTE_LEGAJO" VARCHAR2(10 CHAR), 
	"REL_COMBINACION_ANALITICA" VARCHAR2(255 CHAR), 
	"REL_ID_REGION" VARCHAR2(10 CHAR), 
	"REL_TIPO_DEMANDANTE" VARCHAR2(20 CHAR), 
	"REL_TIPO_PERSONA" VARCHAR2(200 CHAR), 
	"REL_FECHA_ALTA" DATE, 
	"REL_IMPORTE_PREVISTO" NUMBER(18,4), 
	"REL_ASUNTO" VARCHAR2(1000 CHAR), 
	"REL_ASUNTOS_SECUNDARIOS" VARCHAR2(1000 CHAR), 
	"REL_SUBASUNTO" VARCHAR2(1000 CHAR), 
	"REL_FECHA_DEMANDA" DATE, 
	"REL_NRO_AUTO" VARCHAR2(255 CHAR), 
	"REL_FECHA_CONCILIACION" DATE, 
	"REL_FASE_RESUL_CON" VARCHAR2(255 CHAR), 
	"REL_FECHA_JUZGADO" DATE, 
	"REL_RESULTADO_JUZGADO" VARCHAR2(255 CHAR), 
	"REL_FECHA_TRIBUNAL_SUPERIOR" DATE, 
	"REL_RESULTADO_TRI_SUPERIOR" VARCHAR2(255 CHAR), 
	"REL_FECHA_TRIBUNAL_SUPREMO" DATE, 
	"REL_RESULTADO_TRI_SUPREMO" VARCHAR2(255 CHAR), 
	"REL_COSTO_TOTAL" NUMBER(18,4), 
	"REL_FECHA_ESTADO" DATE, 
	"REL_ESTADO_CIERRE" VARCHAR2(200 CHAR), 
	"REL_ABOGADO_RESPONSABLE" VARCHAR2(255 CHAR), 
	"REL_OBSERVACION" VARCHAR2(1000 CHAR), 
	"REL_SUBASUNTOS_SECUNDARIOS" VARCHAR2(1000 CHAR), 
	"REL_FECHA_NOTIFICACION" DATE, 
	"REL_VALOR_RECARGO" NUMBER(18,4), 
	"REL_FECHA_CIERRE" DATE, 
	"REL_MATERIA" VARCHAR2(1000 CHAR), 
	"REL_ID_DIVISION" VARCHAR2(10 CHAR), 
	"REL_IMPORTE_PROVISION" NUMBER(18,4), 
	"REL_ID_LEG_ENT" VARCHAR2(10 CHAR), 
	"REL_ID_LEGADO" VARCHAR2(20 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_SEGURIDAD
--------------------------------------------------------

  CREATE TABLE "M4SLL_SEGURIDAD" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ID_APP_ROLE" VARCHAR2(50 CHAR), 
	"SS_SECUENCIAL" NUMBER(10,0), 
	"SS_SQL" CLOB, 
	"SS_CHK_SELECT" VARCHAR2(1 CHAR), 
	"SS_CHK_UPDATE" VARCHAR2(1 CHAR), 
	"SS_CHK_INSERT" VARCHAR2(1 CHAR), 
	"SS_CHK_DELETE" VARCHAR2(1 CHAR), 
	"SS_CHK_CLIENTE_OBM" VARCHAR2(1 CHAR), 
	"SS_CHK_DTI" VARCHAR2(1 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
 LOB ("SS_SQL") STORE AS BASICFILE (ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
--------------------------------------------------------
--  DDL for Table M4SLL_SEGURIDAD_VI
--------------------------------------------------------

  CREATE TABLE "M4SLL_SEGURIDAD_VI" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ID_APP_ROLE" VARCHAR2(50 CHAR), 
	"SSV_ID_MODULO" VARCHAR2(254 CHAR), 
	"SSV_CHK_VER" VARCHAR2(1 CHAR), 
	"SSV_CHK_GUARDAR" VARCHAR2(1 CHAR), 
	"SSV_CHK_MODIFICAR" VARCHAR2(1 CHAR), 
	"SSV_CHK_ELIMINAR" VARCHAR2(1 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_SEGURIDAD2
--------------------------------------------------------

  CREATE TABLE "M4SLL_SEGURIDAD2" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"ID_APP_ROLE" VARCHAR2(50 CHAR), 
	"SS_SECUENCIAL" NUMBER(10,0), 
	"SS_SQL" CLOB, 
	"SS_CHK_SELECT" VARCHAR2(1 CHAR), 
	"SS_CHK_UPDATE" VARCHAR2(1 CHAR), 
	"SS_CHK_INSERT" VARCHAR2(1 CHAR), 
	"SS_CHK_DELETE" VARCHAR2(1 CHAR), 
	"SS_CHK_CLIENTE_OBM" VARCHAR2(1 CHAR), 
	"SS_CHK_DTI" VARCHAR2(1 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
 LOB ("SS_SQL") STORE AS BASICFILE (ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
--------------------------------------------------------
--  DDL for Table M4SLL_SGD_CONFIG
--------------------------------------------------------

  CREATE TABLE "M4SLL_SGD_CONFIG" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"SGDC_CONTEXT" VARCHAR2(300 CHAR), 
	"SGDC_ENDPOINT" VARCHAR2(300 CHAR), 
	"SGDC_MAIN_CLASS" VARCHAR2(300 CHAR), 
	"SGDC_TOKEN_SECURITY" VARCHAR2(300 CHAR), 
	"SGDC_COUNTRY" VARCHAR2(300 CHAR), 
	"SGDC_METHOD_GET_DO" VARCHAR2(300 CHAR), 
	"SGCD_METHOD_DEL_DOCUMENTS" VARCHAR2(300 CHAR), 
	"SGDC_METHOD_OBTAIN_DOCUMENT" VARCHAR2(300 CHAR), 
	"SGDC_METHOD_SAVE_DOCUMENT" VARCHAR2(300 CHAR), 
	"SGDC_ATTRIBUTES" VARCHAR2(300 CHAR), 
	"SGDC_VAL_ATTRIBUTES" VARCHAR2(300 CHAR), 
	"SGDC_TP_DOCUMENTO" VARCHAR2(300 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_STATUS_PAGOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_STATUS_PAGOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"STP_ID_STATUS_PAGO" VARCHAR2(3), 
	"STP_NM_STATUS_PAGO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_ST_REPO_PROV
--------------------------------------------------------

  CREATE TABLE "M4SLL_ST_REPO_PROV" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"SSR_PERIODO" DATE, 
	"MSR_ID_STATUS_REPORTE" VARCHAR2(3 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"SRP_APROBACION_G" VARCHAR2(1 CHAR), 
	"SRP_APROBACION_D" VARCHAR2(1 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TOTHONJ
--------------------------------------------------------

  CREATE TABLE "M4SLL_TOTHONJ" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"TNJ_ANIO" NUMBER(4,0), 
	"TNJ_MES" NUMBER(2,0), 
	"MAB_SECUENCIA" NUMBER(10,0), 
	"TNJ_MONTO_A" NUMBER(18,4), 
	"TNJ_MONTO" NUMBER(18,4), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TOTPEDHIS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TOTPEDHIS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"TPH_MES" NUMBER(2,0), 
	"TPH_ANIO" NUMBER(4,0), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"STD_ID_LEG_ENT" VARCHAR2(9), 
	"EJU_ID_EST_JURIDICO" VARCHAR2(3), 
	"TPH_AUTOR" VARCHAR2(1000), 
	"TPH_REU" VARCHAR2(1000), 
	"LIT_NRO_PROCESO" VARCHAR2(100), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TPH_VALOR_DEMANDA" NUMBER(18,4), 
	"TPH_VALOR_DEM_INTERES" NUMBER(18,4), 
	"TPH_VALOR_DEM_COR_MON" NUMBER(18,4), 
	"TPH_VALOR_DEM_ACT" NUMBER(18,4), 
	"TPH_VAL_RIESGO" NUMBER(18,4), 
	"TPH_VALOR_PROVISION" NUMBER(18,4), 
	"TPH_PAGOS" NUMBER(18,4), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TPH_VAL_HON_JURIDICO" NUMBER(18,4), 
	"TPH_VAL_PREMIO_JURIDICO" NUMBER(18,4), 
	"TPH_VAL_TOTAL_HON_JUR" NUMBER(18,4), 
	"TPH_AUTOR_RUN" VARCHAR2(1000), 
	"TPH_AUTOR_CAUSAL" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPH_VALOR_CONDENA" NUMBER(18,4), 
	"TPH_PORC_PROV_CONDENA" NUMBER(5,2), 
	"TPH_VALOR_PROV_CONDENA" NUMBER(18,4), 
	"TPH_VALOR_HON" NUMBER(18,4), 
	"TPH_PORC_PROV_HON" NUMBER(5,2), 
	"TPH_VALOR_PROV_HON" NUMBER(18,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_AUTOR_REU
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_AUTOR_REU" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"TAR_NM_TP_AUTOR_REU" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TAR_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TAR_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_AUTOR_REU_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_AUTOR_REU_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TAR_ID_TP_AUTOR_REU" VARCHAR2(3), 
	"TAR_NM_TP_AUTOR_REU" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_COMPROMIS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_COMPROMIS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TCO_ID_TP_COMPROMISO" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TCO_NM_TP_COMPROMISO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TCO_DT_VALIDEZ" NUMBER(4,0), 
	"TCO_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TCO_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_COMPROMIS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_COMPROMIS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TCO_ID_TP_COMPROMISO" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TCO_NM_TP_COMPROMISO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TCO_DT_VALIDEZ" NUMBER(4,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_DOC_LITIG
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_DOC_LITIG" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TDL_ID_TP_DOC_LITIGIO" VARCHAR2(3), 
	"TDL_NM_TP_DOC_LITIGIO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TDL_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TDL_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_DOC_LITIG_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_DOC_LITIG_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TDL_ID_TP_DOC_LITIGIO" VARCHAR2(3), 
	"TDL_NM_TP_DOC_LITIGIO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_ENTIDADES
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_ENTIDADES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"TPE_NM_TP_ENTIDAD" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPE_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TPE_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_ENTIDADES_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_ENTIDADES_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_TP_ENTIDAD" VARCHAR2(3), 
	"TPE_NM_TP_ENTIDAD" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_FALTAS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_FALTAS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"TFL_ID_TP_FALTA" VARCHAR2(3 CHAR), 
	"TFL_NM_TP__FALTA" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3 CHAR), 
	"TFL_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TFL_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_FASES
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_FASES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TFA_NM_TP_FASE" VARCHAR2(254), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TFA_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TFA_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_FASES_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_FASES_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TFA_ID_TP_FASE" VARCHAR2(3), 
	"TFA_NM_TP_FASE" VARCHAR2(254), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_IDENTIFIC
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_IDENTIFIC" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"TPI_NM_TP_IDENTIFICACION" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPI_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TPI_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_IDENTIFIC_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_IDENTIFIC_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPI_ID_TP_IDENTIFICACION" VARCHAR2(3), 
	"TPI_NM_TP_IDENTIFICACION" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_LITIGIOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_LITIGIOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPL_NM_TP_LITIGIO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TPL_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_LITIGIOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_LITIGIOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPL_NM_TP_LITIGIO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_MOTIVO
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_MOTIVO" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TMO_ID_TP_MOTIVO" VARCHAR2(3), 
	"TMO_NM_TP_MOTIVO" VARCHAR2(254), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TMO_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TMO_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_PAGOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_PAGOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPA_ID_PAGO" VARCHAR2(3), 
	"TPA_NM_PAGO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPA_NUMERO_CUENTA" VARCHAR2(30 CHAR), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPA_VENDOR_ID" VARCHAR2(15 CHAR), 
	"TPA_VENDOR_SITE_ID" VARCHAR2(15 CHAR), 
	"VENDOR_NAME" VARCHAR2(240 CHAR), 
	"TPA_NOMINA_S_N" VARCHAR2(1 CHAR), 
	"TPA_CONCEPTO" VARCHAR2(1 CHAR), 
	"TPA_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TPA_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_PAGOS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_PAGOS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPA_ID_PAGO" VARCHAR2(3), 
	"TPA_NM_PAGO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPA_NUMERO_CUENTA" VARCHAR2(30 CHAR), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPA_VENDOR_ID" VARCHAR2(15 CHAR), 
	"TPA_VENDOR_SITE_ID" VARCHAR2(15 CHAR), 
	"VENDOR_NAME" VARCHAR2(240 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_PEDIDO
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_PEDIDO" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"TPE_NM_PEDIDO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TPE_PROVISIONA_S_N" VARCHAR2(1 CHAR), 
	"TPE_DT_END" DATE, 
	"TPE_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_PEDIDO_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_PEDIDO_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"TPE_NM_PEDIDO" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_RECLAMOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_RECLAMOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"TRC_ID_TP_RECLAMO" VARCHAR2(3 CHAR), 
	"TRC_NM_TP_RECLAMO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3 CHAR), 
	"TRC_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TRC_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_RECURREN
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_RECURREN" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TRE_ID_RECURRENCIA" VARCHAR2(3), 
	"TRE_NM_RECURRENCIA" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TRE_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TRE_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_ROLES
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_ROLES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TPR_ID_TP_ROL" NUMBER(10,0), 
	"TPR_NM_TP_ROL" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPR_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TPR_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_SALIDA_PA
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_SALIDA_PA" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"TSP_ID_SALIDA_PAGO" VARCHAR2(3 CHAR), 
	"TSP_NM_SALIDA_PAGO" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE, 
	"TSP_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TSP_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_STA_DET
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_STA_DET" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TSD_ID_TP_STA_DET" VARCHAR2(3), 
	"TSD_NM_TP_STATUS_DET" VARCHAR2(254), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TSD_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TSD_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_STATUS
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_STATUS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TST_NM_TP_STATUS" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TST_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TST_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TP_STATUS_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TP_STATUS_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TST_ID_TP_STATUS" VARCHAR2(3), 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"TST_NM_TP_STATUS" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_TRIBUNALES
--------------------------------------------------------

  CREATE TABLE "M4SLL_TRIBUNALES" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRI_NM_TRIBUNAL" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8 CHAR), 
	"STD_ID_GEO_PLACE" VARCHAR2(9 CHAR), 
	"TRI_DT_START" DATE DEFAULT TO_DATE ( '1800-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
	"TRI_DT_END" DATE DEFAULT TO_DATE ( '4000-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
  GRANT SELECT ON "M4SLL_TRIBUNALES" TO "RBLATLEG001";
--------------------------------------------------------
--  DDL for Table M4SLL_TRIBUNALES_BKP
--------------------------------------------------------

  CREATE TABLE "M4SLL_TRIBUNALES_BKP" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"TRI_ID_TRIBUNAL" VARCHAR2(3), 
	"TRI_NM_TRIBUNAL" VARCHAR2(254), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"TPL_ID_TP_LITIGIO" VARCHAR2(3), 
	"STD_ID_SUB_GEO_DIV" VARCHAR2(8 CHAR), 
	"STD_ID_GEO_PLACE" VARCHAR2(9 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_VAL_EC_LIT
--------------------------------------------------------

  CREATE TABLE "M4SLL_VAL_EC_LIT" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"VEL_SECUENCIA" NUMBER(10,0), 
	"LIT_ID_LITIGIO" VARCHAR2(10 CHAR), 
	"VEL_VALOR_CONDENA" NUMBER(18,4), 
	"VEL_PORC_PROV_CONDENA" NUMBER(18,4), 
	"VEL_IMP_PROV_CONDENA" NUMBER(18,4), 
	"VEL_VALOR_FINAL_CONDENA" NUMBER(18,4), 
	"VEL_DT_IMPACTO_COND" DATE, 
	"VEL_OBS_CONDENA" VARCHAR2(1000 CHAR), 
	"VEL_VAL_HONORARIOS" NUMBER(18,4), 
	"VEL_PORC_PROV_HONORARIOS" NUMBER(18,4), 
	"VEL_IMP_PROV_HONORARIOS" NUMBER(18,4), 
	"VEL_DT_IMPACTO_HONO" DATE, 
	"VEL_OBS_HONORARIOS" VARCHAR2(1000 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_VAL_LITIGIOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_VAL_LITIGIOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4), 
	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"VAL_SECUENCIA" NUMBER(10,0), 
	"TPE_ID_PEDIDO" VARCHAR2(3), 
	"VAL_FECHA" DATE, 
	"PED_VALOR" NUMBER(18,4), 
	"VAL_PED" NUMBER(18,4), 
	"VAL_PED_INT" NUMBER(18,4), 
	"VAL_PED_COR" NUMBER(18,4), 
	"VAL_PED_ACT" NUMBER(18,4), 
	"VAL_PROV" NUMBER(18,4), 
	"VAL_PROV_INT" NUMBER(18,4), 
	"VAL_PROV_COR" NUMBER(18,4), 
	"VAL_PROV_ACT" NUMBER(18,4), 
	"VAL_FECHA_BASE" DATE, 
	"VAL_AGREGADO_POR" NUMBER(1,0), 
	"VAL_RIESGO" NUMBER(18,4), 
	"VAL_RIESGO_JUST" VARCHAR2(1000), 
	"ID_APPROLE" VARCHAR2(30), 
	"ID_SECUSER" VARCHAR2(30), 
	"DT_LAST_UPDATE" DATE, 
	"VAL_POR_PROV" NUMBER(18,4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Table M4SLL_WKF_ESTADOS
--------------------------------------------------------

  CREATE TABLE "M4SLL_WKF_ESTADOS" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"WKE_ID_ESTADO" NUMBER(10,0), 
	"WKE_NM_ESTADO" VARCHAR2(254 CHAR), 
	"WKE_DT_START" DATE, 
	"WKE_DT_END" DATE, 
	"WKE_PLAZO" NUMBER(3,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_WKF_ROL_ESTA
--------------------------------------------------------

  CREATE TABLE "M4SLL_WKF_ROL_ESTA" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"WKE_ID_ESTADO" NUMBER(10,0), 
	"MRA_ID_ROL_ACTOR" NUMBER(10,0), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table M4SLL_WKF_TAR_ESTA
--------------------------------------------------------

  CREATE TABLE "M4SLL_WKF_TAR_ESTA" 
   (	"ID_ORGANIZATION" VARCHAR2(4 CHAR), 
	"WTE_SECUENCIA" NUMBER(10,0), 
	"WKE_ID_ESTADO" NUMBER(10,0), 
	"WTE_ESTADO_SIGUIENTE" NUMBER(10,0), 
	"WTE_NM_TAREA" VARCHAR2(254 CHAR), 
	"ID_APPROLE" VARCHAR2(30 CHAR), 
	"ID_SECUSER" VARCHAR2(30 CHAR), 
	"DT_LAST_UPDATE" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE( INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 121
  PCTINCREASE 50);
--------------------------------------------------------
--  DDL for Table RUPD$_M4SLL_LITIGIOS
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "RUPD$_M4SLL_LITIGIOS" 
   (	"LIT_ID_LITIGIO" VARCHAR2(10), 
	"ID_ORGANIZATION" VARCHAR2(4), 
	"DMLTYPE$$" VARCHAR2(1), 
	"SNAPID" NUMBER(*,0), 
	"CHANGE_VECTOR$$" RAW(255)
   ) ON COMMIT PRESERVE ROWS ;

   COMMENT ON TABLE "RUPD$_M4SLL_LITIGIOS"  IS 'temporary updatable snapshot log';
--------------------------------------------------------
--  DDL for View M4SLL_VW_AGENDA_ES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_AGENDA_ES" ("LIT_ID_LITIGIO", "TCO_ID_TP_COMPROMISO", "MAB_SECUENCIA", "TFA_ID_TP_FASE", "LIT_NRO_PROCESO", "TPE_ID_PEDIDO", "TPL_NM_TP_LITIGIO", "COM_DT_FIN_TERMINO", "COM_DT_INICIO_TERMINO") AS 
  SELECT comp.lit_id_litigio, comp.tco_id_tp_compromiso, comp.mab_secuencia,
          comp.tfa_id_tp_fase, lit.lit_nro_proceso, ped.tpe_id_pedido,
          tplit.tpl_nm_tp_litigio, comp.com_dt_fin_termino,
          comp.com_dt_inicio_termino
     FROM (M4GLOBAL.m4sll_compromisos comp INNER JOIN M4GLOBAL.m4sll_litigios lit
          ON comp.lit_id_litigio = lit.lit_id_litigio)
          LEFT JOIN
          M4GLOBAL.m4sll_pedidos ped
          ON (    comp.lit_id_litigio = ped.lit_id_litigio
              AND ped.ped_principal_s_n = 'S'
             )
          LEFT JOIN M4GLOBAL.m4sll_tp_litigios tplit
          ON lit.tpl_id_tp_litigio = tplit.tpl_id_tp_litigio
    WHERE lit.id_organization = '0001' 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_ANALITICA
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_ANALITICA" ("SCO_ID_HR", "SCO_ID_WORK_UNIT", "SSP_ID_CENT_COSTO", "CSP_ID_DELEG_CC", "CSP_ID_DIVIS_CC", "CSP_ID_CENTRO_CC", "CSP_ID_DIIVISION", "SSP_NM_DIVISIOESP", "CSP_ID_NEGOCIO", "CSP_N_NEGESP", "SCO_ID_POSITION", "SCO_DESCRIPTIONESP", "STD_ID_JOB_CODE", "STD_N_JOB_CODEESP", "CCO_ID_TP_JOB", "CCO_NM_TP_JOBESP", "STD_ID_LEG_ENT", "STD_N_LEG_ENT") AS 
  SELECT A1.SCO_ID_HR, a1.SCO_ID_WORK_UNIT, a2.SSP_ID_CENT_COSTO, A3.CSP_ID_DELEG_CC, A3.CSP_ID_DIVIS_CC, A3.CSP_ID_CENTRO_CC,
                               A6.CSP_ID_DIIVISION, A6.SSP_NM_DIVISIOESP, A7.CSP_ID_NEGOCIO, A7.CSP_N_NEGESP, a9.SCO_ID_POSITION, A9.SCO_DESCRIPTIONESP,
                               A10.STD_ID_JOB_CODE, A10.STD_N_JOB_CODEESP, A11.CCO_ID_TP_JOB, A11.CCO_NM_TP_JOBESP, A12.STD_ID_LEG_ENT, A13.STD_N_LEG_ENT
                            FROM m4global.M4SCO_H_HR_WUNIT A1, m4global.M4CSP_WUNIT_CCOSTO A2, m4global.M4SSP_CENTR_COSTO A3, M4GLOBAL.STD_PERSON A4
                            ,m4global.STD_WORK_UNIT A5, m4global.M4CSP_DIVISION A6, m4global.M4CSP_NEGOCIO A7,m4global.M4SCO_H_HR_POS A8, m4global.m4sco_positioN A9
                            , m4global.std_job A10, m4global.M4CCO_X_TP_JOB A11, m4global.m4sco_h_hr_legent A12, M4GLOBAL.STD_LEG_ENT A13
                            WHERE a1.id_organization = '0001'
                                 -- AND a1.SCO_ID_HR = AR.STD_ID_PERSON   --'ES00424402' -- busca por legajo
                                  --and a4.STD_SSN = ARG  -- busca por DNI  NIF para España
                                  AND a1.SCO_OR_HR_ROLE = (SELECT MAX(a11.SCO_OR_HR_ROLE) 
                                                                FROM m4global.M4SCO_H_HR_WUNIT A11                                                         
                                                            WHERE a11.id_organization = A1.ID_ORGANIZATION
                                                                  AND a1.SCO_ID_HR = a11.SCO_ID_HR
                                                                  AND a11.sco_dt_start = (SELECT MAX(a111.sco_dt_start) 
                                                                                            FROM m4global.M4SCO_H_HR_WUNIT A111 
                                                                                        WHERE a111.id_organization = a11.id_organization
                                                                                              AND a1.SCO_ID_HR = a111.SCO_ID_HR GROUP BY a111.SCO_ID_HR  )
                                                            group by a11.SCO_ID_HR    )
                                  AND A1.SCO_DT_START = (SELECT MAX(a1111.sco_dt_start) 
                                                                                            FROM m4global.M4SCO_H_HR_WUNIT A1111 
                                                                                        WHERE a1111.id_organization = a1.id_organization
                                                                                              AND a1.SCO_ID_HR = a1111.SCO_ID_HR 
                                                                                              GROUP BY a1111.SCO_ID_HR  )
                                  AND A1.ID_ORGANIZATION = A2.ID_ORGANIZATION and a1.SCO_ID_WORK_UNIT = a2.STD_ID_WORK_UNIT
                                  AND A2.DT_START = (SELECT MAX(A22.DT_START) FROM  m4global.M4CSP_WUNIT_CCOSTO A22 
                                                    WHERE A2.ID_ORGANIZATION = A22.ID_ORGANIZATION AND A2.STD_ID_WORK_UNIT = A22.STD_ID_WORK_UNIT
                                                    GROUP BY A22.STD_ID_WORK_UNIT )
                                  AND A1.ID_ORGANIZATION = A3.ID_ORGANIZATION and A2.SSP_ID_CENT_COSTO = A3.SSP_ID_CENT_COSTO
                                  AND A1.SCO_ID_HR = A4.STD_ID_PERSON
                                  AND A5.ID_ORGANIZATION = a1.ID_ORGANIZATION and a5.STD_ID_WORK_UNIT = a1.SCO_ID_WORK_UNIT
                                  AND A6.ID_ORGANIZATION = A5.ID_ORGANIZATION AND A6.CSP_ID_DIIVISION = A5.CSP_ID_DIIVISION
                                  AND A7.CSP_ID_NEGOCIO = A6.CSP_ID_NEGOCIO
                                  AND A8.ID_ORGANIZATION = A1.ID_ORGANIZATION AND A1.SCO_ID_HR = A8.SCO_ID_HR
                                  AND A8.SCO_OR_HR_ROLE = (SELECT MAX(A88.SCO_OR_HR_ROLE) FROM m4global.M4SCO_H_HR_POS A88 
                                                            WHERE A88.ID_ORGANIZATION = A8.ID_ORGANIZATION AND A8.SCO_ID_HR = A88.SCO_ID_HR
                                                            GROUP BY A88.SCO_ID_HR)
                                  AND A8.ID_ORGANIZATION = A9.ID_ORGANIZATION AND A8.SCO_ID_POSITION =A9.SCO_ID_POSITION
                                  AND A10.id_organization =A9.id_organization  and A10.STD_ID_JOB_CODE = A9.SCO_ID_JOB_CODE
                                  AND A11.CCO_ID_TP_JOB = A10.CCO_ID_TP_JOB
                                  AND A12.ID_ORGANIZATION  = A1.ID_ORGANIZATION AND A12.STD_ID_HR = A1.SCO_ID_HR
                                  AND A12.DT_START = (SELECT MAX(A122.DT_START) from m4global.m4sco_h_hr_legent A122 
                                                                    where A12.ID_ORGANIZATION  = A122.ID_ORGANIZATION 
                                                                        AND  A12.STD_ID_HR  =  A122.STD_ID_HR 
                                                      GROUP BY  A122.STD_ID_HR )
                                 AND A12.STD_OR_HR_PERIOD = ( SELECT MAX(A1222.STD_OR_HR_PERIOD) from m4global.m4sco_h_hr_legent A1222
                                                                WHERE A12.ID_ORGANIZATION  = A1222.ID_ORGANIZATION 
                                                                        AND  A12.STD_ID_HR  =  A1222.STD_ID_HR 
                                                                        AND A1222.DT_START = (SELECT MAX(A12222.DT_START) from m4global.m4sco_h_hr_legent A12222
                                                                                                 where A1222.ID_ORGANIZATION  = A12222.ID_ORGANIZATION 
                                                                                                 AND  A1222.STD_ID_HR  =  A12222.STD_ID_HR 
                                                                                                GROUP BY  A12222.STD_ID_HR )
                                                              )
                                 AND A12.ID_ORGANIZATION = A13.ID_ORGANIZATION AND A12.STD_ID_LEG_ENT = A13.STD_ID_LEG_ENT WITH READ ONLY
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_BAN_CCB
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_BAN_CCB" ("USUARIO", "BANDEJA", "ACCION") AS 
  SELECT usuario,
          
--  CONSULTA,
          M4GLOBAL.m4pkg_util_pkg.sql2json
                      (M4GLOBAL.m4pkg_util_pkg.f_sql_paginado_bind ('ADMIN',
                                                        consulta,
                                                        filtro,
                                                        pagina,
                                                        100
                                                       ),
                       filtro
                      ) AS bandeja,
          accion
     FROM M4GLOBAL.m4sll_param_usr
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_BAN_ES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_BAN_ES" ("USUARIO", "BANDEJA", "ACCION") AS 
  SELECT usuario, 
          
--  CONSULTA, 
          M4PKG_UTIL_PKG.sql2json 
                        (M4PKG_UTIL_PKG.f_sql_paginado_bind ('ADMIN', 
                                                        consulta,    
                                                        filtro,
                                                        pagina, 
                                                        300 
                                                       ), 
                         filtro 
                        ) AS bandeja,
                        ACCION
/*          
SELECT usuario, 
          
--  CONSULTA, 
          m4pkg_util_pkg.sql2json 
                        (m4pkg_util_pkg.f_sql_paginado_2 ('ADMIN', 
                                                        consulta, 
                                                        pagina, 
                                                        300 
                                                       ), 
                         '' 
                        ) AS bandeja,
                        ACCION
 */
     FROM m4sll_param_usr
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_CCB_RMJU_RB
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_CCB_RMJU_RB" ("Número de Proceso", "Número de Radicación", "Ciudad", "Entidad/Especialidad") AS 
  SELECT
     base0.lit_id_litigio "Número de Proceso",
     base2.fas_nro_radicacion "Número de Radicación",
     CASE base1.std_n_geo_placesp
          WHEN 'BOGOTA' THEN 'BOGOTA, D.C.'
          WHEN 'C/CUTA' THEN 'CUCUTA'
          WHEN 'FLORENCIA - CAQUETÁ' THEN 'FLORENCIA'
          WHEN 'ARMENIA - ANTIOQUIA' THEN 'ARMENIA'
          ELSE base1.std_n_geo_placesp END "Ciudad",
     base4.tri_nm_tribunal "Entidad/Especialidad"
FROM m4global.m4sll_litigios base0
LEFT JOIN m4global.std_geo_place base1
   ON base0.id_organization = base1.id_organization
   AND base1.std_id_country = '8'
   AND base1.std_id_geo_div = '8'
   AND base1.std_id_geo_place = base0.std_id_geo_place
   AND base1.std_id_sub_geo_div = base0.std_id_sub_geo_div
LEFT JOIN m4global.m4sll_fases base2
   ON base0.lit_id_litigio = base2.lit_id_litigio
   AND base0.id_organization = base2.id_organization
   AND base2.fas_fecha IN (
            SELECT   MAX (base3.fas_fecha)
            FROM m4global.m4sll_fases base3
            WHERE base3.id_organization = base0.id_organization AND base3.lit_id_litigio = base0.lit_id_litigio
            GROUP BY base3.lit_id_litigio)
LEFT JOIN m4global.m4sll_tribunales base4
   ON base4.id_organization = base0.id_organization
   AND base4.TRI_ID_TRIBUNAL = base2.TRI_ID_TRIBUNAL
WHERE base0.id_organization = '0150'
and base0.TST_ID_TP_STATUS = 1
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_CPE_RB
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_CPE_RB" ("Número de Proceso", "Número de Radicación") AS 
  SELECT base0.lit_id_litigio "Número de Proceso",
          base0.lit_nro_proceso "Número de Radicación"
     FROM m4global.m4sll_litigios base0
    WHERE base0.id_organization = '0050' AND base0.tst_id_tp_status = 1 
;
  GRANT SELECT ON "M4SLL_VW_CPE_RB" TO "RBLATLEG001";
--------------------------------------------------------
--  DDL for View M4SLL_VW_CUADRANTE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_CUADRANTE" ("STD_ID_HR", "CLIENTE", "OBJETIVO", "HORA_ENTRADA", "HORA_SALIDA", "TURNO") AS 
  select a.STD_ID_HR ,  b.CCO_NM_CLIENTE  Cliente, c.CCO_NM_OBJETIVO  Objetivo, a.cco_hh_entrada Hora_Entrada, a.cco_hh_salida Hora_Salida ,a.CCO_TURNO Turno  from m4cco_gt_horas a 
left join m4cco_x_clientes  b on a.CSP_ID_TERCERO = b.CCO_ID_CLIENTE
left join m4cco_x_objetivo c on a.CSP_ID_SUBTERCERO = c.CCO_ID_OBJETIVO and b.CCO_ID_CLIENTE = c.CCO_ID_CLIENTE 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_PER_CCB
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_PER_CCB" ("TIPO", "ID", "NOMBRE_APELLIDO", "DNI", "EMPRESA", "TPI_ID_TP_IDENTIFICACION") AS 
  SELECT 'PI' tipo, p.std_id_person ID,
          p.std_n_first_name || ' ' || p.std_n_fam_name_1 nombre_apellido,
          p.std_ssn dni, e.std_id_leg_ent empresa,
          '' tpi_id_tp_identificacion
     FROM std_person p INNER JOIN m4sco_h_hr_legent e
            ON p.std_id_person like 'CO%'
        AND p.std_id_person = e.std_id_hr
        AND e.std_or_hr_period =
               (SELECT   MAX (std_or_hr_period)
                    FROM m4sco_h_hr_legent r
                   WHERE r.std_id_hr = e.std_id_hr
                     AND r.id_organization = e.id_organization
                     AND r.dt_start =
                            (SELECT   MAX (l.dt_start)
                                 FROM m4sco_h_hr_legent l
                                WHERE l.id_organization = r.id_organization
                                  AND l.std_id_hr = r.std_id_hr
                             GROUP BY l.std_id_hr)
                GROUP BY r.std_id_hr)
        AND e.dt_start =
               (SELECT MAX (dt_start)
                  FROM m4sco_h_hr_legent h
                 WHERE h.std_id_hr = e.std_id_hr
                   AND h.id_organization = e.id_organization)
   UNION
   SELECT 'PE' tipo, pex_nro_documento person,
          pex_nombre || ' ' || pex_apellido nombre_apellido,
          pex_id_persona_ext dni, '' empresa,
          tpi_id_tp_identificacion tpi_id_tp_identificacion
     FROM m4sll_persona_ext
    WHERE id_organization = '0150'   
      AND PEX_DT_END >= sysdate                     -- Personas Externas
   UNION
   SELECT 'ME' tipo, ent_nro_identificacion person, ent_nm_entidad nombre,
                                 -- Entidades Externas o Grupos Externos;;;;;;
          ent_nro_identificacion dni, '' empresa,
          tpi_id_tp_identificacion tpi_id_tp_identificacion
     FROM m4sll_entidades
    WHERE id_organization = '0150'    
      AND ENT_DT_END >= sysdate 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_PER_CL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_PER_CL" ("TIPO", "ID", "NOMBRE_APELLIDO", "DNI", "EMPRESA", "TPI_ID_TP_IDENTIFICACION") AS 
  SELECT 'PI' tipo, p.std_id_person ID,
          p.std_n_first_name || ' ' || p.std_n_fam_name_1 nombre_apellido,
          p.std_ssn dni, e.std_id_leg_ent empresa,
          '' tpi_id_tp_identificacion
     FROM std_person p INNER JOIN m4sco_h_hr_legent e
            ON p.std_id_person like 'CL%'
        AND p.std_id_person = e.std_id_hr
        AND e.std_or_hr_period =
               (SELECT   MAX (std_or_hr_period)
                    FROM m4sco_h_hr_legent r
                   WHERE r.std_id_hr = e.std_id_hr
                     AND r.id_organization = e.id_organization
                     AND r.dt_start =
                            (SELECT   MAX (l.dt_start)
                                 FROM m4sco_h_hr_legent l
                                WHERE l.id_organization = r.id_organization
                                  AND l.std_id_hr = r.std_id_hr
                             GROUP BY l.std_id_hr)
                GROUP BY r.std_id_hr)
        AND e.dt_start =
               (SELECT MAX (dt_start)
                  FROM m4sco_h_hr_legent h
                 WHERE h.std_id_hr = e.std_id_hr
                   AND h.id_organization = e.id_organization)
                   
   UNION SELECT 'PE' tipo, pex_nro_documento person,
          pex_nombre || ' ' || pex_apellido nombre_apellido,
          pex_id_persona_ext dni, '' empresa,
          tpi_id_tp_identificacion tpi_id_tp_identificacion
     FROM m4sll_persona_ext WHERE id_organization = '0110' 
    --AND PEX_DT_END >= sysdate   

   UNION SELECT 'ENT' tipo, ent_nro_identificacion person, ent_nm_entidad nombre,                            
      ent_nro_identificacion dni, '' empresa,
      tpi_id_tp_identificacion tpi_id_tp_identificacion
     FROM m4sll_entidades WHERE id_organization = '0110'    
    --AND ENT_DT_END >= sysdate
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_PER_CPE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_PER_CPE" ("TIPO", "ID", "NOMBRE_APELLIDO", "DNI", "EMPRESA", "TPI_ID_TP_IDENTIFICACION") AS 
  SELECT 'PI' tipo, p.std_id_person ID,
          p.std_n_first_name || ' ' || p.std_n_fam_name_1 nombre_apellido,
          p.std_ssn dni, e.std_id_leg_ent empresa,
          '' tpi_id_tp_identificacion
     FROM std_person p INNER JOIN m4sco_h_hr_legent e
            ON p.std_id_person like 'PE%'
        AND p.std_id_person = e.std_id_hr
        AND e.std_or_hr_period =
               (SELECT   MAX (std_or_hr_period)
                    FROM m4sco_h_hr_legent r
                   WHERE r.std_id_hr = e.std_id_hr
                     AND r.id_organization = e.id_organization
                     AND r.dt_start =
                            (SELECT   MAX (l.dt_start)
                                 FROM m4sco_h_hr_legent l
                                WHERE l.id_organization = r.id_organization
                                  AND l.std_id_hr = r.std_id_hr
                             GROUP BY l.std_id_hr)
                GROUP BY r.std_id_hr)
        AND e.dt_start =
               (SELECT MAX (dt_start)
                  FROM m4sco_h_hr_legent h
                 WHERE h.std_id_hr = e.std_id_hr
                   AND h.id_organization = e.id_organization)
   UNION
   SELECT 'PE' tipo, pex_nro_documento person,
          pex_nombre || ' ' || pex_apellido nombre_apellido,
          pex_id_persona_ext dni, '' empresa,
          tpi_id_tp_identificacion tpi_id_tp_identificacion
     FROM m4sll_persona_ext
    WHERE id_organization = '0050'   
      AND PEX_DT_END >= sysdate                     -- Personas Externas
   UNION
   SELECT 'ME' tipo, ent_nro_identificacion person, ent_nm_entidad nombre,
                                 -- Entidades Externas o Grupos Externos;;;;;;
          ent_nro_identificacion dni, '' empresa,
          tpi_id_tp_identificacion tpi_id_tp_identificacion
     FROM m4sll_entidades
    WHERE id_organization = '0050'    
      AND ENT_DT_END >= sysdate
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_PER_ENT
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_PER_ENT" ("TIPO", "NRO_ID", "NOMBRE", "ID_TP", "ID", "FECHA_INI", "FECHA_FIN", "ID_NEGOCIO", "ID_EMPRESA", "TIPO_EMPLEADO") AS 
  SELECT 'ENT' tipo, p.ENT_NRO_IDENTIFICACION NRO_ID, p.ENT_NM_ENTIDAD NOMBRE , p.TPE_ID_TP_ENTIDAD ID_TP, P.ENT_ID_ENTIDAD ID,p.ENT_DT_START,p.ENT_DT_END,p.ENT_ID_NEGOCIO , '' ID_EMPRE,p.ENT_TP_EMPLEADO
     FROM M4SLL_ENTIDADES p 
        where p.id_organization = '0001'           
   UNION      
   SELECT 'PF' tipo, e.pex_nro_documento NRO_ID ,e.pex_nombre || ' ' || e.pex_apellido NOMBRE, e.TPI_ID_TP_IDENTIFICACION ID_TP, e.pex_id_persona_ext ID, e.PEX_DT_START,e.PEX_DT_END,e.PEX_NEGOCIO,e.PEX_EMPRESA,e.PEX_TP_EMPLEADO  
     FROM m4sll_persona_ext e
    WHERE id_organization = '0001' WITH READ ONLY 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_PER_ES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_PER_ES" ("TIPO", "ID", "NOMBRE_APELLIDO", "DNI") AS 
  SELECT 'I' tipo, p.std_id_person ID,
          p.std_n_fam_name_1 || ' ' || p.std_n_first_name nombre_apellido,
          p.std_ssn dni
     FROM std_person p WHERE p.std_id_person like 'ES%'
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_RAMJUD_CCB
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_RAMJUD_CCB" ("CIUDAD", "LIT_ID_LITIGIO", "LIT_ID_LEGADO", "NRO_RADICACION", "REFERENCIA", "CLASE", "JUZGADO", "ABOGADO", "FECHA_ACTUALIZACION", "FECHA_ACTUACION", "DESC_ACTUACION") AS 
  SELECT CASE base3.std_n_geo_placesp
             WHEN 'BOGOTA'
                THEN 'BOGOTA, D.C.'
             WHEN 'C/CUTA'
                THEN 'CUCUTA'
             ELSE base3.std_n_geo_placesp
          END ciudad,
          base1.lit_id_litigio lit_id_litigio,
          base0.lit_id_legado lit_id_legado,
          base1.fas_nro_radicacion nro_radicacion,   
          replace((base1.rjc_demandante || ' CONTRA '
          || base1.rjc_demandado), chr(10),'') as referencia,
          base1.rjc_clase clase, base1.rjc_despacho juzgado,
          base1.rjc_ponente abogado,
          base2.rjd_dt_actualizacion fecha_actualizacion,
          base2.RJD_DT_INICIO_TERMINO fecha_actuacion,
          base2.rjd_actuacion || ' ' || base2.rjd_anotacion desc_actuacion
     FROM m4global.m4sll_litigios base0 INNER JOIN m4global.m4sll_ccb_ramajudc base1
          ON base1.id_organization = base0.id_organization
        AND base1.lit_id_litigio = base0.lit_id_litigio
          LEFT JOIN m4global.m4sll_ccb_ramajudd base2
          ON base2.id_organization = base1.id_organization
        AND base2.fas_nro_radicacion = base1.fas_nro_radicacion
          LEFT JOIN m4global.std_geo_place base3
          ON base0.id_organization = base3.id_organization
        AND base3.std_id_country = '8'
        AND base3.std_id_geo_div = '8'
        AND base0.std_id_geo_place = base3.std_id_geo_place
        AND base0.std_id_sub_geo_div = base3.std_id_sub_geo_div
    WHERE base3.std_n_geo_placesp IS NOT NULL
      AND base0.id_organization = '0150'
      AND base0.tst_id_tp_status = 1 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_RAMJUD_CCB_VTO
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_RAMJUD_CCB_VTO" ("DIAS", "JUZGADO", "RJD_DT_FIN_TERMINO", "LIT_ID_LITIGIO", "LIT_ID_LEGADO", "RJC_CLASE", "ETAPA", "REFERENCIA", "OBSERVACION") AS 
  SELECT   (  TO_DATE (base2.rjd_dt_fin_termino, 'DD/MM/YYYY')
             - TO_DATE (SYSDATE, 'DD/MM/YYYY')
            ) AS dias,
               base1.rjc_despacho
            || ' '
            || CASE base3.std_n_geo_placesp
                  WHEN 'BOGOTA'
                     THEN 'BOGOTA, D.C.'
                  WHEN 'C/CUTA'
                     THEN 'CUCUTA'
                  ELSE base3.std_n_geo_placesp
               END juzgado,
            base2.rjd_dt_fin_termino AS vencimiento,
            base0.lit_id_litigio litigio, base0.lit_id_legado proceso,
            base1.rjc_clase clase,
            (SELECT tf.tfa_nm_tp_fase
               FROM m4global.m4sll_fases f
                    INNER JOIN
                    (SELECT   lit_id_litigio,
                              MAX (tfa_id_tp_fase) AS fasemax
                         FROM m4global.m4sll_fases
                        WHERE id_organization = '0150'
                     GROUP BY lit_id_litigio) maxf
                    ON maxf.fasemax = f.tfa_id_tp_fase
                  AND maxf.lit_id_litigio = f.lit_id_litigio
                    INNER JOIN m4global.m4sll_tp_fases tf
                    ON (    tf.id_organization = '0150'
                        AND tf.id_organization = f.id_organization
                        AND tf.tfa_id_tp_fase = f.tfa_id_tp_fase
                       )
              WHERE f.id_organization = '0150'
                AND f.lit_id_litigio = base0.lit_id_litigio) AS etapa,
               base1.rjc_demandante
            || ' CONTRA '
            || base1.rjc_demandado AS referencia,
            base2.rjd_anotacion AS observacion
       FROM m4global.m4sll_litigios base0 INNER JOIN m4global.m4sll_ccb_ramajudc base1
            ON base1.id_organization = base0.id_organization
          AND base1.lit_id_litigio = base0.lit_id_litigio
            LEFT JOIN m4global.m4sll_ccb_ramajudd base2
            ON base2.id_organization = base1.id_organization
          AND base2.fas_nro_radicacion = base1.fas_nro_radicacion
            LEFT JOIN m4global.std_geo_place base3
            ON base0.id_organization = base3.id_organization
          AND base3.std_id_country = '8'
          AND base3.std_id_geo_div = '8'
          AND base0.std_id_geo_place = base3.std_id_geo_place
          AND base0.std_id_sub_geo_div = base3.std_id_sub_geo_div
      WHERE base0.id_organization = '0150'
        AND base0.tst_id_tp_status = 1
        AND base2.rjd_anotacion IS NOT NULL
        AND base2.rjd_dt_fin_termino IS NOT NULL
   ORDER BY base0.lit_id_litigio, base2.rjd_dt_fin_termino 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_REPORTE_R
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_REPORTE_R" ("ID_ORGANIZATION", "CIUDAD", "LIT_ID_LITIGIO", "LIT_ID_LEGADO", "NRO_RADICACION", "CLASE", "JUZGADO", "FECHA_ACTUACION", "DESC_ACTUACION", "DEMANDANTE", "DEMANDADO") AS 
  SELECT  base0.id_organization, base3.std_n_geo_placesp ciudad, base1.lit_id_litigio lit_id_litigio,
         base0.lit_id_legado lit_id_legado,
         base1.fas_nro_radicacion nro_radicacion,
         base1.rjc_clase clase, base1.rjc_despacho juzgado,
         base2.rjd_dt_actualizacion fecha_actuacion,
         base2.rjd_actuacion || ' ' || base2.rjd_anotacion desc_actuacion,
         base1.rjc_demandante  demandante,
         base1.rjc_demandado demandado
    FROM m4global.m4sll_litigios base0 INNER JOIN m4global.M4SLL_CCB_RJCC_BKP base1
         ON base1.id_organization = base0.id_organization
       AND base1.lit_id_litigio = base0.lit_id_litigio
         LEFT JOIN m4global.M4SLL_CCB_RJCD_BKP base2
         ON base2.id_organization = base1.id_organization
       AND base2.fas_nro_radicacion = base1.fas_nro_radicacion
         LEFT JOIN m4global.std_geo_place base3
         ON base0.id_organization = base3.id_organization
       AND base3.std_id_country = '8'
       AND base3.std_id_geo_div = '8'
       AND base0.std_id_geo_place = base3.std_id_geo_place
       AND base0.std_id_sub_geo_div = base3.std_id_sub_geo_div
   WHERE base0.id_organization = '0150'
     AND base0.tst_id_tp_status = 1
     AND base2.rjd_dt_actualizacion >= (TO_DATE (SYSDATE, 'DD/MM/YY') - 1)
ORDER BY 2, 9 WITH READ ONLY 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_SEGUIMIEN
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_SEGUIMIEN" ("DT_START", "DT_END", "NSTATE", "USUARIO", "DESCRIPCION", "BPO", "NOMBRE_USUARIO", "ID_BPC") AS 
  SELECT   a.dt_instantiation, a.dt_cancellation, a.n_stateger,
            d.id_app_user, c.desc_comment, a.id_bpo, d.n_app_user,a.id_bpc
       FROM m4rwf_inst_task a, m4rwf_workitem_c1 c, m4rsc_appuser d
      WHERE c.id_bpc(+) = a.id_bpc
        AND c.id_bpo(+) = a.id_bpo
        AND c.id_inst_task(+) = a.id_inst_task
        AND (   c.id_comment =
                   (SELECT MAX (b.id_comment)
                      FROM m4rwf_workitem_c1 b
                     WHERE a.id_bpc = b.id_bpc
                       AND a.id_bpo = b.id_bpo
                       AND a.id_inst_task = b.id_inst_task)
             OR c.id_comment IS NULL
            )
        AND d.id_app_user = a.id_secuser
   ORDER BY a.dt_instantiation ASC 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_TIPOS_CCB
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_TIPOS_CCB" ("TIPO", "OBJ_JSON") AS 
  SELECT 'M4SLL_TP_AUTOR_REU' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TAR_ID_TP_AUTOR_REU,TAR_NM_TP_AUTOR_REU FROM M4GLOBAL.M4SLL_TP_AUTOR_REU TPF WHERE ID_ORGANIZATION = ''0150'' AND TAR_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_COMPROMIS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TCO_ID_TP_COMPROMISO,TPL_ID_TP_LITIGIO,TCO_NM_TP_COMPROMISO   FROM M4GLOBAL.M4SLL_TP_COMPROMIS TPF WHERE ID_ORGANIZATION = ''0150'' AND TCO_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_DOC_LITIG' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TDL_ID_TP_DOC_LITIGIO, TDL_NM_TP_DOC_LITIGIO  FROM M4GLOBAL.M4SLL_TP_DOC_LITIG TPF WHERE ID_ORGANIZATION = ''0150'' AND TDL_DT_END >= Sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ENTIDADES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TPE_ID_TP_ENTIDAD, TPE_NM_TP_ENTIDAD  FROM M4GLOBAL.M4SLL_TP_ENTIDADES TPF WHERE ID_ORGANIZATION = ''0150'' AND TPE_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_FASES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TFA_ID_TP_FASE,TFA_NM_TP_FASE,TPL_ID_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_FASES TPF WHERE ID_ORGANIZATION = ''0150'' AND TFA_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_IDENTIFIC' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPI_ID_TP_IDENTIFICACION,TPI_NM_TP_IDENTIFICACION FROM M4GLOBAL.M4SLL_TP_IDENTIFIC TPF WHERE ID_ORGANIZATION = ''0150'' AND TPI_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_LITIGIOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPL_ID_TP_LITIGIO, TPL_NM_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0150'' AND TPL_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_MOTIVO' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TMO_ID_TP_MOTIVO, TMO_NM_TP_MOTIVO, TPL_ID_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_MOTIVO TPF WHERE ID_ORGANIZATION = ''0150'' AND TMO_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PAGOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPA_ID_PAGO, TPA_NM_PAGO, TPA_NUMERO_CUENTA FROM M4GLOBAL.M4SLL_TP_PAGOS TPF WHERE ID_ORGANIZATION = ''0150'' AND TPA_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PEDIDO' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPE_ID_PEDIDO, TPE_NM_PEDIDO FROM M4GLOBAL.M4SLL_TP_PEDIDO TPF WHERE ID_ORGANIZATION = ''0150'' AND TPE_DT_END >= Sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_RECURREN' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TRE_ID_RECURRENCIA, TRE_NM_RECURRENCIA FROM M4GLOBAL.M4SLL_TP_RECURREN TPF WHERE ID_ORGANIZATION = ''0150'' AND TRE_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ROLES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TPR_ID_TP_ROL, TPR_NM_TP_ROL FROM M4GLOBAL.M4SLL_TP_ROLES TPF WHERE ID_ORGANIZATION = ''0150'' AND TPR_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STA_DET' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TSD_ID_TP_STA_DET, TSD_NM_TP_STATUS_DET , TPL_ID_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_STA_DET TPF WHERE ID_ORGANIZATION = ''0150'' AND TSD_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STATUS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TST_ID_TP_STATUS, TPL_ID_TP_LITIGIO, TST_NM_TP_STATUS FROM M4GLOBAL.M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0150'' AND TST_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TRIBUNALES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TRB.TRI_ID_TRIBUNAL, TRB.TRI_NM_TRIBUNAL FROM M4GLOBAL.M4SLL_TRIBUNALES TRB WHERE ID_ORGANIZATION = ''0150'' AND TRI_DT_END >= sysdate ',
              ''
             ) AS obj_json
     FROM DUAL
   /*UNION ALL
   SELECT 'M4SLL_FASES_RESULT' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT FAR_ID_FASE_RESULTADO, TFA_ID_TP_FASE, FAR_NM_FASE_RESULTADO FROM M4GLOBAL.M4SLL_FASES_RESULT TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL*/
   UNION ALL
   SELECT 'STD_LEG_ENT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select std_id_leg_ent, std_n_leg_ent from M4GLOBAL.STD_LEG_ENT WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select TPF.MAB_SECUENCIA, TPF.MAB_NOMBRE, TPF.MAB_APELLIDO, TPF.STD_ID_PERSON from M4GLOBAL.M4SLL_MT_ABOGADOS TPF WHERE ID_ORGANIZATION = ''0150'' AND MAB_DT_END >= Sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOSINT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select TPFI.MAB_SECUENCIA, TPFI.MAB_NOMBRE, TPFI.MAB_APELLIDO from M4GLOBAL.M4SLL_MT_ABOGADOS TPFI WHERE ID_ORGANIZATION = ''0150'' AND  MAB_CHK_INT = ''I'' AND MAB_DT_END >= Sysdate ORDER BY TPFI.MAB_NOMBRE ASC',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOSEXT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select TPFE.MAB_SECUENCIA, TPFE.MAB_NOMBRE, TPFE.MAB_APELLIDO from M4GLOBAL.M4SLL_MT_ABOGADOS TPFE WHERE ID_ORGANIZATION = ''0150''  AND  MAB_CHK_INT = ''E'' AND MAB_DT_END >= Sysdate ORDER BY TPFE.MAB_NOMBRE ASC',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_NEGOCIOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select TPF.* from M4GLOBAL.M4SLL_NEGOCIOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'STD_SUB_GEO_DIV' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select std_id_sub_geo_div, std_n_sub_geo_esp from M4GLOBAL.STD_SUB_GEO_DIV WHERE ID_ORGANIZATION = ''0150''  and STD_ID_COUNTRY = ''8'' and STD_ID_GEO_DIV = ''8''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'ULTIMA_PASTA' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MAX(TO_NUMBER(LIT_ID_LITIGIO)) as ULTIMA_PASTA  FROM M4GLOBAL.M4SLL_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT EJU_ID_EST_JURIDICO, EJU_NM_EST_JURIDICO FROM M4GLOBAL.M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0150'' AND EJU_NM_EST_JURIDICO is not null AND EJU_DT_END >= Sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_RIESGOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MRI_ID_RIESGO, MRI_NM_RIESGO  FROM M4GLOBAL.M4SLL_MTO_RIESGOS MTR WHERE ID_ORGANIZATION = ''0150'' AND MRI_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_COD_ALT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MCA_ID_CODIGO_ALTERNO, MCA_NM_CODIGO_ALTERNO  FROM M4GLOBAL.M4SLL_MTO_COD_ALT MCA WHERE ID_ORGANIZATION = ''0150'' AND MCA_DT_END >= Sysdate',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_DET_PROV' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MDP_ID_DET_PROVISION, MDP_NM_DET_PROVISION, MDP_CUENTA_DEBE, MDP_CUENTA_HABER  FROM M4GLOBAL.M4SLL_MTO_DET_PROV MDP WHERE ID_ORGANIZATION = ''0150'' AND MDP_DT_END >= sysdate',
              ''
             ) AS obj_json
     FROM DUAL 
   UNION ALL
   SELECT 'M4SLL_MTO_EST_TARE' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MET_ID_EST_TAREA, MET_NM_EST_TAREA FROM M4GLOBAL.M4SLL_MTO_EST_TARE MET WHERE ID_ORGANIZATION = ''0150''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_TAR_CIE' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MTC_ID_TAREA, MTC_NM_TAREA FROM M4GLOBAL.M4SLL_MTO_TAR_CIE MTC WHERE ID_ORGANIZATION = ''0150''',
              ''
             ) AS obj_json
     FROM DUAL    
   UNION ALL
   SELECT 'M4SLL_MTO_REGION' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT REG_ID_REGION, STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, STD_ID_GEO_PLACE, NEG_ID_NEGOCIO,STD_ID_LEG_ENT FROM M4GLOBAL.M4SLL_MTO_REGION MTR WHERE ID_ORGANIZATION = ''0150''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   /*SELECT 'TODOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT VW_TIPOS.*FROM M4GLOBAL.M4SLL_VW_TIPOS_CCB VW_TIPOS  WHERE TIPO <> ''TODOS'' AND TIPO <> ''M4SLL_TRIBUNALES''',
              ''
             ) AS obj_json
     FROM DUAL*/
     SELECT 'TODOS' AS tipo,
        M4GLOBAL.m4pkg_sll_expediente_ccb.OBTENER_CATALOGO('ARX0000455','{"TODOS":""}') AS obj_json 
     FROM dual 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_TIPOS_CCB_2
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_TIPOS_CCB_2" ("TIPO", "OBJ_JSON") AS 
  SELECT 'M4SLL_TP_AUTOR_REU' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TAR_ID_TP_AUTOR_REU,TAR_NM_TP_AUTOR_REU FROM M4GLOBAL.M4SLL_TP_AUTOR_REU TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_COMPROMIS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT  TCO_ID_TP_COMPROMISO,TPL_ID_TP_LITIGIO,TCO_NM_TP_COMPROMISO   FROM M4GLOBAL.M4SLL_TP_COMPROMIS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_DOC_LITIG' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT  TDL_ID_TP_DOC_LITIGIO, TDL_NM_TP_DOC_LITIGIO  FROM M4GLOBAL.M4SLL_TP_DOC_LITIG TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ENTIDADES' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT  TPE_ID_TP_ENTIDAD, TPE_NM_TP_ENTIDAD  FROM M4GLOBAL.M4SLL_TP_ENTIDADES TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_FASES' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TFA_ID_TP_FASE,TFA_NM_TP_FASE,TPL_ID_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_FASES TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_IDENTIFIC' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TPI_ID_TP_IDENTIFICACION,TPI_NM_TP_IDENTIFICACION FROM M4GLOBAL.M4SLL_TP_IDENTIFIC TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_LITIGIOS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TPL_ID_TP_LITIGIO, TPL_NM_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_MOTIVO' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TMO_ID_TP_MOTIVO, TMO_NM_TP_MOTIVO, TPL_ID_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_MOTIVO TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PAGOS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TPA_ID_PAGO, TPA_NM_PAGO, TPA_NUMERO_CUENTA FROM M4GLOBAL.M4SLL_TP_PAGOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PEDIDO' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TPE_ID_PEDIDO, TPE_NM_PEDIDO FROM M4GLOBAL.M4SLL_TP_PEDIDO TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_RECURREN' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TRE_ID_RECURRENCIA, TRE_NM_RECURRENCIA FROM M4GLOBAL.M4SLL_TP_RECURREN TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ROLES' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT  TPR_ID_TP_ROL, TPR_NM_TP_ROL FROM M4GLOBAL.M4SLL_TP_ROLES TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STA_DET' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TSD_ID_TP_STA_DET, TSD_NM_TP_STATUS_DET , TPL_ID_TP_LITIGIO FROM M4GLOBAL.M4SLL_TP_STA_DET TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STATUS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TST_ID_TP_STATUS, TPL_ID_TP_LITIGIO, TST_NM_TP_STATUS FROM M4GLOBAL.M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL    
   UNION ALL
   SELECT 'M4SLL_TRIBUNALES' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT TRB.TRI_ID_TRIBUNAL, TRIM(TRB.TRI_NM_TRIBUNAL) FROM M4GLOBAL.M4SLL_TRIBUNALES TRB WHERE ID_ORGANIZATION = ''0150''  ',
              ''
             ) AS obj_json
     FROM DUAL

   UNION ALL
   SELECT 'STD_LEG_ENT' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('select std_id_leg_ent, std_n_leg_ent from M4GLOBAL.STD_LEG_ENT WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL 
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('select TPF.MAB_SECUENCIA, TPF.MAB_NOMBRE, TPF.MAB_APELLIDO from M4GLOBAL.M4SLL_MT_ABOGADOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL   
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOSINT' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('select TPFI.MAB_SECUENCIA, TPFI.MAB_NOMBRE, TPFI.MAB_APELLIDO from M4GLOBAL.M4SLL_MT_ABOGADOS TPFI WHERE ID_ORGANIZATION = ''0150'' AND  MAB_CHK_INT = ''I''',
              ''
             ) AS obj_json
     FROM DUAL  
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOSEXT' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('select TPFE.MAB_SECUENCIA, TPFE.MAB_NOMBRE, TPFE.MAB_APELLIDO from M4GLOBAL.M4SLL_MT_ABOGADOS TPFE WHERE ID_ORGANIZATION = ''0150''  AND  MAB_CHK_INT = ''E''',
              ''
             ) AS obj_json
     FROM DUAL  
   UNION ALL
   SELECT 'M4SLL_NEGOCIOS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('select TPF.* from M4GLOBAL.M4SLL_NEGOCIOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL                
   UNION ALL
   SELECT 'STD_SUB_GEO_DIV' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('select std_id_sub_geo_div, std_n_sub_geo_esp from M4GLOBAL.STD_SUB_GEO_DIV WHERE ID_ORGANIZATION = ''0150''  and STD_ID_COUNTRY = ''8'' and STD_ID_GEO_DIV = ''8''',
              ''
             ) AS obj_json
     FROM DUAL 
   UNION ALL
   SELECT 'ULTIMA_PASTA' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT MAX(TO_NUMBER(LIT_ID_LITIGIO)) as ULTIMA_PASTA  FROM M4GLOBAL.M4SLL_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL          
   UNION ALL         
   SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT EJU_ID_EST_JURIDICO, EJU_NM_EST_JURIDICO FROM M4GLOBAL.M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_RIESGOS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT MRI_ID_RIESGO, MRI_NM_RIESGO  FROM M4GLOBAL.M4SLL_MTO_RIESGOS MTR WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL    
   UNION ALL
   SELECT 'M4SLL_MTO_COD_ALT' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT MCA_ID_CODIGO_ALTERNO, MCA_NM_CODIGO_ALTERNO  FROM M4GLOBAL.M4SLL_MTO_COD_ALT MCA WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL   
   UNION ALL
   SELECT 'M4SLL_MTO_DET_PROV' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT MDP_ID_DET_PROVISION, MDP_NM_DET_PROVISION, MDP_CUENTA_DEBE, MDP_CUENTA_HABER  FROM M4GLOBAL.M4SLL_MTO_DET_PROV MDP WHERE ID_ORGANIZATION = ''0150'' ',
              ''
             ) AS obj_json
     FROM DUAL     
   
   UNION ALL
   SELECT 'TODOS' AS tipo,
          M4GLOBAL.m4pkg_util_pkg.sql2json
             ('SELECT VW_TIPOS.*FROM M4GLOBAL.M4SLL_VW_TIPOS_CCB_2 VW_TIPOS  WHERE TIPO <> ''TODOS'' ',
              ''
             ) AS obj_json
   FROM DUAL
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_TIPOS_CL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_TIPOS_CL" ("TIPO", "OBJ_JSON") AS 
  SELECT 'M4SLL_TP_AUTOR_REU' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_AUTOR_REU TPF WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_COMPROMIS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT  TCO_ID_TP_COMPROMISO, TPL_ID_TP_LITIGIO, TCO_NM_TP_COMPROMISO, TCO_DT_VALIDEZ,TCO_DT_END  FROM M4GLOBAL.M4SLL_TP_COMPROMIS TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TCO_NM_TP_COMPROMISO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_DOC_LITIG' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TDL_ID_TP_DOC_LITIGIO,TDL_NM_TP_DOC_LITIGIO, TPL_ID_TP_LITIGIO, TDL_DT_END FROM M4GLOBAL.M4SLL_TP_DOC_LITIG TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TDL_NM_TP_DOC_LITIGIO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_ENTIDADES' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_ENTIDADES TPF WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_FASES' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT  TFA_ID_TP_FASE,TFA_NM_TP_FASE, TPL_ID_TP_LITIGIO, TFA_DT_END  FROM M4GLOBAL.M4SLL_TP_FASES TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TFA_NM_TP_FASE ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_IDENTIFIC' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_IDENTIFIC TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TPI_NM_TP_IDENTIFICACION ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_LITIGIOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TPL_NM_TP_LITIGIO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_MOTIVO' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TMO_ID_TP_MOTIVO, TMO_NM_TP_MOTIVO, TPL_ID_TP_LITIGIO, TMO_DT_END FROM M4GLOBAL.M4SLL_TP_MOTIVO TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TMO_NM_TP_MOTIVO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_PAGOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPA_ID_PAGO, TPA_NM_PAGO,  TPA_NUMERO_CUENTA, TPL_ID_TP_LITIGIO,TPA_VENDOR_ID,TPA_VENDOR_SITE_ID,VENDOR_NAME,TPA_NOMINA_S_N,TPA_CONCEPTO,TPA_DT_END FROM M4GLOBAL.M4SLL_TP_PAGOS TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TPA_NM_PAGO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_PEDIDO' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPE_ID_PEDIDO,TPE_NM_PEDIDO,TPL_ID_TP_LITIGIO,TPE_PROVISIONA_S_N,TPE_DT_START,TPE_DT_END  FROM M4GLOBAL.M4SLL_TP_PEDIDO TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TPE_NM_PEDIDO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_STATUS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPF.*FROM M4GLOBAL.M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TST_NM_TP_STATUS ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_STATUS_LA' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT TPF.*FROM M4GLOBAL.M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0110'' AND TST_ID_TP_STATUS IN (''1'',''2'') ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TRIBUNALES' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT  TRI_ID_TRIBUNAL, TRI_NM_TRIBUNAL, TPL_ID_TP_LITIGIO, STD_ID_SUB_GEO_DIV,STD_ID_GEO_PLACE,TRI_DT_END  FROM M4GLOBAL.M4SLL_TRIBUNALES TPF WHERE ID_ORGANIZATION = ''0110'' ORDER BY TRI_NM_TRIBUNAL ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'ULTIMA_PASTA' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT NVL(MAX(TO_NUMBER(LIT_ID_LITIGIO)),0) as ULTIMA_PASTA  FROM M4GLOBAL.M4SLL_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'STD_LEG_ENT' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('select std_id_leg_ent, std_n_leg_ent from M4GLOBAL.STD_LEG_ENT WHERE ID_ORGANIZATION = ''0110'' ORDER BY STD_N_LEG_ENT ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT eju_id_est_juridico, eju_nm_est_juridico FROM M4GLOBAL.M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0110'' ORDER BY EJU_NM_EST_JURIDICO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_FASES_ESTADO' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_FASES_ESTADO WHERE ID_ORGANIZATION = ''0110'' ORDER BY FAS_NM_FASE_ESTADO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MTO_PEDIDO_D' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT MPD_ID_PEDIDO_DETALLE, MPD_NM_PEDIDO_DETALLE,TPL_ID_TP_LITIGIO,MPD_PAGO_NOMINA_DET_S_N FROM M4GLOBAL.M4SLL_MTO_PEDIDO_D WHERE ID_ORGANIZATION = ''0110'' ORDER BY MPD_NM_PEDIDO_DETALLE ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_NEGOCIOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT NEG_ID_NEGOCIO,NEG_NM_NEGOCIO,LIT_CENTRO_COSTO, DT_LAST_UPDATE FROM M4GLOBAL.M4SLL_NEGOCIOS WHERE ID_ORGANIZATION = ''0110'' ORDER BY NEG_NM_NEGOCIO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_ESP_DELEGACI' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT EDE_ID_DELEGACION, ECI_ID_CIUDAD, EDE_NM_DELEGACION, EDE_ZONA_RRLL, DT_LAST_UPDATE  FROM M4GLOBAL.M4SLL_ESP_DELEGACI WHERE ID_ORGANIZATION = ''0110'' ORDER BY EDE_NM_DELEGACION ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_ESP_CIUDADES' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT ECI_ID_CIUDAD,ECI_NM_CIUDAD, DT_LAST_UPDATE FROM M4GLOBAL.M4SLL_ESP_CIUDADES WHERE ID_ORGANIZATION = ''0110'' ORDER BY ECI_NM_CIUDAD ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_DOC_ORIGENES' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_DOC_ORIGENES WHERE ID_ORGANIZATION = ''0110'' ORDER BY DOO_NM_DOC_ORIGEN ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_COMP_ESTADOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_COMP_ESTADOS WHERE ID_ORGANIZATION = ''0110'' ORDER BY COE_NM_COMP_ESTADO ASC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_STATUS_PAGOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_STATUS_PAGOS WHERE ID_ORGANIZATION = ''0110'' ORDER BY STP_NM_STATUS_PAGO ASC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_SALIDA_PA' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_TP_SALIDA_PA WHERE ID_ORGANIZATION = ''0110'' ORDER BY TSP_NM_SALIDA_PAGO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MTO_TP_EMPLE' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_MTO_TP_EMPLE WHERE ID_ORGANIZATION = ''0110'' ORDER BY MTE_NM_TP_EMPLEADO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_TP_RECLAMOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_TP_RECLAMOS WHERE ID_ORGANIZATION = ''0110'' ORDER BY TRC_NM_TP_RECLAMO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_FASES_RESULT' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT FAR_ID_FASE_RESULTADO, TFA_ID_TP_FASE,FAR_NM_FASE_RESULTADO,TPL_ID_TP_LITIGIO, FAR_DT_END 
        FROM M4GLOBAL.M4SLL_FASES_RESULT WHERE ID_ORGANIZATION = ''0110''  ORDER BY FAR_NM_FASE_RESULTADO ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_ENTIDADES' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        (' SELECT * FROM M4GLOBAL.M4SLL_ENTIDADES e  WHERE e.ID_ORGANIZATION=''0110'' ORDER BY TO_NUMBER(e.ENT_ID_ENTIDAD) DESC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_PERSONA_EXT' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_PERSONA_EXT WHERE ID_ORGANIZATION=''0110'' ORDER BY TO_NUMBER(PEX_ID_PERSONA_EXT) DESC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MT_ABOGADOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_MT_ABOGADOS WHERE ID_ORGANIZATION=''0110'' ORDER BY MAB_SECUENCIA desc ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MTO_CONCEPTO' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT MCO_ID_CONCEPTO, MCO_NM_CONCEPTO from M4GLOBAL.m4sll_mto_concepto WHERE ID_ORGANIZATION = ''0110'' ORDER BY MCO_NM_CONCEPTO ASC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MTO_EST_TARE' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT MET_ID_EST_TAREA, MET_NM_EST_TAREA from M4GLOBAL.M4SLL_MTO_EST_TARE WHERE ID_ORGANIZATION = ''0110'' ORDER BY MET_NM_EST_TAREA ASC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MTO_TAR_CIE' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT MTC_ID_TAREA, MTC_NM_TAREA, MTC_NM_PROCEDIMIENTO from M4GLOBAL.M4SLL_MTO_TAR_CIE WHERE ID_ORGANIZATION = ''0110'' ORDER BY MTC_NM_TAREA ASC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MTO_EST_EJE' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT MEE_ID_EST_EJECUCION, MEE_NM_EST_EJECUCION  from M4GLOBAL.M4SLL_MTO_EST_EJE WHERE ID_ORGANIZATION = ''0110'' ORDER BY MEE_NM_EST_EJECUCION ASC',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('select * from M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_EST_JUR_SUB' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('select * from M4SLL_EST_JUR_SUB WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'STD_GEO_DIV' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('select STD_ID_GEO_DIV, STD_N_GEO_DIVESP from STD_GEO_DIV WHERE ID_ORGANIZATION = ''0110'' AND STD_ID_COUNTRY = ''9''  ORDER BY STD_N_GEO_DIVESP ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'STD_SUB_GEO_DIV' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('select STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, STD_N_SUB_GEO_ESP from STD_SUB_GEO_DIV WHERE ID_ORGANIZATION = ''0110'' AND STD_ID_COUNTRY = ''9'' ORDER BY STD_N_SUB_GEO_ESP ASC  ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'STD_GEO_PLACE' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT STD_ID_GEO_DIV, STD_ID_SUB_GEO_DIV, STD_ID_GEO_PLACE, STD_N_GEO_PLACESP FROM STD_GEO_PLACE WHERE ID_ORGANIZATION = ''0110'' AND STD_ID_COUNTRY = ''9''  ORDER BY STD_N_GEO_PLACESP ASC ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_MEDIO_PAGOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_MEDIO_PAGOS WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL

UNION ALL
SELECT 'M4SLL_STATUS_PAGOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT * FROM M4GLOBAL.M4SLL_STATUS_PAGOS WHERE ID_ORGANIZATION = ''0110'' ',
        ''
        ) AS obj_json
FROM DUAL


UNION ALL
SELECT 'TODOS' AS tipo,
    m4global.m4pkg_util_pkg.sql2json
        ('SELECT VW_TIPOS.*FROM M4GLOBAL.M4SLL_VW_TIPOS_CL VW_TIPOS  WHERE TIPO <> ''TODOS'' AND TIPO <> ''M4SLL_PERSONA_EXT'' ',
        ''
        ) AS obj_json
FROM DUAL
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_TIPOS_ES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_TIPOS_ES" ("TIPO", "OBJ_JSON") AS 
  SELECT 'M4SLL_TP_AUTOR_REU' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_AUTOR_REU TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_COMPROMIS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TCO_ID_TP_COMPROMISO, TPL_ID_TP_LITIGIO, TCO_NM_TP_COMPROMISO, TCO_DT_VALIDEZ,TCO_DT_START,TCO_DT_END  FROM M4GLOBAL.M4SLL_TP_COMPROMIS TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TCO_NM_TP_COMPROMISO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_DOC_LITIG' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TDL_ID_TP_DOC_LITIGIO,TDL_NM_TP_DOC_LITIGIO, TPL_ID_TP_LITIGIO,TDL_DT_START ,TDL_DT_END FROM M4GLOBAL.M4SLL_TP_DOC_LITIG TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TDL_NM_TP_DOC_LITIGIO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ENTIDADES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_ENTIDADES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_FASES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TFA_ID_TP_FASE,TFA_NM_TP_FASE, TPL_ID_TP_LITIGIO,TFA_DT_START ,TFA_DT_END  FROM M4GLOBAL.M4SLL_TP_FASES TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TFA_NM_TP_FASE ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_IDENTIFIC' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_IDENTIFIC TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TPI_NM_TP_IDENTIFICACION ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_LITIGIOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPF.* FROM M4GLOBAL.M4SLL_TP_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TPL_NM_TP_LITIGIO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_MOTIVO' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TMO_ID_TP_MOTIVO, TMO_NM_TP_MOTIVO, TPL_ID_TP_LITIGIO,TMO_DT_START, TMO_DT_END FROM M4GLOBAL.M4SLL_TP_MOTIVO TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TMO_NM_TP_MOTIVO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PAGOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPA_ID_PAGO, TPA_NM_PAGO,  TPA_NUMERO_CUENTA, TPL_ID_TP_LITIGIO,TPA_VENDOR_ID,TPA_VENDOR_SITE_ID,VENDOR_NAME,TPA_NOMINA_S_N,TPA_CONCEPTO,TPA_DT_START,TPA_DT_END FROM M4GLOBAL.M4SLL_TP_PAGOS TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TPA_NM_PAGO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PEDIDO' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPE_ID_PEDIDO,TPE_NM_PEDIDO,TPL_ID_TP_LITIGIO,TPE_PROVISIONA_S_N,TPE_DT_START,TPE_DT_START,TPE_DT_END  FROM M4GLOBAL.M4SLL_TP_PEDIDO TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TPE_NM_PEDIDO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STATUS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4GLOBAL.M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TST_NM_TP_STATUS ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STATUS_LA' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4GLOBAL.M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0001'' AND TST_ID_TP_STATUS IN (''001'',''002'') ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TRIBUNALES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT  TRI_ID_TRIBUNAL, TRI_NM_TRIBUNAL, TPL_ID_TP_LITIGIO, STD_ID_SUB_GEO_DIV,STD_ID_GEO_PLACE,TRI_DT_START,TRI_DT_END  FROM M4GLOBAL.M4SLL_TRIBUNALES TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TRI_NM_TRIBUNAL ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'ULTIMA_PASTA' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MAX(TO_NUMBER(LIT_ID_LITIGIO)) as ULTIMA_PASTA  FROM M4GLOBAL.M4SLL_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'STD_LEG_ENT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('select std_id_leg_ent, std_n_leg_ent from M4GLOBAL.STD_LEG_ENT WHERE ID_ORGANIZATION = ''0001'' ORDER BY STD_N_LEG_ENT ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT eju_id_est_juridico, eju_nm_est_juridico FROM M4GLOBAL.M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0001'' ORDER BY EJU_NM_EST_JURIDICO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_FASES_ESTADO' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_FASES_ESTADO WHERE ID_ORGANIZATION = ''0001'' ORDER BY FAS_NM_FASE_ESTADO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_PEDIDO_D' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT MPD_ID_PEDIDO_DETALLE, MPD_NM_PEDIDO_DETALLE,TPL_ID_TP_LITIGIO,MPD_PAGO_NOMINA_DET_S_N,MPD_DT_START,MPD_DT_END FROM M4GLOBAL.M4SLL_MTO_PEDIDO_D WHERE ID_ORGANIZATION = ''0001'' ORDER BY MPD_NM_PEDIDO_DETALLE ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_NEGOCIOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT NEG_ID_NEGOCIO,NEG_NM_NEGOCIO,LIT_CENTRO_COSTO, DT_LAST_UPDATE FROM M4GLOBAL.M4SLL_NEGOCIOS WHERE ID_ORGANIZATION = ''0001'' ORDER BY NEG_NM_NEGOCIO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESP_DELEGACI' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT EDE_ID_DELEGACION, ECI_ID_CIUDAD, EDE_NM_DELEGACION, EDE_ZONA_RRLL, DT_LAST_UPDATE  FROM M4GLOBAL.M4SLL_ESP_DELEGACI WHERE ID_ORGANIZATION = ''0001'' ORDER BY EDE_NM_DELEGACION ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESP_DELE_REP' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT EDE_ID_DELEGACION, EDE_NM_DELEGACION FROM M4GLOBAL.M4SLL_ESP_DELEGACI WHERE ID_ORGANIZATION = ''0001'' GROUP BY EDE_ID_DELEGACION,EDE_NM_DELEGACION ORDER BY EDE_NM_DELEGACION ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESP_ZONAS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT DISTINCT EDE_ZONA_RRLL, DT_LAST_UPDATE FROM M4GLOBAL.M4SLL_ESP_DELEGACI WHERE ID_ORGANIZATION = ''0001'' ORDER BY EDE_ZONA_RRLL ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESP_CIUDADES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT ECI_ID_CIUDAD,ECI_NM_CIUDAD, DT_LAST_UPDATE FROM M4GLOBAL.M4SLL_ESP_CIUDADES WHERE ID_ORGANIZATION = ''0001'' ORDER BY ECI_NM_CIUDAD ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_DOC_ORIGENES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_DOC_ORIGENES WHERE ID_ORGANIZATION = ''0001'' ORDER BY DOO_NM_DOC_ORIGEN ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_COMP_ESTADOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_COMP_ESTADOS WHERE ID_ORGANIZATION = ''0001'' ORDER BY COE_NM_COMP_ESTADO ASC',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_STATUS_PAGOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_STATUS_PAGOS WHERE ID_ORGANIZATION = ''0001'' ORDER BY STP_NM_STATUS_PAGO ASC',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_SALIDA_PA' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_TP_SALIDA_PA WHERE ID_ORGANIZATION = ''0001'' ORDER BY TSP_NM_SALIDA_PAGO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_TP_EMPLE' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_MTO_TP_EMPLE WHERE ID_ORGANIZATION = ''0001'' ORDER BY MTE_NM_TP_EMPLEADO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_RECLAMOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_TP_RECLAMOS WHERE ID_ORGANIZATION = ''0001'' ORDER BY TRC_NM_TP_RECLAMO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_MATERIA' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4GLOBAL.M4SLL_MTO_MATERIA WHERE ID_ORGANIZATION = ''0001'' ORDER BY MMA_NM_MATERIA ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_FASES_RESULT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT FAR_ID_FASE_RESULTADO, TFA_ID_TP_FASE,FAR_NM_FASE_RESULTADO,TPL_ID_TP_LITIGIO,FAR_DT_START, FAR_DT_END FROM M4GLOBAL.M4SLL_FASES_RESULT WHERE ID_ORGANIZATION = ''0001'' ORDER BY FAR_NM_FASE_RESULTADO ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_CLIENTES_OMB' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT  
     c.CLO_ID_CLIENTE,  c.CLO_NM_CLIENTE,c.CLO_DT_START, c.CLO_DT_END, DECODE(p.CLO_ID_CLIENTE,NULL,0,1) as USED
   FROM M4GLOBAL.M4SLL_CLIENTES_OMB c LEFT JOIN M4GLOBAL.M4SLL_PEDIDO_DET p
   ON (c.CLO_ID_CLIENTE = p.CLO_ID_CLIENTE and p.ID_ORGANIZATION=''0001'')
   WHERE c.ID_ORGANIZATION=''0001''
   ORDER BY c.CLO_NM_CLIENTE ASC  
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ENTIDADES' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT 
     e.ENT_ID_ENTIDAD, e.ENT_NM_ENTIDAD, e.ENT_NRO_IDENTIFICACION, e.TPE_ID_TP_ENTIDAD, 
     e.TPI_ID_TP_IDENTIFICACION, e.ENT_DT_START, e.ENT_DT_END, DECODE(a.ENT_NRO_IDENTIFICACION,NULL,0,1) AS USED, e.ENT_ID_NEGOCIO, e.ENT_TP_EMPLEADO  
   FROM M4GLOBAL.M4SLL_ENTIDADES e LEFT JOIN M4GLOBAL.M4SLL_AUTOR_REU a ON (e.ENT_NRO_IDENTIFICACION = a.ENT_NRO_IDENTIFICACION and a.ID_ORGANIZATION=''0001'')
   WHERE e.ID_ORGANIZATION=''0001'' ORDER BY e.ENT_NM_ENTIDAD ASC
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_PERSONA_EXT' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT
    p.PEX_ID_PERSONA_EXT, p.PEX_NOMBRE, p.PEX_APELLIDO, p.TPI_ID_TP_IDENTIFICACION, 
    p.PEX_NRO_DOCUMENTO, p.PEX_DT_START, p.PEX_DT_END , DECODE(a.PEX_NRO_DOCUMENTO,NULL,0,1) AS USED 
   FROM M4GLOBAL.M4SLL_PERSONA_EXT p LEFT JOIN M4GLOBAL.M4SLL_AUTOR_REU a
   ON (p.PEX_NRO_DOCUMENTO = a.PEX_NRO_DOCUMENTO and a.ID_ORGANIZATION=''0001'')
   WHERE p.ID_ORGANIZATION=''0001'' ORDER BY TO_NUMBER(p.PEX_ID_PERSONA_EXT) DESC     
    ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT 
     a.mab_secuencia, a.std_id_person, a.mab_nombre, a.mab_apellido, a.mab_email, a.mab_chk_int,
     a.ede_id_delegacion, a.eci_id_ciudad, a.std_id_leg_ent,a.mab_dt_start, a.mab_dt_end, DECODE(l.MAB_SECUENCIA,NULL,0,1) as USED
   FROM M4GLOBAL.M4SLL_MT_ABOGADOS a LEFT JOIN M4GLOBAL.M4SLL_LITIGIOS l
   ON (a.MAB_SECUENCIA = l.MAB_SECUENCIA and l.ID_ORGANIZATION=''0001'')
   WHERE a.ID_ORGANIZATION=''0001'' ORDER BY a.mab_apellido asc    
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_CONCEPTO' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT MCO_ID_CONCEPTO, MCO_NM_CONCEPTO from M4GLOBAL.m4sll_mto_concepto WHERE ID_ORGANIZATION = ''0001'' ORDER BY MCO_NM_CONCEPTO ASC
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_EST_TARE' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT MET_ID_EST_TAREA, MET_NM_EST_TAREA from M4GLOBAL.M4SLL_MTO_EST_TARE WHERE ID_ORGANIZATION = ''0001'' ORDER BY MET_NM_EST_TAREA ASC
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_TAR_CIE' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT MTC_ID_TAREA, MTC_NM_TAREA, MTC_NM_PROCEDIMIENTO from M4GLOBAL.M4SLL_MTO_TAR_CIE WHERE ID_ORGANIZATION = ''0001'' ORDER BY MTC_NM_TAREA ASC
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_EST_EJE' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('
   SELECT MEE_ID_EST_EJECUCION, MEE_NM_EST_EJECUCION  from M4GLOBAL.M4SLL_MTO_EST_EJE WHERE ID_ORGANIZATION = ''0001'' ORDER BY MEE_NM_EST_EJECUCION ASC
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'TODOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT VW_TIPOS.*FROM M4GLOBAL.M4SLL_VW_TIPOS_ES VW_TIPOS  WHERE TIPO <> ''TODOS'' AND TIPO <> ''M4SLL_PERSONA_EXT'' ',
              ''
             ) AS obj_json
     FROM DUAL 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_TIPOS_ES_18112019
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_TIPOS_ES_18112019" ("TIPO", "OBJ_JSON") AS 
  SELECT 'M4SLL_TP_AUTOR_REU' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_AUTOR_REU TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_COMPROMIS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_COMPROMIS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_DOC_LITIG' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_DOC_LITIG TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_ENTIDADES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_ENTIDADES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_FASES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_FASES TPF WHERE ID_ORGANIZATION = ''0001'' ORDER BY TFA_ID_TP_FASE ASC ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_IDENTIFIC' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_IDENTIFIC TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_LITIGIOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_MOTIVO' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_MOTIVO TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_PAGOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_PAGOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_PEDIDO' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_PEDIDO TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_STATUS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_STATUS_LA' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0001'' AND TST_ID_TP_STATUS IN (''001'',''002'') ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TRIBUNALES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TRIBUNALES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'ULTIMA_PASTA' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT MAX(TO_NUMBER(LIT_ID_LITIGIO)) as ULTIMA_PASTA  FROM M4SLL_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'STD_LEG_ENT' AS tipo,
          m4pkg_util_pkg.sql2json
             ('select std_id_leg_ent, std_n_leg_ent from STD_LEG_ENT WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT eju_id_est_juridico, eju_nm_est_juridico FROM M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_FASES_ESTADO' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_FASES_ESTADO WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_MTO_PEDIDO_D' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_MTO_PEDIDO_D WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_NEGOCIOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_NEGOCIOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_ESP_DELEGACI' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_ESP_DELEGACI WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_ESP_CIUDADES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_ESP_CIUDADES WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_DOC_ORIGENES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_DOC_ORIGENES WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_COMP_ESTADOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_COMP_ESTADOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_STATUS_PAGOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_STATUS_PAGOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_SALIDA_PA' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_TP_SALIDA_PA WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_MTO_TP_EMPLE' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_MTO_TP_EMPLE WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_TP_RECLAMOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_TP_RECLAMOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_MTO_MATERIA' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_MTO_MATERIA WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_FASES_RESULT' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_FASES_RESULT WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   /* ***************** TIPOS CON TABLAS MAESTRO ********************* */
   SELECT 'M4SLL_CLIENTES_OMB' AS tipo,
          m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT  
     c.CLO_ID_CLIENTE,  c.CLO_NM_CLIENTE, DECODE(p.CLO_ID_CLIENTE,NULL,0,1) as USED
   FROM M4SLL_CLIENTES_OMB c LEFT JOIN M4SLL_PEDIDO_DET p
   ON (c.CLO_ID_CLIENTE = p.CLO_ID_CLIENTE and p.ID_ORGANIZATION=''0001'')
   WHERE c.ID_ORGANIZATION=''0001''
   ORDER BY TO_NUMBER(c.CLO_ID_CLIENTE) DESC  

   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_ENTIDADES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT 
     e.ENT_ID_ENTIDAD, e.ENT_NM_ENTIDAD, e.ENT_NRO_IDENTIFICACION, e.TPE_ID_TP_ENTIDAD, 
     e.TPI_ID_TP_IDENTIFICACION, DECODE(a.ENT_NRO_IDENTIFICACION,NULL,0,1) AS USED 
   FROM M4SLL_ENTIDADES e LEFT JOIN M4SLL_AUTOR_REU a ON (e.ENT_NRO_IDENTIFICACION = a.ENT_NRO_IDENTIFICACION and a.ID_ORGANIZATION=''0001'')
   WHERE e.ID_ORGANIZATION=''0001'' ORDER BY TO_NUMBER(e.ENT_ID_ENTIDAD) DESC

   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_PERSONA_EXT' AS tipo,
          m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT
    p.PEX_ID_PERSONA_EXT, p.PEX_NOMBRE, p.PEX_APELLIDO, p.TPI_ID_TP_IDENTIFICACION, 
    p.PEX_NRO_DOCUMENTO, DECODE(a.PEX_NRO_DOCUMENTO,NULL,0,1) AS USED 
   FROM M4SLL_PERSONA_EXT p LEFT JOIN M4SLL_AUTOR_REU a
   ON (p.PEX_NRO_DOCUMENTO = a.PEX_NRO_DOCUMENTO and a.ID_ORGANIZATION=''0001'')
   WHERE p.ID_ORGANIZATION=''0001'' ORDER BY TO_NUMBER(p.PEX_ID_PERSONA_EXT) DESC     
    ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
-------------------------------
   SELECT 'M4SLL_MT_ABOGADOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('
   SELECT DISTINCT 
     a.mab_secuencia, a.std_id_person, a.mab_nombre, a.mab_apellido, a.mab_email, a.mab_chk_int,
     a.ede_id_delegacion, a.eci_id_ciudad, a.std_id_leg_ent, a.mab_dt_end, DECODE(l.MAB_SECUENCIA,NULL,0,1) as USED
   FROM M4SLL_MT_ABOGADOS a LEFT JOIN M4SLL_LITIGIOS l
   ON (a.MAB_SECUENCIA = l.MAB_SECUENCIA and l.ID_ORGANIZATION=''0001'')
   WHERE a.ID_ORGANIZATION=''0001'' ORDER BY MAB_SECUENCIA desc    
   ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   /* ***************** FIN TIPOS CON TABLAS MAESTRO ********************* */
   SELECT 'TODOS' AS tipo,
          m4global.m4pkg_util_pkg.sql2json
             ('SELECT VW_TIPOS.*FROM M4GLOBAL.M4SLL_VW_TIPOS_ES VW_TIPOS  WHERE TIPO <> ''TODOS''',
              ''
             ) AS obj_json
     FROM DUAL 
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_TIPOS_ES_2
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_TIPOS_ES_2" ("TIPO", "OBJ_JSON") AS 
  SELECT 'M4SLL_TP_AUTOR_REU' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_AUTOR_REU TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_COMPROMIS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_COMPROMIS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_DOC_LITIG' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_DOC_LITIG TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ENTIDADES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_ENTIDADES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_FASES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_FASES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_IDENTIFIC' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_IDENTIFIC TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_LITIGIOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_MOTIVO' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_MOTIVO TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PAGOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_PAGOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_PEDIDO' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_PEDIDO TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_RECURREN' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_RECURREN TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_ROLES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_ROLES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STA_DET' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_STA_DET TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TP_STATUS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TP_STATUS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_TRIBUNALES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT TPF.*FROM M4SLL_TRIBUNALES TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'ULTIMA_PASTA' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT MAX(TO_NUMBER(LIT_ID_LITIGIO)) as ULTIMA_PASTA  FROM M4SLL_LITIGIOS TPF WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'STD_LEG_ENT' AS tipo,
          m4pkg_util_pkg.sql2json
             ('select std_id_leg_ent, std_n_leg_ent from STD_LEG_ENT WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESTUDIO_JUR' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT eju_id_est_juridico, eju_nm_est_juridico FROM M4SLL_ESTUDIO_JUR WHERE ID_ORGANIZATION = ''0001'' ',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_FASES_ESTADO' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_FASES_ESTADO WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MTO_PEDIDO_D' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_MTO_PEDIDO_D WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_NEGOCIOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_NEGOCIOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_MT_ABOGADOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_MT_ABOGADOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESP_DELEGACI' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_ESP_DELEGACI WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_ESP_CIUDADES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_ESP_CIUDADES WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL
   UNION ALL
   SELECT 'M4SLL_DOC_ORIGENES' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_DOC_ORIGENES WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL

UNION ALL
   SELECT 'M4SLL_COMP_ESTADOS' AS tipo,
          m4pkg_util_pkg.sql2json
             ('SELECT * FROM M4SLL_COMP_ESTADOS WHERE ID_ORGANIZATION = ''0001''',
              ''
             ) AS obj_json
     FROM DUAL

UNION ALL
SELECT 'M4SLL_STATUS_PAGOS' AS tipo,
      m4pkg_util_pkg.sql2json
         ('SELECT * FROM M4SLL_STATUS_PAGOS WHERE ID_ORGANIZATION = ''0001''',
          ''
         ) AS obj_json
 FROM DUAL

 UNION ALL
 SELECT 'M4SLL_TP_SALIDA_PA' AS tipo,
      m4pkg_util_pkg.sql2json
         ('SELECT * FROM M4SLL_TP_SALIDA_PA WHERE ID_ORGANIZATION = ''0001''',
          ''
         ) AS obj_json
 FROM DUAL


 UNION ALL
 SELECT 'M4SLL_MTO_TP_EMPLE' AS tipo,
      m4pkg_util_pkg.sql2json
         ('SELECT * FROM M4SLL_MTO_TP_EMPLE WHERE ID_ORGANIZATION = ''0001''',
          ''
         ) AS obj_json
 FROM DUAL
         
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_USES_CL
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_USES_CL" ("USUARIO", "RESPUESTA", "SOLICITUD") AS 
  SELECT usuario, 
          
--  CONSULTA, 
          M4PKG_UTIL_PKG.sql2json 
                        (M4PKG_UTIL_PKG.f_sql_paginado_bind ('ADMIN', 
                                                        consulta,    
                                                        filtro,
                                                        pagina, 
                                                        300 
                                                       ), 
                         filtro 
                        ) AS RESPUESTA,
                        ACCION AS SOLICITUD
                    
     FROM m4sll_param_usr
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_USES_ES
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_USES_ES" ("USUARIO", "RESPUESTA", "SOLICITUD") AS 
  SELECT usuario, 
          
--  CONSULTA, 
          M4PKG_UTIL_PKG.sql2json 
                        (M4PKG_UTIL_PKG.f_sql_paginado_bind ('ADMIN', 
                                                        consulta,    
                                                        filtro,
                                                        pagina, 
                                                        300 
                                                       ), 
                         filtro 
                        ) AS RESPUESTA,
                        ACCION AS SOLICITUD
                    
     FROM m4sll_param_usr
;
--------------------------------------------------------
--  DDL for View M4SLL_VW_USES_PE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "M4SLL_VW_USES_PE" ("USUARIO", "RESPUESTA", "SOLICITUD") AS 
  SELECT usuario, 
          
--  CONSULTA, 
          M4PKG_UTIL_PKG.sql2json 
                        (M4PKG_UTIL_PKG.f_sql_paginado_bind ('ADMIN', 
                                                        consulta,    
                                                        filtro,
                                                        pagina, 
                                                        300 
                                                       ), 
                         filtro 
                        ) AS RESPUESTA,
                        ACCION AS SOLICITUD
                    
     FROM m4sll_param_usr
;
--------------------------------------------------------
--  DDL for Materialized View M4SLL_VW_REPORTE_LITIGIO
--------------------------------------------------------

  CREATE MATERIALIZED VIEW "M4SLL_VW_REPORTE_LITIGIO" ("Expediente", "Refe", "Empresa", "Demandado", "Negocio", "Ciudad", "Delegacion", "Zona Lab", "Demandante", "NIF", "Codigo", "Analitica", "Tipo demandante", "Personal", "Fecha Alta", "Importe Previsto", "Asunto", "Asuntos Secundarios", "Subasunto", "Subasunto Secundario", "Cliente", "Fe Despido/Pres demanda", "Fecha Conciliación", "Resultado Conciliación", "Fecha Juzgado", "N° Autos", "Resultado Juzgado", "Fecha Tribunal Superior", "Tribuanl Superior resultado", "Fecha Tribunal Supremo", "Tribunal Supremo resultado", "Total Coste", "Fecha estado", "Estado Final", "Fecha Cierre", "Abogado", "Observaciones", "TPL_ID_TP_LITIGIO", "TST_ID_TP_STATUS", "ECI_ID_CIUDAD", "EDE_ID_DELEGACION", "MAB_SECUENCIA", "EDE_ZONA_RRLL", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "LIT_FECHA_INICIO", "LIT_FECHA_CIERRE", "LIT_NRO_PROCESO", "LIT_NUMERO_EJECUCION")
  ORGANIZATION HEAP PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  BUILD IMMEDIATE
  USING INDEX 
  REFRESH FORCE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT
  USING ENFORCED CONSTRAINTS DISABLE QUERY REWRITE
  AS SELECT 
            L.LIT_ID_LITIGIO as "Expediente",
            L.LIT_ID_LEGADO as "Refe",        
            E.STD_N_LEG_ENT AS "Empresa",
            REU.NOMBRE as "Demandado",
            NEG.NEG_NM_NEGOCIO as "Negocio",
            CI.ECI_NM_CIUDAD as "Ciudad",
            DE.EDE_NM_DELEGACION as "Delegacion",
            DE.EDE_ZONA_RRLL as "Zona Lab",
            AUTOR.NOMBRE as "Demandante",
            COALESCE(AR.PEX_NRO_DOCUMENTO, AR.ENT_NRO_IDENTIFICACION, P.STD_SSN, AR.STD_ID_LEG_ENT) as NIF,
            AR.STD_ID_PERSON as "Codigo",
            L.STD_ID_LEG_ENT || L.LIT_REGION || L.LIT_DIVISION ||L.LIT_CENTRO_COSTO as "Analitica",
            CASE WHEN L.LIT_CORPORATIVO_S_N='N' THEN 'NO CORPORATIVO' ELSE 'CORPORATIVO' END as "Tipo demandante", 
            MPE.MTE_NM_TP_EMPLEADO as "Personal",
            TO_CHAR(L.LIT_FECHA_INICIO, 'dd/mm/yyyy') as "Fecha Alta",
            L.LIT_VALOR_PED_TOTAL as "Importe Previsto",
            TPE.TPE_NM_PEDIDO as "Asunto",
            M4PKG_SLL_RP_ES_LITIGIOS.ASUNTOS_SECUNDARIOS(L.LIT_ID_LITIGIO) as "Asuntos Secundarios",
            M4PKG_SLL_RP_ES_LITIGIOS.SUB_ASUNTOS(L.LIT_ID_LITIGIO,'S') as "Subasunto",
            M4PKG_SLL_RP_ES_LITIGIOS.SUB_ASUNTOS(L.LIT_ID_LITIGIO, 'N') as "Subasunto Secundario",
            M4PKG_SLL_RP_ES_LITIGIOS.ASUNTOS_OMBUS(L.LIT_ID_LITIGIO) as "Cliente",
            --L.LIT_FECHA_PRESENTACION as "Fe Despido/Pres demanda",
            TO_CHAR(M4PKG_SLL_RP_ES_LITIGIOS.PRIMERA_FASE(L.LIT_ID_LITIGIO), 'dd/mm/yyyy') as "Fe Despido/Pres demanda",
            TO_CHAR(M4PKG_SLL_RP_ES_LITIGIOS.PRIMERA_FASE_TIPO(L.LIT_ID_LITIGIO,'002'), 'dd/mm/yyyy') as "Fecha Conciliación",
            M4PKG_SLL_RP_ES_LITIGIOS.RESULTADO_FASE_TIPO(L.LIT_ID_LITIGIO,'002') as "Resultado Conciliación",
            TO_CHAR(M4PKG_SLL_RP_ES_LITIGIOS.PRIMERA_FASE_TIPO(L.LIT_ID_LITIGIO,'003'), 'dd/mm/yyyy') as "Fecha Juzgado",
            L.LIT_NRO_PROCESO as "N° Autos", 
            M4PKG_SLL_RP_ES_LITIGIOS.RESULTADO_FASE_TIPO(L.LIT_ID_LITIGIO,'003') as "Resultado Juzgado",
            TO_CHAR(M4PKG_SLL_RP_ES_LITIGIOS.PRIMERA_FASE_TIPO(L.LIT_ID_LITIGIO,'004'), 'dd/mm/yyyy') as "Fecha Tribunal Superior",
            M4PKG_SLL_RP_ES_LITIGIOS.RESULTADO_FASE_TIPO(L.LIT_ID_LITIGIO,'004') as "Tribuanl Superior resultado",
            TO_CHAR(M4PKG_SLL_RP_ES_LITIGIOS.PRIMERA_FASE_TIPO(L.LIT_ID_LITIGIO,'005'), 'dd/mm/yyyy') as "Fecha Tribunal Supremo",
            M4PKG_SLL_RP_ES_LITIGIOS.RESULTADO_FASE_TIPO(L.LIT_ID_LITIGIO,'005') as "Tribunal Supremo resultado",
            L.LIT_VALOR_TOTAL as "Total Coste", 
            TO_CHAR(L.LIT_DT_ACTUALIZACION, 'dd/mm/yyyy') as "Fecha estado",
            TS.TST_NM_TP_STATUS as "Estado Final",        
            TO_CHAR(L.LIT_FECHA_CIERRE, 'dd/mm/yyyy') as "Fecha Cierre",
            AB.MAB_NOMBRE || ' ' || AB.MAB_APELLIDO as "Abogado",
            M4PKG_SLL_RP_ES_LITIGIOS.SEGUIMIENTOS(L.LIT_ID_LITIGIO) as "Observaciones",
            L.TPL_ID_TP_LITIGIO,
            L.TST_ID_TP_STATUS,
            L.ECI_ID_CIUDAD,
            L.EDE_ID_DELEGACION,
            L.MAB_SECUENCIA,
            DE.EDE_ZONA_RRLL,
            PE.TPE_ID_PEDIDO,
            L.NEG_ID_NEGOCIO,
            L.LIT_FECHA_INICIO,
            L.LIT_FECHA_CIERRE,
            L.LIT_NRO_PROCESO,
            L.LIT_NUMERO_EJECUCION         
            
            -- '{"TPL_ID_TP_LITIGIO":"","TST_ID_TP_STATUS":"","ECI_ID_CIUDAD":"","EDE_ID_DELEGACION":"","MAB_SECUENCIA":"","EDE_ZONA_RRLL":"","TPE_ID_PEDIDO":""
            --,"NEG_ID_NEGOCIO":"","LIT_FECHA_INICIO":"","LIT_FECHA_CIERRE":"","NRO_AUTO":"","NRO_EJECUCION":"","NUEVO_FORMATO":"S"}';
        FROM 
            M4SLL_LITIGIOS L            LEFT JOIN STD_LEG_ENT           E   ON L.STD_ID_LEG_ENT=E.STD_ID_LEG_ENT        AND L.ID_ORGANIZATION = E.ID_ORGANIZATION 
                LEFT JOIN M4SLL_ESP_CIUDADES    CI  ON L.ECI_ID_CIUDAD=CI.ECI_ID_CIUDAD         AND L.ID_ORGANIZATION = CI.ID_ORGANIZATION 
                LEFT JOIN M4SLL_ESP_DELEGACI    DE  ON L.ECI_ID_CIUDAD=DE.ECI_ID_CIUDAD         AND L.EDE_ID_DELEGACION=DE.EDE_ID_DELEGACION    AND L.ID_ORGANIZATION = DE.ID_ORGANIZATION 
                LEFT JOIN M4SLL_AUTOR_REU       AR  ON L.LIT_ID_LITIGIO=AR.LIT_ID_LITIGIO       AND L.ID_ORGANIZATION = AR.ID_ORGANIZATION  AND AR.AUR_AUTOR_REU='A'
                LEFT JOIN M4SLL_MTO_TP_EMPLE    MPE ON AR.MTE_ID_TP_EMPLEADO = MPE.MTE_ID_TP_EMPLEADO AND AR.ID_ORGANIZATION = MPE.ID_ORGANIZATION
                LEFT JOIN M4SLL_PEDIDOS         PE  ON L.LIT_ID_LITIGIO=PE.LIT_ID_LITIGIO       AND PE.PED_PRINCIPAL_S_N='S'                    AND L.ID_ORGANIZATION = PE.ID_ORGANIZATION 
                LEFT JOIN M4SLL_TP_PEDIDO       TPE ON PE.TPE_ID_PEDIDO=TPE.TPE_ID_PEDIDO       AND L.ID_ORGANIZATION = TPE.ID_ORGANIZATION 
                LEFT JOIN M4SLL_TP_STATUS       TS  ON L.TST_ID_TP_STATUS=TS.TST_ID_TP_STATUS   AND L.ID_ORGANIZATION = TS.ID_ORGANIZATION 
                LEFT JOIN M4SLL_MT_ABOGADOS     AB  ON L.MAB_SECUENCIA=AB.MAB_SECUENCIA         AND L.ID_ORGANIZATION = AB.ID_ORGANIZATION 
                LEFT JOIN STD_PERSON            P   ON AR.STD_ID_PERSON=P.STD_ID_PERSON         
                LEFT JOIN M4SLL_TP_MOTIVO       MT ON L.TMO_ID_TP_MOTIVO=MT.TMO_ID_TP_MOTIVO    AND L.ID_ORGANIZATION = MT.ID_ORGANIZATION 
                LEFT JOIN M4SLL_MTO_MATERIA     MA ON L.MMA_ID_MATERIA = MA.MMA_ID_MATERIA      AND L.ID_ORGANIZATION = MA.ID_ORGANIZATION
                LEFT JOIN M4SLL_NEGOCIOS        NEG ON L.NEG_ID_NEGOCIO = NEG.NEG_ID_NEGOCIO    AND L.ID_ORGANIZATION = NEG.ID_ORGANIZATION 
                LEFT JOIN (
                    SELECT (
                        LISTAGG(SLEN.STD_N_LEG_ENT ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, M4AURE.STD_ID_LEG_ENT) ) AS NOMBRE,
                        M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                        M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                    FROM 
                        M4SLL_AUTOR_REU M4AURE
                        JOIN STD_LEG_ENT SLEN  ON (  M4AURE.AUR_AUTOR_REU = 'A' AND SLEN.STD_ID_LEG_ENT =  M4AURE.STD_ID_LEG_ENT AND  SLEN.ID_ORGANIZATION = '0001' )
                    GROUP BY                     M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                    UNION SELECT 
                        (LISTAGG( M4PEEX.PEX_APELLIDO || ' ' || M4PEEX.PEX_NOMBRE ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, M4PEEX.PEX_NRO_DOCUMENTO ) ) AS NOMBRE,
                        M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                        M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                    FROM                     M4SLL_AUTOR_REU M4AURE
                        JOIN  M4SLL_PERSONA_EXT M4PEEX ON (
                            M4AURE.AUR_AUTOR_REU = 'A' AND M4PEEX.PEX_NRO_DOCUMENTO = M4AURE.PEX_NRO_DOCUMENTO
                        )
                    WHERE M4PEEX.ID_ORGANIZATION = '0001'   
                    GROUP BY 
                        M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                    UNION SELECT 
                        (LISTAGG(M4EN.ENT_NM_ENTIDAD ,' | ' )WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, M4EN.ENT_NRO_IDENTIFICACION ) ) AS NOMBRE,   
                        M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                        M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                    FROM
                        M4SLL_AUTOR_REU M4AURE
                        JOIN M4SLL_ENTIDADES M4EN ON (   M4AURE.AUR_AUTOR_REU = 'A' AND M4EN.ENT_NRO_IDENTIFICACION =  M4AURE.ENT_NRO_IDENTIFICACION)
                    WHERE  
                        M4EN.ID_ORGANIZATION = '0001'   
                    GROUP BY 
                        M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                    UNION SELECT 
                        (LISTAGG( STDP.STD_N_FAM_NAME_1 || ' ' || STDP.STD_N_FIRST_NAME ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, STDP.STD_ID_PERSON) ) AS NOMBRE,
                        M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                        M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                    FROM 
                        M4SLL_AUTOR_REU M4AURE                    JOIN STD_PERSON STDP ON (  M4AURE.AUR_AUTOR_REU = 'A' AND STDP.STD_ID_PERSON = M4AURE.STD_ID_PERSON )                 
                    GROUP BY                     M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                ) AUTOR ON (AUTOR.ID_ORGANIZATION = '0001' AND  AUTOR.LIT_ID_LITIGIO = L.LIT_ID_LITIGIO )
                LEFT JOIN (SELECT (LISTAGG(SLEN.STD_N_LEG_ENT ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, M4AURE.STD_ID_LEG_ENT) ) AS NOMBRE
                    ,M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                    M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                    FROM M4SLL_AUTOR_REU M4AURE
                    JOIN STD_LEG_ENT SLEN  ON (  M4AURE.AUR_AUTOR_REU = 'R' AND SLEN.STD_ID_LEG_ENT =  M4AURE.STD_ID_LEG_ENT AND  SLEN.ID_ORGANIZATION = '0001' )
                    GROUP BY M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                    UNION SELECT (LISTAGG( M4PEEX.PEX_APELLIDO || ' ' || M4PEEX.PEX_NOMBRE ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, M4PEEX.PEX_NRO_DOCUMENTO ) ) AS NOMBRE,
                    M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                    M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                    FROM M4SLL_AUTOR_REU M4AURE
                        JOIN  M4SLL_PERSONA_EXT M4PEEX ON (
                            M4AURE.AUR_AUTOR_REU = 'R' AND M4PEEX.PEX_NRO_DOCUMENTO = M4AURE.PEX_NRO_DOCUMENTO
                        )
                    WHERE  M4PEEX.ID_ORGANIZATION = '0001'                  GROUP BY M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                    UNION SELECT (LISTAGG(M4EN.ENT_NM_ENTIDAD ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, M4EN.ENT_NRO_IDENTIFICACION ) ) AS NOMBRE,   
                    M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                    M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                        FROM M4SLL_AUTOR_REU M4AURE JOIN M4SLL_ENTIDADES M4EN ON (   M4AURE.AUR_AUTOR_REU = 'R' AND M4EN.ENT_NRO_IDENTIFICACION =  M4AURE.ENT_NRO_IDENTIFICACION)
                        WHERE  M4EN.ID_ORGANIZATION = '0001'                GROUP BY M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                    UNION SELECT (LISTAGG( STDP.STD_N_FAM_NAME_1 || ' ' || STDP.STD_N_FIRST_NAME ,' | ' ) WITHIN GROUP (ORDER BY M4AURE.LIT_ID_LITIGIO, STDP.STD_ID_PERSON) ) AS NOMBRE,
                    M4AURE.LIT_ID_LITIGIO AS LIT_ID_LITIGIO,
                    M4AURE.ID_ORGANIZATION AS ID_ORGANIZATION
                        FROM M4SLL_AUTOR_REU M4AURE
                            JOIN STD_PERSON STDP ON (  M4AURE.AUR_AUTOR_REU = 'R' AND STDP.STD_ID_PERSON = M4AURE.STD_ID_PERSON )                 
                        GROUP BY M4AURE.ID_ORGANIZATION,M4AURE.LIT_ID_LITIGIO 
                )REU ON (REU.ID_ORGANIZATION = '0001' AND  REU.LIT_ID_LITIGIO = L.LIT_ID_LITIGIO )
        WHERE 
            L.ID_ORGANIZATION = '0001' ;

   COMMENT ON MATERIALIZED VIEW "M4SLL_VW_REPORTE_LITIGIO"  IS 'snapshot table for snapshot M4GLOBAL.M4SLL_VW_REPORTE_LITIGIO';
--------------------------------------------------------
--  DDL for Index IDX_M4SLL_AUTOR_REU_AUTOR
--------------------------------------------------------

  CREATE INDEX "IDX_M4SLL_AUTOR_REU_AUTOR" ON "M4SLL_AUTOR_REU" ("ID_ORGANIZATION" DESC, "LIT_ID_LITIGIO" DESC, "AUR_AUTOR_REU") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index IDX_M4SLL_PEDIDOS_PRINCIPAL
--------------------------------------------------------

  CREATE INDEX "IDX_M4SLL_PEDIDOS_PRINCIPAL" ON "M4SLL_PEDIDOS" ("ID_ORGANIZATION" DESC, "LIT_ID_LITIGIO" DESC, "PED_PRINCIPAL_S_N") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index IDX_M4SLL_PERSONA_EXT
--------------------------------------------------------

  CREATE INDEX "IDX_M4SLL_PERSONA_EXT" ON "M4SLL_PERSONA_EXT" ("ID_ORGANIZATION" DESC, "PEX_NRO_DOCUMENTO" DESC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_AUTOR_REU_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_AUTOR_REU_PRUEBA_GABY_PK" ON "M4SLL_AUTOR_REU_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_AUTOR_REU_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_AUTOR_REU_UK" ON "M4SLL_AUTOR_REU" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_ESP_DELEGACI_PRU_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_ESP_DELEGACI_PRU_GABY_PK" ON "M4SLL_ESP_DELEGACI_PRUEBA_GABY" ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_INI_PARAM_CALC_PROV_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_INI_PARAM_CALC_PROV_PK" ON "M4SLL_INI_PARAM_CALC_PROV" ("IPAR_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_INI_PARAM_CALC_PROV_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_INI_PARAM_CALC_PROV_UK" ON "M4SLL_INI_PARAM_CALC_PROV" ("ID_ORGANIZATION", "IPAR_PROCESO", "IPAR_NOMBRE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_INT_LIST_LITIGIOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_INT_LIST_LITIGIOS_PK" ON "M4SLL_INT_LIST_LITIGIOS" ("LIT_ID_LITIGIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_LITIGIOS_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_LITIGIOS_PRUEBA_GABY_PK" ON "M4SLL_LITIGIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK" ON "M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK" ON "M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_MATRIZ_PRE_PARAM_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_MATRIZ_PRE_PARAM_PK" ON "M4SLL_MATRIZ_PRE_PARAM" ("MPP_ID_ORDEN") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_NEGOCIOS_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_NEGOCIOS_PRUEBA_GABY_PK" ON "M4SLL_NEGOCIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_PARAM_USR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_PARAM_USR_PK" ON "M4SLL_PARAM_USR" ("USUARIO", "ACCION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_PEDIDOS_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_PEDIDOS_PRUEBA_GABY_PK" ON "M4SLL_PEDIDOS_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPE_ID_PEDIDO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK" ON "M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" ("ID_ORGANIZATION", "MPC_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index I_MLOG$_M4SLL_ESP_CIUDADES
--------------------------------------------------------

  CREATE INDEX "I_MLOG$_M4SLL_ESP_CIUDADES" ON "MLOG$_M4SLL_ESP_CIUDADES" ("XID$$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index I_MLOG$_M4SLL_LITIGIOS
--------------------------------------------------------

  CREATE INDEX "I_MLOG$_M4SLL_LITIGIOS" ON "MLOG$_M4SLL_LITIGIOS" ("XID$$") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2011041824350
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011041824350" ON "M4SLL_ABOHON_NJ" ("ANJ_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1909190913290
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1909190913290" ON "M4SLL_ASIENTOS_C" ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1909190936290
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1909190936290" ON "M4SLL_ASIENTOS_D" ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "HDP_DT_PERIODO", "ASD_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1812101138149
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138149" ON "M4SLL_AU_REU_ANALI" ("LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARA_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index IDX_M4SLL_AUTOR_REU_AUTOR
--------------------------------------------------------

  CREATE INDEX "IDX_M4SLL_AUTOR_REU_AUTOR" ON "M4SLL_AUTOR_REU" ("ID_ORGANIZATION" DESC, "LIT_ID_LITIGIO" DESC, "AUR_AUTOR_REU") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138147
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138147" ON "M4SLL_AUTOR_REU" ("AUR_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_AUTOR_REU_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_AUTOR_REU_UK" ON "M4SLL_AUTOR_REU" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_AUTOR_REU_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_AUTOR_REU_PRUEBA_GABY_PK" ON "M4SLL_AUTOR_REU_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "AUR_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381411
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381411" ON "M4SLL_AUT_REU_DOC" ("LIT_ID_LITIGIO", "AUR_SECUENCIA", "ARD_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911141709510
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911141709510" ON "M4SLL_CASUIS_CTAS" ("CCU_CASO", "CCU_NRO_ASIENTO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905100932210
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905100932210" ON "M4SLL_CCB_RAMAJUDC" ("RJC_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905100932211
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905100932211" ON "M4SLL_CCB_RAMAJUDD" ("RJD_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2001281715260
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2001281715260" ON "M4SLL_CCB_RJCC_BKP" ("RJC_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2001281715261
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2001281715261" ON "M4SLL_CCB_RJCD_BKP" ("RJD_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1912271205373
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912271205373" ON "M4SLL_CIERRES_MENS" ("CIM_ANIO", "CIM_MES", "MTC_ID_TAREA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1908261544270
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1908261544270" ON "M4SLL_CLIENTES_OMB" ("CLO_ID_CLIENTE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1909091116410
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1909091116410" ON "M4SLL_CLIENTES_ROL" ("CLO_ID_CLIENTE", "CLR_ID_ROLE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901041401263
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901041401263" ON "M4SLL_COMP_DETALLE" ("COM_SECUENCIA", "LIT_ID_LITIGIO", "COE_ID_COMP_ESTADO", "COR_ID_COMP_RESULTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK18121011381412
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381412" ON "M4SLL_COMP_DOC" ("TCO_ID_TP_COMPROMISO", "LIT_ID_LITIGIO", "COD_SECUENCIA", "COM_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901041401262
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901041401262" ON "M4SLL_COMP_ESTADOS" ("COE_ID_COMP_ESTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901041401264
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901041401264" ON "M4SLL_COMP_RESULTA" ("COR_ID_COMP_RESULTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231410221
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231410221" ON "M4SLL_COMPROMISOS" ("TCO_ID_TP_COMPROMISO", "LIT_ID_LITIGIO", "COM_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911150935200
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911150935200" ON "M4SLL_CONVERSION" ("CON_REFERENCIA", "CON_VALOR_CONVERTIDO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805281516260
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805281516260" ON "M4SLL_COTIZACION" ("COT_ANIO", "COT_MES", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2011181849030
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011181849030" ON "M4SLL_CPE_CEJPJ_C" ("LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2011181849031
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011181849031" ON "M4SLL_CPE_CEJPJ_D" ("LIT_ID_LITIGIO", "CCD_ID_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1906241115300
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1906241115300" ON "M4SLL_CTRL_ERRORES" ("CTE_USUARIO", "CTE_FECHA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1908061519450
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1908061519450" ON "M4SLL_CUADRANTE" ("ORDINAL_10_PK", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1908261618440
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1908261618440" ON "M4SLL_DATOS_WF" ("ID_BPC", "MODULO", "ID_MODULE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231555314
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231555314" ON "M4SLL_DESTINATARIO" ("DES_ID_DESTINATARIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381420
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381420" ON "M4SLL_DOC_LITIGIOS" ("DOL_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901041401261
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901041401261" ON "M4SLL_DOC_ORIGENES" ("DOO_ID_DOC_ORIGEN", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805241632110
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805241632110" ON "M4SLL_DOCPAG" ("LIT_ID_LITIGIO", "DCP_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231243390
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231243390" ON "M4SLL_ENTIDADES" ("ENT_NRO_IDENTIFICACION", "TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905081629510
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905081629510" ON "M4SLL_ESP_CIUDADES" ("ECI_ID_CIUDAD", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905081629512
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905081629512" ON "M4SLL_ESP_DELEGACI" ("EDE_ID_DELEGACION", "ECI_ID_CIUDAD", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_ESP_DELEGACI_PRU_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_ESP_DELEGACI_PRU_GABY_PK" ON "M4SLL_ESP_DELEGACI_PRUEBA_GABY" ("ID_ORGANIZATION", "EDE_ID_DELEGACION", "ECI_ID_CIUDAD") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911041402250
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911041402250" ON "M4SLL_ESP_LIT_PROV" ("LIT_ID_LITIGIO", "ELP_ANIO", "ELP_MES", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1901241529580
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901241529580" ON "M4SLL_EST_JUR_SUB" ("EJU_ID_EST_JURIDICO", "EJS_ID_EST_JUR_SUB", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381413
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381413" ON "M4SLL_ESTUDIO_JUR" ("EJU_ID_EST_JURIDICO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_FASES_TFA_ID_FASE
--------------------------------------------------------

  CREATE INDEX "M4SLL_FASES_TFA_ID_FASE" ON "M4SLL_FASES" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TFA_ID_TP_FASE" DESC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1903121315171
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1903121315171" ON "M4SLL_FASES" ("LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1903121315173
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1903121315173" ON "M4SLL_FASES_DOC" ("LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "FAD_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1903121315172
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1903121315172" ON "M4SLL_FASES_ESTADO" ("FAS_ID_FASE_ESTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2011111629350
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011111629350" ON "M4SLL_FASES_PROV" ("FAP_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1903121315170
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1903121315170" ON "M4SLL_FASES_RESULT" ("FAR_ID_FASE_RESULTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1908121633201
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1908121633201" ON "M4SLL_HIS_DET_PROV" ("LIT_ID_LITIGIO", "TFA_ID_TP_FASE", "MDP_ID_DET_PROVISION", "HDP_DT_PERIODO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_INI_PARAM_CALC_PROV_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_INI_PARAM_CALC_PROV_PK" ON "M4SLL_INI_PARAM_CALC_PROV" ("IPAR_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_INI_PARAM_CALC_PROV_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_INI_PARAM_CALC_PROV_UK" ON "M4SLL_INI_PARAM_CALC_PROV" ("ID_ORGANIZATION", "IPAR_PROCESO", "IPAR_NOMBRE") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911141648351
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911141648351" ON "M4SLL_INT_GL_TRX_L" ("ORIGEN", "GRUPO", "LOTE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911141648350
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911141648350" ON "M4SLL_INT_GL_TRXS" ("ORIGEN", "GRUPO", "LOTE", "RENGLON", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_INT_LIST_LITIGIOS_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_INT_LIST_LITIGIOS_PK" ON "M4SLL_INT_LIST_LITIGIOS" ("LIT_ID_LITIGIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911131129411
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911131129411" ON "M4SLL_INT_PAG_NO_D" ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907291718440
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907291718440" ON "M4SLL_INT_PAGO_NOM" ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1904111011150
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1904111011150" ON "M4SLL_LIT_HECHOS" ("LIT_ID_LITIGIO", "LIH_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138140
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138140" ON "M4SLL_LITIGIOS" ("LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812110929540
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812110929540" ON "M4SLL_LITIGIOS_HIS" ("LIT_ID_LITIGIO", "LIH_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_LITIGIOS_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_LITIGIOS_PRUEBA_GABY_PK" ON "M4SLL_LITIGIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901041650550
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901041650550" ON "M4SLL_LIT_SEGUIMIE" ("LIT_ID_LITIGIO", "LIS_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1904041344150
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1904041344150" ON "M4SLL_LIT_VINCULAD" ("LIT_ID_LITIGIO", "LIV_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1910111308481
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1910111308481" ON "M4SLL_MATRIZ_PRE_C" ("MPC_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_MATRIZ_PRE_C_PRUEBA_G_UK" ON "M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" ("ID_ORGANIZATION", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "NEG_ID_NEGOCIO", "MTE_ID_TP_EMPLEADO", "EDE_ID_DELEGACION", "EDE_ZONA_RRLL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK_M4SLL_MATRIZ_PRE_C_PRUEB_PK" ON "M4SLL_MATRIZ_PRE_C_PRUEBA_GABY" ("ID_ORGANIZATION", "MPC_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1910111308480
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1910111308480" ON "M4SLL_MATRIZ_PRE_D" ("MPD_ANIO", "MPD_MES", "MPC_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1910101723320
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1910101723320" ON "M4SLL_MATRIZ_PREDI" ("MPR_ANIO", "MPR_MES", "TPL_ID_TP_LITIGIO", "TPE_ID_PEDIDO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_MATRIZ_PRE_D_PRUEBA_G_PK" ON "M4SLL_MATRIZ_PRE_D_PRUEBA_GABY" ("ID_ORGANIZATION", "MPD_ANIO", "MPD_MES", "MPC_SECUENCIA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_MATRIZ_PRE_PARAM_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_MATRIZ_PRE_PARAM_PK" ON "M4SLL_MATRIZ_PRE_PARAM" ("MPP_ID_ORDEN") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138146
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138146" ON "M4SLL_MEDIO_PAGOS" ("MEP_ID_MEDIO_PAGO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2006221525033
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525033" ON "M4SLL_MODULO_ROL" ("MOR_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905031255481
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905031255481" ON "M4SLL_MT_ABOGADOS" ("MAB_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905031530580
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905031530580" ON "M4SLL_MTO_COD_ALT" ("MCA_ID_CODIGO_ALTERNO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911081214540
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911081214540" ON "M4SLL_MTO_CONCEPTO" ("MCO_ID_CONCEPTO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1908121633200
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1908121633200" ON "M4SLL_MTO_DET_PROV" ("MDP_ID_DET_PROVISION", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1909121232290
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1909121232290" ON "M4SLL_MTO_EMP_ORG" ("STD_ID_LEG_ENT", "ORG_ID", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK2011161141410
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011161141410" ON "M4SLL_MTO_ESTADOS" ("MOR_ESTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1912271205372
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912271205372" ON "M4SLL_MTO_EST_EJE" ("MEE_ID_EST_EJECUCION", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1912271205370
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912271205370" ON "M4SLL_MTO_EST_TARE" ("MET_ID_EST_TAREA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2011160939420
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011160939420" ON "M4SLL_MTO_FUNCION" ("MOR_FUNCION", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907241608520
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907241608520" ON "M4SLL_MTO_MATERIA" ("MMA_ID_MATERIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2006221525032
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525032" ON "M4SLL_MTO_MODULOS" ("MTM_ID_MODULO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905091455510
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905091455510" ON "M4SLL_MTO_PEDIDO_D" ("MPD_ID_PEDIDO_DETALLE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907301130500
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907301130500" ON "M4SLL_MTO_RIESGOS" ("MRI_ID_RIESGO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2006221525037
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525037" ON "M4SLL_MTO_ROL_ACTO" ("MRA_ID_ROL_ACTOR", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2006221525030
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525030" ON "M4SLL_MTO_SEG_INTE" ("ID_APP_ROLE", "MSI_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1912271205371
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912271205371" ON "M4SLL_MTO_TAR_CIE" ("MTC_ID_TAREA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907221131090
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907221131090" ON "M4SLL_MTO_TP_EMPLE" ("MTE_ID_TP_EMPLEADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1909161051300
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1909161051300" ON "M4SLL_MT_ST_RE_PRO" ("MSR_ID_STATUS_REPORTE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1902131322280
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1902131322280" ON "M4SLL_NEGOCIOS" ("NEG_ID_NEGOCIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_NEGOCIOS_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_NEGOCIOS_PRUEBA_GABY_PK" ON "M4SLL_NEGOCIOS_PRUEBA_GABY" ("ID_ORGANIZATION", "NEG_ID_NEGOCIO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1912231250370
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912231250370" ON "M4SLL_NEGOCIOS_ROL" ("NEG_ID_NEGOCIO", "ID_APP_ROLE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231555313
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231555313" ON "M4SLL_PAGOS" ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911131129410
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911131129410" ON "M4SLL_PAGOS_NOM_D" ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "PND_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1910311755372
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1910311755372" ON "M4SLL_PAGOS_NOMINA" ("LIT_ID_LITIGIO", "PNO_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381417
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381417" ON "M4SLL_PAGOS_TRN" ("LIT_ID_LITIGIO", "PAG_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911201027060
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911201027060" ON "M4SLL_PARAMETRICA" ("PAR_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_PARAM_USR_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_PARAM_USR_PK" ON "M4SLL_PARAM_USR" ("USUARIO", "ACCION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138148
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138148" ON "M4SLL_PEDIDO_DET" ("LIT_ID_LITIGIO", "TPE_ID_PEDIDO", "PDE_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index IDX_M4SLL_PEDIDOS_PRINCIPAL
--------------------------------------------------------

  CREATE INDEX "IDX_M4SLL_PEDIDOS_PRINCIPAL" ON "M4SLL_PEDIDOS" ("ID_ORGANIZATION" DESC, "LIT_ID_LITIGIO" DESC, "PED_PRINCIPAL_S_N") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138142
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138142" ON "M4SLL_PEDIDOS" ("TPE_ID_PEDIDO", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index M4SLL_PEDIDOS_PRUEBA_GABY_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "M4SLL_PEDIDOS_PRUEBA_GABY_PK" ON "M4SLL_PEDIDOS_PRUEBA_GABY" ("ID_ORGANIZATION", "LIT_ID_LITIGIO", "TPE_ID_PEDIDO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index IDX_M4SLL_PERSONA_EXT
--------------------------------------------------------

  CREATE INDEX "IDX_M4SLL_PERSONA_EXT" ON "M4SLL_PERSONA_EXT" ("ID_ORGANIZATION" DESC, "PEX_NRO_DOCUMENTO" DESC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138143
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138143" ON "M4SLL_PERSONA_EXT" ("PEX_NRO_DOCUMENTO", "TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1905100932212
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1905100932212" ON "M4SLL_PROV_ABOGADO" ("LIT_ID_LITIGIO", "MAB_SECUENCIA", "PRA_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2006221525034
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525034" ON "M4SLL_ROL_ACT_ROLE" ("MRA_ID_ROL_ACTOR", "ID_APP_ROLE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901091506010
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901091506010" ON "M4SLL_ROL_APROBS" ("ID_APP_ROLE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901091148510
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901091148510" ON "M4SLL_ROLES_USRS" ("ID_APP_ROLE", "TPR_ID_TP_ROL", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907261615320
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907261615320" ON "M4SLL_RP_CB_LITIGI" ("RCL_MES", "RCL_ANIO", "RCL_CARPET_ID", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1912101750530
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912101750530" ON "M4SLL_RP_ES_FICHER" ("REFE", "USUARIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907261552030
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907261552030" ON "M4SLL_RP_ES_LITIGI" ("REL_USUARIO", "REL_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1911201647210
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1911201647210" ON "M4SLL_RP_ES_PROVIS" ("REL_USUARIO", "REL_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1912301210170
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1912301210170" ON "M4SLL_SEGURIDAD" ("ID_APP_ROLE", "SS_SECUENCIAL", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2001151711500
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2001151711500" ON "M4SLL_SEGURIDAD_VI" ("ID_APP_ROLE", "SSV_ID_MODULO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2012141927230
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2012141927230" ON "M4SLL_SGD_CONFIG" ("SGDC_CONTEXT", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381418
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381418" ON "M4SLL_STATUS_PAGOS" ("STP_ID_STATUS_PAGO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1909161051301
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1909161051301" ON "M4SLL_ST_REPO_PROV" ("SSR_PERIODO", "MSR_ID_STATUS_REPORTE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2011091911480
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2011091911480" ON "M4SLL_TOTHONJ" ("TNJ_ANIO", "TNJ_MES", "MAB_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901021404160
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901021404160" ON "M4SLL_TOTPEDHIS" ("LIT_ID_LITIGIO", "TPH_MES", "TPH_ANIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138144
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138144" ON "M4SLL_TP_AUTOR_REU" ("TAR_ID_TP_AUTOR_REU", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231410220
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231410220" ON "M4SLL_TP_COMPROMIS" ("TCO_ID_TP_COMPROMISO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381424
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381424" ON "M4SLL_TP_DOC_LITIG" ("TDL_ID_TP_DOC_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138141
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138141" ON "M4SLL_TP_ENTIDADES" ("TPE_ID_TP_ENTIDAD", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1902071553540
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1902071553540" ON "M4SLL_TP_FALTAS" ("TFL_ID_TP_FALTA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK1812101538050
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101538050" ON "M4SLL_TP_FASES" ("TFA_ID_TP_FASE", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381422
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381422" ON "M4SLL_TP_IDENTIFIC" ("TPI_ID_TP_IDENTIFICACION", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1812101138145
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1812101138145" ON "M4SLL_TP_LITIGIOS" ("TPL_ID_TP_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381416
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381416" ON "M4SLL_TP_MOTIVO" ("TMO_ID_TP_MOTIVO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231555310
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231555310" ON "M4SLL_TP_PAGOS" ("TPA_ID_PAGO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381419
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381419" ON "M4SLL_TP_PEDIDO" ("TPE_ID_PEDIDO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1902071553541
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1902071553541" ON "M4SLL_TP_RECLAMOS" ("TRC_ID_TP_RECLAMO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381415
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381415" ON "M4SLL_TP_RECURREN" ("TRE_ID_RECURRENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1901091148511
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1901091148511" ON "M4SLL_TP_ROLES" ("TPR_ID_TP_ROL", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1907161218340
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1907161218340" ON "M4SLL_TP_SALIDA_PA" ("TSP_ID_SALIDA_PAGO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381410
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381410" ON "M4SLL_TP_STA_DET" ("TSD_ID_TP_STA_DET", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381423
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381423" ON "M4SLL_TP_STATUS" ("TST_ID_TP_STATUS", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK1805231029190
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK1805231029190" ON "M4SLL_TRIBUNALES" ("TRI_ID_TRIBUNAL", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2102051253490
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2102051253490" ON "M4SLL_VAL_EC_LIT" ("VEL_SECUENCIA", "LIT_ID_LITIGIO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK18121011381414
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK18121011381414" ON "M4SLL_VAL_LITIGIOS" ("LIT_ID_LITIGIO", "VAL_SECUENCIA", "TPE_ID_PEDIDO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index VAL_FEC_IDX1
--------------------------------------------------------

  CREATE INDEX "VAL_FEC_IDX1" ON "M4SLL_VAL_LITIGIOS" ("VAL_FECHA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 16384 NEXT 16384 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT);
--------------------------------------------------------
--  DDL for Index PK2006221525031
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525031" ON "M4SLL_WKF_ESTADOS" ("WKE_ID_ESTADO", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK2006221525035
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525035" ON "M4SLL_WKF_ROL_ESTA" ("WKE_ID_ESTADO", "MRA_ID_ROL_ACTOR", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Index PK2006221525036
--------------------------------------------------------

  CREATE UNIQUE INDEX "PK2006221525036" ON "M4SLL_WKF_TAR_ESTA" ("WTE_SECUENCIA", "ID_ORGANIZATION") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS ;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_AUTO_FASE_JUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_AUTO_FASE_JUS" 
        FOR INSERT OR UPDATE OR DELETE ON  M4GLOBAL.M4SLL_LITIGIOS
COMPOUND TRIGGER
/* este triger es utilizado para españa 
su yo ingreso nro aut en el expediente y la fase es juzgado se actualiza el valor FAS_NRO_RADICACION para esta fase (03)
*/
    
    vPASTA          VARCHAR2(10):='';
    vPASTAOLD       VARCHAR2(10):='';
    vIDORG          VARCHAR2(10):='';
    vVALOR          NUMBER(18,2):=0;
    vIDTPEIDPEDIDO  VARCHAR2(10):='';
    vNAUTO          VARCHAR2(100):='';

    BEFORE STATEMENT IS
    BEGIN

        vVALOR:=0;
     END BEFORE STATEMENT;
    -- Se lanzará después de cada fila actualizada
    AFTER EACH ROW IS

    BEGIN    
        IF (INSERTING OR UPDATING)  THEN
            vPASTA := :NEW.LIT_ID_LITIGIO; 
            vIDORG := :NEW.ID_ORGANIZATION;
            vNAUTO := :NEW.LIT_NRO_PROCESO;

        END IF;

    END AFTER EACH ROW;

    -- Se lanzará después de la sentencia

    AFTER STATEMENT IS
     BEGIN

     DBMS_OUTPUT.PUT_LINE('El litigio : ' || vPASTA);
     DBMS_OUTPUT.PUT_LINE('El litigio viejo : ' || vPASTAOLD);
     DBMS_OUTPUT.PUT_LINE('El organizacion : ' || vIDORG);
     DBMS_OUTPUT.PUT_LINE('El número : ' || vVALOR);


    IF (vIDORG = '0001') THEN
       UPDATE M4GLOBAL.M4SLL_FASES SET FAS_NRO_RADICACION=vNAUTO WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG AND TFA_ID_TP_FASE = '003' ;
    END IF;

     END AFTER STATEMENT;

END;

/
ALTER TRIGGER "M4SLL_TG_ACT_AUTO_FASE_JUS" DISABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_DT_FECHAC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_DT_FECHAC" 

BEFORE UPDATE
ON M4GLOBAL.M4SLL_LITIGIOS 

REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN    
        IF (:OLD.ID_ORGANIZATION = '0050') THEN     
            IF (:NEW.TST_ID_TP_STATUS = '2') THEN
                BEGIN                    
                     :NEW.LIT_FECHA_CIERRE := sysdate;
                END;   
            ELSE
                BEGIN                    
                     :NEW.LIT_FECHA_CIERRE := '';
                END;
            END IF;
        END IF;
        null;
    END; 
/
ALTER TRIGGER "M4SLL_TG_ACT_DT_FECHAC" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_DT_TPSTATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_DT_TPSTATUS" 

BEFORE UPDATE
ON M4GLOBAL.M4SLL_LITIGIOS 

REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN    
        IF (:OLD.ID_ORGANIZATION = '0150') THEN     
            IF (:OLD.TST_ID_TP_STATUS <> :NEW.TST_ID_TP_STATUS) THEN
                BEGIN                    
                     :NEW.LIT_DT_ACTUALIZACION := sysdate;
                END;   
            END IF;
        END IF;
        null;
    
    END;

/
ALTER TRIGGER "M4SLL_TG_ACT_DT_TPSTATUS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_ESTADO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_ESTADO" 

BEFORE UPDATE
ON M4GLOBAL.M4SLL_LITIGIOS 

REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
-- Cada vez que el usuario cambia el estado de un litigio se gurdara un registro en la tabla M4SLL_LITIGIOS_HIS 
DECLARE
   V_LIH_SECUENCIA_MAX  M4SLL_LITIGIOS_HIS.LIH_SECUENCIA%TYPE; -- almaceno el maximo valor
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN    
        IF (:OLD.ID_ORGANIZATION = '0050') THEN     
            IF (:OLD.TST_ID_TP_STATUS <> :NEW.TST_ID_TP_STATUS) THEN
                BEGIN               
                SELECT nvl(max(LIH_SECUENCIA),0)+1 INTO V_LIH_SECUENCIA_MAX
                FROM M4SLL_LITIGIOS_HIS WHERE :OLD.LIT_ID_LITIGIO = :NEW.LIT_ID_LITIGIO;
                
		        INSERT INTO M4SLL_LITIGIOS_HIS(ID_ORGANIZATION,LIH_SECUENCIA,LIT_ID_LITIGIO,LIH_COLUM_ALTERADA, LIH_FECHA_ALTERADA, LIH_ID_OLD, LIH_ID_NUEVO,ID_APPROLE,ID_SECUSER,DT_LAST_UPDATE)
			    VALUES(:OLD.ID_ORGANIZATION, V_LIH_SECUENCIA_MAX, :OLD.LIT_ID_LITIGIO, 'TST_ID_TP_STATUS', sysdate, :OLD.TST_ID_TP_STATUS, :NEW.TST_ID_TP_STATUS,'M4ADM','AR00060481',SYSDATE);
                commit;
                END;   
            END IF;
      END IF;
        null;
    END;
/
ALTER TRIGGER "M4SLL_TG_ACT_ESTADO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_LIT_X_FASE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_LIT_X_FASE" 
    FOR UPDATE ON M4GLOBAL.M4SLL_FASES
COMPOUND TRIGGER
    
    vPASTA  VARCHAR2(10):=' ';
    vPASTAOLD  VARCHAR2(10):=' ';
    vIDORG  VARCHAR2(10):=' ';
    vVALOR  VARCHAR2(10):='';
    vIDFASE VARCHAR2(30):='';

    BEFORE STATEMENT IS 
    BEGIN
        vVALOR:=' ';
    END BEFORE STATEMENT;

    AFTER EACH ROW IS 
    BEGIN    
        IF UPDATING  THEN
            vPASTA := :NEW.LIT_ID_LITIGIO; 
            vIDORG := :NEW.ID_ORGANIZATION;
            vIDFASE := :NEW.TFA_ID_TP_FASE;
        ELSIF DELETING THEN
            vPASTA := :OLD.LIT_ID_LITIGIO; 
            vIDORG := :OLD.ID_ORGANIZATION;
            vIDFASE := :OLD.TFA_ID_TP_FASE;
        END IF;

    END AFTER EACH ROW;

    AFTER STATEMENT IS 
    BEGIN

        IF(vIDORG = '0001') THEN

            IF(vIDFASE = '003') THEN
                SELECT FAS_NRO_RADICACION INTO vVALOR FROM M4GLOBAL.M4SLL_FASES WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG AND TFA_ID_TP_FASE = vIDFASE ;
                UPDATE M4GLOBAL.M4SLL_LITIGIOS SET LIT_NRO_PROCESO = vVALOR WHERE LIT_ID_LITIGIO = vPASTA AND ID_ORGANIZATION = vIDORG;
            END IF; 

        END IF; 

    END AFTER STATEMENT;

END;

/
ALTER TRIGGER "M4SLL_TG_ACT_LIT_X_FASE" DISABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACTRGO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACTRGO" 
        FOR INSERT OR UPDATE OR DELETE ON  M4GLOBAL.M4SLL_PEDIDOS
COMPOUND TRIGGER
    
    vPASTA  VARCHAR2(10):=' ';
    vPASTAOLD  VARCHAR2(10):=' ';
    vIDORG  VARCHAR2(10):=' ';
    vVALOR  NUMBER(18,2):=0;
    vIDTPEIDPEDIDO VARCHAR2(10):=' ';

    BEFORE STATEMENT IS
    BEGIN

        vVALOR:=0;
     END BEFORE STATEMENT;

    AFTER EACH ROW IS
    BEGIN    
        IF (INSERTING OR UPDATING)  THEN
            vPASTA := :NEW.LIT_ID_LITIGIO; 
            vIDORG := :NEW.ID_ORGANIZATION;
        ELSIF DELETING THEN
            vPASTA := :OLD.LIT_ID_LITIGIO; 
            vIDORG := :OLD.ID_ORGANIZATION;
        END IF;

    END AFTER EACH ROW;

    AFTER STATEMENT IS
     BEGIN

     IF(vIDORG = '0001') THEN
       SELECT NVL(SUM(PED_VALOR),0) INTO vVALOR FROM M4GLOBAL.M4SLL_PEDIDOS WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG;  

        UPDATE M4GLOBAL.M4SLL_LITIGIOS SET LIT_VALOR_PED_TOTAL=vVALOR WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG;
       END IF; 
     END AFTER STATEMENT;

END; 
/
ALTER TRIGGER "M4SLL_TG_ACTRGO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_M4SLL_INI_PARAM_CALC_PROV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_M4SLL_INI_PARAM_CALC_PROV" 
BEFORE DELETE OR INSERT OR UPDATE
ON M4GLOBAL.M4SLL_INI_PARAM_CALC_PROV 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN

    RAISE_APPLICATION_ERROR(-20099, 'No se pueden modificar los parametros !. Ejecute <alter trigger TRG_M4SLL_INI_PARAM_CALC_PROV disable> y luego <enable>');

END; 

/
ALTER TRIGGER "TRG_M4SLL_INI_PARAM_CALC_PROV" DISABLE;
--------------------------------------------------------
--  DDL for Trigger RJCC_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "RJCC_TRG" 
BEFORE INSERT
ON M4SLL_CCB_RJCC_BKP 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  SELECT AUTO_RJCC.NEXTVAL INTO :NEW.RJC_SECUENCIA FROM DUAL;
END; 

/
ALTER TRIGGER "RJCC_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger RJCD_TRG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "RJCD_TRG" 
BEFORE INSERT
ON M4SLL_CCB_RJCD_BKP 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
  SELECT AUTO_RJCD.NEXTVAL INTO :NEW.RJD_SECUENCIA FROM DUAL;
END; 

/
ALTER TRIGGER "RJCD_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_LIT_X_FASE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_LIT_X_FASE" 
    FOR UPDATE ON M4GLOBAL.M4SLL_FASES
COMPOUND TRIGGER
    
    vPASTA  VARCHAR2(10):=' ';
    vPASTAOLD  VARCHAR2(10):=' ';
    vIDORG  VARCHAR2(10):=' ';
    vVALOR  VARCHAR2(10):='';
    vIDFASE VARCHAR2(30):='';

    BEFORE STATEMENT IS 
    BEGIN
        vVALOR:=' ';
    END BEFORE STATEMENT;

    AFTER EACH ROW IS 
    BEGIN    
        IF UPDATING  THEN
            vPASTA := :NEW.LIT_ID_LITIGIO; 
            vIDORG := :NEW.ID_ORGANIZATION;
            vIDFASE := :NEW.TFA_ID_TP_FASE;
        ELSIF DELETING THEN
            vPASTA := :OLD.LIT_ID_LITIGIO; 
            vIDORG := :OLD.ID_ORGANIZATION;
            vIDFASE := :OLD.TFA_ID_TP_FASE;
        END IF;

    END AFTER EACH ROW;

    AFTER STATEMENT IS 
    BEGIN

        IF(vIDORG = '0001') THEN

            IF(vIDFASE = '003') THEN
                SELECT FAS_NRO_RADICACION INTO vVALOR FROM M4GLOBAL.M4SLL_FASES WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG AND TFA_ID_TP_FASE = vIDFASE ;
                UPDATE M4GLOBAL.M4SLL_LITIGIOS SET LIT_NRO_PROCESO = vVALOR WHERE LIT_ID_LITIGIO = vPASTA AND ID_ORGANIZATION = vIDORG;
            END IF; 

        END IF; 

    END AFTER STATEMENT;

END;

/
ALTER TRIGGER "M4SLL_TG_ACT_LIT_X_FASE" DISABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_M4SLL_INI_PARAM_CALC_PROV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_M4SLL_INI_PARAM_CALC_PROV" 
BEFORE DELETE OR INSERT OR UPDATE
ON M4GLOBAL.M4SLL_INI_PARAM_CALC_PROV 
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN

    RAISE_APPLICATION_ERROR(-20099, 'No se pueden modificar los parametros !. Ejecute <alter trigger TRG_M4SLL_INI_PARAM_CALC_PROV disable> y luego <enable>');

END; 

/
ALTER TRIGGER "TRG_M4SLL_INI_PARAM_CALC_PROV" DISABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_AUTO_FASE_JUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_AUTO_FASE_JUS" 
        FOR INSERT OR UPDATE OR DELETE ON  M4GLOBAL.M4SLL_LITIGIOS
COMPOUND TRIGGER
/* este triger es utilizado para españa 
su yo ingreso nro aut en el expediente y la fase es juzgado se actualiza el valor FAS_NRO_RADICACION para esta fase (03)
*/
    
    vPASTA          VARCHAR2(10):='';
    vPASTAOLD       VARCHAR2(10):='';
    vIDORG          VARCHAR2(10):='';
    vVALOR          NUMBER(18,2):=0;
    vIDTPEIDPEDIDO  VARCHAR2(10):='';
    vNAUTO          VARCHAR2(100):='';

    BEFORE STATEMENT IS
    BEGIN

        vVALOR:=0;
     END BEFORE STATEMENT;
    -- Se lanzará después de cada fila actualizada
    AFTER EACH ROW IS

    BEGIN    
        IF (INSERTING OR UPDATING)  THEN
            vPASTA := :NEW.LIT_ID_LITIGIO; 
            vIDORG := :NEW.ID_ORGANIZATION;
            vNAUTO := :NEW.LIT_NRO_PROCESO;

        END IF;

    END AFTER EACH ROW;

    -- Se lanzará después de la sentencia

    AFTER STATEMENT IS
     BEGIN

     DBMS_OUTPUT.PUT_LINE('El litigio : ' || vPASTA);
     DBMS_OUTPUT.PUT_LINE('El litigio viejo : ' || vPASTAOLD);
     DBMS_OUTPUT.PUT_LINE('El organizacion : ' || vIDORG);
     DBMS_OUTPUT.PUT_LINE('El número : ' || vVALOR);


    IF (vIDORG = '0001') THEN
       UPDATE M4GLOBAL.M4SLL_FASES SET FAS_NRO_RADICACION=vNAUTO WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG AND TFA_ID_TP_FASE = '003' ;
    END IF;

     END AFTER STATEMENT;

END;

/
ALTER TRIGGER "M4SLL_TG_ACT_AUTO_FASE_JUS" DISABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_DT_TPSTATUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_DT_TPSTATUS" 

BEFORE UPDATE
ON M4GLOBAL.M4SLL_LITIGIOS 

REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN    
        IF (:OLD.ID_ORGANIZATION = '0150') THEN     
            IF (:OLD.TST_ID_TP_STATUS <> :NEW.TST_ID_TP_STATUS) THEN
                BEGIN                    
                     :NEW.LIT_DT_ACTUALIZACION := sysdate;
                END;   
            END IF;
        END IF;
        null;
    
    END;

/
ALTER TRIGGER "M4SLL_TG_ACT_DT_TPSTATUS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_DT_FECHAC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_DT_FECHAC" 

BEFORE UPDATE
ON M4GLOBAL.M4SLL_LITIGIOS 

REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
DECLARE
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN    
        IF (:OLD.ID_ORGANIZATION = '0050') THEN     
            IF (:NEW.TST_ID_TP_STATUS = '2') THEN
                BEGIN                    
                     :NEW.LIT_FECHA_CIERRE := sysdate;
                END;   
            ELSE
                BEGIN                    
                     :NEW.LIT_FECHA_CIERRE := '';
                END;
            END IF;
        END IF;
        null;
    END; 
/
ALTER TRIGGER "M4SLL_TG_ACT_DT_FECHAC" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACT_ESTADO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACT_ESTADO" 

BEFORE UPDATE
ON M4GLOBAL.M4SLL_LITIGIOS 

REFERENCING NEW AS NEW OLD AS OLD 
FOR EACH ROW
-- Cada vez que el usuario cambia el estado de un litigio se gurdara un registro en la tabla M4SLL_LITIGIOS_HIS 
DECLARE
   V_LIH_SECUENCIA_MAX  M4SLL_LITIGIOS_HIS.LIH_SECUENCIA%TYPE; -- almaceno el maximo valor
   PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN    
        IF (:OLD.ID_ORGANIZATION = '0050') THEN     
            IF (:OLD.TST_ID_TP_STATUS <> :NEW.TST_ID_TP_STATUS) THEN
                BEGIN               
                SELECT nvl(max(LIH_SECUENCIA),0)+1 INTO V_LIH_SECUENCIA_MAX
                FROM M4SLL_LITIGIOS_HIS WHERE :OLD.LIT_ID_LITIGIO = :NEW.LIT_ID_LITIGIO;
                
		        INSERT INTO M4SLL_LITIGIOS_HIS(ID_ORGANIZATION,LIH_SECUENCIA,LIT_ID_LITIGIO,LIH_COLUM_ALTERADA, LIH_FECHA_ALTERADA, LIH_ID_OLD, LIH_ID_NUEVO,ID_APPROLE,ID_SECUSER,DT_LAST_UPDATE)
			    VALUES(:OLD.ID_ORGANIZATION, V_LIH_SECUENCIA_MAX, :OLD.LIT_ID_LITIGIO, 'TST_ID_TP_STATUS', sysdate, :OLD.TST_ID_TP_STATUS, :NEW.TST_ID_TP_STATUS,'M4ADM','AR00060481',SYSDATE);
                commit;
                END;   
            END IF;
      END IF;
        null;
    END;
/
ALTER TRIGGER "M4SLL_TG_ACT_ESTADO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger M4SLL_TG_ACTRGO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "M4SLL_TG_ACTRGO" 
        FOR INSERT OR UPDATE OR DELETE ON  M4GLOBAL.M4SLL_PEDIDOS
COMPOUND TRIGGER
    
    vPASTA  VARCHAR2(10):=' ';
    vPASTAOLD  VARCHAR2(10):=' ';
    vIDORG  VARCHAR2(10):=' ';
    vVALOR  NUMBER(18,2):=0;
    vIDTPEIDPEDIDO VARCHAR2(10):=' ';

    BEFORE STATEMENT IS
    BEGIN

        vVALOR:=0;
     END BEFORE STATEMENT;

    AFTER EACH ROW IS
    BEGIN    
        IF (INSERTING OR UPDATING)  THEN
            vPASTA := :NEW.LIT_ID_LITIGIO; 
            vIDORG := :NEW.ID_ORGANIZATION;
        ELSIF DELETING THEN
            vPASTA := :OLD.LIT_ID_LITIGIO; 
            vIDORG := :OLD.ID_ORGANIZATION;
        END IF;

    END AFTER EACH ROW;

    AFTER STATEMENT IS
     BEGIN

     IF(vIDORG = '0001') THEN
       SELECT NVL(SUM(PED_VALOR),0) INTO vVALOR FROM M4GLOBAL.M4SLL_PEDIDOS WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG;  

        UPDATE M4GLOBAL.M4SLL_LITIGIOS SET LIT_VALOR_PED_TOTAL=vVALOR WHERE LIT_ID_LITIGIO=vPASTA AND ID_ORGANIZATION=vIDORG;
       END IF; 
     END AFTER STATEMENT;

END; 
/
ALTER TRIGGER "M4SLL_TG_ACTRGO" ENABLE;
CREATE MATERIALIZED VIEW LOG ON "M4SLL_ESP_CIUDADES"
 PCTFREE 10 PCTUSED 30 INITRANS 1 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  WITH ROWID EXCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON "M4SLL_LITIGIOS"
 PCTFREE 10 PCTUSED 30 INITRANS 1 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  WITH PRIMARY KEY, ROWID ( "ECI_ID_CIUDAD" ) EXCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON "STD_LEG_ENT"
 PCTFREE 10 PCTUSED 30 INITRANS 1 MAXTRANS 255 LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  WITH PRIMARY KEY, ROWID EXCLUDING NEW VALUES;
--------------------------------------------------------
--  DDL for Procedure M4SLL_CCB_RJCC_SP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "M4SLL_CCB_RJCC_SP" IS

/*
    INSERCION DE REGISTROS EN LA TABLA ESPEJO CON REGISTROS ACTUALIZADOS POR EL ROBOT
    ESPEJO: M4SLL_CCB_RJCC_BKP  ----
    ROBOT:  M4SLL_CCB_RAMAJUDC  ---- CABECERA
    
    EL ESPEJO ACTIVA LA SEQUENCE AUTO_RJCC A TRAVÉS DEL TRIGGER RJCC_TRG
    
    
    AM. 290120
*/


BEGIN
        INSERT INTO M4SLL_CCB_RJCC_BKP
            (ID_ORGANIZATION, LIT_ID_LITIGIO, FAS_NRO_RADICACION, RJC_DESPACHO, 
            RJC_PONENTE, RJC_TIPO, RJC_CLASE, RJC_RECURSO, 
            RJC_UBICACION_EXPEDIENTE, RJC_DEMANDANTE, RJC_DEMANDADO, RJC_CONTENIDO,
            ID_APPROLE,ID_SECUSER, DT_LAST_UPDATE)
        SELECT B.ID_ORGANIZATION, B.LIT_ID_LITIGIO, B.FAS_NRO_RADICACION, B.RJC_DESPACHO, 
            B.RJC_PONENTE, B.RJC_TIPO, B.RJC_CLASE, B.RJC_RECURSO, 
            B.RJC_UBICACION_EXPEDIENTE, B.RJC_DEMANDANTE, B.RJC_DEMANDADO, B.RJC_CONTENIDO,
            B.ID_APPROLE, B.ID_SECUSER, B.DT_LAST_UPDATE 
        FROM M4SLL_CCB_RJCC_BKP A RIGHT JOIN M4SLL_CCB_RAMAJUDC B 
        ON     A.FAS_NRO_RADICACION = B.FAS_NRO_RADICACION AND 
               A.LIT_ID_LITIGIO=  B.LIT_ID_LITIGIO
        WHERE  A.FAS_NRO_RADICACION     IS NULL AND
               A.LIT_ID_LITIGIO         IS NULL; 
               
               
        COMMIT;       
           
   
END; 

/
--------------------------------------------------------
--  DDL for Procedure M4SLL_CCB_RJCD_SP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "M4SLL_CCB_RJCD_SP" 
IS
/*
    INSERCION DE REGISTROS EN LA TABLA ESPEJO CON REGISTROS ACTUALIZADOS POR EL ROBOT
    ESPEJO: M4SLL_CCB_RJCD_BKP
    ROBOT:  M4SLL_CCB_RAMAJUDD

    EL ESPEJO ACTIVA LA SEQUENCE AUTO_RJCD A TRAVÉS DEL TRIGGER RJCD_TRG
    LOS NVL EFECTIVIZA LA COMPARACION CUANDO EL CAMPO ES NULL

    AM. 290120
*/
BEGIN
   INSERT INTO m4sll_ccb_rjcd_bkp
               (id_organization, lit_id_litigio, fas_nro_radicacion,
                rjd_dt_actualizacion, rjd_actuacion, rjd_anotacion,
                rjd_dt_inicio_termino, rjd_dt_fin_termino, rjd_dt_registro,
                id_approle, id_secuser, dt_last_update)
     SELECT b.id_organization, b.lit_id_litigio, b.fas_nro_radicacion,
             b.rjd_dt_actualizacion, b.rjd_actuacion, b.rjd_anotacion,
             b.rjd_dt_inicio_termino, b.rjd_dt_fin_termino,
             b.rjd_dt_registro, b.id_approle, b.id_secuser, b.dt_last_update
        FROM m4sll_ccb_rjcd_bkp a RIGHT JOIN m4sll_ccb_ramajudd b
             ON a.fas_nro_radicacion = b.fas_nro_radicacion
           AND a.lit_id_litigio = b.lit_id_litigio
                      AND NVL (TO_CHAR (a.rjd_dt_actualizacion, 'DD/MM/YYYY'), TO_CHAR(SYSDATE, 'DD/MM/YYYY')) =
                  NVL (TO_CHAR (b.rjd_dt_actualizacion, 'DD/MM/YYYY'),
                       TO_CHAR (SYSDATE, 'DD/MM/YYYY'))
           AND NVL (a.rjd_actuacion, 'X') = NVL (b.rjd_actuacion, 'X')
           AND NVL (a.rjd_anotacion, 'X') = NVL (b.rjd_anotacion, 'X')
       WHERE a.fas_nro_radicacion IS NULL
         AND a.lit_id_litigio IS NULL
         AND a.rjd_dt_actualizacion IS NULL
         AND a.rjd_actuacion IS NULL
         AND a.rjd_anotacion IS NULL;

   COMMIT;
End; 

/
--------------------------------------------------------
--  DDL for Procedure M4SLL_SP_JOB
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "M4SLL_SP_JOB" (
        p_user         IN   VARCHAR2,
        p_accion       IN   VARCHAR2,
        p_json_param   IN   CLOB,
        p_pagina       IN   VARCHAR2
         
)
IS

-- RECORDAR 
/*
    ACTIVA JOB PARA EJECUCION DEL CIERRE MENSUAL
    EL JOB SE EJECUTA DOS MINUTOS DESPUES DE SER INVOCADO
    1 HORA = 1/24
    1 MIN  = 1/ (24*60)
    1 SEG  = 1/ (24*60*60) 
*/
    ARG_PS_NULO VARCHAR2(200) := NULL;

vMOMENTO VARCHAR2(50):='';
X        NUMBER;   

    BEGIN


      vMOMENTO := TO_CHAR(SYSDATE + (1/(24*60*60)) * 2, 'mm/dd/yyyy hh24:mi:ss' );



      SYS.DBMS_JOB.SUBMIT
        (
          job        => X
          ,what       => 'M4PKG_SLL_ES_USES.EXEC_DYNAMIC('''||P_USER||''','''||P_ACCION||''','''||P_JSON_PARAM||''','''||P_PAGINA||''');'
          --,what       => 'A_PRUEBA_INTERT();'
          
         ,next_date  => to_date(vMOMENTO,'mm/dd/yyyy hh24:mi:ss')
         ,no_parse   => FALSE
        );

    DBMS_OUTPUT.PUT_LINE(X);
    
    END M4SLL_SP_JOB;

/
--------------------------------------------------------
--  DDL for Package JSON_DYN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_DYN" authid current_user as
 /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  null_as_empty_string   boolean not null := true;  --varchar2
  include_dates          boolean not null := true;  --date
  include_clobs          boolean not null := true;
  include_blobs          boolean not null := false;

  /* list with objects */
  function executeList(stmt varchar2, bindvar json default null, cur_num number default null) return json_list;

  /* object with lists */
  function executeObject(stmt varchar2, bindvar json default null, cur_num number default null) return json;


  /* usage example:
   * declare
   *   res json_list;
   * begin
   *   res := json_dyn.executeList(
   *            'select :bindme as one, :lala as two from dual where dummy in :arraybind',
   *            json('{bindme:"4", lala:123, arraybind:[1,2,3,"X"]}')
   *          );
   *   res.print;
   * end;
   */

/* --11g functions
  function executeList(stmt in out sys_refcursor) return json_list;
  function executeObject(stmt in out sys_refcursor) return json;
*/
end json_dyn;


/
--------------------------------------------------------
--  DDL for Package JSON_EXT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_EXT" as
  /*
  Copyright (c) 2009 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  /* This package contains extra methods to lookup types and
     an easy way of adding date values in json - without changing the structure */
  function parsePath(json_path varchar2, base number default 1) return json_list;

  --JSON Path getters
  function get_json_value(obj json, v_path varchar2, base number default 1) return json_value;
  function get_string(obj json, path varchar2,       base number default 1) return varchar2;
  function get_number(obj json, path varchar2,       base number default 1) return number;
  function get_json(obj json, path varchar2,         base number default 1) return json;
  function get_json_list(obj json, path varchar2,    base number default 1) return json_list;
  function get_bool(obj json, path varchar2,         base number default 1) return boolean;

  --JSON Path putters
  procedure put(obj in out nocopy json, path varchar2, elem varchar2,   base number default 1);
  procedure put(obj in out nocopy json, path varchar2, elem number,     base number default 1);
  procedure put(obj in out nocopy json, path varchar2, elem json,       base number default 1);
  procedure put(obj in out nocopy json, path varchar2, elem json_list,  base number default 1);
  procedure put(obj in out nocopy json, path varchar2, elem boolean,    base number default 1);
  procedure put(obj in out nocopy json, path varchar2, elem json_value, base number default 1);

  procedure remove(obj in out nocopy json, path varchar2, base number default 1);

  --Pretty print with JSON Path - obsolete in 0.9.4 - obj.path(v_path).(to_char,print,htp)
  function pp(obj json, v_path varchar2) return varchar2; 
  procedure pp(obj json, v_path varchar2); --using dbms_output.put_line
  procedure pp_htp(obj json, v_path varchar2); --using htp.print

  --extra function checks if number has no fraction
  function is_integer(v json_value) return boolean;

  format_string varchar2(30 char) := 'yyyy-mm-dd hh24:mi:ss';
  --extension enables json to store dates without comprimising the implementation
  function to_json_value(d date) return json_value;
  --notice that a date type in json is also a varchar2
  function is_date(v json_value) return boolean;
  --convertion is needed to extract dates 
  --(json_ext.to_date will not work along with the normal to_date function - any fix will be appreciated)
  function to_date2(v json_value) return date;
  --JSON Path with date
  function get_date(obj json, path varchar2, base number default 1) return date;
  procedure put(obj in out nocopy json, path varchar2, elem date, base number default 1);

  --experimental support of binary data with base64
  function base64(binarydata blob) return json_list;
  function base64(l json_list) return blob;

  function encode(binarydata blob) return json_value;
  function decode(v json_value) return blob;

end json_ext;

/
--------------------------------------------------------
--  DDL for Package JSON_HELPER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_HELPER" as
  /* Example:
  set serveroutput on;
  declare
    v_a json;
    v_b json;
  begin
    v_a := json('{a:1, b:{a:null}, e:false}');
    v_b := json('{c:3, e:{}, b:{b:2}}');
    json_helper.merge(v_a, v_b).print(false);
  end;
  --
  {"a":1,"b":{"a":null,"b":2},"e":{},"c":3}
  */
  -- Recursive merge
  -- Courtesy of Matt Nolan - edited by Jonas Krogsb¿ll
  function merge( p_a_json json, p_b_json json) return json;

  -- Join two lists
  -- json_helper.join(json_list('[1,2,3]'),json_list('[4,5,6]')) -> [1,2,3,4,5,6] 
  function join( p_a_list json_list, p_b_list json_list) return json_list;

  -- keep only specific keys in json object
  -- json_helper.keep(json('{a:1,b:2,c:3,d:4,e:5,f:6}'),json_list('["a","f","c"]')) -> {"a":1,"f":6,"c":3}
  function keep( p_json json, p_keys json_list) return json;

  -- remove specific keys in json object
  -- json_helper.remove(json('{a:1,b:2,c:3,d:4,e:5,f:6}'),json_list('["a","f","c"]')) -> {"b":2,"d":4,"e":5}
  function remove( p_json json, p_keys json_list) return json;

  --equals
  function equals(p_v1 json_value, p_v2 json_value, exact boolean default true) return boolean;
  function equals(p_v1 json_value, p_v2 json, exact boolean default true) return boolean;
  function equals(p_v1 json_value, p_v2 json_list, exact boolean default true) return boolean;
  function equals(p_v1 json_value, p_v2 number) return boolean;
  function equals(p_v1 json_value, p_v2 varchar2) return boolean;
  function equals(p_v1 json_value, p_v2 boolean) return boolean; 
  function equals(p_v1 json_value, p_v2 clob) return boolean;
  function equals(p_v1 json, p_v2 json, exact boolean default true) return boolean;
  function equals(p_v1 json_list, p_v2 json_list, exact boolean default true) return boolean;

  --contains json, json_value
  --contains json_list, json_value
  function contains(p_v1 json, p_v2 json_value, exact boolean default false) return boolean;
  function contains(p_v1 json, p_v2 json, exact boolean default false) return boolean;
  function contains(p_v1 json, p_v2 json_list, exact boolean default false) return boolean;
  function contains(p_v1 json, p_v2 number, exact boolean default false) return boolean;
  function contains(p_v1 json, p_v2 varchar2, exact boolean default false) return boolean;
  function contains(p_v1 json, p_v2 boolean, exact boolean default false) return boolean;
  function contains(p_v1 json, p_v2 clob, exact boolean default false) return boolean;

  function contains(p_v1 json_list, p_v2 json_value, exact boolean default false) return boolean;
  function contains(p_v1 json_list, p_v2 json, exact boolean default false) return boolean;
  function contains(p_v1 json_list, p_v2 json_list, exact boolean default false) return boolean;
  function contains(p_v1 json_list, p_v2 number, exact boolean default false) return boolean;
  function contains(p_v1 json_list, p_v2 varchar2, exact boolean default false) return boolean;
  function contains(p_v1 json_list, p_v2 boolean, exact boolean default false) return boolean;
  function contains(p_v1 json_list, p_v2 clob, exact boolean default false) return boolean;

end json_helper;

/
--------------------------------------------------------
--  DDL for Package JSON_ML
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_ML" as
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  /* This package contains extra methods to lookup types and
     an easy way of adding date values in json - without changing the structure */

  jsonml_stylesheet xmltype := null;

  function xml2json(xml in xmltype) return json_list;
  function xmlstr2json(xmlstr in varchar2) return json_list;

end json_ml;

/
--------------------------------------------------------
--  DDL for Package JSON_PARSER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_PARSER" as
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */
  /* scanner tokens:
    '{', '}', ',', ':', '[', ']', STRING, NUMBER, TRUE, FALSE, NULL 
  */
  type rToken IS RECORD (
    type_name VARCHAR2(7),
    line PLS_INTEGER,
    col PLS_INTEGER,
    data VARCHAR2(32767),
    data_overflow clob); -- max_string_size

  type lTokens is table of rToken index by pls_integer;
  type json_src is record (len number, offset number, src varchar2(32767), s_clob clob); 

  json_strict boolean not null := false;

  function next_char(indx number, s in out nocopy json_src) return varchar2;
  function next_char2(indx number, s in out nocopy json_src, amount number default 1) return varchar2;

  function prepareClob(buf in clob) return json_parser.json_src;
  function prepareVarchar2(buf in varchar2) return json_parser.json_src;
  function lexer(jsrc in out nocopy json_src) return lTokens;
  procedure print_token(t rToken);

  function parser(str varchar2) return json;
  function parse_list(str varchar2) return json_list;
  function parse_any(str varchar2) return json_value;
  function parser(str clob) return json;
  function parse_list(str clob) return json_list;
  function parse_any(str clob) return json_value;
  procedure remove_duplicates(obj in out nocopy json);
  function get_version return varchar2;

end json_parser;

/
--------------------------------------------------------
--  DDL for Package JSON_PRINTER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_PRINTER" as
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */
  indent_string varchar2(10 char) := '  '; --chr(9); for tab
  newline_char varchar2(2 char)   := chr(13)||chr(10); -- Windows style
  --newline_char varchar2(2) := chr(10); -- Mac style
  --newline_char varchar2(2) := chr(13); -- Linux style
  ascii_output boolean    not null := true;
  escape_solidus boolean  not null := false;

  function pretty_print(obj json, spaces boolean default true, line_length number default 0) return varchar2;
  function pretty_print_list(obj json_list, spaces boolean default true, line_length number default 0) return varchar2;
  function pretty_print_any(json_part json_value, spaces boolean default true, line_length number default 0) return varchar2;
  procedure pretty_print(obj json, spaces boolean default true, buf in out nocopy clob, line_length number default 0, erase_clob boolean default true);
  procedure pretty_print_list(obj json_list, spaces boolean default true, buf in out nocopy clob, line_length number default 0, erase_clob boolean default true);
  procedure pretty_print_any(json_part json_value, spaces boolean default true, buf in out nocopy clob, line_length number default 0, erase_clob boolean default true);

  procedure dbms_output_clob(my_clob clob, delim varchar2, jsonp varchar2 default null);
  procedure htp_output_clob(my_clob clob, jsonp varchar2 default null);
end json_printer;


/
--------------------------------------------------------
--  DDL for Package JSON_UTIL_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_UTIL_PKG" authid current_user as

  /*

  Purpose:    JSON utilities for PL/SQL
  see http://ora-00001.blogspot.com/

  Remarks:    

  Who     Date        Description
  ------  ----------  -------------------------------------
  MBR     30.01.2010  Created
  JKR     01.05.2010  Edited to fit in PL/JSON
  JKR     19.01.2011  Newest stylesheet + bugfix handling

  */

  -- generate JSON from REF Cursor
  function ref_cursor_to_json (p_ref_cursor in sys_refcursor,
                               p_max_rows in number := null,
                               p_skip_rows in number := null) return json_list;

  -- generate JSON from SQL statement
  function sql_to_json (p_sql in varchar2,
                        p_max_rows in number := null,
                        p_skip_rows in number := null) return json_list;


end json_util_pkg;

/
--------------------------------------------------------
--  DDL for Package JSON_XML
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "JSON_XML" as 
  /*
  Copyright (c) 2010 Jonas Krogsboell

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  */

  /*
  declare
    obj json := json('{a:1,b:[2,3,4],c:true}');
    x xmltype;
  begin
    obj.print;
    x := json_xml.json_to_xml(obj);
    dbms_output.put_line(x.getclobval());
  end;  
  */

  function json_to_xml(obj json, tagname varchar2 default 'root') return xmltype;

end json_xml;

/
--------------------------------------------------------
--  DDL for Package M4PASE_CLIENTE_VCM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PASE_CLIENTE_VCM" AS
/******************************************************************************
   NAME:       M4PASE_CLIENTE_VCM
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        25/07/2013            1. Created this package.

   TYPES
    v_horas;
    regList;

   FUNCTIONS 
   ------------------------------------
   1- FUNCTION fn_get_emp_aurus

   PROCEDURES
   -------------------------------------
   2- PROCEDURE pr_registra_log_pasecli_2
    
******************************************************************************/

 TYPE v_horas IS VARRAY(17) OF NUMBER;
 TYPE regList IS RECORD(
                v_c_menu_m4_pasecli                         VARCHAR2(100),
                v_c_presentacion_m4_pasecli                 VARCHAR2(100),
                v_c_objeto_m4_pasecli                       VARCHAR2(100),      
                v_c_nroleg                                  VARCHAR2(9),  
                v_c_pais                                    VARCHAR2(9),
                v_c_emp                                     VARCHAR2(4),
                v_c_emp_aurus                               VARCHAR2(10),
                v_c_asiento                                 VARCHAR2(6),
                v_n_antnroliq                               NUMBER,
                v_d_fecha_desde                             DATE,
                v_d_fecha_hasta                             DATE,   
                v_d_fdesde                                  DATE,
                v_d_fhasta                                  DATE,
                v_c_tiporeg                                 VARCHAR2(30), 
                v_c_upreg                                   VARCHAR2(30),
                v_n_tipo                                    NUMBER,                                
                v_d_newmes                                  NUMBER, 
                v_d_newanio                                 NUMBER,                  
                v_d_upmes                                   NUMBER, 
                v_d_upanio                                  NUMBER,
                v_d_mes                                     NUMBER, 
                v_d_anio                                    NUMBER,
                v_c_itera                                   NUMBER,
                v_n_ultsem                                  NUMBER,
                k_n_ultima_semana                           NUMBER := 1,
                k_c_control_itera                           VARCHAR(100):='NO_ITERA',
                v_horas_vcm                                 v_horas                   
                );
  rList regList;
                                             

  FUNCTION fn_get_emp_aurus(pemp std_leg_ent.std_id_leg_ent%type,
                            ppais std_leg_ent.id_organization%type) 
                                 RETURN m4cco_int_paseccte.emp%type;                    
  PROCEDURE m4pe_importa_hs_pasecli(
   p_c_menu_m4_pasecli           IN   VARCHAR2,
   p_c_presentacion_m4_pasecli   IN   VARCHAR2,
   p_c_objeto_m4_pasecli         IN   VARCHAR2,      
   p_c_pais                      IN   VARCHAR2,
   p_c_emp                       IN   VARCHAR2,
   p_c_emp_aurus                 IN   NUMBER,
   p_c_asiento                   IN   VARCHAR2,
   p_d_fecha_desde               IN   DATE,
   p_d_fecha_hasta               IN   DATE,   
   p_d_mes                       IN   NUMBER, 
   p_d_anio                      IN   NUMBER,                  
   p_num_ultsem                    IN   NUMBER,
   p_c_id_approle                IN   VARCHAR2,  -- agregar al objeto  y sacar fecha desde y hasta horas extras
   p_c_id_secuser                IN   VARCHAR2);
   

  PROCEDURE pr_registra_log_pasecli_2 (registro IN m4cco_log_vcm%ROWTYPE);        


END M4PASE_CLIENTE_VCM; 

/
--------------------------------------------------------
--  DDL for Package M4PGK_CDE_SEG_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PGK_CDE_SEG_PKG" AS 
/*
Creado Por Noel Zambrano
paquete creado para manejo de roles y permisos en la app CDE

Fecha Creacion: 15/01/2020
Fecha Modificacion:
Ultima modificacion:
*/

type roles_array is table of m4rsc_approle%rowtype ;
--TYPE id_roles_array IS TABLE OF VARCHAR(30) index by binary_integer;
TYPE id_roles_array IS TABLE OF VARCHAR2(30) ;
-- TYPE arr_type is TABLE of VARCHAR2(11 BYTE); 
TYPE NUM_ARRAY IS TABLE OF NUMBER;
-- TYPE roles_array2 IS TABLE OF m4rsc_approle.%TYPE NOT NULL;
    /*Devuelve si el usuario tiene el rol dado
    */
    FUNCTION tiene_rol (
        p_user         IN   VARCHAR2,
        P_ROLE         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN BOOLEAN;

     /*Devuelve los roles de un usuario
    */
    FUNCTION obtener_roles_usuario (
        p_user         IN   VARCHAR2,        
        p_json_param   IN   VARCHAR2
    ) RETURN id_roles_array;

    /*Devuelve true si el usuario tiene un rol asignado para mover la fase
    */
    FUNCTION tiene_rol_mov_fase (
        p_user         IN   VARCHAR2,
        P_MFA_ID_FASE  IN VARCHAR2,
        P_MTI_ID_IDIOMA IN VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN BOOLEAN;


    /*Devuelve si el usuario tiene un permiso asignado 
    a implementar cuando se use la tabla de permisos
    */
    FUNCTION tiene_permiso (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN BOOLEAN;


     /*
     Devuelve un where en caso de que el rol que se pase tenga
     */
    FUNCTION OBTENER_SQL_ROL (
        P_ROL          IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION OBTENER_FASES_X_USUARIO (
        P_USER             IN   VARCHAR2,
        P_DEN_ID_DENUNCIA  IN  VARCHAR2,
        P_MTI_ID_IDIOMA    IN VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION CAMBIAR_FASE(
        P_USER              IN   VARCHAR2,
        P_DEN_ID_DENUNCIA   IN   VARCHAR2,
        P_MFA_ID_FASE       IN   VARCHAR2,
        P_MTI_ID_IDIOMA     IN   VARCHAR2,
        P_STD_ID_PERSON     IN   VARCHAR2,
        p_json_param        IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION obtener_seguridad_interna(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_ID_USER IN VARCHAR2 --Id User
    ) RETURN VARCHAR2;

    FUNCTION get_seguridad_reporte(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_ID_USER IN VARCHAR2 --Id User
    ) RETURN VARCHAR2;


END m4pgk_cde_seg_pkg;


/
--------------------------------------------------------
--  DDL for Package M4PGK_SCJ_SEG_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PGK_SCJ_SEG_PKG" AS 
/*
Creado Por Noel Zambrano
paquete creado para manejo de roles y permisos en la app SCJ

Fecha Creacion: 26/03/2020
Fecha Modificacion:
Ultima modificacion:
*/

type roles_array is table of m4rsc_approle%rowtype ;
--TYPE id_roles_array IS TABLE OF VARCHAR(30) index by binary_integer;
TYPE id_roles_array IS TABLE OF VARCHAR2(30) ;
-- TYPE arr_type is TABLE of VARCHAR2(11 BYTE); 
TYPE NUM_ARRAY IS TABLE OF NUMBER;
-- TYPE roles_array2 IS TABLE OF m4rsc_approle.%TYPE NOT NULL;
    /*Devuelve si el usuario tiene el rol dado
    */

    FUNCTION obtener_seguridad_interna(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_ID_USER IN VARCHAR2 --Id User
    ) RETURN VARCHAR2;


END m4pgk_scj_seg_pkg; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_ARMADO_JORNADAS_CL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_ARMADO_JORNADAS_CL" as 

    K_CHILE    varchar2(4) := '0110';



     K_OK integer  := 1;
    K_ERROR integer := 0;
    cnterrores number := 0;
    K_FALSE integer := 0;
    K_COMMITS number := 1000;
    k_fin_jornada integer := -1;


    K_EST_ERROR M4CCL_HS_FICH_HIST.CCL_ESTADO%type := 'E';
    K_EST_LEIDO M4CCL_HS_FICH_HIST.CCL_ESTADO%type := 'L';


    K_MODULE varchar2(20) := 'ARMADOJORNADA_CL';

    k_mk_I varchar2(1) :=  'I'; --- primer entrada
    k_mk_0 varchar2(1) :=  '0'; --- entrada sector interna
    k_mk_1 varchar2(1) :=  '1'; --- salida sector interna
    k_mk_O varchar2(1) :=  'O'; --- salida definitiva
    

    

    g_cntcommits number ;
    msgerr clob;
    G_ID_ORGANIZATION varchar2(4) := K_CHILE;
    G_STD_ID_HR varchar2(10);
    g_mk_error varchar2(4000);
    
    
    PROCEDURE MAIN_ARMADO(p_fdesde date, p_fhasta date, p_emp varchar2, p_grp varchar2, p_idhr varchar2);
    
end M4PKG_ARMADO_JORNADAS_CL;

/
--------------------------------------------------------
--  DDL for Package M4PKG_ARMA_JORN_BR_J
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_ARMA_JORN_BR_J" 
as   

    /*--- 
        07/08/2017 ACV
        se agrega consideraciones sobre el campo aprobado
        el campo aprobado es sobre las fichadas ingresadas manualmente. o sea con el campo ajustdo = 1
        estas pueden tener en el campo aprobado los valores: 
                null (para fichadas de origen reloj), 
                'P': pendiente de aprobacion (default fichadas manuelaes)
                'N': no se aprobo por superior
                'S': fichada  aprobada por superior
    
        solo se tomaran fichadas de origen  todos  campos de validacoon en 0 y  ajustes (1) aprobados  ('S')   
    ---*/
    K_APROBADO      M4CBR_GT_MARCACION.CCO_APROBADO%type := 'S';
    K_SIN_APROBAR   M4CBR_GT_MARCACION.CCO_APROBADO%type := 'N';
    K_PEND_APROB    M4CBR_GT_MARCACION.CCO_APROBADO%type := 'P';
    
    
    /*
       ARMADO DE JORNADAS INFORMADAS POR FORPONTO
       ACV 31/12/2016
       ACV 31/08/2017 se agrego parametro p_idhr
    */
    cursor c_horas(p_idorg varchar2, p_fchd date, p_fchh date, p_idhr varchar2, PID_PROCESO VARCHAR2) is select /*+parallel (m,4)*/ *  FROM M4CBR_GT_MARCACION  m
                        WHERE  m.ID_ORGANIZATION = p_idorg and m.dt_fecha between p_fchd and p_fchh + 1
                            and m.cbr_ck_descarta = 0
                            --and m.CBR_CK_AJUSTADO = 0
                            and ((m.cbr_ck_validado = 0 and m.CCO_APROBADO is null)
                                 or   
                                (m.cbr_ck_validado = 0 and m.CCO_APROBADO  = K_APROBADO))
                            and ((m.std_id_hr = p_idhr and p_idhr is not null)
                                        or  (m.std_id_hr is not null and p_idhr is null))    
                                --and m.STD_ID_HR = '609002'
--                            AND M.STD_ID_HR='121123'
-- LG 08/03/18 NO TOMO EN CUENTA LAS FICHADAS CON JORNADA MANUAL
                            AND (NOT EXISTS (SELECT 1 
                                               FROM M4CBR_GT_MARCA_MAN X 
                                              WHERE X.ID_ORGANIZATION=M.ID_ORGANIZATION
                                                AND X.STD_ID_HR=M.STD_ID_HR
                                                AND X.DT_FECHA=M.DT_FECHA
                                                AND X.DT_HORA=M.DT_HORA
                                                AND X.CCO_CK_MANUAL='S'))
                            AND  EXISTS
                            (   
                                SELECT 1  FROM M4CCO_VW_GT_HT_HR_CAL C/*M4CCO_GT_HT_HR_CAL G LAUTARO 26/05/16*/ , M4CCO_GT_HR_PROCES p
                                            WHERE C.CCO_ID_PROCESO=PID_PROCESO 
                                                  AND C.ID_ORGANIZATION= M.ID_ORGANIZATION
                                                  AND C.STD_ID_HR = M.STD_ID_HR
                                                  AND C.ID_ORGANIZATION = P.ID_ORGANIZATION
                                                  and  C.std_id_hr =  P.std_id_hr 
                                                   and C.cco_id_proceso = P.CCO_ID_PROCESO
                            )
                            order by std_id_hr, dt_fecha, dt_hora;



                                
                                

    /*--- como  buscar empresa  apra legajos de acuerdo al periodo  indicado.---*/
    /*select * from std_hr_period p, M4SCO_H_HR_LEGENT l 
        where p.id_organization = '0130' 
    and p.id_organization = l.id_organization 
    and p.std_id_hr = l.STD_ID_HR
    and p.STD_OR_HR_PERIOD = l.STD_OR_HR_PERIOD
    and (l.DT_START between   to_date('01/01/2016','dd/mm/yyyy')  and to_date('31/01/2016','dd/mm/yyyy')
    or l.dt_end between to_date('01/01/2016','dd/mm/yyyy')  and to_date('31/01/2016','dd/mm/yyyy')
    or l.dt_start  <= to_date('01/01/2016','dd/mm/yyyy')  
    or dt_end >=  to_date('31/01/2016','dd/mm/yyyy'))*/                                
                                
                                
    
   TYPE t_tbl_horas IS TABLE OF C_horas%ROWTYPE index by binary_integer;
   t_fichadas           t_tbl_horas;
    
    
    type array_t is table of c_horas%rowtype index by binary_integer;
    array_horas array_t;
    reghrs c_horas%rowtype;
  
    
    
    --- cursor de jornadas por empleado que no  armarn jornadas y  forman una, y aun asi estan en error por los parametros
    cursor  c_huerfanas(p_idorg varchar2, p_fdesde date, p_fhasta date, p_idhr varchar2, PID_PROCESO VARCHAR2) is 
    select std_id_hr, dt_fecha, count(*) from  M4CBR_GT_MARCACION m 
        where m.id_organization = p_idorg
            and m.dt_fecha between p_fdesde and p_fhasta
            and ((m.STD_ID_HR = p_idhr and p_idhr is not null)
                or (m.std_id_hr is not null and p_idhr is null))
            and m.CBR_CK_DESCARTA = 0 
                and m.CBR_CK_VALIDADO = 2
        and not exists
            ( select 1 from M4CCO_GT_HORAS h
                where 
                h.id_organization = m.id_organization
                and h.STD_OR_PERIOD = 1
                and h.std_id_hr = m.std_id_hr
                AND H.CCO_DT_JORNADA = M.DT_FECHA                    
            )
-- LG 08/03/18 NO TOMO EN CUENTA LAS FICHADAS CON JORNADA MANUAL
                            AND (NOT EXISTS (SELECT 1 
                                               FROM M4CBR_GT_MARCA_MAN X 
                                              WHERE X.ID_ORGANIZATION=M.ID_ORGANIZATION
                                                AND X.STD_ID_HR=M.STD_ID_HR
                                                AND X.DT_FECHA=M.DT_FECHA
                                                AND X.DT_HORA=M.DT_HORA
                                                AND X.CCO_CK_MANUAL='S'))            
        and exists (   
                                SELECT 1  FROM M4CCO_VW_GT_HT_HR_CAL C/*M4CCO_GT_HT_HR_CAL G LAUTARO 26/05/16*/ , M4CCO_GT_HR_PROCES p
                                            WHERE C.CCO_ID_PROCESO=PID_PROCESO 
                                                  AND C.ID_ORGANIZATION= M.ID_ORGANIZATION
                                                  AND C.STD_ID_HR = M.STD_ID_HR
                                                  AND C.ID_ORGANIZATION = P.ID_ORGANIZATION
                                                  and  C.std_id_hr =  P.std_id_hr 
                                                   and C.cco_id_proceso = P.CCO_ID_PROCESO
                            )                                                
            having mod(count(*),2) = 0
            group by std_id_hr, dt_fecha;

    TYPE t_tbl_huer IS TABLE OF C_huerfanas%ROWTYPE index by binary_integer;
    t_hrhuer           t_tbl_huer;
    
    
    cursor c_hr_huer(p_idorg varchar2, p_idhr varchar2, p_fch date, PID_PROCESO varchar2) is 
        select * from  M4CBR_GT_MARCACION m 
            where m.id_organization = p_idorg
                and m.std_id_hr = p_idhr
                and m.dt_fecha = p_fch
                and m.CBR_CK_DESCARTA = 0 
                    and m.CBR_CK_VALIDADO = 2
-- LG 08/03/18 NO TOMO EN CUENTA LAS FICHADAS CON JORNADA MANUAL
                            AND (NOT EXISTS (SELECT 1 
                                               FROM M4CBR_GT_MARCA_MAN X 
                                              WHERE X.ID_ORGANIZATION=M.ID_ORGANIZATION
                                                AND X.STD_ID_HR=M.STD_ID_HR
                                                AND X.DT_FECHA=M.DT_FECHA
                                                AND X.DT_HORA=M.DT_HORA
                                                AND X.CCO_CK_MANUAL='S'))
        ;

        
--LG 08/03/18
    cursor c_marcas_manuales(p_idorg varchar2, p_idhr varchar2, pDT_JORNADA DATE, PID_PROCESO varchar2) is 
        select /*+parallel (m,4)*/ x.*, M.CSP_ID_TERCERO, M.CSP_ID_SUBTERCERO, M.CCO_TURNO  
          FROM M4CBR_GT_MARCACION  m, M4CBR_GT_MARCA_MAN X 
         WHERE  m.ID_ORGANIZATION = p_idorg 
--           and m.dt_fecha between p_fchd and p_fchh + 1
           and m.cbr_ck_descarta = 0
           and (    (m.cbr_ck_validado = 0 and m.CCO_APROBADO is null)
                 or (m.cbr_ck_validado = 0 and m.CCO_APROBADO  = K_APROBADO))
           and (    (m.std_id_hr = p_idhr and p_idhr is not null)
                 or (m.std_id_hr is not null and p_idhr is null))    
           and X.ID_ORGANIZATION=M.ID_ORGANIZATION
           AND X.STD_ID_HR=M.STD_ID_HR
           AND X.DT_FECHA=M.DT_FECHA
           AND X.DT_HORA=M.DT_HORA
           AND X.CCO_CK_MANUAL='S'
           AND X.CCO_dT_JORNADA = pDT_JORNADA
           AND  EXISTS
(   
                                SELECT 1  FROM M4CCO_VW_GT_HT_HR_CAL C/*M4CCO_GT_HT_HR_CAL G LAUTARO 26/05/16*/ , M4CCO_GT_HR_PROCES p
                                            WHERE C.CCO_ID_PROCESO=PID_PROCESO 
                                                  AND C.ID_ORGANIZATION= M.ID_ORGANIZATION
                                                  AND C.STD_ID_HR = M.STD_ID_HR
                                                  AND C.ID_ORGANIZATION = P.ID_ORGANIZATION
                                                  and  C.std_id_hr =  P.std_id_hr 
                                                   and C.cco_id_proceso = P.CCO_ID_PROCESO
                            )                                                                           
        order by M.std_id_hr, M.dt_fecha, M.dt_hora, X.CCO_CK_TIPO ASC;    
    

    TYPE t_tbl_forz IS TABLE OF C_hr_huer%ROWTYPE index by binary_integer;
    t_jorforz       t_tbl_forz;
    
    
    
    cursor  c_huererr(p_idorg varchar2, p_fdesde date, p_fhasta date, PID_PROCESO VARCHAR2, p_confchref number ) is 
    select   * from  M4CBR_GT_MARCACION m 
        where m.id_organization = p_idorg
            and m.dt_fecha between p_fdesde and p_fhasta
            and m.CBR_CK_DESCARTA = 0 
            and m.CBR_CK_VALIDADO = 2
            and ((m.CCO_DT_JORNADA_EF is not null and p_confchref = 1)
                 or (m.CCO_DT_JORNADA_EF is null and p_confchref = 0))
        and not exists
            ( select 1 from M4CCO_GT_HORAS h
                where 
                h.id_organization = m.id_organization
                and h.STD_OR_PERIOD = 1
                and h.std_id_hr = m.std_id_hr
                AND H.CCO_DT_JORNADA = M.DT_FECHA                    
            )
-- LG 08/03/18 NO TOMO EN CUENTA LAS FICHADAS CON JORNADA MANUAL
                            AND (NOT EXISTS (SELECT 1 
                                               FROM M4CBR_GT_MARCA_MAN X 
                                              WHERE X.ID_ORGANIZATION=M.ID_ORGANIZATION
                                                AND X.STD_ID_HR=M.STD_ID_HR
                                                AND X.DT_FECHA=M.DT_FECHA
                                                AND X.DT_HORA=M.DT_HORA
                                                AND X.CCO_CK_MANUAL='S'))            
        and exists (   
                                SELECT 1  FROM M4CCO_VW_GT_HT_HR_CAL C/*M4CCO_GT_HT_HR_CAL G LAUTARO 26/05/16*/ , M4CCO_GT_HR_PROCES p
                                            WHERE C.CCO_ID_PROCESO=PID_PROCESO 
                                                  AND C.ID_ORGANIZATION= M.ID_ORGANIZATION
                                                  AND C.STD_ID_HR = M.STD_ID_HR
                                                  AND C.ID_ORGANIZATION = P.ID_ORGANIZATION
                                                  and  C.std_id_hr =  P.std_id_hr 
                                                  and C.cco_id_proceso = P.CCO_ID_PROCESO
                            )                                                
            ;
    
    TYPE t_tbl_huerr IS TABLE OF C_huererr%ROWTYPE index by binary_integer;
    t_huerferr       t_tbl_huerr;

    
    
    
    
    msgerr clob;
    xuser varchar2(40);
    xapprole M4CCO_GT_PROCESOS.ID_APPROLE%type;
    xidsecuser M4CCO_GT_PROCESOS.ID_SECUSER%type;        
    
    
    K_ERRORARMADO number  := 2;
    K_OK integer  := 1;
    K_ERROR integer := 0;
    
    K_MODULE  varchar2(15) := 'ARMOJORNADA';
    K_COMMITS  number := 1000;
    K_NFICHPERDAY    number :=  30;

    K_PENDIENTE   varchar2(2)  := 'P';
    K_FINALIZADO  varchar2(2) := 'I';
    k_ERRONEO     varchar2(2)  := 'E';    
    
    
    k_MAXHRSDIA     number := 16; -- NOTA IMPORTANTE:  si se redefine la maxima cantidad de horas por jornada cambias este valor !!!!
    K_MININTERJOR   number := 11;   --- 03/01/2017 ACV , definido en forma arbitraria a los efectos de completar el codigo, a definir mas adelante por Brasil
    
    K_ENTRADA varchar2(1) := 'I';
    K_SALIDA  varchar2(1) := 'O';
    
    K_PERIODODEFAULT number := 1;
    
    K_DEBUG_PAR varchar2(10) := 'DEBUG';
    
    
    ID_PROCESO M4CCO_GT_PROCESOS.CCO_ID_PROCESO%TYPE;
    
    nrolegant   varchar2(9) ; 
    
    cntcomm number;
    cnterrores number;
    xdebug integer;
    
    
    G_STD_ID_HR varchar2(9);
    
    --PROCEDURE GetParametrosJornadas(p_idorg varchar2, p_idhr varchar2, p_idempresa varchar2,  o_maxjor in out number, o_minintjor in out number, p_log integer);
    
    Procedure MainJornadas(p_idprocess varchar2);
    
    
end M4PKG_ARMA_JORN_BR_J;

/
--------------------------------------------------------
--  DDL for Package M4PKG_BCOHRS_BR_NEW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_BCOHRS_BR_NEW" as 

--- constantes ---
    K_OK  integer := 1;
    K_FALSE integer := 0;
    K_ERROR  integer := 0;
    K_MODULE  varchar2(20) := 'SALDOHORAS';
    k_NCOMMIT number := 1000;
    --K_TY_2x1  varchar2(20):= 'ty_2x1';
    --K_TY_3x1  varchar2(20):= 'ty_3x1';
    K_2MESES    integer := 2;
    K_3MESES    integer := 3;

    K_COMMITS number := 1000;    
    cntcommits number;

    k_maxsaldos  NUMBER := 100;
    
    K_STAT_ENCURSO varchar2(1)  := 'C';
    K_STAT_CONCLUIDO varchar2(1)  := 'F';
    K_STAT_ERROR     varchar2(1)  := 'E';
    
    K_TIPO_RESULTADO_BANCO M4CCO_GT_HR_RESULT.CCO_GT_TIPO%type := 'B';
    
    xuser varchar2(40);
       xapprole M4CCO_GT_PROCESOS.ID_APPROLE%type;
       xidsecuser M4CCO_GT_PROCESOS.ID_SECUSER%type; 

    cnterrores number;
    

    msgerr clob;
        
    k_español  nls_session_parameters.value%type := 'SPANISH';
    k_SABADO integer := 6;
    K_LUNES integer := 1;
    
    G_SIMULA integer;
    G_ID_HR std_hr_period.std_id_hr%type;
    G_RETROACTIVO varchar2(1);
    G_ID_ORGANIZATION varchar2(4);

    --Lautaro 29/05/17
    G_IDIOMA VARCHAR2(10);

    g_cntcommits number;

    G_ID_PROCESO M4CCO_GT_PROCESOS.CCO_ID_PROCESO%TYPE;
    G_DT_DESDE DATE;
    G_DT_HASTA DATE;
    G_FCH_APLIC DATE;
    --- 19/06/2017 ACV ---
    G_TIPO_CALCULO  M4CCO_GT_TIP_CA_BL.CCO_ID_TIPO_CALCULO%type; 
    G_DT_REFERENCIA DATE;
    G_STD_ID_HR varchar2(9);
    
     g_approle std_hr_period.ID_APPROLE%type;
    g_iduser  std_hr_period.ID_SECUSER%type;

    
    G_COMPENSA number(1);
    
    
    cursor c_paga(p_idorg varchar2, p_idpago varchar2) is 
        select /*+ PARALLEL (b,4)*/ * from M4CBR_BCO_HORAS_n b
            where  b.id_organization = p_idorg 
                and b.CCO_ID_PAGO = p_idpago and b.CCO_HORAS_PAGA <> 0;  
    regpaga c_paga%rowtype;
    
    cursor c_saldosp (p_idorg varchar2, p_anio number, p_mes  number, p_idhr varchar2, p_compensa number) is 
        select /*+ PARALLEL (h,4)*/ /*+PARALLEL (t,4)*/ unique nroleg from 
        (select  h.std_id_hr nroleg 
           /* (select max(CCO_DIA_HEREDADO)    
                from M4CBR_BCO_HORAS_n hh 
                    where hh.id_organization = h.id_organization
                    and hh.std_id_hr  = h.std_id_hr
                    and hh.CCO_ANNO_LIQUID = h.CCO_ANNO_LIQUID 
                    and hh.CCO_MES_LIQUID = h.CCO_MES_LIQUID
                    and hh.CCO_ty_acumulador = h.cco_ty_acumulador ) fchref*/
            from  M4CBR_BCO_HORAS_n h, M4CCO_OCURRENCIA o 
                    where h.id_organization = p_idorg
                    and ((h.std_id_hr = p_idhr and p_idhr is not null) or (h.std_id_hr is not null and p_idhr is null))
                    and h.CCO_ANNO_LIQUID = p_anio
                    and h.CCO_MES_LIQUID = p_mes
                    and (h.cco_saldo_pos <> 0 or h.cco_saldo_neg <> 0 ) 
                    and h.CCO_FCH_PAGA is null 
                    and h.ID_ORGANIZATION = o.ID_ORGANIZATION
                    and h.CCO_ID_OCURRENCIA = o.CCO_ID_OCURRENCIA
                    and o.cco_CHK_COMPENSA = nvl(p_compensa,0) );
    regleg c_saldosp%rowtype;    
     
    
    cursor  c_tiposacum(p_idorg varchar2, p_idhr varchar2, p_anio varchar2, p_mes varchar2) is 
        select unique CCO_TY_ACUMULADOR
            from  M4CBR_BCO_HORAS_n hh
            where 
                    hh.id_organization = p_idorg
                    and hh.std_id_hr  = p_idhr
                    and hh.CCO_ANNO_LIQUID = p_anio
                    and hh.CCO_MES_LIQUID = p_mes;
    regTYACUM c_tiposacum%rowtype;                    

    cursor c_saldoshr (p_idorg varchar2, p_idhr varchar, p_anio number, p_mes  number, p_tyacum varchar2, p_compensa  number) is 
        select CCO_TY_ACUMULADOR, CCO_ANNO_HEREDADO, CCO_MES_HEREDADO, CCO_SEMANA_HEREDADA, CCO_DIA_HEREDADO, hh.CCO_ID_OCURRENCIA, CCO_SALDO_POS, CCO_SALDO_NEG,
                            CCO_HORAS_PAGA,    CCO_FCH_PAGA, cco_observacion    
                from M4CBR_BCO_HORAS_N hh, M4CCO_OCURRENCIA o  
                    where 
                    hh.id_organization = p_idorg
                    and hh.std_id_hr  = p_idhr
                    and hh.CCO_ANNO_LIQUID = p_anio
                    and hh.CCO_MES_LIQUID = p_mes
                    and hh.CCO_TY_ACUMULADOR = p_tyacum
                    and hh.ID_ORGANIZATION = o.ID_ORGANIZATION
                    and hh.CCO_ID_OCURRENCIA = o.CCO_ID_OCURRENCIA
                    and o.cco_CHK_COMPENSA = nvl(p_compensa,0)
                        order by CCO_TY_ACUMULADOR,CCO_ANNO_HEREDADO desc, CCO_MES_HEREDADO desc , CCO_SEMANA_HEREDADA desc , CCO_DIA_HEREDADO desc;
    TYPE TyTbSaldos  IS TABLE of c_saldoshr%ROWTYPE INDEX BY BINARY_INTEGER;
    arr_saldos  tytbsaldos;
    arr_detalle tytbsaldos;
    regcur c_saldosHR%rowtype;
    regsaldos c_saldosHR%rowtype;

    
    
    
    /*Procedure PutIncid_N(p_idorg varchar2, p_idhr varchar2, 
                    p_anio  number, p_mes number, 
                    p_fch date,
                    p_tyacum varchar2,
                    p_hrs number, 
                    p_ocurrpos varchar2,
                    p_ocurrneg varchar2,
                    p_loguea integer,
                    p_retroactivo varchar2, p_idioma varchar2,
                    p_fchdesde date, p_fchhasta date
                    );*/
                    
    Procedure PutIncid_N(p_idorg varchar2, p_idhr varchar2, 
                    p_anio  number, p_mes number, 
                    p_fch date,
                    p_tyacum varchar2,
                    p_hrs number, 
                    p_ocurrpos varchar2,
                    p_ocurrneg varchar2,
                    p_loguea integer,
                    p_retroactivo varchar2, p_idioma varchar2,
                    p_fchdesde date, p_fchhasta date,
                    p_idblk varchar2 , p_idtyblk varchar2,
                    p_ocurrpos_p varchar2,
                    p_ocurrneg_p varchar2
                    );                    
                    
    Procedure HeredoSaldos(p_idorg varchar2, p_idhr varchar2, p_anio in out number, p_mes in out number, p_retro varchar2, p_idproc varchar2);    
    Procedure Main_Proc_SAldos(p_idprocess varchar2);
    Procedure InicioSaldosHr(p_idorg varchar2, p_idhr varchar2, p_anio in out number, p_mes in out number, p_retro varchar2);
    Procedure GetConfTipoBLoque(p_idorg varchar2, p_idblk varchar2, p_tyblk varchar2, o_nmeses in out integer, o_nsemanas in out integer, o_ndias in out integer);
    Function  BuscoSabado( p_fch date, p_idioma varchar2) return DATE; 
   
 end M4PKG_BCOHRS_BR_NEW; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CALCULO_HS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CALCULO_HS" 

IS

FUNCTION EJEC_CREATE (
p_ORG IN VARCHAR2,
p_DT_DESDE IN DATE,
p_DT_HASTA IN DATE,
p_PROCESO IN VARCHAR2,
p_COMANDO IN VARCHAR2,
p_ID_SECUSER IN VARCHAR2
)
RETURN NUMBER;

PROCEDURE EJEC_INIT (
p_Ord IN NUMBER,
p_log IN CLOB
);

PROCEDURE EJEC_ERROR (
p_Ord IN NUMBER,
p_log IN CLOB
);
PROCEDURE EJEC_END (
p_Ord IN NUMBER,
p_Log IN clob default ''
);

PROCEDURE EJEC_SET_LOG(
p_Ord IN NUMBER,
p_log IN CLOB
);


PROCEDURE  M4PR_HS_APERTURA_PERIODO
(  pID_ORGANIZATION VARCHAR2
 , pDT_DESDE DATE
 , pDT_HASTA DATE
 , pID_MODULO VARCHAR2
 , pID_EMPRESA VARCHAR2
 , pID_UBICACION VARCHAR2
 , pID_USUARIO VARCHAR2) ;
PROCEDURE M4PR_HS_CIERRE_PERIODO
(pID_ORGANIZATION VARCHAR2, pDT_DESDE DATE, pDT_HASTA DATE, pID_MODULO VARCHAR2, pID_UBICACION VARCHAR2, pID_USUARIO VARCHAR2, pID_EMPRESA VARCHAR2) ;
PROCEDURE M4PR_HS_VALIDACION_HORAS (
   p_id_organization   IN   VARCHAR2,
   p_id_user           IN   VARCHAR2,
   p_dt_desde          IN   DATE,
   p_dt_hasta          IN   DATE,
   p_id_modulo         IN   VARCHAR2,
   p_id_region         IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_id_ubi         IN   VARCHAR2
);
PROCEDURE   M4PR_HS_VUELCO_HORAS (
   p_id_organization   IN   VARCHAR2,
   p_id_user           IN   VARCHAR2,
   p_dt_desde          IN   DATE,
   p_dt_hasta          IN   DATE,
   p_id_modulo         IN   VARCHAR2,
   p_id_region         IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_id_ubi            IN   VARCHAR2
);

PROCEDURE M4PR_GUARDAR_M4CCO_HR_HORAS ( 
p_emp varchar2,
p_id_hr IN VARCHAR2,
p_dt_desde IN DATE,
p_dt_hasta IN DATE,
p_or_proc IN NUMBER DEFAULT 0,
p_id_secuser IN VARCHAR2 DEFAULT NULL
);


procedure M4PR_REORDEN_HRS_PARAGUAY( 
p_id_organization  IN varchar2, 
p_dt_desde IN DATE,
p_dt_hasta IN DATE,
p_id_user IN VARCHAR2);

PROCEDURE M4PR_ELIMINAR_NOVEDADES ( 
p_Ord IN NUMBER,
p_id_organization   IN   VARCHAR2,
p_dt_desde IN DATE,
p_dt_hasta IN DATE,
p_id_hr IN VARCHAR2);

END M4PKG_CALCULO_HS; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CALCULO_HS_BK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CALCULO_HS_BK" 

IS
PROCEDURE  M4PR_HS_APERTURA_PERIODO
(  pID_ORGANIZATION VARCHAR2
 , pDT_DESDE DATE
 , pDT_HASTA DATE
 , pID_MODULO VARCHAR2
 , pID_EMPRESA VARCHAR2
 , pID_UBICACION VARCHAR2
 , pID_USUARIO VARCHAR2) ;
PROCEDURE M4PR_HS_CIERRE_PERIODO
(pID_ORGANIZATION VARCHAR2, pDT_DESDE DATE, pDT_HASTA DATE, pID_MODULO VARCHAR2, pID_UBICACION VARCHAR2, pID_USUARIO VARCHAR2, pID_EMPRESA VARCHAR2) ;
PROCEDURE M4PR_HS_VALIDACION_HORAS (
   p_id_organization   IN   VARCHAR2,
   p_id_user           IN   VARCHAR2,
   p_dt_desde          IN   DATE,
   p_dt_hasta          IN   DATE,
   p_id_modulo         IN   VARCHAR2,
   p_id_region         IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_id_ubi         IN   VARCHAR2
);
PROCEDURE   M4PR_HS_VUELCO_HORAS (
   p_id_organization   IN   VARCHAR2,
   p_id_user           IN   VARCHAR2,
   p_dt_desde          IN   DATE,
   p_dt_hasta          IN   DATE,
   p_id_modulo         IN   VARCHAR2,
   p_id_region         IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_id_ubi            IN   VARCHAR2
);

PROCEDURE m4pr_guardar_m4cco_hr_horas(
pid_hr IN VARCHAR2,
p_dt_desde IN DATE,
p_dt_hasta IN DATE);

procedure M4PR_REORDEN_HRS_PARAGUAY( p_id_organization  varchar2);
PROCEDURE M4PR_CARGA_FICH_BULK(p_idorganizacion IN VARCHAR2,p_legajo IN VARCHAR2,p_fechai IN VARCHAR2,p_fechaf IN VARCHAR2);

END M4PKG_CALCULO_HS; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CALCULO_PROVISION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CALCULO_PROVISION" 
is
  -- --------------------------------------------------------------------------
  -- Name         : M4PKG_CALCULO_PROVISION
  -- Author       : Gabriel Arrota
  -- Description  : modulo M4PKG_CALCULO_PROVISION
  -- Requirements :
  -- License      : N/A
  -- History      : Contiene todos los procedimientos y funciones para realizar el 
  --                calculo de provisiones.
  --
  --   When         Who               What
  --   ===========  ===============   =================================================
  --   17-OCT-2019  Gabriel Arrtoa    Initial Creation
  -- --------------------------------------------------------------------------
--procedure carga_matrix_predictiva ( pg_id_organization    IN m4sll_litigios.id_organization%type,
--                                    pg_fecha_cierre_desde IN date,
--                                    pg_fecha_cierre_hasta IN date
--                                  );  

procedure carga_matrix_predictiva_anual ( pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                        );
                                        
                                        

procedure carga_valor_provision_litigio (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                         pg_fecha_cierre_hasta IN date
                                        );

procedure carga_valor_provision_litigioB (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );
                                        
procedure carga_asientos_contables_prov (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                         pg_fecha_cierre_hasta IN date
                                         );
                                                                                                                           
end M4PKG_CALCULO_PROVISION; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CALCULO_PROVISION_2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CALCULO_PROVISION_2" 
is
  -- --------------------------------------------------------------------------
  -- Name         : M4PKG_CALCULO_PROVISION
  -- Author       : Gabriel Arrota
  -- Description  : modulo M4PKG_CALCULO_PROVISION
  -- Requirements :
  -- License      : N/A
  -- History      : Contiene todos los procedimientos y funciones para realizar el 
  --                calculo de provisiones.
  --
  --   When         Who               What
  --   ===========  ===============   =================================================
  --   17-OCT-2019  Gabriel Arrtoa    Initial Creation
  -- --------------------------------------------------------------------------
--procedure carga_matrix_predictiva ( pg_id_organization    IN m4sll_litigios.id_organization%type,
--                                    pg_fecha_cierre_desde IN date,
--                                    pg_fecha_cierre_hasta IN date
--                                  );  

procedure carga_matrix_predictiva_anual ( pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                        );
                                        
                                        

procedure carga_valor_provision_litigio (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                         pg_fecha_cierre_hasta IN date
                                        );

procedure carga_valor_provision_litigioB (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );
                                        
procedure carga_asientos_contables_prov (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                         pg_fecha_cierre_hasta IN date
                                         );
                                         
                                         

procedure carga_valor_provision_liti_old (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );
                                         
                                         
                                         
                                         
procedure carga_valor_provision_liti_MOD (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );
                                                                            
procedure carga_valor_provision_liti_new (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );


procedure carga_valor_provision_liti_ult (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );

procedure x;
                                                                                                                                                                          
end M4PKG_CALCULO_PROVISION_2; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CALCULO_PROVISION_3
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CALCULO_PROVISION_3" 
is
  -- --------------------------------------------------------------------------
  -- Name         : M4PKG_CALCULO_PROVISION
  -- Author       : Gabriel Arrota
  -- Description  : modulo M4PKG_CALCULO_PROVISION
  -- Requirements :
  -- License      : N/A
  -- History      : Contiene todos los procedimientos y funciones para realizar el 
  --                calculo de provisiones.
  --
  --   When         Who               What
  --   ===========  ===============   =================================================
  --   17-OCT-2019  Gabriel Arrtoa    Initial Creation
  -- --------------------------------------------------------------------------

--   TYPE t_parametros IS TABLE OF m4sll_ini_param_calc_prov.ipar_nombre%TYPE INDEX BY VARCHAR2 (30);
--     --Coleccion que guarda los parametros de cada proceso.
--   vt_parametros   t_parametros;
--     --Indice de la coleccion que guarda los parametros (el nombre del parametro)
--   v_idx_param     m4sll_ini_param_calc_prov.ipar_nombre%TYPE; 
   
procedure carga_matrix_predictiva_anual ( pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                        );
                                        
procedure carga_valor_provision_litigios (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                          pg_fecha_cierre_hasta IN date
                                         );
                                       
procedure carga_provision_asientos (pg_id_organization    IN m4sll_litigios.id_organization%type,
                                    pg_fecha_cierre_hasta IN date,
                                   -- p_all                 IN pls_integer
                                    p_litigios            IN varchar2 default NULL
                                   );

function in_lista (p_string IN VARCHAR2) RETURN TablaLitigios;                                  
                                                                                                                                                                                                                
end M4PKG_CALCULO_PROVISION_3; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CALCULO_STD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CALCULO_STD" as

Err_Access_into_null   NUMBER  := 6530;
err_COllection_is_null  number := 6531;
err_CURSOR_ALREADY_OPEN number := 6511; 
err_DUP_VAL_ON_INDEX number := 1;
err_INVALID_CURSOR number := 1001;
err_INVALID_NUMBER number := 1722;
err_LOGIN_DENIED number := 1017;
err_NO_DATA_FOUND number := 1403;
err_NOI_LOGGED_ON number := 1012;
err_PROGRAM_ERROR number := 6501;
err_ROWTYPE_MISMATCH number := 6504;
err_STORAGE_ERROR number := 6501;
err_SUBSCRIPT_BEYOND_COUNT number := 6533;
err_SUBSCRIPT_OUTSIDE_LIMIT number := 6532;
err_TIMEOUT_ON_RESOURCE number := 51;
err_TOO_MANY_ROWS number:= 1422;
err_VALUE_ERROR number := 6502;
err_ZERO_DIVIDE number := 1476;
--- errores prpopios ---
err_Break_user number :=-21001; 
err_Close_Month number :=-21002;

K_NO_DESCRIP_ERROR varchar2(40) := '{NO DESCRIPTION PER COUNTRY}';


--- 17/01/2017 ACV , segun lo definido por Matiallegro  ---
K_FRANCO_COMPENSADO   m4cco_gt_day_type.CCO_TIPO_DIA%type := 2; 
/*LAUTARO: CAMBIE EL NOMBRE DE LA VARIABLE, SE PRESTABA A CONFUSION. NO ES FRANCO COMPENSATORIO, ES FRANCO COMPENSADO.*/ 
K_FRANCO              m4cco_gt_day_type.CCO_TIPO_DIA%type := 3;
K_NORMAL              m4cco_gt_day_type.CCO_TIPO_DIA%type := 1;
k_feriado             m4cco_gt_day_type.CCO_TIPO_DIA%type := 4; 
k_DiaVIGI             m4cco_gt_day_type.CCO_TIPO_DIA%type := 5;
K_DIAJUSTIF           m4cco_gt_day_type.CCO_TIPO_DIA%type := 6; -- 05/10/2017 acv SE AGREGO POR NUEVA DEFINICION 
-----------------------------------------------------------------------------------



K_RES_IDHR  number := 1;
K_RES_PERIOD number  := 2;
k_CICLOS_TO_INTERRUP number := 1000;


-------constantes--------------
K_IDORGGRAL  std_hr_period.id_organization%type := '0000';
K_appersand varchar2(1) := chr(38);
K_numeral varchar2(1) := '#';
K_PaRiZQ  varchar2(1) := '(';
k_parder  varchar2(1) := ')';
K_comma   varchar2(1) := ',';
K_punto   varchar2(1) := '.';
k_pipe    varchar2(1) := '|';  

k_español  nls_session_parameters.value%type := 'SPANISH';
k_SATURDAY integer := 6;
K_LUNES integer := 1;
k_sunday INTEGER := 7;
k_moNDAY INTEGER;
k_tUESDAY INTEGER;
K_WENDSDAY INTEGER;
K_tHURSDAY INTEGER;
k_fRIDAY INTEGER;


K_TRUE integer := 1;
K_FALSE integer := 0;  
K_OK number := 1;
K_NO number := 0;
K_ERROR number := 0;

G_ANIO  number(4);
G_MES number(2);

g_approle std_hr_period.ID_APPROLE%type;
g_iduser  std_hr_period.ID_SECUSER%type;

K_FACTOR_DEC_HH  number := 24;
K_FACTOR_DEC_HHMM number := 1440;

K_FACTOR_MMHH number := 0.01666;
K_FACTOR_HHMM number := 60;

K_DEC   M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '1' ;
K_DECH  M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '2' ;
K_DATE  M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '3' ;

K_HORAS     M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '05';
K_MINUTOS   M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '06';

xuser varchar(40);

K_SUMA  varchar2(1) := '+';
K_RESTA varchar2(1) := '-';
 
K_HORA_CERO varchar2(10) := '00:00:00';
K_HORA_FIN_DIA varchar2(10) := '23:59:59';
K_HORA_FIN_DIA2 varchar2(10) := '23:59:00';

K_REG_NORMAL m4cco_gt_hr_result.CCO_GT_TIPO%TYPE := 'N';
K_REG_AJUSTE m4cco_gt_hr_result.CCO_GT_TIPO%TYPE := 'T';



K_SUMA  varchar2(1) := '+';
K_RESTA varchar2(1) := '-';

--Function  ExecuteSentence(p_idorganization varchar2, p_idprocess varchar2, p_loguea  integer, p_onlyone  integer)  return  number;
K_TIPO_RESULTADO_NORMAL VARCHAR2(1) := 'N';
K_TIPO_RESULTADO_RETRO VARCHAR2(1) := 'R';  
K_TIPO_RESULTADO_RETRO_T VARCHAR2(1) := 'T';
K_TIPO_RESULTADO_AJUSTE VARCHAR2(1) := 'A';
K_tipo_resultado_BANCO m4cco_gt_hr_result.CCO_GT_TIPO%TYPE := 'B';


K_FCH_FUT date  := to_date('01/01/4000','dd/mm/yyyy');

K_DMD        varchar2(30) := 'DMD_TA';
K_DMD_COMP   varchar2(30) := 'TA001';


--MODULOS
K_MODULO_TT     M4cco_gt_param.CCO_ID_MODULO%type := 'GT_TIEMPO_TEORICO';
K_MODULO_TODOS  M4cco_gt_param.CCO_ID_MODULO%type := 'GT_ALL';
K_MODULO_CALC   M4cco_gt_param.CCO_ID_MODULO%type := 'GT_CALC_HORAS';
K_MODULO_AUSE   M4cco_gt_param.CCO_ID_MODULO%type := 'GT_CALC_AUSENCIAS';
----------variables globales-------------
msgerr  clob;


--PARAMETROS
K_PARAM_DEBUG       M4cco_gt_param.CCO_ID_PARAM%type  := 'DEBUG';
--K_PARAM_TT_HR_DEBUG M4cco_gt_param.CCO_ID_PARAM%type  := 'HR_DEBUG';
K_PARAM_TT_DEBUG    M4cco_gt_param.CCO_ID_PARAM%type  := 'CALCULAR_TT_DEBUG';
K_PARAM_ALL_ID_HR   M4cco_gt_param.CCO_ID_PARAM%type  := 'ID_HR';
K_PARAM_ALL_DT_JORNADA  M4cco_gt_param.CCO_ID_PARAM%type  := 'DT_JORNADA';
K_PARAM_ID_PROCESO  M4cco_gt_param.CCO_ID_PARAM%type  := 'ID_PROCESO';
K_PARAM_DIAS_PROYEC M4cco_gt_param.CCO_ID_PARAM%type  := 'DIAS_TT_PROYEC'; --- 17/04/2018 ACV , usado para proyectar el tiempo teorico de una semana ---
K_NCICLOS_BREAK_PARAM M4cco_gt_param.CCO_ID_PARAM%type  := 'CICLOS_TIO_BREAK'; 
K_PARAM_MULTIPERIODO M4cco_gt_param.CCO_ID_PARAM%type  := 'MULTIPERIODO'; ---  si un pais trabaja con multiperiodo --- 


--LAUTARO 26/12/2017 DOTA261217
G_TIPO_PARAMETRO M4CCO_GT_HT_CALC.CCO_TIPO_PARAM%TYPE;
K_TIPO_PARAM_JERARQUIAS VARCHAR2(1):='J';
K_TIPO_PARAM_LEGAJOS VARCHAR2(1):='L';


K_COMMITS number(4) := 1000;

--- 8/10/2019 ACV estados de Interfces ---
K_ITFZ_HABILITADO number(1) := 1;
K_ITFZ_DESHABILIADO number(1) := 0;
K_ITFZ_OCUPADO number(1) := 2;
K_ITFZ_EN_ERROR number(1) := 3;
 


G_DT_PROYEC number;

g_id_hr_Rcalc  std_hr_period.std_id_hr%type;
G_ID_BLK_RCALC   varchar2(20);
G_ID_tyblk_RCALC  varchar2(20);
G_RECURSIVO number(1);
G_dt_recalc_d date := NULL;
G_dt_recalc_h date := NULL;
G_FALTA_TRUCHA m4sco_incidence.sco_id_incidence%type:='F131';
G_ID_FALTA      m4sco_incidence.sco_id_incidence%type:='GT01';
G_RETROACTIVO varchar2(1);
G_FCH_APLIC DATE;
G_TIPO_CALCULO  M4CCO_GT_TIP_CA_BL.CCO_ID_TIPO_CALCULO%type; 
G_TIPO_PARAMETRO M4CCO_GT_HT_CALC.CCO_TIPO_PARAM%TYPE;

G_DT_REFERENCIA DATE;

G_TIPO_PARAMETRO M4CCO_GT_HT_CALC.CCO_TIPO_PARAM%TYPE;

k_colombia  std_hr_period.ID_ORGANIZATION%type := '0150';
k_chile         std_hr_period.ID_ORGANIZATION%type := '0110';
k_argentina std_hr_period.ID_ORGANIZATION%type := '0010';
k_paraguay std_hr_period.ID_ORGANIZATION%type := '0030';
k_peru              std_hr_period.ID_ORGANIZATION%type := '0050';
K_ESPAÑA        std_hr_period.ID_ORGANIZATION%type := '0001';
K_BRASIL        std_hr_period.ID_ORGANIZATION%type := '0130';
K_FRANCIA       std_hr_period.ID_ORGANIZATION%type := '';
K_DEUT          std_hr_period.ID_ORGANIZATION%type := '';
K_ENGL          std_hr_period.ID_ORGANIZATION%type := '';
K_ITALIA        std_hr_period.ID_ORGANIZATION%type := '';    



----------------------agregar como secuenciadores -------------------------
K_SQ_ERROR  M4cco_GT_SECUENCIA.CCO_TIPO%type := 'SQERRORES';


type tydia is record(
    cco_tipo_dia  M4CCO_GT_TYDIAS.CCO_TIPO_DIA%type,
    ck_justifica    number(1)
);




type ty_globals is  record
(
    g_chk_borro_todo varchar2(1),
    G_TIPO_CALCULO  M4CCO_GT_TIP_CA_BL.CCO_ID_TIPO_CALCULO%type,
    G_DT_REFERENCIA DATE,
    G_escalculo varchar2(1),
    g_id_proceso m4cco_gt_procesos.cco_id_proceso%type,
    G_DIVGEO M4CCO_GT_PROCESOS.STD_ID_GEO_DIV%type,
    g_ID_ORGANIZATION std_hr_period.id_organization%type,
    g_anio number,
    g_mes number,
    g_dt_desde date,
    g_dt_hasta date,
    g_iduser M4CCO_GT_PROCESOS.ID_SECUSER%type,
    g_APPROLE M4CCO_GT_PROCESOS.ID_APPROLE%TYPE,
    g_FCH_APLIC DATE,
    G_RECURSIVO number(1),
    G_EMPRESA std_leg_ent.std_id_leg_ent%type,
    g_numdesde NUMBER(10),
    G_NUMHASTA NUMBER(10),
    G_STD_ID_HR std_hr_period.std_id_hr%type,
    g_id_hr_Rcalc  std_hr_period.std_id_hr%type,
    G_ID_BLK_RCALC   varchar2(20),
    G_ID_tyblk_RCALC  varchar2(20),
    G_dt_recalc_d date := NULL,
    G_dt_recalc_h date := NULL,
    G_DT_PROYEC number,
    G_TIPO_PARAMETRO M4CCO_GT_HT_CALC.CCO_TIPO_PARAM%TYPE,
    CABLE_ID_HR std_hr_period.std_id_hr%type,
    G_USER_BRK M4CCO_GT_PROCESOS.USER_BREAK%type,
    G_CNT_COMMITS number(4),
    g_martes number,
    g_diasquerestan number,
    G_RETROACTIVO number,
    G_FALTA_TRUCHA m4sco_incidence.sco_id_incidence%type:='F131',
    G_ID_FALTA      m4sco_incidence.sco_id_incidence%type:='GT01',
    G_IDIOMA VARCHAR2(10),
    k_español  nls_session_parameters.value%type := 'SPANISH',
    k_SATURDAY integer := 6,
    K_LUNES integer := 1,
    k_sunday INTEGER := 7,
    k_moNDAY INTEGER,
    k_tUESDAY INTEGER,
    K_WENDSDAY INTEGER,
    K_tHURSDAY INTEGER,
    k_fRIDAY INTEGER,
    g_ordinal number(10),
    G_AJUSTES number,
    G_CICLOS_INTERRUP number,
    g_cicLOS NUMBER, 
    G_MULTIPERIODO number,
    G_DEBUG integer, 
    G_BDEBUG boolean,
    G_DIA_NORMAL M4cco_gt_tydias.cco_tipo_dia%type
);

g_varglobals ty_globals;    ---<<< GUARDA TODAS LAS CARACTERISTICAS DEL PROCESO !!!!  Y ME REMITO A ELLA  SIEMPRE --


--LAUTARO 07/06/17
CURSOR C_EMPLEADOS(PID_PROCESO VARCHAR2, PID_ORGANIZATION VARCHAR2) IS
select std_id_hr, C.STD_OR_HR_PERIOD 
from  M4CCO_VW_GT_HT_HR_CAL C 
WHERE C.CCO_ID_PROCESO=PID_PROCESo AND C.ID_ORGANIZATION=PID_ORGANIZATION ;


--- condiciones para ejecucion de item de modulo ---
cursor c_condmod(PID_PROCESO varchar2, p_idorg varchar2, p_idhr varchar2, p_period number, p_fdesde date, p_fhasta date, p_idmodulo varchar2, p_orden number, p_seq number, p_iduser varchar2, p_blkctrl varchar2, p_tyblkctrl varchar2
            ) is 
    select A.CCO_ID_TIPO_BLOQUE  as tyblk, A.CCO_ID_BLOQUE as blk, C.CCO_ID_OCURRENCIA as ocurr, A.CCO_ID_OCURRENCIA_ALTER as ocurr_alter,  a.CCO_ID_OCURR_AJ as ocurr_aj, cnd.CCO_CTRL_FECHA
        , cnd.CCO_CTRL_TYBLoQ , cnd.CCO_CTRL_OCURR, cnd.CCO_CTRL_OCU_AJ, cnd.CCO_CTRL_OCU_ALTER, cnd.CCO_GT_TIPO
        from M4CCO_GT_IT_COND cnd,  M4CCO_GT_HR_BLOQUE B, M4CCO_GT_TIPO_BLOQ A, M4CCO_GT_BLOQ_OCUR C
                  , M4CCO_GT_USER_T_RO D, M4CCO_OCURRENCIA F, M4CCO_GT_OCURR_SEG E   
             WHERE Cnd.ID_ORGANIZATION=p_idorg
               and cnd.cco_id_modulo = p_idmodulo
              and cnd.cco_orden= p_orden
              and cnd.cco_seq = p_seq
                and ((cnd.CCO_BLK_CTRoL = p_blkctrl and p_blkctrl is not null and cnd.CCO_BLK_CTROL is not null)
                             or  (cnd.CCO_TYBLK_CTROL  is null  and p_tyblkctrl is null))  --- que cnd.CCO_BLK_CTRL sea nulo es una generalidad sino se condiciona por el
               and ((cnd.CCO_TYBLK_CTROL = p_tyblkctrl and p_tyblkctrl is not null and cnd.CCO_tyBLK_CTROL is not null)
                    or 
                         (cnd.CCO_tyBLK_CTROL  is null  and p_tyblkctrl is null))  --- que cnd.CCO_byBLK_CTRL sea nulo es una generalidad sino se condiciona por el
              and b.id_organization = cnd.id_organization
               AND B.CCO_ID_PROCESO = PID_PROCESO
               AND B.STD_ID_HR= p_idhr
               and b.cco_id_bloque = cnd.cco_id_bloque
               and b.cco_id_tipo_bloque = cnd.cco_id_tipo_bloque
               AND A.CCO_ID_BLOQUE=B.CCO_ID_BLOQUE
               AND A.CCO_ID_TIPO_BLOQUE=B.CCO_ID_TIPO_BLOQUE
               AND A.ID_ORGANIZATION=B.ID_ORGANIZATION
               and ((a.dt_start between p_fdesde and p_fhasta                              ---- se incorpora este tipo de validacion incorporando vigencia retroactiva  reemplaza  --> 'AND A.DT_END >= p_fhasta ' que esta comentado
                                    and a.dt_end between p_fdesde and p_fhasta)
                           or ( a.dt_start  between p_fdesde and  p_fhasta and a.dt_end > p_fhasta)
                           or ( a.dt_end  between p_fdesde and  p_fhasta and a.dt_start < p_fdesde)
                           or ( a.dt_start < p_fdesde  and a.dt_end > p_fhasta))
               --AND A.DT_END >= p_fhasta 
               AND C.CCO_ID_BLOQUE=A.CCO_ID_BLOQUE
               AND C.CCO_ID_TIPO_BLOQUE=A.CCO_ID_TIPO_BLOQUE
               AND C.ID_ORGANIZATION=A.ID_ORGANIZATION
                      AND D.CCO_ID_APP_USER = p_IDUSER 
               AND D.ID_ORGANIZATION = A.ID_ORGANIZATION
               AND F.CCO_ID_OCURRENCIA = C.CCO_ID_OCURRENCIA
               AND F.ID_ORGANIZATION = C.ID_ORGANIZATION
               AND E.CCO_ID_TIPO_ROL = D.CCO_ID_TIPO_ROL
               AND E.CCO_ID_CATEGORIA = F.CCO_ID_CATEGORIA
               AND E.CCO_INSERT='S'
               ORDER BY CND.ID_SEQ_EVAL ;

--- EXCEPCIONES  para ejecucion de item de modulo ---
cursor c_condexcep(PID_PROCESO varchar2, p_idorg varchar2, p_idhr varchar2, p_period number, p_fdesde date, p_fhasta date, p_idmodulo varchar2, p_orden number, p_seq number, p_iduser varchar2, p_blkctrl varchar2, p_tyblkctrl varchar2
            ) is 
    select A.CCO_ID_TIPO_BLOQUE  as tyblk, A.CCO_ID_BLOQUE as blk, C.CCO_ID_OCURRENCIA as ocurr, A.CCO_ID_OCURRENCIA_ALTER as ocurr_alter,  a.CCO_ID_OCURR_AJ as ocurr_aj, cnd.CCO_CTRL_FECHA
        , cnd.CCO_CTRL_TYBLoQ , cnd.CCO_CTRL_OCURR, cnd.CCO_CTRL_OCU_AJ, cnd.CCO_CTRL_OCU_ALTER, cnd.CCO_GT_TIPO
        from M4CCO_GT_IT_EXCEP cnd,  M4CCO_GT_HR_BLOQUE B, M4CCO_GT_TIPO_BLOQ A, M4CCO_GT_BLOQ_OCUR C
                  , M4CCO_GT_USER_T_RO D, M4CCO_OCURRENCIA F, M4CCO_GT_OCURR_SEG E   
             WHERE Cnd.ID_ORGANIZATION=p_idorg
               and cnd.cco_id_modulo = p_idmodulo
              and cnd.id_seq = p_seq
             and cnd.cco_orden = p_seq
               and ((cnd.CCO_BLK_CTRoL = p_blkctrl and p_blkctrl is not null and cnd.CCO_BLK_CTROL is not null)
                             or  (cnd.CCO_TYBLK_CTROL  is null  and p_tyblkctrl is null))  --- que cnd.CCO_BLK_CTRL sea nulo es una generalidad sino se condiciona por el
               and ((cnd.CCO_TYBLK_CTROL = p_tyblkctrl and p_tyblkctrl is not null and cnd.CCO_tyBLK_CTROL is not null)
                    or 
                         (cnd.CCO_tyBLK_CTROL  is null  and p_tyblkctrl is null))  --- que cnd.CCO_byBLK_CTRL sea nulo es una generalidad sino se condiciona por el
              and b.id_organization = cnd.id_organization
               AND B.CCO_ID_PROCESO = PID_PROCESO
               AND B.STD_ID_HR= p_idhr
               and b.cco_id_bloque = cnd.cco_id_bloque
               and b.cco_id_tipo_bloque = cnd.cco_id_tipo_bloque
               AND A.CCO_ID_BLOQUE=B.CCO_ID_BLOQUE
               AND A.CCO_ID_TIPO_BLOQUE=B.CCO_ID_TIPO_BLOQUE
               AND A.ID_ORGANIZATION=B.ID_ORGANIZATION
               and ((a.dt_start between p_fdesde and p_fhasta                              ---- se incorpora este tipo de validacion incorporando vigencia retroactiva  reemplaza  --> 'AND A.DT_END >= p_fhasta ' que esta comentado
                                    and a.dt_end between p_fdesde and p_fhasta)
                           or ( a.dt_start  between p_fdesde and  p_fhasta and a.dt_end > p_fhasta)
                           or ( a.dt_end  between p_fdesde and  p_fhasta and a.dt_start < p_fdesde)
                           or ( a.dt_start < p_fdesde  and a.dt_end > p_fhasta))
               --AND A.DT_END >= p_fhasta 
               AND C.CCO_ID_BLOQUE=A.CCO_ID_BLOQUE
               AND C.CCO_ID_TIPO_BLOQUE=A.CCO_ID_TIPO_BLOQUE
               AND C.ID_ORGANIZATION=A.ID_ORGANIZATION
                      AND D.CCO_ID_APP_USER = p_IDUSER 
               AND D.ID_ORGANIZATION = A.ID_ORGANIZATION
               AND F.CCO_ID_OCURRENCIA = C.CCO_ID_OCURRENCIA
               AND F.ID_ORGANIZATION = C.ID_ORGANIZATION
               AND E.CCO_ID_TIPO_ROL = D.CCO_ID_TIPO_ROL
               AND E.CCO_ID_CATEGORIA = F.CCO_ID_CATEGORIA
               AND E.CCO_INSERT='S'
               ORDER BY CND.ID_SEQ_EVAL ;

regcond c_condmod%rowtype;               
  

/*--- sumo ños tiempos que estuve fuera del dia de laburo ---*/
Cursor cdia(p_idorg varchar2, p_idhr varchar2, p_jorn date, p_fchdesde date, p_fchhasta date, p_period number) is    
        select  CCO_HH_ENTRADA, CCO_HH_SALIDA, (CCO_HH_SALIDA - CCO_HH_ENTRADA) DIF 
               from M4CCO_GT_HORAS H
                WHERE  
                id_organization  = p_idorg
                    and std_id_hr = p_idhr
                        AND ((H.STD_OR_PERIOD  = p_period and p_period is not null ) or (H.STD_OR_PERIOD is not null and p_period is null))
                        and CCO_DT_JORNADA = p_jorn
                            order by id_seq asc;  
reghrs cdia%rowtype;

TYPE REG_BLOQUE_F IS RECORD (
    CCO_ID_TIPO_BLOQUE        VARCHAR2 (20 Char)    ,
    CCO_ID_BLOQUE        VARCHAR2 (20 Char)    ,
    CCO_TOPE        NUMBER (8,4)    ,
    CCO_TOLERANCIA        NUMBER (15,2)    ,
    SCO_ID_TIME_UNIT        VARCHAR2 (6 Char)    ,
    CCO_REDONDEO        NUMBER (15,2)    ,
    SCO_ID_TIME_UNI_RE        VARCHAR2 (6 Char)    ,
    CCO_HORA_DESDE        DATE    ,
    CCO_HORA_HASTA        DATE    ,
    CCO_TIPO_ANALISIS     M4cco_gt_tipo_bloq.CCO_TIPO_ANALISIS%type   ,
    CCO_GRUPO_CALCULO        VARCHAR2 (2 Char)    ,
    CCO_CANT_DESDE        NUMBER (5,2)    ,
    CCO_CANT_HASTA        NUMBER (5,2)    ,
    CCO_ID_OCURRENCIA        VARCHAR2(20),    
    CHK_ACUMULA number (1,0), 
    CCO_FACTORSALDO     number (9,4),      CCO_TUNIT_CANTIDADES varchar2 (6),
    CCO_FACTOR_OCURR     number (9,4),
    CCO_CK_NORMAL number (1,0),
    CCO_CK_FOLGA number (1,0),
    CCO_CK_FOLGA_C number (1,0),
    CCO_CK_FERIADO number (1,0),
    CCO_CK_HRS_CONTRAC varchar2 (1),
    CCO_HR_LMT_NOCTUR date,
    CCO_ID_TIPO_HR_AD varchar2(20),
    CCO_CK_FER_VIGI number(1,0),
    CCO_FRECUENCIA_ANALISIS number(4),
    CCO_FRECUENCIA_ANALISIS_A number(4),
    CCO_ID_OCURRENCIA_ALTER    VARCHAR2(20),
    CCO_CK_INI_MONDAY number(1),
    CCO_FREC_ANALISIS_2 number(4),
    ID_BENEFICIO varchar2 (8),
    CCO_CK_EVAL_HORARIO    NUMBER (1),        
    CCO_EVAL_TOLER_I    VARCHAR2 (2 Byte),        
    CCO_EVAL_TOLER_O    VARCHAR2 (2 Byte),        
    CCO_TOLERANCIA_O    NUMBER (15,2),
    CCO_MIN_TFEST number (2,0) 
    );


TYPE TYPE_TABLA_HR_SEG IS TABLE OF VARCHAR2(10)
    INDEX BY VARCHAR2(10);
    
TABLA_HR_SEG TYPE_TABLA_HR_SEG;

K_CONSULT_SEGUR varchar2(40) :=   'CONSULT_SEGUR';

K_PAR_IDORG vaRCHAR2(20) := '#ORGANIZAION#';

    --- FUNCIONES RELATIVA AL ID DE PROCESO ----------------------------------------------------------------
    /*Procedure GetParamerosProceso(PID_PROCESO vachar2, o_fdesde in out date, o_fhasta in out date, o_user in out varchar2, o_funcionario in out varchar2,                                    o_anio  in out  number, o_mes in out number, o_tproyect in out  number, o_geodiv in out varchar2, o_simula int out number,                                    o_pagocmpulsivo in out number);*/
    --rocedure GetParamerosProceso(PID_PROCESO varchar2, o_fdesde in out date, o_fhasta in out date, o_user in out varchar2, o_funcionario in out varchar2,
     ---                           o_anio  in out  number, o_mes in out number, o_tproyect in out  number, o_geodiv in out varchar2, o_simula in out number,
      --                          o_pagocmpulsivo in out number, o_emp in out varchar2, o_regdesde in out number, o_reghasta in out number);
        
Procedure GetParamerosProceso(PID_PROCESO varchar2, o_fdesde in out date, o_fhasta in out date, o_user in out varchar2, o_funcionario in out varchar2,
                                o_anio  in out  number, o_mes in out number, o_tproyect in out  number, o_geodiv in out varchar2, o_simula in out number,
                                o_pagocmpulsivo in out number, o_emp in out varchar2, o_regdesde in out number, o_reghasta in out number,
                                o_RETROACTIVO in out  varchar2,o_FCH_APLIC in out date, o_TIPO_CALCULO in out varchar2, o_DT_REFERENCIA in out date, o_ESCALCULO in out varchar2, o_TIPO_PARAMETRO in out varchar2);
    FUNCTION PROCESO_TIPO_CALCULO(p_idorg varchar2, PID_PROCESO varchar2) return varchar2;
    FUNCTION  GetIDOrgPRoceso(p_process  varchar2) return  varchar2;
    Procedure BloqueoLegajos(p_idorg varchar2, PID_PROCESO varchar2);
    Procedure LiberoLegajos(p_idorg varchar2,PID_PROCESO varchar2);
    Function PROC_IS_PAGOCOMPULSIVO(PID_PROCESO varchar2 ) return number; 
    pROCEDURE  DesBloqueoProceso(PID_PROCESO varchar2);
    
    --- FUNCIONES GENERALES -------------------------------------------------------------------------------
    Procedure Compute_Commit(o_cntcommits in out  number);
    PROCEDURE ESTADISTICADERESULTADO(PID_PROCESO varchar2, p_idorg varchar2);
    PROCEDURE GENERA_OCURRENCIA (p_idorg varchar2, pSTD_ID_HR IN VARCHAR2, pDT_JORNADA IN DATE, pORDINAL IN NUMBER, pID_OCURRENCIA IN VARCHAR2, pVALOR IN NUMBER, pCANTIDAD IN NUMBER, pID_PROCESO IN VARCHAR2, p_hrscalendar number, p_factor  number, p_redondeo number, PID_BLOQUE IN VARCHAR2, PID_TIPO_BLOQUE IN VARCHAR2, p_subprocess varchar2, P_PERIOD NUMBER, p_cntcommits in  out number);
    
    FUNCTION M4GetPLSQLSentence(p_idorg varchar2, p_population varchar2) return clob;
    Function  ExecuteSentence(pid_proceso varchar2, p_loguea  integer, p_onlyone integer, p_population varchar2 )  return  number;
    Function MainExecute(pid_proceso varchar2, p_onlyone integer) return integer;
    -------------------------------------------------------------------------------------------------------------------------
    Function  GetCampoResultado(p_str clob, p_nrocampo number) return varchar2;
    Function  GetCampoResultado(p_str clob, p_nrocampo number, p_separ varchar2) return varchar2;
    -------------------------------------------------------------------------------------------------------------------------
    Function  GetVlParameter(p_idorg varchar2, p_module varchar2, p_param varchar2) return varchar2;
    Procedure GetSemanaDia( p_Fecha DATE,  p_maxinx number,  o_semana in out number, o_dia in out number, p_idioma varchar2, p_debug integer );
    Function QueDiaDeSemana(p_fch date, p_idiom varchar2, p_debug integer) return integer;
    Function  GetDayWeekNumber(p_idhr in varchar2, p_fecha date) return number;
    Procedure BuscoExtremosPeriodo(p_idhr varchar2, p_jorn date , o_fchdesde in out date, o_fchhasta in out date, p_dias integer );
    Function  GetTiempoAlmuerzo(p_idorg varchar2, p_idhr varchar2, p_jorn date, p_hrdesdefer date, p_hrhastafer date, P_PERIOD NUMBER) return number;
    Function Conv_NUmber(p_valor varchar2) return number;
    Function GetFchIngreso(p_idorg varchar2, p_StdIdHr varchar2, p_period number) return DATE;
    Function Module (p_val number) return number;
    Function GetHorasAbarcadas(p_jorn date, p_hrdesde varchar, p_hrhasta varchar, p_fdesde date, p_fhasta date) return number;  
    Function GetHorasABarcadas_Cant(p_regblk REG_BLOQUE_F, p_horasreales number, p_horasteoricas number) return  number;
    Procedure GetLimitesAnalisis(p_jorn date, p_hrdesde date, p_hrhasta date, o_hrdesde in out date, o_hrhasta in out date);
    Function AnalizoFichada(p_hrdesde date, p_hrhasta date, p_fdesde date, p_fhasta date) return number;
    Function GetHorasTrabajadas(p_idorg varchar2, p_idhr varchar2, p_fdesde date, p_fhasta date, p_idproces varchar2, P_PERIOD NUMBER) return  number;
    FUnction GetHorasTeoricas(p_idorg varchar2, p_idhr varchar2, p_period number, p_fdesde date, p_fhasta date) return  number;
    Procedure CuantasSemanasVto(p_fchini date, p_fchfin date, o_semanas in out number, o_dias in out  number);
    Procedure CuantasSemanas(p_fchd date, p_fchh date, o_fechafrecti in out date, o_semanas in out number);
    Function M4FN_GET_ULT_OR_PERIOD(pID_ORG IN VARCHAR2, pSTD_ID_HR IN VARCHAR2, pFECHA IN DATE) RETURN NUMBER;
    Function M4FN_GET_OR_PERIOD  (pID_ORG IN VARCHAR2, pSTD_ID_HR IN VARCHAR2, pFECHA IN DATE)  RETURN NUMBER;
    PROCEDURE SetIDIOMA(o_vargl in out ty_globals, p_idiom varchar2);
    Function ValidoDia(p_idhr in varchar2, p_tydia varchar2, p_normal integer, p_folga integer, p_folgac integer, p_feriado integer, p_vigilador integer, p_fch date, p_idblk varchar2, p_tyblk varchar2) return integer;
    Function ValidaDia_Por_Bloque(p_fch  date,p_domingo number, p_lunes number, p_martes number, p_miercoles number, p_jueves number, p_viernes number, p_sabado number) return  integer;
    Function ValidoDia2(p_idhr in varchar2, p_tydia varchar2, p_normal integer, p_folga integer, p_folgac integer, p_feriado integer, p_vigilador integer, p_fch date, p_idblk varchar2, p_tyblk varchar2, p_horasteoricas number) return integer;
    Function ValidoHrs(p_fch date, p_hrs number, p_tipojorn varchar2,  
                     p_tope number, p_tolerancia number, p_unidtol varchar2, p_cntdesde number, p_cnthasta number, p_unidcnt varchar2,
                     p_extremoi varchar2, p_extremod varchar2, p_fchd date, p_fchh date, p_tyblkjorn varchar2, p_esferiado varchar2 ) return integer;       
    PRocedure  GetIntervalHorasJustificadas(p_idorg varchar2,p_idhr varchar2,p_jorn date, o_fchdesde in out date, o_fchhasta in out date, o_hrdesde in out date, o_hrhasta in out date, p_id_falta varchar2, p_period number);    
    Function ConversionUnid(p_fch date, p_hrs number, p_unido varchar2, p_unid varchar2) return number;
    Procedure  DecToHHMi( p_hhmm number, o_hh in out number, o_mi in out number);
    Function Dec_To_Dechh(p_hhmm number) return  number;
    Function OtrashorasIgualOcurrencia( p_idorg varchar2, p_idhr varchar2, p_fch date , p_ocurr  varchar2, p_idblk varchar2, p_tyblk varchar2, p_ty_analisis varchar2, P_PERIOD NUMBER) return NUMBER;
    Procedure GetParametrosDia(p_idorg varchar2, p_idhr varchar2, p_fecha date, o_tipodia in out varchar2, p_period number);
    Procedure GetPrimerayUltimaFichada(p_idorg varchar2, p_idhr varchar2, p_jorn date,   o_fchin in out date, o_fchout in out date, p_period number);
    Procedure InformarSinTiempoTeorico(p_idorg varchar2, p_idprocess varchar2, p_fdesde varchar2, p_fhasta varchar2);
    Function GetTiempoTeoricoAlmuerzo(p_idhr varchar2, p_jorn date, p_period number) return number;
    Function IngresoAntesDeHora(p_idorg varchar2, p_idhr varchar2, p_fch date, p_hrdesde date, p_period number) return integer;
    Function IngresoDespuesDeHora(p_idorg varchar2, p_idhr varchar2, p_fch date, p_hrdesde date, p_period number) return integer;
    Function SalioAntesDeHora(p_idorg varchar2, p_idhr varchar2, p_fch date, p_hrdesde date, p_period number) return integer;
    Function SalioDespuesDeHora(p_idorg varchar2, p_idhr varchar2, p_fch date, p_hrdesde date, p_period number) return integer;
    Function GetHorasTeoricasDefault(p_idhr varchar2) return   number;
    Function GetTotalHrsOcurr( p_idorg varchar2, p_idhr varchar2, p_period varchar2,  p_fch_d date, p_fch_h date,  p_ocurr varchar2, p_tiporeg varchar2 ) return number;
    Function GetTotalHrsOcurrTyBlk(p_idorg varchar2, p_idhr varchar2, p_period number,  p_fch_d date,p_fch_h date, p_ocurr varchar2, p_idtyblock varchar2, p_tiporeg varchar2 ) return number;
    PROCEDURE M4PR_GT_TOTALIZA_HORAS (P_IDORG VARCHAR2, P_ID_PROCESO IN VARCHAR2);
    Procedure GetTiempoEstimadoTrabajo(p_idorg varchar2,p_idhr varchar2, p_fch date, p_hrsteor number, o_jornt_d in out date, o_jornt_h in out date, p_period number) ;
    Function  ExisteOcurrencia(p_idorg varchar2, p_idhr varchar2, p_jorn date,  p_id_ocurrencia varchar2, p_period number) return integer;
    Function  ExisteTipoDeBLoque(p_idorg varchar2, p_idhr varchar2, p_jorn date,  p_idblk varchar2, p_tyblk varchar2, p_period number) return integer ;
    Procedure Inicio_SAldos_Bco_Horas(PID_PROCESO varchar2);
    --PROCEDURE NUEVO_ERROR(p_idorg varchar2, p_idproc varchar2, P_MODULO IN VARCHAR2, PID_HR IN VARCHAR2, P_ERROR IN VARCHAR2, o_CNTCOMMITS in out number);
    PROCEDURE NUEVO_ERROR(p_idorg varchar2, p_idproc varchar2, P_MODULO IN VARCHAR2, PID_HR IN VARCHAR2, P_ERROR IN VARCHAR2, o_CNTCOMMITS in out number, p_errorstd varchar2); 
   --Function HoraDentrodeTolerancia(p_hr date, p_minuten number, p_hrref date, p_porizq  number,p_porder number)  return  number
    Function HoraDentrodeTolerancia(p_hr date, p_tolerancia number, p_unidtole varchar2, p_hrref date, p_porizq  number,p_porder number)  return  number;
    Function ConfirmaCondTyBLk(PID_PROCESO varchar2, p_idorg varchar2, p_idhr varchar2, p_period number, p_fdesde date, p_fhasta date, p_idmodulo varchar2, p_orden number, p_idseq number
                            ,p_fdesdectrl date, p_fhastactrl date, o_cntcommits in out number, p_blkctrl varchar2, p_tyblkctrl varchar2) return number;
    Function ConfirmaExcepTyBLk(PID_PROCESO varchar2, p_idorg varchar2, p_idhr varchar2, p_period number, p_fdesde date, p_fhasta date, p_idmodulo varchar2,p_orden number,  p_idseq number
                            ,p_fdesdectrl date, p_fhastactrl date, o_cntcommits in out number, p_blkctrl varchar2, p_tyblkctrl varchar2) return number;
    --Procedure PUT_MESAGGE(p_idorg varchar2, p_process varchar2,  p_idsq number, p_msgshort varchar2, p_msglarge clob, o_cntcommits in out number);
    Procedure PUT_MESAGGE(p_idorg varchar2, p_process varchar2,p_idhr varchar2, p_idsq number, p_msgshort varchar2, p_msglarge clob, o_cntcommits in out number);
    Function GetLastNextSeqProcess(p_idorg varchar2, p_process varchar2) return  number;
    Procedure InitMessages(p_idorg varchar2, p_process varchar2);
    Function GetDayWeekNumberSp(p_fecha varchar2, p_idiom varchar2) return number;
    Function M4FN_GET_ULT_PERIOD (pID_ORG IN VARCHAR2, pSTD_ID_HR IN VARCHAR2, pFECHA IN DATE) RETURN NUMBER;
    Function  GetSoloNumeros(p_idhr varchar2) return varchar2;
    function GetMonthAfter(p_fch date, p_nmonthafter number) RETURN varCHAR2;
    function GetMonthBefore(p_fch date, p_nmonthafter number) RETURN varCHAR2;
    PROCEDURE CALCULAR_DOTACION(p_idorg varchar2, P_ID_PROCESO IN VARCHAR2);
    PRocedure  SetGLobal(p_idorg varchar2, PID_PROCESO varchar2, o_global in out ty_globals);
    function ToDATE(p_char varchar2, p_mask varchar2) return  date;
    FUNCTION  PROCESO_CERRADO(p_idorg varchar2, PID_PROCESO varchar2) return  integer;   
    PROCEDURE EvaluoInterrupcion(o_global in out ty_globals, p_module varchar2);   
    Function FechasEnPeriodo(p_dt_desde date, p_dt_hasta date, p_fch1 date, p_fch2 date) return number;
    Procedure GT_Exceptions( p_idorg varchar2, p_idproc varchar2,  p_idhr varchar2, p_mdl varchar2,  p_errorsql number, p_errormsg clob, o_global in out ty_globals);
    function MASK_HR_GLOBAL(p_prefijo varchar2, p_val varchar2) return varchar2; 
    Procedure AnuloProceso(p_idorg varchar2, p_idproc varchar2);
    Procedure  GetFechas_Politic_GT(p_idorg varchar2, p_idpolitic varchar2, o_fdesde in out  date, o_fhasta in out  date, p_today date);
    
    --- 02/10/2019 ACV funciones de manejo de archivos , NOTA: trabaja con JAVA !!!!!---
    --Procedure ARCH_LEO( p_path varchar2, p_file varchar2, o_linea in out varchar2, o_utlarch in out UTL_FILE.FILE_TYPE  , o_open  in out number, o_nrow in out number);
    Procedure ARCH_LEO( p_path varchar2, p_file varchar2, o_linea in out varchar2, o_utlarch in out UTL_FILE.FILE_TYPE  , o_open  in out number, o_nrow in out number, o_varglobal in out ty_globals);
    Function  ARcH_GetCOlumna(p_linea varchar2, p_pos number, p_nchar number ) return  varchar2   ;   
    FUNCTION get_path (p_dir IN VARCHAR2) RETURN VARCHAR2;  ---  para llamar  directorios  configurables ---
    Procedure GetFiles(p_dir varchar2);
    Procedure ActualizoInterfaz(p_idorg varchar2, p_interfaz  varchar2, p_fecha date, p_estado number);
    Procedure  GetUltimaEjecucion(p_idorg varchar2, p_interfaz  varchar2, o_fecha in out date, o_estado in out number);
    Function GetSqlConsulta(p_idorg varchar2, p_fecharef date, p_idconsult varchar2) return clob;   
    PROCEDURE INICIALIZO_RESULTADO(p_idorg varchar2, PID_PROCESO varchar2); 
    Function GetSecuencialError(p_idorg varchar2, p_tipo varchar2) return  M4cco_GT_SECUENCIA.CCO_NEXT%type; 
 
    PROCEDURE SETINICIO(p_idorg varchar2, p_idproc varchar2,  P_PASO IN INTEGER, P_TEXT IN VARCHAR2,p_plan varchar2, p_mdl varchar2,  p_orden number , p_seq number, p_pasostotales number);
    PROCEDURE SETFIN(p_idorg varchar2, p_idproc varchar2, P_PASO IN INTEGER, P_TEXT IN VARCHAR2, p_plan varchar2, p_mdl varchar2,  p_orden number , p_seq number, p_pasostotales number);
    Procedure Check_Thread_Running(p_idorg varchar2, p_idproc varchar2, p_plan varchar2, p_mdl varchar2,  p_orden number , p_seq number); 
    Function GetCAlendarioDefault(P_IDORG VARCHAR2, pSCO_ID_WORK_LOC IN VARCHAR2, pSTD_ID_GEO_DIV IN VARCHAR2, pSTD_ID_COUNTRY IN VARCHAR2, P_DTDESDE DAtE, P_DT_HASTA DATE) return varchar2;
    FUnction FechaContemplada(p_idorg varchar2, p_jorn date, p_blk varchar2, p_tyblk varchar2)  return number; 
    Function ParaQueDiaCalcula(p_idorg varchar2, p_jorn date, p_blk varchar2, p_tyblk varchar2, p_dayweek number) return  number; 
    PROCEDURE M4PR_GT_ARMAR_BLOQUES_X_HR( p_idorg varchar2, P_ID_PROCESO IN VARCHAR2); 
    fUNCTION EsDiaJustificado(p_idorg varchar2, p_incid varchar2 )  return  tydia; -- devuelve el tipo de dia que le corresponde a partir de la incidencia (si la tiene, por default devuelve el tipo de dia  parametrizado por parametro general)----
    --Procedure JustificoAusencia(p_idorg varchar2, p_idhr varchar2, p_period number,  p_fch date);    
    Procedure JustificoAusencia(p_idorg varchar2, p_idhr varchar2, p_period number, P_FCH DATE, p_dt_desde date,  p_dt_hasta date);
 
    function M4Fn_FChVIgente(p_desde date, p_hasta date, p_endesde date, p_enhasta date) return  number; ---  funcion disponible  como independiente tambien ---
    function  M4Fn_ValidaFliaDat(p_idorg varchar2, p_flia varchar2, p_data varchar2) return number; 
  
END M4PKG_CALCULO_STD;

/
--------------------------------------------------------
--  DDL for Package M4PKG_CARGOS_A_RHEVOLUTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CARGOS_A_RHEVOLUTION" 
AS

PROCEDURE M4PR_IG_REL_JOB_POSI;
PROCEDURE M4PR_IG_JOB;
PROCEDURE M4PR_IG_REL_JOB_POSI_DIRE;

END M4PkG_CARGOS_A_RHEVOLUTION; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CDE_DENUNCIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CDE_DENUNCIA" 
AS

  FUNCTION OBTENER_DENUNCIA (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION obtener_catalogo (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;
END m4pkg_cde_denuncia; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_CDE_EMAILS_VTO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CDE_EMAILS_VTO" 
AS

  FUNCTION CALCULAR_DIAS_HABILES (
        P_MPA_ID_PAIS   IN   VARCHAR2,
        P_FECHA         IN   DATE
    ) RETURN NUMBER;

END m4pkg_cde_emails_vto;

/
--------------------------------------------------------
--  DDL for Package M4PKG_CDE_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CDE_PKG" 
AS
    /* FUNCTION SQL2JSON(
         P_SQL CLOB,
         P_JSON_PARAM  VARCHAR2

     ) RETURN CLOB;

     FUNCTION F_SQL_PAGINADO(
     p_user                  IN VARCHAR2,
     p_sql                   IN VARCHAR2,
     p_nro_pagina            IN INTEGER,
     p_filas_pag             IN INTEGER
     ) RETURN CLOB;
   */
   PROCEDURE arma_bandeja_query (
      p_user         IN   VARCHAR2,
      p_json_param        VARCHAR2,
      p_pagina            VARCHAR2
   );

   PROCEDURE arma_bandeja_seguimiento_query (
      p_user         IN   VARCHAR2,
      p_json_param        VARCHAR2,
      p_pagina            VARCHAR2
   );

   PROCEDURE arma_bandeja_accion (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );
END m4pkg_cde_pkg; 



/
--------------------------------------------------------
--  DDL for Package M4PKG_CDE_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CDE_REPORTES" AS 
       --PRAGMA SERIALLY_REUSABLE;

    FUNCTION INFORME_PASTA(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    ) RETURN CLOB;

    FUNCTION LISTADO_DENUNCIAS (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;



END M4PKG_CDE_REPORTES; 


/
--------------------------------------------------------
--  DDL for Package M4PKG_CODIF_DATOS_ACAD_EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CODIF_DATOS_ACAD_EMEA" 
AS 
PROCEDURE    M4PR_IG_EDU_DIPLOMA(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_EDU_TYPE(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_EDU_SPECIAL(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_EDUC_CENTER(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HR_ACAD_BACKGR(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HR_LANG(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HT_HR_LANG(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_LU_LANGUAGES(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HR_COMP_BACK(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_LANG_LEVEL(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_IG_CONOC_INFORM (vID_ORGANIZATION VARCHAR2);
END M4PKG_CODIF_DATOS_ACAD_EMEA;

/
--------------------------------------------------------
--  DDL for Package M4PKG_CODIF_DATOS_ACAD_LTAM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CODIF_DATOS_ACAD_LTAM" 
AS 
PROCEDURE    M4PR_IG_EDU_DIPLOMA(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_EDU_TYPE(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_EDU_SPECIAL(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_EDUC_CENTER(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HR_ACAD_BACKGR(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HR_LANG(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HT_HR_LANG(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_LU_LANGUAGES(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_HR_COMP_BACK(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4PR_IG_LANG_LEVEL(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4CBR_IG_H_HR_SAL(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4CCO_IG_H_HR_SAL(vID_ORGANIZATION VARCHAR2);
PROCEDURE    M4CCO_IG_H_HR_COMPL(vID_ORGANIZATION VARCHAR2);

END M4PKG_CODIF_DATOS_ACAD_LTAM;

/
--------------------------------------------------------
--  DDL for Package M4PKG_CODIF_LATAM_GLOB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CODIF_LATAM_GLOB" 
AS 
PROCEDURE    M4PR_IG_X_CALIFICACI    ; 
PROCEDURE    M4PR_IG_UBI    ; 
PROCEDURE    M4PR_IG_HT_LE_ADDR    ; 
PROCEDURE    M4PR_IG_centr_costo    ; 
------------- 
PROCEDURE M4PR_SOLICITUDES;      
PROCEDURE M4PR_BANK_BRANCH_DE_M4LATAM; 
PROCEDURE M4PR_FONDO_PENS_DE_M4LATAM; 
PROCEDURE M4PR_OBRA_SOCIAL_DE_M4LATAM; 
PROCEDURE M4PR_X_CATEGORIA_DE_M4LATAM; 
PROCEDURE M4PR_X_CONTRATO_DE_M4LATAM; 
PROCEDURE M4PR_X_CONVENIO_DE_M4LATAM; 
PROCEDURE M4PR_X_EMP_TYPE_DE_M4LATAM; 
PROCEDURE M4PR_LEG_ENT_DE_M4LATAM; 
PROCEDURE M4PR_WORK_LOCATION_DE_M4LATAM; 
PROCEDURE M4PR_EXTERNAL_ORG_DE_M4LATAM; 
PROCEDURE M4PR_COMPANY_BANK_DE_M4LATAM; 
PROCEDURE M4PR_IG_H_WLOC_ADDR; 
PROCEDURE M4PR_psg_gest_fol_conta; 
PROCEDURE m4pr_ig_cod_posi(vID_ORGANIZATION VARCHAR2);
PROCEDURE m4pr_ig_sucursales;
END M4PKG_CODIF_LATAM_GLOB;

/
--------------------------------------------------------
--  DDL for Package M4PKG_COMP_SALAREF_CCO_H_SBA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_COMP_SALAREF_CCO_H_SBA" AS
/******************************************************************************
   NAME:       M4PKG_COMP_SALAREF_CCO_H_SBA
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        30/09/2019      ES00610911       1. Created this package.
******************************************************************************/

  FUNCTION MyFunction(Param1 IN NUMBER) RETURN NUMBER;
  PROCEDURE MyProcedure(Param1 IN NUMBER);
-- COMPARACION SALARIOS BRUTOS CCO_H_SBA --V330092019--
SELECT '1 CCO_H_SBA ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_ASIG_VEHICULO||'-'||CCO_ASIG_SEG_MED DATO
FROM CCO_H_SBA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 CCO_H_SBA ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_ASIG_VEHICULO||'-'||CCO_ASIG_SEG_MED
FROM M4PSPNES.CCO_H_SBA@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 CCO_H_SBA GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_ASIG_VEHICULO||'-'||CCO_ASIG_SEG_MED
FROM M4PSPNES.CCO_H_SBA@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 CCO_H_SBA GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_ASIG_VEHICULO||'-'||CCO_ASIG_SEG_MED
FROM CCO_H_SBA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL -- COMPARACION SALARIOS BRUTOS M4CCO_H_SLAR_REF --
SELECT '1 CCO_H_SLAR_REF ESP vs GLOBAL' COMPARACION ,SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_SBDA DATO
FROM M4CCO_H_SALAR_REF A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 CCO_H_SLAR_REF ESP vs GLOBAL',STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_SBDA
FROM M4PSPNES.M4CCO_H_SALAR_REF@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 CCO_H_SLAR_REF GLOBAL vs ESP',STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_SBDA
FROM M4PSPNES.M4CCO_H_SALAR_REF@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 CCO_H_SLAR_REF GLOBAL vs ESP',SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_SBA||'-'||CCO_SBDA
FROM M4CCO_H_SALAR_REF A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL -- COMPARACION INCENTIVOS --
SELECT '1 INCENTIVOS ESP vs GLOBAL' COMPARACION, SUBSTR(SCO_ID_HR,3,9)||'-'||SCO_OR_HR_PERIOD||'-'||CCO_FEC_INICIO||'-'||CCO_FEC_FIN||'-'||CCO_INCENTIVO||'-'||CCO_PRIMA DATO
FROM M4CCO_H_HR_EXC_INC A  WHERE CCO_FEC_FIN >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 INCENTIVOS ESP vs GLOBAL', SCO_ID_HR||'-'||SCO_OR_HR_PERIOD||'-'||CCO_FEC_INICIO||'-'||CCO_FEC_FIN||'-'||CCO_INCENTIVO||'-'||CCO_PRIMA
FROM M4PSPNES.M4CCO_H_HR_EXC_INC@M4EMEA A  WHERE CCO_FEC_FIN >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 INCENTIVOS GLOBAL vs ESP', SCO_ID_HR||'-'||SCO_OR_HR_PERIOD||'-'||CCO_FEC_INICIO||'-'||CCO_FEC_FIN||'-'||CCO_INCENTIVO||'-'||CCO_PRIMA
FROM M4PSPNES.M4CCO_H_HR_EXC_INC@M4EMEA A WHERE CCO_FEC_FIN >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 INCENTIVOS GLOBAL vs ESP', SUBSTR(SCO_ID_HR,3,9)||'-'||SCO_OR_HR_PERIOD||'-'||CCO_FEC_INICIO||'-'||CCO_FEC_FIN||'-'||CCO_INCENTIVO||'-'||CCO_PRIMA
FROM M4CCO_H_HR_EXC_INC A  WHERE CCO_FEC_FIN >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL -- COMPARACION SEGURO MEDICO --
SELECT '1 SEGURO MEDICO ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMPORTE_ANUAL||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_SEG_MED A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 SEGURO MEDICO ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMPORTE_ANUAL||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_SEG_MED@M4EMEA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 SEGURO MEDICO GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMPORTE_ANUAL||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_SEG_MED@M4EMEA A WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 SEGURO MEDICO GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMPORTE_ANUAL||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_SEG_MED A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL --M4CCO_H_FORMACION
SELECT '1 FORMACION ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_FORMACION A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 FORMACION ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_FORMACION@M4EMEA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 FORMACION GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_FORMACION@M4EMEA A WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 FORMACION GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_FORMACION A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL --M4CCO_H_CHEQ_GUARD
SELECT '1 CHEQ_GUARD ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_CHEQ_GUARD A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 CHEQ_GUARD ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_CHEQ_GUARD@M4EMEA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 CHEQ_GUARD GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_CHEQ_GUARD@M4EMEA A WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 CHEQ_GUARD GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_CHEQ_GUARD A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL --M4CCO_H_CHEQ_RESTA
SELECT '1 CHEQ_RESTA ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_CHEQ_RESTA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 CHEQ_RESTA ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_CHEQ_RESTA@M4EMEA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 CHEQ_RESTA GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_CHEQ_RESTA@M4EMEA A WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 CHEQ_RESTA GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_CHEQ_RESTA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL --M4CCO_H_TRANSPORTE
SELECT '1 TRANSPORTE ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_TRANSPORTE A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 TRANSPORTE ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_TRANSPORTE@M4EMEA A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 TRANSPORTE GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4PSPNES.M4CCO_H_TRANSPORTE@M4EMEA A WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 TRANSPORTE GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_CONC||'-'||CSP_IMP_TRA DATO
FROM M4CCO_H_TRANSPORTE A  WHERE DT_START >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL -- AYUDA VIVIENDA
SELECT '1 M4CCO_H_AYU_VIV ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_PRIM_INST||'-'||CCO_IMP_ANUAL||'-'||CCO_VAL_CATASTRAL||'-'||CSP_IMP_TRA
FROM M4CCO_H_AYU_VIV A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 M4CCO_H_AYU_VIV ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_PRIM_INST||'-'||CCO_IMP_ANUAL||'-'||CCO_VAL_CATASTRAL||'-'||CSP_IMP_TRA
FROM M4PSPNES.M4CCO_H_AYU_VIV@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 M4CCO_H_AYU_VIV GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_PRIM_INST||'-'||CCO_IMP_ANUAL||'-'||CCO_VAL_CATASTRAL||'-'||CSP_IMP_TRA
FROM M4PSPNES.M4CCO_H_AYU_VIV@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 M4CCO_H_AYU_VIV GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_IMP_PRIM_INST||'-'||CCO_IMP_ANUAL||'-'||CCO_VAL_CATASTRAL||'-'||CSP_IMP_TRA
FROM M4CCO_H_AYU_VIV A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL -- SEGURO VIDA
SELECT '1 M4CCO_H_SEGUR_VIDA ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_CAPITAL||'-'||CCO_PRIMA_NETA||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_ID_MOTIVO||'-'||CSP_IMP_TRA||'-'||CCO_COMENTARIO
FROM M4CCO_H_SEGUR_VIDA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 M4CCO_H_SEGUR_VIDA ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_CAPITAL||'-'||CCO_PRIMA_NETA||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_ID_MOTIVO||'-'||CSP_IMP_TRA||'-'||CCO_COMENTARIO
FROM M4PSPNES.M4CCO_H_SEGUR_VIDA@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 M4CCO_H_SEGUR_VIDA GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_CAPITAL||'-'||CCO_PRIMA_NETA||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_ID_MOTIVO||'-'||CSP_IMP_TRA||'-'||CCO_COMENTARIO
FROM M4PSPNES.M4CCO_H_SEGUR_VIDA@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 M4CCO_H_SEGUR_VIDA GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_CAPITAL||'-'||CCO_PRIMA_NETA||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_ID_MOTIVO||'-'||CSP_IMP_TRA||'-'||CCO_COMENTARIO
FROM M4CCO_H_SEGUR_VIDA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION ALL -- VEHICULO
SELECT '1 M4CCO_H_VEHIC ESP vs GLOBAL' COMPARACION, SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_ID_VEHICULO||'-'||CCO_ID_MOTIVO||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_OBSERVACIONES
FROM M4CCO_H_VEHIC A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '1 M4CCO_H_VEHIC ESP vs GLOBAL', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_ID_VEHICULO||'-'||CCO_ID_MOTIVO||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_OBSERVACIONES
FROM M4PSPNES.M4CCO_H_VEHIC@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
UNION
SELECT '2 M4CCO_H_VEHIC GLOBAL vs ESP', STD_ID_HR||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_ID_VEHICULO||'-'||CCO_ID_MOTIVO||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_OBSERVACIONES
FROM M4PSPNES.M4CCO_H_VEHIC@M4EMEA A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'
MINUS
SELECT '2 M4CCO_H_VEHIC GLOBAL vs ESP', SUBSTR(STD_ID_HR,3,9)||'-'||STD_OR_HR_PERIOD||'-'||DT_START||'-'||DT_END||'-'||CCO_ID_VEHICULO||'-'||CCO_ID_MOTIVO||'-'||CCO_ID_EFEC_NOMINA||'-'||CCO_OBSERVACIONES
FROM M4CCO_H_VEHIC A where DT_END >= '01/01/2019' AND ID_ORGANIZATION = '0001'

END M4PKG_COMP_SALAREF_CCO_H_SBA;

/
--------------------------------------------------------
--  DDL for Package M4PKG_CONVERT_SQL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_CONVERT_SQL" 
as
    
    /*
        CONSIDERACIONES de ejecucion:
            Ejecutar   la funcion MAIN_M4ToPLSQL (query, loguea) donde 
                -loguea: puede ser 1 o 0 si es uno tira log de ejecucion  por la dbms_outrput
                
                -query: querie de M4 a convertir a PLSQL, compremisa, quitar los caracteres  appersand y ' (comilla simple),  en este ultimo caso reemplazar por la funcion chr(39) concatenado en el medio     
                    por ejemplo: 
                            si tenemos  en medio de un query  la instruccion de M4  ...#DATE('4000-01-01')...
                             quedaria   ...#DATE(' ||  chr(39) ||'4000-01-01' || chr(39) ||  ')...
    
            unas fomra e reemplazar el caractrer'&' seria buscando el caracater  chr(38) por ejemplo
            
            SELECT A.SCO_ID_POPULATION, X.SCO_IND_FILTER, TO_CHAR(A.SCO_PARAMTER), replace(TO_CHAR(SCO_SENTENCE), chr(38),'') 
                    FROM M4SCO_POPUL_PUBLIC X, M4SCO_POPUL_PUBL1 A, M4SCO_POPUL_PUBL2 B
                    WHERE B.SCO_ID_POPULATION=A.SCO_ID_POPULATION
                    AND X.SCO_ID_POPULATION=A.SCO_ID_POPULATION
                    AND X.SCO_ID_POPULATION='POPU_PICHON'
                    ORDER BY X.DT_LAST_UPDATE DESC 

    
    */
    K_OK number := 1;
    K_ERROR number := 0;
    
    
    K_FIELDS    number := 1;
    K_FROM        number := 2;
    K_WHERE        number := 3;
    K_ORACLE    number := 3;
   
    K_NOFLDS    varchar2(50) := '[SELECT AREA MISSING]';
    K_NOFROM    varchar2(50) := '[FROM AREA MISSING]';
    K_NOCOND    varchar2(50) := '[WHERE AREA MISSING]';
    
    
    K_appersand varchar2(1) := chr(38);
    K_numeral varchar2(1) := '#';
    K_PaRiZQ  varchar2(1) := '(';
    k_parder  varchar2(1) := ')';
    K_comma   varchar2(1) := ',';
    k_pipe    varchar2(1) := '|';  
    K_FMT_DT     varchar(25) := 'yyyy-mm-dd';
    K_FMT_DTHH24 varchar(25) := 'dd/mm/yyyy hh24:mi:ss';
    
    ---  cnstantes de funcione  particulares ---
    K_FC_DATE      varchar2(15)  := 'DATE';
    K_FC_TODATE  varchar2(15) := 'TO_DATE';
    K_FC_TIMESTAMP  varchar2(15) := 'TIME_STAMP ';
    
    K_FC_TODAY   varchar2(15)  := '#TODAY ()';
    K_FC_TODAY_2 varchar2(15)  := '#TODAY()';
    K_FC_TODAY_3 varchar2(15)  := '#today ()';
    K_FC_TODAY_4 varchar2(15)  := '#today()';
    
    K_FC_RTODAY    varchar2(15)  := ' sysdate ';
    
    
    
    
    --- constantes de funciones particulares ---
    K_DT_MAX       varchar2(15) := 'm4_plus_inf';
    K_DT_MAX_VAL   varchar2(100) := 'to_date(' || chr(39) || '01/01/4000' || chr(39) || ',' || chr(39) || 'dd/mm/yyyy' || chr(39) || ')' ;
    K_DT_MIN       varchar2(15) := 'm4_plus_inf';
    K_DT_MIN_VAL   varchar2(100) := 'to_date(' || chr(39) || '01/01/1800' || chr(39) || ',' || chr(39) || 'dd/mm/yyyy' || chr(39) || ')' ;
    
    
    ---  POR CADA CAMPO AGREGAR  UN PIPE CONTCATENADO A L RESTO...---
    k_DEFAULT_SELECT_ty3 varchar2(100) := 'SELECT STD_ID_HR  || chr(124) || STD_OR_HR_PERIOD ';  --- ---
    k_DEFAULT_SELECT varchar2(100) := 'SELECT STD_HR_PERIOD.STD_ID_HR  || chr(124) ||  STD_HR_PERIOD.STD_OR_HR_PERIOD ';  --- ---
    K_NIVEL1 number := 1;
    K_NIVEL2 number := 2;
    K_NIVEL3 number := 3;
    K_NIVEL4 number := 4;
    K_NIVEL5 number := 5;
    K_NIVEL6 number := 6;
           
    
    cursor c_items  is  select /* +PARALLEL (q,4)*/ ITEMSUPLLOGICO,ITEMLOGICO, ITEMREAL, ALIAS from M4CCO_items_queries q;
    cursor c_flds(p_tbl varchar2)    is select /*PARALLEL (f,4)*/ * 
                    from m4rdc_fields f
                        where id_object = p_tbl;

    
    regfld c_flds%rowtype;
    
    type array_t is table of c_items%rowtype index by binary_integer;
    array_flds array_t;
    array_tbls array_t;
    msgerr clob;
    
    msgerrtblsflds clob;
 

    K_PREFI_M4x2  varchar2(4) := 'M4M4';
    K_PREFI_M4 varchar2(2) := 'M4';

   
    FUNCTION MAIN_M4ToPLSQL( p_queryM4 clob, p_params clob, loguea integer, p_type varchar2) return clob;    ----  funcion  de  entrada al uso del pkg ----
    Procedure Initbls;
    Procedure IniFlds;
    Procedure InicializoStruct( o_array in out array_t, loguea integer);
    Function CuantosInit(p_array  array_t, loguea integer) return number;
    Function CuantosNoNulos(p_array ARRAY_T, loguea integer) RETURN NUMBER;
    Function GetSelectArea(p_queryM4 clob, loguea integer)  return clob;
    Function GetFromArea(p_queryM4 clob, loguea integer)  return clob;
    Function GetWhereArea(p_queryM4 clob, loguea integer)  return clob;
    Function GetNmTable(p_logtbl varchar2, loguea integer) return varchar2;
    Function GetNmField(p_logtbl varchar2,p_logfld varchar2, loguea integer) return  varchar2;
    Procedure AgregoItem(o_array in out array_t, p_itemsuplog varchar2, p_itemlog varchar2, p_itemreal varchar2, p_alias varchar2, loguea integer);    
    Procedure SplitTbls(o_array in out array_t, p_string varchar2, p_separ varchar2, p_obj number, loguea integer);
    Procedure AgregoCampos( p_tbl varchar2, p_alias varchar2, loguea integer);
    Function Traduce(p_string clob, p_obj number, loguea integer) return  clob;
    Function GetRealFunction(p_db number, p_fnc varchar2, loguea integer) return varchar2;
    Procedure TraduceFunctions(o_string in out clob, loguea integer);
    Function GetStrBtwnChrs(p_str clob,p_chr1 varchar2, p_chr2 varchar2, p_sincepos number,  p_sinchrs integer) return varchar2;
    Procedure ReplaceConstants(p_str in out varchar2);
    Function HayFuncion(p_str varchar2) return number;
    Function GetParametros(p_pos number, p_str clob, p_reemplchr integer,p_separo varchar2, p_separ varchar2) return  clob;
    Procedure Reemplazo_de_Parametros(p_parametros varchar2 ,o_where in out clob, p_loguea integer);
    procedure ReemplazoAliasIgualesATablas( o_string in out clob, p_loguea integer);  
    Function  ExecuteSentence(p_idprocess varchar2,p_idpopulation varchar2, p_loguea integer) return number;
    Procedure ReemplazoWheres(p_nivel integer, o_where in out clob, p_loguea  integer); 
    Function HaySelects( p_texto clob ,p_pos integer, nivelini integer,  p_nivel integer) return  integer;
    Function GetPosParIzq( p_texto clob ,p_pos integer) return  number;
    Function CuantosSelect(p_texto clob) return  number;
    Function CuantosWhere(p_texto clob) return  number;
    Function  GetPosFirstSelect(p_texto clob) return  number; 
 
END M4PKG_CONVERT_SQL; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_DELETE_HR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_DELETE_HR" 
AS 
   
PROCEDURE M4PR_DELETE_IG_H_HR ;
 END M4PKG_DELETE_HR;

/
--------------------------------------------------------
--  DDL for Package M4PKG_EMPLEADO_EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_EMPLEADO_EMEA" 
IS    
PROCEDURE    M4PR_IG_H_HR_RO_TIME_EMEA    ;  --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_H_HR_WLOC_EMEA    ;     --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_H_HR_WUNIT_EMEA    ;    --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_ADDRESS_EMEA    ;  
--PROCEDURE    M4PR_IG_H_MOD_CON_EMEA    ;  
PROCEDURE    M4PR_IG_H_HR_LEGENT_EMEA    ;    
PROCEDURE    M4PR_IG_H_EMP_TYPE_EMEA    ;     
PROCEDURE    M4PR_IG_H_HR_JOB_EMEA    ;  
PROCEDURE    M4PR_IG_H_TYPE_ADJ_EMEA    ;  
PROCEDURE    M4PR_IG_PAYMENT_DATA_EMEA    ;  
PROCEDURE    M4PR_IG_PERSON_EMEA    ;  
PROCEDURE    M4PR_IG_PERSON_BANK_EMEA    ;  
PROCEDURE    M4PR_IG_PHONE_FAX_EMEA    ;  
PROCEDURE    M4PR_IG_HR_PERIOD_EMEA    ;  
PROCEDURE    M4PR_IG_HR_ROLE_EMEA    ;    --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_HT_MAR_STAT_EMEA    ;  
PROCEDURE    M4PR_IG_HR_EMEA    ;  
PROCEDURE    M4PR_IG_TIP_SEGUR; 
PROCEDURE    M4PR_IG_EMAIL    ;    
PROCEDURE    M4PR_IG_HR_NAT    ;     
PROCEDURE    M4PR_IG_HR_C_COSTO     ;    --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_H_IMP_COSTES;       --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_H_HR_POS;           --SGG 26/01/2021, SE HA HECHO SIN IG EN LA PARTE INFERIOR, SI VA BIEN SE PODRÍA QUITAR
PROCEDURE    M4PR_IG_H_HR_EXC_JOB;  
PROCEDURE    M4PR_IG_H_HR_EXC_GRA;  
PROCEDURE    M4PR_IG_H_PORC_GLEGA;  
PROCEDURE    M4PR_IG_H_PORC_JORN ;  
PROCEDURE    M4PR_IG_H_CONTRATOS ;  
PROCEDURE    M4PR_IG_H_CONVENIOS ;   -- CAG  22/11/2018 procedure de Leo ... 
PROCEDURE    M4PR_IG_CONVENIOS ;       -- CAG  22/11/2018 procedure de Leo ... 
PROCEDURE    M4PR_IG_H_HR_EXC_INC;  
PROCEDURE    M4PR_IG_CONTRATO_INT;  
PROCEDURE    M4PR_IG_CONTRATO_LEG;   -- CAG  22/11/2018 procedure de Leo ... 
PROCEDURE    M4PR_IG_CATEGORIAS;  
PROCEDURE    M4PR_IG_H_CATEGORIA_TUM;  
PROCEDURE    M4PR_IG_H_WLOC_ADDR;  
PROCEDURE    M4PR_HCO_BANK_PT;    -- GBM 2020/02/13 Cambios para traer el Código Bancario desde el Emind de Portugal

PROCEDURE    M4PR_IG_H_CONVENIOS_SIN_IG;      -- RDMM 17/06/2020 Nueva manera de nivelar el histórico de convenios

-- ACTUALIZACIONES TABLAS DE ROL E HIJAS SIN IG

PROCEDURE    M4PR_HR_ROLE_INSUPD_EMEA_NO_IG;  --SGG 26/01/2021 EL ROL SE DIVIDE EN DOS PROCESOS, EL INSERT Y UPDATE SE HACEN AL PRINCIPIO, PORQUE LAS TABLAS HIJAS DEPENDEN DE ESTE
PROCEDURE    M4PR_H_HR_WLOC_EMEA_NO_IG;       --SGG 26/01/2021
PROCEDURE    M4PR_HR_WUNIT_EMEA_NO_IG;        --SGG 26/01/2021
PROCEDURE    M4PR_H_CENT_COS_EMEA_NO_IG;      --SGG 26/01/2021
PROCEDURE    M4PR_H_IMP_COSTES_EMEA_NO_IG;    --SGG 26/01/2021
PROCEDURE    M4PR_HR_RO_TIME_EMEA_NO_IG;      --SGG 26/01/2021
PROCEDURE    M4PR_HR_POS_EMEA_NO_IG;          --SGG 26/01/2021
PROCEDURE    M4PR_IG_H_CATEGORIA_TUM_SIN_IG;  -- RDMM 17/06/2020 Nueva manera de nivelar el histórico de categorías
PROCEDURE    M4PR_HR_ROLE_DEL_EMEA_NO_IG;     --SGG 26/01/2021, EL ROL SE HA DIVIDIDO EN DOS PROCESOS, EL DELETE, QUE ES ESTE, SE HACE AL FINAL, PK LAS TABLAS HIJAS DEPENDEN DEL ROL
--FIN ACTUALIZACION TABLAS ROL E HIJAS SIN IG

END M4PKG_EMPLEADO_EMEA;

/
--------------------------------------------------------
--  DDL for Package M4PKG_EMPLEADO_EXT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_EMPLEADO_EXT" 
AS
    PROCEDURE    M4PR_IG_H_HR_CALIFICACI    ;
    PROCEDURE    M4PR_IG_H_HR_UBICACIO    ;
   

END M4PKG_empleado_ext; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_EMPLEADO_LATAM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_EMPLEADO_LATAM" 
IS

  
PROCEDURE    M4PR_IG_H_HR_RO_TIME    ;
PROCEDURE    M4PR_IG_H_HR_WLOC    ;
PROCEDURE    M4PR_IG_H_HR_WUNIT    ;
PROCEDURE    M4PR_IG_ADDRESS    ;
PROCEDURE    M4PR_IG_H_MOD_CON    ;
PROCEDURE    M4PR_IG_H_HR_LEGENT    ;
PROCEDURE    M4PR_IG_H_CATEGORIA    ;
PROCEDURE    M4PR_IG_H_CONTRATO    ;
PROCEDURE    M4PR_IG_H_CONV_CAT    ;
PROCEDURE    M4PR_IG_H_EMP_TYPE    ;
PROCEDURE    M4PR_IG_H_FONDO_PEN    ;
PROCEDURE    M4PR_IG_H_HR_JOB    ;
PROCEDURE    M4PR_IG_H_TYPE_ADJ    ;
PROCEDURE    M4PR_IG_PAYMENT_DATA    ;
PROCEDURE    M4PR_IG_PERSON    ;
PROCEDURE    M4PR_IG_PERSON_BANK    ;
PROCEDURE    M4PR_IG_PHONE_FAX    ;
PROCEDURE    M4PR_IG_HR_PERIOD    ;
PROCEDURE    M4PR_IG_HR_ROLE    ;
PROCEDURE    M4PR_IG_HT_MAR_STAT    ;
PROCEDURE    M4PR_IG_H_HR_TP_SAL    ;
PROCEDURE    M4PR_IG_H_OBRA_SOC    ;
PROCEDURE    M4PR_IG_HR    ;
PROCEDURE    M4PR_IG_EMAIL    ;  
PROCEDURE    M4PR_IG_HR_NAT    ;  
PROCEDURE    M4PR_IG_H_CONVENIO;  
PROCEDURE    M4PR_IG_HR_C_COSTO; 
PROCEDURE    M4PR_IG_H_HR_CALIFIC;
PROCEDURE    M4PR_IG_H_HR_UBICACI;
PROCEDURE    M4PR_IG_SUE_EMPV ; 


END M4PKG_EMPLEADO_LATAM;

/
--------------------------------------------------------
--  DDL for Package M4PKG_EMP_MOV_ORG_BR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_EMP_MOV_ORG_BR" 
IS

PROCEDURE M4PR_IG_CH_ORG_BR;
PROCEDURE M4PR_IG_H_UNIORG;
END M4PKG_EMP_MOV_ORG_BR; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_EMP_MOV_ORG_LATAM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_EMP_MOV_ORG_LATAM" 
IS

PROCEDURE M4PR_IG_CH_ORG;

END M4PKG_EMP_MOV_ORG_LATAM; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GL_DENARIUS_CDF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GL_DENARIUS_CDF" 
IS 

K_ARGENTINA varchar2(4) := '0010';
K_PERU varchar2(4) := '0050';
K_PARAGUAY varchar2(4) := '0030';
K_MEXICO varchar2(4) := '0070';
K_CHILE varchar2(4) := '0110';
K_COLOMBIA varchar2(4) := '0150';
K_BRASIL varchar2(4) := '0130';
K_URUGUAY varchar2(4) := '0090';

K_GL_GLOBAL varchar(4) := '0000';



   PROCEDURE MAIN_GL_ITFZ_CODIFICA_cdf    ( p_id_organization   IN   VARCHAR2, p_cdf varchar2,  p_fecha_desde  IN   DATE);   

END m4pkg_GL_DENARIUS_cdf; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GL_DENARIUS_NOVEDADES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GL_DENARIUS_NOVEDADES" 
IS 

K_ARGENTINA varchar2(4) := '0010';
K_PERU varchar2(4) := '0050';
K_PARAGUAY varchar2(4) := '0030';
K_MEXICO varchar2(4) := '0070';
K_CHILE varchar2(4) := '0110';
K_COLOMBIA varchar2(4) := '0150';
K_BRASIL varchar2(4) := '0130';
K_URUGUAY varchar2(4) := '0090';
K_GL_GLOBAL varchar(4) := '0000';


    PROCEDURE MAIN_GL_ITFZ_NOVEDADES    ( p_id_organization   IN   VARCHAR2, p_cdf varchar2,  p_fecha_desde  IN   DATE, p_emp varchar2);   

END m4pkg_GL_DENARIUS_NOVEDADES; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GL_HR_DENARIUS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GL_HR_DENARIUS" 
IS 

K_ARGENTINA varchar2(4) := '0010';
K_PERU varchar2(4) := '0050';
K_PARAGUAY varchar2(4) := '0030';
K_MEXICO varchar2(4) := '0070';
K_CHILE varchar2(4) := '0110';
K_COLOMBIA varchar2(4) := '0150';
K_BRASIL varchar2(4) := '0130';
K_URUGUAY varchar2(4) := '0090';

K_GL_GLOBAL varchar(4) := '0000';

    PROCEDURE MAIN_GL_ITFZ_PERSONAS( p_id_organization   IN   VARCHAR2,  p_emp  IN   VARCHAR2, p_idhr IN   VARCHAR2,  p_fecha_desde  IN   DATE);   

END m4pkg_GL_HR_DENARIUS; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GL_POST_LIQ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GL_POST_LIQ" 
IS 

K_ARGENTINA varchar2(4) := '0010';
K_PERU varchar2(4) := '0050';
K_PARAGUAY varchar2(4) := '0030';
K_MEXICO varchar2(4) := '0070';
K_CHILE varchar2(4) := '0110';
K_COLOMBIA varchar2(4) := '0150';
K_BRASIL varchar2(4) := '0130';
K_URUGUAY varchar2(4) := '0090';
K_GL_GLOBAL varchar(4) := '0000';


    PROCEDURE MAIN_GL_POST_LIQ   ( p_id_organization   IN   VARCHAR2);
    procedure ProcesoLiquidacion(p_idorg varchar2,p_nroliq number,  p_emp varchar2, p_prcerr  number, p_reproc number);

END m4pkg_GL_POST_LIQ; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GL_SIRADIG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GL_SIRADIG" 
IS 

/* **************************************************************************** 
FUNCION:    Exporta las deducciones de los impuestos a las ganancias cargados en M4
            en el modulo de SIRADIG a las bases de Denarius.

Version    Fecha        Autor           Descripcion
---------  ----------  ---------------  ------------------------------------
1.0        13/08/2015  Damian Oliver     1. Creacion del procedure y las funcionalidades basicas
1.1        28/08/2015  Benjamin Martinez 2. Se modifica procedure ya no se borra
                                            toda la tabla antes de insertar ahora se crea un ciclo en donde por
                                            cada registro se borra y luego se inserta.
2.0            12/10/2017 Alejandro Vila    nueva version se unifica la general con la particular  por empleado.
                                        (se debe cambiar  llamada a desde los obj de M4
                                            donde se llaman a M4PR_DEDUCC_IG_DEN y M4PR_EXP_DEDUC_SIR_X_LEGJAO
                                        )
***************************************************************************** */



K_ARGENTINA varchar2(4) := '0010';
K_PERU varchar2(4) := '0050';
K_PARAGUAY varchar2(4) := '0030';
K_MEXICO varchar2(4) := '0070';
K_CHILE varchar2(4) := '0110';
K_COLOMBIA varchar2(4) := '0150';
K_BRASIL varchar2(4) := '0130';
K_URUGUAY varchar2(4) := '0090';
K_GL_GLOBAL varchar(4) := '0000';


    PROCEDURE MAIN_GL_ITFZ_SIRADIG ( p_idorg IN   VARCHAR2, p_emp varchar2, p_anio number, p_std_id_hr varchar2);   

END m4pkg_GL_SIRADIG; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GT_CALCULO_J
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GT_CALCULO_J" 
as
    
--LAUTARO 29/05/17 CARGADO LOS FERIADOS EN UNA TABLA EN FORMATO <CALENDARIO>|<FECHA>
TYPE TYPE_TABLA_FERIADOS IS TABLE OF NUMBER
     INDEX BY VARCHAR2(64);
TABLA_FERIADOS TYPE_TABLA_FERIADOS;
     

TYPE TYPE_TABLA_ID_FERIADOS IS TABLE OF VARCHAR2(50)    
     INDEX BY VARCHAR2(64);
TABLA_ID_FERIADOS TYPE_TABLA_ID_FERIADOS;

     
TYPE R_DAY_CALEN IS RECORD (
        SCO_ID_DAY_CALENDA M4CCO_GT_DAYCL_DEF.SCO_ID_DAY_CALENDA%TYPE,
        CBR_CK_DIA_VIGILADOR M4CCO_GT_DAYCL_DEF.CBR_CK_DIA_VIGILADOR%TYPE, 
        CCO_START_HOUR M4CCO_GT_DAYCL_DEF.CCO_START_HOUR%tYPE,
        CCO_END_HOUR M4CCO_GT_DAYCL_DEF.CCO_END_HOUR%TYPE,
        CCO_FERIADO_PARCIAL M4CCO_GT_DAYCL_DEF.CCO_FERIADO_PARCIAL%TYPE
        );
TYPE TYPE_TABLA_TIPOS_FERIADO IS TABLE OF R_DAY_CALEN
     INDEX BY VARCHAR2(64);
TABLA_TIPOS_FERIADO TYPE_TABLA_TIPOS_FERIADO;

--LAUTARO 12/06/2017
TYPE TYPE_TABLA_TY_FERIADOS IS TABLE OF M4SCO_DAYCALEN_DEF.SCO_ID_DAYCALEN_TY%TYPE
     INDEX BY VARCHAR2(64);
TABLA_TY_FERIADOS TYPE_TABLA_TY_FERIADOS;


TYPE TYPE_TABLA_HR_SEG IS TABLE OF VARCHAR2(10)
    INDEX BY VARCHAR2(10);
    
TABLA_HR_SEG TYPE_TABLA_HR_SEG;


xapprole STD_HR_PERIOD.id_approle%type;
xsecuser STD_HR_PERIOD.id_secuser%type;


--MODULOS
K_MODULO_TT     M4cco_gt_param.CCO_ID_MODULO%type := 'GT_TIEMPO_TEORICO';
K_MODULO_TODOS  M4cco_gt_param.CCO_ID_MODULO%type := 'GT_ALL';
K_MODULO_CALC   M4cco_gt_param.CCO_ID_MODULO%type := 'GT_CALC_HORAS';
K_MODULO_AUSE   M4cco_gt_param.CCO_ID_MODULO%type := 'GT_CALC_AUSENCIAS';


--PARAMETROS
K_PARAM_DEBUG       M4cco_gt_param.CCO_ID_PARAM%type  := 'DEBUG';
--K_PARAM_TT_HR_DEBUG M4cco_gt_param.CCO_ID_PARAM%type  := 'HR_DEBUG';
K_PARAM_TT_DEBUG    M4cco_gt_param.CCO_ID_PARAM%type  := 'CALCULAR_TT_DEBUG';
K_PARAM_ALL_ID_HR   M4cco_gt_param.CCO_ID_PARAM%type  := 'ID_HR';
K_PARAM_ALL_DT_JORNADA  M4cco_gt_param.CCO_ID_PARAM%type  := 'DT_JORNADA';
K_PARAM_ID_PROCESO  M4cco_gt_param.CCO_ID_PARAM%type  := 'ID_PROCESO';
K_PARAM_DIAS_PROYEC M4cco_gt_param.CCO_ID_PARAM%type  := 'DIAS_TT_PROYEC'; --- 17/04/2018 ACV , usado para proyectar el tiempo teorico de una semana ---

G_ID_FALTA      m4sco_incidence.sco_id_incidence%type:='GT01';

--K_MODULE        varchar2(40) := 'EXEC_PROC';

G_ID_PROCESO M4CCO_GT_PROCESOS.CCO_ID_PROCESO%TYPE;
G_ID_ORGANIZATION VARCHAR2(4);
G_DT_DESDE DATE;
G_DT_HASTA DATE;
G_RETROACTIVO varchar2(1);
G_FCH_APLIC DATE;
G_AJUSTES integer;
--Lautaro 29/05/17
G_IDIOMA VARCHAR2(10);
--- 19/06/2017 ACV ---
G_TIPO_CALCULO  M4CCO_GT_TIP_CA_BL.CCO_ID_TIPO_CALCULO%type; 
g_chk_borro_todo varchar2(1);
G_DT_REFERENCIA DATE;
G_DT_PROYEC number;
G_DIVGEO M4CCO_GT_PROCESOS.STD_ID_GEO_DIV%type;

--LAUTARO 26/12/2017 DOTA261217
G_TIPO_PARAMETRO M4CCO_GT_HT_CALC.CCO_TIPO_PARAM%TYPE;
K_TIPO_PARAM_JERARQUIAS VARCHAR2(1):='J';
K_TIPO_PARAM_LEGAJOS VARCHAR2(1):='L';

--lautaro 09/10/17
--G_STD_ID_HR std_hr_person.std_id_hr%type;
g_Std_id_hr clob;

G_MArtes number(1);
G_Diasquerestan number(1);

G_escalculo varchar2(1);

G_FALTA_TRUCHA m4sco_incidence.sco_id_incidence%type:='F131';

K_TIPO_PRESENCIA VARCHAR2(1):='P';
K_TIPO_INTERVALO VARCHAR2(1):='A'; -- ausencia parcial ---
K_TIPO_ALMUERZO  VARCHAR2(1):='L';
K_TIPO_AUSJUST   VARCHAR2(1) := 'J';
K_TIPO_HRSREALES VARCHAR2(1) := 'T';  --- horas  trabajadas  segunmodelo  teorico comparados con las reales 
K_TIPO_FALTAS VARCHAR2(1)    := 'F';
K_TIPO_calculo VARCHAR2(1) := 'C';
K_TIPO_DESCANSO_INTERJ VARCHAR2(1) := 'D';
K_Tipo_hORAS_TOTALES VARCHAR2(1) := 'H'; --- horas totales reales
K_TIPO_HORAS_ADICIONALES varchar2(1) := 'S';
K_TIPO_NOCTURNIDAD varchar2(1) := 'N';
K_TIPO_AD_NOCTURNO varchar2(1) := 'X';
K_TIPO_ALM_6HR     varchar2(1) := 'I';
K_TIPO_SUMULA      varchar2(1) := 'Z'; 
K_TIPO_NO_SUMULA   varchar2(1) := 'Y';
K_TIPO_REDONDEO   varchar2(1) := 'R';
K_tipo_intrajor   varchar2(1) := 'W';

retval  M4cco_gt_param.CCO_VALOR%type;

K_TRUE integer := 1;
K_FALSE integer := 0;  
K_OK number := 1;
K_NO number := 0;
K_ERROR number := 0;
    
  
G_ANIO  number(4);
G_MES number(2);

g_approle std_hr_period.ID_APPROLE%type;
g_iduser  std_hr_period.ID_SECUSER%type;

K_FACTOR_DEC_HH  number := 24;
K_FACTOR_DEC_HHMM number := 1440;

K_FACTOR_MMHH number := 0.01666;
K_FACTOR_HHMM number := 60;

K_DEC   M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '1' ;
K_DECH  M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '2' ;
K_DATE  M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '3' ;

K_HORAS     M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '05';
K_MINUTOS   M4CCO_GT_TIPO_BLOQ.CCO_TUNIT_CANTIDADES%type := '06';

xuser varchar(40);

K_SUMA  varchar2(1) := '+';
K_RESTA varchar2(1) := '-';


--Function  ExecuteSentence(p_idorganization varchar2, p_idprocess varchar2, p_loguea  integer, p_onlyone  integer)  return  number;
K_TIPO_RESULTADO_NORMAL VARCHAR2(1) := 'N';
K_TIPO_RESULTADO_RETRO VARCHAR2(1) := 'R';  
K_TIPO_RESULTADO_RETRO_T VARCHAR2(1) := 'T';
K_TIPO_RESULTADO_AJUSTE VARCHAR2(1) := 'A';
 
K_FCH_FUT date  := to_date('01/01/4000','dd/mm/yyyy');

K_DMD        varchar2(30) := 'DMD_TA';
K_DMD_COMP   varchar2(30) := 'TA001';

K_COMMITS number  := 1000;
G_CNT_COMMITS number :=0;

K_VIGILADOR  varchar2(1) := 'V';

 
K_HORA_CERO varchar2(10) := '00:00:00';
K_HORA_FIN_DIA varchar2(10) := '23:59:59';
K_HORA_FIN_DIA2 varchar2(10) := '23:59:00';


g_id_hr_Rcalc  std_hr_period.std_id_hr%type;
G_ID_BLK_RCALC   varchar2(20);
G_ID_tyblk_RCALC  varchar2(20);
G_RECURSIVO number(1);
G_dt_recalc_d date := NULL;
G_dt_recalc_h date := NULL;


  Function  ConversionUnid(p_fch date, p_hrs number, p_unido varchar2, p_unid varchar2) return number;  
  Function  GetVlParameter(p_idorg varchar2, p_module varchar2, p_param varchar2) return varchar2;
  --Function  GetVlParameter(p_idorg varchar2, p_module varchar2, p_param varchar2) return varchar2; 
  PROCEDURE GetID_ORGANIZATION(P_ID_PROCESO IN VARCHAR2);
  PROCEDURE GetDT_DESDE_HASTA(P_ID_PROCESO IN VARCHAR2);
  PROCEDURE CALCULAR_DOTACION(P_ID_PROCESO IN VARCHAR2);    
  PROCEDURE M4PR_GT_CALCULAR_TT (pID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_ARMAR_BLOQUES_X_HR(P_ID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_TOTALIZA_HORAS (P_ID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_TOTALIZA_INTERVALOS (P_ID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_JUSTIFICA_AUSENCIAS(pID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_GENERA_INCIDENCIAS(pID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_CALCULO_AUSENCIAS(pID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_CALCULO_HORAS(pID_PROCESO IN VARCHAR2);
  PROCEDURE M4PR_GT_CALCULAR_HR_TT (PID_PROCESO IN VARCHAR2, p_StdIdHr IN VARCHAR2,p_DT_sTART_REF_MOD IN DATE,p_FechaInicio IN  DATE,p_FechaFin IN DATE, p_calendefault varchar2, p_debug in varchar);
      Procedure CALCULO_HORAS_POR_LOTES(PID_PROCESO varchar2);
  PROCEDURE NUEVO_ERROR(P_MODULO IN VARCHAR2, PID_HR IN VARCHAR2, P_ERROR IN VARCHAR2);
  FUNCTION  PROCESO_CERRADO(PID_PROCESO varchar2) return  integer;
  PROCEDURE INICIALIZO_RESULTADO(PID_PROCESO varchar2);
  PROCEDURE GeneroAjuste(PID_PROCESO varchar2);
  Procedure LiberoLegajos(PID_PROCESO varchar2);
  Procedure CalculaHorasADicionales(PID_PROCESO varchar2);
  Procedure ANALISIS_ALMUERZO(PID_PROCESO varchar2);
  --LAUTARO 29/05/17
  PROCEDURE M4PR_GT_CARGAR_FERIADOS(pid_proceso in varchar2);
    --LAUTARO 12/06/17
  PROCEDURE M4PR_GT_CARGA_HR_SEG(pid_proceso in varchar2);
  PROCEDURE Analizo_Faltas_Justificadas(PID_PROCESO varchar2 );
  Procedure Inicio_SAldos_Bco_Horas(PID_PROCESO varchar2);
  FUNCTION M4GetPLSQLSentence2(p_population varchar2) return clob;
  FUNCTION M4GetPLSQLSentence(p_idorg varchar2, p_population varchar2) return clob;
  FUNCTION PROCESO_TIPO_CALCULO(PID_PROCESO varchar2) return varchar2;
  PROCEDURE SETPROCESOINI;

end M4PKG_GT_CALCULO_J;

/
--------------------------------------------------------
--  DDL for Package M4PKG_GT_CALCULO_MLTTHRD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GT_CALCULO_MLTTHRD" as 

    cursor  c_gdiv(p_idorganization varchar2, p_country varchar2) is 
        select * from std_geo_div where id_organization = p_idorganization
            and std_id_country = p_country
                --and std_id_geo_div = 'DF'
                ;

    cursor    c_emp(p_idorg varchar2, p_idplanif varchar2) is             
        select * from M4cco_gt_plan_emps
            where id_organization = p_idorg 
                and  cco_id_plan = p_idplanif;
                
                
                
    reg_div c_gdiv%rowtype;
    reg_emp c_emp%rowtype;

    jobs_max number := 100;
    jobs_plain number := 0;


    pRESULT_ana VARCHAR2(40);
    presult_calc varchar2(40);
    sSQL VARCHAR2(1000);
    ID_CALCULO VARCHAR2(50);
    FDESDE DATE;
    FHASTA DATE;

    mmyyyy varchar2(10);
    dia  number;
    nivel number;
    msgerr clob;

    G_ID_PROCESO varchar2(40); 

    hoy date;

    G_Today date;

    regdesde  number(9);
    reghasta  number(9);

    por_region number(1);
    por_empresa number(1);
    por_registro number(1);
    cnt_registros M4CCO_GT_MNG_THRD.CCO_CNT_REGISTROS%type;
    cntmax   M4CCO_GT_MNG_THRD.CCO_MAX_cnt%type;

     idplanifc  M4CCO_GT_PLAN_EJEC.CCO_ID_PLAN%type;

    PROCEDURE MAIN_EJECUTOR(p_idorg varchar2, p_idproceso varchar2, p_country varchar2, p_fechref date, p_idplanif varchar2, p_idpolitic varchar2,  p_concalc number);

end m4PKG_GT_CALCULO_MLTTHRD;

/
--------------------------------------------------------
--  DDL for Package M4PKG_GT_ESPAÑA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GT_ESPAÑA" 
as
--- COnstyantes---
K_HORAS  M4CCO_GT_PLUS_OCUR.CCO_UNIDAD_PATRON%type := 'H';
K_UNIDADES  M4CCO_GT_PLUS_OCUR.CCO_UNIDAD_PATRON%type := 'U';

--- constantes de p/ bloques de calculo ---
K_IF varchar2(2) := 'IF';
K_CASE_WHEN varchar2(15) := ' CASE WHEN ';

K_TIPO_calculo M4cco_gt_tipo_bloq.CCO_TIPO_ANALISIS%type  := 'C';

K_SUMA  varchar2(1) := '+';
K_RESTA varchar2(1) := '-';

K_MODULO_CALC   M4cco_gt_param.CCO_ID_MODULO%type := 'GT_CALC_HORAS';
K_PARAM_DEBUG       M4cco_gt_param.CCO_ID_PARAM%type  := 'DEBUG';
K_TOPE       varchar2(4) := 'TOPE';

--MODULOS
K_MODULO_TT     M4cco_gt_param.CCO_ID_MODULO%type := 'GT_TIEMPO_TEORICO';
K_MODULO_TODOS  M4cco_gt_param.CCO_ID_MODULO%type := 'GT_ALL';
K_MODULO_AUSE   M4cco_gt_param.CCO_ID_MODULO%type := 'GT_CALC_AUSENCIAS';

--PARAMETROS
--K_PARAM_TT_HR_DEBUG M4cco_gt_param.CCO_ID_PARAM%type  := 'HR_DEBUG';
K_PARAM_TT_DEBUG    M4cco_gt_param.CCO_ID_PARAM%type  := 'CALCULAR_TT_DEBUG';
K_PARAM_ALL_ID_HR   M4cco_gt_param.CCO_ID_PARAM%type  := 'ID_HR';
K_PARAM_ALL_DT_JORNADA  M4cco_gt_param.CCO_ID_PARAM%type  := 'DT_JORNADA';
K_PARAM_ID_PROCESO  M4cco_gt_param.CCO_ID_PARAM%type  := 'ID_PROCESO';
K_PARAM_DIAS_PROYEC M4cco_gt_param.CCO_ID_PARAM%type  := 'DIAS_TT_PROYEC'; --- 17/04/2018 ACV , usado para proyectar el tiempo teorico de una semana ---

msgerr clob;


TYPE REG_BLOQUE_F IS RECORD (
    CCO_ID_TIPO_BLOQUE        VARCHAR2 (20 Char)    ,
    CCO_ID_BLOQUE        VARCHAR2 (20 Char)    ,
    CCO_TOPE        NUMBER (8,4)    ,
    CCO_TOLERANCIA        NUMBER (15,2)    ,
    SCO_ID_TIME_UNIT        VARCHAR2 (6 Char)    ,
    CCO_REDONDEO        NUMBER (15,2)    ,
    SCO_ID_TIME_UNI_RE        VARCHAR2 (6 Char)    ,
    CCO_HORA_DESDE        DATE    ,
    CCO_HORA_HASTA        DATE    ,
    CCO_TIPO_ANALISIS     M4cco_gt_tipo_bloq.CCO_TIPO_ANALISIS%type   ,
    CCO_GRUPO_CALCULO        VARCHAR2 (2 Char)    ,
    CCO_CANT_DESDE        NUMBER (5,2)    ,
    CCO_CANT_HASTA        NUMBER (5,2)    ,
    CCO_ID_OCURRENCIA        VARCHAR2(20),    
    CHK_ACUMULA number (1,0), 
    CCO_FACTORSALDO     number (9,4),      CCO_TUNIT_CANTIDADES varchar2 (6),
    CCO_FACTOR_OCURR     number (9,4),
    CCO_CK_NORMAL number (1,0),
    CCO_CK_FOLGA number (1,0),
    CCO_CK_FOLGA_C number (1,0),
    CCO_CK_FERIADO number (1,0),
    CCO_CK_HRS_CONTRAC varchar2 (1),
    CCO_HR_LMT_NOCTUR date,
    CCO_ID_TIPO_HR_AD varchar2(20),
    CCO_CK_FER_VIGI number(1,0),
    CCO_FRECUENCIA_ANALISIS number(4),
    CCO_FRECUENCIA_ANALISIS_A number(4),
    CCO_ID_OCURRENCIA_ALTER    VARCHAR2(20),
    CCO_CK_INI_MONDAY number(1),
    CCO_FREC_ANALISIS_2 number(4),
    ID_BENEFICIO varchar2 (8),
    CCO_CK_EVAL_HORARIO    NUMBER (1),        
    CCO_EVAL_TOLER_I    VARCHAR2 (2 Byte),        
    CCO_EVAL_TOLER_O    VARCHAR2 (2 Byte),        
    CCO_TOLERANCIA_O    NUMBER (15,2),
    CCO_MIN_TFEST number (2,0),
    CCO_INCLU_AUSEN number(1)
    );

TYPE REG_BLOQUE_clcHRS IS RECORD (
    CCO_ID_TIPO_BLOQUE        VARCHAR2 (20 Char)    ,
    CCO_ID_BLOQUE        VARCHAR2 (20 Char)    ,
    CCO_TOPE        NUMBER (8,4)    ,
    CCO_TOLERANCIA        NUMBER (15,2)    ,
    SCO_ID_TIME_UNIT        VARCHAR2 (6 Char)    ,
    CCO_REDONDEO        NUMBER (15,2)    ,
    SCO_ID_TIME_UNI_RE        VARCHAR2 (6 Char)    ,
    CCO_HORA_DESDE        DATE    ,
    CCO_HORA_HASTA        DATE    ,
    CCO_TIPO_ANALISIS        M4cco_gt_tipo_bloq.CCO_TIPO_ANALISIS%type ,
    CCO_GRUPO_CALCULO        VARCHAR2 (2 Char)    ,
    CCO_CANT_DESDE        NUMBER (5,2)    ,
    CCO_CANT_HASTA        NUMBER (5,2)    ,
    CCO_ID_OCURRENCIA        VARCHAR2(20),    
    CHK_ACUMULA number (1,0), 
    CCO_FACTORSALDO     number (9,4),      
    CCO_TUNIT_CANTIDADES varchar2 (6),
    CCO_FACTOR_OCURR     number (9,4),
    CCO_CK_NORMAL number (1,0),
    CCO_CK_FOLGA number (1,0),
    CCO_CK_FOLGA_C number (1,0),
    CCO_CK_FERIADO number (1,0),
    CCO_CK_HRS_CONTRAC varchar2 (1),
    CCO_HR_LMT_NOCTUR date,
    CCO_CK_FER_VIGI number(1,0),
    CCO_CK_SOLO_FICH_IN number(1,0),
    CCO_CK_SOLAPE number(1,0),
    CCO_CK_INI_MONDAY number(1,0),
    CCO_ID_OCURRENCIA_ALTER  VARCHAR2(20),
    ID_BENEFICIO varchar2 (8),
    CCO_CK_EVAL_HORARIO    NUMBER (1),        
    CCO_EVAL_TOLER_I    VARCHAR2 (2 Byte),        
    CCO_EVAL_TOLER_O    VARCHAR2 (2 Byte),        
    CCO_TOLERANCIA_O    NUMBER (15,2)        
    );


TYPE T_REG_CLCHRS IS RECORD (
        ID_HR VARCHAR2(9),
        DT_JORNADA DATE,
        HS_TEORICAS NUMBER(5,2),
        CK_FERIADO VARCHAR2(1),
        HS_TEORICAS_COMP NUMBER(5,2),
        CK_FALTA_JUSTIFICADA VARCHAR2(1),
        HS_REALES NUMBER(5,2),
        HS_INTERVALO NUMBER(5,2),
        TY_JORNADA VARCHAR2(3),
        HRS_ALMUERZO number(5,2)
        --LAUTARO 30/05/17
        ,sco_id_day_calendar VARCHAR2(50)
    );



--LAUTARO 29/05/17 CARGADO LOS FERIADOS EN UNA TABLA EN FORMATO <CALENDARIO>|<FECHA>
TYPE TYPE_TABLA_FERIADOS IS TABLE OF NUMBER
     INDEX BY VARCHAR2(64);
TABLA_FERIADOS TYPE_TABLA_FERIADOS;
     

TYPE TYPE_TABLA_ID_FERIADOS IS TABLE OF VARCHAR2(50)    
     INDEX BY VARCHAR2(64);
TABLA_ID_FERIADOS TYPE_TABLA_ID_FERIADOS;

     
TYPE R_DAY_CALEN IS RECORD (
        SCO_ID_DAY_CALENDA M4CCO_GT_DAYCL_DEF.SCO_ID_DAY_CALENDA%TYPE,
        CBR_CK_DIA_VIGILADOR M4CCO_GT_DAYCL_DEF.CBR_CK_DIA_VIGILADOR%TYPE, 
        CCO_START_HOUR M4CCO_GT_DAYCL_DEF.CCO_START_HOUR%tYPE,
        CCO_END_HOUR M4CCO_GT_DAYCL_DEF.CCO_END_HOUR%TYPE,
        CCO_FERIADO_PARCIAL M4CCO_GT_DAYCL_DEF.CCO_FERIADO_PARCIAL%TYPE
        );
TYPE TYPE_TABLA_TIPOS_FERIADO IS TABLE OF R_DAY_CALEN
     INDEX BY VARCHAR2(64);
TABLA_TIPOS_FERIADO TYPE_TABLA_TIPOS_FERIADO;

--LAUTARO 12/06/2017
TYPE TYPE_TABLA_TY_FERIADOS IS TABLE OF M4SCO_DAYCALEN_DEF.SCO_ID_DAYCALEN_TY%TYPE
     INDEX BY VARCHAR2(64);
TABLA_TY_FERIADOS TYPE_TABLA_TY_FERIADOS;

TYPE TYPE_TABLA_HR_SEG IS TABLE OF VARCHAR2(10)
    INDEX BY VARCHAR2(10);
    
TABLA_HR_SEG TYPE_TABLA_HR_SEG;


g_varglobals M4PKG_CALCULO_STD.TY_GLOBALS;


Cursor c_fich_det(p_idorg vARCHAR2, p_idhr varchar2,p_fchdesde date, p_fchhasta date) is    
    select  t.CCO_DT_JORNADA, CCO_HH_ENTRADA, CCO_HH_SALIDA, t.CCO_TY_JORNADA tydia 
               from M4CCO_GT_HORAS H,   M4CCO_GT_JORNADA_T T
                WHERE  
                t.id_organization  = P_IDORG
                    and t.std_id_hr = p_idhr
                             and t.cco_dt_jornada between p_fchdesde and p_fchhasta
                           -- and ( t.CCO_HH_ENTRADA between '16feb2017' and '15mar2017'
                           --     or t.CCO_HH_SALIDA between '16feb2017' and '15mar2017')
                    and h.id_organization  (+) = t.id_organization
                    and h.std_id_hr         (+)= t.std_id_hr
                    AND H.STD_OR_PERIOD     (+) = T.STD_OR_HR_PERIOD
                    and h.cco_dt_jornada    (+)= t.cco_dt_jornada                                
                                order  by t.CCO_DT_JORNADA,CCO_HH_ENTRADA ;
                                
                                


CURSOR cur_Jornada (P_IDORG VARCHAR2, p_Empleado IN VARCHAR2, p_dtrefmod date)IS
    SELECT 
    /*+ PARALLEL (A,4)*/ /*+ PARALLEL (B,4)*/ /*+ PARALLEL (C,4)*/ /*+ PARALLEL (D,4)*/ 
    /*+ PARALLEL (EMON,4)*/ /*+ PARALLEL (dtmon,4)*/ /*+ PARALLEL (lunmon,4)*/
    /*+ PARALLEL (ETUE,4)*/ /*+ PARALLEL (dttue,4)*/ /*+ PARALLEL (luntue,4)*/
    /*+ PARALLEL (EEWD,4)*/ /*+ PARALLEL (dtwed,4)*/ /*+ PARALLEL (lunwed,4)*/
    /*+ PARALLEL (ETHR,4)*/ /*+ PARALLEL (dtthr,4)*/ /*+ PARALLEL (lunthr,4)*/
    /*+ PARALLEL (EFRI,4)*/ /*+ PARALLEL (dtfri,4)*/ /*+ PARALLEL (lunfri,4)*/
    /*+ PARALLEL (ESAT,4)*/ /*+ PARALLEL (dtsat,4)*/ /*+ PARALLEL (lunsat,4)*/
    /*+ PARALLEL (ESUN,4)*/ /*+ PARALLEL (dtsun,4)*/ /*+ PARALLEL (lunsun,4)*/
    /*+ PARALLEL (proxi,4)*/
    A.ID_ORGANIZATION ID_ORGANIZATION,
    B.SCO_OR_REF_MOD NRO_SEMANA, 
    nvl(EMON.SCO_WKNG_HRS_DAY,0) HR_MON,
    nvl(ETUE.SCO_WKNG_HRS_DAY,0) HR_TUE,
    nvl(EWED.SCO_WKNG_HRS_DAY,0) HR_WED,
    nvl(ETHR.SCO_WKNG_HRS_DAY,0) HR_THR,
    nvl(EFRI.SCO_WKNG_HRS_DAY,0) HR_FRI,
    nvl(ESAT.SCO_WKNG_HRS_DAY,0) HR_SAT,
    nvl(ESUN.SCO_WKNG_HRS_DAY,0) HR_SUN,
    nvl(dtMON.CCO_TIPO_dia  ,0)   tdmon,
    nvl(dtTUE.CCO_TIPO_dia  ,0)   tdtue,
    nvl(dtWED.CCO_TIPO_dia  ,0)   tdwed,
    nvl(dtTHR.CCO_TIPO_dia  ,0)   tdthr,
    nvl(dtFRI.CCO_TIPO_dia  ,0)   tdfri,
    nvl(dtSAT.CCO_TIPO_dia  ,0)   tdsat,
    nvl(dtSUN.CCO_TIPO_dia  ,0)   tdsun,
    nvl(lunMON.CCO_HRS_ALMUERZO ,0)   lmon,
    nvl(lunTUE.CCO_HRS_ALMUERZO  ,0)   ltue,
    nvl(lunWED.CCO_HRS_ALMUERZO ,0)   lwed,
    nvl(lunTHR.CCO_HRS_ALMUERZO  ,0)   lthr,
    nvl(lunFRI.CCO_HRS_ALMUERZO  ,0)   lfri,
    nvl(lunSAT.CCO_HRS_ALMUERZO  ,0)   lsat,
    nvl(lunSUN.CCO_HRS_ALMUERZO ,0)   lsun,
    nvl(dtMON.CBR_HRS_COMP_FOLGA,0)   hcmon,
    nvl(dtTUE.CBR_HRS_COMP_FOLGA,0)   hctue,
    nvl(dtWED.CBR_HRS_COMP_FOLGA,0)   hcwed,
    nvl(dtTHR.CBR_HRS_COMP_FOLGA,0)   hcthr,
    nvl(dtFRI.CBR_HRS_COMP_FOLGA,0)   hcfri,
    nvl(dtSAT.CBR_HRS_COMP_FOLGA,0)  hcsat,
    nvl(dtSUN.CBR_HRS_COMP_FOLGA,0)   hcsun,
    proxi.CCO_NEXT,
    d.CCO_ID_TIPO_BLOQUE, 
    d.CCO_ID_BLOQUE, 
    d.SCO_OR_WEEK,
    a.SCO_ID_REF_MOD
    FROM M4SCO_HR_THEOR_TIM A,
    M4SCO_REF_W_MOD B,
    M4SCO_HW_MODEL C,
    M4SCO_WEEK D,
    M4SCO_DAY_TYPE EMON,
    m4cco_gt_day_type dtmon,
    m4cco_gt_day_type lunmon,
    M4SCO_DAY_TYPE ETUE,
    m4cco_gt_day_type dttue,
    m4cco_gt_day_type luntue,
    M4SCO_DAY_TYPE EWED,
    m4cco_gt_day_type dtwed,
    m4cco_gt_day_type lunwed,
    M4SCO_DAY_TYPE ETHR,
    m4cco_gt_day_type dtthr,
    m4cco_gt_day_type lunthr,
    M4SCO_DAY_TYPE EFRI,
    m4cco_gt_day_type dtfri,
    m4cco_gt_day_type lunfri,
    M4SCO_DAY_TYPE ESAT,
    m4cco_gt_day_type dtsat,
    m4cco_gt_day_type lunsat,
    M4SCO_DAY_TYPE ESUN,
    m4cco_gt_day_type dtsun,
    m4cco_gt_day_type lunsun,
    M4CCO_gt_REF_W_MOD proxi
WHERE  B.SCO_ID_REF_MOD=A.SCO_ID_REF_MOD
   --AND ((B.SCO_OR_REF_MOD>=A.SCO_OR_REF_MOD and p_todas = 1) or (B.SCO_OR_REF_MOD is not null and  p_todas = 0)) 
   AND C.SCO_ID_WEEK_MDL=B.SCO_ID_WEEK_MDL
   AND D.SCO_OR_WEEK(+)=C.SCO_OR_WEEK
   AND EMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND ETUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND EWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND ETHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND EFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND ESAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND ESUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND dtMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND dtTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND dtWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND dtTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND dtFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND dtSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND dtSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND lunMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND lunTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND lunWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND lunTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND lunFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND lunSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND lunSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   and A.std_id_hr = p_Empleado
   AND A.DT_START = p_dtrefmod
   and b.sco_id_ref_mod = proxi.SCO_ID_REF_MOD
   and b.SCO_OR_REF_MOD = proxi.SCO_OR_REF_MOD
   /*LAUTARO 19/01/17*/
   AND A.ID_ORGANIZATION=P_IDORG
   --LAUTARO 29/05/17
    AND C.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND D.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EMON.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETUE.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dttue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND luntue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EWED.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETHR.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EFRI.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESAT.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESUN.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsun.ID_ORGANIZATION=B.ID_ORGANIZATION
    and lunsun.ID_ORGANIZATION=B.ID_ORGANIZATION
ORDER BY B.SCO_OR_REF_MOD ASC;


CURSOR cur_Jornada3 (p_idorg varchar2, p_Empleado IN VARCHAR2, p_dtrefmod date)IS
    SELECT 
    /*+ PARALLEL (A,4)*/ /*+ PARALLEL (B,4)*/ /*+ PARALLEL (C,4)*/ /*+ PARALLEL (D,4)*/ 
    /*+ PARALLEL (EMON,4)*/ /*+ PARALLEL (dtmon,4)*/ /*+ PARALLEL (lunmon,4)*/
    /*+ PARALLEL (ETUE,4)*/ /*+ PARALLEL (dttue,4)*/ /*+ PARALLEL (luntue,4)*/
    /*+ PARALLEL (EEWD,4)*/ /*+ PARALLEL (dtwed,4)*/ /*+ PARALLEL (lunwed,4)*/
    /*+ PARALLEL (ETHR,4)*/ /*+ PARALLEL (dtthr,4)*/ /*+ PARALLEL (lunthr,4)*/
    /*+ PARALLEL (EFRI,4)*/ /*+ PARALLEL (dtfri,4)*/ /*+ PARALLEL (lunfri,4)*/
    /*+ PARALLEL (ESAT,4)*/ /*+ PARALLEL (dtsat,4)*/ /*+ PARALLEL (lunsat,4)*/
    /*+ PARALLEL (ESUN,4)*/ /*+ PARALLEL (dtsun,4)*/ /*+ PARALLEL (lunsun,4)*/
    /*+ PARALLEL (proxi,4)*/
    B.SCO_OR_REF_MOD NRO_SEMANA 
    FROM M4SCO_HR_THEOR_TIM A,
    M4SCO_REF_W_MOD B,
    M4SCO_HW_MODEL C,
    M4SCO_WEEK D,
    M4SCO_DAY_TYPE EMON,
    m4cco_gt_day_type dtmon,
    m4cco_gt_day_type lunmon,
    M4SCO_DAY_TYPE ETUE,
    m4cco_gt_day_type dttue,
    m4cco_gt_day_type luntue,
    M4SCO_DAY_TYPE EWED,
    m4cco_gt_day_type dtwed,
    m4cco_gt_day_type lunwed,
    M4SCO_DAY_TYPE ETHR,
    m4cco_gt_day_type dtthr,
    m4cco_gt_day_type lunthr,
    M4SCO_DAY_TYPE EFRI,
    m4cco_gt_day_type dtfri,
    m4cco_gt_day_type lunfri,
    M4SCO_DAY_TYPE ESAT,
    m4cco_gt_day_type dtsat,
    m4cco_gt_day_type lunsat,
    M4SCO_DAY_TYPE ESUN,
    m4cco_gt_day_type dtsun,
    m4cco_gt_day_type lunsun,
    M4CCO_gt_REF_W_MOD proxi
WHERE  B.SCO_ID_REF_MOD=A.SCO_ID_REF_MOD
   --AND ((B.SCO_OR_REF_MOD>=A.SCO_OR_REF_MOD and p_todas = 1) or (B.SCO_OR_REF_MOD is not null and  p_todas = 0)) 
   AND C.SCO_ID_WEEK_MDL=B.SCO_ID_WEEK_MDL
   AND D.SCO_OR_WEEK(+)=C.SCO_OR_WEEK
   AND EMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND ETUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND EWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND ETHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND EFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND ESAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND ESUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND dtMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND dtTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND dtWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND dtTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND dtFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND dtSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND dtSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND lunMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND lunTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND lunWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND lunTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND lunFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND lunSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND lunSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   and A.std_id_hr = p_Empleado
   AND A.DT_START = p_dtrefmod
   and b.sco_id_ref_mod = proxi.SCO_ID_REF_MOD
   and b.SCO_OR_REF_MOD = proxi.SCO_OR_REF_MOD
   /*LAUTARO 19/01/17*/
   AND A.ID_ORGANIZATION= p_idorg
   --LAUTARO 29/05/17
    AND C.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND D.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EMON.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETUE.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dttue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND luntue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EWED.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETHR.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EFRI.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESAT.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESUN.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsun.ID_ORGANIZATION=B.ID_ORGANIZATION
    and lunsun.ID_ORGANIZATION=B.ID_ORGANIZATION
ORDER BY B.SCO_OR_REF_MOD ASC;





    
Type Atab_WkTybloq is table of M4SCO_WEEK%rowtype index by binary_integer;     
Type Atab_WkBloq  is table of M4SCO_WEEK%rowtype index by binary_integer;  
Type Atab_WkModel is table of M4SCO_WEEK%rowtype index by binary_integer;    
type Atab_modref  is table of M4SCO_ref_mod%rowtype index by binary_integer;  
    
    
TYPE ATabMonday  IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabTuesday IS  TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabWednesday IS  TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabThursday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabFriday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabSaturday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabSunday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabNroSemana IS TABLE OF M4SCO_REF_W_MOD.SCO_OR_REF_MOD%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabIdOrg IS TABLE OF M4CCO_GT_JORNADA_T.ID_ORGANIZATION%TYPE INDEX BY BINARY_INTEGER;


TYPE TyTabMonday  IS TABLE OF    m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabTuesday IS  TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabWednesday IS  TABLE OF m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabThursday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabFriday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabSaturday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabSunday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;

TYPE lunTabMonday  IS TABLE OF    m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabTuesday IS  TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabWednesday IS  TABLE OF m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabThursday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabFriday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabSaturday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabSunday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;

TYPE nextTabWeek IS TABLE OF M4CCO_gt_REF_W_MOD%ROWTYPE INDEX BY BINARY_INTEGER;


--- 12/05/217 ACV  analisis de  horaria fihadas extras ---
type tytabfichadas is Table of M4CCO_GT_HORAS%rowtype index by binary_integer;
arr_fichadas tytabfichadas;



-- Declaracion arreglo de tabla
arr_Monday ATabMonday ;
arr_Tuesday ATabTuesday;
arr_Wednesday ATabWednesday;
arr_Thursday ATabThursday;
arr_Friday ATabFriday;
arr_Saturday ATabSaturday;
arr_Sunday ATabSunday;
arr_NroSemana ATabNroSemana;
arr_IdOrg ATabIdOrg;

arr_tyMonday    tyTabMonday ;
arr_tyTuesday   tyTabTuesday;
arr_tyWednesday tyTabWednesday;
arr_tyThursday  tyTabThursday;
arr_tyFriday    tyTabFriday;
arr_tySaturday  tyTabSaturday;
arr_tySunday    tyTabSunday;


arr_lMonday    lunTabMonday ;
arr_lTuesday   lunTabTuesday;
arr_lWednesday lunTabWednesday;
arr_lThursday  lunTabThursday;
arr_lFriday    lunTabFriday;
arr_lSaturday  lunTabSaturday;
arr_lSunday    lunTabSunday;

arr_nextweek  nextTabWeek;

arr_tbloq  Atab_WkTyBLoq;
arr_bloq   Atab_WkBloq;
arr_wkmodel Atab_WkModel;
arr_modref Atab_modref;

ind_DetalleSem NUMBER(10):= 1; -- almacena el indice de los arreglos almacenados en memoria.
ind NUMBER(10):= 0;
i_DimArrDS NUMBER(10):= 0; -- almacena la dimension de los arreglos.
v_DiaSemana NUMBER(1); -- almacena el numero de dia retornado por la funcion numero dia de la semana.
v_DiaDetalleSem NUMBER(1); -- almacena el numero de dia de semana iniciado en el dia LUNES
v_IdOrganization M4CCO_GT_JORNADA_T.ID_ORGANIZATION%TYPE;
n_HrsDay M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE; --almacena la cantidad de horas trabajabas por dia

xuser varchar(40);
xapprole STD_HR_PERIOD.id_approle%type;
xsecuser STD_HR_PERIOD.id_secuser%type;


--- analisis  España --- 
K_TIPO_FESTIVO_NORMAL M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'FN';
K_TIPO_PLUS_DOMINGO M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'D';
K_TIPO_FESTIVO_ESPECIAL M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'FE';
K_TIPO_PLUS_TRANSPORTE M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'TR';
K_TIPO_PLUS_NOCTURNIDAD M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'N'; 
--K_TIPO_HRS_xord_FEST    M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'X?' ; -- cambiando el horario es extrarodinaria festiva nocturna o doiurna
K_TIPO_HR_EXTRA_DIURNA M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'XD'; --- cambiando el horario es nocturna o diurna---
K_TIPO_HR_EXTRA_NOC M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'XN'; --- cambiando el horario es nocturna o diurna---
K_TIPO_HR_EXTRA_FEST_NODOM M4CCO_GT_TIPO_BLOQ.CCO_TIPO_ANALISIS%type := 'XF'; --- cambiando el horario es nocturna o diurna--- 



--- NOTA: ACV 19/09/2019, los  metodos publicos debn seguir este conjunto de parametros ---
PROCEDURE  M4PR_GT_CARGAR_FERIADOS_P( p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
PROCEDURE  M4PR_GT_CARGAR_SEGURIDAD_P( p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
PROCEDURE  M4PR_GT_GENERO_PLUS_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
Procedure CALCULO_HORAS_POR_LOTES_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
Procedure  M4PR_GT_CALCULAR_TT_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
Procedure CALCULAR_DOTACION_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
Procedure M4PR_GT_CALCULO_HORAS_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
Procedure ESP_LIBERO_LEGAJOS_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
procedure M4PR_INIT_RESULT_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
procedure M4PR_BLOQUES_X_HR_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);
procedure M4pr_tot_horas_P(p_idorg varchar2, p_idproc varchar2, p_module varchar2, p_blk varchar2, p_tyblkk varchar2, p_analisis varchar2, p_orden number, p_item number);


end M4PKG_GT_ESPAÑA;

/
--------------------------------------------------------
--  DDL for Package M4PKG_GT_NOVE_VIGIA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GT_NOVE_VIGIA" 
is
    K_INSERT M4CCO_INT_DAT_LIEX.CSP_ID_OPERACION%type := 'UPSERT';
    K_DELETE M4CCO_INT_DAT_LIEX.CSP_ID_OPERACION%type := 'DELETE';
    K_NORECTIFICADO M4CCO_INT_DAT_LIEX.CCO_RECTIFICADO%type:= 'N';
    K_SIRECTIFICADO M4CCO_INT_DAT_LIEX.CCO_RECTIFICADO%type:= 'S';

    K_NOVHRS varchar2(10) := 'FICHADAS';
    K_NOVESC varchar2(10) := 'ESCALAS';
    K_COMMITS number := 1000;
    

    cursor c_horas(p_idorg varchar2, p_itfz varchar2, p_filial varchar2, p_fchref date,p_nrolegajo varchar2) is 
        select /*+parallel (h,4)*/ /*+parallel(f,4)*/ h.id_organization, f.CCO_SECUENCIAL, f.CCO_ID_WLOC_FILIAL,
                h.CCO_DT_INICIO, h.CCO_DT_FIN, h.CCO_ORIGEN, f.CCO_TP_DATOS, f.CCO_ORIGEN_INTERFAZ, 
                h.STD_ID_HR, h.FECHAASIG, h.COD_CLIENTE_VIGIA, h.COD_SUBCLIENTE_VIG, h.SCO_OR_DATOS_LIEXT, 
                h.CCO_DIA_E, h.CCO_DIA_S, h.CCO_HORA_E, h.CCO_HORA_S, h.CCO_TURNO   --, h.COD_ID_DELEG, h.CCO_CK_FESTIVO, h.CCO_RECTIFICADO, h.CSP_ID_OPERACION 
         from 
            M4CCO_WS_FILE_VIGI f,  M4CCO_INT_DAT_LIEX h
                where f.id_organization = p_idorg   
                     and ((f.cco_origen = p_itfz and p_itfz is not null ) or (f.cco_origen is not null and p_itfz is null))
                     and f.CCO_CK_PROCESADO = 1
                     and f.id_organization = h.id_organization 
                     and f.CCO_DT_INICIO = h.cco_dt_inicio
                     and f.CCO_DT_FIN = h.cco_dt_fin
                     and ((h.std_id_hr = p_nrolegajo and p_nrolegajo is not null) or (h.std_id_hr is not null and  p_nrolegajo is null) )
                     and f.CCO_ORIGEN = h.cco_origen
                     --and h.std_id_hr = '701218'
                     and h.cco_ck_procesado = 0
                    and h.CSP_ID_OPERACION = K_INSERT  -- se tienen en cuenta retificados 
                     --and h.CCO_RECTIFICADO  = K_NORECTIFICADO
                     order by h.id_organization, f.CCO_SECUENCIAL, f.CCO_DT_INICIO, 
                     f.CCO_DT_FIN ,f.CCO_ORIGEN, h.STD_ID_HR, h.FECHAASIG, 
                     h.CCO_DIA_E,to_number(nvl(h.CCO_HORA_E,'0')) , h.COD_CLIENTE_VIGIA, h.COD_SUBCLIENTE_VIG
                     --h.SCO_OR_DATOS_LIEXT
                     ;

    TYPE T_TBl_hr is record(
        id_organization varchar2(4),
        CCO_SECUENCIAL number(15),
        CCO_ID_WLOC_FILIAL varchar2(15),
        CCO_DT_INICIO date,
        CCO_DT_FIN date,
        CCO_ORIGEN varchar2(1000),
        CCO_TP_DATOS varchar2(10),
        CCO_ORIGEN_INTERFAZ varchar2(15),
        STD_ID_HR  STD_HR_PERIOD.STD_ID_HR%type,
        FECHAASIG date,
        COD_CLIENTE_VIGIA varchar2(6),
        COD_SUBCLIENTE_VIGIA varchar2(10),
        SCO_OR_DATOS_LIEXT number(3),
        CCO_DIA_E DATE,
        CCO_DIA_S date,
        CCO_HORA_E varchar2(6),
        CCO_HORA_S varchar2(6)
    );
    type TyTblhr is table of c_horas%ROWTYPE index by binary_integer;
    xt_horas tyTblHr;


                     
    cursor c_escalas(p_idorg varchar2, p_itfz varchar2, p_filial varchar2) is 
        select /*+parallel (h,4)*/ /*+parallel(f,4)*/ f.id_organization, f.CCO_SECUENCIAL, f.CCO_ID_WLOC_FILIAL, f.CCO_ORIGEN,
                            f.CCO_DT_INICIO,  f.CCO_DT_FIN,
            e.STD_ID_HR, e.CCO_DT_START_ASIG, e.SCO_ID_REF_MOD, e.CCO_DT_END_ASIG, e.CCO_ORIGEN_ESCALA, e.CCO_DIA_INICIO                
        from 
            M4CCO_WS_FILE_VIGI f, M4CCO_INT_DATO_ESC  e
                where f.id_organization = p_idorg
                and e.SCO_ID_REF_MOD <> 'FICTICIA'
                     and e.CCO_DT_START_ASIG <> to_Date ('01042018','ddmmyyyy')   
                     and ((f.cco_origen = p_itfz and p_itfz is not null ) or (f.cco_origen is not null and p_itfz is null))--)                                        
                     and f.CCO_CK_PROCESADO = 1
                     and f.id_organization = e.id_organization 
                     and f.CCO_DT_INICIO = e.cco_dt_inicio
                     and f.CCO_DT_FIN = e.cco_dt_fin
                     and f.CCO_ORIGEN = e.cco_origen
                     and e.cco_ck_procesado = '0' --MRG
                     order by 
                      f.id_organization, f.CCO_SECUENCIAL, f.CCO_DT_INICIO, 
                     f.CCO_DT_FIN ,f.CCO_ORIGEN, e.STD_ID_HR, 
                     e.STD_ID_HR, e.CCO_DT_START_ASIG;
     
    TYPE T_TBl_esca IS TABLE OF c_escalas%rowtype index by binary_integer;
    xT_escalas T_TBL_esca;
    
    
    msgerr  clob;
    g_cntcommits number;
    G_ID_ORGANIZATION  std_hr_period.id_organization%type;


    cursor c_fichadas_errores (p_idorg varchar2, p_idhr varchar2) is
        select * from m4cco_gt_jornada_e where id_organization = p_idorg
            and  ((std_id_hr = p_idhr and p_idhr is not null) or (std_id_hr is not null and p_idhr is not null))
--            and std_id_hr = p_std_id_hr
--            and cco_dt_jornada = p_dt_jornada
            ;
    
    reg_fichada_e       c_fichadas_errores%ROWTYPE;
        
    Procedure PROCESAR_NOVEDADES_BKP(p_idorg varchar2, p_typroc varchar2, p_interfaz varchar2, p_filial varchar2, p_fchref date,p_nroleg varchar2); 
    Procedure PROCESAR_NOVEDADES(p_idorg varchar2, p_typroc varchar2, p_interfaz varchar2, p_filial varchar2, p_fchref date,p_nroleg varchar2);
    
    
    
end M4PKG_GT_NOVE_VIGIA; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_GT_SEXAGESIMAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_GT_SEXAGESIMAL" 
as

/*--- 
    NOTA: 27/07/2018 ACV, modulo de  calculo de funciones sexafesimales
---*/

TYPE t_horas is record(
    uhrs      number(8,4),
    minuten     number(8,4),
    sekunden number(8,4)
);

K_NEGATIVO number(1) := -1;
K_positivo number(1) := 1;
K_SUMA varchar2(1) := '+';
K_RESTA varchar2(1) := '-';
K_MULTIPLICACION varchar2(1) := '*';

G_MINDESDE number;
G_MINHASTA number;
G_SECDESDE number;
G_SECHASTA number;

K_MODULO_TODOS  M4cco_gt_param.CCO_ID_MODULO%type := 'GT_ALL';

g_id_organization  std_hr_period.id_organization%TYPE;

---------------------------------------------------------------
FUnction SxComputoHoras(P_IDORG VARCHAR2, p_hr1 number, p_hr2 number, p_oper varchar2, p_factor number, p_roundmin  number, p_roundsec number,
                        p_secdesde number, p_sechasta number, p_mindesde number, p_minhasta number ) return number;
Function HrsSexa_ToHrs(p_hrs t_horas) return number;
Procedure Gethoras(p_hrsdec number, o_hrs_sexa in out t_horas);
Procedure Sxredondeo(p_hr in out t_horas, p_round_min number, p_round_sec number);
Procedure SxTruncamiento(p_hr in out t_horas, p_xmin number, p_xsec number);
Function SxRedondeo_Simple (p_valor number, p_min number, p_seg number) return number;
Function SxRedondeo_Truncamiento (p_valor number, p_min number, p_seg number, p_trunca number) return number;
Function  Gethoras_Str(p_hrsdec number) return  varchar2;
---------------------------------------------------------------

end M4PKG_GT_SEXAGESIMAL;

/
--------------------------------------------------------
--  DDL for Package M4PKG_IDM4_LIQUIDACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_IDM4_LIQUIDACION" 
AS 
     
     PROCEDURE PRC_GET_DATE (P_ID_ORGANIZATION IN VARCHAR2,P_TLIQ IN NUMBER,P_EMP IN NUMBER,P_FLIQ IN DATE,P_DT_START IN OUT DATE, P_DT_END IN OUT DATE);
     PROCEDURE PRC_M4CAR_SUE_LIQ (P_ID_ORGANIZATION in VARCHAR2, P_NROLIQ in NUMBER, P_LOTE in VARCHAR2 );
     
END M4PKG_IDM4_LIQUIDACION;

/
--------------------------------------------------------
--  DDL for Package M4PKG_IMPORT_HORAS_BR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_IMPORT_HORAS_BR" 
as    

    -----------------------------------------------------------------------------
    --- 03/04/2017 ACV  pacakage de importacin modificado  con modulo de NOVI ---
    -----------------------------------------------------------------------------


    cursor c_hrpend(p_idorg varchar2,  p_fchd date, p_fchh date, p_origen varchar2) is 
             select std_id_hr, count(*) from M4CBR_GT_FICH_HIST h2
                         where h2.id_organization  = p_idorg
                                and h2.id_origen = p_origen
                                and h2.dt_fecha between p_fchd and p_fchh
                                and h2.cbr_id_estado = 'P'
                                and h2.id_lote = 0
                                group by std_id_hr;
    TYPE t_hrpend IS TABLE OF c_hrpend%ROWTYPE
        index by binary_integer;
    tblhr  t_hrpend;
                                                    

    


    cursor c_crp(p_idorg varchar2, p_fchd date, p_fchh date, p_origen varchar2)  is  select * from M4CBR_GT_FICH_HIST where trim(id_organization) = p_idorg and trim(ID_ORIGEN) = p_origen and trim(CBR_ID_ESTADO) = 'P'  and  dt_fecha between p_fchd and p_fchh and nvl(id_lote,0) = 0 ;
    TYPE t_crp IS TABLE OF c_crp%ROWTYPE
        index by binary_integer;
    tblcrp   t_crp;
    

    cursor c_hspendlote(p_idorg varchar2, p_origen varchar2, p_lote number) is select * from M4CBR_GT_FICH_HIST  where  id_origen = p_origen and id_lote = p_lote  and CBR_ID_ESTADO = 'P' ;
    TYPE t_hslote IS TABLE OF c_hspendlote%ROWTYPE;
    tblhslotes   t_hslote;
    
    
    --LG 07/03/18 AGREGO CONDICION  and cco_aprobado = 'S'
    cursor c_portal(p_idorg varchar2, p_fchd date, p_fchh date)  is  select * from  M4CBR_GT_MARC_PORT where trim(id_organization) = p_idorg and trim(CCO_ESTADO) = 'P'  and  dt_fecha between p_fchd and p_fchh and nvl(id_lote,0) = 0 and cco_aprobado = 'S' ;
    TYPE t_portal IS TABLE OF c_portal%ROWTYPE
        index by binary_integer;
    tportal   t_portal;
    
    --LG 07/03/18 AGREGO CONDICION  and cco_aprobado = 'S'
    cursor c_portallote(p_idorg varchar2,  p_lote number)
    is  select * from  M4CBR_GT_MARC_PORT where trim(id_organization) = p_idorg and trim(CCO_ESTADO) = 'P'  and  id_lote = p_lote  and cco_aprobado = 'S';
    TYPE t_portlote IS TABLE OF c_portallote%ROWTYPE
        index by binary_integer;
    tportlote  t_portlote;
    
    
    
    /*
        cursor c_novi as   select ...
        TYPE t_novi IS TABLE OF c_novi%ROWTYPE;
        tblnovi   t_novi;
        
    */
    
    
    regcrp  c_crp%rowtype;
    --regnov  c_novi%rowtype;
    retval integer;
    cntcomm number;
    
    /*--- constantes ---*/
    K_ORI_CRP varchar(10) := 'CRP';
    K_ORI_NOVI varchar(10) := 'NOVI';
    K_ORI_PORTAL varchar(10) := 'PORTA';
    
    
    K_OK integer  := 1;
    K_ERROR integer := 0;
    cnterrores number := 0;
    K_FALSE integer := 0;
    
    
    K_COMMITS number := 1000;

    K_PENDIENTE   varchar2(2)  := 'P';
    K_IMPORTADO  varchar2(2) := 'I';
    k_IMPORERR     varchar2(2)  := 'E';    
    xuser varchar2(40);
    
    msgerr  clob;
    
    niverr number := 0;
    
    g_id_organization  STD_hr_period.ID_ORGANIZATION%TYPE;
    G_DT_DESDE DATE;
    G_DT_HASTA DATE;    
    
    
    /*---------------03/04/2017  ACV modificasciones por  NOVI------------------------------------------------------------------*/
    
    --- 17/01/2017 ACV , segun lo definido por Matias Allegro  ---
    K_FRANCO_COMPENSADO   m4cco_gt_day_type.CCO_TIPO_DIA%type := 2; 
    /*LAUTARO: CAMBIE EL NOMBRE DE LA VARIABLE, SE PRESTABA A CONFUSION. NO ES FRANCO COMPENSATORIO, ES FRANCO COMPENSADO.*/ 
    K_FRANCO              m4cco_gt_day_type.CCO_TIPO_DIA%type := 3;
    K_NORMAL              m4cco_gt_day_type.CCO_TIPO_DIA%type := 1;
    k_feriado             m4cco_gt_day_type.CCO_TIPO_DIA%type := 4; 


    K_LUNES  integer  := 1;


    K_FUTURO DATE := to_date('01/01/4000','dd/mm/yyyy') ;
 

    G_idioma varchar2(30);

    k_español  nls_session_parameters.value%type := 'SPANISH'; 


    xciclo number;


-- Declaracion de tabla de almacenamiento para los detalles semanales.
TYPE ATabMonday  IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabTuesday IS  TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabWednesday IS  TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabThursday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabFriday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabSaturday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabSunday IS TABLE OF M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabNroSemana IS TABLE OF M4SCO_REF_W_MOD.SCO_OR_REF_MOD%TYPE INDEX BY BINARY_INTEGER;
TYPE ATabIdOrg IS TABLE OF M4CCO_GT_JORNADA_T.ID_ORGANIZATION%TYPE INDEX BY BINARY_INTEGER;

TYPE TyTabMonday  IS TABLE OF    m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabTuesday IS  TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabWednesday IS  TABLE OF m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabThursday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabFriday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabSaturday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE TyTabSunday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;

TYPE lunTabMonday  IS TABLE OF    m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabTuesday IS  TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabWednesday IS  TABLE OF m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabThursday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabFriday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabSaturday IS TABLE OF   m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE lunTabSunday IS TABLE OF     m4cco_gt_day_type%ROWTYPE INDEX BY BINARY_INTEGER;

TYpe tyTabSemana is table of   M4SCO_HW_MODEL%ROWTYPE index by Binary_INTEGER;

TYPE nextTabWeek IS TABLE OF M4CCO_gt_REF_W_MOD%ROWTYPE INDEX BY BINARY_INTEGER;
type Tabdtmodelref is table of M4SCO_REF_W_MOD%rowtype index by binary_integer;



-- Declaracion arreglo de tabla
arr_Monday ATabMonday ;
arr_Tuesday ATabTuesday;
arr_Wednesday ATabWednesday;
arr_Thursday ATabThursday;
arr_Friday ATabFriday;
arr_Saturday ATabSaturday;
arr_Sunday ATabSunday;
arr_NroSemana ATabNroSemana;
arr_IdOrg ATabIdOrg;

arr_tyMonday    tyTabMonday ;
arr_tyTuesday   tyTabTuesday;
arr_tyWednesday tyTabWednesday;
arr_tyThursday  tyTabThursday;
arr_tyFriday    tyTabFriday;
arr_tySaturday  tyTabSaturday;
arr_tySunday    tyTabSunday;


arr_lMonday    lunTabMonday ;
arr_lTuesday   lunTabTuesday;
arr_lWednesday lunTabWednesday;
arr_lThursday  lunTabThursday;
arr_lFriday    lunTabFriday;
arr_lSaturday  lunTabSaturday;
arr_lSunday    lunTabSunday;

arr_semana TyTabSemana;

arr_nextweek  nextTabWeek;
arr_fecha_ref Tabdtmodelref;


horasteoricas number;

xredondeo  number;

g_ordinal  number;

v_FechaActual DATE; -- contiene la fecha actual
v_FechaAnt DATE; -- contiene la fecha anterior
v_FechaFin DATE; -- almacena el parametro de p_FechaFin
ind_DetalleSem NUMBER(10):= 1; -- almacena el indice de los arreglos almacenados en memoria.
ind NUMBER(10):= 0;
i_DimArrDS NUMBER(10):= 0; -- almacena la dimension de los arreglos.
v_DiaSemana NUMBER(1); -- almacena el numero de dia retornado por la funcion numero dia de la semana.
v_DiaDetalleSem NUMBER(1); -- almacena el numero de dia de semana iniciado en el dia LUNES
n_HrsDay M4SCO_DAY_TYPE.SCO_WKNG_HRS_DAY%TYPE; --almacena la cantidad de horas trabajabas por dia
v_IdOrganization M4CCO_GT_JORNADA_T.ID_ORGANIZATION%TYPE;

Type tytbljornadaT is table of M4CCO_GT_JORNADA_T%rowtype INDEX BY BINARY_INTEGER;
arr_calendar tytbljornadaT;


-- Declaracion de cursor
 CURSOR cur_Jornada (p_idorg varchar2, p_Empleado IN VARCHAR2, p_refmod varchar2, p_fecha date)IS
    SELECT p_idorg ID_ORGANIZATION,
    to_datE(p_fecha-7+(7*b.sco_or_ref_mod)) as fecha_desde,
    to_date(p_fecha+(7*b.sco_or_ref_mod)) as fecha_hasta,
    B.SCO_OR_REF_MOD NRO_SEMANA, 
    nvl(EMON.SCO_WKNG_HRS_DAY,0) HR_MON,
    nvl(ETUE.SCO_WKNG_HRS_DAY,0) HR_TUE,
    nvl(EWED.SCO_WKNG_HRS_DAY,0) HR_WED,
    nvl(ETHR.SCO_WKNG_HRS_DAY,0) HR_THR,
    nvl(EFRI.SCO_WKNG_HRS_DAY,0) HR_FRI,
    nvl(ESAT.SCO_WKNG_HRS_DAY,0) HR_SAT,
    nvl(ESUN.SCO_WKNG_HRS_DAY,0) HR_SUN,
    nvl(dtMON.CCO_TIPO_dia  ,0)   tdmon,
    nvl(dtTUE.CCO_TIPO_dia  ,0)   tdtue,
    nvl(dtWED.CCO_TIPO_dia  ,0)   tdwed,
    nvl(dtTHR.CCO_TIPO_dia  ,0)   tdthr,
    nvl(dtFRI.CCO_TIPO_dia  ,0)   tdfri,
    nvl(dtSAT.CCO_TIPO_dia  ,0)   tdsat,
    nvl(dtSUN.CCO_TIPO_dia  ,0)   tdsun,
    C.SCO_OR_WEEK  semana,
    proxi.CCO_NEXT, 
    b.dt_start
    FROM 
    M4SCO_REF_W_MOD B,
    M4SCO_HW_MODEL C,
    M4SCO_WEEK D,
    M4SCO_DAY_TYPE EMON,
    m4cco_gt_day_type dtmon,
    m4cco_gt_day_type lunmon,
    M4SCO_DAY_TYPE ETUE,
    m4cco_gt_day_type dttue,
    m4cco_gt_day_type luntue,
    M4SCO_DAY_TYPE EWED,
    m4cco_gt_day_type dtwed,
    m4cco_gt_day_type lunwed,
    M4SCO_DAY_TYPE ETHR,
    m4cco_gt_day_type dtthr,
    m4cco_gt_day_type lunthr,
    M4SCO_DAY_TYPE EFRI,
    m4cco_gt_day_type dtfri,
    m4cco_gt_day_type lunfri,
    M4SCO_DAY_TYPE ESAT,
    m4cco_gt_day_type dtsat,
    m4cco_gt_day_type lunsat,
    M4SCO_DAY_TYPE ESUN,
    m4cco_gt_day_type dtsun,
    m4cco_gt_day_type lunsun,
    M4CCO_gt_REF_W_MOD proxi
WHERE  B.SCO_ID_REF_MOD= p_refmod   --A.SCO_ID_REF_MOD
   AND B.SCO_OR_REF_MOD>= 0
   AND C.SCO_ID_WEEK_MDL=B.SCO_ID_WEEK_MDL
   AND D.SCO_OR_WEEK(+)=C.SCO_OR_WEEK
   AND EMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND ETUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND EWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND ETHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND EFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND ESAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND ESUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND dtMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND dtTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND dtWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND dtTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND dtFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND dtSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND dtSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND lunMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND lunTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND lunWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND lunTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND lunFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND lunSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND lunSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND B.ID_ORGANIZATION=p_idorg
   and b.sco_id_ref_mod = proxi.SCO_ID_REF_MOD
   and b.SCO_OR_REF_MOD = proxi.SCO_OR_REF_MOD
    AND C.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND D.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EMON.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETUE.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dttue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND luntue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EWED.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETHR.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EFRI.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESAT.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESUN.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsun.ID_ORGANIZATION=B.ID_ORGANIZATION
   --and A.std_id_hr = p_Empleado
   --AND A.DT_START = p_dtrefmod
   ---/ *LAUTARO 19/01/17* /
   --AND A.N=G_ID_ORGANIZATION
ORDER BY B.SCO_OR_REF_MOD ASC;


CURSOR cur_Jornada2 (p_Empleado IN VARCHAR2, p_dtrefmod  date )IS
    SELECT 
    /*+ PARALLEL (A,4)*/ /*+ PARALLEL (B,4)*/ /*+ PARALLEL (C,4)*/ /*+ PARALLEL (D,4)*/ 
    /*+ PARALLEL (EMON,4)*/ /*+ PARALLEL (dtmon,4)*/ /*+ PARALLEL (lunmon,4)*/
    /*+ PARALLEL (ETUE,4)*/ /*+ PARALLEL (dttue,4)*/ /*+ PARALLEL (luntue,4)*/
    /*+ PARALLEL (EEWD,4)*/ /*+ PARALLEL (dtwed,4)*/ /*+ PARALLEL (lunwed,4)*/
    /*+ PARALLEL (ETHR,4)*/ /*+ PARALLEL (dtthr,4)*/ /*+ PARALLEL (lunthr,4)*/
    /*+ PARALLEL (EFRI,4)*/ /*+ PARALLEL (dtfri,4)*/ /*+ PARALLEL (lunfri,4)*/
    /*+ PARALLEL (ESAT,4)*/ /*+ PARALLEL (dtsat,4)*/ /*+ PARALLEL (lunsat,4)*/
    /*+ PARALLEL (ESUN,4)*/ /*+ PARALLEL (dtsun,4)*/ /*+ PARALLEL (lunsun,4)*/
    /*+ PARALLEL (proxi,4)*/
    B.SCO_OR_REF_MOD NRO_SEMANA 
    FROM M4SCO_HR_THEOR_TIM A,
    M4SCO_REF_W_MOD B,
    M4SCO_HW_MODEL C,
    M4SCO_WEEK D,
    M4SCO_DAY_TYPE EMON,
    m4cco_gt_day_type dtmon,
    m4cco_gt_day_type lunmon,
    M4SCO_DAY_TYPE ETUE,
    m4cco_gt_day_type dttue,
    m4cco_gt_day_type luntue,
    M4SCO_DAY_TYPE EWED,
    m4cco_gt_day_type dtwed,
    m4cco_gt_day_type lunwed,
    M4SCO_DAY_TYPE ETHR,
    m4cco_gt_day_type dtthr,
    m4cco_gt_day_type lunthr,
    M4SCO_DAY_TYPE EFRI,
    m4cco_gt_day_type dtfri,
    m4cco_gt_day_type lunfri,
    M4SCO_DAY_TYPE ESAT,
    m4cco_gt_day_type dtsat,
    m4cco_gt_day_type lunsat,
    M4SCO_DAY_TYPE ESUN,
    m4cco_gt_day_type dtsun,
    m4cco_gt_day_type lunsun,
    M4CCO_gt_REF_W_MOD proxi
WHERE  B.SCO_ID_REF_MOD=A.SCO_ID_REF_MOD
   AND B.SCO_OR_REF_MOD>=A.SCO_OR_REF_MOD  
   AND C.SCO_ID_WEEK_MDL=B.SCO_ID_WEEK_MDL
   AND D.SCO_OR_WEEK(+)=C.SCO_OR_WEEK
   AND EMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND ETUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND EWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND ETHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND EFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND ESAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND ESUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND dtMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND dtTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND dtWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND dtTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND dtFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND dtSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND dtSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   AND lunMON.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_MONDAY
   AND lunTUE.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_TUESDAY
   AND lunWED.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_WEDNESDAY
   AND lunTHR.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_THURSDAY
   AND lunFRI.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_FRIDAY
   AND lunSAT.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SATURDAY
   AND lunSUN.SCO_ID_DAY_TYPE (+)= D.SCO_DAY_SUNDAY
   and A.std_id_hr = p_Empleado
   AND A.DT_START = p_dtrefmod
   and b.sco_id_ref_mod = proxi.SCO_ID_REF_MOD
   and b.SCO_OR_REF_MOD = proxi.SCO_OR_REF_MOD
   /*LAUTARO 19/01/17*/
   AND A.ID_ORGANIZATION=G_ID_ORGANIZATION
   --LAUTARO 29/05/17
    AND C.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND D.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EMON.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunmon.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETUE.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dttue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND luntue.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EWED.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunwed.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ETHR.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunthr.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND EFRI.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunfri.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESAT.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND lunsat.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ESUN.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND dtsun.ID_ORGANIZATION=B.ID_ORGANIZATION
    and lunsun.ID_ORGANIZATION=B.ID_ORGANIZATION
    AND ROWNUM = 1
ORDER BY B.SCO_OR_REF_MOD ASC;  


K_Ndaycalend number := 50;

K_mdl_Week_NOVI varChar2(20) := 'GET_WK_NOVI';
K_mdl_Update varChar2(20) := 'UPDATE_FICHADAS';

g_approle STD_HR_PERIOD.ID_APPROLE%type;
g_iduser STD_HR_PERIOD.ID_SECUSER%type;
 
    
    
    
    /*--- constantes y procedimientos ---*/
    PROCEDURE MAIN_IMPORTHRS(p_idorg varchar2, p_origen varchar2, p_fchd DATE, p_fchh DATE, p_lote number, p_reimport number);
    PROCEDURE GET_SEMANA_NOVI_OPERATIVA_INIT( p_idorg varchar2, p_idhr varchar2,
                    p_escalanovi number, p_ciclo  number, p_fecha date,  
                    o_modref in out varchar2, o_semana in out varchar2 );  
   
end M4PKG_IMPORT_HORAS_BR; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_IMPORT_HORAS_CL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_IMPORT_HORAS_CL" 
as
    K_CHILE    varchar2(4) := '0110';

    cursor c_hspend(p_fchd date, p_fchh date, p_emp varchar2, p_grp varchar2, p_idhr varchar2) is
            select h.* from M4CCL_HS_FICH_HIST h, M4SCO_H_HR_LEGENT l   
            where  h.id_organization = K_CHILE
        and (( h.CCL_FECHA_HORA between p_fchd and p_fchh and p_fchd is not null and p_fchh is not null) or 
             ( h.CCL_FECHA_HORA is not null and p_fchd is null and p_fchh is null) ) 
        and (( h.std_id_hr = p_idhr and p_idhr is not null) or (h.std_id_hr is not null and p_idhr is null))    
        and h.CCL_ESTADO = 'P' 
        and h.id_organization = l.id_organization            
        and h.std_id_hr = l.std_id_hr
        and l.dt_start <= p_fchh
        and l.dt_end >= p_fchd
        and ((l.std_id_leg_ent = p_emp and p_emp is not null)
             or 
            (l.std_id_leg_ent is not null and  p_emp is null))
        and exists
                ( select 1 from M4CCL_MOD_REF_HR_G g
                    where g.ID_ORGANIZATION = h.id_organization  
                      and ((g.CCL_ID_GRUPO = p_grp and p_grp is not null) or (g.CCL_ID_GRUPO is not null and p_grp is null))
                      and  g.CCL_LEGAJO = h.std_id_hr)
                                order by h.std_id_hr, CCL_FECHA_HORA;
        

    TYPE t_hslote IS TABLE OF c_hspend%ROWTYPE;
    tblhslotes   t_hslote;

     K_OK integer  := 1;
    K_ERROR integer := 0;
    cnterrores number := 0;
    K_FALSE integer := 0;
    K_COMMITS number := 1000;

    k_module  VARCHAR2(40) := 'IMPORT_HROAS_CL';
    


    K_EST_ERROR M4CCL_HS_FICH_HIST.CCL_ESTADO%type := 'E';
    K_EST_LEIDO M4CCL_HS_FICH_HIST.CCL_ESTADO%type := 'L';


    g_cntcommits number ;
    msgerr clob;
    G_ID_ORGANIZATION varchar2(4) := K_CHILE;

    k_mk_I varchar2(1) :=  'I'; --- primer entrada
    k_mk_0 varchar2(1) :=  '0'; --- entrada sector interna
    k_mk_1 varchar2(1) :=  '1'; --- salida sector interna
    k_mk_O varchar2(1) :=  'O'; --- salida definitiva
    
                    
    
    PROCEDURE MAIN_IMPORTHRS(p_fchd date, p_emp varchar2, p_grp varchar2, p_fchh date, p_idhr varchar2);
    
end M4PKG_IMPORT_HORAS_CL; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_INT_INCID_LAT_A_GLOB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_INT_INCID_LAT_A_GLOB" 
AS    

PROCEDURE M4PR_H_RECAIDAS;
PROCEDURE M4PR_H_SAL_VAC;  
PROCEDURE M4PR_HR_INCIDENCE;
PROCEDURE M4PR_HR_VACACIONE;
PROCEDURE M4PR_HT_HR_VACACI;
PROCEDURE M4PR_INCIDENCE; 
PROCEDURE M4PR_X_ACCIDENTE;

END M4PKG_INT_INCID_LAT_A_GLOB; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_LATAM_ADMPER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_LATAM_ADMPER" 
IS
PROCEDURE M4PR_GEN_SALDOS_VAC (
 pID_ORGANIZATION       IN   VARCHAR2,
 pEMP                   IN   VARCHAR2, --PARAMETRO FUERA DE USO
 pNROLEG                IN   VARCHAR2,
 pANIO                  IN   VARCHAR2,
 pUSUARIO               IN   VARCHAR2,
 pIDAPPROLE             IN   VARCHAR2,
 pFECHA                 IN   DATE

);

PROCEDURE M4PR_INT_AUS_VIGIA_LIQ(
P_ID_ORG     IN VARCHAR2,
P_ID_EMP     IN VARCHAR2,
P_ID_ANIO    IN NUMBER,
P_ID_MES     IN NUMBER,
P_DT_INICIO  IN DATE,
P_DT_FIN     IN DATE,
P_ID_HR      IN VARCHAR2,
P_NROLIQ     IN NUMBER,
P_ROLE       IN VARCHAR2,
P_USER       IN VARCHAR2
);

PROCEDURE M4PR_INT_AUSENTES_VIGIA(
P_ID_ORG     IN VARCHAR2,
P_ID_EMP     IN VARCHAR2,
P_ID_ANIO    IN NUMBER,
P_ID_MES     IN NUMBER,
P_DT_INICIO  IN DATE,
P_DT_FIN     IN DATE,
P_ROLE       IN VARCHAR2,
P_USER       IN VARCHAR2
);

PROCEDURE m4pr_gen_saldos_vac_proporc (	  pid_organization IN VARCHAR2
                                        , pemp IN VARCHAR2
                                        , pnroleg IN VARCHAR2
                                        , panio IN VARCHAR2
                                        , pusuario IN VARCHAR2
                                        , pidapprole IN VARCHAR2
                                         );

END M4PKG_LATAM_ADMPER; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_LATAM_ADMPER_BKP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_LATAM_ADMPER_BKP" 
IS
PROCEDURE M4PR_GEN_SALDOS_VAC_BKP (
 pID_ORGANIZATION       IN   VARCHAR2,
 pEMP                   IN   VARCHAR2, --PARAMETRO FUERA DE USO
 pNROLEG                IN   VARCHAR2,
 pANIO                  IN   VARCHAR2,
 pUSUARIO               IN   VARCHAR2,
 pIDAPPROLE             IN   VARCHAR2,
 pFECHA                 IN   DATE

);

PROCEDURE M4PR_INT_AUS_VIGIA_LIQ_BKP(
P_ID_ORG     IN VARCHAR2,
P_ID_EMP     IN VARCHAR2,
P_ID_ANIO    IN NUMBER,
P_ID_MES     IN NUMBER,
P_DT_INICIO  IN DATE,
P_DT_FIN     IN DATE,
P_ID_HR      IN VARCHAR2,
P_NROLIQ     IN NUMBER,
P_ROLE       IN VARCHAR2,
P_USER       IN VARCHAR2
);

PROCEDURE M4PR_INT_AUSENTES_VIGIA_BKP(
P_ID_ORG     IN VARCHAR2,
P_ID_EMP     IN VARCHAR2,
P_ID_ANIO    IN NUMBER,
P_ID_MES     IN NUMBER,
P_DT_INICIO  IN DATE,
P_DT_FIN     IN DATE,
P_ROLE       IN VARCHAR2,
P_USER       IN VARCHAR2
);

PROCEDURE m4pr_gen_saldos_vac_proporcBKP (      pid_organization IN VARCHAR2
                                        , pemp IN VARCHAR2
                                        , pnroleg IN VARCHAR2
                                        , panio IN VARCHAR2
                                        , pusuario IN VARCHAR2
                                        , pidapprole IN VARCHAR2
                                         );

END M4PKG_LATAM_ADMPER_BKP; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_LATAM_DOTACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_LATAM_DOTACION" 
IS
PROCEDURE M4PR_INT_DOTACION (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);

--PROCEDURE M4PR_INTERFACE_LDAP(
--  pID_ORG         IN        VARCHAR2,
--  pFECHA          IN        DATE
--);
--
--PROCEDURE M4PR_INTERFACE_LDAP_BR(
--  pID_ORG         IN        VARCHAR2,
--  pFECHA          IN        DATE
--);

PROCEDURE M4PR_MANO_OBRA_CONTAB (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);

PROCEDURE M4PR_INT_DOTACION_CONTAB (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);

procedure M4pr_MAPPING_ORACLE_ERP3 
(pID_ORG IN VARCHAR2);

PROCEDURE M4PR_INT_DOTACION_CONTAB_COL (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);

PROCEDURE M4PR_INT_DOTACION_CONTAB_PERU (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);

--PROCEDURE M4PR_INT_ERP_CHI;
--PROCEDURE M4PR_INT_ERP_MEX;
--PROCEDURE M4PR_INT_ERP_URU ;
--PROCEDURE M4PR_INT_LDAP_CL;   
--PROCEDURE M4PR_INT_LDAP_MX;
--PROCEDURE M4PR_INT_LDAP_UY;

END M4PKG_LATAM_DOTACION;

/
--------------------------------------------------------
--  DDL for Package M4PKG_LATAM_DOTACION_BKP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_LATAM_DOTACION_BKP" 
IS
PROCEDURE M4PR_INT_DOTACION_BKP (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);
PROCEDURE M4PR_INTERFACE_LDAP_BKP(
  pID_ORG         IN        VARCHAR2,
  pFECHA          IN        DATE
);
PROCEDURE M4PR_INTERFACE_LDAP_BR_BKP(
  pID_ORG         IN        VARCHAR2,
  pFECHA          IN        DATE
);
PROCEDURE M4PR_GENERA_PASE_CONTABLE_BKP 
(P_ID_EMPRESA IN VARCHAR2,
 P_NROLIQ IN INTEGER,
 P_ID_ORGANIZATION IN VARCHAR2,
 P_ID_LOTE IN INTEGER,
 P_ID_USER IN VARCHAR2,
 P_DT_CONTABLE IN DATE,
 P_SIN_USO IN VARCHAR2,
 P_GENERA_AP IN INTEGER,
 P_ID_ASIENTO IN VARCHAR2
 );
 PROCEDURE M4PR_MANO_OBRA_CONTAB_BKP (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);
PROCEDURE M4PR_INT_DOTACION_CONTAB_BKP (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);
procedure M4pr_MAPPING_ORACLE_ERP3_BKP 
(pID_ORG IN VARCHAR2);
PROCEDURE M4PR_INT_DOTACION_CONTAB_COL_B (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);
PROCEDURE M4PR_INT_DOTACION_CONTAB_PER_B (
pID_ORGANIZATION IN VARCHAR2,
pMES  IN VARCHAR2,
pANIO IN VARCHAR2
);
PROCEDURE M4PR_INT_ERP_CHI_BKP;
PROCEDURE M4PR_INT_ERP_MEX_BKP;
PROCEDURE M4PR_INT_ERP_URU_BKP ;
PROCEDURE M4PR_ERP_EMPLEADO_BKP (
   pID_ORG   IN VARCHAR2,
   pNROLEG   IN VARCHAR2,
   pFECHA    IN DATE);
PROCEDURE M4PR_INT_LDAP_CL_BKP;   
PROCEDURE M4PR_INT_LDAP_MX_BKP;
PROCEDURE M4PR_INT_LDAP_UY_BKP;

END M4PKG_LATAM_DOTACION_BKP; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_LATAM_GL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_LATAM_GL" 
IS

FUNCTION GetMonthsBefore(p_fch date, p_nmonthbefore number) RETURN varCHAR2 ;

FUNCTION GET_DIV_ERP(p_origen varchar2, p_emp varchar2, p_clte varchar2, p_obj varchar2, p_default varchar2) return  varchar2;

FUNCTION GET_DELEG_ERP(p_origen varchar2, p_emp varchar2, p_clte varchar2, p_obj varchar2) return varchar2;
    
PROCEDURE m4pr_pase_cliente_objs_mx (
      pid_org      IN   VARCHAR2,
      pasiento     IN   VARCHAR2,
      pdesde       IN   DATE,
      phasta       IN   DATE,
      pempresa     IN   VARCHAR2,
      pemp_aurus   IN   NUMBER,
      pmes         IN   NUMBER,
      panio        IN   NUMBER,
      pasientotp   IN   NUMBER,
      papprole     IN   VARCHAR2,
      psecuser     IN   VARCHAR2
   );
PROCEDURE M4PR_ACTUALIZA_CUST_OBJS(P_ORG IN VARCHAR2,P_EMP IN VARCHAR2);      
PROCEDURE Iniciar_PASECLI_VCM(p_menu_m4_pasecli in varchar2
                                            ,p_presentacion_m4_pasecli in varchar2 
                                            ,p_objeto_m4_pasecli in varchar2                                                                                        
                                            ,p_c_pais in varchar2       
                                            ,p_c_emp in varchar2                                             
                                            ,p_c_emp_aurus IN NUMBER
                                            ,fdesdenor in date
                                            ,fhastanor in date                                                      
                                            ,p_n_asiento in VARCHAR2                                     
                                            ,p_d_mes in number                                                                                                 
                                            ,p_d_anio in number
                                            ,pultimasemana in number
                                            ,p_user in varchar2
                                            ,p_role in varchar2);  
PROCEDURE M4Pr_control_balanceo_vcm (
pID_ORG        IN  VARCHAR2,
pASIENTO       IN  VARCHAR2,
pEMP           IN  VARCHAR2,
pAPPROLE       IN  VARCHAR2,
pSECUSER       IN  VARCHAR2      

);
PROCEDURE m4pr_distrib_y_prorrateo_ppase (
   pid_org       IN   VARCHAR2,
   pasiento      IN   VARCHAR2,
   pemp          IN   VARCHAR2,
   pmes          IN   NUMBER,
   panio         IN   NUMBER,
   pult_semana   IN   NUMBER,                      -- 2:normal 3:ultima semana
   papprole      IN   VARCHAR2,
   psecuser      IN   VARCHAR2
);                                            

PROCEDURE M4PR_PASE_CBLE_DISTRIBUCION
(P_ID_EMPRESA IN VARCHAR2,
 P_NROLIQ IN INTEGER, -- no iria  
 P_ID_ORGANIZATION IN VARCHAR2,
 P_ID_LOTE IN INTEGER, 
 P_ID_USER IN VARCHAR2,
 P_DT_CONTABLE IN DATE,
 P_ID_ASIENTO IN VARCHAR2
 );

PROCEDURE m4pr_revertora_pr(
   p_menu_m4_pasecli           IN   VARCHAR2,
   p_presentacion_m4_pasecli   IN   VARCHAR2,
   p_objeto_m4_pasecli         IN   VARCHAR2,
   p_n_asiento                 IN   VARCHAR2,
   pemp                        IN   VARCHAR2,
   ppais                       IN   VARCHAR2
);

PROCEDURE M4PR_GENERA_PASE_CONTABLE 
(P_ID_EMPRESA IN VARCHAR2,
 P_NROLIQ IN INTEGER,
 P_ID_ORGANIZATION IN VARCHAR2,
 P_ID_LOTE IN INTEGER,
 P_ID_USER IN VARCHAR2,
 P_DT_CONTABLE IN DATE,
 P_SIN_USO IN VARCHAR2,
 P_GENERA_AP IN INTEGER,
 P_ID_ASIENTO IN VARCHAR2
 );
PROCEDURE M4PR_NUEVO_MSJ_ERROR
(P_ID_LEG_ENT IN VARCHAR2, P_ID_ASIENTO IN VARCHAR2,P_ID_EJECUCION IN VARCHAR, P_MENSAJE IN VARCHAR2);

PROCEDURE M4PR_XX_PROCESAR_LOTE_CONTABLE
(P_ID_GRUPO IN NUMBER, 
 P_ID_LOTE IN NUMBER,
P_ID_DESTINO IN VARCHAR2);

PROCEDURE M4PR_XX_PROCESAR_PROVEEDORES
(P_ID_ORGANIZATION IN VARCHAR2, P_ID_COMPROBANTE IN VARCHAR2, P_ID_DESTINO IN VARCHAR2); 
PROCEDURE M4PR_INT_GENERA_REMUNERACIONES
( P_ID_ORGANIZATION IN VARCHAR2
, P_ID_EMPRESA IN VARCHAR2
, P_ID_ASIENTO IN VARCHAR2
--, P_ID_LOTE IN VARCHAR2
, P_TIPO_ARCHIVO IN VARCHAR2
);         

PROCEDURE M4PR_GENERA_PASE_CONTABLE_J
(P_ID_EMPRESA IN VARCHAR2,
 P_NROLIQ IN INTEGER,
 P_ID_ORGANIZATION IN VARCHAR2,
 P_ID_LOTE IN INTEGER,
 P_ID_USER IN VARCHAR2,
 P_DT_CONTABLE IN DATE,
 P_SIN_USO IN VARCHAR2,
 P_GENERA_AP IN INTEGER,
 P_ID_ASIENTO IN VARCHAR2
 );                     
 
 PROCEDURE M4PR_PASE_DIST_ARG
(P_ID_EMPRESA IN VARCHAR2,
 P_NROLIQ IN INTEGER, -- no iria  
 P_ID_ORGANIZATION IN VARCHAR2,
 P_ID_LOTE IN INTEGER, 
 P_ID_USER IN VARCHAR2,
 P_DT_CONTABLE IN DATE,
 P_ID_ASIENTO IN VARCHAR2
 ) ;   
 
 PROCEDURE m4pr_int_hs_vigia (
   p_id_organization   IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_mes               IN   NUMBER,
   p_anio              IN   NUMBER,
   p_user              IN   VARCHAR2,
   p_role              IN   VARCHAR2         
);

PROCEDURE m4pr_int_hs_novia (
   p_id_organization   IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_mes               IN   NUMBER,
   p_anio              IN   NUMBER,
   p_user              IN   VARCHAR2,
   p_role              IN   VARCHAR2, 
   p_asiento           in   varchar2 
);

PROCEDURE m4pr_horas_nov_vcm (
   p_id_organization   IN   VARCHAR2,
   p_dt_desde          IN   DATE,
   p_dt_hasta          IN   DATE,
   p_legajo            IN   VARCHAR2,
   p_c_emp             IN   VARCHAR2, 
   p_d_mes             IN   NUMBER, 
   p_d_anio            IN   NUMBER,
   p_user              IN   VARCHAR2,
   p_role              IN   VARCHAR2
);
procedure m4pr_int_fch_cte_asiento  
    (p_idorganization varchar2,
     p_emp             integer,
     p_asiento      varchar2,
     o_fchini          out date,
     o_fchfin          out date);
     
PROCEDURE ENVIARCORREO2
(
ENVIA IN VARCHAR2,
RECIBE IN VARCHAR2,
ASUNTO IN VARCHAR2,
MENSAJE IN VARCHAR2,
HOST IN VARCHAR2
);

procedure m4pr_int_get_cierre_actual  
    (p_idorganization varchar2,
     p_emp             integer,
     p_asiento      varchar2,
     o_cierre   out    varchAR2);
     
PROCEDURE M4PR_INT_DENARIUS_HORAS_JOB
(p_organization varchar2, p_emp varchar2);

procedure m4pr_int_get_cierre_ant  
    (p_idorganization varchar2,
     p_emp             integer,
     p_asiento      varchar2,
     o_ucierre   out    varchAR2);     

procedure m4pr_int_get_cierre_FECHAS  
    (p_idorganization varchar2,
     p_emp             integer,
     p_cierre          varchar2,
     o_fchi_nor   out    date,
     o_fchh_nor   out    date,
     o_fchi_ext   out    date,
     o_fchh_ext   out    date);
     
PROCEDURE m4pr_int_hs_novipy (
   p_id_organization   IN   VARCHAR2,
   p_dt_desde          IN   DATE,
   p_dt_hasta          IN   DATE,
   p_legajo            IN   VARCHAR2,
   p_c_emp             IN   VARCHAR2,
   p_d_mes             IN   NUMBER,
   p_d_anio            IN   NUMBER,
   p_user              IN   VARCHAR2,
   p_role              IN   VARCHAR2
);

PROCEDURE m4pr_int_hs_gelv (  
   p_id_organization   IN   VARCHAR2,
   p_id_empresa        IN   VARCHAR2,
   p_mes               IN   NUMBER,
   p_anio              IN   NUMBER,
   --p_diaInicio         IN   NUMBER,
   --p_diaFin            IN   NUMBER,    
   --p_asiento           IN   VARCHAR2,
   p_user              IN   VARCHAR2,
   p_role              IN   VARCHAR2
   --p_ultima            IN   VARCHAR2,
   --p_bajas             IN   VARCHAR2  
);

 PROCEDURE ini_ar_pasecli_vcm (
   p_menu_m4_pasecli           IN   VARCHAR2,
   p_presentacion_m4_pasecli   IN   VARCHAR2,
   p_objeto_m4_pasecli         IN   VARCHAR2,
   p_c_pais                    IN   VARCHAR2,
   p_c_emp                     IN   VARCHAR2,
   p_diainicio                 IN   NUMBER,
   p_diafin                    IN   NUMBER,
   p_n_asiento                 IN   VARCHAR2,
   p_d_mes                     IN   NUMBER,
   p_d_anio                    IN   NUMBER,
   pultimasemana               IN   NUMBER,
   p_user                      IN   VARCHAR2,
   p_role                      IN   VARCHAR2,
   p_origen                    IN   VARCHAR2,
   p_bajas                     IN   VARCHAR2,
   p_tipo_asiento              IN   NUMBER

)    ;    

PROCEDURE M4PR_PASECLI_PY (
      p_c_menu_m4_pasecli           IN   VARCHAR2,
      p_c_presentacion_m4_pasecli   IN   VARCHAR2,
      p_c_objeto_m4_pasecli         IN   VARCHAR2,
      p_c_pais                      IN   VARCHAR2,
      p_c_emp                       IN   VARCHAR2,
      p_c_emp_aurus                 IN   NUMBER,
      p_asiento                   IN   VARCHAR2,
      p_d_fecha_desde               IN   varchar2,
      p_d_fecha_hasta               IN   varchar2,
      p_d_mes                       IN   NUMBER,
      p_d_anio                      IN   NUMBER,
      p_num_ultsem                  IN   NUMBER,
      p_c_id_approle                IN   VARCHAR2,
                -- agregar al objeto  y sacar fecha desde y hasta horas extras
      p_c_id_secuser                IN   VARCHAR2
   ) ;  

PROCEDURE m4pr_pasecli_arg (
      p_c_menu_m4_pasecli           IN   VARCHAR2,
      p_c_presentacion_m4_pasecli   IN   VARCHAR2,
      p_c_objeto_m4_pasecli         IN   VARCHAR2,
      p_c_pais                      IN   VARCHAR2,
      p_c_emp                       IN   VARCHAR2,
      p_c_emp_aurus                 IN   NUMBER,
      p_asiento                   IN   VARCHAR2,
      p_d_fecha_desde               IN   varchar2,
      p_d_fecha_hasta               IN   varchar2,
      p_d_mes                       IN   NUMBER,
      p_d_anio                      IN   NUMBER,
      p_num_ultsem                  IN   NUMBER,
      p_c_id_approle                IN   VARCHAR2,
                -- agregar al objeto  y sacar fecha desde y hasta horas extras
      p_c_id_secuser                IN   VARCHAR2
   );

PROCEDURE m4pr_dist_y_prorr_ppase_arg (
   pid_org       IN   VARCHAR2,
   pasiento      IN   VARCHAR2,
   pemp          IN   VARCHAR2,
   pmes          IN   NUMBER,
   panio         IN   NUMBER,
   pult_semana   IN   NUMBER,                      -- 2:normal 3:ultima semana
   papprole      IN   VARCHAR2,
   psecuser      IN   VARCHAR2,
   p_nroleg      in   varchar2,          -- si nse quiere procesar uno solo , NULL es para todos ... para no haradcoddear !!!!!!!
   p_logueo      in   integer            -- si loguea o no
);
   
PROCEDURE M4PR_DIST_Y_PRORR_PPASE_PY (
   pid_org       IN   VARCHAR2,
   pasiento      IN   VARCHAR2,
   pemp          IN   VARCHAR2,
   pmes          IN   NUMBER,
   panio         IN   NUMBER,
   pult_semana   IN   NUMBER,                      -- 2:normal 3:ultima semana
   papprole      IN   VARCHAR2,
   psecuser      IN   VARCHAR2,
   p_nroleg      IN   VARCHAR2,
-- si nse quiere procesar uno solo , NULL es para todos ... para no haradcoddear !!!!!!!
   p_logueo      IN   INTEGER                                -- si loguea o no
);
   
END m4pkg_latam_gl; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_LATAM_INTERFAZ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_LATAM_INTERFAZ" 

IS
PROCEDURE M4PR_INT_DENARIUS_CDF (
   P_ID_ORGANIZATION   IN   VARCHAR2,
   P_CDF               IN   VARCHAR2,
   P_FECHA_DESDE       IN   DATE
);
PROCEDURE M4pr_Ult_Situac_Emple (
 pID_ORG     IN   VARCHAR2,
 pEMP      IN    VARCHAR2,
 pNROLEG  IN      VARCHAR2
);
PROCEDURE M4PR_GL_PoseePromoc(p_idorg varchar2, p_emp varchar2,  p_idhr varchar2, o_cnt in out number, o_fch in out date);

PROCEDURE M4PR_GENERA_TABLA_PROVISION
(pANIO VARCHAR2, pMES VARCHAR2);
PROCEDURE M4PR_GL_GENERONOV(
p_NLOTE                            NUMBER
,p_idorg                        VARCHAR2
,p_RA_CAR_CK_TIPO_OPERAC        VARCHAR2 
,p_RA_CAR_DT_OPERACION             VARCHAR2 
,p_SQ                            NUMBER
,p_EMP                            VARCHAR2
,p_idhr                            VARCHAR2
,p_RA_APYNOM                    VARCHAR2
,P_RA_DIREC                        VARCHAR2 
,p_RA_LOCALI                    VARCHAR2
,p_RA_PROV                        VARCHAR2 
,p_RA_TELEF1                    VARCHAR2 
,p_RA_TELEF2                    VARCHAR2 
,p_RA_CODPOST                    VARCHAR2
,p_RA_FECNAC                    VARCHAR2
,p_RA_FECING                    VARCHAR2
,p_RA_FECEGR                    VARCHAR2
,p_RA_CODNAC                    VARCHAR2
,p_RA_ESTCIV                    VARCHAR2
,p_RA_FECCAS                    VARCHAR2
,p_RA_SEXO                        VARCHAR2
,p_RA_CODDOC1                    VARCHAR2
,p_RA_NRODOC1                    VARCHAR2
,p_sigladoc                      VARCHAR2
,p_RA_RELACION                    VARCHAR2
,p_RA_CODCCOS                    VARCHAR2
,p_RA_FECCOS                    VARCHAR2
,p_RA_CODUBI                    VARCHAR2
,p_RA_FECUBI                    VARCHAR2
,p_RA_CODCAT                    VARCHAR2
,p_RA_CODCAL                    VARCHAR2
,p_RA_CODTAR                    VARCHAR2
,p_RA_FECPUES                    VARCHAR2
,p_RA_CODEST                    VARCHAR2
,p_RA_CODTIT                    VARCHAR2
,p_RA_FORMA                        VARCHAR2
,p_RA_CODSIND                    VARCHAR2
,p_RA_NROASIND                    VARCHAR2
,p_RA_CODOS                        VARCHAR2
,p_RA_NROAOS                    VARCHAR2
,p_RA_CODCJ                        VARCHAR2
,p_RA_NROACJ                    VARCHAR2
,p_RA_BANK                        VARCHAR2
,p_RA_CODSUC                    VARCHAR2
,p_RA_NROCTA                    VARCHAR2
,p_RA_ACTIVO                    NUMBER
,p_RA_PLANOS                    VARCHAR2
,p_RA_CODMEGR                    VARCHAR2
,p_RA_TIPSERV                    VARCHAR2
,p_RA_CODPAIS                    VARCHAR2
,p_RA_ID_APPROLE                VARCHAR2
,p_RA_ID_SECUSER                VARCHAR2
,p_RA_DT_LAST_UPDATE            VARCHAR2
,p_RA_CAR_DT_ULT_UPDATE            VARCHAR2
,p_RA_CAR_DT_ULT_DELETE            VARCHAR2
,p_RA_DT_DENARIUS_UPDATE        VARCHAR2
,p_RB_CAR_CK_TIPO_OPERAC        VARCHAR2
,p_RB_CAR_DT_OPERACION            VARCHAR2
,p_RB_APEL                        VARCHAR2
,p_RB_NOMBRE                    VARCHAR2
,p_RB_CALLE                        VARCHAR2
,p_RB_NRO                        VARCHAR2
,p_RB_PISO                        VARCHAR2
,p_RB_DPTO                        VARCHAR2
,p_RB_PAISNAC                    VARCHAR2
,p_RB_CIUDNAC                    VARCHAR2
,p_RB_PROVNAC                    VARCHAR2
,p_RB_FECANT                    VARCHAR2
,p_RB_CUIL                        VARCHAR2
,p_RB_FAFAFJP                    VARCHAR2
,p_RB_CONTRATO                    VARCHAR2
,p_RB_JUBILADO                    NUMBER    
,p_RB_EMAIL                        VARCHAR2
,p_RB_CONDLEG                    NUMBER    
,p_RB_FECINIC                    VARCHAR2
,p_RB_CBU                        VARCHAR2 
,p_RB_TIPOPER                    VARCHAR2
,p_RB_LUGPAG                    VARCHAR2
,p_RB_CODACTIV                    VARCHAR2
,p_RB_TIPSERV                    VARCHAR2
,p_RB_PRESTA                    VARCHAR2
,p_RB_PLANP                        VARCHAR2
,p_RB_CURP                        VARCHAR2
,p_RB_RFC                        VARCHAR2
,p_RB_IMSS                        VARCHAR2
,p_RA_PASE                        NUMBER
,p_RA_CTACTS                    VARCHAR2
,p_RA_MONEDACTS                    VARCHAR2
,p_RA_BANCOCTS                    NUMBER
,p_RA_RESERVADO                    NUMBER
,p_RB_CAR_DT_ULT_UPDATE            VARCHAR2
,p_RB_CAR_DT_ULT_DELETE            VARCHAR2
,p_RB_DT_DENARIUS_UPDATE        VARCHAR2
,p_RHDESDE                        DATE
,p_RHHASTA                        DATE
,p_RID_SEGURO_SOCIAL            INTEGER
,p_RID_AFILIADO_SEGURO_SOCIAL    INTEGER
,p_RRESERVADO                    NUMBER
,p_RACTIVO_DENARIUS                INTEGER
,p_RNROINSIG                    VARCHAR2
,p_RVACS                        DATE
,p_RVACE                        DATE
,p_RZONAF                        NUMBER
,p_RPAGF                        NUMBER
,p_RFILX                        NUMBER
,p_RFILY                        NUMBER
,p_RREING                        NUMBER
,p_RPASAP                        VARCHAR2
,p_RORIGEN                        VARCHAR2
,p_RVENC                        DATE
,p_RDFECHA                        DATE
,p_RDUSRID                        INTEGER
,p_RDHORA                        DATE
,p_RFECEST                        DATE
,p_RPASE_EMPRESA                NUMBER
,p_RCOD_EMP_DENA                VARCHAR2
,p_D_DURACION_CONTRATO            INTEGER
,p_D_FECTRAN                    DATE
,p_D_FECDENA                    DATE
,p_D_FEINAC                        DATE
,p_D_NROSOL                        INTEGER
,p_D_PJORRED                    INTEGER
,p_D_CANRENOV                    INTEGER
,p_D_NROAPRE                    VARCHAR2
,p_D_PORCPRE                    INTEGER
,p_D_CAT                        VARCHAR2
,p_D_BANKC                        INTEGER
,p_D_CODSUCC                    INTEGER
,p_D_MESANTRE                    INTEGER
,p_DC_NRODOC_ID                    INTEGER
,p_DC_VSIGLA_DOC                VARCHAR2
,p_emp_ant                      INTEGER
,p_fecegr_ant                     DATE
,p_motegr_ant                     INTEGER    
,p_F_NROFAM                        NUMBER
,p_F_APYNOM                        VARCHAR2
,p_F_FECNAC                        VARCHAR2
,p_F_CODNAC                        VARCHAR2
,p_F_ESTCIV                        VARCHAR2
,p_F_SEXO                        VARCHAR2
,p_F_CODDOC                        VARCHAR2
,p_F_NRODOC                        VARCHAR2
,p_F_ACARAF                        VARCHAR2
,p_F_ACAROS                        VARCHAR2
,p_F_ACARIG                        VARCHAR2
,p_F_FECDIG                        VARCHAR2
,p_F_FECHIG                        VARCHAR2
,p_F_CODFAM                        VARCHAR2
,p_F_CONDFAM                    VARCHAR2
,p_F_ESTACT                        VARCHAR2
,p_F_VIVE                        VARCHAR2
,p_F_CUIL                        VARCHAR2
,p_F_FECBAJA                    VARCHAR2
,p_F_CAR_DT_ULT_UPDATE            DATE
,p_F_CAR_DT_ULT_DELETE            DATE
,p_F_CERTIFI                    VARCHAR2
,p_F_CERTIFF                    VARCHAR2
,p_F_DT_DENARIUS_UPDATE            DATE
,p_F_EXPED                        VARCHAR2
,p_F_VSIGLA_DOC_FAM                VARCHAR2
,p_CHK_JUNCADELLA                NUMBER
,p_ID_NOV_TABLA                    VARCHAR2
,p_PR_MOTIVO	                    NUMBER		
,p_PR_CODCAT	                    NUMBER		
,p_PR_RELACION	                    NUMBER		
,p_PR_FECHA	                        DATE				
,o_msgerr                         in out clob
);

PROCEDURE M4PR_PROC_CHG_ESTADO(p_idorg varchar2, p_proc varchar2, p_estado number);
END M4PKG_LATAM_INTERFAZ; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_M4EMEA_RESP_WUNIT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_M4EMEA_RESP_WUNIT" 
AS

PROCEDURE M4PR_H_HR_RESP_A_EMEA;

END M4PkG_M4EMEA_RESP_WUNIT; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_CECOS_EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_CECOS_EMEA" 
AS

PROCEDURE M4PR_CENTR_COSTO_A_EMEA;
PROCEDURE M4PR_TEAMS_A_EMEA;
PROCEDURE M4PR_X_CENTRO_CC_A_EMEA;
PROCEDURE M4PR_H_TEAM_CC_A_EMEA;
PROCEDURE M4PR_HT_TEIA_CC_A_EMEA;

-- Inicio CAG 05/05/2020 - Cambio de sentido de actualización de modelo de cecos de M4GLOBAL a EMEA
PROCEDURE M4PR_TEAMS_EN_EMEA;
PROCEDURE M4PR_H_TEAM_CC_EN_EMEA;
PROCEDURE M4PR_HT_TEIA_CC_EN_EMEA;
-- Fin CAG 05/05/2020

END M4PKG_PASAJE_CECOS_EMEA; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_DESDE_M4EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_DESDE_M4EMEA" 
AS

PROCEDURE M4PR_BANK_BRANCH_DE_M4EMEA;
PROCEDURE M4PR_X_EMP_TYPE_DE_M4EMEA;
PROCEDURE M4PR_LEG_ENT_DE_M4EMEA;
PROCEDURE M4PR_EXTERNAL_ORG_DE_M4EMEA;
PROCEDURE M4PR_COMPANY_BANK_DE_M4EMEA;




END M4PKG_PASAJE_DESDE_M4EMEA; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_DESDE_M4LATAM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_DESDE_M4LATAM" 
AS

PROCEDURE M4PR_SOLICITUDES;     
PROCEDURE M4PR_BANK_BRANCH_DE_M4LATAM;
PROCEDURE M4PR_FONDO_PENS_DE_M4LATAM;
PROCEDURE M4PR_OBRA_SOCIAL_DE_M4LATAM;
PROCEDURE M4PR_X_CATEGORIA_DE_M4LATAM;
PROCEDURE M4PR_X_CONTRATO_DE_M4LATAM;
PROCEDURE M4PR_X_CONVENIO_DE_M4LATAM;
PROCEDURE M4PR_X_EMP_TYPE_DE_M4LATAM;
PROCEDURE M4PR_LEG_ENT_DE_M4LATAM;
PROCEDURE M4PR_WORK_LOCATION_DE_M4LATAM;
PROCEDURE M4PR_EXTERNAL_ORG_DE_M4LATAM;
PROCEDURE M4PR_COMPANY_BANK_DE_M4LATAM;





END M4PKG_PASAJE_DESDE_M4LATAM;

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_DPO_A_EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_DPO_A_EMEA" 
AS
PROCEDURE M4PR_HT_POS_CPRIM_G_A_EMEA;
PROCEDURE M4PR_HT_DIR_EQUIP_G_A_EMEA;
PROCEDURE M4PR_HT_POS_FAMI_G_A_EMEA;
PROCEDURE M4PR_H_HR_EXC_CPR_G_A_EMEA;
PROCEDURE M4PR_FAMILIA_G_A_EMEA;
PROCEDURE M4PR_IND_FAMILIA_G_A_EMEA;
PROCEDURE M4PR_INDICADOR_G_A_EMEA;


END M4PkG_PASAJE_DPO_A_EMEA; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_M4EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_M4EMEA" 
AS

 
      

PROCEDURE M4PR_HT_JOB_GRADO_A_EMEA;
PROCEDURE M4PR_H_JOB_LEVEL_A_EMEA;
PROCEDURE M4PR_H_JOB_VALUE_A_EMEA;
PROCEDURE M4H_KN_CATEGOR_A_EMEA;
PROCEDURE M4PR_JOB_CERT_LIC_A_EMEA;
PROCEDURE M4PR_JOB_OBJECTIV_A_EMEA;
PROCEDURE M4PR_JOB_PREV_JOB_A_EMEA;
PROCEDURE M4PR_R_JOB_COMP_A_EMEA;
PROCEDURE M4PR_R_JOB_DUT_A_EMEA;
PROCEDURE M4PR_HT_JOB_DEF_A_EMEA;
PROCEDURE M4PR_JOB_ACAD_BAC_A_EMEA;
PROCEDURE M4PR_JOB_LANG_A_EMEA;
PROCEDURE M4PR_STD_JOB_A_EMEA;
PROCEDURE M4PR_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_REL_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_WU_TREE_A_EMEA;
PROCEDURE M4PR_H_HR_RESP_A_EMEA;
PROCEDURE M4PR_WU_BUDGET_A_EMEA;
PROCEDURE M4PR_POSITION_A_EMEA;
PROCEDURE M4PR_H_POSITION_A_EMEA;
PROCEDURE M4PR_H_POS_COMP_A_EMEA;
PROCEDURE M4PR_POS_BUDGET_A_EMEA;
PROCEDURE M4PR_REL_POSITION_A_EMEA;
PROCEDURE M4PR_HT_TP_ORG_A_EMEA;
PROCEDURE M4PR_HT_TP_PLAZA_A_EMEA;
PROCEDURE M4PR_HT_TP_POS_A_EMEA;
PROCEDURE M4PR_H_DIR_EQ_ORG_A_EMEA;
PROCEDURE M4PR_H_POS_WUNIT_A_EMEA;
PROCEDURE M4PR_REL_EXC_SFUN_A_EMEA;
PROCEDURE M4PR_R_POSIT_DUT_A_EMEA;
PROCEDURE M4PR_CLAVE_PRIMA_A_EMEA;
PROCEDURE M4PR_HT_POS_CPRIM_A_EMEA;
PROCEDURE M4PR_SOLIC_MOV_AP_A_EMEA;
PROCEDURE M4PR_HT_POS_FAMI_A_EMEA;
PROCEDURE M4PR_HT_POS_INC_A_EMEA;
PROCEDURE M4PR_HT_AREA_JOB_A_EMEA;
PROCEDURE M4PR_HT_LOCAT_JOB_A_EMEA;
PROCEDURE M4PR_HT_ROL_JOB_A_EMEA;
PROCEDURE M4PR_HT_TP_JOB_A_EMEA;

PROCEDURE M4PR_HT_MATRIZ_A_EMEA;
PROCEDURE M4PR_HT_DIR_EQUIP_A_EMEA;
PROCEDURE M4PR_HT_POS_GRADO_A_EMEA;



END M4PkG_PASAJE_M4EMEA; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_M4EMEA_REV_PRE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_M4EMEA_REV_PRE" 
AS

      

PROCEDURE M4PR_HT_JOB_GRADO_A_EMEA;
PROCEDURE M4PR_H_JOB_LEVEL_A_EMEA;
PROCEDURE M4PR_H_JOB_VALUE_A_EMEA;
PROCEDURE M4PR_H_KN_CATEGOR_A_EMEA;
PROCEDURE M4PR_JOB_CERT_LIC_A_EMEA;
PROCEDURE M4PR_JOB_OBJECTIV_A_EMEA;
PROCEDURE M4PR_JOB_PREV_JOB_A_EMEA;
PROCEDURE M4PR_R_JOB_COMP_A_EMEA;
PROCEDURE M4PR_R_JOB_DUT_A_EMEA;
PROCEDURE M4PR_HT_JOB_DEF_A_EMEA;
PROCEDURE M4PR_JOB_ACAD_BAC_A_EMEA;
PROCEDURE M4PR_JOB_LANG_A_EMEA;
PROCEDURE M4PR_STD_JOB_A_EMEA;
PROCEDURE M4PR_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_REL_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_WU_TREE_A_EMEA;
PROCEDURE M4PR_H_HR_RESP_A_EMEA;
PROCEDURE M4PR_WU_BUDGET_A_EMEA;
PROCEDURE M4PR_POSITION_A_EMEA;
PROCEDURE M4PR_H_POSITION_A_EMEA;
PROCEDURE M4PR_H_POS_COMP_A_EMEA;
PROCEDURE M4PR_POS_BUDGET_A_EMEA;
PROCEDURE M4PR_REL_POSITION_A_EMEA;
PROCEDURE M4PR_HT_TP_ORG_A_EMEA;
PROCEDURE M4PR_HT_TP_PLAZA_A_EMEA;
PROCEDURE M4PR_HT_TP_POS_A_EMEA;
PROCEDURE M4PR_H_DIR_EQ_ORG_A_EMEA;
PROCEDURE M4PR_H_POS_WUNIT_A_EMEA;
PROCEDURE M4PR_REL_EXC_SFUN_A_EMEA;
PROCEDURE M4PR_R_POSIT_DUT_A_EMEA;
PROCEDURE M4PR_CLAVE_PRIMA_A_EMEA;
PROCEDURE M4PR_HT_POS_CPRIM_A_EMEA;
--PROCEDURE M4PR_SOLIC_MOV_AP_A_EMEA;
PROCEDURE M4PR_HT_POS_FAMI_A_EMEA;
PROCEDURE M4PR_HT_POS_INC_A_EMEA;
PROCEDURE M4PR_HT_AREA_JOB_A_EMEA;
PROCEDURE M4PR_HT_LOCAT_JOB_A_EMEA;
PROCEDURE M4PR_HT_ROL_JOB_A_EMEA;
PROCEDURE M4PR_HT_TP_JOB_A_EMEA;
PROCEDURE M4PR_HT_MATRIZ_A_EMEA;
PROCEDURE M4PR_HT_DIR_EQUIP_A_EMEA;
PROCEDURE M4PR_HT_POS_GRADO_A_EMEA;
PROCEDURE M4PR_AREA_A_EMEA;
PROCEDURE M4PR_DIVISION_A_EMEA;
PROCEDURE M4PR_DEPARTAMENTO_A_EMEA;
PROCEDURE M4PR_SECCION_A_EMEA;
PROCEDURE M4PR_DELEGACION_A_EMEA;
PROCEDURE M4PR_WUNIT_CCOSTO_A_EMEA;
PROCEDURE M4PR_WORK_LOCATION_DE_M4EMEA;
PROCEDURE M4PR_AGRUP_CNO94_DE_M4EMEA;
PROCEDURE M4PR_SAGRUP_CNO94_DE_M4EMEA;
PROCEDURE M4PR_WUNIT_WLOC_A_EMEA;

END M4PkG_PASAJE_M4EMEA_REV_PRE; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_M4EMEA_REV_V1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_M4EMEA_REV_V1" 
AS

      

PROCEDURE M4PR_HT_JOB_GRADO_A_EMEA;
PROCEDURE M4PR_H_JOB_LEVEL_A_EMEA;
PROCEDURE M4PR_H_JOB_VALUE_A_EMEA;
PROCEDURE M4PR_H_KN_CATEGOR_A_EMEA;
PROCEDURE M4PR_JOB_CERT_LIC_A_EMEA;
PROCEDURE M4PR_JOB_OBJECTIV_A_EMEA;
PROCEDURE M4PR_JOB_PREV_JOB_A_EMEA;
PROCEDURE M4PR_R_JOB_COMP_A_EMEA;
PROCEDURE M4PR_R_JOB_DUT_A_EMEA;
PROCEDURE M4PR_HT_JOB_DEF_A_EMEA;
PROCEDURE M4PR_JOB_ACAD_BAC_A_EMEA;
PROCEDURE M4PR_JOB_LANG_A_EMEA;
PROCEDURE M4PR_STD_JOB_A_EMEA;
PROCEDURE M4PR_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_REL_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_WU_TREE_A_EMEA;
PROCEDURE M4PR_H_HR_RESP_A_EMEA;
PROCEDURE M4PR_WU_BUDGET_A_EMEA;
PROCEDURE M4PR_POSITION_A_EMEA;
PROCEDURE M4PR_H_POSITION_A_EMEA;
PROCEDURE M4PR_H_POS_COMP_A_EMEA;
PROCEDURE M4PR_POS_BUDGET_A_EMEA;
PROCEDURE M4PR_REL_POSITION_A_EMEA;
PROCEDURE M4PR_HT_TP_ORG_A_EMEA;
PROCEDURE M4PR_HT_TP_PLAZA_A_EMEA;
PROCEDURE M4PR_HT_TP_POS_A_EMEA;
PROCEDURE M4PR_H_DIR_EQ_ORG_A_EMEA;
PROCEDURE M4PR_H_POS_WUNIT_A_EMEA;
PROCEDURE M4PR_REL_EXC_SFUN_A_EMEA;
PROCEDURE M4PR_R_POSIT_DUT_A_EMEA;
PROCEDURE M4PR_CLAVE_PRIMA_A_EMEA;
PROCEDURE M4PR_HT_POS_CPRIM_A_EMEA;
--PROCEDURE M4PR_SOLIC_MOV_AP_A_EMEA;
PROCEDURE M4PR_HT_POS_FAMI_A_EMEA;
PROCEDURE M4PR_HT_POS_INC_A_EMEA;
PROCEDURE M4PR_HT_AREA_JOB_A_EMEA;
PROCEDURE M4PR_HT_LOCAT_JOB_A_EMEA;
PROCEDURE M4PR_HT_ROL_JOB_A_EMEA;
PROCEDURE M4PR_HT_TP_JOB_A_EMEA;
PROCEDURE M4PR_HT_MATRIZ_A_EMEA;
PROCEDURE M4PR_HT_DIR_EQUIP_A_EMEA;
PROCEDURE M4PR_HT_POS_GRADO_A_EMEA;
PROCEDURE M4PR_AREA_A_EMEA;
PROCEDURE M4PR_DIVISION_A_EMEA;
PROCEDURE M4PR_DEPARTAMENTO_A_EMEA;
PROCEDURE M4PR_SECCION_A_EMEA;
PROCEDURE M4PR_DELEGACION_A_EMEA;
PROCEDURE M4PR_WUNIT_CCOSTO_A_EMEA;
PROCEDURE M4PR_WORK_LOCATION_DE_M4EMEA;
PROCEDURE M4PR_AGRUP_CNO94_DE_M4EMEA;
PROCEDURE M4PR_SAGRUP_CNO94_DE_M4EMEA;
PROCEDURE M4PR_WUNIT_WLOC_A_EMEA;

END M4PkG_PASAJE_M4EMEA_REV_V1; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_M4EMEA_REV_V2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_M4EMEA_REV_V2" 
AS

      

PROCEDURE M4PR_HT_JOB_GRADO_A_EMEA;
PROCEDURE M4PR_H_JOB_LEVEL_A_EMEA;
PROCEDURE M4PR_H_JOB_VALUE_A_EMEA;
PROCEDURE M4PR_H_KN_CATEGOR_A_EMEA;
PROCEDURE M4PR_JOB_CERT_LIC_A_EMEA;
PROCEDURE M4PR_JOB_OBJECTIV_A_EMEA;
PROCEDURE M4PR_JOB_PREV_JOB_A_EMEA;
PROCEDURE M4PR_R_JOB_COMP_A_EMEA;
PROCEDURE M4PR_R_JOB_DUT_A_EMEA;
PROCEDURE M4PR_HT_JOB_DEF_A_EMEA;
PROCEDURE M4PR_JOB_ACAD_BAC_A_EMEA;
PROCEDURE M4PR_JOB_LANG_A_EMEA;
PROCEDURE M4PR_STD_JOB_A_EMEA;
PROCEDURE M4PR_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_REL_WORK_UNIT_A_EMEA;
PROCEDURE M4PR_WU_TREE_A_EMEA;
PROCEDURE M4PR_H_HR_RESP_A_EMEA;
PROCEDURE M4PR_WU_BUDGET_A_EMEA;
PROCEDURE M4PR_POSITION_A_EMEA;
PROCEDURE M4PR_H_POSITION_A_EMEA;
PROCEDURE M4PR_H_POS_COMP_A_EMEA;
PROCEDURE M4PR_POS_BUDGET_A_EMEA;
PROCEDURE M4PR_REL_POSITION_A_EMEA;
PROCEDURE M4PR_HT_TP_ORG_A_EMEA;
PROCEDURE M4PR_HT_TP_PLAZA_A_EMEA;
PROCEDURE M4PR_HT_TP_POS_A_EMEA;
PROCEDURE M4PR_H_DIR_EQ_ORG_A_EMEA;
PROCEDURE M4PR_H_POS_WUNIT_A_EMEA;
PROCEDURE M4PR_REL_EXC_SFUN_A_EMEA;
PROCEDURE M4PR_R_POSIT_DUT_A_EMEA;
PROCEDURE M4PR_CLAVE_PRIMA_A_EMEA;
PROCEDURE M4PR_HT_POS_CPRIM_A_EMEA;
--PROCEDURE M4PR_SOLIC_MOV_AP_A_EMEA;
PROCEDURE M4PR_HT_POS_FAMI_A_EMEA;
PROCEDURE M4PR_HT_POS_INC_A_EMEA;
PROCEDURE M4PR_HT_AREA_JOB_A_EMEA;
PROCEDURE M4PR_HT_LOCAT_JOB_A_EMEA;
PROCEDURE M4PR_HT_ROL_JOB_A_EMEA;
PROCEDURE M4PR_HT_TP_JOB_A_EMEA;
PROCEDURE M4PR_HT_MATRIZ_A_EMEA;
PROCEDURE M4PR_HT_DIR_EQUIP_A_EMEA;
PROCEDURE M4PR_HT_POS_GRADO_A_EMEA;
PROCEDURE M4PR_AREA_A_EMEA;
PROCEDURE M4PR_DIVISION_A_EMEA;
PROCEDURE M4PR_DEPARTAMENTO_A_EMEA;
PROCEDURE M4PR_SECCION_A_EMEA;
PROCEDURE M4PR_DELEGACION_A_EMEA;
PROCEDURE M4PR_WUNIT_CCOSTO_A_EMEA;
PROCEDURE M4PR_WORK_LOCATION_DE_M4EMEA;
PROCEDURE M4PR_AGRUP_CNO94_DE_M4EMEA;
PROCEDURE M4PR_SAGRUP_CNO94_DE_M4EMEA;
PROCEDURE M4PR_WUNIT_WLOC_A_EMEA;

END M4PkG_PASAJE_M4EMEA_REV_V2; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_M4LATAM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_M4LATAM" 
AS

 
    

PROCEDURE M4PR_HT_JOB_GRADO;
PROCEDURE M4PR_H_JOB_LEVEL;
PROCEDURE M4PR_H_JOB_VALUE;
PROCEDURE M4H_KN_CATEGOR;
PROCEDURE M4PR_JOB_CERT_LIC;
PROCEDURE M4PR_JOB_OBJECTIV;
PROCEDURE M4PR_JOB_PREV_JOB;
PROCEDURE M4PR_R_JOB_COMP;
PROCEDURE M4PR_R_JOB_DUT;
PROCEDURE M4PR_HT_JOB_DEF;
PROCEDURE M4PR_JOB_ACAD_BAC;
PROCEDURE M4PR_JOB_LANG;
PROCEDURE M4PR_STD_JOB;
PROCEDURE M4PR_WORK_UNIT;
PROCEDURE M4PR_REL_WORK_UNIT;
PROCEDURE M4PR_WU_TREE;
PROCEDURE M4PR_H_HR_RESP;
PROCEDURE M4PR_WU_BUDGET;
PROCEDURE M4PR_POSITION;
PROCEDURE M4PR_H_HR_POS;
PROCEDURE M4PR_H_POSITION;
PROCEDURE M4PR_H_POS_COMP;
PROCEDURE M4PR_POS_BUDGET;
PROCEDURE M4PR_REL_POSITION;





END M4PkG_PASAJE_M4LATAM; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_M4LATAM_V1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_M4LATAM_V1" 
AS

 
    

PROCEDURE M4PR_HT_JOB_GRADO;
PROCEDURE M4PR_H_JOB_LEVEL;
PROCEDURE M4PR_H_JOB_VALUE;
PROCEDURE M4H_KN_CATEGOR;
PROCEDURE M4PR_JOB_CERT_LIC;
PROCEDURE M4PR_JOB_OBJECTIV;
PROCEDURE M4PR_JOB_PREV_JOB;
PROCEDURE M4PR_R_JOB_COMP;
PROCEDURE M4PR_R_JOB_DUT;
PROCEDURE M4PR_HT_JOB_DEF;
PROCEDURE M4PR_JOB_ACAD_BAC;
PROCEDURE M4PR_JOB_LANG;
PROCEDURE M4PR_STD_JOB;
PROCEDURE M4PR_WORK_UNIT;
PROCEDURE M4PR_REL_WORK_UNIT;
PROCEDURE M4PR_WU_TREE;
PROCEDURE M4PR_H_HR_RESP;
PROCEDURE M4PR_WU_BUDGET;
PROCEDURE M4PR_POSITION;
PROCEDURE M4PR_H_HR_POS;
PROCEDURE M4PR_H_POSITION;
PROCEDURE M4PR_H_POS_COMP;
PROCEDURE M4PR_POS_BUDGET;
PROCEDURE M4PR_REL_POSITION;





END M4PkG_PASAJE_M4LATAM_V1; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_ORACLE_HCM_A_EMEA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_ORACLE_HCM_A_EMEA" 
AS 
 
PROCEDURE M4PR_SFCANDIDATOS_A_EMEA; 
PROCEDURE M4PR_SFCURSOS_A_EMEA; 
PROCEDURE M4PR_SFIDIOMAS_A_EMEA; 
PROCEDURE M4PR_SFINFORMAT_A_EMEA; 
PROCEDURE M4PR_SFTITULACION_A_EMEA; 
PROCEDURE M4PR_SFFORM_COMPL_A_EMEA; 
PROCEDURE M4PR_SFEXPERIENC_A_EMEA; 
PROCEDURE M4PR_SFTIP_SEGUR_A_EMEA;
PROCEDURE M4PR_IG_IDCANDIDATO_DESDE_EMEA; 
 
END M4PKG_PASAJE_ORACLE_HCM_A_EMEA;

/
--------------------------------------------------------
--  DDL for Package M4PKG_PASAJE_ORACLE_HCM_A_LM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PASAJE_ORACLE_HCM_A_LM" 
AS
PROCEDURE M4PR_WS_SGD_MOVIL_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFCANDIDATOS_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFCURSOS_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFIDIOMAS_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFINFORMAT_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFTITULACION_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFFORM_COMPL_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFEXPERIENC_A_LATAM(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_ACTUALIZA_SFCANDIDATOS(vID_ORGANIZATION VARCHAR2);
PROCEDURE M4PR_SFFAMILY_A_LATAM(vID_ORGANIZATION VARCHAR2); 
PROCEDURE M4PR_REQUIS_SMF_TALEO(vID_ORGANIZATION VARCHAR2);
END M4PKG_PASAJE_ORACLE_HCM_A_LM;

/
--------------------------------------------------------
--  DDL for Package M4PKG_PY_GET_HORAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_PY_GET_HORAS" is 



G_ID_ORGANIZATION  std_hr_period.ID_ORGANIZATION%type := '0030';
G_CNT_COMMITS number := 0;

K_COMMITS number := 1000;
K_PENDIENTE number := 0;
K_OCUPADO    number := 1;
K_CONERROR    number := 2;
K_CORRECTO    number := 3;

K_SOL_OCUPADO   varchar2(2) := 'O';
K_SOL_ENESPERA varchar2(2) := 'P';
K_SOL_ERROR varchar2(2) := 'E';
K_SOL_FINALIZADO varchar2(2) := 'F';

K_NOVIPY M4cco_hr_horas_t.ID_SECUSER%type := 'NOVIPY';

K_MODULE varchar2(40) := 'GL_PY_HR'; 
K_PREFIJO varchar2(2) := 'PY';

--- solicitudes de procesamiento de horas  ---
cursor c_solicitudes is 
    select ID_SOLICITUD, STD_ID_HR, DT_START, DT_END, CCO_ESTADO, CCO_ORIGEN   from 
        M4CCO_HR_GET_HORAS
            where  id_organization = G_ID_ORGANIZATION    
                 and CCO_ESTADO = K_SOL_ENESPERA;

cursor c_horas( p_idhr varchar2, p_dtini date, p_dtfin date, p_ori varchar2)    is 
    select STD_ID_HR,STD_OR_HR_PERIOD,DT_START,CCO_ORDINAL    
         from M4cco_hr_horas_t
            where id_organization  = G_ID_ORGANIZATION 
                and ((std_id_hr = p_idhr and  p_idhr is not null)  or 
                    (std_id_hr is not null and p_idhr is null))
                and dt_start between p_dtini and p_dtfin
                and ((ID_SECUSER = p_ori and p_ori is not null)
                     or (id_secuser is not null and p_ori is null));

cursor c_horas2( p_idhr varchar2, p_dtini date, p_dtfin date, p_ori varchar2)    is 
    select STD_ID_HR,STD_OR_HR_PERIOD, DT_START, CCO_ORDINAL, CCO_DIA_ENTRADA, CCO_DIA_SALIDA, CCO_ID_SECTOR, 
    SSP_ID_CENT_COSTO, CCO_ID_FUNCION, CCO_ID_VALIDACION, CCO_CK_VALIDAR, CCO_HORA_ENTRADA, 
    CCO_MINUTO_ENTRADA, CCO_HORA_SALIDA, CCO_MINUTO_SALIDA, CCO_RECORRIDO, CCO_CK_IMPORTADO, 
    CCO_CK_VOLCAR, CCO_CK_BORRADA, CCO_ESTADO, CCO_ID_MODALIDAD,ID_APPROLE, ID_SECUSER
         from M4cco_hr_horas_t@homolatam
            where id_organization  = G_ID_ORGANIZATION 
                and ((std_id_hr = p_idhr and  p_idhr is not null)  or 
                    (std_id_hr is not null and p_idhr is null))
                and dt_start between p_dtini and p_dtfin
                and ((ID_SECUSER = p_ori and p_ori is not null)
                     or (id_secuser is not null and p_ori is null));

                 
                 
                 



    Procedure ProcesarSolicitudes;
    --Procedure Proceso(p_idhr varchar2, p_dtini date, p_dtfin date, p_idsolicit varchar2);
    procedure Proceso(p_idhr varchar2, p_dtini date, p_dtfin date, p_idsolicit varchar2, p_origen varchar2);
    
end M4Pkg_PY_GET_HORAS; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCC_ES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCC_ES" AS 
       PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE EJECUTAR EL QUERY DE LA BANDEJA DEL SISTEMA CAUSAS CIVILES ESPAÑA

    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SCC_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
     PROCEDURE ARMA_BANDEJA_QUERY(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );

END M4PKG_SCC_ES; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCC_ES_EXPEDIENTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCC_ES_EXPEDIENTE" AS
    FUNCTION obtener_litigio (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION obtener_catalogo (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;

END M4PKG_SCC_ES_EXPEDIENTE; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCC_ES_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCC_ES_REPORTES" AS 
       --PRAGMA SERIALLY_REUSABLE;

    FUNCTION INFORME_PASTA(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    ) RETURN CLOB;

END M4PKG_SCC_ES_REPORTES; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCC_ES_USES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCC_ES_USES" as 

   PROCEDURE exec_dynamic (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );


end M4PKG_SCC_ES_USES; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_ES_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_ES_REPORTES" AS 
       --PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE INSERTAR CONSULTA DE BANDEJA EN LA TABLA M4SLL_PARAM_USR PARA QUE PUEDA LA VISTA "M4SLL_VW_BAN_ES"
    PRESENTE EL RESULTADO DE LA EJECUCION DE LA CONSULTA GENERADA POR ESTE SP

    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
                    {"FECHA_CIERRE":"01-09-2019"}
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SLL_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
     PROCEDURE INFORME_MENSUAL(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );
    PROCEDURE CARGA_M4SCJ_RP_X_CADENAS(
        P_USER IN VARCHAR2,  
        P_PERIODO IN VARCHAR2,
        P_JSON_PARAM  VARCHAR2        
    );
    PROCEDURE LISTA_AUTORES(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2        
    );
    /*
    FUNCTION LISTADOS_VARIOS(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN clob;
    */
    /*
    Retornara por cada  registro con la informacion relacionada al expediente, los procedimientos(causas) -> por cada causa ->
    ultima fase y ultimo compromiso
    */
    FUNCTION REPORTE_CONSOLIDADO(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN clob;
    
    FUNCTION REPORTES_GENERICO(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN clob;
    
    FUNCTION REPORTE_DINAMICO_TP1(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    )  RETURN JSON;
    --RETURN JSON_LIST;
    
    FUNCTION REPORTE_DINAMICO_TP2(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN JSON_LIST;
    
    FUNCTION ADD_COLUMN(
        P_COLUMN   IN CLOB
    )RETURN clob;
    
    FUNCTION ADD_RELATION(
        P_RELACIONES   IN CLOB
    )RETURN clob;
    
    FUNCTION REPORTE_COMP_REG_SET_GAN_PERD (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;
    
    
END M4PKG_SCJ_ES_REPORTES;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_ES_REPORTES_BKP26620
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_ES_REPORTES_BKP26620" AS 
       --PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE INSERTAR CONSULTA DE BANDEJA EN LA TABLA M4SLL_PARAM_USR PARA QUE PUEDA LA VISTA "M4SLL_VW_BAN_ES"
    PRESENTE EL RESULTADO DE LA EJECUCION DE LA CONSULTA GENERADA POR ESTE SP

    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
                    {"FECHA_CIERRE":"01-09-2019"}
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SLL_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
     PROCEDURE INFORME_MENSUAL(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );
    PROCEDURE CARGA_M4SCJ_RP_X_CADENAS(
        P_USER IN VARCHAR2,  
        P_PERIODO IN VARCHAR2,
        P_JSON_PARAM  VARCHAR2        
    );
    PROCEDURE LISTA_AUTORES(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2        
    );
    /*
    FUNCTION LISTADOS_VARIOS(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN clob;
    */
    /*
    Retornara por cada  registro con la informacion relacionada al expediente, los procedimientos(causas) -> por cada causa ->
    ultima fase y ultimo compromiso
    */
    FUNCTION REPORTE_CONSOLIDADO(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN clob;

    FUNCTION REPORTES_GENERICO(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN clob;

    FUNCTION REPORTE_DINAMICO_TP1(
        P_USER          IN VARCHAR2,        
        P_JSON_PARAM    IN VARCHAR2,
        P_PAGINA        IN VARCHAR2
    ) RETURN JSON_LIST;

    FUNCTION ADD_COLUMN(
        P_COLUMN   IN CLOB
    )RETURN clob;

    FUNCTION ADD_RELATION(
        P_RELACIONES   IN CLOB
    )RETURN clob;

    FUNCTION REPORTE_COMP_REG_SET_GAN_PERD (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;



END M4PKG_SCJ_ES_REPORTES_BKP26620;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_ES_USES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_ES_USES" as 

   PROCEDURE exec_dynamic (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );


end m4pkg_scj_es_uses;



/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_ES_USES_AGENDA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_ES_USES_AGENDA" as 

   PROCEDURE GET_AGENDA (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   );

end m4pkg_scj_es_uses_agenda;




/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_ES_USES_RP_CONS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_ES_USES_RP_CONS" as 


   FUNCTION GET_RP_CONSOLIDADO (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   )  RETURN CLOB;

    FUNCTION GET_RP_DINAMICO (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   )  RETURN CLOB;
    FUNCTION GET_RP_FACTURACION (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   )  RETURN CLOB;
end m4pkg_scj_es_uses_rp_cons;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_ES_UTILS_REPORTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_ES_UTILS_REPORTE" AS 
    
    /*
    Obtiene las columnas para mostrarse en reportes dinamicos, las columnas se 
    extraen del sql del reporte especifico
    */
    FUNCTION GET_COLUMNS_REPORTE (
      p_user         in   VARCHAR2,
      P_sql          in   CLOB,
      p_json_param   in   json default json()
   ) RETURN JSON_LIST ;
    /**
        Se encarga de armar las columnas para el select final para generar el reporte, valida contra las columnas del query del reporte original para evitar algun tipo De INYECTION desde el front
        @param p_user           IN   VARCHAR2  usuario que realiza la peticion
        @param p_obj_columnas   IN   JSON      objeto JSON que contiene las columnas enviadas por angular, las que se quieren mostrar en el reporte excel
        @param p_columnas_query IN   JSON      objeto JSON que contiene las columnas extraidas del query completo que genera el reporte
        @return  retorna una cadena que tendra las columnas que seran utilizadas posteriormente en el query final del reporte
    */    
   FUNCTION BUILD_SELECT_COLUMNS_REPORTE (
      p_user           IN   VARCHAR2,
      p_obj_columnas   IN   JSON,   
      p_columnas_query IN   JSON

   ) RETURN VARCHAR2 ;

END M4PKG_SCJ_ES_UTILS_REPORTE; 




/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_EXPEDIENTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_EXPEDIENTE" AS
    FUNCTION OBTENER_EXPEDIENTE (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION obtener_catalogo (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;
   

END m4pkg_scj_expediente;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_IMP_CI_IMPORTACION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_IMP_CI_IMPORTACION" AS 

    procedure procesa_carga_inicial( --pg_expediente_desde pls_integer,
                                    -- pg_expediente_hasta pls_integer,
                                     pg_expIdEmpresa  m4scj_imp_ci_expedientes.expIdEmpresa%type,
                                     pg_borra_tablas  varchar2 default 'N'
                                    );
--    function valida_hora (pg_hora varchar2)
--    return varchar2 ;
    function valida_fecha_hora ( pg_fecha                      IN varchar2,
                                 pg_hora                       IN varchar2,
                                 pg_nombre_campo_fecha_validar IN varchar2,
                                 pg_nombre_campo_hora_validar  IN varchar2
                                ) return varchar2 ;
                                
    procedure procesa_carga_inicial_x_rangos (-- p_expediente_desde pls_integer,
                                              -- p_expediente_hasta pls_integer,
                                               p_expIdEmpresa   m4scj_imp_ci_expedientes.expIdEmpresa%type,
                                               p_borra_tablas  varchar2 default 'N'
                                             );                                  
END M4PKG_SCJ_IMP_CI_IMPORTACION;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_IMP_CI_IMPORTACION_R
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_IMP_CI_IMPORTACION_R" AS 

    procedure procesa_carga_inicial( pg_expediente_desde pls_integer,
                                     pg_expediente_hasta pls_integer,
                                     pg_expIdEmpresa  m4scj_imp_ci_expedientes.expIdEmpresa%type,
                                     pg_borra_tablas  varchar2 default 'N'
                                    );
--    function valida_hora (pg_hora varchar2)
--    return varchar2 ;
    function valida_fecha_hora ( pg_fecha                      IN varchar2,
                                 pg_hora                       IN varchar2,
                                 pg_nombre_campo_fecha_validar IN varchar2,
                                 pg_nombre_campo_hora_validar  IN varchar2
                                ) return varchar2 ;
                                
    procedure procesa_carga_inicial_x_rangos ( p_expediente_desde pls_integer,
                                               p_expediente_hasta pls_integer,
                                               p_expIdEmpresa   m4scj_imp_ci_expedientes.expIdEmpresa%type,
                                               p_borra_tablas  varchar2 default 'N'
                                             );                                                                
END M4PKG_SCJ_IMP_CI_IMPORTACION_R;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_IMP_CI_IMPORTAC_PRUE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_IMP_CI_IMPORTAC_PRUE" AS 

    procedure procesa_carga_inicial( pg_expediente_desde pls_integer,
                                     pg_expediente_hasta pls_integer,
                                     pg_expIdEmpresa  m4scj_imp_ci_expedientes.expIdEmpresa%type,
                                     pg_borra_tablas  varchar2 default 'N'
                                    );
--    function valida_hora (pg_hora varchar2)
--    return varchar2 ;
    function valida_fecha_hora ( pg_fecha                      IN varchar2,
                                 pg_hora                       IN varchar2,
                                 pg_nombre_campo_fecha_validar IN varchar2,
                                 pg_nombre_campo_hora_validar  IN varchar2
                                ) return varchar2 ;

    procedure procesa_carga_inicial_x_rangos ( p_expediente_desde pls_integer,
                                               p_expediente_hasta pls_integer,
                                               p_expIdEmpresa   m4scj_imp_ci_expedientes.expIdEmpresa%type,
                                               p_borra_tablas  varchar2 default 'N'
                                             );                                                                
END M4PKG_SCJ_IMP_CI_IMPORTAC_PRUE;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SCJ_PKG
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SCJ_PKG" 
AS
   PROCEDURE arma_bandeja_query (
      p_user         IN   VARCHAR2,
      p_json_param        VARCHAR2,
      p_pagina            VARCHAR2
   );

   PROCEDURE arma_bandeja_accion (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );
   
   
   FUNCTION OBTENER_LISTA_CORREO(
     P_USER          IN VARCHAR2,
     P_LISTA          IN VARCHAR2 DEFAULT 'FORM_EXT_INDITEX',
     P_JSON_PARAM    IN VARCHAR2            
   ) RETURN clob;
    
    
END m4pkg_scj_pkg;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SGH_EMAILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SGH_EMAILS" AS 

TYPE r_attachment IS RECORD ( 
    filename    VARCHAR2(255), 
    mimetype    VARCHAR2(64) DEFAULT 'text/plain' 
); 
TYPE t_attachments IS TABLE OF r_attachment INDEX BY BINARY_INTEGER; 

-- Determina si un email tiene un formato vÃ¡lido  
FUNCTION is_valid_mail_address(Pe_mail VARCHAR2) RETURN BOOLEAN; 


-- FunciÃ³n para enviar un email 
-- Si hay mÃ¡s de un destinatario, deben ir separados 
-- por un separador que se puede obtener con get_separator 
PROCEDURE send_mail( 
    pe_sender        IN VARCHAR2, 
    pe_recipients    IN VARCHAR2, 
    pe_subject            IN VARCHAR2, 
    pe_message            IN VARCHAR2, 
    ps_error            OUT VARCHAR2) /*RETURN NUMBER*/; 


-- FunciÃ³n para enviar un email 
-- Si hay mÃ¡s de un destinatario, deben ir separados 
-- por un separador que se puede obtener con get_separator 
PROCEDURE send_mail_with_attachments( 
    pe_sender        IN VARCHAR2, 
    pe_recipients    IN VARCHAR2, 
    pe_subject        IN VARCHAR2, 
    pe_message        IN VARCHAR2, 
    pe_attachments    IN t_attachments, 
    ps_replies        OUT UTL_SMTP.replies,
    pe_directory    IN VARCHAR2 DEFAULT NULL) /*RETURN NUMBER*/; 


END M4PKG_SGH_EMAILS; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SGH_JSON
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SGH_JSON" AS 
       --PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE INSERTAR CONSULTA DE BANDEJA EN LA TABLA M4SLL_PARAM_USR PARA QUE PUEDA LA VISTA "M4SLL_VW_BAN_ES"
    PRESENTE EL RESULTADO DE LA EJECUCION DE LA CONSULTA GENERADA POR ESTE SP

    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SLL_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
   
    PROCEDURE ARMA_PER_HAB(
      
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
        
    );

PROCEDURE ARMA_PER_CUR(
      
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
        
    );
 
PROCEDURE ARMA_CATALOGO(
      
    P_USER IN VARCHAR2,        
    P_JSON_PARAM  VARCHAR2
    
        
);  
    
    FUNCTION obtener_catalogo (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION CONDICION_INSCRIPCION (
        P_VALIDACION IN NUMBER
    ) RETURN VARCHAR2;
    FUNCTION VALIDAR_INSCRIPCION (
        P_ID_ORGANIZATION IN VARCHAR2,
        P_STD_ID_GEO_DIV  IN VARCHAR2,
        P_STD_ID_HR       IN VARCHAR2
    ) RETURN VARCHAR2;      
END M4PKG_SGH_JSON; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SGP_USES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SGP_USES" as 

   PROCEDURE exec_dynamic (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );


end m4pkg_sgp_uses;



/
--------------------------------------------------------
--  DDL for Package M4PKG_SGP_USES_BANDEJA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SGP_USES_BANDEJA" as 

    PROCEDURE GET_BANDEJA (
        p_user         IN   VARCHAR2,
        p_json_param        VARCHAR2,
        p_pagina            VARCHAR2
    );


end m4pkg_SGP_uses_bandeja;


/
--------------------------------------------------------
--  DDL for Package M4PKG_SIRADIG_GLB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SIRADIG_GLB" 
is
PROCEDURE m4pr_exp_deducc_ig_den (sempresa   VARCHAR2,  sanio      NUMBER);
PROCEDURE M4PR_ACT_CUIL_PESON ;
PROCEDURE M4PR_ACT_CUIL_SIRADIG;
PROCEDURE M4PR_EXP_DEDUC_SIR_X_LEGAJO( sEMPRESA    VARCHAR2,  sANIO       NUMBER,    sLEGAJO     VARCHAR2);
PROCEDURE M4PR_EXP_DATDED_PROS_COMP(sANIO  NUMBER);
PROCEDURE M4PR_EXP_TRANT_JUN_COMP(sANIO  NUMBER);
PROCEDURE M4PR_EXP_TRANT_PRO_COMP(sANIO  NUMBER);
PROCEDURE M4PR_EXP_DATDED_JUN_COMP(sANIO  NUMBER);
PROCEDURE M4PR_DELETE_DED_DEN(P_EMPRESA    VARCHAR2,P_ANIO NUMBER, P_LEG  VARCHAR2, P_USER  VARCHAR2);
end m4pkg_siradig_glb; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CCB
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CCB" AS 
       PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE INSERTAR CONSULTA DE BANDEJA EN LA TABLA M4SLL_PARAM_USR PARA QUE PUEDA LA VISTA "M4SLL_VW_BAN_ES"
    PRESENTE EL RESULTADO DE LA EJECUCION DE LA CONSULTA GENERADA POR ESTE SP
        
    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SLL_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
     PROCEDURE ARMA_BANDEJA_QUERY(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );
    
    
    PROCEDURE ARMA_ANALITICA(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );
    
    PROCEDURE ARMA_BANDEJA_ACCION(
        P_USER          IN VARCHAR2,
        P_ACCION        IN VARCHAR2,
        P_JSON_PARAM    CLOB,
        P_PAGINA        VARCHAR2
        
    ); 
    
    PROCEDURE ARMA_PACK(
        P_USER          IN VARCHAR2,
        P_ACCION        IN VARCHAR2,
        P_KEY   CLOB,
        P_CLOB    CLOB,
        P_JSON_PARAM    CLOB,
        P_SALIDA      OUT  CLOB 
        
        
    ); 
    
    FUNCTION OBTENER_CATALOGO(
            P_USER          IN VARCHAR2,        
            P_JSON_PARAM    IN VARCHAR2            
        ) RETURN clob;
    
    
     FUNCTION OBTENER_NOMBRES_DEMANDADOS(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
        P_AUR_CK_PRINCIPAL IN VARCHAR2  --DEMANDADO PRINCIPAL UTILIZADO PARA TRAER O TODOS LOS DEMANDADOS O SOLO EL PRICIPAL
    )
    RETURN VARCHAR2;
    
    FUNCTION OBTENER_NOMBRES_DEMANDANTES(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
         P_AUTOR_REU IN VARCHAR2

    )
    RETURN VARCHAR2;
    

     
    
END M4PKG_SLL_CCB;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CCB_ASIENTOS_PROV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CCB_ASIENTOS_PROV" AS 
       

     /* Funcion que busca el periodo que se debe ejecutar el cierre */
     FUNCTION BUSCA_FECHA_CIERRE(
        P_USER VARCHAR2
       ) RETURN DATE;
       /*Procedimiento que realiza el cierre de las provisiones de la causa y de honorarios*/
     PROCEDURE ARMA_ASIENTO_PROV(                                                
        P_USER IN VARCHAR2,                                                
        P_PERIODO  IN DATE                                                
    );
    /*Funcion que actualiza la tabla de control de cierre para cambiar el estado del mes a cerrar*/
    FUNCTION EJECUTA_CIERRE(
        P_USER  VARCHAR2,
        P_PERIODO  VARCHAR2
    )RETURN VARCHAR2;
    /*Funcion que revisa el estado del periodo enviado en la tabla control de cierres*/
    FUNCTION VALIDA_CIERRE(
        P_USER VARCHAR2,                                                
        P_PERIODO   VARCHAR2 
       ) RETURN VARCHAR2;  
END M4PKG_SLL_CCB_ASIENTOS_PROV; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CCB_CIERRE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CCB_CIERRE" AS 
     /*Funcion que busca las tareas del cierre de acuerdo a un periodo*/
     FUNCTION BUSCA_TAREAS_CIERRE(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
       )  RETURN CLOB;
    /* Funcion que ejecuta el cierre de las Provisiones*/
    FUNCTION EJECUTA_PRECIERRE(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2
       )  RETURN VARCHAR2;
       
    FUNCTION EJECUTA_CIERRE(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2
       )  RETURN VARCHAR2;
       
    FUNCTION EJECUTA_CIERRE_CONTRATO(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2
       )  RETURN VARCHAR2;
       
END M4PKG_SLL_CCB_CIERRE; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CCB_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CCB_REPORTES" AS 
       --PRAGMA SERIALLY_REUSABLE;

        FUNCTION REPORTE_CIERRE(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    ) RETURN CLOB;

    FUNCTION INFORME_PASTA(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    ) RETURN CLOB;
    
    PROCEDURE MOVIMIENTO_RAMJUD(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );
    
    PROCEDURE REPORTE_GENERAL(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );

END M4PKG_SLL_CCB_REPORTES; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_USES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_USES" as 

   PROCEDURE exec_dynamic (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );


end m4pkg_sll_cl_uses;


/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_USES_AGENDA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_USES_AGENDA" as 

   PROCEDURE GET_AGENDA (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   );

end m4pkg_sll_cl_uses_agenda;


/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_USES_BANDEJA
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_USES_BANDEJA" as 

    PROCEDURE GET_BANDEJA (
        p_user         IN   VARCHAR2,
        p_json_param        VARCHAR2,
        p_pagina            VARCHAR2
    );

    FUNCTION OBTENER_NOMBRES_DEMANDADOS(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
        P_AUR_CK_PRINCIPAL IN VARCHAR2  --DEMANDADO PRINCIPAL UTILIZADO PARA TRAER O TODOS LOS DEMANDADOS O SOLO EL PRICIPAL
    )
    RETURN VARCHAR2;

    FUNCTION OBTENER_NOMBRES_DEMANDANTES(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
        P_AUTOR_REU IN VARCHAR2
    )
    RETURN VARCHAR2;

end m4pkg_sll_cl_uses_bandeja;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_USES_MAESTROS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_USES_MAESTROS" as 

   PROCEDURE GET_MAESTROS(
      p_user         IN   VARCHAR2,
      p_json_param        CLOB         
   ) ;


    FUNCTION OBTENER_CATALOGO(
     P_USER          IN VARCHAR2,        
     P_JSON_PARAM    IN VARCHAR2            
   ) RETURN clob;

end m4pkg_sll_cl_uses_maestros;


/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_USES_PERSONAS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_USES_PERSONAS" as 

    PROCEDURE GET_PERSONAS (
        p_user         IN   VARCHAR2,
        p_json_param        VARCHAR2,
        p_pagina            VARCHAR2
    );

end m4pkg_sll_cl_uses_personas;





/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_USES_RP_LITIGIO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_USES_RP_LITIGIO" as 

   FUNCTION GET_RP_LITIGIO (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   )  RETURN CLOB;

end m4pkg_sll_cl_uses_rp_litigio;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CL_UTILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CL_UTILS" AS 
 

/*
Funcion encargada de parsear el resultado de una consulta a CLOB en formato JSON
P_SQL    Query ejm  select *from m4sll where rownum <300  deberia estar contemplado el paginado por razones de rendimiento
P_JSON_PARAM    utilizado  en un futuro para pasar filtros para el where o algun otro motivo
*/


   PROCEDURE ARMA_QUERY_PARAM_USR(
        P_USER        IN VARCHAR2,
        P_QUERY       IN  CLOB,
        P_ACCION      IN VARCHAR2,
        P_JSON_PARAM  IN VARCHAR2,
        P_PAGINA      IN VARCHAR2
    );


END M4PKG_SLL_CL_UTILS;


/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE" AS 
       PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE INSERTAR CONSULTA DE BANDEJA EN LA TABLA M4SLL_PARAM_USR PARA QUE PUEDA LA VISTA "M4SLL_VW_BAN_PE"
    PRESENTE EL RESULTADO DE LA EJECUCION DE LA CONSULTA GENERADA POR ESTE SP

    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SLL_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
     PROCEDURE ARMA_BANDEJA_QUERY(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );


    PROCEDURE ARMA_ANALITICA(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );

    PROCEDURE ARMA_BANDEJA_ACCION(
        P_USER          IN VARCHAR2,
        P_ACCION        IN VARCHAR2,
        P_JSON_PARAM    CLOB,
        P_PAGINA        VARCHAR2

    ); 

    PROCEDURE ARMA_PACK(
        P_USER          IN VARCHAR2,
        P_ACCION        IN VARCHAR2,
        P_KEY   CLOB,
        P_CLOB    CLOB,
        P_JSON_PARAM    CLOB,
        P_SALIDA      OUT  CLOB 


    ); 

    FUNCTION OBTENER_CATALOGO(
            P_USER          IN VARCHAR2,        
            P_JSON_PARAM    IN VARCHAR2            
        ) RETURN clob;


     FUNCTION OBTENER_NOMBRES_DEMANDADOS(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
        P_AUR_CK_PRINCIPAL IN VARCHAR2  --DEMANDADO PRINCIPAL UTILIZADO PARA TRAER O TODOS LOS DEMANDADOS O SOLO EL PRICIPAL
    )
    RETURN VARCHAR2;

    FUNCTION OBTENER_NOMBRES_DEMANDANTES(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
         P_AUTOR_REU IN VARCHAR2

    )
    RETURN VARCHAR2;




END M4PKG_SLL_CPE;

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE_ASIENTOS_PROV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE_ASIENTOS_PROV" AS 
       

     /* Funcion que busca el periodo que se debe ejecutar el cierre */
     FUNCTION BUSCA_FECHA_CIERRE(
        P_USER VARCHAR2
       ) RETURN DATE;
       /*Procedimiento que realiza el cierre de las provisiones de la causa y de honorarios*/
     PROCEDURE ARMA_ASIENTO_PROV(                                                
        P_USER IN VARCHAR2,                                                
        P_PERIODO  IN DATE                                                
    );
    /*Funcion que actualiza la tabla de control de cierre para cambiar el estado del mes a cerrar*/
    FUNCTION EJECUTA_CIERRE(
        P_USER  VARCHAR2,
        P_PERIODO  VARCHAR2
    )RETURN VARCHAR2;
    /*Funcion que revisa el estado del periodo enviado en la tabla control de cierres*/
    FUNCTION VALIDA_CIERRE(
        P_USER VARCHAR2,                                                
        P_PERIODO   VARCHAR2 
       ) RETURN VARCHAR2;  
END M4PKG_SLL_CPE_ASIENTOS_PROV; 


/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE_CIERRE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE_CIERRE" AS 
     /*Funcion que busca las tareas del cierre de acuerdo a un periodo*/
     FUNCTION BUSCA_TAREAS_CIERRE(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
       )  RETURN CLOB;
    /* Funcion que ejecuta el cierre de las Provisiones*/
    FUNCTION EJECUTA_PRECIERRE(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2
       )  RETURN VARCHAR2;
       
    FUNCTION EJECUTA_CIERRE(
        P_USER IN VARCHAR2,
        p_json_param   IN   VARCHAR2
       )  RETURN VARCHAR2;
       
END M4PKG_SLL_CPE_CIERRE; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE_EXPEDIENTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE_EXPEDIENTE" AS
    FUNCTION obtener_litigio (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2,
        p_pagina       IN   VARCHAR2
    ) RETURN CLOB;

    FUNCTION obtener_catalogo (
        p_user         IN   VARCHAR2,
        p_json_param   IN   VARCHAR2
    ) RETURN CLOB;

END M4PKG_SLL_CPE_EXPEDIENTE;


/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE_REPORTES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE_REPORTES" AS 
       --PRAGMA SERIALLY_REUSABLE;

        FUNCTION REPORTE_CIERRE(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    ) RETURN CLOB;

    FUNCTION INFORME_PASTA(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    ) RETURN CLOB;

    PROCEDURE MOVIMIENTO_RAMJUD(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );

    PROCEDURE REPORTE_GENERAL(
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );
    
    FUNCTION GET_RP_LITIGIO_DINAMICO (
      p_user         IN   VARCHAR2,
      p_json_param        CLOB
   )  RETURN CLOB;
END M4PKG_SLL_CPE_REPORTES; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE_USES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE_USES" as 

   PROCEDURE exec_dynamic (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );


end M4PKG_SLL_CPE_USES;



/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_CPE_UTILS_REPORTE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_CPE_UTILS_REPORTE" AS 
    
    /*
    Obtiene las columnas para mostrarse en reportes dinamicos, las columnas se 
    extraen del sql del reporte especifico
    */
    FUNCTION GET_COLUMNS_REPORTE (
      p_user         in   VARCHAR2,
      P_sql          in   CLOB,
      p_json_param   in   json default json()
   ) RETURN JSON_LIST ;
    /**
        Se encarga de armar las columnas para el select final para generar el reporte, valida contra las columnas del query del reporte original para evitar algun tipo De INYECTION desde el front
        @param p_user           IN   VARCHAR2  usuario que realiza la peticion
        @param p_obj_columnas   IN   JSON      objeto JSON que contiene las columnas enviadas por angular, las que se quieren mostrar en el reporte excel
        @param p_columnas_query IN   JSON      objeto JSON que contiene las columnas extraidas del query completo que genera el reporte
        @return  retorna una cadena que tendra las columnas que seran utilizadas posteriormente en el query final del reporte
    */    
   FUNCTION BUILD_SELECT_COLUMNS_REPORTE (
      p_user           IN   VARCHAR2,
      p_obj_columnas   IN   JSON,   
      p_columnas_query IN   JSON
      
   ) RETURN VARCHAR2 ;

END M4PKG_SLL_CPE_UTILS_REPORTE; 

/
--------------------------------------------------------
--  DDL for Package M4PKG_SLL_ES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE "M4PKG_SLL_ES" AS 
       PRAGMA SERIALLY_REUSABLE;


   /*
    PROCEDIMIENTO ENCARGADO DE INSERTAR CONSULTA DE BANDEJA EN LA TABLA M4SLL_PARAM_USR PARA QUE PUEDA LA VISTA "M4SLL_VW_BAN_ES"
    PRESENTE EL RESULTADO DE LA EJECUCION DE LA CONSULTA GENERADA POR ESTE SP

    PARAMETROS:
    P_USER: USUARIO AL QUE SE LE VA ARMAR LA BANDEJA (USUARIO META4)
    P_JSON_PARAM:   JSON QUE SE PUEDE UTILIZAR EN FUTURO EN CASO DE QUE LA BANDEJA REQUIERA RECIBIR PARAMETROS DE ALGUN TIPO
    P_PAGINA:       PAGINA DE LA BANDEJA QUE SE DESEA CONSULTAR PARA UN DETERMINADO USUARIO
    SALIDA: INSERTA EN TABLA M4SLL_PARAM_USR  QUERY DE CONSULTA DE BANDEJA PARA EL USUARIO DADO
    */
     PROCEDURE ARMA_BANDEJA_QUERY(
        P_USER IN VARCHAR2,
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2
    );


    PROCEDURE ARMA_BANDEJA_SEGURIDAD(
        P_USER IN VARCHAR2, 
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2,
        P_SQL CLOB
    );

    PROCEDURE ARMA_ANALITICA(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_USER IN VARCHAR2,        
        P_JSON_PARAM  VARCHAR2,
        P_PAGINA VARCHAR2,
        P_PERIOD VARCHAR2
    );

     FUNCTION OBTENER_NOMBRES_DEMANDADOS(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
        P_AUR_CK_PRINCIPAL IN VARCHAR2  --DEMANDADO PRINCIPAL UTILIZADO PARA TRAER O TODOS LOS DEMANDADOS O SOLO EL PRICIPAL
    )
    RETURN VARCHAR2;

    FUNCTION OBTENER_NOMBRES_DEMANDANTES(
        P_ID_ORGANIZATION IN VARCHAR2,
        P_LIT_ID_LITIGIO IN VARCHAR2, --cod de proceso
         P_AUTOR_REU IN VARCHAR2

    )
    RETURN VARCHAR2;
    
    PROCEDURE arma_bandeja_accion (
      p_user         IN   VARCHAR2,
      p_accion       IN   VARCHAR2,
      p_json_param        CLOB,
      p_pagina            VARCHAR2
   );

END M4PKG_SLL_ES;

/

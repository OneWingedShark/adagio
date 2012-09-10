<<<<<<< HEAD
------------------------------------------------------------------------------
--                         ADAGIO - ADALID - AENEA.                         --
--                                                                          --
--                            Copyright (C) 2003                            --
--                                 A. Mosteo.                               --
--                                                                          --
--  Authors: A. Mosteo. (adagio@mosteo.com)                                 --
--                                                                          --
--  If you have any questions in regard to this software, please address    --
--  them to the above email.                                                --
--                                                                          --
--  This program is free software; you can redistribute it and/or modify    --
--  it under the terms of the GNU General Public License as published by    --
--  the Free Software Foundation; either version 2 of the License, or (at   --
--  your option) any later version.                                         --
--                                                                          --
--  This program is distributed in the hope that it will be useful, but     --
--  WITHOUT ANY WARRANTY; without even the implied warranty of              --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       --
--  General Public License for more details.                                --
--                                                                          --
--  You should have received a copy of the GNU General Public License       --
--  along with this library; if not, write to the Free Software Foundation, --
--  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.          --
--                                                                          --
--  You are not allowed to use any part of this code to develop a program   --
--  whose output would be used to harass or prosecute other users of the    --
--  networks Adagio connects with. All data collected with Adagio or a tool --
--  containing Adagio code about other network users must remain            --
--  confidential and cannot be made public by any mean, nor be used to      --
--  harass or legally prosecute these users.                                --
------------------------------------------------------------------------------
--  $Id: aenea-db.ads,v 1.5 2004/01/21 21:05:24 Jano Exp $

   -- Inserciones en base de datos.
   -- Por una parte est� la tabla g2crawl (Hubs, Leaves, Estimated_Size, Tracked, Timestamp)
   -- Por la otra, g2vendors (vendor, amount, percent (en tanto por uno), date

with Agpl.Types.Ustrings; use Agpl.Types.Ustrings;

with Ada.Containers.Doubly_Linked_Lists;

package Aenea.Db is

   Log_Section : constant String := "DB";

   ------------------------------------------------------------------------
   -- Exceptions                                                         --
   ------------------------------------------------------------------------
   DB_Error : exception;

   ------------------------------------------------------------------------
   -- Get_Timestamp                                                      --
   ------------------------------------------------------------------------
   -- Get Current Timestamp from database local time
   function Get_Timestamp return String;

   ------------------------------------------------------------------------
   -- Init;                                                              --
   ------------------------------------------------------------------------
   procedure Init;

   ------------------------------------------------------------------------
   -- Insert_row                                                         --
   ------------------------------------------------------------------------
   procedure Insert_row (Hubs, Leaves, Unique, Total, Tracked : in Natural);
   procedure Insert_row
     (Vendor : in String; Amount, Total : in Natural; Timestamp : in String);
   procedure Insert_Row
     (Context   : in String;
      Key       : in String;
      Count     : in Natural;
      Timestamp : in String);
   -- The timestamp must be as obtained above

   type Rows is record
      Context   : Ustring;
      Key       : Ustring;
      Count     : Natural;
      Timestamp : Ustring;
   end record;

   package Row_Lists is new Ada.Containers.Doubly_Linked_Lists (Rows);

   -----------------
   -- Insert_Rows --
   -----------------
   --  For massive insertions:
   procedure Insert_Rows (Data : in Row_Lists.List);

end Aenea.Db;
=======
------------------------------------------------------------------------------
--                         ADAGIO - ADALID - AENEA.                         --
--                                                                          --
--                            Copyright (C) 2003                            --
--                                 A. Mosteo.                               --
--                                                                          --
--  Authors: A. Mosteo. (adagio@mosteo.com)                                 --
--                                                                          --
--  If you have any questions in regard to this software, please address    --
--  them to the above email.                                                --
--                                                                          --
--  This program is free software; you can redistribute it and/or modify    --
--  it under the terms of the GNU General Public License as published by    --
--  the Free Software Foundation; either version 2 of the License, or (at   --
--  your option) any later version.                                         --
--                                                                          --
--  This program is distributed in the hope that it will be useful, but     --
--  WITHOUT ANY WARRANTY; without even the implied warranty of              --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       --
--  General Public License for more details.                                --
--                                                                          --
--  You should have received a copy of the GNU General Public License       --
--  along with this library; if not, write to the Free Software Foundation, --
--  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.          --
--                                                                          --
--  You are not allowed to use any part of this code to develop a program   --
--  whose output would be used to harass or prosecute other users of the    --
--  networks Adagio connects with. All data collected with Adagio or a tool --
--  containing Adagio code about other network users must remain            --
--  confidential and cannot be made public by any mean, nor be used to      --
--  harass or legally prosecute these users.                                --
------------------------------------------------------------------------------
--  $Id: aenea-db.ads,v 1.5 2004/01/21 21:05:24 Jano Exp $

   -- Inserciones en base de datos.
   -- Por una parte est� la tabla g2crawl (Hubs, Leaves, Estimated_Size, Tracked, Timestamp)
   -- Por la otra, g2vendors (vendor, amount, percent (en tanto por uno), date

with Agpl.Types.Ustrings; use Agpl.Types.Ustrings;

with Ada.Containers.Doubly_Linked_Lists;

package Aenea.Db is

   Log_Section : constant String := "DB";

   ------------------------------------------------------------------------
   -- Exceptions                                                         --
   ------------------------------------------------------------------------
   DB_Error : exception;

   ------------------------------------------------------------------------
   -- Get_Timestamp                                                      --
   ------------------------------------------------------------------------
   -- Get Current Timestamp from database local time
   function Get_Timestamp return String;

   ------------------------------------------------------------------------
   -- Init;                                                              --
   ------------------------------------------------------------------------
   procedure Init;

   ------------------------------------------------------------------------
   -- Insert_row                                                         --
   ------------------------------------------------------------------------
   procedure Insert_row (Hubs, Leaves, Unique, Total, Tracked : in Natural);
   procedure Insert_row
     (Vendor : in String; Amount, Total : in Natural; Timestamp : in String);
   procedure Insert_Row
     (Context   : in String;
      Key       : in String;
      Count     : in Natural;
      Timestamp : in String);
   -- The timestamp must be as obtained above

   type Rows is record
      Context   : Ustring;
      Key       : Ustring;
      Count     : Natural;
      Timestamp : Ustring;
   end record;

   package Row_Lists is new Ada.Containers.Doubly_Linked_Lists (Rows);

   -----------------
   -- Insert_Rows --
   -----------------
   --  For massive insertions:
   procedure Insert_Rows (Data : in Row_Lists.List);

end Aenea.Db;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

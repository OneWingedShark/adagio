with PragmARC.Assignment;
with PragmARC.List_Unbounded;

use PragmARC;
package Lsorthlp is
   type Int is record
      Val : Integer := 0;
   end record;

   procedure Assign is new Assignment (Element => Int);

   package Int_List is new List_Unbounded (Element => Int);

   function "<" (Left : Int; Right : Int) return Boolean;

   procedure Print_One
      (Val : in out Int; Context : in out Int_List.Context_Data'Class; Pos : in Int_List.Position; Continue : out Boolean);
end Lsorthlp;
--
-- Copyright (C) 2002 by PragmAda Software Engineering.  All rights reserved.
--
-- This is free software; you can redistribute it and/or modify it under
-- terms of the GNU General Public License as published by the Free Software
-- Foundation; either version 2, or (at your option) any later version.
-- This software is distributed in the hope that it will be useful, but WITH
-- OUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-- or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
-- for more details. Free Software Foundation, 59 Temple Place - Suite
-- 330, Boston, MA 02111-1307, USA.
--
-- As a special exception, if other files instantiate generics from this
-- unit, or you link this unit with other files to produce an executable,
-- this unit does not by itself cause the resulting executable to be
-- covered by the GNU General Public License. This exception does not
-- however invalidate any other reasons why the executable file might be
-- covered by the GNU Public License.
<<<<<<< HEAD
-- Help package for test program for PragmARC.Scalar_Wrapping

with PragmARC.Scalar_Wrapping;
with PragmARC.List_Unbounded;
package Scalar_Test_Help is
   package Wrapped_Positive is new PragmARC.Scalar_Wrapping (Element => Positive);
   use Wrapped_Positive;

   package Positive_List is new PragmARC.List_Unbounded (Element => Wrapped_Scalar, Assign => Assign);

   procedure Print_One (Item     : in out Wrapped_Scalar;
                        Context  : in out Positive_List.Context_Data'Class;
                        Pos      : in     Positive_List.Position;
                        Continue :    out Boolean);
end Scalar_Test_Help;
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
=======
-- Help package for test program for PragmARC.Scalar_Wrapping

with PragmARC.Scalar_Wrapping;
with PragmARC.List_Unbounded;
package Scalar_Test_Help is
   package Wrapped_Positive is new PragmARC.Scalar_Wrapping (Element => Positive);
   use Wrapped_Positive;

   package Positive_List is new PragmARC.List_Unbounded (Element => Wrapped_Scalar, Assign => Assign);

   procedure Print_One (Item     : in out Wrapped_Scalar;
                        Context  : in out Positive_List.Context_Data'Class;
                        Pos      : in     Positive_List.Position;
                        Continue :    out Boolean);
end Scalar_Test_Help;
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
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49
-- 330, Boston, MA 02111-1307, USA.
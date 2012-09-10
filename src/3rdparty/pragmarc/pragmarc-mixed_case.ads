<<<<<<< HEAD
-- PragmAda Reusable Component (PragmARC)
-- Copyright (C) 2002 by PragmAda Software Engineering.  All rights reserved.
-- **************************************************************************
--
-- Convert a string to mixed case
--
-- History:
-- 2002 Jul 01     J. Carter          V1.1--Changed Pure to Preelaborate
-- 2000 Dec 01     J. Carter          V1.0--Initial release
--
function PragmARC.Mixed_Case (S : String) return String;
pragma Preelaborate (PragmARC.Mixed_Case);
-- Converts S to mixed case
-- (1st character and any character after an underline or dot in upper case,
-- other characters in lower case)
-- Function result has same bounds as S
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
=======
-- PragmAda Reusable Component (PragmARC)
-- Copyright (C) 2002 by PragmAda Software Engineering.  All rights reserved.
-- **************************************************************************
--
-- Convert a string to mixed case
--
-- History:
-- 2002 Jul 01     J. Carter          V1.1--Changed Pure to Preelaborate
-- 2000 Dec 01     J. Carter          V1.0--Initial release
--
function PragmARC.Mixed_Case (S : String) return String;
pragma Preelaborate (PragmARC.Mixed_Case);
-- Converts S to mixed case
-- (1st character and any character after an underline or dot in upper case,
-- other characters in lower case)
-- Function result has same bounds as S
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
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49
-- covered by the GNU Public License.
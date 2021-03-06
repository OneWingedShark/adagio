-- PragmAda Reusable Component (PragmARC)
-- Copyright (C) 2002 by PragmAda Software Engineering.  All rights reserved.
-- **************************************************************************
--
-- History:
-- 2002 Oct 01     J. Carter          V1.4--Added Context to Iterate; use mode out to allow scalars
-- 2002 May 01     J. Carter          V1.3--Added Assign
-- 2001 May 01     J. Carter          V1.2--Added Is_Empty; improved memory usage
-- 2000 Jul 01     J. Carter          V1.1--Changed to use Ada.Numerics.Float_Random
-- 2000 May 01     J. Carter          V1.0--Initial release
--
with Ada.Numerics.Float_Random;
with Ada.Unchecked_Deallocation;

use Ada;
use Ada.Numerics;
package body PragmARC.Skip_List_Unbounded is
   Gen : Float_Random.Generator;

   procedure Dispose is new Unchecked_Deallocation (Object => Node, Name => Link);

   procedure Clear (List : in out Skip_List) is
      Ptr : Link;
   begin -- Clear
      Remove_All : loop
         exit Remove_All when List.Header.Forward (Level_Id'First) = null;

         Ptr := List.Header.Forward (Level_Id'First);
         List.Header.Forward (Level_Id'First) := Ptr.Forward (Level_Id'First);
         Dispose (X => Ptr);
      end loop Remove_All;

      List.Header.Forward := Forward_Set'(Level_Id => null);
      List.Last := null;
      List.Level := Level_Id'First;
   end Clear;

   procedure Assign (To : out Skip_List; From : in Skip_List) is
      Dups : Boolean := False;
      Ptr  : Link    := From.Header.Forward (Level_Id'First);
   begin -- Assign
      if To.Header = From.Header then
         return; -- These are the same lists
      end if;

      Clear (List => To);

      if From.Last = null then -- From is empty
         return;
      end if;

      Check_For_Duplicates : loop
         exit Check_For_Duplicates when Ptr.Forward (Level_Id'First) = null;

         if Ptr.Value = Ptr.Forward (Level_Id'First).Value then
            Dups := True;

            exit Check_For_Duplicates;
         end if;

         Ptr := Ptr.Forward (Level_Id'First);
      end loop Check_For_Duplicates;

      Ptr := From.Header.Forward (Level_Id'First);

      Copy : loop
         exit Copy when Ptr = null;

         Insert (List => To, Item => Ptr.Value, Duplicates_Allowed => Dups);
         Ptr := Ptr.Forward (Level_Id'First);
      end loop Copy;
   end Assign;

   function Search (List : Skip_List; Item : Element) return Result is
      Ptr : Link := List.Header;
   begin -- Search
      All_Levels : for I in reverse Level_Id'First .. List.Level loop
         Advance : loop
            exit Advance when Ptr.Forward (I) = null or else not (Ptr.Forward (I).Value < Item);

            Ptr := Ptr.Forward (I);
         end loop Advance;
      end loop All_Levels;

      Ptr := Ptr.Forward (Level_Id'First);

      if Ptr = null or else Ptr.Value /= Item then
         return Result'(Found => False);
      end if;

      return Result'(Found => True, Item => Ptr.Value);
   end Search;

   procedure Insert (List : in out Skip_List; Item : in Element; Duplicates_Allowed : in Boolean := False) is
      New_Level : Level_Id;
      Update    : Forward_Set (Level_Id) := Forward_Set'(Level_Id => List.Header);
      Ptr       : Link                   := List.Header;

      function Random_Level (List_Level : Level_Id) return Level_Id is
         Probability : constant := 0.25;

         New_Level : Level_Id := Level_Id'First;
      begin -- Random_Level
         Increment : loop
            exit Increment when Float_Random.Random (Gen) >= Probability or New_Level >= Max_Level or New_Level >= List_Level + 1;

            New_Level := New_Level + 1;
         end loop Increment;

         return New_Level;
      end Random_Level;
   begin -- Insert
      All_Levels : for I in reverse Level_Id'First .. List.Level loop
         Advance : loop
            exit Advance when Ptr.Forward (I) = null or else not (Ptr.Forward (I).Value < Item);

            Ptr := Ptr.Forward (I);
         end loop Advance;

         Update (I) := Ptr;
      end loop All_Levels;

      Ptr := Ptr.Forward (Level_Id'First);

      if Ptr /= null and then (Ptr.Value = Item and not Duplicates_Allowed) then
         Ptr.Value := Item;
      else
         After_Dups : loop
            exit After_Dups when Ptr = null or else Ptr.Value /= Item;

            Update (Level_Id'First) := Ptr;
            Ptr := Ptr.Forward (Level_Id'First);
         end loop After_Dups;

         New_Level := Random_Level (List.Level);
         Ptr := new Node (Has_Data => True, Level => New_Level);

         Ptr.Value := Item;

         if New_Level > List.Level then
            List.Level := New_Level;
         end if;

         Adjust_Links : for I in Level_Id'First .. New_Level loop
            Ptr.Forward (I) := Update (I).Forward (I);
            Update (I).Forward (I) := Ptr;
         end loop Adjust_Links;

         if Ptr.Forward (Level_Id'First) = null then -- New last Node
            List.Last := Ptr;
         end if;
      end if;
   exception -- Insert
   when Storage_Error =>
      raise Storage_Exhausted;
   end Insert;

   procedure Delete (List : in out Skip_List; Item : in Element) is
      Update : Forward_Set (Level_Id) := Forward_Set'(Level_Id => List.Header);
      Ptr    : Link                   := List.Header;
   begin -- Delete
      All_Levels : for I in reverse Level_Id'First .. List.Level loop
         Advance : loop
            exit Advance when Ptr.Forward (I) = null or else not (Ptr.Forward (I).Value < Item);

            Ptr := Ptr.Forward (I);
         end loop Advance;

         Update (I) := Ptr;
      end loop All_Levels;

      Ptr := Ptr.Forward (Level_Id'First);

      if Ptr /= null and then Ptr.Value = Item then
         Adjust_Links : for I in Level_Id'First .. List.Level loop
            exit Adjust_Links when Update (I).Forward (I) /= Ptr;

            Update (I).Forward (I) := Ptr.Forward (I);
         end loop Adjust_Links;

         Adjust_Level : loop
            exit Adjust_Level when List.Level <= Level_Id'First or else List.Header.Forward (List.Level) /= null;

            List.Level := List.Level - 1;
         end loop Adjust_Level;

         if List.Last = Ptr then -- Deleted Node at end of List
            List.Last := Update (Level_Id'First);

            if List.Last = List.Header then -- This deletion emptied the List
               List.Last := null;
            end if;
         end if;

         Dispose (X => Ptr);
      end if;
   end Delete;

   function Get_First (List : Skip_List) return Element is
      Ptr : Link := List.Header.Forward (Level_Id'First);
   begin -- Get_First
      if Ptr = null then
         raise Empty;
      end if;

      return Ptr.Value;
   end Get_First;

   function Get_Last (List : Skip_List) return Element is
      -- null;
   begin -- Get_Last
      if List.Last = null then
         raise Empty;
      end if;

      return List.Last.Value;
   end Get_Last;

   function Is_Empty (List : Skip_List) return Boolean is
      -- null;
   begin -- Is_Empty
      return List.Last = null;
   end Is_Empty;

   function Length (List : Skip_List) return Natural is
      Count : Natural := 0;
      Ptr   : Link    := List.Header.Forward (Level_Id'First);
   begin -- Length
      All_Nodes : loop
         exit All_Nodes when Ptr = null;

         Count := Count + 1;
         Ptr := Ptr.Forward (Level_Id'First);
      end loop All_Nodes;

      return Count;
   end Length;

   procedure Finalize (Object : in out Skip_List) is
      -- null;
   begin -- Finalize
      if Object.Header /= null then
         Clear (List => Object);
      end if;

      Dispose (X => Object.Header);
      Object.Last := null;
   end Finalize;

   procedure Iterate (List : in out Skip_List; Context : in out Context_Data) is
      Ptr      : Link := List.Header.Forward (Level_Id'First);
      Continue : Boolean;
   begin -- iterate
      All_Nodes : loop
         exit All_Nodes when Ptr = null;

         Action (Item => Ptr.Value, Context => Context, Continue => Continue);

         exit All_Nodes when not Continue;

         Ptr := Ptr.Forward (Level_Id'First);
      end loop All_Nodes;
   end Iterate;
begin -- PragmARC.Skip_List_Unbounded
   Float_Random.Reset (Gen);
end PragmARC.Skip_List_Unbounded;
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
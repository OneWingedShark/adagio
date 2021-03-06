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
--  $Id: dynamic_vector.ads,v 1.2 2004/01/21 14:48:47 Jano Exp $

-- Package for unbounded vectors, integer-indexed

with Ada.Finalization;  use Ada;

generic
   type Item_type is private;
   Initial_size : Natural := 16;
   Grow_factor  : Float   := 1.5;
package Dynamic_vector is

   pragma Elaborate_body;

   Item_not_found : Exception;

   type Item_array is array (integer range <>) of Item_type;
   type Item_array_access is access all Item_array;
   
   -- That's visible so we can access the internal array an mimic the usual
   -- arrays semantics except for 'Last attribute: Last function must be used.
   -- First can be anything except Integer'First
   -- Controlling guarantees that no leaks occur, and that copies are deep,
   --    and that vector.all is valid from the very first moment.
   type Proto_object (First : Integer) is 
      new Finalization.Controlled with record
      Vector : Item_array_access;
   end record;

   ------------
   -- Object --
   ------------

   -- First is the index for the first element.
   type Object (First : Integer) is new Proto_object with private;

   -- First "attribute"
   -- O (1)
   function First (this : in Object) return integer;
   pragma Inline (First);

   -- Last "attribute"
   -- O (1)
   function Last (this : in Object) return integer;
   pragma Inline (Last);

   -- Length "attribute"
   -- O (1)
   function Length (this : in Object) return integer;
   pragma Inline (Length);

   -- Adds an item to the end. Will grow the vector if necessary.
   -- O (1) or O (n) if growing occurs
   procedure Append (this : in out Object; Item : in Item_type);

   -- Adds an item before a certain position (that could not exist if we
   --    want insertion at Last + 1, i.e., the end. Will grow the vector
   --    if necessary.
   -- O (n)
   procedure Insert (
      this : in out Object; Item : in Item_type; Pos : in Integer);

   -- Grows the vector according to the Grow_factor. Should not be necessary
   --    to be used. It's used internally.
   -- O (n)
   type Sides is (Start, Ending);
   procedure Grow (this : in out Object; Empty_side : in Sides := Ending);

   -- Deletes an item at given pos
   -- O (n)
   procedure Delete (this : in out Object; Pos : in Integer);

   -- Delete all ocurrences of an item
   -- O (n^2)
   procedure Delete_item (this : in out Object; Item : in Item_type);

   -- Clean the vector, starts afresh
   -- O (1)
   procedure Reset (this : in out Object);

   -- Optimize memory usage, vector of only valid positions
   -- Right after optimize, 'Last is valid.
   -- O (n)
   procedure Optimize (this : in out Object);

   -- Member functions, not very useful if you access the vector directly:
   function Value (this : in Object) return Item_array;
   pragma Inline (Value);

   function Value (this : in Object; Pos : in Integer) return Item_type;
   pragma Inline (Value);

   -- Basic searching:
   -- Returns first found after given position
   -- Raise Item_not_found
   -- O (n)
   function Pos (
      this : in Object; 
      Item : in Item_type;
      Pos  : in Integer := Integer'First) return Integer;

private

   procedure Initialize (this : in out Proto_object);
   procedure Adjust     (this : in out Proto_object);
   procedure Finalize   (this : in out Proto_object);

   type Object (First : Integer) is new Proto_object(First) with record
      Last : Integer := First - 1;
   end record;

end Dynamic_vector;

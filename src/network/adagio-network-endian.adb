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
--  $Id: adagio-network-endian.adb,v 1.3 2004/01/21 21:05:37 Jano Exp $

with Ada.Unchecked_conversion; use Ada;
with Interfaces;         use Interfaces;

package body Adagio.Network.Endian is

   function to_Unsigned_32 is new Unchecked_conversion (Integer, Unsigned_32);
   function to_Integer is new Unchecked_conversion (Unsigned_32, Integer);

   function Is_little_endian return boolean is
      use type Interfaces.Unsigned_8;
      var1: Interfaces.Unsigned_16:= 16#abcd#;
      var2: Array(1..2) of Interfaces.Unsigned_8;
      for var2'address use var1'address;
      pragma Import (Ada, var2);
   begin
      return var2(1) = 16#cd#;
   end Is_little_endian;

   -- Convert an arbitrary long byte array to integer in the local endingness
   -- May raise Constraint_error if array lengths exceedes integer capacity.
   function Convert (
      From        : Byte_array;
      Big_endian  : Boolean := true) return Integer is

      Aux      : Unsigned_32 := 0;
      
   begin
      if From'length > 4 then
         raise Constraint_error;
      end if;

      if not Big_endian then
         -- If little endian:
         for n in reverse From'Range loop
            Aux := Shift_left (Aux, 8) or Unsigned_32 (From (n));
         end loop;
      else
         -- Reverse positions:
         for n in From'Range loop
            Aux := Shift_left (Aux, 8) or Unsigned_32 (From (n));
         end loop;
      end if;

      return Integer (Aux);
         
   end Convert;

   function Convert_L (
      From        : Byte_array;
      Big_endian  : Boolean := true) return Long_Long_Integer is

      Aux      : Unsigned_64 := 0;
      
   begin
      if From'length > 8 then
         raise Constraint_error;
      end if;

      if not Big_endian then
         -- If little endian:
         for n in reverse From'Range loop
            Aux := Shift_left (Aux, 8) or Unsigned_64 (From (n));
         end loop;
      else
         -- Reverse positions:
         for n in From'Range loop
            Aux := Shift_left (Aux, 8) or Unsigned_64 (From (n));
         end loop;
      end if;

      return Long_Long_Integer (Aux);
         
   end Convert_L;

   -- Converts an integer to an array of bytes, in the desired endianness.
   function Convert (
      From        : Long_Long_Integer;
      Big_endian  : Boolean := false) return Byte_array is
      
      Aux    : Unsigned_64 := Unsigned_64 (From);
      Size   : Natural := 0;
      Result : Byte_array (1 .. 8);
      Invert : Byte_array (1 .. 8);
      
   begin
      while Aux /= 0 loop
         Size := Size + 1;
         Result (Size) := Byte (Aux and 16#ff#);
         Aux := Shift_right (Aux, 8);
      end loop;

      if Big_endian then
         for N in 1 .. Size loop
            Invert (Size + 1 - N) := Result (N);
         end loop;
         return Invert (1 .. Size);
      end if;

      return Result (1 .. Size);
   end;

   -- Converts an integer to an array of bytes, in the desired endianness.
   -- Size specified (in bytes):
   function Convert (
      From        : Long_Long_Integer;
      Size        : Natural;
      Big_endian  : Boolean := false) return Byte_array is
      Aux         : Byte_array (1 .. Size) := (others => 0);
      Result      : Byte_array := Convert (From, Big_endian);
   begin
      -- Pad if necessary :
      if Result'Length < Size then
         if Big_endian then
            return Aux (1 .. Size - Result'Length) & Result;
         else
            return Result & Aux (1 .. Size - Result'Length);
         end if;
      else
         return Result;
      end if;
   end Convert;

   -- Converts an integer to an array of bytes, in the desired endianness.
   -- Optimally returns the shortest possible array:
   function Convert (
      From        : Integer;
      Big_endian  : Boolean := false) return Byte_array is
   begin
      return Convert (Long_long_integer (From), Big_endian);
   end Convert;

   -- Converts an integer to an array of bytes, in the desired endianness.
   -- Size specified (in bytes):
   function Convert (
      From        : Integer;
      Size        : Natural;
      Big_endian  : Boolean := false) return Byte_array is
   begin
      return Convert (Long_long_integer (From), Size, Big_endian);
   end Convert;

   -- Converts a byte array into a string of same bytes:
   function To_string (From : Byte_array) return String is
      S : String (From'First .. From'Last);
   begin
      for N in S'Range loop
         S (N) := Character'Val (From (N));
      end loop;

      return S;
   end To_string;

   -- Inverse of the previous:
   function To_byte_array (From : String) return Byte_array is
      B : Byte_array (From'Range);
   begin
      for N in B'Range loop
         B (N) := Byte (Character'Pos (From (N)));
      end loop;

      return B;
   end To_byte_array;

   -- Invert a byte_array order
   function Invert (From : Byte_array) return Byte_array is
      To  : Byte_array (From'Range);
      Pos : Integer := From'Last;
   begin
      for N in To'Range loop
         To (N) := From (Pos);
         Pos := Pos - 1;
      end loop;

      return To;
   end;
   
begin

   Little_endian:= Is_little_endian;
   
end Adagio.Network.Endian;

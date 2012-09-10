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
--  $Id: adagio-g2-mesh_element.ads,v 1.3 2004/01/21 21:05:26 Jano Exp $

with Ada.Calendar;
use  Ada;

package Adagio.G2.Mesh_element is

   type Object is private;

   ------------------------------------------------------------------------
   -- Create                                                             --
   ------------------------------------------------------------------------
   -- Create from a HTTP header string (RFC ????)
   -- Receives an "x.x.x.x:port [yyyy-mm-ddThh:mmZ]"
   function Create (
      Resource : in String;
      Location : in String; 
      Verified : in Boolean := false) return Object;

   ------------------------------------------------------------------------
   -- Key                                                                --
   ------------------------------------------------------------------------
   function Key (This : in Object) return String;

   ------------------------------------------------------------------------
   -- Location                                                           --
   ------------------------------------------------------------------------
   function Location (This : in Object) return String;

   ------------------------------------------------------------------------
   -- Better                                                             --
   ------------------------------------------------------------------------
   -- L "better" than R
   function Better (L, R : in Object) return boolean;

private

   type Object is record
      Resource : UString;
      Location : UString;
      Since    : Calendar.Time := Calendar.Clock;
      Verified : Boolean := false;
   end record;

end Adagio.G2.Mesh_element;
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
--  $Id: adagio-g2-mesh_element.ads,v 1.3 2004/01/21 21:05:26 Jano Exp $

with Ada.Calendar;
use  Ada;

package Adagio.G2.Mesh_element is

   type Object is private;

   ------------------------------------------------------------------------
   -- Create                                                             --
   ------------------------------------------------------------------------
   -- Create from a HTTP header string (RFC ????)
   -- Receives an "x.x.x.x:port [yyyy-mm-ddThh:mmZ]"
   function Create (
      Resource : in String;
      Location : in String; 
      Verified : in Boolean := false) return Object;

   ------------------------------------------------------------------------
   -- Key                                                                --
   ------------------------------------------------------------------------
   function Key (This : in Object) return String;

   ------------------------------------------------------------------------
   -- Location                                                           --
   ------------------------------------------------------------------------
   function Location (This : in Object) return String;

   ------------------------------------------------------------------------
   -- Better                                                             --
   ------------------------------------------------------------------------
   -- L "better" than R
   function Better (L, R : in Object) return boolean;

private

   type Object is record
      Resource : UString;
      Location : UString;
      Since    : Calendar.Time := Calendar.Clock;
      Verified : Boolean := false;
   end record;

end Adagio.G2.Mesh_element;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

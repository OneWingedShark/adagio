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
--  $Id: adagio-traffic.ads,v 1.4 2004/02/24 15:26:13 Jano Exp $

with Agpl.Http.Server.Sort_handler;
with Agpl.Types.Ustrings; use Agpl.Types.Ustrings;

with Ada.Calendar;
use  Ada;

package Adagio.Traffic is

   pragma Elaborate_Body;

   -- Max stored traffic
   Max_traffic : Positive := 249;

   Type Ways is (Incoming, Outgoing);

   type Object is tagged record
      Arrival  : Calendar.Time := Calendar.Clock;
      Protocol : Ustring;
      Way      : Ways;
      From     : Ustring;
      Name     : Ustring;
      Data     : Ustring;
   end record;

   ------------------------------------------------------------------------
   -- Add                                                                --
   ------------------------------------------------------------------------
   procedure Add (This : in Object);

   ------------------------------------------------------------------------
   -- Clear                                                              --
   ------------------------------------------------------------------------
   procedure Clear;

   ------------------------------------------------------------------------
   -- Http_report                                                        --
   ------------------------------------------------------------------------
   procedure Http_report (Data : out Agpl.Http.Server.Sort_handler.Data_set);

private

   use type Calendar.Time;

end Adagio.Traffic;

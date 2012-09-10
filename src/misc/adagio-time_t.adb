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
--  $Id: adagio-time_t.adb,v 1.3 2004/01/21 21:05:36 Jano Exp $

with Ada.Calendar;   use Ada;

package body Adagio.Time_t is

   use type Calendar.Time;

   Epoch : constant Calendar.Time := Calendar.Time_of (1970, 1, 1);

   function Clock return Time_t is
   begin
      return Time_t (Calendar.Clock - Epoch);
   end Clock;

   function To_time_t (Time : Calendar.Time) return Time_t is
   begin
      return Time_t (Time - Epoch);
   end To_time_t;

   function To_time (Time : Time_t) return Calendar.Time is
   begin
      return Epoch + Duration (Time);
   end To_time;

   function To_duration (Time : Time_t) return Duration is
   begin
      return Duration (Time);
   end To_duration;

end Adagio.Time_t;

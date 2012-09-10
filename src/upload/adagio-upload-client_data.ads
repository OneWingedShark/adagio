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
--  $Id: adagio-upload-client_data.ads,v 1.3 2004/01/21 21:05:49 Jano Exp $

--  Data to be remembered about all clients (credit system).

with Adagio.Constants; use Adagio.Constants;
with Adagio.Types; use Adagio.Types;

with Agpl.Types.Ustrings; use Agpl.Types.Ustrings;

with Charles.Hash_string;
with Charles.Maps.Hashed.Strings.Unbounded;

with Ada.Calendar; use Ada;

package Adagio.Upload.Client_data is

   pragma Elaborate_body;

   type Object is record
      Client_id    : Ustring;
      Sent         : File_size;       -- Data sent
      Last_request : Calendar.Time := Past_aeons;
   end record;
   type Object_access is access all Object;

   package Data_list is new Charles.Maps.Hashed.Strings.Unbounded (
      Object_access, Charles.Hash_string, "=", "=");

   protected List is
      procedure Init;
      procedure Save;

      procedure Add_sent (Client_id : in String; Amount : in File_size);

      function Get_sent (Client_id : in String) return File_size;

      procedure Set_last_request (
         Client_id : in String; 
         Been      : in Calendar.Time := Calendar.Clock);

      -- Will return Past_aeons if unknown
      function Get_last_request (Client_id : in String) return Calendar.Time;

   private 
      Data : Data_list.Container_type;
   end List;

end Adagio.Upload.Client_data;









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
--  $Id: adagio-upload-client_data.ads,v 1.3 2004/01/21 21:05:49 Jano Exp $

--  Data to be remembered about all clients (credit system).

with Adagio.Constants; use Adagio.Constants;
with Adagio.Types; use Adagio.Types;

with Agpl.Types.Ustrings; use Agpl.Types.Ustrings;

with Charles.Hash_string;
with Charles.Maps.Hashed.Strings.Unbounded;

with Ada.Calendar; use Ada;

package Adagio.Upload.Client_data is

   pragma Elaborate_body;

   type Object is record
      Client_id    : Ustring;
      Sent         : File_size;       -- Data sent
      Last_request : Calendar.Time := Past_aeons;
   end record;
   type Object_access is access all Object;

   package Data_list is new Charles.Maps.Hashed.Strings.Unbounded (
      Object_access, Charles.Hash_string, "=", "=");

   protected List is
      procedure Init;
      procedure Save;

      procedure Add_sent (Client_id : in String; Amount : in File_size);

      function Get_sent (Client_id : in String) return File_size;

      procedure Set_last_request (
         Client_id : in String; 
         Been      : in Calendar.Time := Calendar.Clock);

      -- Will return Past_aeons if unknown
      function Get_last_request (Client_id : in String) return Calendar.Time;

   private 
      Data : Data_list.Container_type;
   end List;

end Adagio.Upload.Client_data;









>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

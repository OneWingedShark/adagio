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
--  $Id: adagio-gui-handlers.ads,v 1.3 2004/02/24 15:26:11 Jano Exp $

with Adagio.Event_log;
with Adagio.G2.Core;

with Agpl.Http.Server.Sort_handler;

with Templates_parser;

package Adagio.Gui.Handlers is

   ------------------------------------------------------------------------
   -- Hubs_object                                                        --
   ------------------------------------------------------------------------
   Hubs_object : Agpl.Http.Server.Sort_handler.Object (
      Source => G2.Core.Hubs_http_handler'Access,
      Single => Agpl.Http.Server.Sort_handler.Null_singleton'Access,
      Page   => new String'("hubs.html"));

   ------------------------------------------------------------------------
   -- Events_object                                                      --
   ------------------------------------------------------------------------
   function Events_singleton return Templates_parser.Translate_table;
   Events_object : Agpl.Http.Server.Sort_handler.Object (
      Source    => Event_log.Http_report'Access, 
      Single    => Events_singleton'Access,
      Page      => new String'("events.html"));

   ------------------------------------------------------------------------
   -- Register                                                           --
   ------------------------------------------------------------------------
   procedure Register;

end Adagio.Gui.Handlers;
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
--  $Id: adagio-gui-handlers.ads,v 1.3 2004/02/24 15:26:11 Jano Exp $

with Adagio.Event_log;
with Adagio.G2.Core;

with Agpl.Http.Server.Sort_handler;

with Templates_parser;

package Adagio.Gui.Handlers is

   ------------------------------------------------------------------------
   -- Hubs_object                                                        --
   ------------------------------------------------------------------------
   Hubs_object : Agpl.Http.Server.Sort_handler.Object (
      Source => G2.Core.Hubs_http_handler'Access,
      Single => Agpl.Http.Server.Sort_handler.Null_singleton'Access,
      Page   => new String'("hubs.html"));

   ------------------------------------------------------------------------
   -- Events_object                                                      --
   ------------------------------------------------------------------------
   function Events_singleton return Templates_parser.Translate_table;
   Events_object : Agpl.Http.Server.Sort_handler.Object (
      Source    => Event_log.Http_report'Access, 
      Single    => Events_singleton'Access,
      Page      => new String'("events.html"));

   ------------------------------------------------------------------------
   -- Register                                                           --
   ------------------------------------------------------------------------
   procedure Register;

end Adagio.Gui.Handlers;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

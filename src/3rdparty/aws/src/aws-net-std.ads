------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                            Copyright (C) 2002                            --
--                                ACT-Europe                                --
--                                                                          --
--  Authors: Dmitriy Anisimkov - Pascal Obry                                --
--                                                                          --
--  This library is free software; you can redistribute it and/or modify    --
--  it under the terms of the GNU General Public License as published by    --
--  the Free Software Foundation; either version 2 of the License, or (at   --
--  your option) any later version.                                         --
--                                                                          --
--  This library is distributed in the hope that it will be useful, but     --
--  WITHOUT ANY WARRANTY; without even the implied warranty of              --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU       --
--  General Public License for more details.                                --
--                                                                          --
--  You should have received a copy of the GNU General Public License       --
--  along with this library; if not, write to the Free Software Foundation, --
--  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.          --
--                                                                          --
--  As a special exception, if other files instantiate generics from this   --
--  unit, or you link this unit with other files to produce an executable,  --
--  this  unit  does not  by itself cause  the resulting executable to be   --
--  covered by the GNU General Public License. This exception does not      --
--  however invalidate any other reasons why the executable file  might be  --
--  covered by the  GNU Public License.                                     --
------------------------------------------------------------------------------

--  $Id: aws-net-std.ads,v 1.1 2003/10/05 19:59:57 Jano Exp $

--  This is the standard (non-SSL) socket support. Only the implementation of
--  this package depends on a specific socket binding. To port AWS to another
--  socket implementation you need only to rewrite the body.

with Ada.Streams;

package AWS.Net.Std is

   use Ada.Streams;

   type Socket_Type is new Net.Socket_Type with private;

   ----------------
   -- Initialize --
   ----------------

   procedure Bind
     (Socket : in out Socket_Type;
      Port   : in     Natural;
      Host   : in     String := "");
   --  Bind a socket on a given port.

   procedure Listen
     (Socket     : in Socket_Type;
      Queue_Size : in Positive := 5);
   --  Set the queue size of the socket

   procedure Accept_Socket
     (Socket     : in     Net.Socket_Type'Class;
      New_Socket : in out Socket_Type);
   --  Accept a connection on a socket.

   procedure Connect
     (Socket   : in out Socket_Type;
      Host     : in     String;
      Port     : in     Positive);
   --  Connect a socket on a given host/port. If Security is true an secure
   --  socket will be used.

   procedure Shutdown (Socket : in Socket_Type);
   --  Shutdown both side of the socket and close it.

   procedure Free (Socket : in out Socket_Type);
   --  Release memory associated with the socket object

   --------
   -- IO --
   --------

   procedure Send
     (Socket : in Socket_Type;
      Data   : in Stream_Element_Array);
   pragma Inline (Send);

   function Receive
     (Socket : in Socket_Type;
      Max    : in Stream_Element_Count := 4096)
      return Stream_Element_Array;
   pragma Inline (Receive);

   ------------
   -- Others --
   ------------

   function Get_FD (Socket : in Socket_Type) return Integer;

   function Peer_Addr (Socket : in Socket_Type) return String;

   function Host_Name return String;

   procedure Set_Send_Buffer
     (Socket : in Socket_Type;
      Size   : in Natural);
   --  Set the internal socket send buffer size.
   --  Do not confuse with buffers for the AWS.Net.Buffered operations.

   procedure Set_Receive_Buffer
     (Socket : in Socket_Type;
      Size   : in Natural);
   --  Set the internal socket receive buffer size.
   --  Do not confuse with buffers for the AWS.Net.Buffered operations.

   procedure Set_Blocking_Mode
     (Socket   : in Socket_Type;
      Blocking : in Boolean);
   --  Set the blocking mode for the socket.

private

   type Socket_Hidden;

   type Socket_Hidden_Access is access Socket_Hidden;

   type Socket_Type is new Net.Socket_Type with record
      S : Socket_Hidden_Access;
   end record;

end AWS.Net.Std;

-------------------------------------------------------------------------------
--                                                                           --
--                      GNADE  : GNu Ada Database Environment                --
--                                                                           --
--  Author          : Juergen Pfeifer <juergen.pfeifer@gmx.net>
--
--  Copyright (C) 2000-2001 Juergen Pfeifer
--                                                                           --
--  GNADE is free software;  you can redistribute it  and/or modify it under --
--  terms of the  GNU General Public License as published  by the Free Soft- --
--  ware  Foundation;  either version 2,  or (at your option) any later ver- --
--  sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
--  OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
--  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
--  for  more details.  You should have  received  a copy of the GNU General --
--  Public License  distributed with GNAT;  see file COPYING.  If not, write --
--  to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston, --
--  MA 02111-1307, USA.                                                      --
--                                                                           --
--  As a special exception,  if other files  instantiate  generics from this --
--  unit, or you link  this unit with other files  to produce an executable, --
--  this  unit  does not  by itself cause  the resulting  executable  to  be --
--  covered  by the  GNU  General  Public  License.  This exception does not --
--  however invalidate  any other reasons why  the executable file  might be --
--  covered by the  GNU Public License.                                      --
--                                                                           --
--  GNADE is implemented to work with GNAT, the GNU Ada compiler.            --
--                                                                           --
-------------------------------------------------------------------------------
with Ada.Exceptions;

package body GNU.DB.SQLCLI.Statement_Attribute.Debug is

   procedure Dump (File            : in Ada.Text_IO.File_Type;
                   StatementHandle : in SQLHSTMT) is
      package SA_IO is
         new Ada.Text_IO.Enumeration_IO (SQL_STATEMENT_ATTRIBUTE);
      use Ada.Text_IO;
      use SA_IO;

      procedure Dump_Statement_Attr (A : in SQL_STATEMENT_ATTRIBUTE);
      procedure Dump_Statement_Attr (A : in SQL_STATEMENT_ATTRIBUTE) is
         use SA_IO;
         AV : constant Statement_Attribute'Class
           := SQLGetStmtAttr (StatementHandle, A);
      begin
         Put (File, A, Debug_Label_Width);
         Put (File, ": ");
         Put (File, Statement_Attributes.To_String (AV));
         New_Line (File);
      end Dump_Statement_Attr;
   begin
      for I in SQL_STATEMENT_ATTRIBUTE'Range loop
         declare
         begin
            Dump_Statement_Attr (I);
         exception
            when Event : others =>
               Put (File, I, Debug_Label_Width);
               Put (File, ": ***** ");
               Put (File, Ada.Exceptions.Exception_Name (Event));
               Put (File, ", ");
               Put (File, Ada.Exceptions.Exception_Message (Event));
               New_Line (File);
         end;
      end loop;
   end Dump;

   procedure Dump (StatementHandle : in SQLHSTMT)
   is
   begin
      Dump (Ada.Text_IO.Standard_Output, StatementHandle);
   end Dump;

end GNU.DB.SQLCLI.Statement_Attribute.Debug;

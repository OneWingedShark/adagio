------------------------------------------------------------------------------
--                             Templates Parser                             --
--                                                                          --
--                        Copyright (C) 1999 - 2002                         --
--                               Pascal Obry                                --
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

--  $Id: templates_parser-expr.adb,v 1.2 2004/02/24 15:40:19 Jano Exp $

with Ada.Text_IO;

separate (Templates_Parser)

package body Expr is

   function Is_Op (O : in String) return Boolean;
   --  Returns True is O is a binary operator.

   function Is_U_Op (O : in String) return Boolean;
   --  Returns True is O is an unary operator.

   -----------
   -- Image --
   -----------

   function Image (O : in Ops) return String is
   begin
      case O is
         when O_And   => return "and";
         when O_Or    => return "or";
         when O_Xor   => return "xor";
         when O_Sup   => return ">";
         when O_Inf   => return "<";
         when O_Esup  => return ">=";
         when O_Einf  => return "<=";
         when O_Equal => return "=";
         when O_Diff  => return "/=";
      end case;
   end Image;

   function Image (O : in U_Ops) return String is
   begin
      case O is
         when O_Not   => return "not";
      end case;
   end Image;

   -----------
   -- Is_Op --
   -----------

   function Is_Op (O : in String) return Boolean is
   begin
      if O = "and" then
         return True;

      elsif O = "or" then
         return True;

      elsif O = "xor" then
         return True;

      elsif O = ">" then
         return True;

      elsif O = "<" then
         return True;

      elsif O = ">=" then
         return True;

      elsif O = "<=" then
         return True;

      elsif O = "=" then
         return True;

      elsif O = "/=" then
         return True;

      else
         return False;
      end if;
   end Is_Op;

   -------------
   -- Is_U_Op --
   -------------

   function Is_U_Op (O : in String) return Boolean is
   begin
      if O = "not" then
         return True;
      else
         return False;
      end if;
   end Is_U_Op;

   -----------
   -- Parse --
   -----------

   function Parse (Expression : in String) return Tree is

      Index : Natural := Expression'First;

      function Get_Token return String;
      --  Returns next token. Set Index to the last analysed position in
      --  Expression.

      ---------------
      -- Get_Token --
      ---------------

      function Get_Token return String is
         use Strings;
         K, I  : Natural;
      begin
         if Index > Expression'Last then
            --  No more data to read.
            return "";
         end if;

         Index := Fixed.Index
           (Expression (Index .. Expression'Last), Blank, Outside);

         if Index = 0 then
            --  There is only one token, return the whole string.
            Index := Expression'Last + 1;
            return Expression (Index .. Expression'Last);

         elsif Expression (Index) = '(' then
            --  This is a sub-expression, returns it.
            K := 0;

            declare
               L : Natural := 1;
            begin
               Look_For_Sub_Exp : for I in Index + 1 .. Expression'Last loop
                  if Expression (I) = '(' then
                     L := L + 1;
                  elsif Expression (I) = ')' then
                     K := I;
                     L := L - 1;
                  end if;

                  exit Look_For_Sub_Exp when L = 0;
               end loop Look_For_Sub_Exp;
            end;

            if K = 0 then
               --  No matching closing parenthesis.

               Exceptions.Raise_Exception
                 (Internal_Error'Identity,
                  "condition, no matching parenthesis for parent at pos "
                  & Natural'Image (Index));

            else
               I := Index;
               Index := K + 1;
               return Expression (I .. K);
            end if;

         elsif Expression (Index) = '"' then
            --  This is a string, returns it.
            K := 0;

            Look_For_String : for I in Index + 1 .. Expression'Last loop
               if Expression (I) = '"' then
                  K := I;
                  exit;
               end if;
            end loop Look_For_String;

            if K = 0 then
               --  No matching closing quote

               Exceptions.Raise_Exception
                 (Internal_Error'Identity,
                  "condition, no matching closing quote string at pos "
                  & Natural'Image (Index));

            else
               I := Index;
               Index := K + 1;
               return Expression (I .. K);
            end if;

         else
            --  We have found the start of a token, look for end of it.
            K := Fixed.Index (Expression (Index .. Expression'Last), Blank);

            if K = 0 then
               --  Token end is the end of Expression.
               I := Index;
               Index := Expression'Last + 1;
               return Expression (I .. Expression'Last);
            else
               I := Index;
               Index := K + 1;
               return Expression (I .. K - 1);
            end if;
         end if;
      end Get_Token;

      L_Tok : constant String := Get_Token;  -- left operand
      O_Tok : constant String := Get_Token;  -- operator
      R_Tok : constant String := Get_Token;  -- right operand

   begin
      if Is_U_Op (L_Tok) then

         if R_Tok = "" then
            --  This is "not expr"
            return new Node'
              (U_Op, Value (L_Tok),
               Parse (O_Tok & ' ' & R_Tok & ' '
                        & Expression (Index .. Expression'Last)));
         else
            --  This is "not expr op expr", parse again with
            --  "(not expr) op expr"
            return Parse ('(' & L_Tok & ' ' & O_Tok & ") "
                            & R_Tok & ' '
                            & Expression (Index .. Expression'Last));
         end if;

      elsif Is_Op (O_Tok) and then Is_U_Op (R_Tok) then
         --  We have "expr op u_op expr", parse again with
         --  "expr op (u_op expr)"
         return Parse (L_Tok & ' ' & O_Tok
                         & " (" & R_Tok & ' '
                         & Expression (Index .. Expression'Last) & ')');

      elsif O_Tok = "" then
         --  No more operator, this is a leaf. It is either a variable or a
         --  value.

         if L_Tok (L_Tok'First) = '(' then
            --  an expression
            return Parse (L_Tok (L_Tok'First + 1 .. L_Tok'Last - 1));

         elsif Strings.Fixed.Index (L_Tok, To_String (Begin_Tag)) = 0 then
            --  a value
            return new Node'(Value, To_Unbounded_String (No_Quote (L_Tok)));

         else
            --  a variable
            return new Node'(Var, Build (No_Quote (L_Tok)));
         end if;


      else
         if Index > Expression'Last then
            --  This is the latest token

            return new Node'(Op, Value (O_Tok),
                             Parse (L_Tok), Parse (R_Tok));

         else
            declare
               NO_Tok : constant String := Get_Token;
            begin
               return new Node'
                 (Op, Value (NO_Tok),
                  Parse (L_Tok & ' ' & O_Tok & ' ' & R_Tok),
                  Parse (Expression (Index .. Expression'Last)));
            end;
         end if;
      end if;
   end Parse;

   ----------------
   -- Print_Tree --
   ----------------

   procedure Print_Tree (E : in Tree) is
   begin
      case E.Kind is
         when Value =>
            declare
               Val : constant String := To_String (E.V);
               K   : constant Natural := Fixed.Index (Val, " ");
            begin
               if K = 0 then
                  Text_IO.Put (Val);
               else
                  Text_IO.Put ('"' & Val & '"');
               end if;
            end;

         when Var =>
            Text_IO.Put (Image (E.Var));

         when Op =>
            Text_IO.Put ('(');
            Print_Tree (E.Left);
            Text_IO.Put (' ' & Image (E.O) & ' ');
            Print_Tree (E.Right);
            Text_IO.Put (')');

         when U_Op =>
            Text_IO.Put ('(');
            Text_IO.Put (Image (E.U_O) & ' ');
            Print_Tree (E.Next);
            Text_IO.Put (')');
      end case;
   end Print_Tree;

   -------------
   -- Release --
   -------------

   procedure Release (E : in out Tree) is
      procedure Free is new Ada.Unchecked_Deallocation (Node, Tree);
   begin
      case E.Kind is
         when Value =>
            null;

         when Var =>
            Release (E.Var);

         when Op =>
            Release (E.Left);
            Release (E.Right);

         when U_Op =>
            Release (E.Next);
      end case;

      Free (E);
   end Release;

   -----------
   -- Value --
   -----------

   function Value (O : in String) return Ops is
   begin
      if O = "and" then
         return O_And;

      elsif O = "or" then
         return O_Or;

      elsif O = "xor" then
         return O_Xor;

      elsif O = ">" then
         return O_Sup;

      elsif O = "<" then
         return O_Inf;

      elsif O = ">=" then
         return O_Esup;

      elsif O = "<=" then
         return O_Einf;

      elsif O = "=" then
         return O_Equal;

      elsif O = "/=" then
         return O_Diff;

      else
         Exceptions.Raise_Exception
           (Internal_Error'Identity, "condition, unknown operator " & O);
      end if;
   end Value;

   function Value (O : in String) return U_Ops is
   begin
      if O = "not" then
         return O_Not;

      else
         Exceptions.Raise_Exception
           (Internal_Error'Identity, "condition, unknown operator " & O);
      end if;
   end Value;

end Expr;

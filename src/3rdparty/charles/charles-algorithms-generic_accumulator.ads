<<<<<<< HEAD
generic

   type Element_Type (<>) is private;
   
   Result : in out Element_Type'Base;
   
   with function "+" (L, R : Element_Type'Base)
      return Element_Type'Base is <>;
   
procedure Charles.Algorithms.Generic_Accumulator (Element : in Element_Type);
=======
generic

   type Element_Type (<>) is private;
   
   Result : in out Element_Type'Base;
   
   with function "+" (L, R : Element_Type'Base)
      return Element_Type'Base is <>;
   
procedure Charles.Algorithms.Generic_Accumulator (Element : in Element_Type);
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

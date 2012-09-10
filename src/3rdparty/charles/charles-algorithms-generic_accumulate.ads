<<<<<<< HEAD
generic

   type Element_Type (<>) is private;

   type Iterator_Type is private;
   
   with function Succ (Iterator : Iterator_Type)
      return Iterator_Type is <>;
      
   with function Element (Iterator : Iterator_Type)
      return Element_Type is <>;
      
   with function "+" (L, R : Element_Type'Base) 
      return Element_Type'Base is <>;
   
function Charles.Algorithms.Generic_Accumulate
  (First, Back   : Iterator_Type;
=======
generic

   type Element_Type (<>) is private;

   type Iterator_Type is private;
   
   with function Succ (Iterator : Iterator_Type)
      return Iterator_Type is <>;
      
   with function Element (Iterator : Iterator_Type)
      return Element_Type is <>;
      
   with function "+" (L, R : Element_Type'Base) 
      return Element_Type'Base is <>;
   
function Charles.Algorithms.Generic_Accumulate
  (First, Back   : Iterator_Type;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49
   Initial_Value : Element_Type'Base) return Element_Type'Base;
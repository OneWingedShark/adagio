<<<<<<< HEAD
generic

   type Left_Type is private;
   
   type Right_Type is private;
   
   with function Is_Less 
     (L : Left_Type;
      R : Right_Type) return Boolean is <>;
   
   with function Is_Less
     (L : Right_Type;
      R : Left_Type) return Boolean is <>;
   
   with procedure Succ (Iterator : in out Left_Type) is <>;
   
   with procedure Succ (Iterator : in out Right_Type) is <>;
   
   with function "=" (L, R : Left_Type) return Boolean is <>;
   
   with function "=" (L, R : Right_Type) return Boolean is <>;
   
function Charles.Algorithms.Generic_Includes_2
  (Left_First, Left_Back   : Left_Type;
   Right_First, Right_Back : Right_Type) return Boolean;
   
   


=======
generic

   type Left_Type is private;
   
   type Right_Type is private;
   
   with function Is_Less 
     (L : Left_Type;
      R : Right_Type) return Boolean is <>;
   
   with function Is_Less
     (L : Right_Type;
      R : Left_Type) return Boolean is <>;
   
   with procedure Succ (Iterator : in out Left_Type) is <>;
   
   with procedure Succ (Iterator : in out Right_Type) is <>;
   
   with function "=" (L, R : Left_Type) return Boolean is <>;
   
   with function "=" (L, R : Right_Type) return Boolean is <>;
   
function Charles.Algorithms.Generic_Includes_2
  (Left_First, Left_Back   : Left_Type;
   Right_First, Right_Back : Right_Type) return Boolean;
   
   


>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

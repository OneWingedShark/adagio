<<<<<<< HEAD
procedure Charles.Algorithms.Generic_Copy 
  (First, Back : in     Source_Type;
   Target      : in out Target_Type) is
   
   Source : Source_Type := First;
   
begin

   while Source /= Back loop
   
      Assign (Target, Source);
      
      Succ (Source);
      
      Succ (Target);
      
   end loop;
   
end Charles.Algorithms.Generic_Copy;

=======
procedure Charles.Algorithms.Generic_Copy 
  (First, Back : in     Source_Type;
   Target      : in out Target_Type) is
   
   Source : Source_Type := First;
   
begin

   while Source /= Back loop
   
      Assign (Target, Source);
      
      Succ (Source);
      
      Succ (Target);
      
   end loop;
   
end Charles.Algorithms.Generic_Copy;

>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49
   
<<<<<<< HEAD
with Charles.Deque_Types;

generic

   with package Maps is 
      new Charles.Deque_Types (<>);
      
   with function Image (Element : Maps.Element_Type)
      return String;
      
procedure Charles.Generic_Dump_Deque (Map : Maps.Map_Type);
=======
with Charles.Deque_Types;

generic

   with package Maps is 
      new Charles.Deque_Types (<>);
      
   with function Image (Element : Maps.Element_Type)
      return String;
      
procedure Charles.Generic_Dump_Deque (Map : Maps.Map_Type);
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

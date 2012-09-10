<<<<<<< HEAD
package body Charles.Prime_Numbers is

   function To_Prime (Length : Integer'Base) 
      return Positive is
   begin
      --this could be more efficiently implemented as a binary search:
      
      for I in Primes'Range loop
         if Primes (I) >= Length then
            return Primes (I);
         end if;
      end loop;
      
      return Primes (Primes'Last);
   end;
   
end Charles.Prime_Numbers;
=======
package body Charles.Prime_Numbers is

   function To_Prime (Length : Integer'Base) 
      return Positive is
   begin
      --this could be more efficiently implemented as a binary search:
      
      for I in Primes'Range loop
         if Primes (I) >= Length then
            return Primes (I);
         end if;
      end loop;
      
      return Primes (Primes'Last);
   end;
   
end Charles.Prime_Numbers;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

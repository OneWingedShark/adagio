<<<<<<< HEAD
package Sha1.Files is

   -- Hash a regular file.
   -- We must supply a full/relative path to the file.
   function Hash
     (Name: String; Implementation: Method:= Time_efficient) return Digest;
   
end Sha1.Files;
=======
package Sha1.Files is

   -- Hash a regular file.
   -- We must supply a full/relative path to the file.
   function Hash
     (Name: String; Implementation: Method:= Time_efficient) return Digest;
   
end Sha1.Files;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

<<<<<<< HEAD
package body Sha1.Bytes is

   procedure Feed (
      HContext: in out Hash_context; 
      Bytes   : in     Byte_array) is
   begin
      Feed (Context (HContext), Bytes);
   end Feed;

   -- It permits also take branchs since Hash_context is not limited.
   function Hash(HContext: Hash_context) return Digest is
   begin
      return Get_SHA1 (Context (HContext));
   end Hash;

end Sha1.Bytes;
=======
package body Sha1.Bytes is

   procedure Feed (
      HContext: in out Hash_context; 
      Bytes   : in     Byte_array) is
   begin
      Feed (Context (HContext), Bytes);
   end Feed;

   -- It permits also take branchs since Hash_context is not limited.
   function Hash(HContext: Hash_context) return Digest is
   begin
      return Get_SHA1 (Context (HContext));
   end Hash;

end Sha1.Bytes;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

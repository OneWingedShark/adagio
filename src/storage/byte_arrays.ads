<<<<<<< HEAD
with Interfaces;

package Byte_arrays is

   subtype Byte is Interfaces.Unsigned_8;

   type Byte_array is array (integer range <>) of Byte;
   pragma Pack(Byte_array);

end Byte_arrays;
=======
with Interfaces;

package Byte_arrays is

   subtype Byte is Interfaces.Unsigned_8;

   type Byte_array is array (integer range <>) of Byte;
   pragma Pack(Byte_array);

end Byte_arrays;
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

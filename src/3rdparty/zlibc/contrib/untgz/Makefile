<<<<<<< HEAD
CC=cc
CFLAGS=-g

untgz: untgz.o  ../../libz.a
	$(CC) $(CFLAGS) -o untgz  untgz.o -L../.. -lz

untgz.o: untgz.c ../../zlib.h
	$(CC) $(CFLAGS) -c -I../.. untgz.c

../../libz.a:
	cd ../..; make

clean:
	rm -f untgz untgz.o *~
=======
CC=cc
CFLAGS=-g

untgz: untgz.o  ../../libz.a
	$(CC) $(CFLAGS) -o untgz  untgz.o -L../.. -lz

untgz.o: untgz.c ../../zlib.h
	$(CC) $(CFLAGS) -c -I../.. untgz.c

../../libz.a:
	cd ../..; make

clean:
	rm -f untgz untgz.o *~
>>>>>>> 32844d73b025baccdb340c164ba5968fb8217a49

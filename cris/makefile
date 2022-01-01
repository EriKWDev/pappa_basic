MGMONOBJ= mgmon.o compline.o expr.o
EXECS= mgm

CFLAGS = -D_CC_
#-O2 -finline-functions
LDFLAGS = -s
# CC = gcc-cris
CC = gcc

mgmon:	$(MGMONOBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o mgmon $(MGMONOBJ)

commands.h: words
	perl fixcom.pl words

MGMONOBJ= basic.o mgmon.o compline.o expr.o
EXECS= basic

CFLAGS = -D_CC_ -g
#-O2 -finline-functions
#LDFLAGS = -s
CC = gcc

mgmon:	$(MGMONOBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o mgmon $(MGMONOBJ)

commands.h: words
	perl fixcom.pl words

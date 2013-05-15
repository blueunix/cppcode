OBJ= main.o	\
		 test1.o

CC = g++

CCFLAGS += -g -c
LDFLAGS += -g
LDFLAGS +=

HEADPATH +=:.

all:target


target:$(OBJ)	
	$(CC) $(LDFLAGS) -o $@ $^

%.o:%.c
	$(CC) $(CCFLAGS) -o $@ $<

vpath %.c .


clean:
	rm -rf *.o
	rm -rf target


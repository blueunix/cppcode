
OBJ = main.o	\
			f1.o

cc := gcc
FFLAGS += -fprofile-arcs   -ftest-coverage
PG += -pg
CCFLAGS += $(FFLAGS) 
CCFLAGS += -g -c
CCFLAGS += $(PG)

LDFLAGS += $(FFLAGS)
LDFLAGS += $(PG)

all:target
	
target:$(OBJ)	 	 
	$(cc) $(LDFLAGS) -o $@ $^ 


%.o:%.c
	$(cc) $(CCFLAGS) -o $@ $<

vpath %.c ./

clean:
	rm -f target
	rm -f *.gcda
	rm -f *.gcno
	rm -f *.o
	rm -f *.gcov
	rm -f *.out

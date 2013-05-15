OBJ= grep.o	


CC = g++

HEADPATH +=:/home/todoupdate/boost/include
LIBPATH +=:/home/todoupdate/boost/lib

LIBS +=:boost_thread
LIBS +=:boost_regex
LIBS +=:boost_program_options


CCFLAGS += -g -c
CCFLAGS += $(subst :,-I,$(HEADPATH))
CCFLAGS += $(subst :,-L,$(LIBPATH))

LDFLAGS += -g
LDFLAGS += $(subst :,-l,$(LIBS))	 
LDFLAGS += $(subst :,-L,$(LIBPATH))


all:target


target:$(OBJ)	
	$(CC) $(LDFLAGS) -o $@ $^

%.o:%.cpp
	$(CC) $(CCFLAGS) -o $@ $<

vpath %.cpp .


clean:
	rm -rf *.o
	rm -rf target


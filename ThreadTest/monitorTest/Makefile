OBJ= monitor.o	


CC = g++

HEADPATH +=:/home/zhaojianxiang/boost/include
LIBPATH +=:/home/zhaojianxiang/boost/lib

LIBS +=:boost_thread


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


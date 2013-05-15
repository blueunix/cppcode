SRC = f1.c	\
			f2.c 	\
			f3.c	\
			main.c

OBJECT += f1.o \
					f2.o \
					f3.o \
					main.o

cc := gcc
#cc := clang
					
HDRPATH +=:include
HDRPATH +=:testinclude

SRCPATH +=:src
SRCPATH +=:testsrc

OBJPATH +=obj

CCFLAGS += $(subst :, -I, $(HDRPATH)) 
CCFLAGS += -g -c	
CCFLAGS += -fprofile-arcs -ftest-coverage

LDFLAGS := -fprofile-arcs -ftest-coverage
ALL = $(OBJPATH)/all

#method 1 to put target in a specific directory
all:$(addprefix $(OBJPATH)/,target) 
$(addprefix $(OBJPATH)/,target):$(addprefix $(OBJPATH)/,$(OBJECT))	
	$(cc) $(LDFLAGS) -o $@ $^ 

#method 2 to put target in a directory
#all:$(OBJPATH)/target
#$(OBJPATH)/target:$(addprefix $(OBJPATH)/,$(OBJECT))
#	$(cc) -o $@ $^


$(OBJPATH)/%.o:%.c
	$(cc)	$(CCFLAGS) -o $@ $<
	$(cc) -MM -MF $(@:.o=.d) -MT $@ -w $(CCFLAGS) $<

#$(OBJPATH)/%.d: %.c 
#  $(CC) -M $(CCFLAGS) $< > $@.$$$$;	\ 
#  sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \ 
#  rm -f $@.$$$$ 

vpath %.c  $(subst :, , $(SRCPATH))	


clean:
	rm -f $(OBJPATH)/*.o
	rm -f $(OBJPATH)/*.d
	rm -f $(OBJPATH)/target
	rm -f $(OBJPATH)/*.gcno
	rm -f $(OBJPATH)/*.gcov
	rm -f $(OBJPATH)/*.gcda

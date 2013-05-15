# Generated automatically from Makefile.in by configure.
# ======================================================================
# Makefile for htmlpty (prettyprint World-Wide Web HTML files)
#
# Current target list:
#	all			(default) make htmlpty and test
#	check			test htmlpty
#	clean			clean up trash and object files
#	clean-tables		clean tables in Entities/*, Missing/*,
#				and Tokens/*
#	clobber			clean up everything for a rebuild
#	dist			make distribution files
#	distclean		same as clobber
#	doc			make documentation files
#	dw			do doubled-word check on documentation
#	entities.xrf		cross-reference of HTML entities to
#				defining grammar files
#	htmlpty			flex-based version of htmlpty
#	htmlpty.html		HTML form of UNIX manual pages
#	htmlpty.o		object code from htmlpty.c
#	htmlpty.pdf		PDF version of manual pages
#	htmlpty.ps		PostScript version of manual pages
#	htmlpty.shar		make shar bundle for e-mailing
#	htmlpty.tar		make tar archive for public distribution
#	htmlpty.txt		ASCII version of manual pages
#	htmlpty.zip		make zip archive for public distribution
#	htmlpty.zoo		make zoo archive for public distribution
#	install			install htmlpty in system directories
#	install-ftp		install htmlpty in FTP directory
#	lint			run lint on C source code
#	maintainer-clean	remove absolutely everything that make
#				can rebuild, including bootstrapping C
#				source code created by lex or flex
#	mostlyclean		clean up trash and object files
#	spell			generate spelling exceptions for documentation
#	test-version		test extraction of version number
#	uninstall		remove htmlpty from system directories
#
#	All-Tables		multicolumn tables for all available HTML
#				grammars (created in subdirectory files
#				Entities/*.tab, Missing/*.tab, Tokens/*.tab)
#	Entities/htmlpty.ent	list of HTML-GRAMMAR-defined SGML entities
#	Entities/htmlpty.tab	multicolumn form of Entities/htmlpty.ent
#	Missing/htmlpty.mis	list of HTML-GRAMMAR-defined SGML entities
#				that are not explicitly recognized by
#				html-pretty's lexical analyzer
#	Missing/htmlpty.tab	multicolumn form of Missing/htmlpty.mis
#	Tokens/htmlpty.tab	multicolumn form of Tokens/htmlpty.tag
#	Tokens/htmlpty.tag	one-column table of HTML tags recognized by
#				html-pretty
#
# Current convenience target list:
#	cdc-mips-epix-cc
#	cray-el94-unicos-c89
#	dec-alpha-osf1-c++
#	dec-alpha-osf1-cc
#	dec-alpha-osf1-g++
#	dec-alpha-osf1-gcc
#	dec-mips-ultrix-cc
#	dec-mips-ultrix-g++
#	dec-mips-ultrix-gcc
#	dec-mips-ultrix-lcc
#	hp-370-bsd43-c++
#	hp-370-bsd43-cc
#	hp-9000-hpux-c++
#	hp-9000-hpux-cc
#	hp-9000-hpux-gcc
#	hp-9000-hpux-g++
#	ibm-370-aix-c++
#	ibm-370-aix-cc
#	ibm-ps2-aix-c++
#	ibm-ps2-aix-cc
#	ibm-rs6000-aix-cc
#	ibm-rs6000-aix-c++
#	ibm-rs6000-aix-g++
#	ibm-rs6000-aix-gcc
#	mips-mips-riscos-cc
#	next-motorola-mach-cc
#	next-motorola-mach-g++
#	next-motorola-mach-gcc
#	next-motorola-mach-lcc
#	sgi-mips-irix-c++
#	sgi-mips-irix-cc
#	sgi-mips-irix-g++
#	sgi-mips-irix-gcc
#	sgi-mips-irix-lcc
#	sgi-mips-irix6-c++
#	sgi-mips-irix6-cc
#	stardent-mips-os2-cc
#	sun-sparc-solaris2-apcc
#	sun-sparc-sunos5-apcc
#	sun-sparc-solaris2-g++
#	sun-sparc-sunos5-g++
#	sun-sparc-solaris2-gcc
#	sun-sparc-sunos5-gcc
#	sun-sparc-solaris2-c++
#	sun-sparc-sunos5-c++
#	sun-sparc-solaris2-cc
#	sun-sparc-sunos5-cc
#	sun-sparc-solaris2-lcc
#	sun-sparc-sunos5-lcc
#	sun-sparc-solaris1-acc
#	sun-sparc-sunos4-acc
#	sun-sparc-solaris1-c++
#	sun-sparc-sunos4-c++
#	sun-sparc-solaris1-gcc
#	sun-sparc-sunos4-gcc
#	sun-sparc-solaris1-g++
#	sun-sparc-sunos4-g++
#
# [28-Nov-1997]
# ======================================================================

#### Start of system configuration section. ####

prefix          = /usr/local
exec_prefix     = $(prefix)

bindir          = $(exec_prefix)/bin
datadir         = $(prefix)/lib
infodir         = $(prefix)/info
libdir          = $(prefix)/share/lib
srcdir          = .

# NB: the default catalog search algorithm in htmlpty is based on mapping
# /the/path/to/bin/htmlpty to /the/path/to/share/lib/htmlpty, so the
# values of BINDIR and LIBDIR are NOT independent.
BINDIR          = $(bindir)
LIBDIR		= $(libdir)
MANDIR          = $(prefix)/man
MANEXT		= 1

CC              = c89
CXX             = c++
CFLAGS          =  $(INCLUDES) $(OPT) $(XCFLAGS)
CXXFLAGS	= -g -O2 $(OPT)

# Although we do not change any of the internal defaults in this
# Makefile, here are the ones that an installation might wish to change
# by -Dvar=value assignments in the DEFS variable:
#
#	----------------	----------------------------------------
#	Variable		Default value
#	----------------	----------------------------------------
#	CATALOG_FILE		"catalog"
#	CATALOG_PATH		"share/lib"
#	DEFAULT_DOCTYPE		"\"-//IETF//DTD HTML//EN\""
#	ENTITY_QUOTE		"\"&quot;\""
#	FILENAME_MAX		system-dependent, but at least MAXBUF
#	INDENT			4
#	MAXBUF			system-dependent, but at least 2048
#	MAXLISTNEST		25
#	MAXTOKENLENGTH		1024
#	MAXWIDTH		72
#	STYLECHUNK		200
#	----------------	----------------------------------------
#
# If you change DEFAULT_DOCTYPE, then ENTITY_QUOTE MUST be set
# correctly, to "\"&quot;\"" or to "\"&34;\"", since the former is not
# defined in some HTML grammars, sigh...
#
# While you can set numeric values corresponding to object sizes, the
# source code may override your settings in order to enforce minimum
# limits to guarantee conformance to the documentation, and SGML grammar
# limits.
#
# These variables are defined below and used in the compilation of
# htmlpty.c:
#
#	----------------	----------------------------------------
#	Variable		Default value
#	----------------	----------------------------------------
#	HOSTNAME		site-dependent
#	USER			site-dependent
#	----------------	----------------------------------------

DEFS            = -DHAVE_CONFIG_H

INSTALL         = /usr/local/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA    = ${INSTALL} -m 644

LDFLAGS         = $(OPT)
LIBS            = 


# ======================================================================
# The remainder of this Makefile should not need changes.

# This can be either nawk or GNU gawk, or on IBM RS/6000 AIX 3.2, awk.
AWK		= gawk

CAT		= cat

CFLOW		= cflow

CFLOWFLAGS	= $(INCLUDES)

CFLOW-FILTER	= $(SED) -e 's/	/  /g'

CFLOW-SRC-FILES	= $(SRC-FILES:.l=.c)

# This variable lists the basenames of the test files.  Those with
# extension .in are input files for the prettyprinter, and those named
# okay/*.out and okay/*.err contain correct output on stdout and stderr
# from the prettyprinter for comparison with the .out and .err files
# created by "make check".  Files with extension .opt contain
# command-line options to be supplied to ../htmlpty.  Files with
# extension .st? contain (nested) style file tests.
CHECKFILES	= check001 check002 check003 check004 check005 check006 \
		  check007 check008 check009 check010 check011 check012 \
		  check013 check014 check015 check016 check017 check018 \
		  check019 check020

# This program is freely available at
# ftp://ftp.math.utah.edu/pub/misc/checksum-x-y.*
# If you don't have, cat will be used instead, and the output
# html file will have an invalid file header checksum.
CHECKSUM	= ( checksum || $(CAT))

CHMOD           = chmod

COL		= col -x -b

COMPRESS-SPACE	= $(SED) -e 's/  */ /g'

CP              = rcp -p

# This filter deletes these output lines in the "make check" test:
# <!-- Prettyprinted by html-pretty.awk version 0.02 [09-Apr-1995] -->
# <!-- on Sun Apr 9 11:19:36 MDT 1995 -->
# <!-- for Nelson H. F. Beebe (beebe@sunrise) -->
# plus this line
# <LINK REV="made" HREF="mailto:beebe@plot79.math.utah.edu">

DELETETIMESTAMP = $(SED) -e '2,4d' -e '/<LINK REV="made" HREF="mailto:/d'

DEROFF		= deroff

DIFF            = diff

DIST-FILES      = AUTHORS ChangeLog COPYING INSTALL Makefile.in NEWS README \
		  README.AWK THANKS acconfig.h builtin.h cittable.awk \
		  common.h config.hin confix.h configure configure.in \
		  configure.sed cpchar.c default.h enttable.awk entxref.awk \
		  fileutil.c fileutil.h htmlpty.c htmlpty.dvi htmlpty.html \
		  htmlpty-??.html htmlpty.l htmlpty.man htmlpty.pdf \
		  htmlpty.ps htmlpty.sok htmlpty.txt install-sh man2ps \
		  mkinstalldirs mrgtable.awk stdc.h sysutil.c sysutil.h \
		  table.c Backup/Makefile Backup/config.h Backup/configure \
		  Entities/* Flow/*.flo HTML40/* HTML40/*/* Missing/* \
		  Styles/catalog Styles/*.sty Test/check[0-9][0-9][0-9].* \
		  Test/okay/check[0-9][0-9][0-9].* Tokens/*

DISTILL		= distill

# You can find the doubled word utility, dw, on
# ftp.math.utah.edu:/pub/misc/dw.shar
DW		= dw

# SGI IRIX 4.x and 5.x lack expand, so use cat instead
EXPAND		= expand

FIND		= find

FTPDIR		= /u/ftp/pub/misc

# For gcc 2.0 or earlier, -Wredundant-decls incorrectly produces
# warnings when a declaration and definition occur in the same file;
# maybe someday gcc will do it correctly, and it will be useful to
# add.  With gcc 2.6.2, it works fine, but produces many warnings
# about things in system header files, and none for htmlpty.c, so I
# normally don't use it.

GCCFLAGS        = -Wall -Wshadow -Wcast-qual -Wpointer-arith -Wwrite-strings \
		  -Wnested-externs -Wcast-align

# Options for g++ 2.0
G++FLAGS        = -Wall -Wshadow -Wcast-qual -Wpointer-arith -Wwrite-strings \
		  -Wid-clash-6 -Wpointer-arith -Wcast-qual -Wconversion \
		  -Waggregate-return -Wstrict-prototypes -Wmissing-prototypes \
		  -Wno-parentheses

GREP		= grep

GROFF		= groff

GZIP		= gzip

HEADER-FILES    = config.h confix.h common.h fileutil.h stdc.h

# Use one of these to get the UNIX hostname.
HOST		= -DHOSTNAME=\"`uname -n`\"
HOST		= -DHOSTNAME=\"`hostname`\"

# This one is definitely system-dependent, but usually needed only at
# the developer's site:
HTML-DIR	= /usr/local/lib/html-check/lib

# Current grammar version accepted by W3C:
HTML-GRAMMAR	= $(HTML-DIR)/HTML32.dtd

# Current, old and future grammars:
HTML-GRAMMARS   = $(HTML-DIR)/Cougar.dtd \
		  $(HTML-DIR)/HTML32.dtd \
		  $(HTML-DIR)/HTML4-frameset.dtd \
		  $(HTML-DIR)/HTML4-loose.dtd \
		  $(HTML-DIR)/HTML4-strict.dtd \
		  $(HTML-DIR)/html-0.dtd \
		  $(HTML-DIR)/html-0s.dtd \
		  $(HTML-DIR)/html-1.dtd \
		  $(HTML-DIR)/html-1s.dtd \
		  $(HTML-DIR)/html-3.dtd \
		  $(HTML-DIR)/html-mcom.dtd \
		  $(HTML-DIR)/html-s.dtd \
		  $(HTML-DIR)/html.dtd

# Grammars that are used to create the "HTML CONSTRAINTS" section of
# htmlpty.man:
HTML-GRAMMARS-MAN = Entities/Cougar.dtd Entities/HTML32.dtd \
		  Entities/HTML4-loose.dtd Entities/html-3.dtd \
		  Entities/html-mcom.dtd Entities/html.dtd

HTML-TABLES-MAN	= $(HTML-GRAMMARS-MAN:.dtd=.tab)

HTML-XREF-MAN	= $(HTML-GRAMMARS-MAN:.dtd=.cit)

# This program is freely available at
# ftp://ftp.math.utah.edu/pub/sgml/sp-*
# If you don't have it, then the HTML validation test will be silently
# suppressed.
HTMLCHECK	= html-ncheck

# This program is freely available at
# ftp://ftp.math.utah.edu/pub/sgml/htmlpty-x.y.*
HTMLPRETTY	= ./htmlpty

HTMLPTY		= ../htmlpty

# These options are always in effect for the check target, in case the
# internal defaults are changed at installation time.
HTMLPTY-TEST-OPTIONS = -indent 4 -width 72

# Directories to be searched for config.h; changing this allows builds
# to be done elsewhere, with source code on a read-only file system.
INCLUDES	= -I.

ISPELL		= ispell

LDFLAGS         = -ll

LINT		= lint

# Portable LINTFLAGS settings:
LINTFLAGS	= -bchx $(INCLUDES)

# These LINTFLAGS options work for Sun Solaris 2.5 lint:
LINTFLAGS	= -a -b -c -fd -Ncheck=%all -Nlevel=4 -p -x -Xtransition=yes $(INCLUDES)

LN		= ln

# Choose either UNIX lex or GNU flex (fast lex), available from
# prep.ai.mit.edu:/pub/gnu.  flex is much faster (13x) at processing
# htmlpty.l, and also handles characters in 128..255 correctly.
#
# Some lex implementations are not 8-bit clean.  For HTML, this is
# significant, because accented characters from the range 128..255 are
# defined by the grammar, and sometimes used in HTML files.  In
# particular, on Sun Solaris 2.3 and 2.4, char is signed, and the lex
# code from /usr/ccs/bin/ncform uses characters returned by yyinput() as
# array indexes.  For characters in 128..255, these appear as negative
# integers, with the result that out-of-bounds array accesses are made
# with unpredictable results.  On a simple test file containing a
# character in 128..255, the character was completely lost if it was
# preceded by whitespace, but not if it was preceded by something else.
# The test file check005.in contains 3 examples near line 744 where the
# erroneous behavior of lex will be detected.  Curiously, the test file
# check008.in, which contains one instance of each character in 1..255,
# is handled correctly, showing the unpredictabily of the lex bug, and
# the difficulty of exposing it with test files.  Because the error
# happens deep inside the lex-generated code, there is nothing that can
# be done in htmlpty.l to work around the problem.
#
# The flex code uses unsigned char and suitable typecasts to get the
# right answer.

LEX		= flex

LS		= ls

# man2html is available at ftp://ftp.math.utah.edu/pub/sgml/man2html-x.yy.*
MAN2HTML	= man2html

MAN2PS		= ./man2ps

MKDIR		= mkdir -p

MPACK		= mpack

MV		= mv

NROFF		= groff -Tascii

OPT		= -g

PR		= pr

PRFLAGS		= -t'' -l60 -c6 -w79

PROGRAM		= html-pretty

RM              = /bin/rm -f

SED		= sed

SHAR            = shar

SHAR-FILES      = $(DIST-FILES) PC/*.bat PC/htmlpty.mim PC/htmlpty.uue

SHELL		= /bin/sh

SORT		= sort

SPELL		= spell

SPELL-PREFILTER	= $(SED) -e 's/[0-9,.:;?&]/ /g'

SRC-FILES	= htmlpty.l fileutil.c sysutil.c table.c

TAR		= gnutar

TAR-FILES       = $(DIST-FILES) PC/*.bat PC/*.exe

TEE		= tee

TMPTESTDIR	= /tmp/htmlpty-test

TOUCH		= touch

TR		= tr

TRUE		= true

UNZIP		= unzip

USER		= -DUSER=\"$(LOGNAME)\"

# uue is an improved version of uuencode, which avoids using blanks in the
# encoding, and includes a translation table, but uuencode will work too
UUENCODE	= uue

VERSION		= `$(AWK) '/^[ \t]*version *= *"[0-9.]+", *$$/ \
		{ gsub(/[^0-9.]/,"",$$3); print $$3 }' htmlpty.l`
VERSION		= 1.00

ZIP		= zip

ZOO		= zoo

# ======================================================================

.SUFFIXES:	.i .c .cit .tab .dtd

# For debugging purposes, remove line directives, because they are
# incorrectly synchronized with the .l file.  Also, remove write
# access from the file to prevent accidental editing.
# 
# Some lex versions, e.g. Sun Solaris 2.x and SGI IRIX 5.x and 6.x,
# predefine YYLMAX to be BUFSIZ, without giving the lex program a
# change to redefine it.  We need to guarantee at least 8K bytes, so
# we include a filter step to set YYLMAX on such systems.
#
# There is an off-by-two error in some lex versions, e.g. Sun Solaris
# 2.x and SGI IRIX 5.x and 6.x, which can result in one character
# beyond yytext[] being overwritten, and insufficient space left for
# the trailing NUL.  We fix that too, sigh...
#
# On NeXT Mach 3.x, yytext is initially declared as "extern char yytext[]",
# and then later, after the user code, as "char yytext[YYLMAX];", making
# it impossible to use sizeof(yytext).  We patch this brain damage too!
.l.c:
	-$(CHMOD) a+w $@ 2>/dev/null
	$(RM) $@
	$(LEX) $(LFLAGS) -t $< | \
		$(SED)  -e '/^# *line/d' \
			-e 's/#[ 	]*define[ 	][ 	]*YYLMAX[ 	][ 	]*[0-9][0-9]*/#define YYLMAX 8192/g' \
			-e 's/#[ 	]*define[ 	][ 	]*YYLMAX[ 	][ 	]*BUFSIZ/#define YYLMAX 8192/g' \
			-e 's/if[(]yylastch > &yytext\[YYLMAX\][)]/if(yylastch > \&yytext[YYLMAX-2])/' \
			-e 's/extern char yytext\[[ 	]*\];/extern char  yytext[YYLMAX];/' \
			> $@
	-$(CHMOD) a-w $@ 2>/dev/null

.c.i:
	$(CC) $(CFLAGS) -E $< >$@

# NB: This rule may be run here, or in a subdirectory one level below:
.dtd.tab:
	if test -f ./enttable.awk ; \
	then \
		$(TR) '\n' ' ' <$< | $(AWK) -f ./enttable.awk >$@ ; \
	else \
		$(TR) '\n' ' ' <$< | $(AWK) -f ../enttable.awk >$@ ; \
	fi

# NB: This rule may be run here, or in a subdirectory one level below:
.tab.cit:
	if test -f ./cittable.awk ; \
	then  \
		$(AWK) -f ./cittable.awk $< >$@ ; \
	else  \
		$(AWK) -f ../cittable.awk $< >$@ ; \
	fi

# ======================================================================

all:	htmlpty
#all:	htmlpty check dw spell doc

check:	htmlpty
	@echo "The following checks should output only the test names:"
	@cd Test ; \
	if test -d $(TMPTESTDIR) ; then $(RM) -r $(TMPTESTDIR) ; fi ; \
	$(MKDIR) $(TMPTESTDIR) $(TMPTESTDIR)/okay ;\
	for f in $(CHECKFILES) ; \
	do \
		echo $$f ; \
		OPTIONS="`cat $$f.opt 2>/dev/null || $(TRUE)`" ; \
		$(HTMLPTY) $(HTMLPTY-TEST-OPTIONS) $$OPTIONS -n <$$f.in >$$f.out 2>$$f.err ; \
		if cmp okay/$$f.err $$f.err ; \
		then $(RM) $$f.err ; \
		else \
			echo Failure on $$f.err ... ; \
			$(DIFF) okay/$$f.err $$f.err ; \
		fi ; \
		$(RM) $(TMPTESTDIR)/okay/$$f.err.$$$$ $(TMPTESTDIR)/$$f.err.$$$$ ; \
		$(DELETETIMESTAMP) okay/$$f.out >$(TMPTESTDIR)/okay/$$f.out.$$$$ ; \
		$(DELETETIMESTAMP) $$f.out >$(TMPTESTDIR)/$$f.out.$$$$ ; \
		if cmp $(TMPTESTDIR)/okay/$$f.out.$$$$ $(TMPTESTDIR)/$$f.out.$$$$ ; \
		then $(RM) $$f.out ; \
		else \
			echo Failure on $$f.out ... ; \
			$(DIFF) $(TMPTESTDIR)/okay/$$f.out.$$$$ $(TMPTESTDIR)/$$f.out.$$$$ ; \
		fi ; \
		$(RM) $(TMPTESTDIR)/okay/$$f.out.$$$$ $(TMPTESTDIR)/$$f.out.$$$$ ; \
	done

clean:
	-$(RM) *.i
	-$(RM) *.ln
	-$(RM) *.o
	-$(RM) *~
	-$(RM) TAGS
	-$(RM) \#*
	-$(RM) core
	-$(RM) cpchar
	-$(RM) gmon.out
	-$(RM) htmlpty.ser
	-$(RM) mon.out
	-$(RM) -r $(TMPTESTDIR)

clean-flo:
	-$(RM) Flow/*.flo

clean-tables:
	-$(RM) entities.xrf
	-$(RM) Entities/*.ent
	-$(RM) Entities/*.tab
	-$(RM) Missing/*.mis
	-$(RM) Missing/*.tab
	-$(RM) Tokens/*.tag
	-$(RM) Tokens/*.tab

clobber:	distclean

cpchar:	cpchar.o
	$(CC) $(CFLAGS) -o cpchar cpchar.o

distclean:	clean
	-$(RM) config.h config.cache config.log config.status
	-$(RM) cpchar
	-$(RM) cscope.out
	-$(RM) -r .sb
	-$(RM) -r cxx_repository
	-$(RM) htmlpty
	-$(RM) htmlpty-?.??.tar
	-$(RM) htmlpty-?.??.zip
	-$(RM) htmlpty-?.??.zoo
	-$(RM) htmlpty-?.??.tar-lst
	-$(RM) htmlpty-?.??.zip-lst
	-$(RM) htmlpty-?.??.zoo-lst
	-$(RM) htmlpty.Addrs
	-$(RM) htmlpty.Counts
	-$(RM) htmlpty.pixie
	-$(RM) htmlpty.shar
	-$(RM) htmlpty.tar
	-$(RM) htmlpty.zip
	-$(RM) htmlpty.zoo
	-$(RM) PC/htmlpty.mim
	-$(RM) PC/htmlpty.uue
	-$(RM) Makefile

dist:	htmlpty.tar htmlpty.zip htmlpty.zoo

doc:	htmlpty.dvi htmlpty.html htmlpty.ps htmlpty.txt

dw:
	@echo "Doubled word check in htmlpty.man..."
	@-$(DEROFF) htmlpty.man | $(DW)
	@echo "Doubled word check in ChangeLog..."
	$(DW) <ChangeLog
	@echo "Doubled word check in README..."
	$(DW) <README

entities.xrf:	entxref.awk # All-Tables
	$(AWK) -f entxref.awk Entities/*.ent >$@

fileutil.o:	fileutil.c $(HEADER-FILES)

htmlpty:	htmlpty.o fileutil.o sysutil.o table.o
	$(CC) $(CFLAGS) -o htmlpty htmlpty.o fileutil.o sysutil.o table.o $(LDFLAGS) $(LIBS)

htmlpty.dvi:	htmlpty.man
	$(GROFF) -man -Tdvi $< >$@
	$(CHMOD) a-w $@

# NB: We want level 3.2 or later HTML in order to take advantage of
# the <SMALL>...</SMALL> environment that is heavily used in the "HTML
# GRAMMAR CONSTRAINTS" section.
htmlpty.html:	htmlpty.man $(HTMLPRETTY)
	-$(CHMOD) a+w $@ 2>/dev/null
	$(MAN2HTML) -grammar-level 3.2 -split 1 $$PWD/$<
	$(MV) htmlpty.html htmlpty.tmp
	$(HTMLPRETTY) -f $$PWD/$@ -logfile /dev/null <htmlpty.tmp | $(CHECKSUM) >$@
	-$(RM) htmlpty.tmp
	-$(CHMOD) a-w $@
	$(HTMLCHECK) $@ || $(TRUE)

htmlpty.i:	htmlpty.c $(HEADER-FILES)
	$(CC) $(CFLAGS) $(USER) $(HOST) -E $< >$@

htmlpty.o:	htmlpty.c $(HEADER-FILES)
	$(CC) $(CFLAGS) $(USER) $(HOST) -c $<

htmlpty.pdf:	htmlpty.ps
	$(DISTILL) $<

htmlpty.ps:	htmlpty.man
	-$(CHMOD) a+w $@ 2>/dev/null
	-$(MAN2PS) <$< >$@
	-$(CHMOD) a-w $@

htmlpty.shar:	$(SHAR-FILES)
	$(SHAR) $(SHAR-FILES) >htmlpty.shar

htmlpty.tar:	$(TAR-FILES)
	-$(RM) htmlpty.tar
	-$(RM) htmlpty-$(VERSION).tar htmlpty-$(VERSION).tar-lst
	-$(RM) -r htmlpty-$(VERSION)
	-$(MKDIR) htmlpty-$(VERSION)
	$(TAR) chf - $(TAR-FILES) | (cd htmlpty-$(VERSION); tar xf -)
	$(TAR) cf htmlpty-$(VERSION).tar htmlpty-$(VERSION)
	$(LN) htmlpty-$(VERSION).tar htmlpty.tar
	-$(RM) -r htmlpty-$(VERSION)
	$(TAR) tvf htmlpty-$(VERSION).tar >htmlpty-$(VERSION).tar-lst

htmlpty.txt:	htmlpty.man
	-$(CHMOD) a+w $@ 2>/dev/null
	$(NROFF) -man htmlpty.man | col -b | $(EXPAND) >$@
	-$(CHMOD) a-w $@

htmlpty.zip:	htmlpty.tar
	-$(RM) htmlpty*.zip htmlpty*.zip-lst
	-$(RM) -r htmlpty-$(VERSION)
	$(TAR) xf htmlpty.tar
	$(ZIP) -r htmlpty-$(VERSION).zip htmlpty-$(VERSION)
	-$(RM) -r htmlpty-$(VERSION)
	$(UNZIP) -v htmlpty-$(VERSION).zip >htmlpty-$(VERSION).zip-lst
	$(LN) htmlpty-$(VERSION).zip htmlpty.zip

htmlpty.zoo:	htmlpty.tar
	-$(RM) htmlpty*.zoo htmlpty*.zoo-lst
	-$(RM) -r htmlpty-$(VERSION)
	$(TAR) xf htmlpty.tar
	$(FIND) htmlpty-$(VERSION) -type f -print | $(SORT) | $(ZOO) aI htmlpty-$(VERSION).zoo
	-$(RM) -r htmlpty-$(VERSION)
	$(ZOO) v htmlpty-$(VERSION).zoo >htmlpty-$(VERSION).zoo-lst
	$(LN) htmlpty-$(VERSION).zoo htmlpty.zoo

install:	htmlpty install-exe install-lib install-man

install-exe:
	$(CP) htmlpty $(BINDIR)/$(PROGRAM)
	-$(CHMOD) 775 $(BINDIR)/$(PROGRAM)

install-man:
	-$(RM) $(MANDIR)/cat$(MANEXT/$(PROGRAM).$(MANEXT)
	$(CP) htmlpty.man $(MANDIR)/man$(MANEXT/$(PROGRAM).$(MANEXT)
	-$(CHMOD) 664 $(MANDIR)/man$(MANEXT/$(PROGRAM).$(MANEXT)

install-lib:
	-$(MKDIR) $(LIBDIR)/$(PROGRAM)
	$(CP) Styles/* $(LIBDIR)/$(PROGRAM)/
	$(CHMOD) 664 $(LIBDIR)/$(PROGRAM)/*

install-ftp:	htmlpty.tar htmlpty.zip htmlpty.zoo
	$(TAR) tvf htmlpty-$(VERSION).tar >$(FTPDIR)/htmlpty-$(VERSION).tar-lst
	$(GZIP) <htmlpty-$(VERSION).tar >$(FTPDIR)/htmlpty-$(VERSION).tar.gz
	-$(CHMOD) 664 $(FTPDIR)/htmlpty-$(VERSION).tar.gz
	$(CP) htmlpty-$(VERSION).zip $(FTPDIR)
	-$(CHMOD) 664 $(FTPDIR)/htmlpty-$(VERSION).zip
	$(CP) htmlpty-$(VERSION).zip-lst $(FTPDIR)
	-$(CHMOD) 664 $(FTPDIR)/htmlpty-$(VERSION).zip-lst
	$(CP) htmlpty-$(VERSION).zoo $(FTPDIR)
	-$(CHMOD) 664 $(FTPDIR)/htmlpty-$(VERSION).zoo
	$(CP) htmlpty-$(VERSION).zoo-lst $(FTPDIR)
	-$(CHMOD) 664 $(FTPDIR)/htmlpty-$(VERSION).zoo-lst
	$(LS) -l $(FTPDIR)/htmlpty*

lint:	htmlpty.c
	$(LINT) $(LINTFLAGS) *.c

maintainer-clean:	distclean
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."
	-$(RM) config.hin
	-$(MAKE) -f Backup/Makefile clean-flo clean-tables
	-$(CHMOD) a+w htmlpty.c
	-$(RM) htmlpty.c
	-$(CHMOD) a+w htmlpty.dvi
	-$(RM) htmlpty.dvi
	-$(CHMOD) a+w htmlpty.html
	-$(RM) htmlpty.html
	-$(CHMOD) a+w htmlpty.pdf
	-$(RM) htmlpty.pdf
	-$(CHMOD) a+w htmlpty.ps
	-$(RM) htmlpty.ps
	-$(CHMOD) a+w htmlpty.txt
	-$(RM) htmlpty.txt

mostlyclean:	clean

spell htmlpty.ser:	htmlpty.man ChangeLog README
	@echo "Spelling exceptions (logged in htmlpty.ser)..."
	-@for f in 1 ; \
	do \
		$(DEROFF) htmlpty.man | $(SPELL-PREFILTER) | $(SPELL) +htmlpty.sok ; \
		$(DEROFF) htmlpty.man | $(SPELL-PREFILTER) | $(ISPELL) -l -p htmlpty.sok ; \
		$(CAT) ChangeLog README | $(SPELL-PREFILTER) | $(SPELL) +htmlpty.sok ; \
		$(CAT) ChangeLog README | $(SPELL-PREFILTER) | $(ISPELL) -l -p htmlpty.sok ; \
	done | $(TEE) htmlpty.ser | $(SORT) -u

sysutil.o:	sysutil.c $(HEADER-FILES)

table.o:	table.c builtin.h default.h $(HEADER-FILES)

test-version:
	@echo "Version number is ""'"$(VERSION)"'"

uninstall:	uninstall-exe uninstall-lib uninstall-man

uninstall-exe:
	-$(RM) $(BINDIR)/$(PROGRAM)

uninstall-lib:
	-$(RM) -r $(LIBDIR)/$(PROGRAM)

uninstall-man:
	-$(RM) $(MANDIR)/cat$(MANEXT/$(PROGRAM).$(MANEXT)
	-$(RM) $(MANDIR)/man$(MANEXT/$(PROGRAM).$(MANEXT)

#=======================================================================
# Subdirectory files:

# Multicolumn tables for all available HTML grammars
All-Tables:       Entities-tables Entities-contained-in-tables \
		  Entities-merged-table Xref-tables

Entities-contained-in-tables:
	# $(MAKE) Entities-tables
	-mkdir Entities 2>/dev/null
	$(MAKE) $(HTML-XREF-MAN)

Entities-merged-table:	Entities/merged-table.tab

Entities/merged-table.tab:	
	$(MAKE) Entities-tables
	cd Entities ; \
	$(AWK) -f ../mrgtable.awk `echo $(HTML-TABLES-MAN) | \
		$(SED) -e 's@Entities/@./@g'` >merged-table.tab

# NB: This target is made when the tables are out-of-date with respect
# to either the grammar files, or the awk programs.  Thus, in the
# loop, we must copy and touch the grammar files to force the inner
# make to actually remake the target.
Entities-tables:	$(HTML-TABLES-MAN)
	-mkdir Entities 2>/dev/null
	cd Entities; \
	for f in $(HTML-GRAMMARS-MAN) ; \
	do \
		g=`basename $$f .dtd` ; \
		$(RM) $$g.dtd 2>/dev/null || $(TRUE); \
		$(CP) $(HTML-DIR)/$$g.dtd . || $(TRUE); \
		$(TOUCH) $$g.dtd ; \
		$(MAKE) -f ../Makefile $$g.tab ; \
		$(RM) $$g.dtd 2>/dev/null ; \
	done

$(HTML-TABLES-MAN):	enttable.awk mrgtable.awk

Xref-tables:
	for f in $(HTML-GRAMMARS) ; \
	do \
		g=`basename $$f .dtd` ; \
		if test -f $$f ; \
		then \
			echo "" ; \
			echo ========== Making tables from $$f ; \
			$(MAKE) HTML-GRAMMAR=$$f Entities/htmlpty.tab Missing/htmlpty.tab ; \
			$(MV) Entities/htmlpty.ent Entities/$$g.ent ; \
			$(MV) Entities/htmlpty.tab Entities/$$g.tab ; \
			$(MV) Missing/htmlpty.mis Missing/$$g.mis ; \
			$(MV) Missing/htmlpty.tab Missing/$$g.tab ; \
			$(LS) -l Entities/$$g.* Missing/$$g.* ;\
		fi ; \
	done
	$(MAKE) Tokens/htmlpty.tag Tokens/htmlpty.tab

# Make a list of HTML entities mentioned in the grammar file
Entities/htmlpty.ent:	$(HTML-GRAMMAR) Makefile
	if test -d Entities ; then $(TRUE) ; else $(MKDIR) Entities ; fi
	echo "# HTML entities in HTML grammar DTD, computed on `date` from" >$@
	echo "# `ls -lo $(HTML-GRAMMAR) Makefile`" | $(COMPRESS-SPACE) >>$@
	echo "#" >>$@
	$(SED) -e 's/"/@/g' $(HTML-GRAMMAR) | \
		$(TR) '\n' ' ' | \
		$(AWK) '{gsub("<!ENTITY","\n<!ENTITY"); print}' | \
		$(AWK) 'BEGIN {FS="@"} /^<!ENTITY/ {print $$2}' >/tmp/entities.tmp
	$(SED) -e 's/"/@/g' $(HTML-GRAMMAR) | \
		$(TR) '\n' ' ' | \
		$(AWK) '{gsub("<!ELEMENT","\n<!ELEMENT"); print}' | \
		$(AWK) '/^<!ELEMENT/ {print $$2}' >>/tmp/entities.tmp
	$(TR) -c %A-Za-z0-9 '\n' </tmp/entities.tmp | \
		$(GREP) -v '^%' | \
		$(GREP) -v '[^A-Z0-9]' | \
		$(SORT) -u -f >>$@
	-$(RM) /tmp/entities.tmp

Entities/htmlpty.tab:	Entities/htmlpty.ent
	$(GREP) '^#' <$< >$@
	$(GREP) -v '^#' <$< | \
		$(PR) $(PRFLAGS) >>$@

# Function- and Function+Variable-Calls and Called-By cross-reference tables
# created by the Sun Solaris 2.x cflow utility:
flow:	Flow/fcalls.flo Flow/fvcalls.flo Flow/fcalled.flo Flow/fvcalled.flo

Flow:
	if test -d Flow ; then $(TRUE) ; else $(MKDIR) Flow ; fi

Flow/fcalls.flo:	Flow $(CFLOW-SRC-FILES)
	@echo Functions calls table: $@ created on `date` >$@
	@$(LS) -l $(CFLOW-SRC-FILES) >>$@
	$(CFLOW) $(CFLOWFLAGS) $(CFLOW-SRC-FILES) | $(CFLOW-FILTER) >>$@

Flow/fvcalls.flo:	Flow $(CFLOW-SRC-FILES)
	@echo Functions+Variable calls table:  $@ created on `date` >$@
	@$(LS) -l $(CFLOW-SRC-FILES) >>$@
	$(CFLOW) $(CFLOWFLAGS) -ix $(CFLOW-SRC-FILES) | $(CFLOW-FILTER) >>$@

Flow/fcalled.flo:	Flow $(CFLOW-SRC-FILES)
	@echo Function called-by table: $@ created on `date` >$@
	@$(LS) -l $(CFLOW-SRC-FILES) >>$@
	$(CFLOW) $(CFLOWFLAGS) -r $(CFLOW-SRC-FILES) | $(CFLOW-FILTER) >>$@

Flow/fvcalled.flo:	Flow $(CFLOW-SRC-FILES)
	@echo Function+Variable called-by table: $@ created on `date` >$@
	@$(LS) -l $(CFLOW-SRC-FILES) >>$@
	$(CFLOW) $(CFLOWFLAGS) -r -ix $(CFLOW-SRC-FILES) | $(CFLOW-FILTER) >>$@

# Make a list of HTML entities mentioned in the grammar file, but
# absent from html-pretty's lexical analyzer rules.
Missing/htmlpty.mis:	Entities/htmlpty.ent Tokens/htmlpty.tag Makefile
	if test -d Missing ; then $(TRUE) ; else $(MKDIR) Missing ; fi
	echo "# HTML entities missing from htmlpty, computed on `date` from" >$@
	echo "# `ls -lo $(HTML-GRAMMAR) htmlpty.l Makefile`" | \
		$(COMPRESS-SPACE) >>$@
	echo "#" >>$@
	$(GREP) -v '^#' Entities/htmlpty.ent | \
		$(DIFF) - Tokens/htmlpty.tag | \
		$(AWK) '/</ {if (NF > 1) print $$NF}' >>$@

Missing/htmlpty.tab:	Missing/htmlpty.mis
	$(GREP) '^#' <$< >$@
	$(GREP) -v '^#' <$< | \
		$(PR) $(PRFLAGS) >>$@

PC/htmlpty.mim:	PC/htmlpty.exe
	(cd PC/ ; $(MPACK) -s "MIME-encoded html-pretty for IBM PC DOS and Windows" \
		-o htmlpty.mim htmlpty.exe)

PC/htmlpty.uue:	PC/htmlpty.exe
	(cd PC/ ; $(UUENCODE) htmlpty.exe)

# Make a list of all HTML tags recognized by html-pretty
Tokens/htmlpty.tag:	htmlpty.l Makefile
	if test -d Tokens ; then $(TRUE) ; else $(MKDIR) Tokens ; fi
	echo "# HTML entities recognized by htmlpty, computed on `date` from" >$@
	echo "# `ls -lo htmlpty.l Makefile`" | $(COMPRESS-SPACE) >>$@
	echo "#" >>$@
	$(GREP) '^{BEGIN[A-Z][A-Z]*}{[A-Z]' htmlpty.l | \
		$(SED) -e 's/{BEGIN[A-Z][A-Z]*}//' -e 's/{ENDTAG}.*$$//' -e 's/[{}]//g' | \
		$(SORT) -u -f >>$@

# Make a multicolumn table of HTML tags recognized by html-pretty,
# which is useful for checking the descriptions in the manual pages.
Tokens/htmlpty.tab:	Tokens/htmlpty.tag
	$(GREP) '^#' <$< >$@
	$(GREP) -v '^#' <$< | \
		$(PR) $(PRFLAGS) >>$@

#=======================================================================
# Targets required for GNU autoconfigure support:

Makefile: Makefile.in config.status
	./config.status

config.status: configure
	$(srcdir)/configure --srcdir=$(srcdir) --no-create

configure: configure.in configure.sed
	cd $(srcdir); autoconf
# Apply needed fixup for C++ with configure
	mv configure configure.tmp
	$(SED) -f configure.sed <configure.tmp >configure
	-$(RM) configure.tmp
	-$(CHMOD) 775 configure

#=======================================================================
# Public convenience targets.  You can supply a TARGETS=targets setting
# when you invoke make to select a particular target; if you do not,
# then the default target, all, will be made.  These targets are named
# according to the scheme vendor-architecture-operatingsystem-compiler.
#
# Sample usage:
#	make dec-alpha-osf1-c++ TARGETS='distclean all check install'
#
# Most of these targets have been imported from other Makefiles, so
# not all have been tested with html-pretty.

MAKEVARS        = AWK='$(AWK)' EXPAND='$(EXPAND)' \
		  HOST='$(HOST)' LEX='$(LEX)' OPT='$(OPT)' \
		  USER='$(USER)' XCFLAGS='$(XCFLAGS)'

cdc-mips-epix-cc:
	$(MAKE) $(MAKEVARS) CC='cc -systype bsd43 -D__CC__' $(TARGETS)

cray-el94-unicos-c89:
	$(MAKE) $(MAKEVARS) CC='c89' $(TARGETS)

dec-alpha-osf1-c++:
	$(MAKE) $(MAKEVARS) CC='cxx -x cxx -D_POSIX_SOURCE' $(TARGETS)

# NB: At OSF/1 version 1.x, can omit -std1, but need it for OSF/1 version 2.x
dec-alpha-osf1-cc:
	$(MAKE) $(MAKEVARS) CC='c89 -std1' $(TARGETS)

dec-alpha-osf1-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS)' $(TARGETS)

dec-alpha-osf1-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS)' $(TARGETS)

dec-mips-ultrix-cc:
	$(MAKE) $(MAKEVARS) CC=cc $(TARGETS)

dec-mips-ultrix-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS)' $(TARGETS)

dec-mips-ultrix-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS)' $(TARGETS)

dec-mips-ultrix-lcc:
	$(MAKE) $(MAKEVARS) CC='lcc -A -A -n' OPT= $(TARGETS)

hp-370-bsd43-c++:
	$(MAKE) $(MAKEVARS) CC=CC $(TARGETS)

hp-370-bsd43-cc:
	$(MAKE) $(MAKEVARS) CC=CC $(TARGETS)

hp-9000-hpux-c++:
	$(MAKE) $(MAKEVARS) CC='CC -D_HPUX_SOURCE' $(TARGETS)

hp-9000-hpux-cc:
	$(MAKE) $(MAKEVARS) CC='c89 -D_HPUX_SOURCE' $(TARGETS)

hp-9000-hpux-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc -D_HPUX_SOURCE $(GCCFLAGS)' $(TARGETS)

hp-9000-hpux-g++:
	$(MAKE) $(MAKEVARS) CC='g++ -D_HPUX_SOURCE $(GCCFLAGS)' $(TARGETS)

IBM370CC = 'CC +a1 +p +w -D_POSIX_SOURCE -Hansi -D__STDC__ -D_BSD -D_AIX -D_AIX370'
ibm-370-aix-c++:
	$(MAKE) $(MAKEVARS) CC=$(IBMPS2CC) $(TARGETS)

ibm-370-aix-cc:
	$(MAKE) $(MAKEVARS) CC=cc $(TARGETS)

IBMPS2CC = 'CC +a1 +p +w -D_POSIX_SOURCE -Hansi -D__STDC__ -D_BSD -D_AIX -Dps2'
ibm-ps2-aix-c++:
	$(MAKE) $(MAKEVARS) CC=$(IBMPS2CC) $(TARGETS)

ibm-ps2-aix-cc:
	$(MAKE) $(MAKEVARS) CC=cc $(TARGETS)

ibm-rs6000-aix-cc:
	$(MAKE) $(MAKEVARS) CC='c89 -D_POSIX_SOURCE -D_ALL_SOURCE' $(TARGETS)

ibm-rs6000-aix-c++:
	$(MAKE) $(MAKEVARS) CC='xlC' $(TARGETS)

ibm-rs6000-aix-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS)' $(TARGETS)

ibm-rs6000-aix-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS)' $(TARGETS)

mips-mips-riscos-cc:
	$(MAKE) $(MAKEVARS) CC='cc -systype bsd43 -D__CC__' $(TARGETS)

next-motorola-mach-cc:
	$(MAKE) $(MAKEVARS) CC='cc $(GCCFLAGS)' $(TARGETS)

next-motorola-mach-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS)' $(TARGETS)

next-motorola-mach-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS)' $(TARGETS)

next-motorola-mach-lcc:
	$(MAKE) $(MAKEVARS) CC='lcc -A -A -n' OPT= $(TARGETS)

sgi-mips-irix-c++:
	$(MAKE) $(MAKEVARS) CC='CC +a1 -xansi +w' $(TARGETS)

SGICC	= 'cc -ansiposix -fullwarn -woff 22,24,183,205,262,269,302,303'
sgi-mips-irix-cc:
	$(MAKE) $(MAKEVARS) CC=$(SGICC) $(TARGETS)

sgi-mips-irix-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS)' $(TARGETS)

sgi-mips-irix-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS)' $(TARGETS)

sgi-mips-irix-lcc:
	$(MAKE) $(MAKEVARS) CC='lcc -A -A -n' OPT= $(TARGETS)

sgi-mips-irix6-c++:
	$(MAKE) $(MAKEVARS) CC='CC -xansi' $(TARGETS)

SGICC	= 'cc -ansiposix -fullwarn'
sgi-mips-irix6-cc:
	$(MAKE) $(MAKEVARS) CC=$(SGICC) $(TARGETS)

stardent-mips-os2-cc:
	$(MAKE) $(MAKEVARS) CC='cc' OPT= $(TARGETS)

# If your Sun systems are exclusively of SuperSPARC and MicroSPARC
# architecture (SPARC level 8), then use XCFLAGS=-cg92 to get the
# code generator to use the integer multiply and divide instructions
# instead of subroutine calls.
SUNAPCC	= 'apcc -Xc=ansi -D__ACC__ -D__solaris'
sun-sparc-solaris2-apcc sun-sparc-sunos5-apcc:
	$(MAKE) $(MAKEVARS) CC=$(SUNAPCC) $(TARGETS)

sun-sparc-solaris2-g++ sun-sparc-sunos5-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS) -D__solaris' $(TARGETS)

sun-sparc-solaris2-gcc sun-sparc-sunos5-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS) -D__solaris' $(TARGETS)

sun-sparc-solaris2-c++ sun-sparc-sunos5-c++:
	$(MAKE) $(MAKEVARS) CC='CC -D__solaris' OPT=-O4 $(TARGETS)

sun-sparc-solaris2-cc sun-sparc-sunos5-cc:
	$(MAKE) $(MAKEVARS) CC='cc -Xc -D__ACC__ -D__solaris' OPT=-xO4 \
		$(TARGETS)

# NB: We normally specify -n for checking for dereferencing of NULL
# pointers, but there is a bug in lcc 3.1 that results in bogus error
# messages for citesub.c.
sun-sparc-solaris2-lcc sun-sparc-sunos5-lcc:
	$(MAKE) $(MAKEVARS) CC='lcc -A -A -D__solaris' OPT= $(TARGETS)

SUNACC	= 'acc -Xc -vc -strconst -D__ACC__ -D_POSIX_SOURCE -Dunix'
sun-sparc-solaris1-acc sun-sparc-sunos4-acc:
	$(MAKE) $(MAKEVARS) CC=$(SUNACC) $(TARGETS)

sun-sparc-solaris1-c++ sun-sparc-sunos4-c++:
	$(MAKE) $(MAKEVARS) CC='/usr/CC/sun4/CC -I/usr/CC/incl -D__SUNCC__' \
		$(TARGETS)

sun-sparc-solaris1-gcc sun-sparc-sunos4-gcc:
	$(MAKE) $(MAKEVARS) CC='gcc $(GCCFLAGS)' $(TARGETS)

sun-sparc-solaris1-g++ sun-sparc-sunos4-g++:
	$(MAKE) $(MAKEVARS) CC='g++ $(GCCFLAGS)' $(TARGETS)

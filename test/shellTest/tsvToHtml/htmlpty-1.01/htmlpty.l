%{					/* -*-c-*- */
 /**********************************************************************
 @Lex-file{
    author              = "Nelson H. F. Beebe",
    version             = "1.01",
    date                = "25 August 2001",
    time                = "16:02:40 MDT",
    filename            = "htmlpty.l",
    address             = "Center for Scientific Computing
                           University of Utah
                           Department of Mathematics, 322 INSCC
                           155 S 1400 E RM 233
                           Salt Lake City, UT 84112-0090
                           USA",
    telephone           = "+1 801 581 5254",
    FAX                 = "+1 801 585 1640, +1 801 581 4148",
    URL                 = "http://www.math.utah.edu/~beebe",
    checksum            = "61434 4466 13618 115898",
    email               = "beebe@math.utah.edu, beebe@acm.org,
			   beebe@computer.org, beebe@ieee.org (Internet)",
    codetable           = "ISO/ASCII",
    keywords            = "HTML, prettyprinter, SGML, WWW, World-Wide Web",
    supported           = "yes",
    docstring           = "This is a table-driven HTML and SGML file
			   prettyprinter.

			   Usage:

                               html-pretty [-?] [-author] [-blank-line-warning]
                                       [-brief] [-catalogfile filename]
                                       [-check-tag-nesting] [-comment-banner]
                                       [-convert-paragraph-breaks] [-copyright]
                                       [-email-address user@host]
                                       [-extend-style style:tags]
                                       [-extend-style tag:tags] [-file filename]
                                       [-grammar-level level] [-help]
                                       [-indent nnn] [-keep-format]
				       [-logfile filename]
                                       [-no-blank-line-warning] [-no-brief]
                                       [-no-check-tag-nesting]
                                       [-no-comment-banner]
				       [-no-convert-paragraph-breaks]
				       [-no-keep-format] [-no-print-stylefile]
				       [-no-quiet] [-no-read-stylefiles]
                                       [-no-trace-opens]
				       [-no-unknown-tag-warning]
                                       [-no-warnings-in-comments]
                                       [-outfile filename] [-personal-name]
                                       [-print-stylefile] [-quiet]
				       [-read-stylefiles] [-stylefile filename]
				       [-trace-opens] [-unknown-tag-warning]
				       [-version] [-width nnn]
                                       [< infile or file(s)] [> outfile]

			   The options are:

			   -?                    : display usage summary and
						   quit
			   -author               : show author credit and quit
			   -blank-line-warning   : warn about blank lines
			   -brief                : omit standard !DOCTYPE, HTML,
						   HEAD, BODY
			   -catalogfile filename : set style catalog filename
			   -check-tag-nesting    : warn about tag nesting errors
			   -comment-banner       : print a comment banner
                           -convert-paragraph-breaks : convert text paragraph
                                                   break to HTML paragraph break
			   -copyright            : show copyright information
						   and quit
			   -email-address adr    : set email address for banner
			   -extend-style "style:TAG TAG ..."  : extend style
						   class with tags
			   -extend-style "TAG:TAG TAG ..."    : extend style
						   class of TAG with tags
			   -file filename        : name output file in comment
						   banner
			   -grammar-level level  : select grammar level in style
						   catalog
			   -help                 : display usage summary and
						   quit
			   -indent nnn           : set indentation to nnn spaces
						   per level
			   -keep-format          : preserve input format
			                           verbatim
			   -logfile filename     : set error log filename
			   -no-blank-line-warning: do not warn about blank lines
                           -no-brief             : output standard !DOCTYPE,
                                                   HTML, HEAD, BODY
                           -no-check-tag-nesting : do not warn about tag nesting
                                                   errors
			   -no-comment-banner    : no comment banner
                           -no-convert-paragraph-breaks : do not convert text
                                                   paragraph breaks to <P>
			   -no-keep-format       : treat input as normal HTML or
			                           SGML
                           -no-print-stylefile   : do not print stylefile
			   -no-quiet             : print warnings on stderr
                           -no-read-stylefiles   : do not read default style
			                           files
                           -no-trace-opens       : no tracing of attempted file
                                                   openings
                           -no-unknown-tag-warning : no unknown tag warnings
			   -no-warnings-in-comments : warnings appear only on
			                              stderr
			   -outfile filename     : set output filename
			   -personal-name name   : set personal name for banner
			   -print-stylefile      : print style file and quit
			   -quiet                : do not print warnings on
			                           stderr
			   -read-stylefiles      : read default style files
			   -stylefile filename   : set style filename
			   -trace-opens          : trace attempted file openings
			   -unknown-tag-warning  : warn about unknown HTML tags
                           -warnings-in-comments : warnings also appear as
                                                   comments on stdout
			   -version              : show version number and quit
			   -width nnn            : set output line width to nnn

			   Letter case in option names is NOT
			   significant, and option names may be
			   abbreviated to any unique leading prefix.

			   On IBM PC DOS, the leading hyphen in option
			   names may be replaced by a slash; both
			   hyphen and slash are accepted.

			   For compatibility with GNU and POSIX option
			   styles, the option switch character may be
			   doubled: --author is the same as -author.

			   The idea is that each <TAG> ... </TAG> pair
			   should contain material that is indented
			   according to the nesting depth of the tags.
			   However, certain common tags, such as those
			   to change fonts, are excluded from this
			   indenting.

			   As with any simple-minded prettyprinter,
			   especially ones for natural language text,
			   which rarely conforms to a strict grammar,
			   you should check the output of the
			   prettyprinter before replacing the input by
			   it.  In particular, if your input file
			   follows the standards imposed by this
			   prettyprinter, a file difference listing may
			   be reassuring.  Otherwise, try viewing the
			   output with one or more World-Wide Web client
			   programs (amaya, arena, chimera, hotjava, ie,
			   jde, lynx, netscape, panorama, xmosaic, ...).
			   If you have an SGML parser or translator, you
			   can use that for checking too.

			   The checksum field above contains a CRC-16
			   checksum as the first value, followed by the
			   equivalent of the standard UNIX wc (word
			   count) utility output of lines, words, and
			   characters.  This is produced by Robert
			   Solovay's checksum utility.",
 }
 **********************************************************************/

/* htmlpty -- prettyprint World-Wide Web HTML files, and SGML files */

#include <config.h>			/* private header file */

#if defined(HAVE_CTYPE_H)
#include <ctype.h>
#endif

#if defined(HAVE_LIMITS_H)
#include <limits.h>
#endif

#if !defined(INT_MAX)
#define INT_MAX 32767			/* should always be in <limits.h> */
#endif

#if defined(HAVE_STDIO_H)
#include <stdio.h>
#endif

#if defined(HAVE_STDLIB_H)
#include <stdlib.h>
#endif

#if defined(HAVE_STRING_H)
#include <string.h>			/* for strlen() declaration */
#endif

#if defined(HAVE_SYS_TYPES_H)
#include <sys/types.h>
#endif

#if defined(HAVE_TIME_H)
#include <time.h>
#endif

#include <common.h>			/* private header file */
#include <fileutil.h>			/* private header file */
#include <sysutil.h>			/* private header file */

#if !defined(__DATE__)
#define __DATE__ ""
#endif /* __DATE__ */

#if !defined(__TIME__)
#define __TIME__ ""
#endif /* __TIME__ */

#if !defined(USER)
#define USER	""
#endif

#if !defined(HOSTNAME)
#define HOSTNAME ""
#endif

#define COMMENT_PREFIX	"<!-- "
#define COMMENT_SUFFIX	" -->"

#if !defined(DEFAULT_DOCTYPE)
#define DEFAULT_DOCTYPE "\"-//IETF//DTD HTML//EN\""	/* can override at compile time */
	/* WARNING: if this is changed, ENTITY_QUOTE may need change too! */
#endif

#if !defined(INDENT)
#define INDENT 4			/* can override at compile time */
#endif

#if (INDENT < 4) || (16 < INDENT)
#undef INDENT
#define INDENT 4			/* but guarantee a reasonable value */
#endif

#define PUTSTDERR(msg)	(void)fputs((msg), stderr)

#if defined(IBM_PC)
#if !defined(CATALOG_PATH)
#define CATALOG_PATH			"lib\\"
#endif
#if !defined(CATALOG_FILE)
#define CATALOG_FILE			"catalog"
#endif
#else
#if defined(VMS)
#if !defined(CATALOG_PATH)
#define CATALOG_PATH			"[-]"
#endif
#if !defined(CATALOG_FILE)
#define CATALOG_FILE			"catalog"
#endif
#else  /* supply UNIX-like defaults */
#if !defined(CATALOG_PATH)
#define CATALOG_PATH			"share/lib/"
#endif
#if !defined(CATALOG_FILE)
#define CATALOG_FILE			"catalog"
#endif
#endif /* defined(VMS) */
#endif /* defined(IBM_PC) */


#if defined(IBM_PC)
#if defined(__TURBOC__)

/* This code will compile fine under Turbo C 2.0, which always defines
fileno().  However, Turbo C 3.0 defines fileno() only in a non-Standard
C environment (-A command-line flag omitted).  Compilation fails under
both 2.0 and 3.0 if -A is omitted, because some header files get
included with const modifiers (flex checks for Turbo C and ensures that
const is used), and they later get included again with const defined to
an empty string (by stdc.h), resulting in function prototype declaration
conflicts.  Thus, we need to compile in the Standard C environment, and
then supply a definition of fileno() if one hasn't been provided. */

#ifndef fileno
#define fileno(f)       ((f)->fd)
#endif
#endif /* defined(__TURBOC__) */
#endif /* defined(IBM_PC) */

/* Silicon Graphics IRIX 5.3 lex supplies a 200-character input
buffer, which is much too small, so increase it. */

#if defined(IBM_PC)
#define YYLMAX_MIN 1024
#else
#define YYLMAX_MIN 8192
#endif

#if defined(YYLMAX) && ((YYLMAX + 0) < YYLMAX_MIN)
#undef YYLMAX
#define YYLMAX YYLMAX_MIN
#endif

#if !defined(YYLMAX)
#define YYLMAX YYLMAX_MIN
#endif

#undef VERSION				/* we don't want the config.h value */

const char *PROGRAM =	"html-pretty";
const char *VERSION =	"1.01";		 /* these MUST match version */
const char *DATE =	"[25-Aug-2001]"; /* and date above */

#define	OPT_INVALID			32700

#define	OPT_AUTHOR			32701
#define	OPT_BLANK_LINE_WARNING		32702
#define	OPT_BRIEF			32703
#define	OPT_CATALOGFILE			32704
#define	OPT_CHECK_TAG_NESTING		32705
#define	OPT_COMMENT_BANNER		32706
#define	OPT_CONVERT_PARAGRAPH_BREAKS	32707
#define	OPT_COPYRIGHT			32708
#define	OPT_EMAIL_ADDRESS		32709
#define	OPT_EXTENDED_STYLE		32710
#define	OPT_FILE			32711
#define	OPT_GRAMMAR_LEVEL		32712
#define	OPT_HELP			32713
#define	OPT_INDENT			32714
#define	OPT_KEEP_FORMAT			32715
#define	OPT_LOGFILE			32716
#define	OPT_NO_BLANK_LINE_WARNING	32717
#define	OPT_NO_BRIEF			32718
#define	OPT_NO_CHECK_TAG_NESTING	32719
#define	OPT_NO_COMMENT_BANNER		32720
#define	OPT_NO_CONVERT_PARAGRAPH_BREAKS	32721
#define	OPT_NO_KEEP_FORMAT		32722
#define	OPT_NO_PRINT_STYLEFILE		32723
#define	OPT_NO_QUIET			32724
#define	OPT_NO_READ_STYLEFILES		32725
#define	OPT_NO_TRACE_OPENS		32726
#define	OPT_NO_UNKNOWN_TAG_WARNING	32727
#define	OPT_NO_WARNINGS_IN_COMMENTS	32728
#define	OPT_OUTFILE			32729
#define	OPT_PERSONAL_NAME		32730
#define	OPT_PRINT_STYLEFILE		32731
#define	OPT_QUIET			32732
#define	OPT_READ_STYLE_FILES		32733
#define	OPT_STYLEFILE			32734
#define	OPT_TRACEOPENS			32735
#define	OPT_UNKNOWN_TAG_WARNING		32736
#define	OPT_VERSION			32737
#define	OPT_WARNINGS_IN_COMMENTS	32738
#define	OPT_WIDTH			32739

typedef struct
{
    const char		*name;
    size_t		min_match;
    int			number;
} Option;

static Option option_table[] =
{
    {"?",			1,	OPT_HELP },
    {"author",			1,	OPT_AUTHOR },
    {"blank-line-warning",	2,	OPT_BLANK_LINE_WARNING },
    {"brief",			1,	OPT_BRIEF }, 		/* NB: -b is equivalent */
    {"catalogfile",		1,	OPT_CATALOGFILE },	/* NB: -c is equivalent */
    {"check-tag-nesting",	2,      OPT_CHECK_TAG_NESTING },
    {"comment-banner",		3,	OPT_COMMENT_BANNER },
    {"convert-paragraph-breaks",3,	OPT_CONVERT_PARAGRAPH_BREAKS },
    {"copyleft",		3,	OPT_COPYRIGHT },
    {"copyright",		3,	OPT_COPYRIGHT },
    {"e-mail-address",		2,	OPT_EMAIL_ADDRESS },	/* email and e-mail are equally common */
    {"email-address",		2,	OPT_EMAIL_ADDRESS },
    {"extend-style",		1,	OPT_EXTENDED_STYLE },	/* NB: -e is equivalent */
    {"file",			1,	OPT_FILE },
    {"grammar-level",		1,	OPT_GRAMMAR_LEVEL },
    {"help",			1,	OPT_HELP },
    {"indent",			1,	OPT_INDENT },
    {"keep-format",		1,	OPT_KEEP_FORMAT },
    {"logfile",			1,	OPT_LOGFILE },
    {"no-blank-line-warning",	5,	OPT_NO_BLANK_LINE_WARNING },
    {"no-brief",		5,	OPT_NO_BRIEF },
    {"no-check-tag-nesting",	5,	OPT_NO_CHECK_TAG_NESTING },
    {"no-comment-banner",	1,	OPT_NO_COMMENT_BANNER }, /* NB: -n is equivalent */
    {"no-convert-paragraph-breaks", 6,	OPT_NO_CONVERT_PARAGRAPH_BREAKS },
    {"no-keep-format",		4,	OPT_NO_KEEP_FORMAT },
    {"no-print-stylefile",	4,	OPT_NO_PRINT_STYLEFILE },
    {"no-quiet",		4,	OPT_NO_QUIET },
    {"no-read-stylefiles",	4,	OPT_NO_READ_STYLEFILES },
    {"no-trace-opens",		4,	OPT_NO_TRACE_OPENS },
    {"no-unknown-tag-warning",	4,	OPT_NO_UNKNOWN_TAG_WARNING },
    {"no-warnings-in-comments",	4,	OPT_NO_WARNINGS_IN_COMMENTS },
    {"outfile",			1,	OPT_OUTFILE },
    {"personal-name",		2,	OPT_PERSONAL_NAME },
    {"print-stylefile",		1,	OPT_PRINT_STYLEFILE },	/* NB: -p is equivalent */
    {"quiet",			1,	OPT_QUIET },
    {"read-stylefiles",		1,	OPT_READ_STYLE_FILES },
    {"stylefile",		1,	OPT_STYLEFILE },
    {"trace-opens",		1,	OPT_TRACEOPENS },
    {"unknown-tag-warning",	1,	OPT_UNKNOWN_TAG_WARNING },
    {"version",			1,	OPT_VERSION },
    {"warnings-in-comments",	2,	OPT_WARNINGS_IN_COMMENTS },
    {"width",			1,	OPT_WIDTH },		/* NB: -w is equivalent */
    {(const char*)NULL,		0,	OPT_INVALID },
};

#if !defined(MAXBIGBUF)
#if defined(IBM_PC)
#define HUGE		huge
#define MAXBIGBUF	2048
#else
#define HUGE
#define MAXBIGBUF	16384
#endif
#endif

#if (MAXBIGBUF) < (MAXBUF)
#undef MAXBIGBUF
#define MAXBIGBUF	(MAXBUF)
#endif

static HUGE char	big_buffer[MAXBIGBUF];

static int		anchor_level = 0;
static int		big_last_verbatim_position = -1;
static int		big_next_position = 0;	/* index into big_buffer[] */
static int		big_newline_position = -1;
static int		blank_line_warning = 0;
static int		body_count = 0;
static int		body_level = 0;
static int		break_suppress = 0;
static int		brief_format = 0;
static const char	*catalog_filename = (const char*)NULL;
static const char	*comment_banner_filename = "";
static int		convert_paragraph_breaks = 0;
static int		do_banner = 1;
static int		do_check_tag_nesting = 0;
static int		doctype_count = 0;

#define ENTITY_AMP	"&amp;"
#define ENTITY_GT	"&gt;"
#define ENTITY_LT	"&lt;"

#if !defined(ENTITY_QUOTE)
#define ENTITY_QUOTE	"&quot;" /* can override at compile time */
			/* default level is 2 (see DEFAULT_DOCTYPE above) */
#endif

static const char 	*entity_quote = ENTITY_QUOTE;

#undef ENTITY_QUOTE
#define ENTITY_QUOTE	entity_quote

#define GRAMMARS_WITH_QUOT " 2 2.0 3.2-draft 4 4.0 cougar mosaic netscape "
					/* NB: MUST be lowercase! */

static int		file_flag = 0;
static const char	*grammar_level = (const char*)NULL;
static int		head_count = 0;
static int		head_level = 0;
static int		html_count = 0;
static int		html_level = 0;
static int		in_plaintext = 0;
static int		indent = INDENT;
static const char	*input_filename = "";
static HUGE int		item_level[MAXLISTNEST+1]; /* index by 1..MAXLISTNEST */
static const char	*item_end_tag[MAXLISTNEST+1];
static int		keep_format = 0;
static int		level = 0;
static int		line_number = 1;
static int		link_count = 0;
static int		list_level = 0;
static int		main_level = 0;
static int		new_paragraph_pending = 0;
static const char	*option_last;
static int		paragraph_level = 0;

#if defined(DEBUG)
static char		prefix[4];	/* for DEBUGGING */
#endif

static int		print_style_file = 0;
static int		quiet_flag = 0;
static int		read_stylefiles_flag = 1;

typedef struct
{
    const char *tag_name;
    int		tag_line_number;
} Tag_Nest_Entry;

typedef struct
{
    size_t		top;		/* points to next free entry in nest[] */
    int			error;		/* non-zero in underflow/overflow state */
    Tag_Nest_Entry	nest[MAXTAGNEST];
} Tag_Nest;

static Tag_Nest		tag_nest;

static int		title_count = 0;
static int		title_level = 0;
static int		unknown_tag_warning = 0;
static const char	*user_email = (const char*)NULL;
static const char	*user_personal_name = (const char*)NULL;
static int		warnings_in_comments = 0;
int			g_argc;
int			g_argk;
char			**g_argv;
const char		*g_arg_source = (const char*)NULL;
int			g_errors = 0;
int			max_width = MAXWIDTH;
int			quit_flag = 0;
int			trace_flag = 0;

static void		adjust_level ARGS((int n_));
static void		author ARGS((void));
static void		begin_font ARGS((void));
static void		begin_list ARGS((void));
static void		begin_list_header ARGS((void));
static void		begin_list_item ARGS((void));
static void		begin_math ARGS((void));
static void		begin_pair ARGS((void));
static void		begin_paragraph ARGS((void));
static void		begin_verbatim ARGS((const char *tag));
INLINE static void	blank ARGS((void));
static void		check_anchor_level ARGS((const char *tag));
static void		check_for_forbidden_end_tag ARGS((const char *tag_name_));
static void		check_tag_nesting ARGS((const char *tag_name));
static int		check_tag_restriction ARGS((const char *tag_name,
						    const char *array_name,
						    const char *top_tag));
static void		comment ARGS((void));
static void		complex_comment ARGS((void));
static void		complex_markup_declaration ARGS((void));
static const char	*concat ARGS((const char *s,const char *t));
static void		copyright ARGS((void));
INLINE static void	copy_verbatim ARGS((void));
static void		count_lines ARGS((void));
static void		delete_backwards ARGS((int offset));
static void		delete_horizontal_spaces ARGS((void));
static void		delete_trailing_spaces ARGS((void));
static void		do_begin_body ARGS((void));
static void		do_begin_head ARGS((void));
static void		do_begin_html ARGS((void));
static void		do_catalog_file ARGS((const char *catalog,
					       const char *grammar));
static int		do_catalog_line ARGS((const char *source,
					      int style_line_number,
					      char *line, const char *path,
					      char *level_list,
					      size_t level_list_size));
static void		do_doctype ARGS((void));
static void		do_end_body ARGS((void));
static void		do_end_head ARGS((void));
static void		do_end_html ARGS((void));
static void		do_initialization_files ARGS((void));
static void		do_link ARGS((void));

#if defined(TAG_CACHE)
typedef void (*StyleFunction)ARGS((void));
#define DO_TAG2(s)	{ \
				static StyleFunction *action = (StyleFunction*)NULL; \
				if (action == (StyleFunction*)NULL) \
					action = get_action_by_name(s); \
				count_lines(); \
				do_tag_2(action); \
			}
static void		do_tag_2 ARGS((StyleFunction *action));
StyleFunction		*get_action_by_name ARGS((const char *key));
#endif /* defined(TAG_CACHE) */

static void		do_tag ARGS((void));
static void		do_title ARGS((void));
INLINE static void	dputc ARGS((int c_));
static int		empty_paragraph ARGS((void));
static void		end_font ARGS((void));
static void		end_list ARGS((void));
static void		end_list_header ARGS((void));
static void		end_list_item ARGS((const char *tag_));
static void		end_math ARGS((void));
static void		end_pair ARGS((void));
static void		end_paragraph ARGS((void));
static void		end_verbatim ARGS((const char *tag_));
static void		error ARGS((const char *msg_));
static void		expect_level ARGS((int the_level_));
static int		has_SGML_content_EMPTY ARGS((const char *tag_name));
INLINE static int	indentation_size ARGS((void));

#if defined(__cplusplus)
			/* Sun Solaris 2.x lex renames input() to yyinput() */
#define Input()		yyinput()
#else
#define Input()		input()
#endif /* defined(__cplusplus) */

#define Is_Begin_Anchor(s)	((s[0] == '<') && \
				 ((s[1] == 'A') || (s[1] == 'a')) && \
				 !isalnum(s[2]))

#define Is_Begin_Tag(s)	((s)[1] != '/')

#define Is_Comment_or_Markup_Declaration(s) ((s[0] == '<') && (s[1] == '!'))

#define Is_End_Anchor(s)	((s[0] == '<') && \
				(s[1] == '/') && \
				((s[2] == 'A') || (s[2] == 'a')) && \
				!isalnum(s[3]))

#define Is_End_Tag(s)	(!Is_Begin_Tag(s))

#define Is_NonEmpty_Line()	(line_length() > indentation_size())

#define Is_SGML_tagchar(c)	(isalnum(c) || (c == '!') || (c == '?'))

INLINE static int	last_char ARGS((int offset_));

#if defined(FLEX_SCANNER)
#define LEXEOF(c)	((c) == EOF)	/* flex end-of-file test */
#else
#define LEXEOF(c)	((c) == 0)	/* lex end-of-file test */
#endif

static void		line_end ARGS((void));

#define line_length()	(big_next_position - 1 - big_newline_position)

#define maybe_begin_body() ((body_count == 0) ? (do_begin_body(), 1) : 0)

static void		multiline_end ARGS((void));
static void		new_paragraph ARGS((void));
static void		newline_after ARGS((void));
static void		newline_around ARGS((void));
static void		no_space_before ARGS((void));
INLINE static void	normalize_tag ARGS((char *tag_));
static void		option_error ARGS((const char *msg_));
static int		option_match ARGS((const char *keyword,
				    const char *user_option,
				    size_t min_match));
static int		option_type ARGS((int argnum_));
static void		out_banner ARGS((void));
static void		out_begin_tag ARGS((const char *s_));
INLINE static void	out_blank ARGS((void));
INLINE static void	out_char ARGS((int c_));
static void		out_doctype ARGS((const char *s_,int default_doctype_));
static void		out_end_tag ARGS((const char *s_));
static void		out_escape ARGS((const char *s_));
static void		out_indentation ARGS((void));
static void		out_leading_blanks ARGS((int nblanks_));

#define out_newline()	out_char((int)'\n')

static void		out_nbsp ARGS((void));
INLINE static void	out_string ARGS((const char *s_));
static void		out_tag_on_own_line ARGS((const char *tag_));
INLINE static void	out_verbatim_char ARGS((int c_));
INLINE static void	out_verbatim_string ARGS((const char *s_));
static void		out_word ARGS((void));
static void		pair_nocheck ARGS((void));
static void		paragraph_break ARGS((void));
static int		paragraph_contains ARGS((const char *tag));
static const char	*peek_tag_nest_tagname ARGS((void));
static int		peek_tag_nest_line_number ARGS((void));
static void		pop_tag_nest ARGS((const char *tag));
static void		print_tag_nest ARGS((void));
static void		punctuation ARGS((void));
static void		push_tag_nest ARGS((const char *tag));
static const char 	*quote_check ARGS((const char *tag));
static void		prescan_options ARGS((void));
static int		reopen ARGS((void));
INLINE static const char *search ARGS((const char *s, const char *sub));
static void		space_after ARGS((void));
static void		space_before ARGS((void));
static int		stricmp ARGS((const char *s1, const char *s2));
static const char 	*tagname ARGS((const char *tag));
INLINE static void	trim_line ARGS((int n_));
static void		usage ARGS((void));
static void		version ARGS((void));
INLINE static void	verbatim_with_translation ARGS((void));
static void		wrapup ARGS((void));

extern void		call_action_by_name ARGS((const char *key));
extern void		do_style_file ARGS((const char *the_filename,
					    int warn_if_no_file));
extern void		do_style_line ARGS((const char *source,
					    int style_line_number,
					    char *line));
extern char		*dupstr ARGS((const char *s));
extern void		generate_style_file ARGS((void));
extern const char	*get_class_by_name ARGS((const char *key));
extern const char	*get_name_by_style ARGS((const char *style));
extern void		initialize ARGS((void));
extern char		*lowercase ARGS((char *s));
extern void		make_hash_table ARGS((void));
extern char 		*strip_comment ARGS((char *line));
extern void		table_wrapup ARGS((void));
extern char		*uppercase ARGS((char *s));

void			body ARGS((void));
void			do_arg ARGS((void));
void			doctype ARGS((void));
void			flush_buffer ARGS((void));
void			font ARGS((void));
void			head ARGS((void));
void			html ARGS((void));
void			html_link ARGS((void));
void			hn ARGS((void));
void			inline_tag ARGS((void));
void			line_break ARGS((void));
void			list ARGS((void));
void			list_header ARGS((void));
void			list_item ARGS((void));
void			markup_declaration ARGS((void));
void			math ARGS((void));
void			math_pair ARGS((void));
void			other_tag ARGS((void));
INLINE void		out_yytext ARGS((void));
void			pair ARGS((void));
void			paragraph ARGS((void));
void			plaintext ARGS((void));
void			short_tag ARGS((void));
void			standalone ARGS((void));
void			standalone_nocheck ARGS((void));
void			title ARGS((void));
void			verbatim ARGS((void));
void			verbatim_nocheck ARGS((void));
void			warning ARGS((const char *msg_));


#if defined(yywrap)
#undef yywrap		/* this is a macro in some older flex versions */
#endif

#define YY_SKIP_YYWRAP	1		/* to suppress flex's own prototype */
int			yywrap ARGS((void));

%}

	/* These settings for lex are about double the required,  */
	/* during initial development.  They can be reduced when  */
	/* the code is stable.  */

%a	25000
%e	 5000
%k	 9000
%n	 2000
%o	40000
%p	10000

A	[Aa]
B	[Bb]
C	[Cc]
D	[Dd]
E	[Ee]
F	[Ff]
G	[Gg]
H	[Hh]
I	[Ii]
J	[Jj]
K	[Kk]
L	[Ll]
M	[Mm]
N	[Nn]
O	[Oo]
P	[Pp]
Q	[Qq]
R	[Rr]
S	[Ss]
T	[Tt]
U	[Uu]
V	[Vv]
W	[Ww]
X	[Xx]
Y	[Yy]
Z	[Zz]

BEGINPAIR	"<"[/]?
BEGINTAG	"<"

	/* SGML tags match "<NAME"{ENDTAG}, to allow for embedded */
	/* key="value" attributes.  Because this pattern matches */
	/* newline characters, every action that has ENDTAG in its */
	/* pattern MUST call count_lines() to update the line count. */
	/* Although AT&T lex has yylineno, POSIX lex does not, and */
	/* flex only provides it by special request.  It is unfortunate */
	/* that this requires tag tokens to be scanned more than once, */
	/* but fortunate that others do not require this overhead. */
ENDTAG		([^<>A-Za-z0-9][^<>]*)?">"
	/* Mon Nov 3 18:40:36 1997: add < twice to ENDTAG pattern to
	avoid premature matches with text that should match
	complex_comment() or complex_markup_declaration() below */

%%

[<]!--[^<>-]*--[ \f\n\r\t\013]*[>]		{ count_lines(); comment(); }


[<]!--([^<>-]*-[^<>-]+|[^<>-]+-[^<>-]*)*--[ \f\n\r\t\013]*[>]	{ count_lines(); comment(); }


[<]!--						{ complex_comment(); }


{BEGINPAIR}[!?][A-Za-z][A-Za-z0-9]*{ENDTAG}	|
{BEGINPAIR}[A-Za-z][A-Za-z0-9]*{ENDTAG}		{ count_lines(); do_tag(); }


[<][!?][A-Za-z][A-Za-z]*			{ complex_markup_declaration(); }


[<][!?][^A-Za-z<>-]+				{ complex_markup_declaration(); }


{BEGINTAG}[/]{ENDTAG}				|
{BEGINPAIR}[#A-Za-z][^>]*{ENDTAG}		{ count_lines(); other_tag(); }


[.,:;!?]+					{ punctuation(); }


[&]"nbsp"[;]					{ out_nbsp(); }

[&][#][0-9]+[;] |
[&][A-Za-z][A-Za-z0-9]*[;]			{ out_word(); /* match &lt;, &#229, &x6C34, ... */ }


[&]						{ out_escape(ENTITY_AMP); }


[<]						{ out_escape(ENTITY_LT); }


[>]						{ out_escape(ENTITY_GT); }


["]						{ out_escape(ENTITY_QUOTE); }


[^ <>"&\f\n\r\t\013]+		{	/* non-blank non-tag `words' */
					/* NB: lex on DEC ULTRIX, DEC OSF/1, */
					/* NeXT, and Sun SunOS 4.1.3 fails  */
					/* to handle \v (vertical tab) */
					/* correctly, so we replace it by */
					/* \013, sigh... */
					out_word();
				}


[ ]+				{ blank(); }


[\f\r\t\013]			{ out_blank(); }	/* other whitespace */


\n([\f\r\t\013]*\n)+		{ count_lines(); paragraph_break(); }

\n				{ line_end(); }


.				{ out_char((int)(yytext[0])); } /* other */


%%


static void
author(VOID_ARG)
{
    (void)fputs("Author:\n", stderr);
    (void)fputs("\tNelson H. F. Beebe, Ph.D.\n", stderr);
    (void)fputs("\tCenter for Scientific Computing\n", stderr);
    (void)fputs("\tUniversity of Utah\n", stderr);
    (void)fputs("\tDepartment of Mathematics, 105 JWB\n", stderr);
    (void)fputs("\t155 S 1400 E RM 233\n", stderr);
    (void)fputs("\tSalt Lake City, UT 84112-0900\n", stderr);
    (void)fputs("\tUSA\n", stderr);
    (void)fputs("\tTel: +1 801 581 5254\n", stderr);
    (void)fputs("\tFAX: +1 801 581 4148\n", stderr);
    (void)fputs("\tEmail: beebe@math.utah.edu, beebe@acm.org, beebe@ieee.org\n", stderr);
    (void)fputs("\tWWW URL: http://www.math.utah.edu/~beebe/\n", stderr);
}


#if STDC
static void
adjust_level(int n)
#else
static void
adjust_level(n)
int n;
#endif
{
    level += n;
    if (level < 0)
	level = 0;
}


static void
begin_font(VOID_ARG)
{
    maybe_begin_body();
    space_before();
}


static void
begin_list(VOID_ARG)
{
    maybe_begin_body();
    end_paragraph();		/* HTML lists cannot occur inside paragraphs */

    if (list_level < MAXLISTNEST)
    {
	++list_level;
	item_level[list_level] = 0;
	item_end_tag[list_level] = "";
    }
    else
	error("list nesting too deep: rebuild program with larger MAXLISTNEST");
    newline_around();
    adjust_level(1);
}


static void
begin_list_header(VOID_ARG)
{
    maybe_begin_body();
    end_paragraph();	/* HTML list headers cannot occur inside paragraphs */
    adjust_level(-1);
    newline_around();
}


static void
begin_list_item(VOID_ARG)
{
    maybe_begin_body();
    end_paragraph();		/* HTML list items cannot occur inside paragraphs */
    if (item_level[list_level] > 0)
	end_list_item(item_end_tag[list_level]); /* supply omitted end tag */
    adjust_level(-1);
    normalize_tag((char*)&yytext[0]);
    if (strncmp("<LI", (const char*)&yytext[0], 3) == 0)
	item_end_tag[list_level] = "</LI>";
    else if (strncmp("<DD", (const char*)&yytext[0], 3) == 0)
	item_end_tag[list_level] = "</DD>";
    else if (strncmp("<DT", (const char*)&yytext[0], 3) == 0)
	item_end_tag[list_level] = "</DT>";
    else
	error("unknown list item begin tag");
    newline_around();
    item_level[list_level]++;
}


static void
begin_math(VOID_ARG)
{
    maybe_begin_body();
    space_before();
}


static void
begin_pair(VOID_ARG)
{
    normalize_tag((char*)&yytext[0]);
    if (!paragraph_contains((const char*)&yytext[0]))
	end_paragraph();
    newline_around();
}


static void
begin_paragraph(VOID_ARG)
{
    maybe_begin_body();
    begin_pair();
    paragraph_level = level;
}


#if STDC
static void
begin_verbatim(const char *tag)
#else
static void
begin_verbatim(tag)
const char *tag;
#endif
{
    end_paragraph(); /* HTML verbatim environments cannot occur inside paragraphs */
    trim_line(0);
    if (line_length() > 0)
	out_newline();
    trim_line(0);		/* want <VERBATIM> and </VERBATIM> on newline */
    out_verbatim_string(tag);
}


INLINE static void
blank(VOID_ARG)
{
    int c_last;
    int c_lastm1;
    int c_lastm2;

    delete_horizontal_spaces();

    c_last = last_char(0);
    c_lastm1 = last_char(-1);
    c_lastm2 = last_char(-2);

    out_blank();		/* collapse multiple spaces into single one */

    switch (c_last)
    {
    case '.':
	if (isupper(c_lastm1))
	{
	    if (isspace(c_lastm2))
		break;			/* looks like [ ][A-Z][.] */
	    else
		out_blank();		/* assume sentence end */
	}
	else if ((c_lastm2 == '.') && isalpha(c_lastm1))
	    break;			/* looks like "e.g." or "i.e." */
	else
	    out_blank();		/* assume sentence end */
	break;

    case ':':
    case '!':
    case '?':
	out_blank();			/* two spaces after these punctuators */
	break;

    default:				/* no additional space */
	break;
    }
}


void
body(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
    {
	do_begin_head();
	do_end_head();
	if (body_count > 0)
	    warning("illegal extra <BODY> tag");
	body_count++;
	body_level++;
    }
    else
	body_level--;

    pair_nocheck();
    expect_level(1);
    main_level = level;
    new_paragraph();
}


#if STDC
static void
check_anchor_level(const char *tag)
#else
static void
check_anchor_level(tag)
const char *tag;
#endif
{
    if (Is_Begin_Anchor(tag))
    {
	anchor_level++;
	if (anchor_level > 1)
	    warning("obsolete feature: nested anchor tags <A ...> ... <A ...> ... </A> ... </A>");
    }
    else if (Is_End_Anchor(tag))
    {
	if (anchor_level <= 0)
	{
	    warning("end anchor </A> without previous matching begin anchor <A ...>");
	    anchor_level = 0;
	}
	else
	    anchor_level--;
    }
}


#if STDC
static void
check_for_forbidden_end_tag(const char *tag_name)
#else
static void
check_for_forbidden_end_tag(tag_name)
const char *tag_name;
#endif
{
    /* Check if the tag_name (e.g., BASEFONT, not <BASEFONT> or
       </BASEFONT>), is a member of the classes with SGML content
       EMPTY, for which end tags are forbidden, and if so, raise a
       warning for it.  Deletion is, however, left to a human. */

    if (has_SGML_content_EMPTY(tag_name))
    {
#undef MSG_FMT
#define MSG_FMT	"HTML grammars do not permit an end tag for the tag name [%.2047s]; please consider deleting it"
	char tempmsg[sizeof(MSG_FMT) + 2047 + 1];

	SPRINTF(tempmsg, MSG_FMT, tag_name);
	warning(tempmsg);
    }
}


#if STDC
static void
check_tag_nesting(const char *tag_name)
#else
static void
check_tag_nesting(tag_name)
const char *tag_name;
#endif
{
    if (do_check_tag_nesting)
    {
	const char	*top_tag;

	top_tag = peek_tag_nest_tagname();
	if (top_tag != (const char*)NULL)	/* see if tag_name can be contained in top_tag */
	{    /* NB: if the first check produces a warning, the second check is skipped */
	    check_tag_restriction(tag_name,"ContainedIn",top_tag) ||
	    check_tag_restriction(top_tag,"CannotContain",tag_name);
	}
    }
}


#if STDC
static int
check_tag_restriction(const char *tag_name, const char *array_name,
		      const char *top_tag)
#else
static int
check_tag_restriction(tag_name, array_name, top_tag)
const char *tag_name;
const char *array_name;
const char *top_tag;
#endif
{					/* return 0 on success, non-zero on error */
#undef MSG_FMT
#define MSG_FMT "%.2047s[%.2047s]"
    char	tempmsg[sizeof(MSG_FMT) + 2047 + 2047 + 1];
    const char	*value;

    SPRINTF(tempmsg, MSG_FMT, array_name, tag_name);

    value = get_name_by_style(tempmsg);

    if (value != (const char*)NULL)	/* then we have array_name[] data */
    {
#undef MSG_FMT
#define MSG_FMT " %.2047s "
	char search_string[sizeof(MSG_FMT) + 2047 + 1];

	SPRINTF(search_string, MSG_FMT, top_tag);
	if (search(value,search_string) == (char*)NULL)
	{
#undef MSG_FMT
#define MSG_FMT "tag <%.2047s> is illegal inside <%.2047s> environment beginning at line %d"
	    char tempmsg[sizeof(MSG_FMT) + 2047 + 2047 + 21 + 1];

	    SPRINTF(tempmsg, MSG_FMT, tag_name, top_tag, peek_tag_nest_line_number());
	    warning(tempmsg);
	    return (1);
	}
    }
    return (0);
}


static void
comment(VOID_ARG)
{
  /* Version 0.12: output short comments at current level, and long ones
    flush left.  Earlier versions output all comments flush left.
    Comments are always followed by a newline.  TO DO: perhaps offer
    command-line option to control this behavior. */

    char *p;

    p = (char*)strchr((const char*)&yytext[0],(int)'>');
    while ((p != (char*)NULL) && (p > (char*)&yytext[0]) && isspace(p[-1]))
    {				/* reduce "--   >" to "-->" */
	*p = '\0';
	*--p = '>';
    }

    if (line_length() == 0)
	out_indentation();

    if (strlen((const char*)&yytext[0]) <= (size_t)(max_width - line_length()))
	newline_after();
    else
	newline_around();

    adjust_level(-1);
}


static void
complex_comment(VOID_ARG)
{					/* called on match with "<!--" (comment begin) */
    /* Copy complex comment verbatim, handling nested --comment-- sections */

    register int c;			/* current input character */

#if defined(NESTED_SGML_COMMENTS)
    register int begin_count;		/* how much of "<!--" we have seen so far */
    register int end_count;		/* how much of "-->" we have seen so far */
    register int comment_level;		/* comment nesting depth */
#else
    register int consecutive_hyphen_count; /* number of consecutive hyphens seen so far */
    register int done;			/* non-zero when <!comment-declaration> complete */
    register int hyphen_pairs;		/* number of -- pairs seen so far */
    register int nonspace_count;	/* number of nonspaces since last space or -- */
    register int previous_c;		/* memory of previous input character */
#endif

    delete_horizontal_spaces();
    if (Is_NonEmpty_Line())		/* then put this tag on new line */
	out_newline();
    out_verbatim_string((const char*)&yytext[0]); /* this is "<!--" */

#if defined(NESTED_SGML_COMMENTS)
    /* After I wrote this, consultation with an SGML expert and the
       ISO 8879 SGML Standard clarified that comments cannot be nested
       in general; examples are given in the "COMMENTS IN HTML AND SGML"
       section of the manual page file, htmlpty.man.   The older code
       is preserved in case I need it in the future. */

    comment_level = 1;			/* since we have seen "<!--" */
    end_count = 0;
    begin_count = 0;

    /* Now copy to matching "-->", ignoring contents, and allowing
    nested comments. NB: html-check and html-ncheck seem to allow only
    ONE embedded comment, but I don't have the SGML standard handy to
    check this point. */

    while ((comment_level > 0) && (c = Input()) && !LEXEOF(c))
    {
	out_verbatim_char(c);
	switch (c)
	{
	case '<':
	    begin_count = 1;
	    end_count = 0;
	    break;

	case '!':
	    if (begin_count == 1)
		begin_count = 2;
	    end_count = 0;
	    break;

	case '-':
	    if (begin_count >= 2)
		begin_count++;
	    end_count++;
	    break;

	case '>':
	    begin_count = 0;
	    end_count++;
	    break;

	case '\n':
	    line_number++;
	    /* FALL THROUGH */

	case '\f':
	case '\r':
	case '\t':
	case '\013':			/* == '\v' */
	    begin_count = 0;
	    if (end_count == 2)
		break;		/* already saw "--", but following whitespace is legal */
	    end_count = 0;
	    break;

	default:
	    end_count = 0;
	    begin_count = 0;
	}
	if ((end_count == 3) && (c == '>')) /* then saw "-->" */
	    comment_level--;
	if ((begin_count == 4) && (c == '-')) /* then saw "<!--" */
	    comment_level++;
    }
#else
    /* Now copy body of (possibly multiple) --comments-- to matching ">".
       There must be an even number of -- pairs before the final ">",
       and nothing other than whitespace between the last -- and the
       final ">". */

    consecutive_hyphen_count = 2;
    done = 0;
    hyphen_pairs = 1;			/* since we have seen "<!--" */
    nonspace_count = 4;			/* since we have seen "<!--" */
    previous_c = '-';

    while (!done && (c = Input()) && !LEXEOF(c))
    {
	out_verbatim_char(c);

	if (!isspace(c))		/* strictly, should be !isSGMLspace() */
	    nonspace_count++;
	else
	    nonspace_count = 0;

	if (c == '-')
	{
	    if ((++consecutive_hyphen_count % 2) == 0)
	    {
		hyphen_pairs++;
		nonspace_count = 0;
	    }
	}
	else
	    consecutive_hyphen_count = 0;

	switch (c)
	{
	case '<':
	    if ((hyphen_pairs % 2) == 0)
		warning("tag-open string (<) is illegal outside --comment-region-- in a comment declaration");
	    break;

	case '!':
	    if (((hyphen_pairs % 2) == 0) && (previous_c == '<'))
		warning("markup-declaration-open string (<!) is illegal outside --comment-region-- in a comment declaration");
	    break;

	case '>':
	    if ((hyphen_pairs % 2) == 0) /* then possible end of comment declaration */
	    {
		if (nonspace_count == 1) /* end: only > and space seen since last -- */
		    done = 1;
		else
		    warning("tag-close string (>) is illegal outside --comment-region-- in a comment declaration");
	    }
	    break;

	case '\n':
	    line_number++;
	    break;

	default:
	    break;
	}
	previous_c = c;
    }
#endif /* defined(NESTED_SGML_COMMENTS) */
    out_newline();
}


static void
complex_markup_declaration(VOID_ARG)
{					/* called on match with "<[!?][A-Za-z]+" (declaration begin) */
    /* Copy complex declaration verbatim, handling nested --comment-- sections */

    register int c;			/* current input character */

    register int consecutive_hyphen_count; /* number of consecutive hyphens seen so far */
    register int done;			/* non-zero when <!comment-declaration> complete */
    register int hyphen_pairs;		/* number of -- pairs seen so far */
    register int nonspace_count;	/* number of nonspaces since last space or -- */
    register int angle_bracket_level;	/* level of < < <...> > > nesting */

    delete_horizontal_spaces();
    if (Is_NonEmpty_Line())		/* then put this tag on new line */
	out_newline();
    out_verbatim_string((const char*)&yytext[0]); /* this is "<!SomeName" */

    /* Now copy body of (possibly multiple) --comments-- to matching ">".
       There must be an even number of -- pairs before the final ">",
       and nothing other than whitespace between the last -- and the
       final ">". */

    consecutive_hyphen_count = 0;
    done = 0;
    hyphen_pairs = 0;			/* since we have seen "<!SomeName" */
    nonspace_count = strlen((const char*)&yytext[0]); /* since we have seen "<!SomeName" */
    angle_bracket_level = 1;		/* since we have seen "<!SomeName" */

    /* The while() {...} statement here is similar to that in
       complex_comment(): only the initialization, and the permitting
       of embedded <...> markup differs: TODO: perhaps move these two
       code sections to a common function! */

    while (!done && (c = Input()) && !LEXEOF(c))
    {
	out_verbatim_char(c);

	if (!isspace(c))		/* strictly, should be !isSGMLspace() */
	    nonspace_count++;
	else
	    nonspace_count = 0;

	if (c == '-')
	{
	    if ((++consecutive_hyphen_count % 2) == 0)
	    {
		hyphen_pairs++;
		nonspace_count = 0;
	    }
	}
	else
	    consecutive_hyphen_count = 0;

	switch (c)
	{
	case '<':
	    if ((hyphen_pairs % 2) == 0) /* then outside comment region */
		angle_bracket_level++;
	    break;

	case '>':
	    if ((hyphen_pairs % 2) == 0) /* then outside comment region */
	    {				/* possible end of comment declaration */
		angle_bracket_level--;
		if ((angle_bracket_level == 0) && (nonspace_count == 1))
		    done = 1;		/* end: only > and space seen since last -- */
	    }
	    break;

	case '\n':
	    line_number++;
	    break;

	default:
	    break;
	}
    }
    out_newline();
}


#if STDC
static const char *
concat(const char *s,const char *t)
#else
static const char *
concat(s,t)
const char *s;
const char *t;
#endif
{	/* return a dynamic string containing the concatenation of s and t */
    size_t	need;
    char	*p;

    if (s == (const char*)NULL)
	s = "";
    if (t == (const char*)NULL)
	t = "";
    need = strlen(s) + strlen(t) + 1;
    p = (char*)malloc(need);
    if (p == (char*)NULL)
	error("out of memory in concat()");
    else
	(void)strcat(strcpy(p,s),t);
    return ((const char*)p);
}


static void
copyright(VOID_ARG)
{
    FPRINTF(stderr,"\t*****************************************\n");
    FPRINTF(stderr,"\t* THIS PROGRAM IS IN THE PUBLIC DOMAIN. *\n");
    FPRINTF(stderr,"\t*****************************************\n");
}


INLINE static void
copy_verbatim(VOID_ARG)
{
    /* Copy up to matching </ENDTAG>, or in the case of <PLAINTEXT>, */
    /* to end-of-file. */

    int		c;
    char	endtag[MAXTOKENLENGTH + 1];
    size_t	k;
    char	normalized_endtag[MAXTOKENLENGTH + 1];
    char	verbatim_endtag[MAXTOKENLENGTH + 1];

    (void)strcpy(verbatim_endtag, "</");
    (void)strncat(verbatim_endtag, tagname((const char*)&yytext[0]),
		  sizeof(verbatim_endtag)-4); /* 3 for "</>", plus 1 for NUL */
    (void)strcat(verbatim_endtag, ">");

    while ((c = Input(), !LEXEOF(c)))
    {
	if (c == '\n')
	    line_number++;
	if (c == '<')
	{			/* try to collect tentative tag name */
	    k = 0;
	    endtag[k++] = (char)c;
	    while (k < (sizeof(endtag) - 1))
	    {
		c = Input();
		if ((c == '/') || Is_SGML_tagchar(c)) /* then inside tag */
		    endtag[k++] = c;
		else if (c == '>')	/* reached end of tag, and this loop */
		{
		    endtag[k++] = c;
		    break;
		}
		else		/* no longer inside a tag: put back lookahead */
		{
		    if (!LEXEOF(c))
			unput(c);
		    break;
		}
	    }
	    endtag[k] = '\0';		/* terminate string */
	    if (c == '>')		/* found a complete tag */
	    {
		strcpy(normalized_endtag, endtag);
		normalize_tag(normalized_endtag);
		if (endtag[1] == '/')
		{
		    if (strcmp(verbatim_endtag,normalized_endtag) == 0)
		    {			/* found matching end tag */
			if (strcmp("</PLAINTEXT>",normalized_endtag) == 0)
			    warning("</PLAINTEXT> is treated as ordinary text: PLAINTEXT environment continues to end-of-file");
			else
			{
			    end_verbatim(normalized_endtag);
			    return;
			}
		    }
		}
	    }
	    /* No matching tag, so just output our lookahead */
	    out_verbatim_string(endtag);
	}
	else
	    out_verbatim_char(c);
    }
}


static void
count_lines(VOID_ARG)
{
    register const char *p;

    for (p = (const char*)&yytext[0]; *p ; ++p)
    {
	if (*p == '\n')
	    line_number++;
    }
}


#if STDC
static void
delete_backwards(int offset)
#else
static void
delete_backwards(offset)
int offset;
#endif
{   /* Delete backwards up to and including the character which is offset
       characters backwards (offset <= 0) from the last character written. */
    int next_free_position;

    /* NB: This function maintains the invariants documented in dputc()! */

    next_free_position = big_next_position - 1 + offset;

    if (next_free_position <= big_last_verbatim_position) /* big_buffer[0..big_last_verbatim_position] frozen */
	next_free_position = big_last_verbatim_position + 1;

    if ( (0 <= next_free_position) && (next_free_position < big_next_position) )
    {				/* then safely inside in-use area of big_buffer[] */
	big_next_position = next_free_position;
	big_buffer[big_next_position] = '\0'; /* for DEBUGGING only */
	if (big_next_position <= big_newline_position)
	{				/* recompute newline position */
	    for (big_newline_position = big_next_position - 1;
		 ((big_newline_position >= 0) &&
		  (big_buffer[big_newline_position] != '\n'));
		 big_newline_position--)
		NOOP;
	}
    }
}


static void
delete_horizontal_spaces(VOID_ARG)
{			/* remove trailing horizontal space, but NOT newlines, */
			/* back to current indentation */
    trim_line(indentation_size());
}


static void
delete_trailing_spaces(VOID_ARG)
{			/* remove trailing spaces, INCLUDING newlines */
    int c;

    for ( ; ((c = last_char(0), c) != EOF) && isspace(c); )
	delete_backwards(0);
}


static void
do_begin_body(VOID_ARG)
{
    do_begin_head();
    do_end_head();
    if (body_count == 0)
    {
	if (!brief_format)
	    out_begin_tag("<BODY>");
	body_count++;
	body_level++;
    }
}


static void
do_begin_head(VOID_ARG)
{
    do_begin_html();
    if (head_count == 0)
    {
	if (!brief_format)
	    out_begin_tag("<HEAD>");
	head_count++;
	head_level++;
    }
}


static void
do_begin_html(VOID_ARG)
{
    do_doctype();
    if (html_count == 0)
    {
	if (!brief_format)
	    out_begin_tag("<HTML>");
	html_count++;
	html_level++;
	main_level = level;
    }
}


#if STDC
static void
do_catalog_file(const char *catalog, const char *grammar)
#else
static void
do_catalog_file(catalog,grammar)
const char *catalog;
const char *grammar;
#endif
{
    FILE	*fp;
    char	level_list[MAXBUF];

    level_list[0] = '\0';		/* initialize to empty */

    if (catalog == (const char *)NULL)	/* then use default CATALOG_FILE */
    {
	const char *catpath;
	const char *libpath;

	/* If executable is /usr/local/bin/html-pretty, then expect to
	find catalog in /usr/local/bin/../lib/html-pretty/catalog,
	or more precisely /usr/local/<CATALOG_PATH><CATALOG_FILE>. */
	catpath = concat(CATALOG_PATH,program_name());
	libpath = concat(parent_of(systemdir()),catpath);
	FREE(catpath);
	catalog = makefilename("", libpath, DEFAULT_PATHSEP,
			       "", CATALOG_FILE, "", "");
	FREE(libpath);
    }
    fp = tfopen(catalog,"r");
    if (fp == (FILE*)NULL)
    {
#undef MSG_FMT
#define MSG_FMT "could not open style catalog file [%.2047s]"
	char tempmsg[sizeof(MSG_FMT) + 2047 + 1];

	SPRINTF(tempmsg, MSG_FMT, catalog);
	error(tempmsg);
    }
    else				/* open was successful */
    {
	int		done;
	char		line[MAXBUF+2];		/* space for two trailing NULs */
	const char	*path;
	int		style_line_number;

	done = 0;
	path = path_of(catalog);
	style_line_number = 0;

	while (!done && (fgets(line, sizeof(line), fp) != (char*)NULL))
	{
	    style_line_number++;
	    if (do_catalog_line(catalog, style_line_number, line, path,
				level_list, sizeof(level_list)))
		done = 1;
	}

	if (!done)
	{
#undef MSG_FMT
#define MSG_FMT "could not find grammar level [%.39s] in catalog file [%.2047s]:\n\tlevels available: %.255s"
	    char tempmsg[sizeof(MSG_FMT) + 39 + 2047 + 255 + 1];

	    SPRINTF(tempmsg, MSG_FMT, grammar, catalog, level_list);
	    error(tempmsg);
	}

	(void)fclose(fp);
    }
}


#if STDC
static int
do_catalog_line(const char *source, int style_line_number, char *line,
		const char *path, char *level_list, size_t level_list_size)
#else
static int
do_catalog_line(source, style_line_number, line, path, level_list,
		level_list_size)
const char	*source;
int		style_line_number;
char		*line;			/* NB: overwritten on return */
const char	*path;
char		*level_list;		/* NB: appended on return */
size_t		level_list_size;
#endif
{	/* Process a catalog line of the form "level: filename % comment"
	and if the level matches grammar_level, prefix path to the filename
	and call do_style_file().  Return 1 if a match was found, and 0
	otherwise. */
    char	*filename;
    char	*level_name;

    level_name = strtok(strip_comment(line),WHITESPACE);
    if ((level_name != (char*)NULL) &&
	((strlen(level_list) + 1 + strlen(level_name)) < level_list_size))
    {
	/* Standard C says this is undefined because of overlap:
	   SPRINTF(level_list,"%s %s",level_list,level_name); */
      (void)strcat(strcat(level_list," "),level_name);
    }
    if ((level_name != (char*)NULL) && (stricmp(grammar_level,level_name) == 0))
    {					/* this is the line we want */
	filename = strtok((char*)NULL,WHITESPACE);
	if (filename == (char*)NULL)
	{
#undef MSG_FMT
#define MSG_FMT "expected filename on line %d of catalog file [%.2047s]"
	    char tempmsg[sizeof(MSG_FMT) + 2047 + 21 + 1];

	    SPRINTF(tempmsg, MSG_FMT, style_line_number, source);
	    error(tempmsg);
	}
	do_style_file(makefilename("", path, DEFAULT_PATHSEP,
				"", filename, "", ""), 1);
	return (1);
    }
    return (0);
}


static void
do_doctype(VOID_ARG)
{
    end_paragraph();
    if (doctype_count == 0)
    {
	const char *p;

#undef MSG_FMT
#define MSG_FMT "<!DOCTYPE HTML PUBLIC %.2047s>"
	char tempmsg[sizeof(MSG_FMT) + 2047 + 1];

	p = get_name_by_style("public");
	SPRINTF(tempmsg, MSG_FMT, (p == (char*)NULL) ? DEFAULT_DOCTYPE : p);
	out_doctype(tempmsg,1);
    }
}


static void
do_end_body(VOID_ARG)
{
    if (body_level > 0)
    {
	end_paragraph();
	if (!brief_format)
	    out_end_tag("</BODY>");
	body_level--;
    }
}


static void
do_end_head(VOID_ARG)
{
    if (head_level > 0)
    {
	end_paragraph();
	do_title();
	if (title_level > 0)
	{
	    title_level--;
	    out_tag_on_own_line("<!-- Please supply a descriptive title here -->");
	    out_end_tag("</TITLE>");
	}
	do_link();
	if (!brief_format)
	    out_end_tag("</HEAD>");
	head_level--;
    }
}


static void
do_end_html(VOID_ARG)
{
    do_begin_body();
    do_end_body();
    if (html_level > 0)
    {
	if (!brief_format)
	    out_end_tag("</HTML>");
	html_level--;
    }
}


static void
do_initialization_files(VOID_ARG)
{
    if (!read_stylefiles_flag)	/* then suppress initialization files */
	return;

    /* Try to read three initialization files: one in the system
       directory where this executable was found, one in the home
       directory, and the other in the current directory.  None of them
       need exist. */

    do_style_file(makefilename("", systemdir(),  DEFAULT_PATHSEP,
			       DEFAULT_PREFIX, DEFAULT_BASENAME,
			       DEFAULT_SUFFIX, DEFAULT_PATHSUFFIX), 0);

    do_style_file(makefilename("", DEFAULT_HOME, DEFAULT_PATHSEP,
			       DEFAULT_PREFIX, DEFAULT_BASENAME,
			       DEFAULT_SUFFIX, DEFAULT_PATHSUFFIX), 0);

    do_style_file(makefilename(DEFAULT_DRIVE, DEFAULT_PATH, DEFAULT_PATHSEP,
			       DEFAULT_PREFIX, DEFAULT_BASENAME,
			       DEFAULT_SUFFIX, DEFAULT_PATHSUFFIX), 0);
}


static void
do_link(VOID_ARG)
{
    if (link_count == 0)
    {
	if (!brief_format)
	{
	    const char *email;
#undef MSG_FMT
#define MSG_FMT "<LINK REV=\"made\" HREF=\"mailto:%.295s\">"
	    char tempmsg[sizeof(MSG_FMT) + 39 + 1 + 255 + 1];

	    email = (user_email == (const char*)NULL) ? email_address() : user_email;

	    SPRINTF(tempmsg, MSG_FMT,
		    (email == (const char*)NULL) ? "USERNAME@HOSTNAME" : email);
	    out_tag_on_own_line(
		"<!-- Please supply a correct e-mail address here -->");
	    out_tag_on_own_line(tempmsg);
	}
	link_count++;
    }
}


static void
do_tag(VOID_ARG)
{
    const char *tag_name;

    tag_name = tagname((const char*)&yytext[0]);

    if (Is_Begin_Tag(yytext))
    {
	check_tag_nesting(tag_name);
	if (!has_SGML_content_EMPTY(tag_name))
	    push_tag_nest(tag_name);
    }
    else if (Is_End_Tag(yytext))
    {
	check_for_forbidden_end_tag(tag_name);
	if (!has_SGML_content_EMPTY(tag_name))
	    pop_tag_nest(tag_name);
    }

    check_anchor_level((const char*)&yytext[0]);
    call_action_by_name(tag_name);
    if ((anchor_level == 0) && new_paragraph_pending)
    {		/* new paragraph after <A ...><Hn>...</Hn></A> */
	new_paragraph();
	new_paragraph_pending = 0;
    }
}


#if defined(TAG_CACHE)
#if STDC
static void
do_tag_2(StyleFunction *action)
#else
static void
do_tag_2(action)
StyleFunction *action;
#endif
{
    const char *tag_name;

    tag_name = tagname((const char*)&yytext[0]);

    if (Is_Begin_Tag(yytext))
    {
	check_tag_nesting(tag_name);
	if (!has_SGML_content_EMPTY(tag_name))
	    push_tag_nest(tag_name);
    }
    else if (Is_End_Tag(yytext))
    {
	check_for_forbidden_end_tag(tag_name);
	if (!has_SGML_content_EMPTY(tag_name))
	    pop_tag_nest(tag_name);
    }

    check_anchor_level((const char*)&yytext[0]);
    (*action)();
    if ((anchor_level == 0) && new_paragraph_pending)
    {		/* new paragraph after <A ...><Hn>...</Hn></A> */
	new_paragraph();
	new_paragraph_pending = 0;
    }
}
#endif /* defined(TAG_CACHE) */


static void
do_title(VOID_ARG)
{
    if (title_count == 0)
    {
	if (!brief_format)
	{
	    out_begin_tag("<TITLE>");
	    out_tag_on_own_line("<!-- Please supply a descriptive title here -->");
	    out_end_tag("</TITLE>");
	}
	title_count++;
    }
}


void
doctype(VOID_ARG)
{
    if (doctype_count > 0)
	warning("illegal extra <!DOCTYPE...> declaration");
    out_doctype((const char*)&yytext[0],0);
}


#if STDC
INLINE static void
dputc(int c)
#else
INLINE static void
dputc(c)
int c;
#endif
{
   /********************************************************************
     This is the key low-level output routine: EVERY output character
     goes through this function, and big_newline_position is maintained
     in order to support efficient line_length() computation.

     Buffer handling is complicated, because characters can be deleted
     by delete_backwards(), as well as added by dputc(), and the buffer
     contents can be examined by last_char(), which requires substantial
     lookback in order to be able to support trimming of white space
     (including newlines), and empty-paragraph elimination.

     These are the critical invariants maintained by this function:

     (1) (0 <= big_next_position) && (big_next_position <= sizeof(big_buffer))

     (2) if (big_next_position >= sizeof(big_buffer)), then part of
     	 big_buffer[] must be irrevocably output before more data can be
     	 added.

     (2) big_buffer[0..big_next_position-1] holds buffered data for
         future output, and thus, big_next_position is the number of
     	 buffered characters

     (3) (-1 <= big_newline_position) &&
	 (big_newline_position < big_next_position) &&
         ((big_newline_position >= 0) ?
	 	(big_buffer[big_newline_position] == '\n') : 1)

     (4) (-1 <= big_last_verbatim_position) &&
	 (big_last_verbatim_position < big_next_position)

     (5) Once big_buffer[] is at least half full, it remains
         that way until the final call to flush_buffer() in wrapup(),
	 so that substantial lookback is always available.

   ********************************************************************/

    if (big_next_position >= (int)sizeof(big_buffer))
    {					/* buffer full: write first half of buffer */
	char HUGE * rest;
	int	save_big_next_position;
	size_t	size_of_rest;

	save_big_next_position = big_next_position;
	big_next_position /= 2;		/* position halfway into big_buffer[] */

#if MAXBIGBUF >= 2048			/* should always be true, but be safe! */
	big_next_position &= ~1023;	/* round down to multiple of 1024 bytes */
					/* for fwrite() and memcpy() efficiency */
#endif

	big_last_verbatim_position -= big_next_position;
	if (big_last_verbatim_position < (-1))
     	    big_last_verbatim_position = -1; /* NB: critical for last_char()! */

     	big_newline_position -= big_next_position;
	if (big_newline_position < (-1))
     	    big_newline_position = -1;

	/* NB: flush_buffer() resets big_next_position, so we need to precompute */
        /* the size and position of the remaining data in big_buffer[], and */
	/* update the fencepost position, and the newline position */

	rest = &big_buffer[big_next_position];
	size_of_rest = (size_t)(save_big_next_position - big_next_position);

	flush_buffer();

	(void)memcpy((VOIDP)&big_buffer[0], (VOIDP)rest, size_of_rest);
		/* NB: always safe: no overlap of source and destination possible */

	big_next_position = (int)size_of_rest;
    }
    if (c == '\n')
	big_newline_position = big_next_position;
    big_buffer[big_next_position++] = c;
}


static int
empty_paragraph(VOID_ARG)
{			/* return 1 if buffered output ends in empty paragraph */
    /* When </P> is the next tag to be output (but not yet output), scan
       backwards in the internal output buffers to see if we have an
       empty paragraph, and if so, delete back to the beginning of the
       line on which <P> occurs, and return 1, indicating that the
       paragraph would be empty, if it were generated. */

    int c;
    int k;

    for (k = 0; ((c = last_char(k), c) != EOF) && isspace(c); --k)
	NOOP;	/* find last buffered non-space at offset k (backwards) */

    if ((c != EOF) &&
	(last_char(k-2) == '<') &&
	(last_char(k-1) == 'P') &&
	(last_char(k-0) == '>'))
    {
	delete_backwards(k-2);
	return (1);
    }
    else
	return (0);
}


static void
end_font(VOID_ARG)
{
    no_space_before();
    space_after();
}


static void
end_list(VOID_ARG)
{
    end_paragraph();
    if (list_level > 0)
    {
	if (item_level[list_level] > 0)
	    end_list_item(item_end_tag[list_level]);
	item_end_tag[list_level] = "";
	item_level[list_level] = 0;
	list_level--;
    }
    adjust_level(-1);
    newline_around();
}


static void
end_list_header(VOID_ARG)
{
    if (!paragraph_contains((const char*)&yytext[1]))
	end_paragraph();
    newline_around();
    adjust_level(1);
}


#if STDC
static void
end_list_item(const char *tag)
#else
static void
end_list_item(tag)
const char *tag;
#endif
{
    if (!paragraph_contains((const char*)&yytext[1]))
	end_paragraph();
    adjust_level(-1);
    normalize_tag((char*)&yytext[0]);
    out_tag_on_own_line(tag);
    item_level[list_level]--;
    adjust_level(1);
}


static void
end_math(VOID_ARG)
{
    space_after();
}


static void
end_pair(VOID_ARG)
{
    if (!paragraph_contains((const char*)&yytext[1]))
	end_paragraph();
    newline_around();
}


static void
end_paragraph(VOID_ARG)
{
    if (paragraph_level > 0)
    {
	if (level == paragraph_level)
	{
	    adjust_level(-1);
	    if (!empty_paragraph())
		out_tag_on_own_line("</P>");
	    paragraph_level = 0;
	}
	else
	    warning("unclosed previous paragraph");
    }
}


#if STDC
static void
end_verbatim(const char *tag)
#else
static void
end_verbatim(tag)
const char *tag;
#endif
{
    pop_tag_nest(tagname(tag));

    big_last_verbatim_position = -1;	/* must override, so we can trim leading space */

    trim_line(0);
    if (line_length() > 0)
	out_newline();
    trim_line(0);		/* want <VERBATIM> and </VERBATIM> on newline */
    out_verbatim_string(tag);
    out_newline();
}


#if STDC
static void
error(const char *msg)
#else
static void
error(msg)
const char *msg;
#endif
{
    quiet_flag = 0;			/* error messages cannot be suppressed */
    warning(msg);
    do_banner = 0;			/* prevent any boilerplate */
    brief_format = 1;			/* generation by wrapup() */
    wrapup();
    exit (EXIT_FAILURE);
}


#if STDC
static void
expect_level(int the_level) /* the_level == expected level OUTSIDE <x>..</x> */
#else
static void
expect_level(the_level)
int the_level;
#endif
{
#undef MSG_FMT
#define MSG_FMT "<%.255s at level %d should be at level %d"
    char tempmsg[sizeof(MSG_FMT) + 255 + 21 + 21 + 1];

    if ( (Is_End_Tag(yytext) && (level != the_level)) ||
	(Is_Begin_Tag(yytext) && ((level - 1) != the_level)) )
    {
	/* yytext[0] has been set to '\0' already: supply the original '<' */
	SPRINTF(tempmsg, MSG_FMT, (char*)&yytext[1],
		Is_End_Tag(yytext) ? level : (level - 1), the_level);
	warning(tempmsg);
    }
}


void
flush_buffer(VOID_ARG)
{
    if (big_next_position > 0)
    {
	(void)fwrite(big_buffer, (size_t)big_next_position, (size_t)1, stdout);
	big_next_position = 0;
    }
}


void
font(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_font();
    else
	end_font();
}


#if STDC
static int
has_SGML_content_EMPTY(const char *tag_name)
#else
static int
has_SGML_content_EMPTY(tag_name)
const char *tag_name;
#endif
{
    const char *style_class;

    style_class = get_class_by_name(tag_name);

    if (style_class == (const char*)NULL) /* optimization */
	return (0);
    else if ((*style_class != 'd') &&	/* optimization with fast match of */
	     (*style_class != 'l') &&	/* initial letters of strings below */
	     (*style_class != 'm') &&
	     (*style_class != 'p') &&
	     (*style_class != 's'))
	return (0);
    else
	return ((strcmp(style_class,"doctype") == 0) ||
		(strcmp(style_class,"line-break") == 0) ||
		(strcmp(style_class,"math") == 0) ||
		(strcmp(style_class,"plaintext") == 0) ||
		(strcmp(style_class,"short") == 0) ||
		(strcmp(style_class,"standalone") == 0) ||
		(strcmp(style_class,"standalone-nocheck") == 0));
}


void
head(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
    {
	do_begin_html();
	if (head_count > 0)
	    warning("illegal extra <HEAD> tag");
	head_count++;
	head_level++;
    }
    else
    {
	do_title();
	if (Is_End_Tag(yytext))
	    do_link();
	head_level--;
    }
    pair_nocheck();
    expect_level(1);
    main_level = level;
}


void
hn(VOID_ARG)
{
    int is_begin_tag;

    maybe_begin_body();
    do_begin_body();
    is_begin_tag = Is_Begin_Tag(yytext);
    if (is_begin_tag)
	end_paragraph();
    pair();
    expect_level(main_level);

    if (is_begin_tag && (anchor_level > 0))
	warning("obsolete order: put anchor environment inside header environment, instead of the reverse");

    /* The HTML grammar permits header environments inside anchors,
       but it is better to put the anchor inside the header, so that
       we can provide a new paragraph immmediately following the
       header environment. */

    if ((anchor_level == 0) && !is_begin_tag) /* if not in anchor environment, */
	new_paragraph();		/* then start new paragraph after end of header */
    else if ((anchor_level > 0) && !is_begin_tag)
	new_paragraph_pending = 1;	/* start new paragraph when anchor_level == 0 */
}


void
html(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
    {
	if (html_count > 0)
	    warning("illegal extra <HTML> tag");
	html_count++;
	html_level++;
    }
    else
    {
	if (body_count == 0)
	{
	    do_begin_body();
	    do_end_body();
	}
	html_level--;
    }
    do_doctype();
    if (Is_Begin_Tag(yytext) && !brief_format)
	out_newline();	/* want blank line between <!DOCTYPE...> and <HTML> */
    pair_nocheck();
    expect_level(0);
    main_level = level;
}


void
html_link(VOID_ARG)
{
    link_count++;
    standalone_nocheck();
}


INLINE static int
indentation_size(VOID_ARG)
{
    int n;

    n = indent * level;

    /* Ensure that a reasonable amount of space is left on each line, even */
    /* if the indentation level gets large.   Without this cap, out_char() */
    /* can produce an infinite loop(): out_char() -> out_leading_blanks() */
    /* out_blank() -> out_char(). */

    if (n > (max_width - 16))
	n = (max_width - 16);
    if (n < 0)
	n = 0;
    return (n);
}


void
inline_tag(VOID_ARG)
{
    maybe_begin_body();
    normalize_tag((char*)&yytext[0]);
    out_yytext();
}


#if STDC
INLINE static int
last_char(int offset)
#else
static int
INLINE last_char(offset)
int offset;
#endif
{ /* Return the (unsigned) character which is offset characters from the
     last character written, or EOF if not in buffer, or not after the
     last verbatim character written.  Thus, last_char(0) is the last
     one written, last_char(-1) is the second last, and so on.  Negative
     offsets are backwards, positive offsets forwards (and thus,
     positive offsets are meaningless). */

    register int looking_at;

    looking_at = big_next_position - 1 + offset;

    if ( (big_last_verbatim_position < looking_at) &&
	 (looking_at < big_next_position) )
	return ((int)((unsigned char)big_buffer[looking_at]));
    else
	return (EOF);
}


void
line_break(VOID_ARG)
{
    maybe_begin_body();
    no_space_before();
    newline_after();
    adjust_level(-1);
}


static void
line_end(VOID_ARG)
{
    int c;
    int original_line_number;

    /* One or more consecutive empty lines mark a paragraph boundary, */
    /* whereas a single newline is just replaced by a space. */

    original_line_number = line_number;

    for (c = '\n'; !LEXEOF(c) && isspace(c); c = Input())
    {					/* gobble all following whitespace */
	if (c == '\n')
	    line_number++;
    }
    if (!LEXEOF(c))
	unput(c);			/* put back non-space lookahead */
    if (line_number > (original_line_number + 1))
    {					/* have paragraph break */
	trim_line(0);
	if (line_length() > 0)
	    out_newline();		/* two or more newlines mark a */
	out_newline();			/* paragraph boundary */
    }
    else				/* have simple line break */
    {
	delete_horizontal_spaces();	/* discard unneeded space and */
	out_blank();			/* replace line break by one space */
    }
}


void
list(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_list();
    else
	end_list();
}


void
list_header(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_list_header();
    else
	end_list_header();
}


void
list_item(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_list_item();
    else
	end_list_item((const char*)&yytext[0]);
}


void
markup_declaration(VOID_ARG)
{
    standalone_nocheck();
}


void
math(VOID_ARG)
{
    short_tag();
}


void
math_pair(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_math();
    else
	end_math();
}


static void
multiline_end(VOID_ARG)
{
    /* yytext[] contains two or more empty lines.  Such vertical space
       has no significance in HTML, which requires explicit <P> tags to
       markup paragraphs.  However, the user may have written multiple
       newlines for readability, or out of sloppiness, or may have
       incorrectly expected a paragraph break, so we offer a warning
       option.

       If warnings were requested, we reduce yytext[] to two consecutive
       newlines, which will leave space for manual insertion of <P> tags
       if the user wishes.  Otherwise, we change yytext[] to a single
       newline, which might be further reduced to a space. */

    delete_trailing_spaces();
    if (blank_line_warning)	/* then preserve single line break as verbatim text */
    {
	warning("blank lines are not paragraph breaks in HTML");
	out_verbatim_string("\n\n");
    }
    else				/* output line break as trimable newline  */
	out_char('\n');
    yytext[0] = '\0';			/* indicate yytext[] has been output */
}


static void
new_paragraph(VOID_ARG)
{
#undef P_TAG
#define P_TAG "<P>"
    char save_yytext[sizeof(P_TAG)];

    /* We need to save and restore yytext[] here, since
       this function is called as a side effect of processing
       other HTML tags which are already in yytext[]. */

    (void)memcpy((char*)&save_yytext[0],(const char*)&yytext[0],sizeof(save_yytext));
    (void)strcpy((char*)&yytext[0],P_TAG);
    paragraph();
    (void)memcpy((char*)&yytext[0],(const char*)&save_yytext[0],sizeof(save_yytext));
#undef P_TAG
}


static void
newline_after(VOID_ARG)
{
    int is_begin_tag;

    is_begin_tag = Is_Begin_Tag(yytext);
    if (Is_End_Tag(yytext))		/* then have end tag: </TAG> */
	adjust_level(-1);
    out_yytext();
    if (is_begin_tag)			/* then have begin tag: <TAG> */
	adjust_level(1);
    out_newline();
}


static void
newline_around(VOID_ARG)
{
    int is_begin_tag;

    is_begin_tag = Is_Begin_Tag(yytext);
    if (Is_End_Tag(yytext))
	adjust_level(-1);
    delete_horizontal_spaces();
    if (Is_NonEmpty_Line())		/* then put this tag on new line */
	out_newline();
    out_yytext();
    if (is_begin_tag)
	adjust_level(1);
    out_newline();
}


static void
no_space_before(VOID_ARG)
{
    delete_horizontal_spaces();
    out_yytext();
}


#if STDC
INLINE static void
normalize_tag(char *tag)
#else
INLINE static void
normalize_tag(tag)
char *tag;
#endif
{		/* convert tag name and key names in tag[] to uppercase, */
		/* replace line breaks by spaces, and collapse adjacent */
		/* spaces to one space, overwriting the old contents */
		/* with the (possibly shorter) new contents */
    char *equals;
    char *p;
    char *q;

    if (tag[0] != '<')
	return;

    if (Is_Comment_or_Markup_Declaration(tag)) /* leave spacing in these untouched */
	return;

    p = (char*)&tag[1];
    if (*p == '/')
	++p;

    /* Convert tagname pattern "[A-Za-z]+" to uppercase */
    for ( ; *p && isalpha(*p) ; ++p)
    {
	if (islower(*p))
	    *p = toupper(*p);
    }

    /* Convert key name patterns "[A-Za-z]+=" to uppercase */
    while ((p != (char*)NULL) && ((equals = strchr(p,(int)'=')) != (char*)NULL))
    {
	for (p = equals - 1; isalpha(*p); --p)
	{
	    if (islower(*p))
		*p = toupper(*p);
	}
	/* Try to scan past ="value" or ='value' in case the */
	/* value contains an equals.  However, some HTML/SGML markup */
	/* omits quotes around values, so in such a case, we just */
	/* scan for the next equals. */
	p = equals + 1;
	if ( (*p == '\"') || (*p == '\'') )
	    p = strchr(p+1,(int)*p); /* advance to matching delimiter */
    }

    /* Collapse runs of whitespace to single blanks */
    for (p = q = (char*)&tag[0]; *q; ++p, ++q)
    {
	if (isspace(*q))
	{
	    while (*q && isspace(*q))	/* scan over run of spaces */
		++q;
	    if (*q == '\0')
		break;
	    *p++ = ' ';			/* and replace by a single blank */
	}
	*p = *q;
    }
    *p = '\0';				/* supply string terminator */
}


void
other_tag(VOID_ARG)
{
    /* Unrecognized tags are normalized and output without indentation */
    /* change, but may force a paragraph end. */

    if (unknown_tag_warning)
    {
#undef MSG_FMT
#define MSG_FMT "unknown HTML tag [%.255s]"
	char tempmsg[sizeof(MSG_FMT) + 255 + 1];

	SPRINTF(tempmsg, MSG_FMT, yytext);
	warning(tempmsg);
    }

    maybe_begin_body();
    normalize_tag((char*)&yytext[0]);
    if (Is_Begin_Tag(yytext))
    {
	if (!paragraph_contains((const char*)&yytext[0]))
	    end_paragraph();
    }
    else
    {
	if (!paragraph_contains((const char*)&yytext[1]))
	    end_paragraph();
    }
    out_yytext();
}


static void
out_banner(VOID_ARG)
{
    long	the_timeval;
    char	timestr[27];

    out_string(COMMENT_PREFIX);
    out_string("-*-html-*-");
    out_string(COMMENT_SUFFIX);
    out_newline();

    if (comment_banner_filename && *comment_banner_filename)
    {
	out_string(COMMENT_PREFIX);
	out_string(comment_banner_filename);
	out_string(COMMENT_SUFFIX);
	out_newline();
    }
    else if (input_filename && *input_filename)
    {
	out_string(COMMENT_PREFIX);
	out_string(input_filename);
	out_string(COMMENT_SUFFIX);
	out_newline();
    }

    out_string(COMMENT_PREFIX);
    out_string("Prettyprinted by ");
    out_string(PROGRAM);

#if defined(FLEX_SCANNER)
    out_string(" flex version ");
#else
    out_string(" lex version ");
#endif

    out_string(VERSION);
    out_string(" ");
    out_string(DATE);
    out_string(COMMENT_SUFFIX);
    out_newline();

    the_timeval = time((time_t *)NULL);
    (void)strcpy(timestr,ctime((const time_t*)(&the_timeval)));
    timestr[24] = '\0';			/* kill \n from ctime() */

    out_string(COMMENT_PREFIX);
    out_string("on ");
    out_string(timestr);
    out_string(COMMENT_SUFFIX);
    out_newline();

    out_string(COMMENT_PREFIX);
    out_string("for ");
    out_string((user_personal_name == (const char*)NULL) ? personal_name() : user_personal_name);
    out_string(" (");			/* avoid <email_address> to avoid */
    out_string((user_email == (const char*)NULL) ? email_address() : user_email);
					/* confusing browsers that have */
    out_string(")");			/* defective comment parsing */
    out_string(COMMENT_SUFFIX);
    out_newline();

    out_newline();			/* supply one blank line after banner */
}


#if STDC
static void
out_begin_tag(const char *s)
#else
static void
out_begin_tag(s)
const char *s;
#endif
{
    out_tag_on_own_line(s);
    adjust_level(1);
}


INLINE static void
out_blank(VOID_ARG)
{			/* output a blank, except at beginning of line */
    if (Is_NonEmpty_Line()) /* then not at start of line, */
	out_char((int)' ');
}


#if STDC
INLINE static void
out_char(int c)
#else
INLINE static void
out_char(c)
int c;
#endif
{    /* All non-verbatim mode output goes through this function, which
	handles line wrapping of long lines at spaces */

    if ((line_length() >= max_width) && isspace(c))
	c = '\n';			/* break long line here */

    if (c == '\n')		/* trim trailing space at end-of-line */
    {
	trim_line(0);

#if defined(IBM_PC)
	/***************************************************************
	  On the IBM PC, we handle input and output in binary mode, and
	  input \r (Ctl-M) gets mapped to blank by lex, except in
	  verbatim mode.  Thus, on output, we need to map \n (Ctl-J)
	  back to \r\n to match DOS conventions.  This routine is never
	  called from copy_verbatim(), so there is no risk of getting
	  \r\r\n output from \r\n in verbatim mode.
	***************************************************************/
     	dputc('\r');
#endif

    }

    dputc(c);
#if 0
    if (c == '\n')
	out_indentation();
#endif
}


#if STDC
static void
out_doctype(const char *s,int default_doctype)
#else
static void
out_doctype(s,default_doctype)
const char *s;
int default_doctype;
#endif
{
    if (level > 0)
	warning("<!DOCTYPE...> not at level 0");
    doctype_count++;
    if (!brief_format || !default_doctype)
    {
	if (last_char(0) == '\n')
	    out_newline(); /* blank line between comments and <!DOCTYPE...> */
	out_string(quote_check(s));
	out_newline();
    }
}


#if STDC
static void
out_end_tag(const char *s)
#else
static void
out_end_tag(s)
const char *s;
#endif
{
    adjust_level(-1);
    out_tag_on_own_line(s);
}


#if STDC
static void
out_escape(const char *s)
#else
static void
out_escape(s)
const char *s;
#endif
{
    maybe_begin_body();
    out_string(s);
}


static void
out_indentation(VOID_ARG)
{
    out_leading_blanks(indentation_size());
}


#if STDC
static void
out_leading_blanks(int nblanks)
#else
static void
out_leading_blanks(nblanks)
int nblanks;
#endif
{

#if defined(DEBUG)
    SPRINTF(prefix, "%02d:", level);	/* for DEBUGGING */
#endif

    for ( ; nblanks > 0; --nblanks)
	out_char((int)' ');		/* NB: must NOT be out_blank() */
					/* because that function suppresses */
					/* blanks at start of line */
}


static void
out_nbsp(VOID_ARG)
{
    break_suppress = 2;	/* cannot break before or after "&nbsp;" entity! */
    out_word();
}


#if STDC
INLINE static void
out_string(const char *s)
#else
INLINE static void
out_string(s)
const char *s;
#endif
{		/* output a string, line wrapping at spaces if necessary */
    const char *original_s;
    const char *p;

    if (s == (const char*)NULL)
	return;

    if (line_length() < indentation_size()) /* first token on this line */
    {
	trim_line(0);
	out_indentation();
    }
    if (line_length() == indentation_size())
    {
	for (p = s; *p == ' '; ++p)	/* does s match /^[ ]+$/ ? */
	    NOOP;
	if (*p == '\0')		/* yes, it does */
	    return;		/* discard blank string at beginning of line */
    }
    for (original_s = s ; *s ; ++s)
    {
	if ((s == original_s) || (*s == ' '))
	{			/* then possible place to wrap the line */
	    p = strchr(s+1,(int)' '); /* next wrap point is at next blank or */
	    if (p == (char*)NULL) /* else at end of string */
		p = strchr(s+1,(int)'\0');
	    /* The wrap decision is tricky: the second condition was added at
	       version 0.12 to prevent breaking when the continued text would
	       not be further indented than if it remained on the current line.
	       The commonest such case is <A HREF="very-long-URL">, where the
	       distance from the tag start to the HREF is less than the default
	       indent value. */
	    if (((line_length() + (int)(p - s)) > max_width) &&
		(line_length() > (indentation_size() + indent)) &&
		Is_NonEmpty_Line() && (break_suppress <= 0))
	    {			/* then line must be wrapped */
		out_newline();
		if (s > original_s)
		    adjust_level(1); /* indent wrapped lines one more level */
		out_indentation();
		if (s > original_s)
		    adjust_level(-1);
		if (*s == ' ')
		{
		    for (++s; *s && isspace(*s); ++s)
			NOOP;		/* skip over repeated spaces */
		    s--;		/* and point back to last space */
		    continue;
		}
	    }
	}
	out_char((int)*s);
    }
    if (break_suppress > 0)
	break_suppress--;
}


#if STDC
static void
out_tag_on_own_line(const char *tag)
#else
static void
out_tag_on_own_line(tag)
const char *tag;
#endif
{
    delete_horizontal_spaces();
    if (Is_NonEmpty_Line())		/* then put this tag on new line */
	out_newline();
    out_string(quote_check(tag));
    out_newline();
}


#if STDC
INLINE static void
out_verbatim_char(int c)
#else
INLINE static void
out_verbatim_char(c)
int c;
#endif
{
    (void)dputc(c);
    big_last_verbatim_position = big_next_position - 1;
					/* NB: must be recomputed after dputc()! */
}


#if STDC
INLINE static void
out_verbatim_string(const char *s)
#else
INLINE static void
out_verbatim_string(s)
const char *s;
#endif
{
    for (; *s; ++s)
	out_verbatim_char((int)*s);
}


static void
out_word(VOID_ARG)
{
    if (title_level == 0)
	maybe_begin_body();
    out_yytext();
}


INLINE void
out_yytext(VOID_ARG)
{
    if (yytext[0])
    {
	if (yytext[0] == '<')
	    normalize_tag((char*)&yytext[0]);

	if (Is_Comment_or_Markup_Declaration(yytext))
	    out_verbatim_string((char*)&yytext[0]);
	else
	    out_string((yytext[0] == '<') ?
		       quote_check((const char*)&yytext[0]) :
		       (const char*)&yytext[0]);

	yytext[0] = '\0';		      /* prevent duplicate output */

	/* Having just reset yytext[] to an empty string, it appears
	that we should set yyleng = 0, but that is NOT allowed with
	flex.  In its quest for speed, flex by default requires that
	yytext[] must not be extended, and yyleng must never be changed
	by the user, unless the -l option (lex compatibility) has been
	used.  From (flex.info)Deficiencies: ``Use of `unput()'
	invalidates yytext and yyleng, unless the `%array' directive or
	the `-l' option has been used.''.  From (flex.info)OPtions:
	``Use of this option costs a considerable amount of
	performance...''.  In the current version of htmlpty.l, yyleng
	is never referenced, so it does not matter that we never update
	it.  However, the presence of this comment serves as a reminder
	for future revisions! */
    }
}


void
pair(VOID_ARG)
{
    normalize_tag((char*)&yytext[0]);
    if (Is_Begin_Tag(yytext))
    {
	maybe_begin_body();
	begin_pair();
    }
    else
	end_pair();
}


static void
pair_nocheck(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_pair();
    else
	end_pair();
}


void
paragraph(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
	begin_paragraph();
    else
	end_paragraph();
}


static void
paragraph_break(VOID_ARG)
{
    if (convert_paragraph_breaks)
	new_paragraph();
    else
	multiline_end();
}


#if STDC
static int
paragraph_contains(const char *tag)
#else
static int
paragraph_contains(tag)
const char *tag;
#endif
{
    size_t k;
    static struct
    {
	const char	*name;
	size_t		length;
    } table[] =
    {

#define	ENTRY(s) { s, (sizeof(s) - 1) }

	ENTRY("#PCDATA"),	/* HTML 2.0 tags allowed inside paragraphs: */
	ENTRY("A"),		/* see manual page section HTML 2.0  */
	ENTRY("B"),		/* CONSTRAINTS: P contains: ... list. */
	ENTRY("BR"),
	ENTRY("CITE"),
	ENTRY("CODE"),
	ENTRY("DFN"),
	ENTRY("EM"),
	ENTRY("I"),
	ENTRY("IMG"),
	ENTRY("INPUT"),
	ENTRY("KBD"),
	ENTRY("SAMP"),
	ENTRY("STRONG"),
	ENTRY("TEXTAREA"),
	ENTRY("TT"),
	ENTRY("U"),
	ENTRY("VAR"),

	ENTRY("ACRONYM"),	/* HTML 4.0 */
	ENTRY("BASEFONT"),	/* HTML 4.0: Base font: later altered by <FONT...>...</FONT> */
	ENTRY("BIG"),		/* HTML 4.0: Big font */
	ENTRY("BLINK"),		/* Mosaic: Blinking text */
	ENTRY("BT"),		/* HTML 3.0: Bold Term */
	ENTRY("Q"),		/* HTML 3.0, 4.0: inline quote */
	ENTRY("S"),		/* HTML 4.0 (Deprecated): struck-through font */
	ENTRY("SMALL"),		/* HTML 4.0: small font */
	ENTRY("STRIKE"),	/* HTML 4.0 (Deprecated): struck-through font */
	ENTRY("T"),		/* HTML 3.0: Term */

	/* The remaining were generated by running a simple test with
	   the HTML4-loose.dtd grammar, using a merged list of the tags
	   from all available grammars, putting a single tag pair inside
	   a paragraph.  Unless html-ncheck raised errors, we assume the
	   tag may occur inside paragraphs.  However, there may have
	   been failures for other reasons, so this list is not
	   exhaustive.  The entries with comments generated errors, but
	   further examination indicates they are legal in
	   paragraphs. */

	ENTRY("APPLET"),	/* runtime execution of applet */
	ENTRY("BDO"),		/* HTML 4.0 (Cougar) i18n Bidirectional Override */
	ENTRY("BUTTON"),
	ENTRY("DEL"),
	ENTRY("FONT"),
	ENTRY("IFRAME"),
	ENTRY("INS"),
	ENTRY("LABEL"),		/* HTML 4.0 (Cougar) */
	ENTRY("OBJECT"),	/* HTML 4.0 (Cougar) */
	ENTRY("SCRIPT"),
	ENTRY("SPAN"),		/* HTML 4.0 (Cougar) */
	ENTRY("SUB"),
	ENTRY("SUP"),

	/* The remaining elements are taken from the paragraph-contains
	   list produced by mrgtable.awk in Entities/merged-table.tab;
	   this should make the list exhaustively complete! */

	ENTRY("ABBR"),		/* HTML 4.0 */
	ENTRY("ABBREV"),	/* HTML 3.0 */
	ENTRY("AU"),		/* HTML 3.0 */
	ENTRY("CENTER"),	/* HTML Mosaic/Netscape */
	ENTRY("LANG"),		/* HTML 3.0 */
	ENTRY("MAP"),		/* HTML 3.2 */
	ENTRY("MATH"),		/* HTML 3.0 */
	ENTRY("NOBR"),		/* HTML Mosaic/Netscape */
	ENTRY("PERSON"),	/* HTML 3.0 */
	ENTRY("SELECT"),	/* HTML 3.2 */
	ENTRY("STYLE"),		/* HTML 4.0 (Cougar) */
	ENTRY("TAB"),		/* HTML 3.0 */
	ENTRY("WBR"),		/* HTML Mosaic/Netscape */

	ENTRY("")
    };

    for (k = 0; table[k].length > 0; ++k)
    {
	if ((strncmp(tag+1,table[k].name,table[k].length) == 0) &&
	    ((tag[1+table[k].length] == '>') ||
	      isspace(tag[1+table[k].length])))
	    return (1);
    }
    return (0);
}


static const char*
peek_tag_nest_tagname(VOID_ARG)
{
    return ((tag_nest.top >= 1) ? tag_nest.nest[tag_nest.top-1].tag_name : (const char*)NULL);
}


static int
peek_tag_nest_line_number(VOID_ARG)
{
    return ((tag_nest.top >= 1) ? tag_nest.nest[tag_nest.top-1].tag_line_number : 0);
}


#if STDC
static void
pop_tag_nest(const char *tag)
#else
static void
pop_tag_nest(tag)
const char *tag;
#endif
{
    /* Pop tag_nest.nest[] down to, and including, the first matching begin
       tag.  A tag nest is somewhat like a stack, except that the pop
       operation always pops down to a matching tag.  This is
       necessary, because HTML allows omission of some closing tags,
       e.g. <UL> <LI>... <LI>... <LI>... </UL> instead of <UL>
       <LI>...</LI> <LI>...</LI> <LI>...</LI> </UL>.  The former would
       have a nest xxx UL LI LI LI when /UL was reached, while the
       latter would have a nest xxx UL.  In both cases, the pop
       operation should reduce the nest to xxx. */

    if ((tag_nest.top < 1) && (tag_nest.error == 0)) /* only one message on stack underflow */
    {
	tag_nest.error = 1;
	warning("tag nesting underflow: probable cause: excess end tags");
    }
    while (tag_nest.top >= 1)
    {
	int match_found;

	tag_nest.error = 0;		/* turn off error flag */
	--tag_nest.top;
	match_found = (strcmp(tag_nest.nest[tag_nest.top].tag_name,tag) == 0);
	FREE(tag_nest.nest[tag_nest.top].tag_name);
	tag_nest.nest[tag_nest.top].tag_name = (const char*)NULL;
	tag_nest.nest[tag_nest.top].tag_line_number = 0;
	if (match_found)
	    break;
    }
}


static void
print_tag_nest(VOID_ARG)
{
    if (tag_nest.top >= 1)
    {
#undef MSG_FMT
#define MSG_FMT "unclosed tags in tag nest: line:opentag ="
	char tempmsg[sizeof(MSG_FMT) + 2047 + 1]; /* NB: extra 2047 for list appended below */

#undef MSG_FMT2
#define MSG_FMT2 " %d:%.2047s"
	    char tempmsg2[sizeof(MSG_FMT2) + 21 + 2047 + 1];

	SPRINTF(tempmsg, MSG_FMT);

	while (tag_nest.top >= 1)
	{
	    SPRINTF(tempmsg2,MSG_FMT2,
		    peek_tag_nest_line_number(), peek_tag_nest_tagname());
	    strncat(tempmsg, tempmsg2, sizeof(tempmsg) - strlen(tempmsg));
	    pop_tag_nest(peek_tag_nest_tagname());
	}
	tempmsg[sizeof(tempmsg)-1] = '\0'; /* ensure string termination */

	warning(tempmsg);
    }
}


static void
punctuation(VOID_ARG)
{
    register int c;
    register int cm1;
    register int cm2;

    if (title_level == 0)
	maybe_begin_body();

    /*******************************************************************
      Discard space between tag and following punctuation, e.g.,
	<EM>html</EM>.
      and
	<A HREF="...">xyz</A>?
      However, if the tag was followed by a newline instead of space,
      restore the newline.  This ensures that we generate

	 <ABC>
	     xxx
	 </ABC>,
         yyy zzz

      instead of

	 <ABC>
	     xxx
	 </ABC>, yyy zzz
     ******************************************************************/

    /* Check for patterns: ">\r\n", ">\r", and ">\n", and if found,
       move the punctuation in yytext[] to immediately after the ">". */

    c = last_char(0);
    cm1 = last_char(-1);
    cm2 = last_char(-2);
    if (isspace(c) &&
	((cm1 == (int)'>') || (isspace(cm1) && (cm2 == (int)'>'))))
    {
	delete_trailing_spaces();
	out_yytext();
	if ((cm1 == (int)'\n') || (cm1 == (int)'\r'))
	    out_verbatim_char(cm1);		/* preserve any CR or LF */
	if ((c == (int)'\n') || (c == (int)'\r'))
	    out_verbatim_char(c);		/* preserve any CR or LF */
    }
    else
	out_yytext();
}


#if STDC
static void
push_tag_nest(const char *tag)
#else
static void
push_tag_nest(tag)
const char *tag;
#endif
{
    if (tag_nest.top < MAXTAGNEST)
    {
	tag_nest.error = 0;
	tag_nest.nest[tag_nest.top].tag_name = (const char*)dupstr(tag);
	tag_nest.nest[tag_nest.top].tag_line_number = line_number;
	tag_nest.top++;
    }
    else if (tag_nest.error == 0)	/* only one message in overflow state */
    {
#undef MSG_FMT
#define MSG_FMT "tag nesting reached limit of %lu levels"
	char tempmsg[sizeof(MSG_FMT) + 20 + 1];

	tag_nest.error = 1;
	SPRINTF(tempmsg, MSG_FMT, (unsigned long)MAXTAGNEST);
	warning(tempmsg);
    }
}


#if STDC
static const char *
quote_check(const char *tag)
#else
static const char *
quote_check(tag)
const char *tag;
#endif
{
    const char *		close_angle;
    register const char *	p;
    int 			quote_count;
    static char			tempbuf[MAXBUF];

    if (tag[0] != '<')
	return (tag);

    if (Is_Comment_or_Markup_Declaration(tag))	/* allow unbalanced quotes */
	return (tag);			/* (e.g. in filehdr text) */

    for (close_angle = (const char*)NULL, p = tag, quote_count = 0; *p; ++p)
    {			/* count quotation marks, and remember tag end */
	if (*p == '"')
	    quote_count++;
	else if (*p == '>')
	    close_angle = p;
    }

    if ((quote_count % 2) == 0)
	return (tag);			/* okay: even number of quotes */
    else if ((close_angle != (const char*)NULL) &&
	     (strlen(tag) < (sizeof(tempbuf) - 1)))
    {					/* error: supply fixup */
	(void)strcpy(tempbuf, tag);
	tempbuf[(int)(close_angle - tag)] = '"';
	(void)strcpy(&tempbuf[(int)(close_angle - tag) + 1], close_angle);
	warning("unbalanced quotes in tag repaired");
	return ((const char*)&tempbuf[0]);
    }
    else				/* error: no space for fixup */
    {
	warning("unbalanced quotes in tag -- NOT repaired");
	return (tag);
    }
}


void
plaintext(VOID_ARG)
{
    in_plaintext = 1;
    warning("<PLAINTEXT> is abberant HTML and is strongly deprecated; use <PRE>...</PRE> instead");
    verbatim();	/* NB: PLAINTEXT is handled specially inside verbatim processing */
}


INLINE static const char*
#if STDC
search(const char *s, const char *sub)
#else /* NOT STDC */
INLINE static const char*
search(s,sub)
const char  *s;
const char  *sub;
#endif /* STDC */
{
    /* This function is an equivalent of the non-standard C library
      routine, strstr(), but renamed to avoid a conflict with that
      function in system header files. */

    /*******************************************************************
      Return a pointer to the location of sub[] in s[], else (const
      char*)NULL.  This is a reasonably simple implementation, but
      because it is heavily used when -check-tag-nesting has been
      requested, we optimize it with inline code, avoid examining
      characters twice, and avoid unnecessary function calls.

      Preprocessor conditionals #if 0..#else..#endif preserve the slower
      equivalent code in the unused then branch for algorithmic clarity.

      A library version might use a more sophisticated version
      (e.g. Boyer-Moore, Knuth-Morris-Pratt, Sunday, or else a hardware
      search).
    *******************************************************************/

    size_t length;

    if (s == (const char*)NULL)		/* handle first special case */
	return ((const char*)NULL);

    if ((sub == (const char*)NULL) || (*sub == '\0')) /* second special case */
	return (s);			/* NULL substring always found at start */

    length = (size_t)strlen(sub);	/* length > 0 is now guaranteed  */

#if 0
    s = (const char*)strchr(s,sub);	/* find first character match */
#else
    for ( ; *s && (*s != *sub); ++s)    /* fast inline version */
	NOOP;
    if (*s == '\0')			/* then *sub was not found */
	s = (const char*)NULL;
#endif

    /* At this point, either *s == *sub, or else s == NULL */
    if (length == 1)			/* and maybe we are done */
	return (s);

    while (s != (const char*)NULL)
    {
	if (strncmp(s+1,sub+1,length-1) == 0) /* first characters already match */
	    return (s);
	++s;				/* no match, move right one character in s[] */
#if 0
        s = (const char*)strchr(s,*sub));
#else
	for ( ; *s && (*s != *sub); ++s) /* fast inline version */
	    NOOP;
	if (*s == '\0')			/* then *sub was not found */
	    s = (const char*)NULL;
#endif
    }
    return ((const char*)NULL);
}


void
short_tag(VOID_ARG)
{
    maybe_begin_body();
    out_yytext();
}


static void
space_after(VOID_ARG)
{
    out_yytext();
    out_blank();
}


static void
space_before(VOID_ARG)
{
    delete_horizontal_spaces();
    out_blank();
    out_yytext();
}


void
standalone(VOID_ARG)
{
    maybe_begin_body();
    standalone_nocheck();
}


void
standalone_nocheck(VOID_ARG)
{
    normalize_tag((char*)&yytext[0]);
    if (!paragraph_contains((const char*)&yytext[0]))
	end_paragraph();
    newline_around();
    adjust_level(-1);	/* negate level adjustment from newline_around()  */
}


#if STDC
static int
stricmp(const char *s1, const char *s2)
#else /* NOT STDC */
static int
stricmp(s1, s2)
const char *s1;
const char *s2;
#endif /* STDC */
{
#define TOUPPER(c) (islower(c) ? toupper(c) : (c))

    while ((*s1) && (TOUPPER(*s1) == TOUPPER(*s2)))
    {
	s1++;
	s2++;
    }
    return((int)(TOUPPER(*s1) - TOUPPER(*s2)));
#undef TOUPPER
}


#if STDC
static const char *
tagname(const char *tag)
#else
static const char *
tagname(tag)
const char *tag;
#endif
{			/* return uppercase SGML tag name from tag */
    register size_t	k;
    register const char	*p;
    static char		uc_tag[MAXTOKENLENGTH + 1];

    p = tag + 1;			/* ignore initial "<" */
    if (*p == '/')			/* and optional following "/" */
	++p;
    for (k = 0; (k < (sizeof(uc_tag) - 1)) && Is_SGML_tagchar(*p); ++k, ++p)
	uc_tag[k] = (islower(*p) ? toupper(*p) : *p);
    uc_tag[k] = '\0';
    return ((const char*)&uc_tag[0]);
}


void
title(VOID_ARG)
{
    if (Is_Begin_Tag(yytext))
    {
	do_begin_head();
	main_level = level;
	if (title_count > 0)
	    warning("illegal extra <TITLE> tag");
	title_count++;
	title_level++;
    }
    else
	title_level--;
    pair_nocheck();
    expect_level(main_level);
}


#if STDC
INLINE static void
trim_line(int n)
#else
INLINE static void
trim_line(n)
int n;
#endif
{
    /* Trim horizontal space on the current output line back to no
    more than n leading characters (which are usually whitespace). */
    register int c;
    register int current_column;

    current_column = line_length();
    if (current_column > n)		/* then we have some trimming to do */
    {
	for (; ((c = last_char(0),c) != EOF) && ((c == ' ') || (c == '\t')); )
	{
	    delete_backwards(0);
	    current_column--;
	    if (current_column <= n)
		break;
	}
    }
}


static void
usage(VOID_ARG)
{
    static int first = 1;

    if (first)
    {
	PUTSTDERR("Usage:\n\n");
	PUTSTDERR(PROGRAM);
	PUTSTDERR(" [-?] [-author] [-blank-line-warning] [-brief] [-catalogfile filename]\n");
	PUTSTDERR("\t[-check-tag-nesting] [-comment-banner] [-convert-paragraph-breaks]\n");
	PUTSTDERR("\t[-copyright] [-email-address user@host] [-extend-style style:tags]\n");
	PUTSTDERR("\t[-extend-style tag:tags] [-file filename] [-grammar-level level] [-help]\n");
	PUTSTDERR("\t[-indent nnn] [-keep-format] [-logfile filename]\n");
	PUTSTDERR("\t[-no-blank-line-warning] [-no-brief] [-no-check-tag-nesting]\n");
	PUTSTDERR("\t[-no-comment-banner] [-no-convert-paragraph-breaks] [-no-keep-format]\n");
	PUTSTDERR("\t[-no-print-stylefile] [-no-quiet] [-no-read-stylefiles]\n");
	PUTSTDERR("\t[-no-trace-opens] [-no-unknown-tag-warning] [-no-warnings-in-comments]\n");
	PUTSTDERR("\t[-outfile filename] [-personal-name] [-print-stylefile] [-quiet]\n");
	PUTSTDERR("\t[-read-stylefiles] [-stylefile filename] [-trace-opens]\n");
	PUTSTDERR("\t[-unknown-tag-warning] [-version] [-warnings-in-comments] [-width nnn]\n");
	PUTSTDERR("\t[< infile or file(s)] [> outfile]\n");

	PUTSTDERR("\nwhere the options are:\n\n");

	PUTSTDERR("-?                           : display usage summary and quit\n");
	PUTSTDERR("-author                      : show author credit and quit\n");
	PUTSTDERR("-blank-line-warning          : warn about blank lines\n");
	PUTSTDERR("-brief                       : omit standard !DOCTYPE, HTML, HEAD, BODY\n");
	PUTSTDERR("-catalogfile filename        : set style catalog filename\n");
	PUTSTDERR("-check-tag-nesting           : warn about tag nesting errors\n");
	PUTSTDERR("-comment-banner              : print comment banner\n");
	PUTSTDERR("-convert-paragraph-breaks    : convert text paragraph breaks to <P>\n");
	PUTSTDERR("-copyright                   : show copyright information and quit\n");
	PUTSTDERR("-email-address user@host     : set email address for banner\n");
	PUTSTDERR("-extend-style \"style : TAG TAG ...\" : extend style class with tags\n");
	PUTSTDERR("-extend-style \"TAG : TAG TAG ...\"   : extend style class of TAG with tags\n");
	PUTSTDERR("-file filename               : name output file in comment banner\n");
	PUTSTDERR("-grammar-level level         : select grammar level in style catalog\n");
	PUTSTDERR("-help                        : display usage summary and quit\n");
	PUTSTDERR("-indent nnn                  : set indentation to nnn spaces per level\n");
	PUTSTDERR("-keep-format                 : preserve input format verbatim\n");
	PUTSTDERR("-logfile filename            : set error log filename\n");
	PUTSTDERR("-no-blank-line-warning       : do not warn about blank lines\n");
	PUTSTDERR("-no-brief                    : output standard !DOCTYPE, HTML, HEAD, BODY\n");
	PUTSTDERR("-no-check-tag-nesting        : do not warn about tag nesting errors\n");
	PUTSTDERR("-no-comment-banner           : no comment banner\n");
	PUTSTDERR("-no-convert-paragraph-breaks : do not convert text paragraph breaks to <P>\n");
	PUTSTDERR("-no-keep-format              : treat input as normal HTML or SGML\n");
	PUTSTDERR("-no-print-stylefile          : do not print stylefile\n");
	PUTSTDERR("-no-quiet                    : print warnings on stderr\n");
	PUTSTDERR("-no-read-stylefiles          : suppress reading of default style files\n");
	PUTSTDERR("-no-trace-opens              : no tracing of attempted file openings\n");
	PUTSTDERR("-no-unknown-tag-warning      : do not warn about unknown HTML tags\n");
	PUTSTDERR("-no-warnings-in-comments     : warnings appear only on stderr\n");
	PUTSTDERR("-outfile filename            : set output filename\n");
	PUTSTDERR("-personal-name name          : set personal name for banner\n");
	PUTSTDERR("-print-stylefile             : print style file and quit\n");
	PUTSTDERR("-quiet                       : do not print warnings on stderr\n");
	PUTSTDERR("-read-stylefiles             : read default style files\n");
	PUTSTDERR("-stylefile filename          : set style filename\n");
	PUTSTDERR("-trace-opens                 : trace attempted file openings\n");
	PUTSTDERR("-unknown-tag-warning         : warn about unknown HTML tags\n");
	PUTSTDERR("-version                     : show version number and quit\n");
	PUTSTDERR("-warnings-in-comments        : warnings also appear as comments on stdout\n");
	PUTSTDERR("-width nnn                   : set output line width to nnn\n");
	PUTSTDERR("\n");
	PUTSTDERR("GNU and POSIX style --<name> options are also recognized.\n");
    }
    first = 0;
}


void
verbatim_nocheck(VOID_ARG)
{
    normalize_tag((char*)&yytext[0]);
    if (Is_Begin_Tag(yytext))
    {
	begin_verbatim((const char*)&yytext[0]);
	copy_verbatim();
    }
    else
	end_verbatim((const char*)&yytext[0]);
}


void
verbatim(VOID_ARG)
{
    normalize_tag((char*)&yytext[0]);
    if (Is_Begin_Tag(yytext))
    {
	maybe_begin_body();
	begin_verbatim((const char*)&yytext[0]);
	copy_verbatim();
    }
    else
	end_verbatim((const char*)&yytext[0]);
}


INLINE static void
verbatim_with_translation(VOID_ARG)
{
    /* Copy the input stream verbatim, translating only the fundamental */
    /* four characters < > & " to SGML entities, and embedding it in a */
    /* preformatted environment, <PRE>...</PRE>.   If this routine is */
    /* called, then yylex() will never be called, so we need to use */
    /* getchar() instead of Input(). */
    register int	c;
    register int	last_line_number;
    char		line_number_buffer[MAXBUF];
    register int	more;
    register int	non_ASCII_count;

    push_tag_nest("<PRE>");
    maybe_begin_body();
    begin_verbatim("<PRE>");
    out_verbatim_char('\n');
    last_line_number = line_number - 1;
    line_number_buffer[0] = '\0';	/* so we can use strcat() below */
    non_ASCII_count = 0;

    for (more = 1; more; )
    {
	c = getchar();

	if (c > 127)
	{
	    non_ASCII_count++;
	    if (line_number > last_line_number)
	    {
		if (strlen(line_number_buffer) < (sizeof(line_number_buffer) - 21 - 4 - 1))
		{			/* size - 21 (nnnnnn) -4 ( ...) - 1 (NUL)  */
		    char tempmsg[1 + 21 + 1]; /* size = 1 (space) + 21 (nnnnnn) + 1 (NUL) */
		    SPRINTF(tempmsg," %d", line_number);
		    (void)strcat((char*)&line_number_buffer[0], (const char*)&tempmsg[0]);
		}
		else if (line_number_buffer[strlen(line_number_buffer)-1] != '.')
		    (void)strcat(line_number_buffer, " ...");
	    }
	    last_line_number = line_number;
	}

	switch (c)
	{
	case EOF:
	    if (yywrap())	/* then end of all input files, */
		more = 0;	/* so terminate the for() loop */
	    break;

	case '\n':
	    out_verbatim_char('\n');
	    line_number++;
	    break;

	case '<':
	    out_verbatim_string(ENTITY_LT);
	    break;

	case '>':
	    out_verbatim_string(ENTITY_GT);
	    break;

	case '&':
	    out_verbatim_string(ENTITY_AMP);
	    break;

	case '\"':
	    out_verbatim_string(ENTITY_QUOTE);
	    break;

	default:
	    out_verbatim_char(c);
	    break;
	}
    }

    end_verbatim("</PRE>");	/* this will call pop_tag_nest() */

    if (non_ASCII_count > 0)
    {
#undef MSG_FMT
#define MSG_FMT "%d non-ASCII characters encountered at line(s)%s; this document requires a <META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=\"...\"> declaration in the <HEAD>...</HEAD> environment"
	char tempmsg[sizeof(MSG_FMT) + 21 + sizeof(line_number_buffer)];

	SPRINTF(tempmsg, MSG_FMT, non_ASCII_count, (const char*)&line_number_buffer[0]);
	warning(tempmsg);
    }
}


static void
version(VOID_ARG)
{
    FPRINTF(stderr, "HTML/SGML prettyprinter %s version %s %s\n",
		  PROGRAM, VERSION, DATE);
    FPRINTF(stderr, "Compiled on %s %s by %s@%s\n", __DATE__, __TIME__,
		  USER, HOSTNAME);
}


#if STDC
void
warning(const char *msg)
#else
void
warning(msg)
const char *msg;
#endif
{
    if (!quiet_flag)
    {
	FPRINTF(stderr,"%.2047s:%d:%.4094s\n",
		((input_filename == (const char*)NULL) ? "" : input_filename),
		line_number, msg);
    }

    if (warnings_in_comments)
    {
#undef MSG_FMT
#define MSG_FMT	"\n<!-- WARNING: %.2047s:%d:%.4094s -->\n"
	char tempmsg[sizeof(MSG_FMT) + 2047 + 21 + 2*2047 + 1];
	/* allow space for TWO long strings in message section of tempmsg[] */

	SPRINTF(tempmsg, MSG_FMT,
	    ((input_filename == (const char*)NULL) ? "" : input_filename),
	    line_number, msg);
	out_verbatim_string(tempmsg);
    }
}


static void
wrapup(VOID_ARG)
{
    trim_line(0);
    if (line_length() > 0)		/* then force out last line */
	out_newline();
    if (!in_plaintext)
	do_end_html();
    if (level != 0)
	warning("non-zero <TAG> ... </TAG> nesting level at end-of-file");
    print_tag_nest();
    delete_trailing_spaces();
    dputc('\n');			/* guarantee final newline */
    flush_buffer();			/* output all remaining buffered data */
}


#if STDC
int
main(int argc, char *argv[])
#else
int
main(argc, argv)
int argc;
char *argv[];
#endif
{

#if defined(__STDC__) && defined(_IOFBF) && defined(BUFSIZ) && ((MAXBIGBUF) > (BUFSIZ))
    /* OPTIMIZATION: when possible, and requested by large MAXBIGBUF
       setting, use larger input and output buffers for reduced system
       call overhead. */
    static char big_input_buffer[MAXBIGBUF];
    static char big_output_buffer[MAXBIGBUF];

    (void)setvbuf(stdin, big_input_buffer, _IOFBF, sizeof(big_input_buffer));
    (void)setvbuf(stdout, big_output_buffer, _IOFBF, sizeof(big_output_buffer));
#endif


#if !defined(FLEX_SCANNER)
    /*******************************************************************
      This sanity check is essential, because some lex implementations
      allocate yytext[] before the user-definable code section is
      reached, making it impossible to reset the array size, YYLMAX, at
      compilation time.

      We handle this by a sed filter step in the Makefile to correct the
      .c code output by lex, but just in case someone ran lex manually,
      we also make this run-time check.

      I spent a half-day in debugging sessions trying to figure out why
      data was being overwritten elsewhere before discovering this
      undocumented `feature' of lex!
    *******************************************************************/
    if ((size_t)YYLMAX != sizeof(yytext))
    {
	FPRINTF(stderr,"**********************************************************************\n");
	FPRINTF(stderr,"** FATAL ERROR: This program has inconsistent array sizes:\n");
	FPRINTF(stderr,"**\tYYLMAX = %lu\n", (size_t)(YYLMAX));
	FPRINTF(stderr,"**\tsizeof(yytext) = %lu\n", sizeof(yytext));
	FPRINTF(stderr,"** You must correct the lex-generated code and rebuild the program.\n");
	FPRINTF(stderr,"** The Makefile has a sed filter step that should correct the error.\n");
	FPRINTF(stderr,"** Did you override this by running lex manually?\n");
	FPRINTF(stderr,"**********************************************************************\n");
	exit(EXIT_FAILURE);
    }
#endif

#if defined(IBM_PC)
    /* On IBM PC DOS, use binary mode for stdin and stdout, so that Ctl-Z */
    /* does not mean end-of-file on input, and so that Ctl-M Ctl-J is not */
    /* written at end-of-line on output, causing doubled Ctl-M characters. */
    (void)setmode(fileno(stdin), O_BINARY);
    (void)setmode(fileno(stdout), O_BINARY);
#endif

    do_banner = 1;
    g_errors = 0;
    g_argk = 0;			/* private file-wide index into g_argv[] */
    g_argc = argc;		/* private file-wide argument count */
    g_argv = &argv[0];		/* private file-wide argument list */

    prescan_options();		/* to check for -read-stylefiles and -trace-opens options */

    initialize();

    do_initialization_files();

    make_hash_table();

    (void)reopen();		/* parse command line up to first file */

    if (quit_flag == 0)		/* then no errors have been seen */
    {
	if (do_banner)
	    out_banner();

	if (print_style_file)	/* special case: print style file and exit */
	    generate_style_file();
	else			/* normal case: prettyprint input files */
	{
	    if (keep_format)
		verbatim_with_translation();
	    else
	    {
		while (yylex())
		    NOOP;
	    }
	    wrapup();		/* to force out last buffer */
	}
    }

    table_wrapup();			/* free dynamically-allocated tables */

    return ((g_errors > 0) ? EXIT_FAILURE : EXIT_SUCCESS);
}


void
do_arg(VOID_ARG)
{
    int n;

    switch (option_type(g_argk))
    {
    case OPT_AUTHOR:
	author();
	quit_flag = 1;
	break;

    case OPT_BLANK_LINE_WARNING:
      blank_line_warning = 1;
      break;

    case OPT_BRIEF:
	brief_format = 1;
	break;

    case OPT_CATALOGFILE:	/* expect -catalogfile filename */
	if (g_argv[++g_argk] != (char*)NULL)
	    catalog_filename = g_argv[g_argk];
	else
	    option_error("missing catalog filename");
	break;

    case OPT_CHECK_TAG_NESTING:
	do_check_tag_nesting = 1;
	break;

    case OPT_COMMENT_BANNER:
	do_banner = 1;
	break;

    case OPT_CONVERT_PARAGRAPH_BREAKS:
	convert_paragraph_breaks = 1;
	break;

    case OPT_COPYRIGHT:
	copyright();
	quit_flag = 1;
	break;

    case OPT_EMAIL_ADDRESS:		/* expect -e-mail-address user@host */
	if (g_argv[++g_argk] != (char*)NULL)
	    user_email = g_argv[g_argk];
	else
	    option_error("missing user@hostname");
	break;

    case OPT_EXTENDED_STYLE:	/* expect -extend-style "style : tag tag ..." */
				/* or     -extend-style "TAG   : tag tag ..." */
	if (g_argv[++g_argk] != (char*)NULL)
	{
	    char buffer[MAXBUF + 2];	/* NB: space for TWO trailing NULs */

	    (void)strncpy(buffer, g_argv[g_argk], MAXBUF);
	    do_style_line("command-line", 0, buffer);
	    make_hash_table();
	}
	else
	    option_error("missing \"style : tag tag...\" or \"TAG: tag tag ...\" value");
	break;

    case OPT_FILE:			/* expect -file filename */
	if (g_argv[++g_argk] != (char*)NULL)
	{
	    comment_banner_filename = (const char*)g_argv[g_argk];
	    file_flag = 1;
	}
	else
	    option_error("missing input filename");
	break;

    case OPT_GRAMMAR_LEVEL:		/* expect -grammar-level level */
	if (g_argv[++g_argk] != (char*)NULL)
	{
	    char tempbuf[MAXTOKENLENGTH];

	    grammar_level = g_argv[g_argk];
	    (void)strcat(tempbuf," ");
	    (void)strncat(tempbuf,grammar_level,sizeof(tempbuf)-3); /* 3 == 2 blanks + 1 NUL */
	    (void)strcat(tempbuf," ");
	    entity_quote = (search(GRAMMARS_WITH_QUOT,
				   lowercase(tempbuf)) == (const char*)NULL) \
		? "&#34;" : "&quot;";
	    do_catalog_file(catalog_filename,grammar_level);
	    make_hash_table();
	}
	else
	    option_error("missing grammar level in style catalog");
	break;

    case OPT_HELP:
	usage();
	quit_flag = 1;
	break;

    case OPT_INDENT:			/* expect -indent nnn */
	if ((g_argv[++g_argk] != (char*)NULL) && isdigit(g_argv[g_argk][0]))
	{
	    n = (int)atoi(g_argv[g_argk]);
	    if ((0 <= n) && (n <= 16))	/* require reasonable range */
		indent = n;
	}
	else
	    option_error("missing indentation value");
	break;

    case OPT_KEEP_FORMAT:
	keep_format = 1;
	break;

    case OPT_LOGFILE:			/* expect -logfile filename */
	if (g_argv[++g_argk] != (char*)NULL)
	{
	    if (tfreopen(g_argv[g_argk], "w", stderr) == (FILE*)NULL)
		exit(EXIT_FAILURE);	/* no stderr left for warning() */
	}
	else
	    option_error("missing log filename");
	break;

    case OPT_NO_BLANK_LINE_WARNING:
	blank_line_warning = 0;
	break;

    case OPT_NO_BRIEF:
	brief_format = 0;
	break;

    case OPT_NO_CHECK_TAG_NESTING:
	do_check_tag_nesting = 0;
	break;

    case OPT_NO_COMMENT_BANNER:
	do_banner = 0;
	break;

    case OPT_NO_CONVERT_PARAGRAPH_BREAKS:
	convert_paragraph_breaks = 0;
	break;

    case OPT_NO_KEEP_FORMAT:
	keep_format = 0;
	break;

    case OPT_NO_PRINT_STYLEFILE:
	print_style_file = 0;
	break;

    case OPT_NO_QUIET:
	quiet_flag = 0;
	break;

    case OPT_NO_READ_STYLEFILES:
	break; /* already handled in main() -> prescan_options() */

    case OPT_NO_TRACE_OPENS:
	break; /* already handled in main() -> prescan_options() */

    case OPT_NO_UNKNOWN_TAG_WARNING:
	unknown_tag_warning = 0;
	break;

    case OPT_NO_WARNINGS_IN_COMMENTS:
	warnings_in_comments = 0;
	break;

    case OPT_OUTFILE:			/* expect -outfile outputfilename */
	if (g_argv[++g_argk] != (char*)NULL)
	{
	    if (tfreopen(g_argv[g_argk], "w", stdout) == (FILE*)NULL)
		exit(EXIT_FAILURE);	/* no stdout left for output */
	}
	else
	    option_error("missing output filename");
	break;

    case OPT_PERSONAL_NAME:		/* expect -personal-name "Jill Q. User" */
	if (g_argv[++g_argk] != (char*)NULL)
	    user_personal_name = g_argv[g_argk];
	else
	    option_error("missing personal name");
	break;

    case OPT_PRINT_STYLEFILE:
	print_style_file = 1;
	break;

    case OPT_QUIET:
	quiet_flag = 1;
	break;

    case OPT_READ_STYLE_FILES:			/* no default style files */
	break; /* already handled in main() -> prescan_options() */

    case OPT_STYLEFILE:			/* expect -stylefile filename */
	if (g_argv[++g_argk] != (char*)NULL)
	{
	    do_style_file(g_argv[g_argk],1);
	    make_hash_table();
	}
	else
	    option_error("missing style filename");
	break;

    case OPT_TRACEOPENS:
	break; /* already handled in main() -> prescan_options() */

    case OPT_UNKNOWN_TAG_WARNING:
	unknown_tag_warning = 1;
	break;

    case OPT_VERSION:
	version();
	quit_flag = 1;
	break;

    case OPT_WARNINGS_IN_COMMENTS:
	warnings_in_comments = 1;
	break;

    case OPT_WIDTH:			/* expect -width nnn */
	if ((g_argv[++g_argk] != (char*)NULL) && isdigit(g_argv[g_argk][0]))
	{
	    n = (int)atoi(g_argv[g_argk]);
	    if (n == 0)			/* interpret as `infinity' */
		max_width = INT_MAX;	/* defined in <limits.h> */
	    else if (0 < n)		/* require reasonable range */
		max_width = n;
	}
	else
	    option_error("missing width value");
	break;

    default:
	option_error("unknown option name");
	break;
    }
}


#if STDC
static void
option_error(const char *msg)
#else
static void
option_error(msg)
const char *msg;
#endif
{
#undef MSG_FMT
#define MSG_FMT "-%.39s option%.7s%.2047s%.1s: %.255s"
    char tempmsg[sizeof(MSG_FMT) + 39 + 8 + 2047 + 1 + 255 + 1];

    SPRINTF(tempmsg, MSG_FMT, option_last,
	    ((g_arg_source == (const char*)NULL) ? "" : " from ["),
	    ((g_arg_source == (const char*)NULL) ? "" : g_arg_source),
	    ((g_arg_source == (const char*)NULL) ? "" : "]"),
	    msg);
			/* option_last was set in last call to option_type() */
    quit_flag = 1;
    g_errors++;
    warning(tempmsg);
    usage();
}


#if STDC
static int
option_match(const char *keyword, const char *user_option, size_t min_match)
#else
static int
option_match(keyword, user_option, min_match)
const char *keyword;
const char *user_option;
size_t min_match;
#endif
{
    register size_t	k;
    register int	lc_keyword;
    register int	lc_user_option;
    register size_t	n_keyword;
    register size_t	n_user_option;

    n_keyword = strlen(keyword);
    n_user_option = strlen(user_option);

#define TOLOWER(c)	(isupper(c) ? tolower(c) : (c))
#define KTHOF(s,k,n)	(((k) < (n)) ? TOLOWER(s[k]) : ' ')

    for (k = 0; k < n_user_option; ++k)
    {
	lc_keyword = KTHOF(keyword,k,n_keyword);
	lc_user_option = KTHOF(user_option,k,n_user_option);
	if (lc_keyword != lc_user_option) /* only first k character match */
	    break;
    }

    lc_user_option = KTHOF(user_option,k,n_user_option); /* reevaluate */
					/* in case we reached the loop limit */

    /* We have an acceptable abbreviated match if at least min_match
       characters have matched, and the next character in user_option[]
       that failed to match is a (possibly padding) space. */
    return ((k >= min_match) && isspace(lc_user_option)) ? 1 : 0;
}


#if STDC
static int
option_type(int argnum)
#else
static int
option_type(argnum)
int argnum;
#endif
{	/* return matching OPT_xxx, or else OPT_INVALID */
    register int	k;

    option_last = g_argv[argnum];
    if (OPTION_PREFIX(option_last[0]))	/* expect <prefix><option><NUL> */
    {
	++option_last;
	if (OPTION_PREFIX(option_last[0])) /* allow GNU and POSIX-style: --<option> */
	    ++option_last;

	for (k = 0; option_table[k].name != (const char*)NULL; ++k)
	{				/* linear search in option name table */
	    if (option_match(option_table[k].name,option_last,option_table[k].min_match))
	    {
		option_last = option_table[k].name; /* save for option_error() */
		return (option_table[k].number);
	    }
	}
    }
    return (OPT_INVALID);
}


static void
prescan_options(VOID_ARG)
{
    register int  k;

    /* Handle the command-line options that need to be processed before
       any files are read. */

    for (k = 0; k < g_argc; ++k)
    {
	switch (option_type(k))
	{
	case OPT_NO_READ_STYLEFILES:
	    read_stylefiles_flag = 0;
	    break;

	case OPT_NO_TRACE_OPENS:
	    trace_flag = 0;
	    break;

	case OPT_READ_STYLE_FILES:
	    read_stylefiles_flag = 1;
	    break;

	case OPT_TRACEOPENS:
	    trace_flag = 1;
	    break;

	default:
	    break;			/* all other options are ignored for now */
	}
    }
}


static int
reopen(VOID_ARG)
{
    if (g_argk < (g_argc - 1))
    {
	++g_argk;
	if (OPTION_PREFIX(g_argv[g_argk][0]))
	{
	    do_arg();
	    return (reopen());
	}
	else if (freopen(g_argv[g_argk], RMODE, stdin) != (FILE*)NULL)
	{
	    if (!file_flag)
		comment_banner_filename = g_argv[g_argk];
	    input_filename = g_argv[g_argk];
	}
	else
	{
#undef MSG_FMT
#define MSG_FMT "unable to open input file [%.255s]"
	    char tempmsg[sizeof(MSG_FMT) + 255 + 1];

	    SPRINTF(tempmsg, MSG_FMT, g_argv[g_argk]);
	    warning(tempmsg);

	    g_errors++;
	    return (reopen());		/* move on to next file */
	}

	line_number = 1;
	return (0);			/* have file to process */
    }
    else
	return (1);			/* all done */
}


int
yywrap(VOID_ARG)
{
    return (reopen());
}

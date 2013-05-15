/***********************************************************************
 @C-file{
    author              = "Nelson H. F. Beebe",
    version             = "1.00",
    date                = "29 November 1997",
    time                = "08:54:50 MST",
    filename            = "table.c",
    address             = "Center for Scientific Computing
                           University of Utah
                           Department of Mathematics, 105 JWB
                           155 S 1400 E RM 233
                           Salt Lake City, UT 84112-0090
                           USA",
    telephone           = "+1 801 581 5254",
    FAX                 = "+1 801 581 4148",
    URL                 = "http://www.math.utah.edu/~beebe",
    checksum            = "56233 1792 5918 47691",
    email               = "beebe@math.utah.edu, beebe@acm.org,
                           beebe@ieee.org (Internet)",
    codetable           = "ISO/ASCII",
    keywords            = "prettyprinter, table utilities",
    supported           = "yes",
    docstring           = "This file contains support functions for
                           table-driven processing of lexical tokens.

                           This code (about 1700 lines) was borrowed
                           almost entirely from tex-pretty, and this
                           file is now shared by html-pretty and
                           tex-pretty.

                           In the original port of this code to
                           html-pretty, the only changes to the original
                           tex-pretty code were:

			       (1) 8 small code sections (see the
			       preprocessor conditionals for the symbols
			       HTML_PRETTY and TeX_PRETTY below);

			       (2) an alternative definition of the
			       builtin_style[] table, now stored in a
			       separate file, builtin.h;

			       (3) an alternate definition of the
			       default_style[] table, now stored in a
			       separate file, default.h.

			   During this development, several new features
			   have been added to the functions in this
			   file; they will be usable in tex-pretty as
			   well.

                           The checksum field above contains a CRC-16
                           checksum as the first value, followed by the
                           equivalent of the standard UNIX wc (word
                           count) utility output of lines, words, and
                           characters.  This is produced by Robert
                           Solovay's checksum utility.",
 }
***********************************************************************/

#include <config.h>			/* private header file */

#if defined(HAVE_CTYPE_H)
#include <ctype.h>
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

#if defined(HAVE_TIME_H)
#include <time.h>
#endif

#include <common.h>			/* private header file */
#include <fileutil.h>			/* private header file */


typedef void (*PostOutputAction)ARGS((const char *name));

typedef void (*StyleFunction)ARGS((void));

typedef struct
{
    const char *style;
    size_t style_length; /* NB: important optimization for get_name_by_style() */
    const char *name;
    StyleFunction action;
} Style;

typedef struct
{
    size_t max_size;
    size_t size;
    Style *table;
} StyleTable;

typedef unsigned int	HASH_INT;	/* MUST be unsigned for hash() */
					/* to protect against overflow */
typedef struct Hash_Entry
{
    const char		*hash_key;	/* pointer to hash key string */
    VOIDP		hash_data;	/* pointer to arbitrary data */
} HASH_ENTRY;

typedef struct Hash_Table
{
    HASH_INT	hash_index;		/* index of next entry to be */
					/* examined by hash_next() */
    HASH_INT	hash_size;		/* size of hash table */
    HASH_ENTRY	*hash_table;		/* pointer to hash table */
} HASH_TABLE;

#include <builtin.h>			/* private header file */
#include <default.h>			/* private header file */

#if defined(TeX_PRETTY)
static PostOutputAction post_output_action;
static void		do_nothing ARGS((const char *pattern));
#endif

static HASH_TABLE	*style_hash_table = (HASH_TABLE *)NULL;
static StyleTable	style_table = { 0, 0, (Style*)NULL };

#undef VERSION				/* we don't want the config.h value */

extern const char	*DATE;
extern const char	*PROGRAM;
extern const char	*VERSION;

extern int		g_argc;
extern int		g_argk;
extern char		**g_argv;
extern const char	*g_arg_source;

extern int		g_errors;
extern int		max_width;
extern int		quit_flag;

static void		add_style ARGS((const char *data_source,
					int style_line_number,
					const char *the_style, const char *the_name));
static int		compare_strings ARGS((const VOIDP s,const VOIDP t));
static void		do_arg_line ARGS((char *line, const char *data_source));
static void		error ARGS((const char *msg));
static void		error_pending ARGS((const char *msg));
static void		free_hash_table ARGS((void));
static void		free_style_table ARGS((void));
static void		free_style_table_entry ARGS((Style *the_table));

#define get_macro(pattern) dupstr(pattern)

static char		*get_arg ARGS((char *line, char **next));
static char		*get_continued_line ARGS((char *line, size_t maxline,
						  FILE *fpstyle,
						  const char *the_filename,
						  int *p_style_line_number));
static size_t		get_longest_style_length ARGS((void));
static VOIDP		get_memory ARGS((VOIDP ptr, size_t size));
static Style		*get_style_by_name ARGS((const char *name));
static Style		*get_style_by_style ARGS((const char *name));
static char		*get_token ARGS((const char *data_source,
					 int style_line_number,
					 char *name, const char *set,
					 char *overwritten_char));
INLINE static HASH_INT	hash ARGS((const char *key, const HASH_TABLE *table));
static HASH_TABLE	*hash_alloc ARGS((HASH_INT size));
static void		hash_free ARGS((HASH_TABLE *table));
static HASH_ENTRY	*hash_install ARGS((const char* key, VOIDP data,
					    HASH_TABLE *table));
INLINE static HASH_ENTRY *hash_lookup ARGS((const char* key, HASH_TABLE *table));
static HASH_ENTRY	*hash_next ARGS((int first, HASH_TABLE *table));

#define Is_Array_Style(style)	(strchr(style,'['/*']'*/) != (char*)NULL)

static int		temp_char;
#define Is_Item_Separator(c)	(temp_char = (c), isspace(temp_char) || (temp_char == ','))

static void		make_style_table_entry ARGS((Style *the_table,
						     const char *the_style,
						     const char *the_name,
						     StyleFunction the_action));
static long		next_prime ARGS((long n));
static void		normalize_space ARGS((char *s));
static void		print_arrays ARGS((size_t longest_style_length));
static void		print_indentation ARGS((size_t indentation_count));
static void		print_table_row ARGS((const char **sorted_table,
					      size_t longest_style_length,
					      const char *the_style));
static void		show_styles ARGS((void));
static const char 	*style_of_name ARGS((const char* name));

void			call_action_by_name ARGS((const char *key));
void			do_style_file ARGS((const char *the_filename,
					    int warn_if_no_file));
void			do_style_line ARGS((const char *data_source,
					    int style_line_number,
					    char *line));
char			*dupstr ARGS((const char *s));
void			generate_style_file ARGS((void));

#if defined(TAG_CACHE)
StyleFunction		*get_action_by_name ARGS((const char *key));
#endif /* defined(TAG_CACHE) */

const char 		*get_class_by_name ARGS((const char *key));
const char 		*get_name_by_style ARGS((const char *style));
char			*lowercase ARGS((char *s));
void			make_hash_table ARGS((void));
void			initialize ARGS((void));
char	 		*strip_comment ARGS((char *line));
void			table_wrapup ARGS((void));
char			*uppercase ARGS((char *s));

extern void		do_arg ARGS((void));
extern void		warning ARGS((const char *msg));

#if defined(HTML_PRETTY)
extern void		out_yytext ARGS((void));
extern void		other_tag ARGS((void));
#endif /* defined(HTML_PRETTY) */

#define ESCAPE_PREFIX	'\\'	/* this escapes newline, percent, and QUOTECHARS */
#define QUOTECHARS	"\""	/* could include ` and ', but we don't need them yet */

#if STDC
static void
add_style(const char *data_source, int style_line_number, const char *the_style,
	  const char *the_name)
#else
static void
add_style(data_source,style_line_number,the_style,the_name)
const char *data_source;
int style_line_number;
const char *the_style;
const char *the_name;
#endif
{
    Style *s;
    Style temp_style;

#if !defined(STYLECHUNK)

#if defined(HTML_PRETTY)
#define STYLECHUNK		200	/* big enough for builtin table (145 used) */
#endif /* defined(HTML_PRETTY) */

#if defined(TeX_PRETTY)
#define STYLECHUNK		900	/* big enough for builtin table */
#endif /* defined(TeX_PRETTY) */

#endif /* !defined(STYLECHUNK) */

    if (style_table.size >= style_table.max_size)
    {					/* create or enlarge table */
	style_table.max_size += STYLECHUNK;
	style_table.table = (Style*)get_memory((VOIDP)style_table.table,
					       sizeof(Style) *
					       style_table.max_size);
    }
    if (strcmp("default",the_style) == 0)
    {
	s = &temp_style;
	s->style = "default";

#if defined(HTML_PRETTY)
	s->action = other_tag;
#endif /* defined(HTML_PRETTY) */

#if defined(TeX_PRETTY)
	s->action = Is_Control_Sequence(the_name) ? out_yytext : environment;
#endif

    }
    else
	s = get_style_by_style(the_style);

    /* NB: this may add duplicate names to the table: the last added is */
    /* the one to be used. */
    if (Is_Array_Style(the_style))	/* expect table[key] */
	make_style_table_entry(&style_table.table[style_table.size++],
			       the_style, the_name, (StyleFunction)NULL);
    else if (s != (Style*)NULL)		/* found a style_table entry */
	make_style_table_entry(&style_table.table[style_table.size++],
			       s->style, the_name, s->action);
    else				/* should never happen */
    {
#undef MSG_FMT
#define MSG_FMT "unknown style [%.39s] command [%.39s] at line %d in style source [%.2047s]"
	char tempmsg[sizeof(MSG_FMT) + 39 + 39 + 21 + 2047 + 1];

	SPRINTF(tempmsg, MSG_FMT,
		the_style, the_name, style_line_number, data_source);
	error_pending(tempmsg);
	show_styles();
    }
}


#if STDC
void
call_action_by_name(const char *key)
#else
void
call_action_by_name(key)
const char *key;
#endif
{
    Style *style;

    style = get_style_by_name(key);

    if (style == (Style*)NULL)
	other_tag();
    else
	style->action();
}


#if STDC
static void
delete_style(const char *name)
#else
static void
delete_style(name)
const char *name;
#endif
{
    register int	delete_all;
    register size_t	k;

    if (name != (const char*)NULL)	/* NULL value should never happen */
    {
	delete_all = (strcmp("default",name) == 0);
	for (k = 0; k < style_table.size; ++k)
	{
	    if (delete_all ||
		((style_table.table[k].style != (const char*)NULL) &&
		 (strcmp(style_table.table[k].style,name) == 0)))
		free_style_table_entry(&style_table.table[k]);
	}
	make_hash_table();
    }
}


#if STDC
static int
compare_strings(const VOIDP s,const VOIDP t)
#else
static int
compare_strings(s,t)
const VOIDP s;
const VOIDP t;
#endif
{
    return (strcmp(*(const char**)s, *(const char**)t));
}


#if STDC
static void
do_arg_line(char *line, const char *data_source)
#else
static void
do_arg_line(line,data_source)
char *line;
const char *data_source;
#endif
{
    char	*argv[(MAXBUF + 1)/2 + 1];
    int		argc;

    char	*p;
    char	*q;

    char	**save_g_argv;
    int		save_g_argc;
    int		save_g_argk;
    const char  *save_g_arg_source;

    /* Save the global argument data */
    save_g_argv = g_argv;
    save_g_argc = g_argc;
    save_g_argk = g_argk;
    save_g_arg_source = g_arg_source;

    /* Parse the line into command-line arguments, a la shell processing
    of the real command line. */

    argv[0] = g_argv[0];		/* zeroth argument always points to program */
    argc = 1;

    for (p = get_arg(line,&q); (p != (char*)NULL); p = get_arg(q,&q))
	argv[argc++] = p;
    argv[argc] = (char*)NULL;		/* argv[] always ends with NULL pointer */

    g_arg_source = data_source;
    g_argc = argc;
    g_argv = argv;
    for (g_argk = 1; g_argk < g_argc ; g_argk++)
	do_arg();

    /* Restore the global argument data */
    g_argv = save_g_argv;
    g_argc = save_g_argc;
    g_argk = save_g_argk;
    g_arg_source = save_g_arg_source;
}


#if defined(TeX_PRETTY)
#if STDC
static void
do_nothing(const char *pattern)
#else
static void
do_nothing(pattern)
const char *pattern;
#endif
{
			/* post-outout do-nothing action for out_string() */
}
#endif /* defined(TeX_PRETTY) */


#if STDC
void
do_style_file(const char *the_filename, int warn_if_no_file)
#else
void
do_style_file(the_filename, warn_if_no_file)
const char *the_filename;
int warn_if_no_file;
#endif
{
    FILE	*fpstyle;

    if (the_filename == (const char *)NULL) /* silently reject NULL names */
	return;

    fpstyle = tfopen(the_filename,"r");
    if (fpstyle == (FILE*)NULL)		/* open failed */
    {
	if (warn_if_no_file)
	{
#undef MSG_FMT
#define MSG_FMT "unable to open style file [%.2047s]"
	    char tempmsg[sizeof(MSG_FMT) + 2047 + 1];

	    SPRINTF(tempmsg, MSG_FMT, the_filename);
	    error_pending(tempmsg);
	}
    }
    else				/* open succeeded */
    {
	char	line[MAXBUF+2];		/* NB: space for two trailing NULs */
	int	style_line_number;

	style_line_number = 0;
	while (get_continued_line(line, MAXBUF, fpstyle, the_filename,
				  &style_line_number) != (char*)NULL)
	    do_style_line(the_filename, style_line_number, line);
	(void)fclose(fpstyle);
    }
}


#if STDC
void
do_style_line(const char *data_source, int style_line_number, char *line)
#else
void
do_style_line(data_source, style_line_number, line)
const char	*data_source;
int		style_line_number;
char		*line;			/* NB: overwritten on return */
#endif
{
    /* NB: line[] must have room at the end for two trailing NULs! */
    char	overwritten_char;
    char	*p;
    const char	*lhs;
    int		rhs_count;

#if defined(HTML_PRETTY)
#define ASSIGNCHARS ":="
#define STYLECHARS "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-#[]"
#define TOKENCHARS "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!%:="
#define TOUPPER(s)	uppercase(s)
#endif

#if defined(TeX_PRETTY)
#define ASSIGNCHARS ":="
#define STYLECHARS "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-"
#define TOKENCHARS "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\\@:=*()[]{}"
#define TOUPPER(s)	(s)
#endif

    p = strchr(strip_comment(line),(int)'\0');

    p[1] = '\0';			/* need two consecutive terminators */
					/* for get_token() calls */

    for (--p; (p > line) && isspace(*p); --p)
	*p = '\0';			/* strip trailing space */

    if (p <= line)
	return;				/* ignore empty lines */

    for (p = line; *p && isspace(*p); ++p) /* skip over leading space */
	NOOP;

    if (OPTION_PREFIX(*p))
	do_arg_line(p,data_source);
    else
    {
	do					/* one-trip loop */
	{
	    /* In the interests of storage economy, we tolerate some
	    ugliness here: we want to be able to store the tokens in the
	    line[] buffer without the need for dynamic memory allocation,
	    and we want normal C NUL string terminators.  If there is no
	    space around the assignment operator separating the LHS from RHS
	    names, there is no room for the NULs, so we check for this, and
	    restore the overwritten characters. */

	    p = get_token(data_source, style_line_number, line, STYLECHARS,
			  &overwritten_char);
	    if (p == (char*)NULL)
		break;			/* error exit */
	    lhs = style_of_name(p);

	    p += strlen(p);
	    p[0] = overwritten_char;

	    p = get_token(data_source, style_line_number, p, ASSIGNCHARS,
			  &overwritten_char);
	    if (p == (char*)NULL)
		break;			/* error exit */

	    p += strlen(p);
	    p[0] = overwritten_char;

	    if (Is_Array_Style(lhs))	/* have array[name] : value */
	    {				/* so pass untokenized value to add_style() */
		while (*p && (strchr(TOKENCHARS,(int)*p) == (char*)NULL))
		    ++p;		/* skip to start of value */
		normalize_space(p);
		*--p = ' '; 		/* want leading space in value */
		add_style(data_source, style_line_number, lhs,
			  (strchr(QUOTECHARS,(int)*p) == (char*)NULL) ? TOUPPER(p) : p);
		p = (char*)NULL;	/* to flag success */
	    }
	    else			/* have class : name name name .... */
	    {				/* so pass each class:name pair to add_style() */
		for (p = get_token(data_source, style_line_number, p, TOKENCHARS,
				   (char*)NULL),
		       rhs_count = 0;
		     (p != (char*)NULL) && *p;
		     p = get_token(data_source, style_line_number,
				   p + (int)strlen(p) + 1, TOKENCHARS, (char*)NULL),
		       rhs_count++)
		    add_style(data_source, style_line_number, lhs,
			      (strchr(QUOTECHARS,(int)*p) == (char*)NULL) ? TOUPPER(p) : p);

		if (rhs_count == 0)
		    delete_style(lhs);
	    }
	    /* this test is  always true, but avoids unreachable-code complaints */
	    if (p == (char*)NULL)
		return;			/* normal success return */
	} while (0);

	{					/* error handler */
#undef MSG_FMT
#define MSG_FMT "expected style : name name ... in %.2047s:%d:%.255s"
	    char tempmsg[sizeof(MSG_FMT) + 2047 + 21 + 255 + 1];

	    SPRINTF(tempmsg, MSG_FMT, data_source, style_line_number, line);
	    error_pending(tempmsg);
	}
    }
}


#if STDC
char*
dupstr(const char *s)
#else
char*
dupstr(s)
const char *s;
#endif
{
    char *p;

    /* Return a dynamically-allocated copy of s with one extra character
       available for blank-padding of value strings from "array[name]: value"
       style-file entries, or die. */

    p = (char*)malloc(strlen(s)+1+1);	/* +1 for space, +1 for NUL */
    if (p == (char*)NULL)
	error("out of memory in dupstr()");
    return (strcpy(p,s));
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
    warning(msg);
    g_errors++;
    table_wrapup();
    exit (EXIT_FAILURE);
}


#if STDC
static void
error_pending(const char *msg)
#else
static void
error_pending(msg)
const char *msg;
#endif
{
    warning(msg);
    g_errors++;
    quit_flag = 1;
}


static void
free_hash_table(VOID_ARG)
{
    register size_t k;

    if (style_hash_table != (HASH_TABLE*)NULL)
    {
	for (k = 0; k < style_hash_table->hash_size; ++k)
	{ /* All hash_keys were dynamically allocated, so free them now */
	    if (style_hash_table->hash_table[k].hash_key != (const char*)NULL)
		FREE(style_hash_table->hash_table[k].hash_key);
	}
	hash_free(style_hash_table);
    }
}


static void
free_style_table(VOID_ARG)
{
    register size_t k;

    if (style_table.table != (Style*)NULL)
    {
	for (k = 0; k < style_table.size; ++k)
	    free_style_table_entry(&style_table.table[k]);
	FREE(style_table.table);
    }
}


#if STDC
static void
free_style_table_entry(Style *the_table)
#else
static void
free_style_table_entry(Style *the_table)
#endif
{
    /* WARNING: the code here MUST be matched by code in make_style_table_entry()! */
    if (the_table->name != (const char*)NULL)
	FREE(the_table->name);
    if (the_table->style != (const char*)NULL)
	FREE(the_table->style);
    the_table->name = (const char*)NULL;
    the_table->style = (const char*)NULL;
    the_table->style_length = 0;
    the_table->action = (StyleFunction)NULL;
}


void
generate_style_file(VOID_ARG)
{
    register int	k;
    size_t		longest_style_length;
    const char		**sorted_table;
    char		timestring[26];

#if    defined(OS_VMCMS)
    struct tm                   *the_timeval;
				/* clock value from time() for ctime() */
    the_timeval = time();
    (void)strcpy(timestring,ctime(the_timeval));
#else  /* NOT defined(OS_VMCMS) */
    time_t                      the_timeval;
				/* clock value from time() for ctime() */
    the_timeval = time((time_t*)NULL);
    (void)strcpy(timestring,ctime(&the_timeval));
#endif /* defined(OS_VMCMS) */

    sorted_table = (const char**)get_memory((VOIDP)NULL,
					    sizeof(const char*) * style_table.size);
    longest_style_length = get_longest_style_length();
    PRINTF("%%%% %s version %s date %s\n", PROGRAM, VERSION, DATE);
    PRINTF("%%%% User-modifiable style file generated on %s", timestring);
					/* NB: timestring[] has \n already */

    PRINTF("\n%%%% Uncomment the next line to clear all existing rules,\n");
    PRINTF("%%%% or leave it as a comment to preserve them:\n");
    PRINTF("%% default :\n");
    for (k = 0; default_style[k].style != (const char*)NULL; ++k)
	print_table_row(sorted_table, longest_style_length, default_style[k].style);

    FREE(sorted_table);

    print_arrays(longest_style_length);
}


#if defined(TAG_CACHE)
#if STDC
StyleFunction*
get_action_by_name(const char *key)
#else
StyleFunction*
get_action_by_name(key)
const char *key;
#endif
{
    Style *style;

    style = get_style_by_name(key);

    if (style == (Style*)NULL)
	return ((StyleFunction*)&other_tag);
    else
	return (&style->action);
}
#endif /* defined(TAG_CACHE) */


#if STDC
static char *
get_arg(char *line, char **next)
#else
static char *
get_arg(line, next)
char *line;
char **next;
#endif
{
    register char	*source;
    register char	*target;
    register int	quote;

    if (line == (char*)NULL)
	return ((char*)NULL);

    for ( ; *line && isspace(*line); ++line) /* skip leading space */
	NOOP;

    /* line now points to the start of the argument */

    quote = (int)(((*line == '\'') || (*line == '\"')) ? *line : '\0');

    if (quote)				/* point past opening quote */
	line++;

    /* Argument ends at next space or NUL following either a quoted string
       or a non-space token */
    for (source = target = line; *source ; ++source)
    {
	if (quote)			/* then inside quoted string */
	{
	    if ((source[-1] != ESCAPE_PREFIX) && (*source == quote))
	    {			/* quoted string ends, but maybe not argument */
		if (isspace(source[1]) || (source[1] == '\0'))
		    break;		/* then reached end of quoted string argument */
		quote = (int)(((*source == '\'') || (*source == '\"')) ? *source : '\0');
		if (!quote)
		   *target++ = *source;
	    }
	    else if ((source[-1] == ESCAPE_PREFIX) && (*source == quote))
	    {
		target--;		/* backup to overwrite ESCAPE_PREFIX */
		*target++ = *source;
	    }
	    else			/* continue collecting argument */
		*target++ = *source;
	}
	else if (isspace(*source))	/* then argument is complete */
	    break;
	else				/* continue collecting argument */
	    *target++ = *source;
    }

    *next = *source ? (source + 1) : (char*)NULL;

    *target = '\0';			/* terminate argument */

    return (line);
}


#if STDC
const char *
get_class_by_name(const char *key)
#else
const char *
get_class_by_name(key)
const char *key;
#endif
{
    Style *style;

    style = get_style_by_name(key);

    return ((style != (Style*)NULL) ? style->style : (const char *)NULL);
}


#if STDC
static char *
get_continued_line(char *line, size_t maxline, FILE *fpstyle,
		   const char *the_filename, int *p_style_line_number)
#else
static char *
get_continued_line(line, maxline, fpstyle, the_filename, p_style_line_number)
char		*line;
size_t		maxline;
FILE		*fpstyle;
const char	*the_filename
int		*p_style_line_number;
#endif
{
    char	*p;

    if (fgets(line, (int)maxline, fpstyle) == (char*)NULL)
	return ((char*)NULL);

    if (strchr(line,(int)'\n') != (char*)NULL)
	(*p_style_line_number)++;
    else
    {
#undef MSG_FMT
#define MSG_FMT "line too long for internal %d-character buffer at line %d of style file [%.2047s] "
	char tempmsg[sizeof(MSG_FMT) + 21 + 21 + 2047 + 1];

	SPRINTF(tempmsg, MSG_FMT, (int)maxline, *p_style_line_number,
		the_filename);
	error(tempmsg);
    }

    for (p = strchr(line,(int)'\0') - 2; *p == ESCAPE_PREFIX;
	 p = strchr(line,(int)'\0') - 2)
    {				/* collect continuation lines */
	int bytes_left;

	bytes_left = (int)(&line[0] + maxline - p);
	if (bytes_left > 0)
	{
	    if (fgets(p, bytes_left, fpstyle) == (char*)NULL)
	    {
#undef MSG_FMT
#define MSG_FMT "unexpected end-of-file while collecting continuation lines at line %d of style file [%.2047s]"
		char tempmsg[sizeof(MSG_FMT) + 21 + 2047 + 1];

		SPRINTF(tempmsg, MSG_FMT, *p_style_line_number,
			the_filename);
		error(tempmsg);
	    }
	}
	if ((bytes_left > 0) && (strchr(line,(int)'\n') != (char*)NULL))
	    (*p_style_line_number)++;
	else
	{
	    /* If we reach this point, then bytes_left <= 0,
	    or the line[] does not end in a newline: in either
	    case, line[] is already full */
#undef MSG_FMT
#define MSG_FMT "continued line too long for internal %d-character buffer, or lacks a newline, at line %d of style file [%.2047s]"
	    char tempmsg[sizeof(MSG_FMT) + 21 + 21 + 2047 + 1];

	    SPRINTF(tempmsg, MSG_FMT, (int)maxline, *p_style_line_number,
		    the_filename);
	    error(tempmsg);
	}
    }
    return (line);
}


static size_t
get_longest_style_length(VOID_ARG)
{
    register size_t	k;
    register size_t	longest_style_length;

    /* For neat output, we want to line up the name lists according to
       the length of the longest style name in style_table.table[].style. */

    for (longest_style_length = 0, k = 0; k < style_table.size; ++k)
    {
	if (style_table.table[k].style != (const char*)NULL)
	{
	    register size_t	m;

	    m = style_table.table[k].style_length;
	    if (m > longest_style_length)
		longest_style_length = m;
	}
    }
    return (longest_style_length);
}


#if STDC
static VOIDP
get_memory(VOIDP ptr, size_t size)
#else
static VOIDP
get_memory(ptr,size)
VOIDP ptr;
size_t size;
#endif
{
    /* allocate, or reallocate, memory, and return only if successful */

    if (ptr == (VOIDP)NULL)
	ptr = (VOIDP)malloc(size);
    else
	ptr = (VOIDP)realloc(ptr, size);
    if (ptr == (VOIDP )NULL)
	error("out of memory in get_memory()");
    return (ptr);
}


#if STDC
const char *
get_name_by_style(const char *style)
#else
const char *
get_name_by_style(style)
const char *style;
#endif
{
    register int k;			/* NB: must be signed! */
    register size_t style_len;

    if (style != (const char*)NULL)
    {
	style_len = strlen(style);
	for (k = (int)style_table.size - 1; k >= 0; --k)
	{	/* match style against style_table from newest to oldest */

	    /* WARNING: This loop is an important hot spot in
	       html-pretty.  Before optimization, a test using
	       htmlpty.html with -check-tag-nesting had 3,298,844 calls
	       to strcmp(), which was 92% of all calls to strcmp().

	       Adding the initial-character comparison optimization
	       reduced the number of calls to 1,766,756, that is, 54% of
	       the original number.

	       Modifying the Style structure to also hold the length of
	       the style string, and adding a length test reduced the
	       strcmp() call count to 127,012, just 4% of the original.

	       Total run time dropped by about 40%, which is a nice
	       payoff for hardly more than two lines of additional code
	       in this key statement!

	       The run-time penalty for an unprofiled optimized version
	       was a slowdown of 1.7 when -check-tag-nesting was selected. */

	    if ((style_table.table[k].style != (const char*)NULL) &&
		(style_table.table[k].style_length == style_len) &&	/* NB: important optimization */
		(*style_table.table[k].style == *style) && 		/* NB: important optimization */
		(strcmp(style_table.table[k].style+1, style+1) == 0))
		return (style_table.table[k].name);
	}
    }
    return ((const char*)NULL);
}


#if STDC
static Style *
get_style_by_name(const char *key)
#else
static Style *
get_style_by_name(key)
const char *key;
#endif
{
    HASH_ENTRY *h;

    h = hash_lookup(key, style_hash_table);

    return ((h == (HASH_ENTRY*)NULL) ? (Style*)NULL : (Style*)h->hash_data);
}


#if STDC
static Style *
get_style_by_style(const char *key)
#else
static Style *
get_style_by_style(key)
const char *key;
#endif
{
    register size_t k;

    for (k = 0; default_style[k].style != (const char*)NULL; ++k)
    {					/* match key against default styles */
	if (strcmp(default_style[k].style, key) == 0)
	    return (&default_style[k]);
    }

    return ((Style*)NULL);
}


#if STDC
static char*
get_token(const char *data_source, int style_line_number, char *name,
	  const char *set, char *overwritten_char)
#else
static char*
get_token(data_source, style_line_number, name, set, overwritten_char)
const char *data_source;
int style_line_number;
char *name;
const char *set;
char *overwritten_char;
#endif
{    /*	 Return next token from name[] made of chars in set[], or else
	 NULL.  Special case: if token begins with a character in
	 QUOTECHARS, then set[] is ignored, and the token is a quoted
	 string, INCLUDING the delimiting quotes. */
    register char *token;	/* pointer to start of token in name[] */
    register char *target;	/* pointer into target (overwritten in name[]) */

    for (token = name; token[0] && Is_Item_Separator(token[0]); ++token)
	NOOP;	/* move over leading item separators (whitespace or commas) */

    if (token[0] && (strchr(QUOTECHARS,(int)token[0]) != (char*)NULL))
    {				/* then collect a quoted string */
	register char quote;	/* opening quote character from QUOTECHARS */
	register char *source;	/* source pointer */

	quote = token[0];
	for (target = source = token + 1; *source; ++target, ++source)
	{   /* copy to closing quote, reducing escaped quotes */
	    if (*source == quote)
	    {
		if (target[-1] == ESCAPE_PREFIX) /* found escaped quote */
		   --target;		/* prepare to overwrite escape */
		else			/* found closing unescaped quote */
		{
		    *target = *source;	/* copy closing quote */
		    if (source > target)
			*source = ' ';	/* and leave a blank, NOT NUL, behind */
		    break;		/* and exit loop */
		}
	    }
	    if (target < source)	/* then have reduced an escape */
	    {
		*target = *source;	/* copy down */
		*source = ' ';	/* and leave a blank, NOT NUL, behind: a NUL */
				/* would prevent collection of the next token! */
	    }
	}
	if (target[0] == quote)		/* then string was properly closed */
	    target++; /* point past closing quote, ready for NUL termination */
	else				/* have unbalanced quotes, so issue */
	{				/* an error message and quit */
#undef MSG_FMT
#define MSG_FMT "unclosed quoted string [%.255s] at line %d in style source [%.2047s]"
	    char tempmsg[sizeof(MSG_FMT) + 255 + 21 + 2047 + 1];

	    SPRINTF(tempmsg, MSG_FMT, name, style_line_number, data_source);
	    error(tempmsg);
	}
    }
    else			/* collect unquoted token in character set[] */
    {
	for (target = token;
	     target[0] && (strchr(set,(int)target[0]) != (char*)NULL); ++target)
	    NOOP;			/* move over chars in set */
    }

    if (overwritten_char != (char*)NULL)
	*overwritten_char = target[0];	/* save previous contents */

    target[0] = '\0';			/* terminate token */

    return ((token == target) ? (char*)NULL : token);
}


#if STDC
INLINE static HASH_INT
hash(const char *key, const HASH_TABLE *table)
#else
INLINE static HASH_INT
hash(key,table)
const char		*key;
const HASH_TABLE	*table;	/* hash_table created by hash_alloc() */
#endif
{
    HASH_INT		hash_code;

    if (table == (HASH_TABLE*)NULL)
	return (0);			/* NULL table: no index available */

    /* This hash function gives a reasonably even distribution when
       tested against the UNIX spelling dictionary, /usr/dict/words. */
    for (hash_code = 0; *key; ++key)
	hash_code = (hash_code << 1) ^ (0xff & *key);

    return (hash_code % (table->hash_size));
}


#if STDC
static HASH_TABLE*
hash_alloc(HASH_INT size)
#else
static HASH_TABLE*
hash_alloc(size)	/* allocate, initialize, and return hash table */
HASH_INT	size;	/* minimum required size of hash table */
#endif
{
    HASH_INT	k;
    HASH_TABLE	*table;

    size = (HASH_INT)next_prime((long)size);	/* make hash size a prime for */
						/* good hash performance */

    /* allocate hash table */
    table = (HASH_TABLE*)get_memory((VOIDP)NULL, size*sizeof(HASH_TABLE));

    /* initialize hash table */
    table->hash_index = (HASH_INT)0;
    table->hash_size = (HASH_INT)size;
    table->hash_table = (HASH_ENTRY*)get_memory((VOIDP)NULL,
						size*sizeof(HASH_ENTRY));

    /* initialize hash entries */
    for (k = 0; k < size; ++k)
    {
	table->hash_table[k].hash_key = (const char*)NULL;
	table->hash_table[k].hash_data = (VOIDP)NULL;
    }

    return (table);
}


#if STDC
static HASH_ENTRY*
hash_next(
int		first,
HASH_TABLE	*table
)
#else /* NOT STDC */
static HASH_ENTRY*
hash_next(first,table)	/* return next non-empty entry from table, or NULL */
int		first;
HASH_TABLE	*table;
#endif /* STDC */
{
    if (table == (HASH_TABLE*)NULL)
	return ((HASH_ENTRY*)NULL);	/* NULL table is always empty */
    if (first)
	table->hash_index = 0;
    while (table->hash_index < table->hash_size)
    {
	if (table->hash_table[table->hash_index].hash_key != (const char*)NULL)
	    return (&table->hash_table[table->hash_index++]);
	else
	    table->hash_index++;
    }
    return ((HASH_ENTRY*)NULL);		/* end of table reached */
}


#if STDC
static void
hash_free(HASH_TABLE *table)
#else
static void
hash_free(table)
HASH_TABLE	*table;
#endif
{
    if (table != (HASH_TABLE*)NULL)
    {
	FREE(table->hash_table);
	FREE(table);
    }
}


#if STDC
static HASH_ENTRY*
hash_install(const char *key, VOIDP data, HASH_TABLE *table)
#else
static HASH_ENTRY*
hash_install(key,data,table)
const char	*key;		/* key string tagging data */
VOIDP		data;		/* data to install */
HASH_TABLE	*table;		/* hash_table created by hash_alloc() */
#endif
{
    HASH_ENTRY	*h;

    h = hash_lookup(key,table);
    if (h != (HASH_ENTRY*)NULL)
    {
	/* NB: in tex-pretty, we are guaranteed that keys are dynamically
	   allocated, so if we are replacing an old entry, we should
	   free it to prevent a memory leak.  If this code is used
	   elsewhere, the free() call MUST be eliminated. */
	if (h->hash_key != (const char*)NULL)
	    FREE(h->hash_key);
	h->hash_key = key;
	h->hash_data = data;
    }
    return (h);
}


#if STDC
INLINE static HASH_ENTRY*
hash_lookup(const char *key, HASH_TABLE *table)
#else
INLINE static HASH_ENTRY*
hash_lookup(key,table)		/* return (maybe empty) entry for key, */
				/* or NULL if table full */
const char	*key;		/* key string to search for */
HASH_TABLE	*table;		/* hash_table created by hash_alloc() */
#endif
{
    HASH_ENTRY	*h = (HASH_ENTRY*)NULL;
    HASH_INT	n;
    HASH_INT	probes;

    if (table == (HASH_TABLE*)NULL)	/* NULL table has no entries */
	return ((HASH_ENTRY*)NULL);

    n = hash(key,table);		/* initial hash index */

    for (probes = 1; probes <= table->hash_size; ++probes)
    {
	if (table->hash_table[n].hash_key == (const char*)NULL)
	{
	    h = &table->hash_table[n];	/* not in table */
	    break;
	}
	else if ((*table->hash_table[n].hash_key == *key) && /* NB: important optimization */
		 (strcmp(table->hash_table[n].hash_key+1, key+1) == 0))
	{
	    h = &table->hash_table[n];	/* have entry in table */
	    break;
	}
	else
	{
	    n++;			/* linear probe to next entry */
	    if (n >= table->hash_size)
		n = (HASH_INT)0;
	}
    }
    return (h);
}


void
make_hash_table(VOID_ARG)
{
    register size_t k;

    /* Install "style : name" pairs in the style_hash_table keyed by
       name, so that we can rapidly locate a style given the name.
       However, exclude "array[name] : value" entries from the hash
       table. */

    free_hash_table();			/* discard any previous hash table */

    style_hash_table = hash_alloc((HASH_INT)(10 + (style_table.size / 8) * 10));
					/* want table about 80% full */

    if (style_hash_table == (HASH_TABLE*)NULL)
	error("out of memory in make_hash_table()");

    for (k = 0; k < style_table.size; ++k)
    {
	if ((style_table.table[k].name != (const char*)NULL) &&
	    !Is_Array_Style(style_table.table[k].style))
	    (void)hash_install(get_macro(style_table.table[k].name),
			       (VOIDP)&style_table.table[k],
			       style_hash_table);
    }
}


void
initialize(VOID_ARG)
{
    int			k;

#if defined(IBM_PC)
    /* On IBM PC DOS, use binary mode for stdin and stdout, so that Ctl-Z */
    /* does not mean end-of-file on input, and so that Ctl-M Ctl-J is not */
    /* written at end-of-line on output, causing doubled Ctl-M characters. */
    (void)setmode(fileno(stdin), O_BINARY);
    (void)setmode(fileno(stdout), O_BINARY);
#endif

    g_errors = 0;
#if defined(TeX_PRETTY)
    post_output_action = do_nothing;	/* prevent argument handling */

#define WRAP_BEFORE_CHARS " [<{("	/* ")}>]" for balance */
    {
	unsigned const char *p;

	for (p = (unsigned const char *)WRAP_BEFORE_CHARS; *p; ++p)
	    wrap_before_chars[*p] = 1;
    }
#endif /* defined(TeX_PRETTY) */

    for (k = 0; builtin_style[k] != (const char*)NULL; ++k)
    {
	char line[MAXBUF+2];		/* space for two trailing NULs */

	(void)strcpy(line,builtin_style[k]); /* get modifiable copy */
	do_style_line("internal-table", k, line);
    }
}


#if STDC
char *
lowercase(char *s)
#else
char *
lowercase(s)
char *s;
#endif
{
    char *org_s;

    if (s != (char*)NULL)
    {
	for (org_s = s ; *s ; ++s)
	{
	    if (isupper(*s))
		*s = tolower(*s);
	}
    }
    return (org_s);
}


#if STDC
static void
make_style_table_entry(Style *the_table, const char *the_style,
		       const char *the_name, StyleFunction the_action)
#else
static void
make_style_table_entry(the_table, the_style, the_name, the_action)
Style		*the_table;
const char	*the_style;
const char	*the_name;
StyleFunction	the_action;
#endif
{
    /* WARNING: the code here MUST be matched by code in free_style_table_entry()! */
    the_table->name = (const char*)dupstr(the_name);
    the_table->style = (const char*)dupstr(the_style);
    the_table->style_length = strlen(the_table->style);	/* NB: important optimization */
    the_table->action = the_action;
}


static long
#if STDC
next_prime(
long n
)
#else
next_prime(n)			/* return next prime at or after n */
long n;
#endif
{
    long	factor;			/* prime factor */
    int		is_prime;		/* 'prime' is a prime number */
    long	prime;			/* tentative prime */

    n = (n < 0L) ? -n : n;		/* be safe -- force n positive */
    prime = 2L*(n/2L) + 1L;		/* next odd number */
    is_prime = (prime <= 3L);
    while (!is_prime)
    {
	factor = 5L;
	is_prime = (prime % 2L) && (prime % 3L);
	while (is_prime && (factor*factor <= prime))
	{
	    if ((prime % factor) == 0L)
		is_prime = 0;
	    else if ((prime % (factor + 2L)) == 0L)
		is_prime = 0;
	    else	/* factor+4 is divisible by 3 (every 3rd odd is) */
		factor += 6L;
	}
	if (!is_prime)
	    prime += 2L;
    }
    return (prime);
}


#if STDC
static void
normalize_space(char *s)
#else
static void
normalize_space(s)
char *s;
#endif
{
    char *p;
    char *q;

    /* Remove leading and trailing space in s[], and reduce multiple
       spaces to single ones, and then add a single trailing space. */

    for (q = p = s; isspace(*p); ++p)
	NOOP;				/* trim leading space */
    while (*p)
    {
	*q++ = *p;			/* copy character */
	if (isspace(*p))
	{
	    while (*p && isspace(*p))	/* skip duplicate spaces */
		p++;
	}
	else				/* just advance one character */
	    p++;
    }
    *q++ = ' ';				/* supply single trailing space */
    *q = '\0';				/* and terminate string */
}


#if STDC
static void
print_arrays(size_t longest_style_length)
#else
static void
print_arrays(longest_style_length)
size_t		longest_style_length;
#endif
{
    register size_t	m;
    register size_t	m_sorted;
    const char		**sorted_array_table;
    const char		**sorted_value_table;

    sorted_array_table = (const char**)get_memory((VOIDP)NULL,
						  sizeof(const char*) * style_table.size);
    sorted_value_table = (const char**)get_memory((VOIDP)NULL,
						  sizeof(const char*) * style_table.size);

    /* Make a pass through the hash table to find all unique `style'
       names which are not in default_style[].style, as evidenced by
       NULL values of style->action, and store them in
       sorted_array_table[].  These entries represent style-file triples
       of the form "array[name] = value".  Because there may be many
       triples with the same "array[name]" `style', we need to check for
       duplicates in the sorted_array_table[] before storing a new entry
       there. */

    for (m_sorted = 0, m = 0; m < style_table.size; ++m)
    {
	if ((style_table.table[m].action == (StyleFunction)NULL) &&
	    (style_table.table[m].style != (const char*)NULL))
	{
	    register int found_duplicate;
	    register int k;

	    for (found_duplicate = 0, k = 0; (k < m_sorted) && !found_duplicate; ++k)
		found_duplicate = (strcmp(style_table.table[m].style, sorted_array_table[k]) == 0);
	    if (!found_duplicate)
		sorted_array_table[m_sorted++] = style_table.table[m].style;
	}
    }

    if (m_sorted >= 1)		/* have at least one "array[name] = value" */
    {
	/* Now print a sorted list of values, ordered by "array[name]" */
	qsort(sorted_array_table, m_sorted, sizeof(const char*),
	      (int (*) ARGS((const VOIDP,const VOIDP)))compare_strings);
	PRINTF("\n%%%% Array definitions:\n");
	for (m = 0; m < m_sorted; ++m)
	    print_table_row(sorted_value_table, longest_style_length,
			    sorted_array_table[m]);
    }

    FREE(sorted_array_table);
    FREE(sorted_value_table);
}


#if STDC
static void
print_indentation(size_t indentation_count)
#else
static void
print_indentation(indentation_count)
size_t indentation_count;
#endif
{
    register size_t k;

    for (k = 0; k < indentation_count; ++k)
	PRINTF(" ");
}


#if STDC
static void
print_table_row(const char **sorted_table, size_t longest_style_length,
		const char *the_style)
#else
static void
print_table_row(sorted_table, longest_style_length, the_style)
const char	**sorted_table;
size_t		longest_style_length;
const char	*the_style;
#endif
{
    register HASH_ENTRY	*h;
    register size_t	line_length;
    register size_t	m;
    register size_t	m_sorted;
    char 		*value;

    value = (char*)NULL;
    if (Is_Array_Style(the_style)) /* array[name] : value */
    {			/* so lookup in style_table */
	register int	k; /* loop index: SIGNED integer, since we count down past zero */

	for (m_sorted = 0, k = (style_table.size - 1); k >= 0; --k)
	{		/* find only LAST matching entry in style_table.table[] */
			/* since the last entered is the one that holds */
	    if (strcmp(style_table.table[k].style, the_style) == 0)
	    {
		register char *p;

		/* copy words in value into sorted_table[], but do NOT sort it! */
		value = dupstr(style_table.table[k].name);
		for (p = strtok(value,WHITESPACE); p != (char*)NULL;
		     p = strtok((char*)NULL,WHITESPACE))
		    sorted_table[m_sorted++] = p;
		break;
	    }
	}
    }
    else		/* style : name name name */
    {			/* so lookup name:style pairs in hash table */
	/* Make a pass through the hash table to find all names in this
	   style class, and store them in sorted_table[] */
	for (m_sorted = 0, h = hash_next(1,style_hash_table);
	     (h != (HASH_ENTRY*)NULL);
	     h = hash_next(0,style_hash_table))
	{
	    Style *style;

	    style = (Style*)(h->hash_data);
	    if (strcmp(the_style,style->style) == 0)
		sorted_table[m_sorted++] = style->name;
	}
	qsort(sorted_table, m_sorted, sizeof(const char*),
	      (int (*) ARGS((const VOIDP,const VOIDP)))compare_strings);
    }

    PRINTF("\n%s :",the_style);
    line_length = strlen(the_style) + 2;

    print_indentation((longest_style_length + 2) - line_length);
    line_length = (longest_style_length + 2);

    for (m = 0; m < m_sorted; ++m)
    {
	line_length += 1 + strlen(sorted_table[m]);
	if (line_length > (max_width - 2)) /* need room for final " \" */
	{			/* then need to continue this long line */
	    PRINTF(" \\\n");
	    line_length = longest_style_length + 2;
	    print_indentation(line_length);
	    line_length += 1 + strlen(sorted_table[m]);
	}
	PRINTF(" %s",sorted_table[m]);
    }
    PRINTF("\n");

    if (value != (char*)NULL)		/* then we allocated memory for tokenizing */
	FREE(value);
}


static void
show_styles(VOID_ARG)
{
    static int 	first = 1;
    int		k;
    int		line_length;
    int		styles_on_line;

    if (first)
    {
	FPRINTF(stderr,"The recognized style classes are:\n\t");
	line_length = 8;		/* account for tab */
	for (k = 0, styles_on_line = 0;
	     default_style[k].style != (const char*)NULL;
	     ++k, ++styles_on_line)
	{
	    if (styles_on_line > 0)
		line_length++;		/* account for space separator */
	    line_length += default_style[k].style_length;
	    if (line_length > max_width)
	    {
		FPRINTF(stderr,"\n\t");
		styles_on_line = 0;
		line_length = 8;	/* account for tab */
		line_length += default_style[k].style_length;
	    }
	    FPRINTF(stderr, "%s%s", ((styles_on_line == 0) ? "" : " "),
		    default_style[k].style);
	}
	FPRINTF(stderr,"\n");
    }
    first = 0;
}


#if STDC
static const char*
style_of_name(const char* name)
#else
static const char*
style_of_name(name)
const char* name;
#endif
{	/* return a pointer to the style of a name, or the name, if no style,
	   in a static internal buffer */
    static char style_buffer[MAXTOKENLENGTH + 1];

    style_buffer[0] = '\0';		/* initialize to empty string and */
    style_buffer[sizeof(style_buffer)-1] = '\0';
					/* to guarantee strncpy() termination */

    if (name != (const char*)NULL)
    {
#if defined(HTML_PRETTY)
	/* Map a tag into its style: this relies on the style name space
	   being disjoint from the tag name space, which is not a
	   problem, since style names are lowercase, and tag names are
	   UPPERCASE.

	   I considered, and rejected, using angle brackets to
	   distinguish the two: <TAG> vs style, because that is
	   impossible on the command-line on PC DOS, and inadvisable in
	   UNIX, since failure to properly quote the angle brackets can
	   result in unintentional file overwriting. */

	{
	    int		k;
	    Style	*style;

	    for (k = (int)style_table.size - 1; k >= 0; --k)
	    {		/* Search newest to oldest entries, but */
			/* NB: if delete_style() was called, */
			/* some of the entries may be NULL! */
		style = &style_table.table[k];
		if ((style != (Style*)NULL) &&
		    (style->name != (const char*)NULL) &&
		    (strcmp(style->name,name) == 0))
		    break;
	    }
	    if (k < 0)			/* then search failed */
		style = (Style*)NULL;
	    if (style == (Style*)NULL)	/* then just use name */
		(void)strncpy(style_buffer,name,sizeof(style_buffer)-1);
	    else			/* use style of name */
		(void)strncpy(style_buffer,style->style,sizeof(style_buffer)-1);

	}
#endif /* defined(HTML_PRETTY) */

#if defined(TeX_PRETTY)
	(void)strncpy(style_buffer,name,sizeof(style_buffer)-1);
#endif /* defined(TeX_PRETTY) */

    }
    return ((const char*)&style_buffer[0]);
}


#if STDC
char *
strip_comment(char *line)
#else
char *
strip_comment(line)
char *line;
#endif
{	/* Strip comments from non-escaped percent to end of line, */
	/* reduce escaped percent to percent, and return pointer to line. */
    register char *p;
    register char *q;

    for (p = q = &line[0]; p[0]; ++p, ++q)
    {
	if (p[0] == '%')		/* possible comment start */
	{
	    if ((p > &line[0]) && (p[-1] != ESCAPE_PREFIX))
		break;			/* comment inside line */
	    else if (p == &line[0])	/* comment at start of line */
		break;
	    else if ((p > &line[0]) && (p[-1] == ESCAPE_PREFIX))
		q--;			/* backup to overwrite ESCAPE_PREFIX */
	}
	*q = *p;
    }
    *q = 0;
    return (&line[0]);
}


void
table_wrapup(VOID_ARG)
{
    free_hash_table();			/* NB: order here is CRITICAL: free */
    free_style_table();			/* hash table BEFORE style table! */
}


#if STDC
char *
uppercase(char *s)
#else
char *
uppercase(s)
char *s;
#endif
{
    char *org_s;

    if (s != (char*)NULL)
    {
	for (org_s = s ; *s ; ++s)
	{
	    if (islower(*s))
		*s = toupper(*s);
	}
    }
    return (org_s);
}

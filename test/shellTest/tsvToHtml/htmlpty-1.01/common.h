#if !defined(COMMON_H)
#define COMMON_H 1
#include <stdc.h>			/* NB: must be included AFTER */
					/* all system header files, to */
					/* avoid inconsistent definitions */
					/* of const */
#define HTML_PRETTY	1

#define DEFAULT_PROGRAM_NAME		"htmlpty"

#if defined(IBM_PC)
#define MAXBUF_MIN		1536
#else
#define MAXBUF_MIN		2048
#endif

#if !defined(MAXBUF)
#define MAXBUF			MAXBUF_MIN	/* can override at compile time */
#endif

#if ((MAXBUF) < MAXBUF_MIN)
#undef MAXBUF
#define MAXBUF			MAXBUF_MIN /* but guarantee a minimum: see man pages; */
					/* must be at least LITLEN from html.decl. */
					/* LITLEN used to be 1024, but HTML 4.0 */
					/* required an increase to at least 1075. */
					/* The value MAXBUF-1 appears in numerous */
					/* MSG_FMT strings and tempmsg[] dimension */
					/* expressions in at least htmlpty.l and */
					/* table.c, so if this value is increased */
					/* permanently, all of those constants should */
					/* be adjusted. Failure to do so may result in */
					/* (harmless) truncation of strings in warning */
					/* and error messages.  There is no portable */
					/* way to incorporate preprocessor-time numeric */
					/* values in strings prior to Standard C. */
#endif

#if !defined(MAXLISTNEST)
#define MAXLISTNEST	100		/* can override at compile time */
#endif

#if ((MAXLISTNEST) < 100)
#undef MAXLISTNEST
#define MAXLISTNEST		100	/* but guarantee a reasonable value */
					/* must be at least TAGLVL from html.decl */
#endif

#define MAXTAGNEST		(MAXLISTNEST)

#if !defined(MAXTOKENLENGTH)
#define MAXTOKENLENGTH		(MAXBUF) /* can override at compile time */
#endif

#if ((MAXTOKENLENGTH) < (MAXBUF))
#undef MAXTOKENLENGTH
#define MAXTOKENLENGTH		(MAXBUF) /* but guarantee a minimum: see man pages */
					/* must be at least LITLEN from html.decl */
#endif

#if !defined(MAXWIDTH)
#define MAXWIDTH		72	/* can override at compile time */
#endif

#if ((MAXWIDTH) < 72)
#undef MAXWIDTH
#define MAXWIDTH		72	/* but guarantee a minimum: see man pages */
#endif

#define NOOP	/* NO-OP */

/* Careful: some systems (e.g. HP-UX 9.0) have ridiculously small
FILENAME_MAX values, so we insist that a filename buffer size be at
least MAXBUF. */
#if !defined(FILENAME_MAX)
#define FILENAME_MAX		(MAXBUF)/* can override at compile time */
#endif

#if ((FILENAME_MAX) < MAXBUF)
#undef FILENAME_MAX
#define FILENAME_MAX		(MAXBUF)/* but guarantee a minimum: see man pages */
#endif

#if defined(HAVE_VOIDP)
#define VOIDP 			void*
#else
#define VOIDP 			char*
#endif

#define PRINTF		(void)printf
#define FPRINTF		(void)fprintf
#define SPRINTF		(void)sprintf
#define FREE(p)		free((VOIDP)(p))
#define WHITESPACE	" \f\n\r\t\013"

#if defined(c_plusplus) && !defined(__cplusplus)
#define __cplusplus 1			/* want modern-C++-style identifier */
#endif

#if defined(__cplusplus)
#define INLINE inline
#else
#define INLINE
#endif

#if defined(__cplusplus)
#define C_DECL_BEGIN		extern "C" {
#define C_DECL_END		}
#else
#define C_DECL_BEGIN
#define C_DECL_END
#endif

#if !defined(HAVE_GETLOGIN_DECL)
#if defined(HAVE_GETLOGIN_IN_CPLUSPLUS)
char *getlogin ARGS((void));
#else
C_DECL_BEGIN
char *getlogin ARGS((void));
C_DECL_END
#endif
#endif

#if !defined(HAVE_GETHOSTNAME_DECL)
#if defined(HAVE_GETHOSTNAME_IN_CPLUSPLUS)
int gethostname ARGS((char *name, int namelen));
#else
C_DECL_BEGIN
int gethostname ARGS((char *name, int namelen));
C_DECL_END
#endif
#endif

#if defined(MSDOS)|| defined(_MSDOS)|| defined(__MSDOS__)|| defined(__TURBOC__)
#undef IBM_PC
#define IBM_PC
#endif

#endif /* !defined(COMMON_H) */

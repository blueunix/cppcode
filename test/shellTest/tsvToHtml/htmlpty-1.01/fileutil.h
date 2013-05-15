#if !defined(FILEUTIL_H)
#define FILEUTIL_H 1

extern const char	*file_of ARGS((const char* filename));
extern const char *	makefilename ARGS((const char *drive,
					   const char *path,
					   const char *pathsep,
					   const char *prefix,
					   const char *basefile,
					   const char *suffix,
					   const char *pathsuffix));
extern const char	*parent_of ARGS((const char* filename));
extern const char	*path_of ARGS((const char* filename));
extern const char 	*program_name ARGS((void));
extern const char 	*systemdir ARGS((void));
extern FILE		*tfopen ARGS((const char *file,const char *mode));
extern FILE		*tfreopen ARGS((const char *file,const char *mode,
					FILE *oldfp));

#if defined(IBM_PC)
#define DEFAULT_DIRSEP		       	"\\"
#define DEFAULT_PARENT			"..\\"
#define DEFAULT_SYSPATH			getenv("PATH")
#define DEFAULT_SYSPATHSEP       	";"
#define DEFAULT_HOME			"c:\\"
#define DEFAULT_DRIVE			""
#define DEFAULT_PATH			""
#define DEFAULT_PATHSEP			""
#define DEFAULT_PREFIX			""
#define DEFAULT_BASENAME		program_name()
#define DEFAULT_SUFFIX			".ini"
#define DEFAULT_PATHSUFFIX		""
#define OPTION_PREFIX(c)		( ((c) == '-') || ((c) == '/') )
#else
#if defined(VMS)
#define DEFAULT_DIRSEP		/*[*/ 	":]"
#define DEFAULT_PARENT			"[-]"
#define DEFAULT_SYSPATH			"SYS$SYSTEM:"
#define DEFAULT_SYSPATHSEP       	""
#define DEFAULT_HOME			"SYS$LOGIN:"
#define DEFAULT_DRIVE			""
#define DEFAULT_PATH			""
#define DEFAULT_PATHSEP			""
#define DEFAULT_PREFIX			""
#define DEFAULT_BASENAME		program_name() /* NB: small memory leak */
#define DEFAULT_SUFFIX			".ini"
#define DEFAULT_PATHSUFFIX		""
#define OPTION_PREFIX(c)		( ((c) == '-') || ((c) == '/') )
#else  /* supply UNIX-like defaults */
#define DEFAULT_DIRSEP		       	"/"
#define DEFAULT_PARENT			"../"
#define DEFAULT_SYSPATH			getenv("PATH")
#define DEFAULT_SYSPATHSEP       	":"
#define DEFAULT_HOME			getenv("HOME")
#define DEFAULT_DRIVE			""
#define DEFAULT_PATH			""
#define DEFAULT_PATHSEP			"/"
#define DEFAULT_PREFIX			"."
#define DEFAULT_BASENAME		program_name() /* NB: small memory leak */
#define DEFAULT_SUFFIX			"rc"
#define DEFAULT_PATHSUFFIX		""
#define OPTION_PREFIX(c)		((c) == '-')
#endif /* defined(VMS) */
#endif /* defined(IBM_PC) */

#if defined(IBM_PC)
/* On the IBM PC, we process files in binary mode, so that Ctl-Z does
not act as an end-of-file mark. */
#define RMODE "rb"
#define WMODE "wb"
#else  /* not IBM_PC */
#define RMODE "r"
#define WMODE "w"
#endif /* IBM_PC */

#if defined(IBM_PC)

#if defined(HAVE_FCNTL_H)
#include <fcntl.h>			/* for O_BINARY in setmode() call */
#endif

#if defined(HAVE_IO_H)
#include <io.h>				/* for setmode() prototypes */
#endif

#if defined(_O_BINARY) && !defined(O_BINARY)
/* Microsoft C version 7.0 requires leading underscore on these symbols
in Standard C mode (command-line -Za switch).  Versions 5.0, 5.1, and
6.0 do not use the leading underscore.  */
#define O_BINARY _O_BINARY
#define setmode _setmode
#endif /* defined(_O_BINARY) && !defined(O_BINARY) */

#endif /* IBM_PC */

#endif /* !defined(FILEUTIL_H) */

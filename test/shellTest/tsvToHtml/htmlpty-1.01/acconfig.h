/* acconfig.h

Entries in this file provide defaults for preprocessor symbols that
autoconf does not already know about in its
/usr/local/share/autoconf/acconfig.h file.  They are inserted in the
config.h.in file by the autoheader utility.

Contrary to the autoconf 2.12 documentation in Node: Invoking
autoheader, at least one of the <at>TOP<at> or <at>BOTTOM<at> markers
must be present.  If both are omitted, then the contents of this file
are lost.
*/

@BOTTOM@

/* Define cast of ctime() argument: const time_t* or long* */
#undef CTIME_ARG_IS_TIME_T_POINTER

#if defined(CTIME_ARG_IS_TIME_T_POINTER)
#define CTIME_CAST	const time_t*
#else
#define CTIME_CAST	long*
#endif

/* Define if getlogin() is available */
#undef HAVE_GETLOGIN

/* Define if getlogin() is declared (in unistd.h) */
#undef HAVE_GETLOGIN_DECL

/* Define if getlogin() is a C++ function (else C) */
#undef HAVE_GETLOGIN_IN_CPLUSPLUS

/* Define if gethostname() is available */
#undef HAVE_GETHOSTNAME

/* Define if gethostname() is declared (in unistd.h??) */
#undef HAVE_GETHOSTNAME_DECL

/* Define if gethostname() is a C++ function (else C) */
#undef HAVE_GETHOSTNAME_IN_CPLUSPLUS

/* Define if getpwnam() is available */
#undef HAVE_GETPWNAM

/* Define if getpwnam() is declared (in unistd.h??) */
#undef HAVE_GETPWNAM_DECL

/* Define if getpwnam() is a C++ function (else C) */
#undef HAVE_GETPWNAM_IN_CPLUSPLUS

/* Define if getpwnam() is available */
#undef HAVE_GETPWUID

/* Define if getpwnam() is declared (in unistd.h??) */
#undef HAVE_GETPWUID_DECL

/* Define if getpwnam() is a C++ function (else C) */
#undef HAVE_GETPWUID_IN_CPLUSPLUS

/* Define if getgetuid() is available */
#undef HAVE_GETUID

/* Define if getuid() is declared (in unistd.h??) */
#undef HAVE_GETUID_DECL

/* Define if getuid() is a C++ function (else C) */
#undef HAVE_GETUID_IN_CPLUSPLUS

/* Define if compiler supports ANSI/ISO Standard C function prototypes */
#undef HAVE_STDC_PROTOTYPES

/* Define if void* pointers are supported */
#undef HAVE_VOIDP

/* Define with program name as a string literal */
#undef PACKAGE

/* Define if the compiler accepts ANSI/ISO Standard C */
#undef STDC

/* Define with program version number as a string literal */
#undef VERSION

#include <confix.h>		/* fixups for config.h errors (mostly for C++) */

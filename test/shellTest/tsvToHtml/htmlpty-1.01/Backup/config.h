/* config.h.  Generated automatically by configure.  */
/* config.hin.  Generated automatically from configure.in by autoheader.  */

/* Define to empty if the keyword does not work.  */
/* #undef const */

/* Define if you need to in order for stat and other things to work.  */
/* #undef _POSIX_SOURCE */

/* Define to `unsigned' if <sys/types.h> doesn't define.  */
/* #undef size_t */

/* Define if you have the ANSI C header files.  */
#define STDC_HEADERS 1

/* Define if you have the strtok function.  */
#define HAVE_STRTOK 1

/* Define if you have the <ctype.h> header file.  */
#define HAVE_CTYPE_H 1

/* Define if you have the <fcntl.h> header file.  */
#define HAVE_FCNTL_H 1

/* Define if you have the <io.h> header file.  */
/* #undef HAVE_IO_H */

/* Define if you have the <jsys.h> header file.  */
/* #undef HAVE_JSYS_H */

/* Define if you have the <libc.h> header file.  */
/* #undef HAVE_LIBC_H */

/* Define if you have the <limits.h> header file.  */
#define HAVE_LIMITS_H 1

/* Define if you have the <pwd.h> header file.  */
#define HAVE_PWD_H 1

/* Define if you have the <stdio.h> header file.  */
#define HAVE_STDIO_H 1

/* Define if you have the <stdlib.h> header file.  */
#define HAVE_STDLIB_H 1

/* Define if you have the <string.h> header file.  */
#define HAVE_STRING_H 1

/* Define if you have the <sys/types.h> header file.  */
#define HAVE_SYS_TYPES_H 1

/* Define if you have the <sys/utsname.h> header file.  */
#define HAVE_SYS_UTSNAME_H 1

/* Define if you have the <time.h> header file.  */
#define HAVE_TIME_H 1

/* Define if you have the <unistd.h> header file.  */
#define HAVE_UNISTD_H 1

/* Define cast of ctime() argument: const time_t* or long* */
#define CTIME_ARG_IS_TIME_T_POINTER 1

#if defined(CTIME_ARG_IS_TIME_T_POINTER)
#define CTIME_CAST	const time_t*
#else
#define CTIME_CAST	long*
#endif

/* Define if getlogin() is available */
#define HAVE_GETLOGIN 1

/* Define if getlogin() is declared (in unistd.h) */
#define HAVE_GETLOGIN_DECL 1

/* Define if getlogin() is a C++ function (else C) */
#define HAVE_GETLOGIN_IN_CPLUSPLUS 1

/* Define if gethostname() is available */
#define HAVE_GETHOSTNAME 1

/* Define if gethostname() is declared (in unistd.h??) */
/* #undef HAVE_GETHOSTNAME_DECL */

/* Define if gethostname() is a C++ function (else C) */
#define HAVE_GETHOSTNAME_IN_CPLUSPLUS 1

/* Define if getpwnam() is available */
#define HAVE_GETPWNAM 1

/* Define if getpwnam() is declared (in unistd.h??) */
#define HAVE_GETPWNAM_DECL 1

/* Define if getpwnam() is a C++ function (else C) */
#define HAVE_GETPWNAM_IN_CPLUSPLUS 1

/* Define if getpwnam() is available */
#define HAVE_GETPWUID 1

/* Define if getpwnam() is declared (in unistd.h??) */
#define HAVE_GETPWUID_DECL 1

/* Define if getpwnam() is a C++ function (else C) */
#define HAVE_GETPWUID_IN_CPLUSPLUS 1

/* Define if getgetuid() is available */
#define HAVE_GETUID 1

/* Define if getuid() is declared (in unistd.h??) */
#define HAVE_GETUID_DECL 1

/* Define if getuid() is a C++ function (else C) */
#define HAVE_GETUID_IN_CPLUSPLUS 1

/* Define if compiler supports ANSI/ISO Standard C function prototypes */
#define HAVE_STDC_PROTOTYPES 1

/* Define if void* pointers are supported */
#define HAVE_VOIDP 1

/* Define with program name as a string literal */
#define PACKAGE "htmlpty"

/* Define if the compiler accepts ANSI/ISO Standard C */
#define STDC 1

/* Define with program version number as a string literal */
#define VERSION "1.00"

#include <confix.h>		/* fixups for config.h errors (mostly for C++) */

/***********************************************************************
 @C-file{
    author              = "Nelson H. F. Beebe",
    version             = "1.00",
    date                = "28 November 1997",
    time                = "13:22:05 MST",
    filename            = "sysutil.c",
    address             = "Center for Scientific Computing
                           University of Utah
                           Department of Mathematics, 105 JWB
                           155 S 1400 E RM 233
                           Salt Lake City, UT 84112-0090
                           USA",
    telephone           = "+1 801 581 5254",
    FAX                 = "+1 801 581 4148",
    URL                 = "http://www.math.utah.edu/~beebe",
    checksum            = "43720 202 603 5702",
    email               = "beebe@math.utah.edu, beebe@acm.org,
                           beebe@ieee.org (Internet)",
    codetable           = "ISO/ASCII",
    keywords            = "prettyprinter, system utilities",
    supported           = "yes",
    docstring           = "This file provides support functions for
                           certain system-dependent facilities.

                           The checksum field above contains a CRC-16
                           checksum as the first value, followed by the
                           equivalent of the standard UNIX wc (word
                           count) utility output of lines, words, and
                           characters.  This is produced by Robert
                           Solovay's checksum utility.",
 }
***********************************************************************/

#include <config.h>			/* private header file */

#if defined(HAVE_PWD_H)
#include <pwd.h>
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

#if defined(HAVE_SYS_UTSNAME_H)
#include <sys/utsname.h>
#endif

#if defined(HAVE_UNISTD_H)
#include <unistd.h>
#endif

#if defined(unix) || defined(_unix) || defined(__unix) || defined(__unix__) \
	|| defined(_IBMR2)
#define UNIX
#if defined(__NeXT__)
#undef HAVE_UNAME
#if defined(__GNUG__)
#if defined(HAVE_LIBC_H)
#include <libc.h>
#endif
#else
/***********************************************************************
This ugliness of explicit declarations arises because the installation
of gcc 2.6.3 (and earlier) on the NeXT system searches vendor-provided
header files before gcc ones; the result is function prototype
conflicts.  They can be avoided if the code is compiled with an explicit
include-file path, such as
	-I/usr/local/lib/gcc-lib/m68k-next-nextstep3/2.6.3/include/bsd
but that is an ugly solution too, so instead we just provide copies of
the declarations from the gcc libc.h that we actually need.
***********************************************************************/
extern char	*getlogin(void);
extern uid_t    getuid(void);
extern int      gethostname(char *, int);
#endif
#else
#define HAVE_UNAME
#if defined(HAVE_UNISTD_H)
#include <unistd.h>
#endif
#endif
#else
#undef UNIX
#endif

#include <common.h>			/* private header file */
#include <sysutil.h>			/* private header file */

/**********************************************************************/


const char *
email_address(VOID_ARG)
{				/* return pointer to email address, or else NULL */
    const char 		*host;
    const char 		*user;

#undef MSG_FMT
#define MSG_FMT "%.39s@%.255s"
    static char		buffer[sizeof(MSG_FMT) + 39 + 255 + 1];

    host = host_name();
    user = login_name();
    if ((host != (const char*)NULL) && (user != (const char*)NULL))
    {
	SPRINTF(buffer, MSG_FMT, user, host);
	return ((const char*)&buffer[0]);
    }
    else
	return ((const char*)NULL);
}


const char *
host_name(VOID_ARG)
{				/* return pointer to host name, or else NULL */

#if defined(HAVE_SYS_UTSNAME_H)
    static struct utsname	uts;

    if (uname(&uts) < 0)
	(void)strcpy(uts.nodename,"");
    return ((const char*)&uts.nodename[0]);
#else
#if defined(HAVE_GETHOSTNAME)
    static char			hostname[256+1]; /* maximum host name length */

    if (gethostname(hostname, sizeof(hostname)) < 0)
	(void)strcpy(hostname, "");
    return ((const char*)&hostname[0]);
#else
    return ((const char *)NULL);
#endif
#endif /* defined(HAVE_SYS_UTSNAME_H) */

}


const char *
login_name(VOID_ARG)
{				/* return pointer to login name, or else NULL */
    const char *name;

#if defined(HAVE_PWD_H)
    static struct passwd *pwd;
#endif

#if defined(HAVE_GETLOGIN)
    name = (const char*)getlogin();
#else
    name = (const char*)NULL;
#endif

#if defined(HAVE_PWD_H) && defined(HAVE_GETPWNAM) && defined(HAVE_GETPWUID) && defined(HAVE_GETUID)
    pwd = (name == (const char*)NULL) ?
	(struct passwd *)getpwuid(getuid()) : (struct passwd *)getpwnam(name);
    name = (pwd != (struct passwd *)NULL) ?
	(const char*)pwd->pw_name : (const char*)NULL;
#endif

    return (name);
}


const char *
personal_name(VOID_ARG)
{				/* return pointer to personal name, or else NULL */
    const char *name;

#if defined(HAVE_PWD_H)
    static struct passwd *pwd;
#endif

#if defined(HAVE_GETLOGIN)
    name = (const char*)getlogin();
#else
    name = (const char*)NULL;
#endif

#if defined(HAVE_PWD_H) && defined(HAVE_GETPWNAM) && defined(HAVE_GETPWUID) && defined(HAVE_GETUID)
    pwd = (name == (const char*)NULL) ?
	(struct passwd *)getpwuid(getuid()) : (struct passwd *)getpwnam(name);
    name = (pwd != (struct passwd *)NULL) ?
	(const char*)pwd->pw_gecos : (const char*)NULL;
#endif

    return (name);

}

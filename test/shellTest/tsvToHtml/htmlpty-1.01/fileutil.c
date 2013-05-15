/***********************************************************************
 @C-file{
    author              = "Nelson H. F. Beebe",
    version             = "1.00",
    date                = "04 November 1997",
    time                = "19:30:26 MST",
    filename            = "fileutil.c",
    address             = "Center for Scientific Computing
                           University of Utah
                           Department of Mathematics, 105 JWB
                           155 S 1400 E RM 233
                           Salt Lake City, UT 84112-0090
                           USA",
    telephone           = "+1 801 581 5254",
    FAX                 = "+1 801 581 4148",
    URL                 = "http://www.math.utah.edu/~beebe",
    checksum            = "27329 354 1382 10948",
    email               = "beebe@math.utah.edu, beebe@acm.org,
                           beebe@ieee.org (Internet)",
    codetable           = "ISO/ASCII",
    keywords            = "file utilities, prettyprinter",
    supported           = "yes",
    docstring           = "This file contains a collection of functions
                           for manipulating file names on various operating
			   systems.

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

#include <common.h>			/* private header file */
#include <fileutil.h>			/* private header file */

extern char				**g_argv;
extern int				trace_flag;

#if STDC
const char*
file_of(const char* fullname)
#else
const char*
file_of(fullname)
const char* fullname;
#endif
{   /* Return a pointer to <filename> in a static copy of <fullname>
       treated as <path><filename>, or NULL if not found. */
    static char	buffer[FILENAME_MAX+1];
    char	*p;

    if (fullname == (const char*)NULL)
	return ((const char*)NULL);

    (void)strncpy(buffer, fullname, FILENAME_MAX);
    buffer[FILENAME_MAX] = '\0';	/* ensure termination */

    /* Scan backward to find first character in DEFAULT_DIRSEP */
    for (p = strchr(buffer,(int)'\0') - 1;
	(p >= &buffer[0]) && (strchr(DEFAULT_DIRSEP,(int)*p) == (char*)NULL); --p)
	NOOP;
    return ((const char*)(p + 1));
}


#if STDC
const char *
makefilename(const char *drive, const char *path, const char *pathsep,
	     const char *prefix, const char *basefile, const char *suffix,
	     const char *pathsuffix)
#else
const char *
makefilename(drive, path, pathsep, prefix, basefile, suffix, pathsuffix)
const char *drive;
const char *prefix;
const char *pathsep;
const char *path;
const char *basefile;
const char *suffix;
const char *pathsuffix;
#endif
{
    /*******************************************************************
    Construct a filename from argument concatenation as

	<drive><path><pathsep><prefix><basefile><suffix><pathsuffix>

    in an internal buffer, and return a pointer to it. However, if the
    required name is too long, then return NULL instead.  NULL arguments
    are treated like empty strings.

    Special exception: <pathsep> is omitted if <drive> and <path> are
    empty strings.

    This abstraction works for at least these operating systems:
	Amiga DOS
	Apple Macintosh MacOS
	Atari TOS
	DEC TOPS-10 and TOPS-20
	DEC VAX VMS and OpenVMS
	IBM OS/2
	IBM PC DOS
	IBM VM/CMS
	Microsoft Windows 3.x, 95, NT
	UNIX (all flavors)
	WWW URLs [too bad fopen() does not know about them (yet)!]
    *******************************************************************/

    /* Careful: some systems (e.g. HP-UX 9.0) have ridiculously small limits,
       so we insist that the filename buffer size be at least MAXBUF. */
#if defined(FILENAME_MAX) && ((FILENAME_MAX + 0) > MAXBUF)
    static char the_filename[FILENAME_MAX+1];
#else
    static char the_filename[MAXBUF+1];
#endif

    /* Convert NULL arguments to empty strings */
    if (drive      == (const char*)NULL) drive = "";
    if (path       == (const char*)NULL) path = "";
    if (pathsep    == (const char*)NULL) pathsep = "";
    if (prefix     == (const char*)NULL) prefix = "";
    if (basefile   == (const char*)NULL) basefile = "";
    if (suffix     == (const char*)NULL) suffix = "";
    if (pathsuffix == (const char*)NULL) pathsuffix = "";

    if ((strlen(drive) + strlen(path) + strlen(pathsep) + strlen(prefix) +
	 strlen(basefile) + strlen(suffix) + strlen(pathsuffix)) >=
	(sizeof(the_filename)/sizeof(the_filename[0])))
	return ((const char*)NULL);
    else				/* buffer is big enough */
    {
	if ((strcmp(drive,"") == 0) && (strcmp(path,"") == 0))
	    pathsep = "";		/* pathsep not needed when no drive or path */
	else if ((strlen(path) >= 1) && (strcmp(pathsep,strchr(path,(int)'\0')-1) == 0))
	    pathsep = "";		/* pathsep not needed when path ends in pathsep */
	SPRINTF(the_filename, "%s%s%s%s%s%s%s",
		drive, path, pathsep, prefix, basefile, suffix, pathsuffix);
	return ((const char*)&the_filename[0]);
    }
}


#if STDC
const char*
parent_of(const char* fullname)
#else
const char*
parent_of(fullname)
const char* fullname;
#endif
{   /* Return a pointer to the parent directory in <path> in a static copy
       of <fullname> treated as <path><filename>, or NULL if not found. */
    char	*p;
    char	*parent;

    if (fullname == (const char*)NULL)
	return ((const char*)NULL);

    parent = (char*)path_of(fullname);	/* NB: OK to cast const away! */

    /* Scan backward over chars in DEFAULT_DIRSEP */
    for (p = strchr(parent,(int)'\0') - 1;
	(p >= &parent[0]) && (strchr(DEFAULT_DIRSEP,(int)*p) != (char*)NULL); --p)
	*p = '\0';

    /* Scan backward to find first character in DEFAULT_DIRSEP */
    for (p = strchr(parent,(int)'\0') - 1;
	(p >= &parent[0]) && (strchr(DEFAULT_DIRSEP,(int)*p) == (char*)NULL); --p)
	*p = '\0';

    /* If we reduced parent to an empty string, then we have one of
       two special cases:
           parent_of("..") -> ""	(should be "..")
           parent_of("/")  -> "" 	(should be "/", equivalent to "..")
       In either case, we can use ".." as the return value, although
       this may lead us astray in the presence of symbolic links or
       mount points.  DEFAULT_PARENT has a suitable string for each
       supported file system type. */

    return ((const char*)((parent[0] == '\0') ? DEFAULT_PARENT : &parent[0]));
}


#if STDC
const char*
path_of(const char* fullname)
#else
const char*
path_of(fullname)
const char* fullname;
#endif
{   /* Return a pointer to <path> in a static copy of <fullname>
       treated as <path><filename>, or NULL if not found. */
    static char	buffer[FILENAME_MAX+1];
    char	*p;

    if (fullname == (const char*)NULL)
	return ((const char*)NULL);

    (void)strncpy(buffer, fullname, FILENAME_MAX);
    buffer[FILENAME_MAX] = '\0';	/* ensure termination */

    /* Scan backward to find first character in DEFAULT_DIRSEP */
    for (p = strchr(buffer,(int)'\0') - 1;
	(p >= &buffer[0]) && (strchr(DEFAULT_DIRSEP,(int)*p) == (char*)NULL); --p)
	*p = '\0';
    return (&buffer[0]);
}


const char*
program_name(VOID_ARG)
{   /* Return a pointer in a static internal buffer to the program name,
       excluding any leading path and trailing extension and version
       number. */
    static char buffer[FILENAME_MAX+1];
    char	*p;
    char	*q;

    (void)strncpy(buffer,
		  (g_argv[0] == (char*)NULL) ? DEFAULT_PROGRAM_NAME : file_of(g_argv[0]),
		  FILENAME_MAX);
    buffer[FILENAME_MAX] = '\0';	/* ensure termination */

    p = &buffer[0];

    /* In the interests of O/S portability, we require the program name to
       consist of characters in the set [A-Za-z0-9_-.;], and we discard
       any trailing part of it after [.;]. This reduces "foo.exe",
       "foo.exe.1", and "foo.exe;23" to just "foo". */
    for (q = strchr(p,(int)'\0') - 1; (q >= p); q--)
    {
	if (isalnum(*q) || (*q == '_') || (*q == '-'))
	    NOOP;
	else if ((*q == '.') || (*q == ';'))
	    *q = '\0';
	else
	    break;
    }
    return ((const char*)&q[1]);
}


const char *
systemdir(VOID_ARG)
{   /* Return a pointer in a static internal buffer to the directory
       path part of g_argv[0], if it is a file, treating it as a string
       <path><file>.  Otherwise, search the system path for the file
       g_argv[0], and if found, return a pointer to the directory path
       part.  Otherwise, return NULL. */
    const char	*filename;
    FILE	*fp;
    char	*path;
    static char	syspath[FILENAME_MAX+1];
    const char	*tmp_path;

    /* If g_argv[0] has a path component, try it as absolute path to a
       file. [If it has no path component, we must NOT look for it in
       the current directory.] */
    filename = g_argv[0];
    tmp_path = path_of(filename);
    if ((tmp_path != (const char*)NULL) &&
	(*tmp_path != '\0') &&
	((fp = tfopen(filename,"r")) != (FILE*)NULL))
	fclose(fp);
    else				/* try to find it in system path */
    {
	(void)strncpy(syspath, DEFAULT_SYSPATH, FILENAME_MAX);
	syspath[FILENAME_MAX] = '\0';	/* ensure string termination */

	for (path = strtok(syspath, DEFAULT_SYSPATHSEP);
	     (path != (char*)NULL) && *path;
	     path = strtok((char*)NULL, DEFAULT_SYSPATHSEP))
	{
	    filename = makefilename("", path, DEFAULT_PATHSEP,
				    "", g_argv[0], "", "");
	    if ((filename != (const char*)NULL) &&
		(fp = tfopen(filename,"r")) != (FILE*)NULL)
	    {
		fclose(fp);
		break;
	    }
	    filename = (const char*)NULL;
	}
    }
    return (path_of(filename));
}


#if STDC
FILE *
tfopen(const char *file,const char *mode)
#else
FILE *
tfopen(file,mode)
const char *file;
const char *mode;
#endif
{
    FILE *fp;

    if (trace_flag)
	FPRINTF(stderr,"%% open attempt on file [%s] mode [%s]: ",
		(file == (const char*)NULL) ? "??" : file,
		(mode == (const char*)NULL) ? "??" : mode);
    fp = fopen(file,mode);
    if (trace_flag)
	FPRINTF(stderr,"%s\n",((fp == (FILE*)NULL) ? "FAILED" : "OK"));
    return (fp);
}


#if STDC
FILE *
tfreopen(const char *file,const char *mode,FILE *oldfp)
#else
FILE *
tfopen(file,mode)
const char *file;
const char *mode;
#endif
{
    FILE *fp;

    if (trace_flag)
	FPRINTF(stderr,"%% open attempt on file [%s] mode [%s]: ",
		(file == (const char*)NULL) ? "??" : file,
		(mode == (const char*)NULL) ? "??" : mode);
    fp = freopen(file,mode,oldfp);
    if (trace_flag)
    {
	if (!((oldfp == stderr) && (fp == (FILE*)NULL)))
	    FPRINTF(stderr,"%s\n",((fp == (FILE*)NULL) ? "FAILED" : "OK"));
    }
    return (fp);
}

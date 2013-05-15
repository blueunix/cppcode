/***********************************************************************
[17-Apr-1995]
***********************************************************************/

#include <stdio.h>
#include <stdlib.h>

#ifndef EXIT_SUCCESS
#define EXIT_SUCCESS 0
#endif

#if defined(__STDC__) || defined(__cplusplus)
int
main(int argc, char* argv[])
#else
int
main(argc,argv)
int argc;
char* argv[];
#endif
{
    int c;

    while ((c = getchar()) != EOF)
	putchar(c);

    exit (EXIT_SUCCESS);
    return (EXIT_SUCCESS);
}

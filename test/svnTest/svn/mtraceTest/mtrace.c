#include <mcheck.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>


void __mtracer_on () __attribute__((constructor));
void __mtracer_off () __attribute__((destructor));
void __mtracer_on ()
{
    char *p=getenv("MALLOC_TRACE");
    char tracebuf[1023];
    if(!p)
        p="malloc_trace";
    sprintf(tracebuf, "%s.%d", p, getpid());
    setenv("MALLOC_TRACE",tracebuf, 1);
    atexit(&__mtracer_off);
    mtrace();
}

void __mtracer_off ()
{
    muntrace();
}


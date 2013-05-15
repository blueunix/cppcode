#if !defined(STDC_H)
#define STDC_H	1

/* NB: Careful: some compilers define __STDC__ to be 0, meaning
   non-Standard C */
#if 0 /* STDC is now automatically determined by configure and defined in config.h */
#if ((defined(__STDC__) && ((__STDC__ + 0) > 0)) || defined(__cplusplus))
#define STDC 1
#else
#define STDC 0
#endif
#else
#if !defined(STDC)
#define STDC 0
#endif
#endif /* 0 */

#if defined(HAVE_STDC_PROTOTYPES)
#define ARGS(plist) plist
#else
#define ARGS(plist) ()
#endif

#if STDC
#if defined(HAVE_STDLIB_H)
#include <stdlib.h>
#endif
#define VOID_ARG	void
#else
#define const
#define VOID_ARG
#endif

#if !defined(EXIT_SUCCESS)
#define EXIT_SUCCESS	0
#endif

#if !defined(EXIT_FAILURE)
#define EXIT_FAILURE	1
#endif

#endif /* !defined(STDC_H) */

#if !defined(CONFIX_H)
#define CONFIX_H 1
#if defined(__cplusplus) || defined(c_plusplus)
/* Autoconf version 2.12 gets the wrong answer in configure for C++
compilers, because generated test code calls exit() without a function
prototype in scope, instead of using return().  This has been reported
to the GNU autoconf developers, but in the meantime, we provide this
workaround by redefining it. */
#undef STDC_HEADERS
#define STDC_HEADERS 1
#undef HAVE_STDC_PROTOTYPES
#define HAVE_STDC_PROTOTYPES 1
#undef HAVE_VOIDP
#define HAVE_VOIDP 1
/* Autoconf version 2.12 gets the wrong answer in configure for C++
compilers for AC_C_CONST, so set it to the proper value. */
#undef const
#endif
#endif /* !defined(CONFIX_H) */

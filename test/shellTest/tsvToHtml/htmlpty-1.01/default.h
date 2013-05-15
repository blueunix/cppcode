#if !defined(DEFAULT_H)
#define DEFAULT_H 1

extern void		body ARGS((void));
extern void		doctype ARGS((void));
extern void		font ARGS((void));
extern void		head ARGS((void));
extern void		hn ARGS((void));
extern void		html ARGS((void));
extern void		html_link ARGS((void));
extern void		inline_tag ARGS((void));
extern void		line_break ARGS((void));
extern void		list ARGS((void));
extern void		list_header ARGS((void));
extern void		list_item ARGS((void));
extern void		markup_declaration ARGS((void));
extern void		math ARGS((void));
extern void		math_pair ARGS((void));
extern void		pair ARGS((void));
extern void		paragraph ARGS((void));
extern void		plaintext ARGS((void));
extern void		short_tag ARGS((void));
extern void		standalone ARGS((void));
extern void		standalone_nocheck ARGS((void));
extern void		title ARGS((void));
extern void		verbatim ARGS((void));
extern void		verbatim_nocheck ARGS((void));

Style default_style[] =
{
#undef ENTRY
#define	ENTRY(s) s, (sizeof(s) - 1)
    { ENTRY("body"),			(const char*)NULL,	body },
    { ENTRY("doctype"),			(const char*)NULL,	doctype },
    { ENTRY("font"),			(const char*)NULL,	font },
    { ENTRY("head"),			(const char*)NULL,	head },
    { ENTRY("html"),			(const char*)NULL,	html },
    { ENTRY("inline"),			(const char*)NULL,	inline_tag },
    { ENTRY("line-break"),		(const char*)NULL,	line_break },
    { ENTRY("link"),			(const char*)NULL,	html_link },
    { ENTRY("list"),			(const char*)NULL,	list },
    { ENTRY("list-header"),		(const char*)NULL,	list_header },
    { ENTRY("list-item"),		(const char*)NULL,	list_item },
    { ENTRY("markup-declaration"), 	(const char*)NULL,	markup_declaration },
    { ENTRY("math"),			(const char*)NULL,	math },
    { ENTRY("math-pair"),		(const char*)NULL,	math_pair },
    { ENTRY("pair"),			(const char*)NULL,	pair },
    { ENTRY("paragraph"),		(const char*)NULL,	paragraph },
    { ENTRY("plaintext"),		(const char*)NULL,	plaintext },
    { ENTRY("public"),			(const char*)NULL,	standalone_nocheck },
    { ENTRY("section"),			(const char*)NULL,	hn },
    { ENTRY("short"),			(const char*)NULL,	short_tag },
    { ENTRY("standalone"),		(const char*)NULL,	standalone },
    { ENTRY("standalone-nocheck"), 	(const char*)NULL,	standalone_nocheck },
    { ENTRY("title"),			(const char*)NULL,	title },
    { ENTRY("verbatim"),		(const char*)NULL,	verbatim },
    { ENTRY("verbatim-nocheck"),	(const char*)NULL,	verbatim_nocheck },
    { (const char *)NULL, (size_t)0,	(const char*)NULL,	(StyleFunction)NULL }
#undef ENTRY
};

#endif /* !defined(DEFAULT_H) */

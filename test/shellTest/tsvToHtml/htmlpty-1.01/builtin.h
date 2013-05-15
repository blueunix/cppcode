#if !defined(BUILTIN_H)
#define BUILTIN_H 1

const char	*builtin_style[] =
{
    /*******************************************************************
    NB: These strings may be no longer than MAXBUF (>= 2048), because
    initialize() must be able to copy them into a fixed buffer,
    line[MAXBUF+2].  They may also not exceed 512 characters in length,
    in order to satisfy a Microsoft C 5.x limit, sigh...

    Tags must consist entirely of exclamation points, letters and
    digits.

    For readability, keep them ordered by grammar level, class, and
    name.
    *******************************************************************/

    /******************************************************************/
    /* Base HTML 1.0 and 2.0 tags */

    "body : BODY",

    "doctype : !DOCTYPE",

    "font : B BIG CODE DFN EM I KBD Q REV SAMP SMALL STRONG TT U VAR",

    "head : HEAD",

    "html : HTML",

    "line-break : BR",

    "link : LINK",

    "list : DIR MENU",
    "list : DL OL UL",

    "list-header : LH",

    "list-item : DD DT LI",

    "markup-declaration : !ATTLIST !ELEMENT !ENTITY !NOTATION !SGML \
			  !SHORTREF !USEMAP",

    "pair : A ABBREV ABSTRACT ADDED ADDRESS ARG AROW ARRAY AU  \
	    BLOCKQUOTE BQ CAPTION CITE CMD DIV1 DIV2 DIV3 DIV4 DIV5 \
	    DIV6 FIG FN FOOTNOTE FORM HIDE LANG MARGIN MATH MESSAGE \
	    NOTE OPTION PERSON QUOTE REMOVED SELECT TABLE TEXTAREA",

    "paragraph : P",

    "plaintext : PLAINTEXT",

    "section : H1 H2 H3 H4 H5 H6",

    "short : ITEM",

    "standalone : CHANGED HR IMG INPUT RENDER STYLES",

    "standalone-nocheck : BASE ISINDEX META",

    "standalone-nocheck : NEXTID",	/* %HTML.Deprecated */

    "title : TITLE",

    "verbatim : LISTING PRE XMP",

    /******************************************************************/
    /* HTML 3.0 additions */

    "font : BT T",

    "math-pair : ABOVE BAR BELOW BOX DDOT DOT HAT ROOT ROW SQRT \
		 TILDE VEC",

    "math-pair : SUB SUP",

    "math : ATOP CHOOSE LEFT OF OVER RIGHT TAB",

    "pair : CREDIT DEL INS",

    "standalone-nocheck : OVERLAY STYLE",

    /******************************************************************/
    /* HTML 3.2 additions */

    "font : STRIKE",

    "math-pair : SUB SUP",

    "pair : APPLET CENTER DIV FONT MAP TD TH TR",

    "standalone-nocheck : AREA BASEFONT PARAM",

    "verbatim-nocheck : SCRIPT STYLE",
    /* NB: STYLE is incompatible between 3.0 and versions 3.2 or later! */

    /******************************************************************/
    /* HTML 4.0 additions */

    "pair : BDO BUTTON COLGROUP FIELDSET FRAMESET IFRAME LABEL \
	   NOFRAMES NOSCRIPT OBJECT SPAN TBODY TFOOT THEAD",

    "font : ACRONYM S",

    "standalone-nocheck : COL FRAME",

    /******************************************************************/
    /* Mosaic additions */

    "font : BLINK",

    "standalone : WBR",

    "verbatim : NOBR",

    /******************************************************************/
    /* Finally, here is the DOCTYPE PUBLIC identifier string: even
       though this built-in style includes tags from higher grammar
       levels, for maximum portability, we want the default
       <!DOCTYPE...> declaration produced by html-pretty to be
       suitable for the lowest common denominator. */

    "public : \"-//IETF//DTD HTML//EN\"",

    /******************************************************************/
     /* The CannotContain[] and ContainedIn[] values which follow
        were produced automatically from the merged-table.tab file.
	Read "CannotContain[X] : Y Z" as X cannot contain Y or Z,
	and "ContainedIn[X]: Y Z" as X is contained in Y or Z. */

    "CannotContain[A] : A",

    "CannotContain[BUTTON] : A BUTTON FIELDSET FORM IFRAME INPUT \
                            ISINDEX LABEL SELECT TEXTAREA",

    "CannotContain[DIR] : ADDRESS BLOCKQUOTE BQ CENTER DIR DIV DL \
                            FIELDSET FIG FORM H1 H2 H3 H4 H5 H6 HR \
                            ISINDEX LISTING MENU NOFRAMES NOSCRIPT \
                            NOTE OL P PRE TABLE UL XMP",

    "CannotContain[FIG] : FIG IMG",

    "CannotContain[FORM] : FORM",

    "CannotContain[LABEL] : LABEL",

    "CannotContain[MATH] : A ABBREV ACRONYM AU BIG BR CITE CODE DEL \
                            DFN EM I IMG INS KBD LANG MATH PERSON Q S \
                            SAMP SMALL STRONG TAB TT U VAR",

    "CannotContain[MENU] : ADDRESS BLOCKQUOTE BQ CENTER DIR DIV DL \
                            FIELDSET FIG FORM H1 H2 H3 H4 H5 H6 HR \
                            ISINDEX LISTING MENU NOFRAMES NOSCRIPT \
                            NOTE OL P PRE TABLE UL XMP",

    "CannotContain[NOFRAMES] : #PCDATA A ABBR ADDRESS APPLET B BASEFONT \
                            BDO BIG BLOCKQUOTE BR BUTTON CENTER CITE \
                            CODE DFN DIR DIV DL EM FIELDSET FONT FORM \
                            H1 H2 H3 H4 H5 H6 HR I IFRAME IMG INPUT \
                            ISINDEX KBD LABEL MAP MENU NOFRAMES \
                            NOSCRIPT OBJECT OL P PRE Q S SAMP SCRIPT \
                            SELECT SMALL SPAN STRIKE STRONG SUB SUP \
                            TABLE TEXTAREA TT U UL VAR",

    "CannotContain[PRE] : APPLET BASEFONT BIG FONT IMG MATH OBJECT \
                            SMALL SUB SUP TAB",

    "CannotContain[SELECT] : INPUT SELECT TEXTAREA",

    "CannotContain[TEXTAREA] : INPUT SELECT TEXTAREA",

    "CannotContain[TITLE] : LINK META SCRIPT STYLE",

    "ContainedIn[#PCDATA] : A ABBR ABBREV ABOVE ACRONYM ADDRESS APPLET \
                            AU B BAR BDO BELOW BIG BLINK BLOCKQUOTE \
                            BODY BOX BQ BT BUTTON CAPTION CENTER CITE \
                            CODE CREDIT DD DDOT DEL DFN DIV DOT DT EM \
                            FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 H6 \
                            HAT I IFRAME INS ITEM KBD LABEL LANG \
                            LEGEND LH LI MATH NOBR NOSCRIPT NOTE \
                            OBJECT OF OPTION P PERSON PRE Q ROOT S \
                            SAMP SMALL SPAN SQRT STRIKE STRONG STYLE \
                            SUB SUP T TD TEXTAREA TEXTFLOW TH TILDE \
                            TITLE TT U VAR VEC",

    "ContainedIn[A] : ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOBR NOSCRIPT NOTE OBJECT P PERSON PRE \
                            Q S SAMP SMALL SPAN STRIKE STRONG SUB SUP \
                            TD TEXTFLOW TH TT U VAR",

    "ContainedIn[ABBR] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TH TT U VAR",

    "ContainedIn[ABBREV] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[ABOVE] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[ACRONYM] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[ADDRESS] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[ANY] : BASEFONT",

    "ContainedIn[APPLET] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TEXTFLOW TH \
                            TT U VAR",

    "ContainedIn[AREA] : MAP",

    "ContainedIn[ARRAY] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[ATOP] : BOX",

    "ContainedIn[AU] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[B] : A ABBR ABBREV ABOVE ACRONYM ADDRESS APPLET \
                            AU B BAR BDO BELOW BIG BLINK BLOCKQUOTE \
                            BODY BOX BQ BT BUTTON CAPTION CENTER CITE \
                            CODE CREDIT DD DDOT DEL DFN DIV DOT DT EM \
                            FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 H6 \
                            HAT I IFRAME INS ITEM KBD LABEL LANG \
                            LEGEND LH LI MATH NOBR NOSCRIPT NOTE \
                            OBJECT OF P PERSON PRE Q ROOT S SAMP SMALL \
                            SPAN SQRT STRIKE STRONG SUB SUP T TD \
                            TEXTFLOW TH TILDE TT U VAR VEC",

    "ContainedIn[BAR] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[BASE] : HEAD",

    "ContainedIn[BASEFONT] : A ABBR ADDRESS APPLET B BDO BIG BLINK \
                            BLOCKQUOTE BODY BUTTON CAPTION CENTER CITE \
                            CODE DD DEL DFN DIV DT EM FIELDSET FONT \
                            FORM H1 H2 H3 H4 H5 H6 I IFRAME INS KBD \
                            LABEL LEGEND LI NOBR NOSCRIPT OBJECT P PRE \
                            Q S SAMP SMALL SPAN STRIKE STRONG SUB SUP \
                            TD TEXTFLOW TH TT U VAR",

    "ContainedIn[BDO] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TEXTFLOW TH \
                            TT U VAR",

    "ContainedIn[BELOW] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[BIG] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLOCKQUOTE BODY BQ BUTTON CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOSCRIPT NOTE OBJECT P PERSON Q S SAMP \
                            SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[BLINK] : A ADDRESS B BLINK BLOCKQUOTE BODY CENTER \
                            CITE CODE DD DT EM FONT FORM H1 H2 H3 H4 \
                            H5 H6 I KBD LI NOBR P PRE SAMP STRONG TT \
                            VAR",

    "ContainedIn[BLOCKQUOTE] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[BODY] : HTML NOFRAMES",

    "ContainedIn[BOX] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[BQ] : BLOCKQUOTE BODY BQ DD DIV FIG FORM LI NOTE \
                            TD TH",

    "ContainedIn[BR] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[BT] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[BUTTON] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY CAPTION CENTER CITE CODE DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LABEL LEGEND LI \
                            NOSCRIPT OBJECT P PRE Q S SAMP SMALL SPAN \
                            STRIKE STRONG SUB SUP TD TH TT U VAR",

    "ContainedIn[CAPTION] : FIELDSET FIG TABLE",

    "ContainedIn[CDATA] : LISTING PLAINTEXT SCRIPT STYLE XMP",

    "ContainedIn[CENTER] : A ADDRESS APPLET B BLINK BLOCKQUOTE BODY \
                            BUTTON CENTER CITE CODE DD DEL DIV DT EM \
                            FIELDSET FONT FORM H1 H2 H3 H4 H5 H6 I \
                            IFRAME INS KBD LI NOBR NOSCRIPT OBJECT P \
                            SAMP STRONG TD TH TT VAR",

    "ContainedIn[CHOOSE] : BOX",

    "ContainedIn[CITE] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[CODE] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[COL] : COLGROUP TABLE",

    "ContainedIn[COLGROUP] : TABLE",

    "ContainedIn[CREDIT] : BLOCKQUOTE BQ FIG",

    "ContainedIn[DD] : DL",

    "ContainedIn[DDOT] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[DEL] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[DFN] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLOCKQUOTE BODY BQ BUTTON CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOSCRIPT NOTE OBJECT P PERSON PRE Q S \
                            SAMP SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[DIR] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[DIV] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[DL] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[DOT] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[DT] : DL",

    "ContainedIn[EM] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[EMPTY] : AREA ATOP BASE BASEFONT BR CHOOSE COL \
                            FRAME HR IMG INPUT ISINDEX LEFT LINK META \
                            NEXTID OVER OVERLAY PARAM RIGHT TAB WBR",

    "ContainedIn[FIELDSET] : APPLET BLOCKQUOTE BODY CENTER DD DEL DIV \
                            FIELDSET FORM IFRAME INS LI NOSCRIPT \
                            OBJECT TD TH",

    "ContainedIn[FIG] : BLOCKQUOTE BODY BQ DD DIV FORM LI NOTE TD \
                            TH",

    "ContainedIn[FONT] : A ABBR ADDRESS APPLET B BDO BIG BLINK \
                            BLOCKQUOTE BODY BUTTON CAPTION CENTER CITE \
                            CODE DD DEL DFN DIV DT EM FIELDSET FONT \
                            FORM H1 H2 H3 H4 H5 H6 I IFRAME INS KBD \
                            LABEL LEGEND LI NOBR NOSCRIPT OBJECT P PRE \
                            Q S SAMP SMALL SPAN STRIKE STRONG SUB SUP \
                            TD TEXTFLOW TH TT U VAR",

    "ContainedIn[FORM] : APPLET BLOCKQUOTE BODY BQ CENTER DD DEL \
                            DIV FIELDSET FIG IFRAME INS LI NOSCRIPT \
                            NOTE OBJECT TD TH",

    "ContainedIn[FRAME] : FRAMESET",

    "ContainedIn[FRAMESET] : FRAMESET HTML",

    "ContainedIn[H1] : A APPLET BLOCKQUOTE BODY BQ BUTTON CENTER \
                            DD DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[H2] : A APPLET BLOCKQUOTE BODY BQ BUTTON CENTER \
                            DD DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[H3] : A APPLET BLOCKQUOTE BODY BQ BUTTON CENTER \
                            DD DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[H4] : A APPLET BLOCKQUOTE BODY BQ BUTTON CENTER \
                            DD DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[H5] : A APPLET BLOCKQUOTE BODY BQ BUTTON CENTER \
                            DD DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[H6] : A APPLET BLOCKQUOTE BODY BQ BUTTON CENTER \
                            DD DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[HAT] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[HEAD] : HTML",

    "ContainedIn[HR] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT PRE TD TH",

    "ContainedIn[I] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[IFRAME] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY CAPTION CENTER CITE CODE DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LABEL LEGEND LI \
                            NOSCRIPT OBJECT P PRE Q S SAMP SMALL SPAN \
                            STRIKE STRONG SUB SUP TD TH TT U VAR",

    "ContainedIn[IMG] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LABEL LANG LEGEND \
                            LH LI NOBR NOSCRIPT NOTE OBJECT P PERSON Q \
                            S SAMP SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[INPUT] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY CAPTION CENTER CITE CODE DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LABEL LEGEND LI \
                            NOSCRIPT OBJECT P PRE Q S SAMP SMALL SPAN \
                            STRIKE STRONG SUB SUP TD TEXTFLOW TH TT U \
                            VAR",

    "ContainedIn[INS] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[ISINDEX] : APPLET BLOCKQUOTE BODY BQ CENTER DD DEL \
                            DIV FIELDSET FIG FORM HEAD IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[ITEM] : ROW",

    "ContainedIn[KBD] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[LABEL] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY CAPTION CENTER CITE CODE DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LEGEND LI NOSCRIPT \
                            OBJECT P PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[LANG] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[LEFT] : BOX",

    "ContainedIn[LEGEND] : FIELDSET",

    "ContainedIn[LH] : DL OL UL",

    "ContainedIn[LI] : DIR MENU OL UL",

    "ContainedIn[LINK] : HEAD",

    "ContainedIn[LISTING] : BLOCKQUOTE BODY BQ CENTER DD DIV FIELDSET \
                            FIG FORM LI NOTE OBJECT TD TH",

    "ContainedIn[MAP] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TEXTFLOW TH \
                            TT U VAR",

    "ContainedIn[MATH] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON Q S SAMP SMALL STRONG SUB SUP TD TH \
                            TT U VAR",

    "ContainedIn[MENU] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[META] : HEAD",

    "ContainedIn[NEXTID] : HEAD",

    "ContainedIn[NOBR] : A ADDRESS B BLINK BLOCKQUOTE BODY CENTER \
                            CITE CODE DD DT EM FONT FORM H1 H2 H3 H4 \
                            H5 H6 I KBD LI NOBR P SAMP STRONG TT VAR",

    "ContainedIn[NOFRAMES] : APPLET BLOCKQUOTE BODY BUTTON CENTER DD \
                            DEL DIV FIELDSET FORM FRAMESET IFRAME INS \
                            LI NOSCRIPT OBJECT TD TH",

    "ContainedIn[NOSCRIPT] : APPLET BLOCKQUOTE BODY BUTTON CENTER DD \
                            DEL DIV FIELDSET FORM IFRAME INS LI \
                            NOSCRIPT OBJECT TD TH",

    "ContainedIn[NOTE] : BLOCKQUOTE BODY BQ DD DIV FIG FORM LI NOTE \
                            TD TH",

    "ContainedIn[OBJECT] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TEXTFLOW TH \
                            TT U VAR",

    "ContainedIn[OF] : ROOT",

    "ContainedIn[OL] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[OPTGROUP] : OPTGROUP SELECT",

    "ContainedIn[OPTION] : OPTGROUP SELECT",

    "ContainedIn[OVER] : BOX",

    "ContainedIn[OVERLAY] : FIG",

    "ContainedIn[P] : ADDRESS APPLET BLOCKQUOTE BODY BQ BUTTON \
                            CENTER DD DEL DIV FIELDSET FIG FORM IFRAME \
                            INS LI NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[PARAM] : APPLET OBJECT",

    "ContainedIn[PERSON] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON PRE Q S SAMP SMALL STRONG SUB SUP \
                            TD TH TT U VAR",

    "ContainedIn[PLAINTEXT] : HTML",

    "ContainedIn[PRE] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[Q] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLOCKQUOTE BODY BQ BUTTON CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOSCRIPT NOTE OBJECT P PERSON PRE Q S \
                            SAMP SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[RIGHT] : BOX",

    "ContainedIn[ROOT] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[ROW] : ARRAY",

    "ContainedIn[S] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLOCKQUOTE BODY BQ BUTTON CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOSCRIPT NOTE OBJECT P PERSON PRE Q S \
                            SAMP SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[SAMP] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[SCRIPT] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 HEAD I IFRAME INS KBD LABEL \
                            LEGEND LI NOSCRIPT OBJECT P PRE Q S SAMP \
                            SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[SELECT] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY CAPTION CENTER CITE CODE DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LABEL LEGEND LI \
                            NOSCRIPT OBJECT P PRE Q S SAMP SMALL SPAN \
                            STRIKE STRONG SUB SUP TD TEXTFLOW TH TT U \
                            VAR",

    "ContainedIn[SMALL] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLOCKQUOTE BODY BQ BUTTON CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOSCRIPT NOTE OBJECT P PERSON Q S SAMP \
                            SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[SPAN] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TEXTFLOW TH \
                            TT U VAR",

    "ContainedIn[SQRT] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[STRIKE] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY BUTTON CAPTION CENTER CITE CODE DD \
                            DEL DFN DIV DT EM FIELDSET FONT FORM H1 H2 \
                            H3 H4 H5 H6 I IFRAME INS KBD LABEL LEGEND \
                            LI NOSCRIPT OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRIKE STRONG SUB SUP TD TH TT U VAR",

    "ContainedIn[STRONG] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[STYLE] : A ADDRESS B BDO BIG BLOCKQUOTE BODY \
                            CAPTION CENTER CITE CODE DD DFN DIV DT EM \
                            FIELDSET FONT FORM H1 H2 H3 H4 H5 H6 HEAD \
                            I KBD LABEL LI OBJECT P PRE Q S SAMP SMALL \
                            SPAN STRONG SUB SUP TD TEXTFLOW TH TT U \
                            VAR",

    "ContainedIn[SUB] : A ABBR ABBREV ABOVE ACRONYM ADDRESS APPLET \
                            AU B BAR BDO BELOW BIG BLOCKQUOTE BODY BOX \
                            BQ BT BUTTON CAPTION CENTER CITE CODE \
                            CREDIT DD DDOT DEL DFN DIV DOT DT EM \
                            FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 H6 \
                            HAT I IFRAME INS ITEM KBD LABEL LANG \
                            LEGEND LH LI MATH NOSCRIPT NOTE OBJECT OF \
                            P PERSON Q ROOT S SAMP SMALL SPAN SQRT \
                            STRIKE STRONG SUB SUP T TD TEXTFLOW TH \
                            TILDE TT U VAR VEC",

    "ContainedIn[SUP] : A ABBR ABBREV ABOVE ACRONYM ADDRESS APPLET \
                            AU B BAR BDO BELOW BIG BLOCKQUOTE BODY BOX \
                            BQ BT BUTTON CAPTION CENTER CITE CODE \
                            CREDIT DD DDOT DEL DFN DIV DOT DT EM \
                            FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 H6 \
                            HAT I IFRAME INS ITEM KBD LABEL LANG \
                            LEGEND LH LI MATH NOSCRIPT NOTE OBJECT OF \
                            P PERSON Q ROOT S SAMP SMALL SPAN SQRT \
                            STRIKE STRONG SUB SUP T TD TEXTFLOW TH \
                            TILDE TT U VAR VEC",

    "ContainedIn[T] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[TAB] : A ABBREV ACRONYM ADDRESS AU B BIG \
                            BLOCKQUOTE BODY BQ CAPTION CITE CODE \
                            CREDIT DD DEL DFN DIV DT EM FIG FORM H1 H2 \
                            H3 H4 H5 H6 I INS KBD LANG LH LI NOTE P \
                            PERSON Q S SAMP SMALL STRONG SUB SUP TD TH \
                            TT U VAR",

    "ContainedIn[TABLE] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[TBODY] : TABLE",

    "ContainedIn[TD] : TR",

    "ContainedIn[TEXTAREA] : A ABBR ADDRESS APPLET B BDO BIG BLOCKQUOTE \
                            BODY CAPTION CENTER CITE CODE DD DEL DFN \
                            DIV DT EM FIELDSET FONT FORM H1 H2 H3 H4 \
                            H5 H6 I IFRAME INS KBD LABEL LEGEND LI \
                            NOSCRIPT OBJECT P PRE Q S SAMP SMALL SPAN \
                            STRIKE STRONG SUB SUP TD TEXTFLOW TH TT U \
                            VAR",

    "ContainedIn[TEXTFLOW] : APPLET",

    "ContainedIn[TFOOT] : TABLE",

    "ContainedIn[TH] : TR",

    "ContainedIn[THEAD] : TABLE",

    "ContainedIn[TILDE] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[TITLE] : HEAD",

    "ContainedIn[TR] : TABLE TBODY TFOOT THEAD",

    "ContainedIn[TT] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[U] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLOCKQUOTE BODY BQ BUTTON CAPTION \
                            CENTER CITE CODE CREDIT DD DEL DFN DIV DT \
                            EM FIELDSET FIG FONT FORM H1 H2 H3 H4 H5 \
                            H6 I IFRAME INS KBD LABEL LANG LEGEND LH \
                            LI NOSCRIPT NOTE OBJECT P PERSON PRE Q S \
                            SAMP SMALL SPAN STRIKE STRONG SUB SUP TD \
                            TEXTFLOW TH TT U VAR",

    "ContainedIn[UL] : APPLET BLOCKQUOTE BODY BQ BUTTON CENTER DD \
                            DEL DIV FIELDSET FIG FORM IFRAME INS LI \
                            NOSCRIPT NOTE OBJECT TD TH",

    "ContainedIn[VAR] : A ABBR ABBREV ACRONYM ADDRESS APPLET AU B \
                            BDO BIG BLINK BLOCKQUOTE BODY BQ BUTTON \
                            CAPTION CENTER CITE CODE CREDIT DD DEL DFN \
                            DIV DT EM FIELDSET FIG FONT FORM H1 H2 H3 \
                            H4 H5 H6 I IFRAME INS KBD LABEL LANG \
                            LEGEND LH LI NOBR NOSCRIPT NOTE OBJECT P \
                            PERSON PRE Q S SAMP SMALL SPAN STRIKE \
                            STRONG SUB SUP TD TEXTFLOW TH TT U VAR",

    "ContainedIn[VEC] : ABOVE BAR BELOW BOX BT DDOT DOT HAT ITEM \
                            MATH OF ROOT SQRT T TILDE VEC",

    "ContainedIn[WBR] : A ADDRESS B BLINK BLOCKQUOTE BODY CENTER \
                            CITE CODE DD DT EM FONT FORM H1 H2 H3 H4 \
                            H5 H6 I KBD LI NOBR P SAMP STRONG TT VAR",

    "ContainedIn[XMP] : BLOCKQUOTE BODY BQ CENTER DD DIV FIELDSET \
                            FIG FORM LI NOTE OBJECT TD TH",

    /* data terminator */
    (const char*)NULL
};
#endif /* !defined(BUILTIN_H) */

# /u/sy/beebe/src/htmlpty/htmlpty-1.00/enttable.awk, Mon Nov 10 17:39:08 1997
# Edit by Nelson H. F. Beebe <beebe@plot79.math.utah.edu>
# ========================================================================
# Read an HTML DTD grammar files, and from it extract a list of
# entities, and then sort them into topological order.
#
# Usage:
#	tr \n ' ' | gawk -f enttable.awk >foo.tsort
#
# The tr prefilter is needed to collapse the entire DTD file to a
# single record, to facilitate extraction of <!ENTITY...> and
# <!ELEMENT...> tags, which often span multiple lines in the DTD.
#
# [12-Nov-1997]
# ========================================================================

BEGIN			{ }

			{ do_dtd(do_clean_dtd(uncomment($0,1))) }

END			{ do_tables() }


function append(list,word)
{
    return ((list == "") ? word : (list " " word))
}


function clean_word(s)
{
    gsub(/[*+][|]/," ",s)	# reduce "(col*|colgroup*)," to "(col colgroup*)"
    gsub(/[)&?+*,; ]+$/,"",s)	# e.g., reduce (DT|DD)+
    gsub(/^[( ]+/,"",s)		# to DT|DD
    gsub(/[|]/," ",s)		# and split into DT DD

    gsub(/[)][+]/," ",s)	# reduce (%one;)+,(%two;)+ +(%three;)+ to (%one;),(%two;) +(%three;)
    gsub(/[();,]/," ",s)	# reduce #PCDATA,LEGEND,(%block;)+ to #PCDATA LEGEND %block
    gsub(/ *[-] */," - ",s)	# change -ABC to - ABC
    gsub(/ *[+] */," + ",s)	# change +DEF to + DEF

    return (s)
}


function deprecated_status(tag)
{
    return ((tag in Deprecated) ? " (deprecated)" : "\\&")
}


function do_clean_dtd(s)
{
    # fix some formatting problems in the DTD files
    gsub(/% +/,"%",s)		# reduce "% URI" to "%URI" etc
    gsub(/[(] +/,"(",s)		# and remove blanks after open parens
    gsub(/ +[)]/,")",s)		# and before close parens
    return (s)
}


function do_deletions( word)
{
    for (word in Element)
	Element[word] = do_one_deletion(word,Element[word])
}


function do_dtd(s)
{
    do_dtd_elements(s)
    do_dtd_entities(s)
}


function do_dtd_elements(s, rest)
{
    if (match(s,/<!ELEMENT[^<>]*>/))
    {
	rest = substr(s,RSTART+RLENGTH)
	do_element(substr(s,RSTART,RLENGTH-1))
	do_dtd_elements(rest)
    }
}


function do_dtd_entities(s, rest)
{
    if (match(s,/<!ENTITY[^<>]*>/))
    {
	rest = substr(s,RSTART+RLENGTH)
	do_entity(substr(s,RSTART,RLENGTH-1))
	do_dtd_entities(rest)
    }
}


function do_element(s, k,n,rest,words)
{
    # Typical entries:
    #	<!ELEMENT (%font;|%phrase) - - (%text)+>
    #   <!ELEMENT BR    - O EMPTY>
    #   <!ELEMENT DL    - -  (DT|DD)+>
    #	<!ELEMENT BODY O O  (%block;)+ +(INS|DEL)>
    #
    # These need special handling, since the minus sign before the
    # last word means that the members in the negated group are to
    # excluded from containment:
    #
    #	<!ELEMENT A - - (%text)* -(A)>
    #   <!ELEMENT TEXTAREA - - (#PCDATA) -(INPUT|TEXTAREA|SELECT)>
    #	<!ELEMENT PRE - - (%text;)* -(%pre.exclusion)>
    #
    # clean_word will leave the - as a separate entry in the word
    # list, so after collecting all elements, and before sorting,
    # we need to process the list with delete_words()

    s = uncomment(s,0)
    n = split(s,words," ")
    rest = clean_word(words[5])
    for (k = 6; k <= n; ++k)
	rest = rest " " clean_word(words[k])
    do_one_element(words[2],words[3],words[4],rest)
}


function do_entity(s, k,n,words)
{
    # Typical entries:
    #
    #   <!ENTITY %URI "CDATA" -- comments -->
    #	<!ENTITY %list " UL | OL | DIR | MENU " >
    #	<!ENTITY %heading "H1|H2|H3|H4|H5|H6">
    #	<!ENTITY amp CDATA "&#38;"     -- ampersand          -->
    #	<!ENTITY %ISOlat1 PUBLIC "-//IETF//ENTITIES Added Latin 1 for HTML//EN">
    #	<!ENTITY % version.attr "VERSION CDATA #FIXED '%HTML.Version;'">

    s = uncomment(s,0)
    # s = protect_quoted_blanks(s)
    gsub(/[()|\"']/," ",s)	# change separators to spaces
    gsub(/[&][#][0-9]+;/," ",s)	# and remove numeric entities
    n = split(s,words," ")
    if (words[3] == "PUBLIC")
	return			# ignore PUBLIC entities
    for (k = 3; k <= n; ++k)
	Entity[words[2]] = Entity[words[2]] " " uppercase_tag(clean_word(words[k]))
#   do_print("ENTITY:" words[2], Entity[words[2]])
}


function do_expand_lhs(lhs, k,n,w,words)
{
    for (w in lhs)
    {
	n = split(expand_entities(w),words," ")
	if (n > 1)
	{
	    for (k = 1; k <= n; ++k)
		lhs[words[k]] = append(lhs[words[k]],lhs[w])
	}
    }
}


function do_expand_require()
{
    do_expand_lhs(Require_Begin)
    do_expand_lhs(Require_End)
}


function do_expand_table(target,source, expansion,k,n,w,words)
{
    for (w in source)
    {
	n = split(expand_entities(w),words," ")
	expansion = expand_entities(source[w])
	for (k = 1; k <= n; ++k)
	    target[words[k]] = expansion
    }
}


function do_manpage_line(wordlist, k,line,max_length,n,words)
{
    max_length = 72

    # sort_words() uppercased everything in wordlist, so we need to
    # restore any font commands to their correct lowercase form
    gsub(/\\S-/,"\\s-",wordlist)
    gsub(/\\S0/,"\\s0",wordlist)

    if (length(wordlist) <= max_length)	# efficiency: don't split short wordlists
	print wordlist
    else			# long wordlist: split and handle a word at a time
    {
	n = split(wordlist,words," ")
	line = ""
	for (k = 1; k <= n; ++k)
	{
	    if ((length(line) + 1 + length(words[k])) > max_length)
	    {
		print line
		line = ""
	    }
	    line = append(line,words[k])
	}
	print line
    }
}


function do_manpage_paragraph(tag,contained_list,contains_list,cannotcontain_list)
{
    print ".\\\"---------------------------------------------------------------------"

    # NB: ANY appears only in html-mcom.dtd, and means essentially
    # #PCDATA or any tag defined in the grammar (see p. 411 of
    # Goldfarb and Rubinsky, The SGML Handbook).

    if ( (tag == "#PCDATA") || (tag == "ANY") || \
	 (tag == "CDATA") || (tag == "EMPTY") )	# then pseudo-tag
	print ".B " tag		# none of these are deprecated, so deprecated_status() is not called
    else if (contains_list ~ /EMPTY/) # then never has end tag
	print ".BR \"<" tag ">\"", \
		"\"" tag_status(Require_Begin,tag) "\"", \
		"\"" deprecated_status(tag) "\""
    else
	print ".BR \"<" tag ">\"", \
		"\"" tag_status(Require_Begin,tag) "\"", \
		"\" .\\|.\\|. </" tag ">\"", \
		"\"" tag_status(Require_End,tag) "\"", \
		"\"" deprecated_status(tag) "\""

    if (length(contained_list) > 0)
    {
	print ".\\\""
	print ".RS"
	print ".I \"contained in:\""
	do_manpage_line(contained_list)
	print ".RE"
    }

    if (length(contains_list) > 0)
    {
	print ".\\\""
	print ".RS"
	print ".I \"contains:\""
	do_manpage_line(contains_list)
	print ".RE"
    }

    if (length(cannotcontain_list) > 0)
    {
	print ".\\\""
	print ".RS"
	print ".I \"cannot contain:\""
	do_manpage_line(cannotcontain_list)
	print ".RE"
    }

    if (tag in Extra_Text)
	print Extra_Text[tag]
}


function do_manpage_table( k,n,taglist,w,words)
{
    # Make UNIX nroff/troff manual page text for a sorted list of HTML
    # tags in the Contains[] and ContainedIn[] arrays

    # First create a sorted list of all known tags
    taglist = ""
    for (w in Contains)
	taglist = append(taglist, w)
    for (w in ContainedIn)
	taglist = append(taglist, w)
    for (w in CannotContain)
	taglist = append(taglist, w)
    taglist = sort_words(taglist)


    n = split(taglist,words," ")
    for (k = 1; k <= n; ++k)
	do_manpage_paragraph(words[k],\
			     sort_words(ContainedIn[words[k]]),\
			     sort_words(Contains[words[k]]),
			     sort_words(CannotContain[words[k]]))
}


function do_one_deletion(tag,wordlist, deleting,j,k,n,words)
{
    # Expand entities in wordlist, then run through the wordlist, and
    # when a "-" entry is hit, delete from the wordlist all of those
    # entries that follow the "-", up to the end of the list, or the
    # "+" entry that suspends deletion.  Deleted entries are appended
    # to the global array element CannotContain[tag]

    ## print ""
    ## printf("DEBUG: do_one_deletion(\"%s\",\"%s\")\n",tag,wordlist)

    wordlist = expand_entities(wordlist)

    ## printf("\t->\t\"%s\"\n",wordlist)

    n = split(wordlist,words," ")

    deleting = 0

    for (k = 1; k <= n; ++k)
    {
	if (words[k] == "-")
	{
	    deleting = 1
	    delete words[k]
	}
	else if (words[k] == "+")
	{
	    deleting = 0
	    delete words[k]
	}
	else if (deleting)
	{		# examine preceding list entries and delete any matches
	    for (j = 1; j < k; ++j)
	    {
		if ((j in words) && (words[k] == words[j]))
		    delete words[j]
	    }
	    CannotContain[tag] = append(CannotContain[tag],words[k])
	    delete words[k]
	}
    }

    wordlist = ""
    for (k = 1; k <= n; ++k)
    {
	if (k in words)
	    wordlist = append(wordlist,words[k])
    }

    ## printf("\t->\t\"%s\"\n",wordlist)

    return (wordlist)
}


function do_one_element(lhs,begin_flag,end_flag,rhs, k,n,words)
{
    ## print "DEBUG: do_one_element(\"" lhs "\", \"" begin_flag "\", \"" end_flag "\", \"" rhs "\")"
    gsub(/[()]/,"",lhs)
    n = split(lhs,words,"|")
    for (k = 1; k <= n; ++k)
    {
	words[k] = uppercase_tag(clean_word(words[k]))
	Element[words[k]] = append(Element[words[k]], rhs)
	Require_Begin[words[k]] = append(Require_Begin[words[k]], begin_flag)
	Require_End[words[k]] = append(Require_End[words[k]], end_flag)
    }
}


function do_print(lhs,rhs)
{
    printf("%-31s\t%s\n", lhs, rhs) | Sort_Pipe
#    printf("%-31s\t%s\n", lhs, rhs)
}


function do_reverse_table(target,source, k,n,w,words)
{
    for (w in source)
    {
	n = split(source[w],words," ")
	for (k = 1; k <= n; ++k)
	{
	    words[k] = uppercase_tag(words[k])
	    target[words[k]] = append(target[words[k]], w)
	}
    }
}


function do_single_table(table_name,table, word)
{
    for (word in table)
    {
	table[word] = sort_words(table[word])
	do_print(table_name ":" word,table[word])
    }
}


function do_tables( k,n,words)
{
    do_deletions()

    Sort_Pipe = "sort -u"

    do_single_table("ENTITY",Entity)
    do_single_table("ELEMENT",Element)
    do_single_table("ReqBEGIN",Require_Begin)
    do_single_table("ReqEND",Require_End)

    do_expand_require()
    do_single_table("ExpReqBEGIN",Require_Begin)
    do_single_table("ExpReqEND",Require_End)

    do_expand_table(Contains,Element)
    do_single_table("Contains",Contains)

    do_reverse_table(ContainedIn,Contains)
    do_single_table("ContainedIn",ContainedIn)

    # No do_expand_table() needed for CannotContain: has already been
    # done in do_one_deletion()
    do_single_table("CannotContain",CannotContain)

    close(Sort_Pipe);

    do_manpage_table()
}


function expand_entities(wordlist, k,n,words)
{
    n = split(wordlist, words, " ")
    wordlist = ""
    for (k = 1; k <= n; ++k)
	wordlist = append(wordlist, \
		   ((substr(words[k],1,1) == "%") ? expand_entities(Entity[words[k]]) : words[k]))
    return (wordlist)
}


function protect_quoted_blanks(s,t)
{
    if (match(s,/\"[^\"]*\"/))
    {
	t = substr(s,RSTART,RLENGTH)
	gsub(" ","_",t)		# change quoted blanks to underscores
	s = substr(s,1,RSTART-1) t substr(s,RSTART+RLENGTH)
    }
    return (s)
}


function small_troff_font(s)
{
    return (((s == "\\&") || (s == "")) ? s : ("\\s-3" s "\\s0\\&"))
}


function sort_words(wordlist, j,k,n,swap,words)
{
    n = split(wordlist,words," ")

    # standardize letter case
    for (k = 1; k <= n; ++k)
	words[k] = uppercase_tag(words[k])

    # sort words[] into ascending order with duplicates eliminated
    for (j = 1; j <= n; ++j)
    {
	if (!(j in words))
	    continue

        for (k = j + 1; k <= n; ++k)
	{
	    if (!(k in words))
		continue
	    if (words[j] == words[k])
		delete words[k]
	    else if (words[j] > words[k])
	    {
		swap = words[j]
		words[j] = words[k]
		words[k] = swap
	    }
	}
    }

    # reconstruct wordlist in sorted order
    wordlist = ""
    for (k = 1; k <= n; ++k)
    {
	if (k in words)
	    wordlist = append(wordlist, words[k])
    }

    return (wordlist)
}


function tag_status(status,tag, k,n,result,words)
{
    # status[tag] contains "-" (required), "O" (optional), or else
    # something like "-:3", "O:3", or "-:3.2,4C,4L,4S O:3", that is, a
    # list of "optcode:grammar-list" elements
    if (index(status[tag],":") == 0)
    {				# simple case: no grammar levels attached to status
	if (status[tag] == "-")
	    result = "\\&"	# NB: use zero-width character because
	    			# an empty string terminates a .BR list,
	    			# sigh...  I tried using "required", but
	    			# since most tags are required, that
	    			# produces a lot of redundant
	    			# information in the tables.
	else if (status[tag] == "O")
	    result = "optional"
	else
	    result = ("??" status[tag] "??")
    }
    else			# complex case: status is a list of optcode:grammar-list
    {
	n = split(status[tag],words," ")
	result = ""
	for (k = 1; k <= n; ++k)
	{
	    if (substr(words[k],1,1) == "-")
		result = append(result,("required:" level_of(words[k])))
	    else if (substr(words[k],1,1) == "O")
		result = append(result,("optional:" level_of(words[k])))
	    else
		result = append(result,("??" status[tag] "??"))
	}

	# Reduce two special cases to shorter forms
	if (result == "required:")
	    result = "\\&"
	else if (result == "optional:")
	    result = "optional"
    }

    result = small_troff_font(result)

    if (result != "\\&")
	result = (" " result)	# supply leading space separator for non-zero-width result

    return (result)
}


function uncomment(s,outer_comment, comment_start,k1,k2,n)
{
    # Remove <!--comment-- (outer_comment non-zero) or --comment-- (outer_comment zero)
    # sequences in s, and return the reduced s

    comment_start = (outer_comment ? "<!--" : "--")
    n = length(comment_start)

    k1 = index(s,comment_start)
    if (k1 > 0)			# found comment start
    {
	k2 = k1 + n - 1 + index(substr(s,k1+n),"--")
	if (k2 == (k1 + n - 1))
	{
	    warning("unbalanced comment")
	    s = substr(s,1,k1-1) " " substr(s,k1+n)
	}
	else
	    s = substr(s,1,k1-1) " " substr(s,k2+n)
	return (uncomment(s,outer_comment)) # recursively remove remaining comments
    }
    else			# no more comments
	return (s)
}


function uppercase_tag(word)
{
    return ((substr(word,1,1) == "%") ? word : toupper(word))
}


function warning(message)
{
    print FILENAME ":" FNR ":%%" message >"/dev/tty"
#    print FILENAME ":" FNR ":%%" message >"/dev/stderr"
}

# /u/sy/beebe/src/htmlpty/htmlpty-1.00/mrgtable.awk, Mon Nov 10 17:39:27 1997
# Edit by Nelson H. F. Beebe <beebe@plot79.math.utah.edu>
# ========================================================================
# Read the tables output by enttable.awk for different grammar
# files, and merge them into one large table, wherein differences in
# grammars are noted.
#
# Usage:
#	gawk -f mrgtable.awk file(s) >new-table-file
#
# [12-Nov-1997]
# ========================================================================

BEGIN			{ initialize() }

FILENAME != LAST_FILENAME { map_filename() }

/^ContainedIn:/		{ merge_containedin(); next }

/^Contains:/		{ merge_contains(); next }

/^CannotContain:/	{ merge_cannotcontain(); next }

/^ExpReqBEGIN:/		{ merge_reqbegin(); next }

/^ExpReqEND:/		{ merge_reqend(); next }

END			{ print_tables() }

# ======================================================================


function clear_array(array, key)
{
    for (key in array)
	delete array[key]
}


function convert_levels_to_small_font(array, k,key,level,n,words,wordlist)
{
    for (key in array)
    {
	n = split(array[key],words," ")
	wordlist = ""
	for (k = 1; k <= n; ++k)
	{
	    level = level_of(words[k])
	    wordlist = append(wordlist, \
		(tag_of(words[k]) ((level == "") ? "" : (":" small_troff_font(level)))))
	}
	array[key] = wordlist
    }
}


function copy_array(target,source, word)
{
    clear_array(target)
    for (word in source)
	target[word] = source[word]
}


function count(array, key,n)
{
    n = 0
    for (key in array)
	n++
    return (n)
}


function initialize()
{
    # These are all of the .dtd grammar files that are complete in
    # themselves, excluding old draft versions that have been superceded
    # by final versions.  We ignore any files that end with an include
    # of another file, since enttable.awk does not handle file
    # inclusion or DTD conditionals.
    File_to_Grammar_Level["html"]               = "2"
    File_to_Grammar_Level["html-3"]             = "3"
    File_to_Grammar_Level["HTML32"]             = "3.2"
    File_to_Grammar_Level["Cougar"]             = "4C"
    File_to_Grammar_Level["HTML4-loose"]        = "4L"
    File_to_Grammar_Level["HTML4-strict"]       = "4S"
    File_to_Grammar_Level["html-mcom"]          = "M"

    Deprecated["BQ"]		= 1
    Deprecated["DIR"]		= 1
    Deprecated["LISTING"]	= 1
    Deprecated["MENU"]	= 1
    Deprecated["NEXTID"]	= 1
    Deprecated["PLAINTEXT"]	= 1
    Deprecated["XMP"]		= 1

    Extra_Text["PLAINTEXT"]	= ".IP\n\
.hy\n\
.ad\n\
NB: The meaning of this tag is aberrant, in that the closing tag is\n\
not supposed to be present, even though the grammar says that it is\n\
optional: the environment instead terminates at end-of-file.  Browsers\n\
differ in their handling of the end tag: some display it as ordinary\n\
text, and others terminate the environment.\n\
.na\n\
.nh\n\
.PP"

}


function level_of(tag_and_level, k)
{   # convert "tag:level" to "level", and "tag" to "", and return the result
    k = index(tag_and_level,":")
    return ((k > 0) ? substr(tag_and_level,k+1) : "")
}


function map_filename( file)
{
    file = FILENAME

    gsub(/[.][^.]+$/,"",file) # reduce /the/path/to/file.ext to /the/path/to/file

    while (match(file,/^[^\/]*\//)) # reduce /the/path/to/file to file
	file = substr(file,RSTART+RLENGTH)

    if (file in File_to_Grammar_Level)
	Grammar_Level = File_to_Grammar_Level[file]
    else
    {
	warning("Cannot map file " FILENAME " to grammar level: job terminated")
	exit(1)
    }

    Grammar_Levels_Seen[Grammar_Level]++

    LAST_FILENAME = FILENAME
}


function merge_cannotcontain( k,tag)
{
    tag = substr($1,15)
    for (k = 2; k <= NF; ++k)
	Merged_CannotContain[tag] = append(Merged_CannotContain[tag],($k ":" Grammar_Level))
}


function merge_containedin( k,tag)
{
    tag = substr($1,13)
    for (k = 2; k <= NF; ++k)
	Merged_ContainedIn[tag] = append(Merged_ContainedIn[tag],($k ":" Grammar_Level))
}


function merge_contains( k,tag)
{
    tag = substr($1,10)
    for (k = 2; k <= NF; ++k)
	Merged_Contains[tag] = append(Merged_Contains[tag],($k ":" Grammar_Level))
}


function merge_reqbegin( k,tag)
{
    tag = substr($1,13)
    for (k = 2; k <= NF; ++k)
	Merged_Require_Begin[tag] = append(Merged_Require_Begin[tag],($k ":" Grammar_Level))
}


function merge_reqend( k,tag)
{
    tag = substr($1,11)
    for (k = 2; k <= NF; ++k)
	Merged_Require_End[tag] = append(Merged_Require_End[tag],($k ":" Grammar_Level))
}


function merge_words(wordlist, k,levellist,n,n_grammar_levels,new_wordlist,new_words,tag,tag_count,words)
{
    # Take a (possibly unsorted) word list like
    #	A:2 A:3 A:3.2 A:4L ABBREV:3 ABOVE:3 ACRONYM:3 ACRONYM:4L
    #	ADDRESS:2 ADDRESS:3 ADDRESS:3.2 ADDRESS:4L AU:3 B:2 B:3 B:3.2 B:4L
    #	BAR:3 BDO:4L BELOW:3 BIG:3 BIG:3.2 BIG:4L ....
    # and return a sorted list like
    #	A ABBREV:3 ABOVE:3 ACRONYM:3,4L ADDRESS AU:3 B BAR:3 BDO:4L BELOW:3
    #	BIG:3,3.2,4L ...
    # where tags belonging to all known grammar levels have the level list
    # omitted.

    n_grammar_levels = count(Grammar_Levels_Seen)

    n = split(wordlist,words," ")
    for (k = 1; k <= n; ++k)	# first build a list of counts of all known tags
	tag_count[tag_of(words[k])]++

    for (k = 1; k <= n; ++k)
    {
	tag = tag_of(words[k])
	if (tag_count[tag] == n_grammar_levels)
	{			# then this tag is in all grammar levels
	    if (!(tag in new_words))
		new_words[tag] = tag # save tag WITHOUT suffixed grammar level list
	}
	else			# this tags is NOT in all grammar levels
	{
	    if (tag in new_words) # just append level to current tag:levellist
		new_words[tag] = (new_words[tag] "," level_of(words[k]))
	    else		# save tag WITH suffixed grammar level list
		new_words[tag] = words[k]
	}
    }

    new_wordlist = ""
    for (tag in new_words)
    {
	# First sort the grammar levels into ascending order for each entry in
	# new_words[]
	levellist = level_of(new_words[tag])
	gsub(/,/," ",levellist)
	levellist = sort_words(levellist)
	gsub(/ /,",",levellist)
	new_words[tag] = (tag_of(new_words[tag]) ":" levellist)

	# Build up a new word list
	new_wordlist = append(new_wordlist,new_words[tag])
    }
    return (sort_words(new_wordlist))
}


function print_tables()
{
    Sort_Pipe = "sort"
    Sort_Pipe = "cat"

    print_merged_table("ContainedIn",Merged_ContainedIn)
    print_merged_table("Contains",Merged_Contains)
    print_merged_table("CannotContain",Merged_CannotContain)
    print_merged_table("ReqBEGIN",Merged_Require_Begin)
    print_merged_table("ReqEND",Merged_Require_End)

    close(Sort_Pipe)

    copy_array(CannotContain, Merged_CannotContain)
    copy_array(ContainedIn, Merged_ContainedIn)
    copy_array(Contains, Merged_Contains)
    copy_array(Require_Begin, Merged_Require_Begin)
    copy_array(Require_End, Merged_Require_End)

    convert_levels_to_small_font(ContainedIn)
    convert_levels_to_small_font(Contains)
    convert_levels_to_small_font(CannotContain)

    do_manpage_table()
}


function print_merged_table(table_name,merged_table, word)
{
    for (word in merged_table)
    {
#	merged_table[word] = merge_words(sort_words(merged_table[word]))
	merged_table[word] = merge_words(merged_table[word])
	printf("%-31s\t%s\n", table_name ":" word, merged_table[word]) | Sort_Pipe
    }
}


function tag_of(tag_and_level, k)
{   # convert "tag:level" to tag, and "tag" to "tag", and return the result
    k = index(tag_and_level,":")
    return ((k > 0) ? substr(tag_and_level,1,k-1) : tag_and_level)
}


# ======================================================================
# NB: NO CHANGES BELOW THIS LINE
# The following functions are borrowed intact from enttable.awk


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


function do_manpage_paragraph(tag,contained_list,contains_list,cannotcontain_list, deprecated)
{
    print ".\\\"---------------------------------------------------------------------"

    # NB: ANY appears only in html-mcom.dtd, and means essentially
    # #PCDATA or any tag defined in the grammar (see p. 411 of
    # Goldfarb and Rubinsky, The SGML Handbook).

    # Since only a few tags are deprecated, we make the output cleaner
    # by creating a minimal deprecated string.
    deprecated = deprecated_status(tag) 
    deprecated = ((deprecated == "\\&") ? "" : (" \"" deprecated "\""))

    if ( (tag == "#PCDATA") || (tag == "ANY") || \
	 (tag == "CDATA") || (tag == "EMPTY") )	# then pseudo-tag
	print ".B " tag		# none of these are deprecated, so deprecated_status() is not called
    else if (contains_list ~ /EMPTY/) # then never has end tag
	print ".BR \"<" tag ">\"", \
		"\"" tag_status(Require_Begin,tag) "\"" deprecated
    else
	print ".BR \"<" tag ">\"", \
		"\"" tag_status(Require_Begin,tag) "\"", \
		"\" .\\|.\\|. </" tag ">\"", \
		"\"" tag_status(Require_End,tag) "\"" deprecated

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

# /u/sy/beebe/src/htmlpty/htmlpty-1.00/cittable.awk, Tue Nov 11 17:30:34 1997
# Edit by Nelson H. F. Beebe <beebe@plot79.math.utah.edu>
# ========================================================================
# Make a .cit file from the ContainedIn: lines of an Entities/*.tab
# file, showing for each tag, which tag environments it may be
# contained in.
#
# Usage:
#	awk -f cittable.awk [-v WIDTH=nnn] infile >outfile
#
# [13-Nov-1997]
# ========================================================================

BEGIN			{ initialize() }

/^CannotContain:/	{ do_containedin("CannotContain") }

/^ContainedIn:/		{ do_containedin("ContainedIn") }

function do_containedin(array_name, k,line_length,tag)
{
    if (first)
    {
	do_header()
	first = 0
    }
    tag = substr($1,length(array_name)+2)
    printf("%-25s :", array_name "[" tag "]")
    line_length = 27
    for (k = 2; k <= NF; ++k)
    {
        gsub(/:[0-9A-Z,.]*/,"",$k) # remove grammar level list
	if ((line_length + 1 + length($k) + 2) > WIDTH)
	{
	    printf(" \\\n%-25s  ","")
	    line_length = 27
	}
	line_length += 1 + length($k)
	printf(" %s",$k)
    }
    print "\n"
}


function do_header()
{
    print "%% html-pretty version 1.00 date [11-Nov-1997]"
    print "%% This is the contained-in tag relationships file,"
    print "%% prepared from",FILENAME,"by cittable.awk."

    # Typical value: "Tue Nov 11 17:37:35 MST 1997"
    #                 123456789.123456789.12345678
    # Want:               xxx xx              xxxx
    print "%% [" substr(Current_Date_and_Time,9,2) "-" \
		 substr(Current_Date_and_Time,5,3) "-" \
		 substr(Current_Date_and_Time,25,4) "]"

    print ""
}



function initialize()
{
    if (WIDTH == "")
	WIDTH = 72

    "date" | getline Current_Date_and_Time
    close("date")
    first = 1
}

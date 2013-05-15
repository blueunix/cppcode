# /u/sy/beebe/public_html/htmlpty/entity-xref.awk, Mon Oct 27 23:24:14 1997
# Edit by Nelson H. F. Beebe <beebe@sunrise.math.utah.edu>
# ========================================================================
# Make a cross-reference of names defined in the Entities/*.ent files,
# showing which grammar files they are each defined in.
#
# Usage:
#	gawk -f entity-xref.awk files >xref-file
#
# [27-Oct-1997]
# ========================================================================

/^[A-Z]+/	{ Entity[$1] = Entity[$1] " " dtd(FILENAME) }

END   		{
		    "date" | getline Current_Date_and_Time
		    close("date")
		    print "# HTML entities cross-referenced to defining grammar files,"
		    print "# computed on", Current_Date_and_Time
		    print "#"
		    for (e in Entity)
			    printf("%-15s\t%s\n", e,Entity[e]) | "sort"
		    close("sort")
		}

function dtd(s)
{
    sub(/[.]ent$/,".dtd",s)
    match(s,"[^/]+$")
    return (substr(s,RSTART,RLENGTH))
}

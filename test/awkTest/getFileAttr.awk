#!/usr/bin/awk -f
BEGIN   { print "File\tOwner" } 
    { print $2, "\t", $3} 
END     { print " - DONE -" } 

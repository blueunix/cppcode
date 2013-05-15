#!/bin/sh

rval=`echo -n "$1" | cut -d: -f2`
echo $rval

#str=`echo -n "$1" | sed 's/ //g'`
#echo $str


#numofchar=`echo -n "$1" | wc -c | sed 's/ //g' `
#echo $numofchar
#   if [ "$numofchar" = "1" ]; then
#      # only one char in string
#      rval=""
      
#   fi
#   numofcharminus1=`expr $numofchar "-" 1`
#   # now cut all but the last char:
#   rval=`echo -n "$1" | cut -b -$numofcharminus1` 
#   echo $rval
    


#   if [ -z "$1" ]; then
#      # empty string
#      rval=""
#      return
#   fi
#   # wc puts some space behind the output this is why we need sed:
#   numofchar=`echo -n "$1" | sed 's/ //g' | wc -c `
#   echo $numofchar
#   # now cut out the last char
#o  rval=`echo -n "$1" | cut -b $numofchar`
#
#  oecho $rval 





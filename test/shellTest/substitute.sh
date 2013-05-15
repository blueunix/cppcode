# substitute - substitute words with other words

SubstFile=substitute.tab
if [ -r "$SubstFile" ]
then
    echo >&2 \
    "reading substitution table $SubstFile"
else
    echo >&2 \
    "cannot read substitution table $SubstFile"
    exit 1
fi

# We need a newer version of AWK, because oawk
# does not support the "getline < FILE" statement
nawk '
    BEGIN {
        # Read the whole substitution file
        # into the array tab[].
        # Format of the substitution file:
        #   oldword newword
        substfile = "'"$SubstFile"'"
        while ( getline < substfile ) {
          tab [$1] = $2  # fill conversion table
        }
        close (substfile)
    }
    {
        for ( i=1; i<=NF; i++ ) {
          if ( tab [$i] != "" ) {
            # substitute old word
            $i = tab [$i]
          }
        }
        print
    }
' "$@"

#/bin/sh

cat << EOFFILE
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
<HTML>
    <HEAD>
        <TITLE>
             <!-- Please supply a descriptive title here -->
        </TITLE>
        <!-- Please supply a correct e-mail address here -->
        <LINK REV="made"
            HREF="mailto:zhaojianxiang@zhaojianxiang-ThinkPad-E420">
    </HEAD>
    <BODY>
        <TABLE>
EOFFILE


sed -e 's=&=\&amp;=g' \
    -e 's=<=\&lt;=g' \
    -e 's=>=\&gt;=g' \
    -e 's=xxx=</TD><TD>=g' \
    -e 's=^.*$=              <TR><TD>&</TD></TR>='

cat << EOFFILE
        </TABLE>
    </BODY>
</HTML>    
EOFFILE

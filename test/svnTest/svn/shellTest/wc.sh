


last | cut -d ' ' -f 1|sort|uniq -c
last | grep [a-zA-Z] | grep -v 'wtmp' | wc -l 

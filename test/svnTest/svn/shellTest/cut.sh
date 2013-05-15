export | cut -c 12-
last | cut -d ' ' -f 1
echo $PATH | cut -d ':' -f 5


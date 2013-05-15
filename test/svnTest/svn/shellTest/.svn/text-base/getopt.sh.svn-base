vflag=off
filename=
set -- `getopt vf:l "$@"`
[ $# -lt 1 ] && exit 1  # getopt failed
echo "process opt"
while [ $# -gt 0 ]
do
    case "$1" in
        -v) vflag=on;;
        -f) filename="$2"; shift;;
        -l) echo "l exist";;
        --) shift; break;;
        -*)
                echo >&2 \
                "usage: $0 [-v] [-f file] file ..."
                exit 1;;
        *)  break;;   # terminate while loop
    esac
    shift
done
# all command line switches are processed,
# "$@" contains all file names
echo $filename
echo $vflag
echo $@

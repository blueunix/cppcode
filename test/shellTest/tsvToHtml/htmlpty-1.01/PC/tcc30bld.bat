:# Build htmlpty with Borland Turbo C 3.0
:# [24-Nov-1997] -- update for version 1.00
:# [12-May-1995]

tcc -I. -ehtmlpty.exe -mc -j10 -Dconst= -DUSER="beebe" -DHOSTNAME="math.utah.edu" htmlpty.c fileutil.c sysutil.c table.c
del fileutil.obj
del htmlpty.obj
del sysutil.obj
del table.obj

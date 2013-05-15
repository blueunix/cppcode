:# Build htmlpty with Borland Turbo C 2.0
:# [31-Oct-1997] -- update for version 1.00
:# [18-Apr-1995]

tcc -I. -ehtmlpty.exe -mc -A -DUSER="beebe" -DHOSTNAME="sunrise" htmlpty.c table.c
del htmlpty.obj 
del table.obj


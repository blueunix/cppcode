#!/usr/bin/env gnuplot

set title 'Usage share data from Wikimedia visitor log analysis report' font 'Ubuntu,14'
set term wxt size 800,600
set out 'browser.png'
set datafile sep ','
set border 3
set key autotitle col under nobox
set style data hist
set style hist rows
set boxwidth 0.5
set style fill solid 0.5 noborder
set xtics scale 0 rotate by -45 font 'Ubuntu,9'
set ytics scale 0 font 'Ubuntu,9'
set format y '%g%%'
set rmargin 5
set bmargin 8
set grid y

# plot rowstacked histogram
plot 'browser.csv' u 2:xtic(1), for [i=3:6] '' u i

# 暂停3秒
pause 20 

unset key
set key autotitle columnheader vertical right out box
unset format
set style hist columns
set xtics norotate font 'Ubuntu,11'

# plot columnstacked histogram
plot 'browser.csv' u 2:key(1), for [i=3:8] '' u i

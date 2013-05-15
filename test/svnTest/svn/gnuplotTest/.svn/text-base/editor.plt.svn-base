#!/usr/bin/env gnuplot

set terminal png
set output 'editor.png'
set title "What's your favorite text editor?" font 'Ubuntu,16'
set xtics scale 0 rotate by -45
set style fill solid 0.25 noborder
set box 0.5
set rmargin 5
set bmargin 5
set grid y

plot 'editor.csv' using 2:xtic(1) with boxes linecolor rgb 'blue' title 'Votes',\
     '' using 0:($2+50):3 with labels notitle

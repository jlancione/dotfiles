# inside gnuplot run with: load "name.gp"
reset

# for surface plots visualized with coloured map
#set pm3d map 
#set palette defined
#set autoscale xfixmin
#set autoscale xfixmax
#set autoscale yfixmin
#set autoscale yfixmax

fname = ".dat"

#set xrange[-2.5:2.5]
set xlabel "x" font ",18"
set ylabel "y" font ",18"
set log x
set log y

plot fname title "title" 

# 2 empty lines for different datastreams, <using> is the keyword for the columns, index is the keyword for datastreams
#plot fname using 1:2 index 0 title "title" 
#replot 1/sqrt(x) with lines
#splot fname u 1:2:3 #for surface plots

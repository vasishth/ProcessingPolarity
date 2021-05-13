#!/bin/sh

#for f in trace.*; do tr '\r' '\n' < $f > tmp && mv tmp $f; done

#./att4plotting.awk cond=a trace.a > a.txt
#./att4plotting.awk cond=b trace.b > b.txt
#./att4plotting.awk cond=c trace.c > c.txt
#./att4plotting.awk cond=d trace.d > d.txt
#./att4plotting.awk cond=e trace.e > e.txt
#./att4plotting.awk cond=f trace.f > f.txt
./att4plotting-pirat.awk cond=a trace.pirat-a > a.txt
./att4plotting-pirat.awk cond=b trace.pirat-b > b.txt
./att4plotting-pirat.awk cond=c trace.pirat-c > c.txt
./att4plotting-pirat.awk cond=d trace.pirat-d > d.txt
./att4plotting-pirat.awk cond=e trace.pirat-e > e.txt
./att4plotting-pirat.awk cond=f trace.pirat-f > f.txt


egrep -B8 .+SPARSAM a.txt | awk '{if ($0 ~ /^--$/) ;else print $0}' > a.completed  
egrep -B8 .+SPARSAM b.txt | awk '{if ($0 ~ /^--$/) ;else print $0}' > b.completed 
egrep -B8 .+SPARSAM c.txt | awk '{if ($0 ~ /^--$/) ;else print $0}' > c.completed 
egrep -B8 .+SPARSAM d.txt | awk '{if ($0 ~ /^--$/) ;else print $0}' > d.completed 
egrep -B8 .+SPARSAM e.txt | awk '{if ($0 ~ /^--$/) ;else print $0}' > e.completed 
egrep -B8 .+SPARSAM f.txt | awk '{if ($0 ~ /^--$/) ;else print $0}' > f.completed


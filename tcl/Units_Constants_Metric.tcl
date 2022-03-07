global m
global sec
global kN
global ton
global Mg
global kg
global kPa
global cm
global mm
global Pa
global MPa
global GPa
global N
global kgf
global cm2
global cm4
global m2
global mm2

global lbm
global lbf
global kip
global ksi
global psi
global in
global in2
global in4
global ft
global pi
global g
global U
global u
global kipin
global kNsec/m
set m 1.;
set sec 1.;
set kN 1.;
set ton  1. ;
set Mg  $ton;
set kg  [expr $ton/1000.];
set kPa [expr $kN/pow($m,2)];
set cm  [expr $m/100.];
set mm  [expr $m/1000.];
set Pa  [expr $kPa/1000.];
set MPa [expr 1000.*$kPa];
set GPa [expr 1000.*$MPa];
set N   [expr $kN/1000.];
set kgf [expr 9.81*$N];
set cm2 [expr $cm*$cm];
set cm4 [expr $cm2*$cm2];
set m2  [expr $m*$m];
set mm2 [expr $mm*$mm];
set lbm [expr $kg*0.4536];
set lbf [expr $N*4.448222];
set kip [expr $lbf*1000];
set ksi [expr 6894.757*$kPa];
set psi [expr 6.894757*$kPa];
set in  [expr 2.54*$cm];
set in2 [expr $in*$in];
set in4 [expr $in2*$in2];
set ft  [expr 12.*$in];
set pi  [expr 2.*asin(1.0)];
set g   [expr 9.81*$m/pow($sec,2)];
set U 	1.e10;
set u 	[expr 1./$U];
set kNsec/m [expr $kN*$sec/$m];
set kipin [expr $kip*$in];
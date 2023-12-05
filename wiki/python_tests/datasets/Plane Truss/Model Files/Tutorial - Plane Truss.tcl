#
#   ____ _ ____         ___                   ____                   ___       _             __                
#  / ___(_)  _ \   _   / _ \ _ __   ___ _ __ / ___|  ___  ___  ___  |_ _|_ __ | |_ ___ _ __ / _| __ _  ___ ___ 
# | |  _| | | | |_| |_| | | | '_ \ / _ \ '_ \\___ \ / _ \/ _ \/ __|  | || '_ \| __/ _ \ '__| |_ / _` |/ __/ _ \
# | |_| | | |_| |_   _| |_| | |_) |  __/ | | |___) |  __/  __/\__ \  | || | | | ||  __/ |  |  _| (_| | (_|  __/
#  \____|_|____/  |_|  \___/| .__/ \___|_| |_|____/ \___|\___||___/ |___|_| |_|\__\___|_|  |_|  \__,_|\___\___|
#                           |_|                                                                                
#
# GiD + OpenSees Interface - An Integrated FEA Platform
# Copyright (C) 2016-2023
#
# Lab of R/C and Masonry Structures
# School of Civil Engineering, AUTh
#
# Development Team
#
# T. Kartalis-Kaounis, Dipl. Eng. AUTh, MSc
# V.K. Papanikolaou, Dipl. Eng., MSc DIC, PhD, Asst. Prof. AUTh
#
# Project Contributors
#
# F. Derveni, Dipl. Eng. AUTh, PhD
# G. Ntinolazos, Dipl. Eng. AUTh
# T. Papadopoulos, Dipl. Eng. AUTh, MSc
# V. Protopapadakis, Dipl. Eng. AUTh, MSc
# T. Zachariadis, Dipl. Eng. AUTh, MSc
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# --------------------------------------------------------------------------------------------------------------
# U N I T S
# --------------------------------------------------------------------------------------------------------------

# Length : m
# Force  : kN
# Moment : kNm
# Stress : kPa
# Mass   : ton

# --------------------------------------------------------------------------------------------------------------
# M A T E R I A L S / S E C T I O N S ( E L E M E N T S )
# --------------------------------------------------------------------------------------------------------------

# IPE 200 (22)
# L 70X50X6 (19)

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  2DOF  (2)
#
# --------------------------------------------------------------------------------------------------------------

model BasicBuilder -ndm 2 -ndf 2

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord

node      1           20            0
node      2           20            2
node      3           18            0
node      4           18          2.1
node      5           16            0
node      6           16          2.2
node      7           14            0
node      8           14          2.3
node      9           12            0
node     10           12          2.4
node     11           10            0
node     12           10          2.5
node     13            8            0
node     14            8          2.4
node     15            6            0
node     16            6          2.3
node     17            4            0
node     18            4          2.2
node     19            2            0
node     20            2          2.1
node     21            0            0
node     22            0            2

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl

fix      1   1   1
fix      2   1   1
fix     21   1   1
fix     22   1   1

# --------------------------------------------------------------------------------------------------------------
# T R U S S   E L E M E N T S  (2 DOF)
# --------------------------------------------------------------------------------------------------------------

# Uniaxial Materials definition used by Truss Elements
# (only if they have not been already defined on this model domain)

uniaxialMaterial Elastic 259 2e+08

# Truss Definition : element truss $eleTag $inode $jnode $A $matTag -rho $rho -cMass $cFlag -doRayleigh $rFlag

element truss      1      1     2      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      2      2     4      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      3      4     6      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      4      6     8      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      5      8    10      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      6     10    12      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      7     12    14      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      8     14    16      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss      9     16    18      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     10     18    20      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     11     20    22      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     12     21    19      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     13     19    17      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     14     17    15      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     15     15    13      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     16     13    11      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     17     11     9      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     18      9     7      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     19      7     5      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     20      5     3      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     21      3     1      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     22     19    20     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     23     17    18     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     24     15    16     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     25     13    14     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     26     11    12     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     27      9    10     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     28      7     8     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     29      5     6     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     30      3     4     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     31      1     4     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     32      4     5     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     33      5     8     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     34      8     9     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     35      9    12     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     36     12    13     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     37     13    16     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     38     16    17     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     39     17    20     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     40     20    21     0.000689 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel
element truss     41     22    21      0.00285 259   -rho        0 -cMass 0 -doRayleigh 0 ; # Steel

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

recorder Node -file Node_displacements.out -time -nodeRange 1 22 -dof 1 2 disp
recorder Node -file Node_rotations.out -time -nodeRange 1 22 -dof 3 disp
recorder Node -file Node_forceReactions.out -time -nodeRange 1 22 -dof 1 2 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 22 -dof 3 reaction
recorder Element -file Truss_axialForce.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 axialForce
recorder Element -file Truss_deformations.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 deformations

logFile "Tutorial - Plane Truss.log"

puts " __   __       __          __                   _       "
puts "/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _"
puts "\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-"
puts "                  |                                     "
puts "                             v2.9.6 with OpenSees v[version]\n"
puts "Analysis summary\n"
puts "Interval 1 : Static - [expr int(1+1)] steps"
puts "\n----------------\n"
set time_start [clock seconds]
puts "Starting analysis...\n"

# --------------------------------------------------------------------------------------------------------------
#
# I N T E R V A L   1
#
# --------------------------------------------------------------------------------------------------------------

puts "Running interval 1"

# Loads - Plain Pattern

pattern Plain 100 Linear {
    load      4        0      -10
    load      6        0      -10
    load      8        0      -10
    load     10        0      -10
    load     12        0      -10
    load     14        0      -10
    load     16        0      -10
    load     18        0      -10
    load     20        0      -10
}

# recording the initial status

record

# Analysis options

wipeAnalysis
system BandGeneral
numberer RCM
constraints Transformation
integrator LoadControl 1
algorithm Linear
analysis Static
set committedSteps 1
for {set i 1} { $i <= 1 } {incr i 1} {
    set AnalOk [analyze 1]
    if {$AnalOk !=0} {
        break
    } else {
        set committedSteps [expr $committedSteps+1]
    }
}
if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED"
    puts "Committed steps : $committedSteps\n"
}

# --------------------------------------------------------------------------------------------------------------

set hour 0.0
set minute 0.0
set second 0.0
set time_end [clock seconds]
set analysisTime [expr $time_end-$time_start]

puts "Analysis finished.\n"

if {$analysisTime<60} {
    if {$analysisTime==0} {
        puts "Analysis time : less than one second"
    } elseif {$analysisTime==1} {
        puts "Analysis time : 1 second"
    } else {
        puts "Analysis time : $analysisTime seconds"
    }

}  elseif {$analysisTime<3600} {
    set minutes [expr $analysisTime/60]
    set seconds [expr $analysisTime%60]

    if {$minutes==1} {
        puts -nonewline "Analysis time : 1 minute"
    } else {
        puts -nonewline "Analysis time : $minutes minutes"
    }

    if {$seconds==0} {
        puts ""
    } elseif {$seconds==1} {
        puts " and 1 second"
    } else {
        puts " and $seconds seconds"
    }

} else  {
    set hours [expr $analysisTime/3600]
    set minutes [expr ($analysisTime%3600)/60]
    set seconds [expr ($analysisTime%3600)%60]

    if {$hours==1} {
        puts -nonewline "Analysis time : 1 hour"
    } else {
        puts -nonewline "Analysis time : $hours hours"
    }

    if {$minutes==0} {
    } elseif {$minute==1} {
        puts -nonewline ", 1 minute"
    } else {
        puts -nonewline ", $minutes minutes"
    }

    if {$seconds==0} {
        puts ""
    } elseif {$second==1} {
        puts " and 1 second"
    } else {
        puts " and $seconds seconds"
    }
}

# --------------------------------------------------------------------------------------------------------------
#
# M E T A D A T A
#
# --------------------------------------------------------------------------------------------------------------

# Number of nodes
# 22

# Elements 1D
# 41

# Elements 2D
# 0

# Elements 3D
# 0

# Truss
# 41
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41

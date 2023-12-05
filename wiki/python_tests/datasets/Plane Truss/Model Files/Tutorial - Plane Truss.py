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
import openseespy.opensees as ops
import time
import math


ops.model("basic", "-ndm", 2, "-ndf", 2)

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord

ops.node(     1,            0,            0)
ops.node(     2,            2,            0)
ops.node(     3,            0,            2)
ops.node(     4,            2,          2.1)
ops.node(     5,            4,            0)
ops.node(     6,            4,          2.2)
ops.node(     7,            6,            0)
ops.node(     8,            6,          2.3)
ops.node(     9,            8,            0)
ops.node(    10,            8,          2.4)
ops.node(    11,           10,            0)
ops.node(    12,           10,          2.5)
ops.node(    13,           12,            0)
ops.node(    14,           12,          2.4)
ops.node(    15,           14,            0)
ops.node(    16,           14,          2.3)
ops.node(    17,           16,            0)
ops.node(    18,           16,          2.2)
ops.node(    19,           18,            0)
ops.node(    20,           18,          2.1)
ops.node(    21,           20,            0)
ops.node(    22,           20,            2)

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl

ops.fix(     1,   1,   1)
ops.fix(     3,   1,   1)
ops.fix(    21,   1,   1)
ops.fix(    22,   1,   1)

# --------------------------------------------------------------------------------------------------------------
# T R U S S   E L E M E N T S  (2 DOF)
# --------------------------------------------------------------------------------------------------------------

# Uniaxial Materials definition used by Truss Elements
# (only if they have not been already defined on this model domain)


ops.uniaxialMaterial("Elastic", 259, 2e+08)

# Truss Definition : element truss $eleTag $inode $jnode $A $matTag -rho $rho -cMass $cFlag -doRayleigh $rFlag

ops.element('truss',      1,     21,     22,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      2,     22,     20,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      3,     20,     18,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      4,     18,     16,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      5,     16,     14,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      6,     14,     12,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      7,     12,     10,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      8,     10,      8,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',      9,      8,      6,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     10,      6,      4,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     11,      4,      3,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     12,      1,      2,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     13,      2,      5,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     14,      5,      7,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     15,      7,      9,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     16,      9,     11,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     17,     11,     13,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     18,     13,     15,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     19,     15,     17,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     20,     17,     19,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     21,     19,     21,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     22,      2,      4,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     23,      5,      6,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     24,      7,      8,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     25,      9,     10,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     26,     11,     12,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     27,     13,     14,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     28,     15,     16,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     29,     17,     18,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     30,     19,     20,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     31,     21,     20,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     32,     20,     17,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     33,     17,     16,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     34,     16,     13,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     35,     13,     12,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     36,     12,      9,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     37,      9,      8,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     38,      8,      5,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     39,      5,      4,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     40,      4,      1,     0.000689, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel
ops.element('truss',     41,      3,      1,      0.00285, 259, '-rho',        0, '-cMass', 0, '-doRayleigh', 0) # Steel

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

ops.recorder('Node', '-file', 'Node_displacements.out', '-time', '-nodeRange', 1, 22, '-dof', 1, 2, 'disp')
ops.recorder('Node', '-file', 'Node_rotations.out', '-time', '-nodeRange', 1, 22, '-dof', 3, 'disp')
ops.recorder('Node', '-file', 'Node_forceReactions.out', '-time', '-nodeRange', 1, 22, '-dof', 1, 2, 'reaction')
ops.recorder('Node', '-file', 'Node_momentReactions.out', '-time', '-nodeRange', 1, 22, '-dof', 3, 'reaction')
ops.recorder('Element', '-file', 'Truss_axialForce.out', '-time', '-ele', 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 'axialForce')
ops.recorder('Element', '-file', 'Truss_deformations.out', '-time', '-ele', 1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10 ,11 ,12 ,13 ,14 ,15 ,16 ,17 ,18 ,19 ,20 ,21 ,22 ,23 ,24 ,25 ,26 ,27 ,28 ,29 ,30 ,31 ,32 ,33 ,34 ,35 ,36 ,37 ,38 ,39 ,40 ,41 ,'deformations')

ops.logFile("Tutorial - Plane Truss.log")

print(" __   __       __          __                   _       ")
print("/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _")
print("\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-")
print("                  |                                     ")
print("                             v2.9.6 with OpenSeesPy\n")
print("Analysis summary\n")
print("Interval 1 : Static")
print("Static Monotonic")
print(f"{int(1+1)} steps")
print("Static Cyclic")
print("\n----------------\n")
time_start = time.time()
print("Starting analysis...\n")

# --------------------------------------------------------------------------------------------------------------
#
# I N T E R V A L   1
#
# --------------------------------------------------------------------------------------------------------------

print("Running interval 1")

# Loads - Plain Pattern

ops.timeSeries('Linear', 200)
ops.pattern('Plain', 100, 200)
ops.load(     4,        0,      -10)
ops.load(     6,        0,      -10)
ops.load(     8,        0,      -10)
ops.load(    10,        0,      -10)
ops.load(    12,        0,      -10)
ops.load(    14,        0,      -10)
ops.load(    16,        0,      -10)
ops.load(    18,        0,      -10)
ops.load(    20,        0,      -10)

# recording the initial status

ops.record()

# Analysis options

ops.wipeAnalysis()
ops.system('BandGeneral')
ops.numberer('RCM')
ops.constraints('Transformation')
ops.integrator("LoadControl", 1)
ops.algorithm("Linear")
ops.analysis('Static')
committedSteps = 1
for i in range(1):
    AnalOk = ops.analyze(1)
    if AnalOk !=0:
        break
    else:
        committedSteps += 1
if AnalOk == 0:
    print("Analysis completed SUCCESSFULLY")
    print(f"Committed steps : {committedSteps}")
else:
    print("Analysis FAILED")
    print(f"Committed steps : {committedSteps}")

# --------------------------------------------------------------------------------------------------------------

hour = 0.0
minute = 0.0
second = 0.0
time_end = time.time()
analysisTime = time_end - time_start

print("Analysis finished.\n")

if analysisTime<60:
    if analysisTime==0:
        print("Analysis time : less than one second")
    elif analysisTime==1:
        print("Analysis time : 1 second")
    else:
        print(f"Analysis time : {analysisTime} seconds")

elif analysisTime<3600:
    minutes = analysisTime / 60
    seconds = analysisTime % 60

    if minutes==1:
        print("Analysis time : 1 minute")
    else:
        print("Analysis time : {minutes} minutes")

    if seconds==0:
        print("")
    elif seconds==1:
        print(" and 1 second")
    else:
        print(f" and {seconds} seconds")

else:
    hours = analysisTime / 3600
    minutes = (analysisTime % 3600) / 60
    seconds = (analysisTime % 3600) % 60

    if hours==1:
        print("Analysis time : 1 hour")
    else:
        print(f"Analysis time : {hours} hours")

    if minutes==0:
        pass
    elif minute==1:
        print(", 1 minute")
    else:
        print(f", {minutes} minutes")

    if seconds==0:
        print("")
    elif second==1:
        print(" and 1 second")
    else:
        print(f" and {seconds} seconds")


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

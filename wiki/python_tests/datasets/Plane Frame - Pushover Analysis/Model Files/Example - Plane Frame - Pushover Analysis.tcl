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

# Column (140)
# Beam (105)

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  3DOF  (3)
#
# --------------------------------------------------------------------------------------------------------------

model BasicBuilder -ndm 2 -ndf 3

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord

node      1           10            0
node      2           10          0.6
node      3           10          1.2
node      4           10          1.8
node      5           10          2.4
node      6           10            3
node      7          9.2            3
node      8          8.4            3
node      9           10          3.6
node     10          7.6            3
node     11            6            0
node     12            6          0.6
node     13            6          1.2
node     14           10          4.2
node     15            6          1.8
node     16          6.8            3
node     17            6          2.4
node     18           10          4.8
node     19            6            3
node     20            6          3.6
node     21           10          5.4
node     22          5.2            3
node     23            6          4.2
node     24           10            6
node     25          9.2            6
node     26          8.4            6
node     27            6          4.8
node     28          4.4            3
node     29          7.6            6
node     30           10          6.6
node     31            6          5.4
node     32          6.8            6
node     33          3.6            3
node     34           10          7.2
node     35            6            6
node     36          5.2            6
node     37            6          6.6
node     38           10          7.8
node     39          2.8            3
node     40            2            0
node     41            2          0.6
node     42            2          1.2
node     43            2          1.8
node     44          4.4            6
node     45            6          7.2
node     46            2          2.4
node     47           10          8.4
node     48            2            3
node     49            6          7.8
node     50            2          3.6
node     51          3.6            6
node     52           10            9
node     53          9.2            9
node     54            2          4.2
node     55          8.4            9
node     56          1.2            3
node     57            6          8.4
node     58          7.6            9
node     59            2          4.8
node     60          2.8            6
node     61          6.8            9
node     62           10          9.6
node     63            2          5.4
node     64            6            9
node     65            2            6
node     66          0.4            3
node     67           10         10.2
node     68          5.2            9
node     69            2          6.6
node     70            6          9.6
node     71          4.4            9
node     72          1.2            6
node     73            2          7.2
node     74           10         10.8
node     75         -0.4            3
node     76            6         10.2
node     77          3.6            9
node     78            2          7.8
node     79          0.4            6
node     80           10         11.4
node     81            6         10.8
node     82          2.8            9
node     83         -1.2            3
node     84            2          8.4
node     85           10           12
node     86           -2            0
node     87         -0.4            6
node     88           -2          0.6
node     89          9.2           12
node     90            2            9
node     91           -2          1.2
node     92            6         11.4
node     93          8.4           12
node     94           -2          1.8
node     95           -2          2.4
node     96          7.6           12
node     97           -2            3
node     98          6.8           12
node     99            2          9.6
node    100           -2          3.6
node    101          1.2            9
node    102           10         12.6
node    103            6           12
node    104         -1.2            6
node    105           -2          4.2
node    106           -2          4.8
node    107          5.2           12
node    108            2         10.2
node    109          0.4            9
node    110           -2          5.4
node    111           10         13.2
node    112            6         12.6
node    113          4.4           12
node    114           -2            6
node    115            2         10.8
node    116          3.6           12
node    117           -2          6.6
node    118         -0.4            9
node    119            6         13.2
node    120           10         13.8
node    121            2         11.4
node    122          2.8           12
node    123           -2          7.2
node    124           -2          7.8
node    125         -1.2            9
node    126            6         13.8
node    127           10         14.4
node    128            2           12
node    129           -2          8.4
node    130          1.2           12
node    131            2         12.6
node    132            6         14.4
node    133           10           15
node    134           -2            9
node    135          9.2           15
node    136          8.4           15
node    137          7.6           15
node    138          6.8           15
node    139           -2          9.6
node    140          0.4           12
node    141            2         13.2
node    142            6           15
node    143           10         15.6
node    144          5.2           15
node    145           -2         10.2
node    146         -0.4           12
node    147            2         13.8
node    148          4.4           15
node    149            6         15.6
node    150           -2         10.8
node    151           10         16.2
node    152          3.6           15
node    153         -1.2           12
node    154            2         14.4
node    155           -2         11.4
node    156          2.8           15
node    157            6         16.2
node    158           10         16.8
node    159           -2           12
node    160            2           15
node    161            6         16.8
node    162          1.2           15
node    163           10         17.4
node    164           -2         12.6
node    165            2         15.6
node    166          0.4           15
node    167           -2         13.2
node    168            6         17.4
node    169           10           18
node    170          9.2           18
node    171            2         16.2
node    172          8.4           18
node    173          7.6           18
node    174         -0.4           15
node    175          6.8           18
node    176           -2         13.8
node    177            6           18
node    178           10         18.6
node    179            2         16.8
node    180          5.2           18
node    181         -1.2           15
node    182           -2         14.4
node    183          4.4           18
node    184            6         18.6
node    185          3.6           18
node    186            2         17.4
node    187           10         19.2
node    188           -2           15
node    189          2.8           18
node    190            6         19.2
node    191           -2         15.6
node    192            2           18
node    193           10         19.8
node    194          1.2           18
node    195           -2         16.2
node    196            6         19.8
node    197            2         18.6
node    198           10         20.4
node    199          0.4           18
node    200           -2         16.8
node    201            6         20.4
node    202         -0.4           18
node    203            2         19.2
node    204           10           21
node    205          9.2           21
node    206          8.4           21
node    207           -2         17.4
node    208          7.6           21
node    209         -1.2           18
node    210          6.8           21
node    211            2         19.8
node    212            6           21
node    213          5.2           21
node    214           -2           18
node    215          4.4           21
node    216            2         20.4
node    217          3.6           21
node    218           -2         18.6
node    219          2.8           21
node    220            2           21
node    221           -2         19.2
node    222          1.2           21
node    223          0.4           21
node    224           -2         19.8
node    225         -0.4           21
node    226           -2         20.4
node    227         -1.2           21
node    228           -2           21

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl z-rot

fix      1   1   1   1
fix     11   1   1   1
fix     40   1   1   1
fix     86   1   1   1

# --------------------------------------------------------------------------------------------------------------
# F O R C E - B A S E D   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# Geometric Transformation

geomTransf Linear 1
geomTransf PDelta 2
geomTransf Corotational 3

# Sections Definition used by forceBeamColumn Elements
# (if they have not already been defined on this model domain)

uniaxialMaterial Concrete01 316 -16000 -0.002 -14000 -0.005
uniaxialMaterial Steel01 311 500000 2e+08 0.15 0 1 0 1


section Fiber 359 -GJ 1e10  {

# Create the Core fibers

patch rect 316      8      8  -0.250000  -0.250000   0.250000   0.250000

# Create the Cover fibers

patch rect 316      8      1  -0.250000   0.250000   0.250000   0.300000
patch rect 316      8      1  -0.250000  -0.300000   0.250000  -0.250000
patch rect 316      1      8  -0.300000  -0.250000  -0.250000   0.250000
patch rect 316      1      8   0.250000  -0.250000   0.300000   0.250000
# Corner Cover fibers
patch rect 316      1      1  -0.300000  -0.300000  -0.250000  -0.250000
patch rect 316      1      1  -0.300000   0.250000  -0.250000   0.300000
patch rect 316      1      1   0.250000  -0.300000   0.300000  -0.250000
patch rect 316      1      1   0.250000   0.250000   0.300000   0.300000


# Create the corner bars

layer straight 311  2   0.00005027   0.250000   0.250000  -0.250000   0.250000
layer straight 311  2   0.00005027   0.250000  -0.250000  -0.250000  -0.250000

# Create the middle bars along local y axis

layer straight 311   2   0.00005027   0.083333   0.250000  -0.083333   0.250000
layer straight 311   2   0.00005027   0.083333  -0.250000  -0.083333  -0.250000

# Create the middle bars along local z axis

layer straight 311   2   0.00005027   0.250000   0.083333   0.250000  -0.083333
layer straight 311   2   0.00005027  -0.250000   0.083333  -0.250000  -0.083333
}


section Fiber 360 {

# Create the Core fibers

patch rect 316     10      4  -0.300000  -0.100000   0.300000   0.100000

# Create the Cover fibers

patch rect 316     10      1  -0.300000   0.100000   0.300000   0.150000
patch rect 316     10      1  -0.300000  -0.150000   0.300000  -0.100000
patch rect 316      2      4  -0.350000  -0.100000  -0.300000   0.100000
patch rect 316      2      4   0.300000  -0.100000   0.350000   0.100000
# Corner Cover fibers
patch rect 316      2      1  -0.350000  -0.150000  -0.300000  -0.100000
patch rect 316      2      1  -0.350000   0.100000  -0.300000   0.150000
patch rect 316      2      1   0.300000  -0.150000   0.350000  -0.100000
patch rect 316      2      1   0.300000   0.100000   0.350000   0.150000


# Create the Top bars (face on local y positive dir)

layer straight 311   3    0.00020110   0.300000   0.100000   0.300000  -0.100000

# Create the Bottom bars (face on local y negative dir)

layer straight 311   3   0.00020110  -0.300000   0.100000  -0.300000  -0.100000
}

# Force-Based Beam-Column Element definition

# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

element forceBeamColumn      1     86     88  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      2     88     91  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      3     91     94  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      4     94     95  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      5     95     97  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      6     97     83  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      7     83     75  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      8     75     66  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn      9     66     56  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     10     56     48  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     11     40     41  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     12     41     42  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     13     42     43  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     14     43     46  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     15     46     48  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     16     48     39  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     17     39     33  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     18     33     28  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     19     28     22  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     20     22     19  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     21     11     12  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     22     12     13  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     23     13     15  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     24     15     17  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     25     17     19  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     26     19     16  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     27     16     10  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     28     10      8  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     29      8      7  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     30      7      6  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     31      1      2  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     32      2      3  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     33      3      4  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     34      4      5  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     35      5      6  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     36     97    100  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     37    100    105  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     38    105    106  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     39    106    110  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     40    110    114  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     41    114    104  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     42    104     87  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     43     87     79  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     44     79     72  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     45     72     65  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     46     48     50  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     47     50     54  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     48     54     59  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     49     59     63  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     50     63     65  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     51     65     60  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     52     60     51  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     53     51     44  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     54     44     36  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     55     36     35  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     56     19     20  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     57     20     23  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     58     23     27  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     59     27     31  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     60     31     35  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     61     35     32  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     62     32     29  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     63     29     26  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     64     26     25  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     65     25     24  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     66      6      9  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     67      9     14  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     68     14     18  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     69     18     21  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     70     21     24  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     71    114    117  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     72    117    123  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     73    123    124  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     74    124    129  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     75    129    134  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     76    134    125  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     77    125    118  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     78    118    109  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     79    109    101  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     80    101     90  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     81     65     69  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     82     69     73  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     83     73     78  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     84     78     84  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     85     84     90  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     86     90     82  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     87     82     77  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     88     77     71  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     89     71     68  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     90     68     64  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     91     35     37  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     92     37     45  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     93     45     49  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     94     49     57  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     95     57     64  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     96     64     61  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     97     61     58  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     98     58     55  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn     99     55     53  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    100     53     52  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    101     24     30  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    102     30     34  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    103     34     38  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    104     38     47  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    105     47     52  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    106    134    139  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    107    139    145  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    108    145    150  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    109    150    155  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    110    155    159  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    111    159    153  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    112    153    146  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    113    146    140  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    114    140    130  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    115    130    128  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    116     90     99  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    117     99    108  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    118    108    115  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    119    115    121  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    120    121    128  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    121    128    122  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    122    122    116  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    123    116    113  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    124    113    107  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    125    107    103  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    126     64     70  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    127     70     76  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    128     76     81  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    129     81     92  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    130     92    103  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    131    103     98  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    132     98     96  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    133     96     93  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    134     93     89  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    135     89     85  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    136     52     62  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    137     62     67  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    138     67     74  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    139     74     80  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    140     80     85  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    141    159    164  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    142    164    167  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    143    167    176  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    144    176    182  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    145    182    188  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    146    188    181  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    147    181    174  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    148    174    166  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    149    166    162  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    150    162    160  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    151    128    131  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    152    131    141  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    153    141    147  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    154    147    154  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    155    154    160  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    156    160    156  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    157    156    152  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    158    152    148  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    159    148    144  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    160    144    142  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    161    103    112  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    162    112    119  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    163    119    126  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    164    126    132  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    165    132    142  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    166    142    138  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    167    138    137  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    168    137    136  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    169    136    135  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    170    135    133  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    171     85    102  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    172    102    111  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    173    111    120  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    174    120    127  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    175    127    133  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    176    188    191  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    177    191    195  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    178    195    200  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    179    200    207  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    180    207    214  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    181    214    209  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    182    209    202  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    183    202    199  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    184    199    194  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    185    194    192  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    186    160    165  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    187    165    171  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    188    171    179  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    189    179    186  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    190    186    192  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    191    192    189  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    192    189    185  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    193    185    183  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    194    183    180  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    195    180    177  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    196    142    149  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    197    149    157  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    198    157    161  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    199    161    168  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    200    168    177  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    201    177    175  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    202    175    173  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    203    173    172  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    204    172    170  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    205    170    169  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    206    133    143  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    207    143    151  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    208    151    158  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    209    158    163  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    210    163    169  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    211    214    218  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    212    218    221  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    213    221    224  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    214    224    226  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    215    226    228  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    216    228    227  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    217    227    225  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    218    225    223  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    219    223    222  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    220    222    220  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    221    192    197  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    222    197    203  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    223    203    211  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    224    211    216  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    225    216    220  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    226    220    219  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    227    219    217  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    228    217    215  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    229    215    213  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    230    213    212  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    231    177    184  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    232    184    190  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    233    190    196  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    234    196    201  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    235    201    212  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    236    212    210  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    237    210    208  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    238    208    206  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    239    206    205  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    240    205    204  3    360  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    241    169    178  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    242    178    187  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    243    187    193  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    244    193    198  3    359  1   -iter   10   1.00e-11   -mass        0
element forceBeamColumn    245    198    204  3    359  1   -iter   10   1.00e-11   -mass        0

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

recorder Node -file Node_displacements.out -time -nodeRange 1 228 -dof 1 2 disp
recorder Node -file Node_rotations.out -time -nodeRange 1 228 -dof 3 disp
recorder Node -file Node_forceReactions.out -time -nodeRange 1 228 -dof 1 2 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 228 -dof 3 reaction
recorder Element -file ForceBeamColumn_localForce.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 localForce
recorder Element -file ForceBeamColumn_basicDeformation.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 basicDeformation
recorder Element -file ForceBeamColumn_plasticDeformation.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 plasticDeformation

logFile "Example - Plane Frame - Pushover Analysis.log"

puts " __   __       __          __                   _       "
puts "/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _"
puts "\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-"
puts "                  |                                     "
puts "                             v2.9.6 with OpenSees v[version]\n"
puts "Analysis summary\n"
puts "Interval 1 : Static - [expr int(1+10)] steps"
puts "Interval 2 : Static - [expr int(1+100)] steps"
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
    load      6        0     -200        0
    load     19        0     -200        0
    load     24        0     -200        0
    load     35        0     -200        0
    load     48        0     -200        0
    load     52        0     -200        0
    load     64        0     -200        0
    load     65        0     -200        0
    load     85        0     -200        0
    load     90        0     -200        0
    load     97        0     -200        0
    load    103        0     -200        0
    load    114        0     -200        0
    load    128        0     -200        0
    load    133        0     -200        0
    load    134        0     -200        0
    load    142        0     -200        0
    load    159        0     -200        0
    load    160        0     -200        0
    load    169        0     -200        0
    load    177        0     -200        0
    load    188        0     -200        0
    load    192        0     -200        0
    load    204        0     -200        0
    load    212        0     -200        0
    load    214        0     -200        0
    load    220        0     -200        0
    load    228        0     -200        0
}

# recording the initial status

record

# Analysis options

wipeAnalysis
system BandGeneral
numberer RCM
constraints Transformation
integrator LoadControl 0.1
test NormDispIncr 0.0001 50 2
algorithm Newton
analysis Static

set Lincr 0.100000
set Nsteps 10
set committedSteps 1
set LoadCounter 0

set strIni {}
variable testTypeStatic NormDispIncr
variable TolStatic 0.0001
variable maxNumIterStatic 50
variable algorithmTypeStatic Newton

for {set i 1} { $i <= $Nsteps } {incr i 1} {
    set t [format "%7.5f" [expr [getTime] + $Lincr]]
    puts -nonewline "(1) $algorithmTypeStatic$strIni LF $t "
    set AnalOk [analyze 1]
    if {$AnalOk !=0} {
        break
    } else {
        set LoadCounter [expr $LoadCounter+1.0]
        set committedSteps [expr $committedSteps+1]
    }
}

if {$AnalOk != 0} {; # if analysis fails, alternative algorithms and substepping is applied
    set firstFail 1
    set AnalOk 0
    set Nk 1
    set returnToInitStepFlag 0
    while {$LoadCounter < $Nsteps && $AnalOk == 0} {
        if {($Nk==2 && $AnalOk==0) || ($Nk==1 && $AnalOk==0)} {
            set Nk 1
            if {$returnToInitStepFlag} {
                puts "\nBack to initial step\n"
                set returnToInitStepFlag 0
            }
            if {$firstFail == 0} { # for the first time only, do not repeat previous failed step
                integrator LoadControl $Lincr; # reset to original increment
                set t [format "%7.5f" [expr [getTime] + $Lincr]]
                puts -nonewline "(1) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
            } else {
                set AnalOk 1
                set firstFail 0
            }
            if {$AnalOk == 0} {
                set LoadCounter [expr $LoadCounter+1.0/$Nk]
                set committedSteps [expr $committedSteps+1]
            }
        }; # end if Nk=1
        # substepping /2
        if {($AnalOk !=0 && $Nk==1) || ($AnalOk==0 && $Nk==4)} {
            set Nk 2; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 2\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
                puts -nonewline "(1) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=2
        # substepping /4
        if {($AnalOk !=0 && $Nk==2) || ($AnalOk==0 && $Nk==8)} {
            set Nk 4; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 4\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
                puts -nonewline "(1) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=4
        # substepping /8
        if {$AnalOk !=0 && $Nk==4 || ($Nk == 16 && $AnalOk == 0)} {
            set Nk 8; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 8\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
                puts -nonewline "(1) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=8
        # substepping /16
        if {($Nk == 8 && $AnalOk!=0)} {
            set Nk 16; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 16\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
                puts -nonewline "(1) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=16
    }; # end while loop
}; # end if AnalOk

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED"
    puts "Committed steps : $committedSteps\n"
}

# all previously defined patterns are constant for so on.

loadConst -time 0.0

# --------------------------------------------------------------------------------------------------------------
#
# I N T E R V A L   2
#
# --------------------------------------------------------------------------------------------------------------

puts "Running interval 2"

# Loads - Plain Pattern

pattern Plain 200 Linear {
    load     97       50        0        0
    load    114      100        0        0
    load    134      150        0        0
    load    159      200        0        0
    load    188      250        0        0
    load    214      300        0        0
    load    228      350        0        0
}

# recording the initial status

record

# Analysis options

wipeAnalysis
system BandGeneral
numberer RCM
constraints Transformation
integrator DisplacementControl 204 1 0.005
test NormDispIncr 0.0001 100 2
algorithm Newton
analysis Static

set Dmax 0.5
set Dincr 0.005000
set Nsteps 100
set committedSteps 1
set IDctrlNode 204
set IDctrlDOF 1

set strIni {}
variable testTypeStatic NormDispIncr
variable TolStatic 0.0001
variable maxNumIterStatic 100
variable algorithmTypeStatic Newton

for {set i 1} { $i <= $Nsteps } {incr i 1} {
    set t [getTime]
    puts -nonewline "(2) $algorithmTypeStatic$strIni LF $t "
    set AnalOk [analyze 1]
    if {$AnalOk !=0} {
        break
    } else {
        set committedSteps [expr $committedSteps+1]
    }
}

if {$AnalOk != 0} {; # if analysis fails, alternative algorithms and substepping is applied
    set firstFail 1
    set Dstep 0.0
    set AnalOk 0
    set Nk 1
    set returnToInitStepFlag 0
    while {$Dstep <= 1.0 && $AnalOk == 0} {
        set controlDisp [nodeDisp $IDctrlNode $IDctrlDOF]
        set Dstep [expr $controlDisp/$Dmax]
        if {($Nk==2 && $AnalOk==0) || ($Nk==1 && $AnalOk==0)} {
            set Nk 1
            if {$returnToInitStepFlag} {
                puts "\nBack to initial step\n"
                set returnToInitStepFlag 0
            }
            if {$firstFail == 0} { # for the first time only, do not repeat previous failed step
                integrator DisplacementControl $IDctrlNode $IDctrlDOF $Dincr; # reset to original increment
                set t [getTime]
                puts -nonewline "(2) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
            } else {
                set AnalOk 1
                set firstFail 0
            }
            if {$AnalOk == 0} {
                set committedSteps [expr $committedSteps+1]
            }
        }; # end if Nk=1
        # substepping /2
        if {($AnalOk !=0 && $Nk==1) || ($AnalOk==0 && $Nk==4)} {
            set Nk 2; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 2\n"
            set DincrReduced [expr $Dincr/$Nk]
            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [getTime]
                puts -nonewline "(2) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=2
        # substepping /4
        if {($AnalOk !=0 && $Nk==2) || ($AnalOk==0 && $Nk==8)} {
            set Nk 4; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 4\n"
            set DincrReduced [expr $Dincr/$Nk]
            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [getTime]
                puts -nonewline "(2) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=4
        # substepping /8
        if {$AnalOk !=0 && $Nk==4 || ($Nk == 16 && $AnalOk == 0)} {
            set Nk 8; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 8\n"
            set DincrReduced [expr $Dincr/$Nk]
            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [getTime]
                puts -nonewline "(2) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
            set returnToInitStepFlag 1
            }
        }; # end if Nk=8
        # substepping /16
        if {($Nk == 8 && $AnalOk!=0)} {
            set Nk 16; # reduce step size
            set continueFlag 1
            puts "\nInitial step is divided by 16\n"
            set DincrReduced [expr $Dincr/$Nk]
            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [getTime]
                puts -nonewline "(2) $algorithmTypeStatic$strIni LF $t "
                set AnalOk [analyze 1]; # zero for convergence
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=16
        set controlDisp [nodeDisp $IDctrlNode $IDctrlDOF]
        set Dstep [expr $controlDisp/$Dmax]
    }; # end while loop
}; # end if AnalOk

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED"
    puts "Committed steps : $committedSteps\n"
}

# all previously defined patterns are constant for so on.

loadConst -time 0.0

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
# 228

# Elements 1D
# 245

# Elements 2D
# 0

# Elements 3D
# 0

# ForceBeamColumn
# 245
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# F R A M E   L O C A L   A X E S   O R I E N T A T I O N
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#      ID                           Type                       Local-x                       Local-y                       Local-z          Literal      Material / Section
#
#       1                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#       2                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#       3                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#       4                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#       5                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#       6                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#       7                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#       8                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#       9                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      10                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      11                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      12                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      13                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      14                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      15                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      16                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      17                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      18                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      19                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      20                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      21                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      22                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      23                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      24                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      25                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      26                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      27                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      28                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      29                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      30                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      31                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      32                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      33                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      34                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      35                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      36                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      37                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      38                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      39                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      40                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      41                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      42                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      43                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      44                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      45                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      46                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      47                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      48                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      49                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      50                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      51                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      52                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      53                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      54                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      55                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      56                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      57                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      58                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      59                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      60                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      61                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      62                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      63                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      64                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      65                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      66                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      67                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      68                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      69                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      70                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      71                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      72                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      73                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      74                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      75                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      76                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      77                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      78                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      79                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      80                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      81                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      82                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      83                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      84                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      85                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      86                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      87                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      88                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      89                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      90                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      91                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      92                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      93                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      94                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      95                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#      96                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      97                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      98                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#      99                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     100                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     101                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     102                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     103                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     104                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     105                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     106                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     107                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     108                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     109                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     110                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     111                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     112                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     113                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     114                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     115                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     116                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     117                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     118                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     119                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     120                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     121                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     122                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     123                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     124                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     125                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     126                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     127                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     128                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     129                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     130                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     131                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     132                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     133                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     134                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     135                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     136                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     137                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     138                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     139                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     140                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     141                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     142                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     143                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     144                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     145                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     146                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     147                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     148                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     149                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     150                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     151                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     152                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     153                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     154                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     155                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     156                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     157                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     158                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     159                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     160                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     161                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     162                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     163                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     164                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     165                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     166                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     167                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     168                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     169                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     170                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     171                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     172                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     173                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     174                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     175                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     176                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     177                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     178                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     179                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     180                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     181                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     182                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     183                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     184                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     185                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     186                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     187                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     188                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     189                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     190                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     191                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     192                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     193                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     194                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     195                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     196                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     197                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     198                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     199                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     200                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     201                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     202                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     203                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     204                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     205                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     206                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     207                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     208                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     209                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     210                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     211                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     212                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     213                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     214                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     215                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     216                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     217                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     218                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     219                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     220                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     221                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     222                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     223                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     224                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     225                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     226                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     227                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     228                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     229                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     230                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     231                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     232                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     233                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     234                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     235                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     236                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     237                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     238                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     239                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     240                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Beam section
#     241                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     242                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     243                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     244                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section
#     245                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Column section

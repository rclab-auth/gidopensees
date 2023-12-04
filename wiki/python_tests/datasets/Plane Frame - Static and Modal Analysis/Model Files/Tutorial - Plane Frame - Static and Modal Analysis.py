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

# Beam 25x65 (180)
# Column 30x30 (210)

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  3DOF  (3)
#
# --------------------------------------------------------------------------------------------------------------
import openseespy.opensees as ops
import time
import math


ops.model("basic", "-ndm", 2, "-ndf", 3)

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord

ops.node(     1,            6,            0)
ops.node(     2,            6,          0.1)
ops.node(     3,            6,          0.2)
ops.node(     4,            6,          0.3)
ops.node(     5,            6,          0.4)
ops.node(     6,            6,          0.5)
ops.node(     7,            6,          0.6)
ops.node(     8,            6,          0.7)
ops.node(     9,            6,          0.8)
ops.node(    10,            6,          0.9)
ops.node(    11,            6,            1)
ops.node(    12,            6,          1.1)
ops.node(    13,            6,          1.2)
ops.node(    14,            6,          1.3)
ops.node(    15,            6,          1.4)
ops.node(    16,            6,          1.5)
ops.node(    17,            6,          1.6)
ops.node(    18,            6,          1.7)
ops.node(    19,            6,          1.8)
ops.node(    20,            6,          1.9)
ops.node(    21,            6,            2)
ops.node(    22,            6,          2.1)
ops.node(    23,            6,          2.2)
ops.node(    24,            6,          2.3)
ops.node(    25,            6,          2.4)
ops.node(    26,            6,          2.5)
ops.node(    27,            6,          2.6)
ops.node(    28,            6,          2.7)
ops.node(    29,            6,          2.8)
ops.node(    30,            6,          2.9)
ops.node(    31,            6,            3)
ops.node(    32,            6,          3.1)
ops.node(    33,            6,          3.2)
ops.node(    34,            6,          3.3)
ops.node(    35,            6,          3.4)
ops.node(    36,            6,          3.5)
ops.node(    37,            6,          3.6)
ops.node(    38,            6,          3.7)
ops.node(    39,            6,          3.8)
ops.node(    40,            6,          3.9)
ops.node(    41,            6,            4)
ops.node(    42,            6,          4.1)
ops.node(    43,            6,          4.2)
ops.node(    44,            6,          4.3)
ops.node(    45,            6,          4.4)
ops.node(    46,            6,          4.5)
ops.node(    47,          5.9,          4.5)
ops.node(    48,          5.8,          4.5)
ops.node(    49,          5.7,          4.5)
ops.node(    50,          5.6,          4.5)
ops.node(    51,          5.5,          4.5)
ops.node(    52,          5.4,          4.5)
ops.node(    53,          5.3,          4.5)
ops.node(    54,          5.2,          4.5)
ops.node(    55,          5.1,          4.5)
ops.node(    56,            6,          4.6)
ops.node(    57,            5,          4.5)
ops.node(    58,          4.9,          4.5)
ops.node(    59,          4.8,          4.5)
ops.node(    60,          4.7,          4.5)
ops.node(    61,            6,          4.7)
ops.node(    62,          4.6,          4.5)
ops.node(    63,          4.5,          4.5)
ops.node(    64,          4.4,          4.5)
ops.node(    65,            6,          4.8)
ops.node(    66,          4.3,          4.5)
ops.node(    67,          4.2,          4.5)
ops.node(    68,          4.1,          4.5)
ops.node(    69,            6,          4.9)
ops.node(    70,            4,          4.5)
ops.node(    71,          3.9,          4.5)
ops.node(    72,            6,            5)
ops.node(    73,          3.8,          4.5)
ops.node(    74,          3.7,          4.5)
ops.node(    75,            6,          5.1)
ops.node(    76,          3.6,          4.5)
ops.node(    77,          3.5,          4.5)
ops.node(    78,          3.4,          4.5)
ops.node(    79,            6,          5.2)
ops.node(    80,          3.3,          4.5)
ops.node(    81,          3.2,          4.5)
ops.node(    82,            6,          5.3)
ops.node(    83,          3.1,          4.5)
ops.node(    84,            6,          5.4)
ops.node(    85,            3,          4.5)
ops.node(    86,          2.9,          4.5)
ops.node(    87,            6,          5.5)
ops.node(    88,          2.8,          4.5)
ops.node(    89,          2.7,          4.5)
ops.node(    90,            6,          5.6)
ops.node(    91,          2.6,          4.5)
ops.node(    92,            6,          5.7)
ops.node(    93,          2.5,          4.5)
ops.node(    94,          2.4,          4.5)
ops.node(    95,            6,          5.8)
ops.node(    96,          2.3,          4.5)
ops.node(    97,          2.2,          4.5)
ops.node(    98,            6,          5.9)
ops.node(    99,          2.1,          4.5)
ops.node(   100,            6,            6)
ops.node(   101,            0,            0)
ops.node(   102,            0,          0.1)
ops.node(   103,            0,          0.2)
ops.node(   104,            0,          0.3)
ops.node(   105,            0,          0.4)
ops.node(   106,            0,          0.5)
ops.node(   107,            2,          4.5)
ops.node(   108,            0,          0.6)
ops.node(   109,            0,          0.7)
ops.node(   110,            0,          0.8)
ops.node(   111,            0,          0.9)
ops.node(   112,            0,            1)
ops.node(   113,          1.9,          4.5)
ops.node(   114,            6,          6.1)
ops.node(   115,            0,          1.1)
ops.node(   116,            0,          1.2)
ops.node(   117,            0,          1.3)
ops.node(   118,          1.8,          4.5)
ops.node(   119,            0,          1.4)
ops.node(   120,            0,          1.5)
ops.node(   121,            6,          6.2)
ops.node(   122,            0,          1.6)
ops.node(   123,          1.7,          4.5)
ops.node(   124,            0,          1.7)
ops.node(   125,            0,          1.8)
ops.node(   126,          1.6,          4.5)
ops.node(   127,            0,          1.9)
ops.node(   128,            6,          6.3)
ops.node(   129,            0,            2)
ops.node(   130,            0,          2.1)
ops.node(   131,          1.5,          4.5)
ops.node(   132,            0,          2.2)
ops.node(   133,            6,          6.4)
ops.node(   134,            0,          2.3)
ops.node(   135,          1.4,          4.5)
ops.node(   136,            0,          2.4)
ops.node(   137,            6,          6.5)
ops.node(   138,            0,          2.5)
ops.node(   139,          1.3,          4.5)
ops.node(   140,            0,          2.6)
ops.node(   141,            0,          2.7)
ops.node(   142,          1.2,          4.5)
ops.node(   143,            6,          6.6)
ops.node(   144,            0,          2.8)
ops.node(   145,          1.1,          4.5)
ops.node(   146,            0,          2.9)
ops.node(   147,            6,          6.7)
ops.node(   148,            0,            3)
ops.node(   149,            1,          4.5)
ops.node(   150,            0,          3.1)
ops.node(   151,            6,          6.8)
ops.node(   152,            0,          3.2)
ops.node(   153,          0.9,          4.5)
ops.node(   154,            0,          3.3)
ops.node(   155,          0.8,          4.5)
ops.node(   156,            0,          3.4)
ops.node(   157,            6,          6.9)
ops.node(   158,            0,          3.5)
ops.node(   159,          0.7,          4.5)
ops.node(   160,            0,          3.6)
ops.node(   161,            6,            7)
ops.node(   162,          0.6,          4.5)
ops.node(   163,            0,          3.7)
ops.node(   164,            6,          7.1)
ops.node(   165,            0,          3.8)
ops.node(   166,          0.5,          4.5)
ops.node(   167,            0,          3.9)
ops.node(   168,          0.4,          4.5)
ops.node(   169,            6,          7.2)
ops.node(   170,            0,            4)
ops.node(   171,          0.3,          4.5)
ops.node(   172,            0,          4.1)
ops.node(   173,            6,          7.3)
ops.node(   174,            0,          4.2)
ops.node(   175,          0.2,          4.5)
ops.node(   176,            0,          4.3)
ops.node(   177,            6,          7.4)
ops.node(   178,          0.1,          4.5)
ops.node(   179,            0,          4.4)
ops.node(   180,            0,          4.5)
ops.node(   181,            6,          7.5)
ops.node(   182,          5.9,          7.5)
ops.node(   183,          5.8,          7.5)
ops.node(   184,          5.7,          7.5)
ops.node(   185,          5.6,          7.5)
ops.node(   186,          5.5,          7.5)
ops.node(   187,          5.4,          7.5)
ops.node(   188,          5.3,          7.5)
ops.node(   189,          5.2,          7.5)
ops.node(   190,          5.1,          7.5)
ops.node(   191,            0,          4.6)
ops.node(   192,            5,          7.5)
ops.node(   193,          4.9,          7.5)
ops.node(   194,          4.8,          7.5)
ops.node(   195,            6,          7.6)
ops.node(   196,          4.7,          7.5)
ops.node(   197,            0,          4.7)
ops.node(   198,          4.6,          7.5)
ops.node(   199,          4.5,          7.5)
ops.node(   200,          4.4,          7.5)
ops.node(   201,            0,          4.8)
ops.node(   202,          4.3,          7.5)
ops.node(   203,            6,          7.7)
ops.node(   204,          4.2,          7.5)
ops.node(   205,          4.1,          7.5)
ops.node(   206,            0,          4.9)
ops.node(   207,            4,          7.5)
ops.node(   208,          3.9,          7.5)
ops.node(   209,            6,          7.8)
ops.node(   210,            0,            5)
ops.node(   211,          3.8,          7.5)
ops.node(   212,          3.7,          7.5)
ops.node(   213,            0,          5.1)
ops.node(   214,          3.6,          7.5)
ops.node(   215,            6,          7.9)
ops.node(   216,          3.5,          7.5)
ops.node(   217,          3.4,          7.5)
ops.node(   218,            0,          5.2)
ops.node(   219,          3.3,          7.5)
ops.node(   220,            6,            8)
ops.node(   221,            0,          5.3)
ops.node(   222,          3.2,          7.5)
ops.node(   223,          3.1,          7.5)
ops.node(   224,            0,          5.4)
ops.node(   225,            3,          7.5)
ops.node(   226,            6,          8.1)
ops.node(   227,          2.9,          7.5)
ops.node(   228,            0,          5.5)
ops.node(   229,          2.8,          7.5)
ops.node(   230,          2.7,          7.5)
ops.node(   231,            6,          8.2)
ops.node(   232,            0,          5.6)
ops.node(   233,          2.6,          7.5)
ops.node(   234,            0,          5.7)
ops.node(   235,          2.5,          7.5)
ops.node(   236,            6,          8.3)
ops.node(   237,          2.4,          7.5)
ops.node(   238,            0,          5.8)
ops.node(   239,          2.3,          7.5)
ops.node(   240,            6,          8.4)
ops.node(   241,          2.2,          7.5)
ops.node(   242,            0,          5.9)
ops.node(   243,          2.1,          7.5)
ops.node(   244,            0,            6)
ops.node(   245,            6,          8.5)
ops.node(   246,            2,          7.5)
ops.node(   247,          1.9,          7.5)
ops.node(   248,            0,          6.1)
ops.node(   249,          1.8,          7.5)
ops.node(   250,            6,          8.6)
ops.node(   251,            0,          6.2)
ops.node(   252,          1.7,          7.5)
ops.node(   253,          1.6,          7.5)
ops.node(   254,            6,          8.7)
ops.node(   255,            0,          6.3)
ops.node(   256,          1.5,          7.5)
ops.node(   257,            0,          6.4)
ops.node(   258,          1.4,          7.5)
ops.node(   259,            6,          8.8)
ops.node(   260,            0,          6.5)
ops.node(   261,          1.3,          7.5)
ops.node(   262,            6,          8.9)
ops.node(   263,          1.2,          7.5)
ops.node(   264,            0,          6.6)
ops.node(   265,          1.1,          7.5)
ops.node(   266,            0,          6.7)
ops.node(   267,            6,            9)
ops.node(   268,            1,          7.5)
ops.node(   269,            0,          6.8)
ops.node(   270,          0.9,          7.5)
ops.node(   271,            6,          9.1)
ops.node(   272,          0.8,          7.5)
ops.node(   273,            0,          6.9)
ops.node(   274,          0.7,          7.5)
ops.node(   275,            6,          9.2)
ops.node(   276,            0,            7)
ops.node(   277,          0.6,          7.5)
ops.node(   278,            0,          7.1)
ops.node(   279,            6,          9.3)
ops.node(   280,          0.5,          7.5)
ops.node(   281,          0.4,          7.5)
ops.node(   282,            0,          7.2)
ops.node(   283,            6,          9.4)
ops.node(   284,          0.3,          7.5)
ops.node(   285,            0,          7.3)
ops.node(   286,          0.2,          7.5)
ops.node(   287,            6,          9.5)
ops.node(   288,            0,          7.4)
ops.node(   289,          0.1,          7.5)
ops.node(   290,            6,          9.6)
ops.node(   291,            0,          7.5)
ops.node(   292,            0,          7.6)
ops.node(   293,            6,          9.7)
ops.node(   294,            0,          7.7)
ops.node(   295,            6,          9.8)
ops.node(   296,            0,          7.8)
ops.node(   297,            6,          9.9)
ops.node(   298,            0,          7.9)
ops.node(   299,            0,            8)
ops.node(   300,            6,           10)
ops.node(   301,            0,          8.1)
ops.node(   302,            6,         10.1)
ops.node(   303,            0,          8.2)
ops.node(   304,            6,         10.2)
ops.node(   305,            0,          8.3)
ops.node(   306,            6,         10.3)
ops.node(   307,            0,          8.4)
ops.node(   308,            6,         10.4)
ops.node(   309,            0,          8.5)
ops.node(   310,            0,          8.6)
ops.node(   311,            6,         10.5)
ops.node(   312,          5.9,         10.5)
ops.node(   313,          5.8,         10.5)
ops.node(   314,          5.7,         10.5)
ops.node(   315,          5.6,         10.5)
ops.node(   316,          5.5,         10.5)
ops.node(   317,          5.4,         10.5)
ops.node(   318,          5.3,         10.5)
ops.node(   319,          5.2,         10.5)
ops.node(   320,          5.1,         10.5)
ops.node(   321,            5,         10.5)
ops.node(   322,          4.9,         10.5)
ops.node(   323,            0,          8.7)
ops.node(   324,          4.8,         10.5)
ops.node(   325,          4.7,         10.5)
ops.node(   326,          4.6,         10.5)
ops.node(   327,          4.5,         10.5)
ops.node(   328,          4.4,         10.5)
ops.node(   329,          4.3,         10.5)
ops.node(   330,            0,          8.8)
ops.node(   331,          4.2,         10.5)
ops.node(   332,          4.1,         10.5)
ops.node(   333,            4,         10.5)
ops.node(   334,          3.9,         10.5)
ops.node(   335,          3.8,         10.5)
ops.node(   336,            0,          8.9)
ops.node(   337,          3.7,         10.5)
ops.node(   338,          3.6,         10.5)
ops.node(   339,          3.5,         10.5)
ops.node(   340,            0,            9)
ops.node(   341,          3.4,         10.5)
ops.node(   342,          3.3,         10.5)
ops.node(   343,          3.2,         10.5)
ops.node(   344,          3.1,         10.5)
ops.node(   345,            0,          9.1)
ops.node(   346,            3,         10.5)
ops.node(   347,          2.9,         10.5)
ops.node(   348,          2.8,         10.5)
ops.node(   349,            0,          9.2)
ops.node(   350,          2.7,         10.5)
ops.node(   351,          2.6,         10.5)
ops.node(   352,            0,          9.3)
ops.node(   353,          2.5,         10.5)
ops.node(   354,          2.4,         10.5)
ops.node(   355,          2.3,         10.5)
ops.node(   356,            0,          9.4)
ops.node(   357,          2.2,         10.5)
ops.node(   358,          2.1,         10.5)
ops.node(   359,            0,          9.5)
ops.node(   360,            2,         10.5)
ops.node(   361,          1.9,         10.5)
ops.node(   362,          1.8,         10.5)
ops.node(   363,            0,          9.6)
ops.node(   364,          1.7,         10.5)
ops.node(   365,          1.6,         10.5)
ops.node(   366,            0,          9.7)
ops.node(   367,          1.5,         10.5)
ops.node(   368,          1.4,         10.5)
ops.node(   369,            0,          9.8)
ops.node(   370,          1.3,         10.5)
ops.node(   371,          1.2,         10.5)
ops.node(   372,            0,          9.9)
ops.node(   373,          1.1,         10.5)
ops.node(   374,            1,         10.5)
ops.node(   375,            0,           10)
ops.node(   376,          0.9,         10.5)
ops.node(   377,          0.8,         10.5)
ops.node(   378,            0,         10.1)
ops.node(   379,          0.7,         10.5)
ops.node(   380,          0.6,         10.5)
ops.node(   381,            0,         10.2)
ops.node(   382,          0.5,         10.5)
ops.node(   383,          0.4,         10.5)
ops.node(   384,            0,         10.3)
ops.node(   385,          0.3,         10.5)
ops.node(   386,          0.2,         10.5)
ops.node(   387,            0,         10.4)
ops.node(   388,          0.1,         10.5)
ops.node(   389,            0,         10.5)

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl z-rot

ops.fix(     1,   1,   1,   1)
ops.fix(   101,   1,   1,   1)

# --------------------------------------------------------------------------------------------------------------
# M A S S E S
# --------------------------------------------------------------------------------------------------------------

# Mass Definition : mass $NodeTag $(ndf nodal mass values corresponding to each DOF)

ops.mass(    46,        5,        0,        0)
ops.mass(   180,        5,        0,        0)
ops.mass(   181,        5,        0,        0)
ops.mass(   291,        5,        0,        0)
ops.mass(   311,        5,        0,        0)
ops.mass(   389,        5,        0,        0)

# --------------------------------------------------------------------------------------------------------------
# E L A S T I C   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# Geometric Transformation

ops.geomTransf('Linear', 1)
ops.geomTransf('PDelta', 2)
ops.geomTransf('Corotational', 3)

# Elastic Beam Column Definition

# element elasticBeamColumn $eleTag $iNode $jNode $A $E $Iz $transfTag <-mass $MassPerUnitLength>

ops.element('elasticBeamColumn',      1,    101, 102,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      2,    102, 103,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      3,    103, 104,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      4,    104, 105,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      5,    105, 106,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      6,    106, 108,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      7,    108, 109,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      8,    109, 110,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',      9,    110, 111,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     10,    111, 112,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     11,    112, 115,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     12,    115, 116,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     13,    116, 117,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     14,    117, 119,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     15,    119, 120,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     16,    120, 122,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     17,    122, 124,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     18,    124, 125,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     19,    125, 127,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     20,    127, 129,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     21,    129, 130,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     22,    130, 132,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     23,    132, 134,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     24,    134, 136,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     25,    136, 138,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     26,    138, 140,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     27,    140, 141,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     28,    141, 144,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     29,    144, 146,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     30,    146, 148,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     31,    148, 150,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     32,    150, 152,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     33,    152, 154,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     34,    154, 156,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     35,    156, 158,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     36,    158, 160,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     37,    160, 163,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     38,    163, 165,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     39,    165, 167,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     40,    167, 170,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     41,    170, 172,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     42,    172, 174,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     43,    174, 176,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     44,    176, 179,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     45,    179, 180,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     46,    180, 191,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     47,    191, 197,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     48,    197, 201,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     49,    201, 206,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     50,    206, 210,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     51,    210, 213,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     52,    213, 218,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     53,    218, 221,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     54,    221, 224,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     55,    224, 228,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     56,    228, 232,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     57,    232, 234,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     58,    234, 238,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     59,    238, 242,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     60,    242, 244,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     61,    244, 248,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     62,    248, 251,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     63,    251, 255,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     64,    255, 257,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     65,    257, 260,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     66,    260, 264,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     67,    264, 266,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     68,    266, 269,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     69,    269, 273,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     70,    273, 276,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     71,    276, 278,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     72,    278, 282,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     73,    282, 285,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     74,    285, 288,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     75,    288, 291,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     76,    291, 292,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     77,    292, 294,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     78,    294, 296,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     79,    296, 298,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     80,    298, 299,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     81,    299, 301,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     82,    301, 303,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     83,    303, 305,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     84,    305, 307,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     85,    307, 309,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     86,    309, 310,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     87,    310, 323,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     88,    323, 330,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     89,    330, 336,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     90,    336, 340,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     91,    340, 345,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     92,    345, 349,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     93,    349, 352,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     94,    352, 356,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     95,    356, 359,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     96,    359, 363,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     97,    363, 366,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     98,    366, 369,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',     99,    369, 372,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    100,    372, 375,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    101,    375, 378,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    102,    378, 381,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    103,    381, 384,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    104,    384, 387,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    105,    387, 389,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    106,    389, 388,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    107,    388, 386,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    108,    386, 385,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    109,    385, 383,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    110,    383, 382,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    111,    382, 380,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    112,    380, 379,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    113,    379, 377,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    114,    377, 376,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    115,    376, 374,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    116,    374, 373,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    117,    373, 371,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    118,    371, 370,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    119,    370, 368,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    120,    368, 367,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    121,    367, 365,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    122,    365, 364,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    123,    364, 362,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    124,    362, 361,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    125,    361, 360,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    126,    360, 358,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    127,    358, 357,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    128,    357, 355,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    129,    355, 354,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    130,    354, 353,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    131,    353, 351,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    132,    351, 350,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    133,    350, 348,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    134,    348, 347,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    135,    347, 346,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    136,    346, 344,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    137,    344, 343,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    138,    343, 342,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    139,    342, 341,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    140,    341, 339,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    141,    339, 338,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    142,    338, 337,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    143,    337, 335,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    144,    335, 334,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    145,    334, 333,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    146,    333, 332,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    147,    332, 331,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    148,    331, 329,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    149,    329, 328,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    150,    328, 327,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    151,    327, 326,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    152,    326, 325,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    153,    325, 324,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    154,    324, 322,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    155,    322, 321,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    156,    321, 320,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    157,    320, 319,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    158,    319, 318,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    159,    318, 317,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    160,    317, 316,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    161,    316, 315,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    162,    315, 314,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    163,    314, 313,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    164,    313, 312,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    165,    312, 311,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    166,    311, 308,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    167,    308, 306,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    168,    306, 304,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    169,    304, 302,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    170,    302, 300,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    171,    300, 297,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    172,    297, 295,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    173,    295, 293,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    174,    293, 290,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    175,    290, 287,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    176,    287, 283,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    177,    283, 279,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    178,    279, 275,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    179,    275, 271,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    180,    271, 267,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    181,    267, 262,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    182,    262, 259,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    183,    259, 254,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    184,    254, 250,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    185,    250, 245,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    186,    245, 240,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    187,    240, 236,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    188,    236, 231,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    189,    231, 226,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    190,    226, 220,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    191,    220, 215,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    192,    215, 209,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    193,    209, 203,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    194,    203, 195,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    195,    195, 181,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    196,    181, 177,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    197,    177, 173,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    198,    173, 169,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    199,    169, 164,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    200,    164, 161,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    201,    161, 157,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    202,    157, 151,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    203,    151, 147,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    204,    147, 143,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    205,    143, 137,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    206,    137, 133,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    207,    133, 128,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    208,    128, 121,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    209,    121, 114,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    210,    114, 100,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    211,    100, 98,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    212,     98, 95,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    213,     95, 92,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    214,     92, 90,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    215,     90, 87,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    216,     87, 84,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    217,     84, 82,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    218,     82, 79,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    219,     79, 75,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    220,     75, 72,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    221,     72, 69,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    222,     69, 65,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    223,     65, 61,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    224,     61, 56,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    225,     56, 46,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    226,     46, 45,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    227,     45, 44,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    228,     44, 43,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    229,     43, 42,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    230,     42, 41,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    231,     41, 40,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    232,     40, 39,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    233,     39, 38,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    234,     38, 37,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    235,     37, 36,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    236,     36, 35,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    237,     35, 34,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    238,     34, 33,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    239,     33, 32,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    240,     32, 31,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    241,     31, 30,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    242,     30, 29,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    243,     29, 28,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    244,     28, 27,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    245,     27, 26,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    246,     26, 25,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    247,     25, 24,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    248,     24, 23,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    249,     23, 22,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    250,     22, 21,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    251,     21, 20,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    252,     20, 19,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    253,     19, 18,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    254,     18, 17,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    255,     17, 16,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    256,     16, 15,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    257,     15, 14,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    258,     14, 13,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    259,     13, 12,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    260,     12, 11,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    261,     11, 10,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    262,     10, 9,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    263,      9, 8,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    264,      8, 7,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    265,      7, 6,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    266,      6, 5,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    267,      5, 4,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    268,      4, 3,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    269,      3, 2,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    270,      2, 1,       0.09,    3.3e+07,   0.000675   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    271,    180, 178,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    272,    178, 175,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    273,    175, 171,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    274,    171, 168,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    275,    168, 166,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    276,    166, 162,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    277,    162, 159,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    278,    159, 155,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    279,    155, 153,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    280,    153, 149,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    281,    149, 145,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    282,    145, 142,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    283,    142, 139,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    284,    139, 135,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    285,    135, 131,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    286,    131, 126,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    287,    126, 123,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    288,    123, 118,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    289,    118, 113,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    290,    113, 107,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    291,    107, 99,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    292,     99, 97,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    293,     97, 96,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    294,     96, 94,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    295,     94, 93,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    296,     93, 91,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    297,     91, 89,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    298,     89, 88,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    299,     88, 86,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    300,     86, 85,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    301,     85, 83,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    302,     83, 81,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    303,     81, 80,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    304,     80, 78,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    305,     78, 77,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    306,     77, 76,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    307,     76, 74,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    308,     74, 73,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    309,     73, 71,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    310,     71, 70,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    311,     70, 68,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    312,     68, 67,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    313,     67, 66,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    314,     66, 64,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    315,     64, 63,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    316,     63, 62,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    317,     62, 60,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    318,     60, 59,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    319,     59, 58,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    320,     58, 57,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    321,     57, 55,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    322,     55, 54,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    323,     54, 53,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    324,     53, 52,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    325,     52, 51,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    326,     51, 50,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    327,     50, 49,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    328,     49, 48,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    329,     48, 47,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    330,     47, 46,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    331,    291, 289,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    332,    289, 286,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    333,    286, 284,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    334,    284, 281,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    335,    281, 280,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    336,    280, 277,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    337,    277, 274,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    338,    274, 272,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    339,    272, 270,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    340,    270, 268,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    341,    268, 265,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    342,    265, 263,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    343,    263, 261,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    344,    261, 258,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    345,    258, 256,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    346,    256, 253,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    347,    253, 252,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    348,    252, 249,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    349,    249, 247,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    350,    247, 246,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    351,    246, 243,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    352,    243, 241,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    353,    241, 239,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    354,    239, 237,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    355,    237, 235,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    356,    235, 233,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    357,    233, 230,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    358,    230, 229,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    359,    229, 227,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    360,    227, 225,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    361,    225, 223,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    362,    223, 222,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    363,    222, 219,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    364,    219, 217,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    365,    217, 216,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    366,    216, 214,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    367,    214, 212,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    368,    212, 211,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    369,    211, 208,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    370,    208, 207,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    371,    207, 205,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    372,    205, 204,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    373,    204, 202,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    374,    202, 200,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    375,    200, 199,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    376,    199, 198,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    377,    198, 196,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    378,    196, 194,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    379,    194, 193,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    380,    193, 192,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    381,    192, 190,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    382,    190, 189,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    383,    189, 188,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    384,    188, 187,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    385,    187, 186,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    386,    186, 185,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    387,    185, 184,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    388,    184, 183,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    389,    183, 182,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37
ops.element('elasticBeamColumn',    390,    182, 181,     0.1625,    3.3e+07, 0.00572135   , 1, '-mass',        0) # Concrete C30/37

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# E Q U A L  C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# Equal Constraint/equalDOF Definition : equalDOF $MasterNode $SlaveNode $DOFs

ops.equalDOF(   180,     46, 1)     ; # ID : 1
ops.equalDOF(   291,    181, 1)     ; # ID : 2
ops.equalDOF(   389,    311, 1)     ; # ID : 3

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

ops.recorder('Node', '-file', 'Node_displacements.out', '-time', '-nodeRange', 1, 389, '-dof', 1, 2, 'disp')
ops.recorder('Node', '-file', 'Node_rotations.out', '-time', '-nodeRange', 1, 389, '-dof', 3, 'disp')
ops.recorder('Node', '-file', 'Node_forceReactions.out', '-time', '-nodeRange', 1, 389, '-dof', 1, 2, 'reaction')
ops.recorder('Node', '-file', 'Node_momentReactions.out', '-time', '-nodeRange', 1, 389, '-dof', 3, 'reaction')
ops.recorder('Element', '-file', 'ElasticBeamColumn_localForce.out', '-time', '-ele', 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 106 , 107 , 108 , 109 , 110 , 111 , 112 , 113 , 114 , 115 , 116 , 117 , 118 , 119 , 120 , 121 , 122 , 123 , 124 , 125 , 126 , 127 , 128 , 129 , 130 , 131 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 140 , 141 , 142 , 143 , 144 , 145 , 146 , 147 , 148 , 149 , 150 , 151 , 152 , 153 , 154 , 155 , 156 , 157 , 158 , 159 , 160 , 161 , 162 , 163 , 164 , 165 , 166 , 167 , 168 , 169 , 170 , 171 , 172 , 173 , 174 , 175 , 176 , 177 , 178 , 179 , 180 , 181 , 182 , 183 , 184 , 185 , 186 , 187 , 188 , 189 , 190 , 191 , 192 , 193 , 194 , 195 , 196 , 197 , 198 , 199 , 200 , 201 , 202 , 203 , 204 , 205 , 206 , 207 , 208 , 209 , 210 , 211 , 212 , 213 , 214 , 215 , 216 , 217 , 218 , 219 , 220 , 221 , 222 , 223 , 224 , 225 , 226 , 227 , 228 , 229 , 230 , 231 , 232 , 233 , 234 , 235 , 236 , 237 , 238 , 239 , 240 , 241 , 242 , 243 , 244 , 245 , 246 , 247 , 248 , 249 , 250 , 251 , 252 , 253 , 254 , 255 , 256 , 257 , 258 , 259 , 260 , 261 , 262 , 263 , 264 , 265 , 266 , 267 , 268 , 269 , 270 , 271 , 272 , 273 , 274 , 275 , 276 , 277 , 278 , 279 , 280 , 281 , 282 , 283 , 284 , 285 , 286 , 287 , 288 , 289 , 290 , 291 , 292 , 293 , 294 , 295 , 296 , 297 , 298 , 299 , 300 , 301 , 302 , 303 , 304 , 305 , 306 , 307 , 308 , 309 , 310 , 311 , 312 , 313 , 314 , 315 , 316 , 317 , 318 , 319 , 320 , 321 , 322 , 323 , 324 , 325 , 326 , 327 , 328 , 329 , 330 , 331 , 332 , 333 , 334 , 335 , 336 , 337 , 338 , 339 , 340 , 341 , 342 , 343 , 344 , 345 , 346 , 347 , 348 , 349 , 350 , 351 , 352 , 353 , 354 , 355 , 356 , 357 , 358 , 359 , 360 , 361 , 362 , 363 , 364 , 365 , 366 , 367 , 368 , 369 , 370 , 371 , 372 , 373 , 374 , 375 , 376 , 377 , 378 , 379 , 380 , 381 , 382 , 383 , 384 , 385 , 386 , 387 , 388 , 389 , 390 , 'localForce')

ops.logFile("Tutorial - Plane Frame - Static and Modal Analysis.log")

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
ops.load(   311,       20,        0,        0)
ops.load(   389,       20,        0,        0)

# recording the initial status

ops.record()

# Perform eigenvalue analysis

print("Running eigenvalue analysis")

numModes = 3

# Record eigenvectors

for k in range(numModes):
    ops.recorder("Node", "-file", f"Mode_{k}.out", "-nodeRange", 1, 389, "-dof", 1, 2, f"eigen {k}")

lambda_ = ops.eigen("-fullGenLapack", numModes)

# Modal report

# modalProperties -file "ModalReport.out" -unorm

# Calculate periods

T = []
for lam in lambda_:
    T.append(6.283185/math.sqrt(lam))

# Write periods file
period = "Periods.out"
with open(period, "w") as file:
    for index, t in enumerate(T):
        file.write(f"{index}  {t}")
file.close()

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
# 389

# Elements 1D
# 390

# Elements 2D
# 0

# Elements 3D
# 0

# ElasticBeamColumn
# 390
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# F R A M E   L O C A L   A X E S   O R I E N T A T I O N
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#      ID                           Type                       Local-x                       Local-y                       Local-z          Literal      Material / Section
#
#       1              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       2              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       3              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       4              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       5              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       6              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       7              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       8              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#       9              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      10              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      11              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      12              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      13              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      14              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      15              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      16              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      17              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      18              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      19              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      20              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      21              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      22              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      23              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      24              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      25              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      26              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      27              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      28              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      29              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      30              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      31              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      32              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      33              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      34              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      35              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      36              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      37              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      38              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      39              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      40              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      41              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      42              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      43              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      44              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      45              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      46              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      47              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      48              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      49              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      50              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      51              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      52              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      53              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      54              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      55              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      56              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      57              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      58              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      59              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      60              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      61              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      62              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      63              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      64              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      65              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      66              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      67              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      68              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      69              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      70              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      71              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      72              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      73              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      74              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      75              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      76              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      77              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      78              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      79              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      80              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      81              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      82              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      83              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      84              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      85              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      86              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      87              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      88              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      89              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      90              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      91              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      92              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      93              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      94              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      95              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      96              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      97              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      98              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#      99              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     100              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     101              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     102              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     103              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     104              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     105              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C30/37
#     106              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     107              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     108              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     109              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     110              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     111              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     112              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     113              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     114              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     115              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     116              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     117              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     118              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     119              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     120              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     121              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     122              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     123              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     124              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     125              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     126              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     127              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     128              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     129              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     130              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     131              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     132              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     133              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     134              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     135              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     136              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     137              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     138              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     139              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     140              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     141              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     142              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     143              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     144              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     145              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     146              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     147              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     148              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     149              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     150              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     151              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     152              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     153              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     154              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     155              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     156              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     157              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     158              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     159              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     160              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     161              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     162              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     163              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     164              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     165              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     166              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     167              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     168              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     169              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     170              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     171              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     172              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     173              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     174              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     175              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     176              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     177              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     178              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     179              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     180              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     181              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     182              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     183              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     184              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     185              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     186              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     187              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     188              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     189              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     190              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     191              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     192              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     193              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     194              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     195              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     196              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     197              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     198              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     199              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     200              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     201              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     202              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     203              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     204              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     205              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     206              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     207              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     208              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     209              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     210              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     211              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     212              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     213              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     214              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     215              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     216              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     217              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     218              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     219              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     220              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     221              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     222              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     223              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     224              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     225              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     226              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     227              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     228              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     229              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     230              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     231              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     232              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     233              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     234              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     235              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     236              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     237              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     238              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     239              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     240              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     241              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     242              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     243              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     244              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     245              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     246              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     247              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     248              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     249              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     250              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     251              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     252              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     253              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     254              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     255              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     256              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     257              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     258              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     259              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     260              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     261              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     262              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     263              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     264              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     265              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     266              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     267              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     268              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     269              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     270              ElasticBeamColumn     {+0.0000 -1.0000 +0.0000}     {+1.0000 +0.0000 -0.0000}     {+0.0000 +0.0000 +1.0000}     { -Y +X +Z };   # Concrete C30/37
#     271              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     272              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     273              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     274              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     275              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     276              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     277              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     278              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     279              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     280              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     281              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     282              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     283              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     284              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     285              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     286              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     287              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     288              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     289              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     290              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     291              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     292              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     293              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     294              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     295              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     296              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     297              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     298              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     299              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     300              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     301              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     302              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     303              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     304              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     305              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     306              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     307              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     308              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     309              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     310              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     311              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     312              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     313              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     314              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     315              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     316              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     317              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     318              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     319              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     320              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     321              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     322              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     323              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     324              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     325              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     326              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     327              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     328              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     329              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     330              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     331              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     332              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     333              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     334              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     335              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     336              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     337              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     338              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     339              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     340              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     341              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     342              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     343              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     344              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     345              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     346              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     347              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     348              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     349              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     350              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     351              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     352              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     353              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     354              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     355              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     356              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     357              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     358              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     359              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     360              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     361              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     362              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     363              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     364              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     365              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     366              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     367              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     368              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     369              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     370              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     371              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     372              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     373              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     374              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     375              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     376              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     377              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     378              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     379              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     380              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     381              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     382              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     383              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     384              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     385              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     386              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     387              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     388              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     389              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37
#     390              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C30/37

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

# Masonry arch element (524)

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  3DOF  (3)
#
# --------------------------------------------------------------------------------------------------------------
import openseespy.opensees as ops
import time
import math


ops.model("basic", "-ndm", 3, "-ndf", 3)

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord $Zcoord

ops.node(     1,           28,            4,            0)
ops.node(     2,           28,            3,            0)
ops.node(     3,           27,            4,            0)
ops.node(     4,           28,            4,        1.125)
ops.node(     5,           27,            3,            0)
ops.node(     6,           28,            3,        1.125)
ops.node(     7,           27,            4,        1.125)
ops.node(     8,           27,            3,        1.125)
ops.node(     9,           26,            4,            0)
ops.node(    10,           28,            2,            0)
ops.node(    11,           26,            3,            0)
ops.node(    12,           27,            2,            0)
ops.node(    13,           28,            4,         2.25)
ops.node(    14,           26,            4,        1.125)
ops.node(    15,           28,            2,        1.125)
ops.node(    16,           28,            3,         2.25)
ops.node(    17,           27,            4,         2.25)
ops.node(    18,           27,            2,        1.125)
ops.node(    19,           26,            3,        1.125)
ops.node(    20,           27,            3,         2.25)
ops.node(    21,           26,            2,            0)
ops.node(    22,           28,            1,            0)
ops.node(    23,           26,            4,         2.25)
ops.node(    24,           28,            2,         2.25)
ops.node(    25,           26,            2,        1.125)
ops.node(    26,           27,            1,            0)
ops.node(    27,           27,            2,         2.25)
ops.node(    28,           26,            3,         2.25)
ops.node(    29,           28,            1,        1.125)
ops.node(    30,           27,            1,        1.125)
ops.node(    31,           28,            4,        3.375)
ops.node(    32,           27,            4,        3.375)
ops.node(    33,           28,            3,        3.375)
ops.node(    34,           26,            1,            0)
ops.node(    35,           26,            2,         2.25)
ops.node(    36,           27,            3,        3.375)
ops.node(    37,           28,            1,         2.25)
ops.node(    38,           26,            1,        1.125)
ops.node(    39,           27,            1,         2.25)
ops.node(    40,           26,            4,        3.375)
ops.node(    41,           28,            2,        3.375)
ops.node(    42,           28,            0,            0)
ops.node(    43,           26,            3,        3.375)
ops.node(    44,           27,            2,        3.375)
ops.node(    45,           27,            0,            0)
ops.node(    46,           28,            0,        1.125)
ops.node(    47,           26,            1,         2.25)
ops.node(    48,           27,            0,        1.125)
ops.node(    49,           26,            2,        3.375)
ops.node(    50,           26,            0,            0)
ops.node(    51,           28,            4,          4.5)
ops.node(    52,           28,            1,        3.375)
ops.node(    53,           28,            0,         2.25)
ops.node(    54,           28,            3,          4.5)
ops.node(    55,           27,            4,          4.5)
ops.node(    56,           26,            0,        1.125)
ops.node(    57,           27,            1,        3.375)
ops.node(    58,           27,            0,         2.25)
ops.node(    59,           27,            3,          4.5)
ops.node(    60,           28,            2,          4.5)
ops.node(    61,           26,            4,          4.5)
ops.node(    62,           26,            1,        3.375)
ops.node(    63,           26,            0,         2.25)
ops.node(    64,           27,            2,          4.5)
ops.node(    65,           26,            3,          4.5)
ops.node(    66,           28,            0,        3.375)
ops.node(    67,           26,            2,          4.5)
ops.node(    68,           27,            0,        3.375)
ops.node(    69,           28,            1,          4.5)
ops.node(    70,           27,            1,          4.5)
ops.node(    71,           26,            0,        3.375)
ops.node(    72,           28,            4,        5.625)
ops.node(    73,           27,            4,        5.625)
ops.node(    74,           28,            3,        5.625)
ops.node(    75,           26,            1,          4.5)
ops.node(    76,           27,            3,        5.625)
ops.node(    77,           26,            4,        5.625)
ops.node(    78,           28,            2,        5.625)
ops.node(    79,           28,            0,          4.5)
ops.node(    80,           26,            3,        5.625)
ops.node(    81,           27,            2,        5.625)
ops.node(    82,           27,            0,          4.5)
ops.node(    83,           26,            2,        5.625)
ops.node(    84,           26,            0,          4.5)
ops.node(    85,           28,            1,        5.625)
ops.node(    86,           27,            1,        5.625)
ops.node(    87,           26,            1,        5.625)
ops.node(    88,           28,            4,         6.75)
ops.node(    89,           27,            4,         6.75)
ops.node(    90,           28,            3,         6.75)
ops.node(    91,           27,            3,         6.75)
ops.node(    92,           28,            0,        5.625)
ops.node(    93,           27,            0,        5.625)
ops.node(    94,           28,            2,         6.75)
ops.node(    95,           26,            4,         6.75)
ops.node(    96,           26,            3,         6.75)
ops.node(    97,           27,            2,         6.75)
ops.node(    98,           26,            0,        5.625)
ops.node(    99,           26,            2,         6.75)
ops.node(   100,           28,            1,         6.75)
ops.node(   101,           27,            1,         6.75)
ops.node(   102,           26,            1,         6.75)
ops.node(   103,           28,            0,         6.75)
ops.node(   104,           28,            4,        7.875)
ops.node(   105,           27,            0,         6.75)
ops.node(   106,           28,            3,        7.875)
ops.node(   107,           27,            4,        7.875)
ops.node(   108,           20,            4,            0)
ops.node(   109,           27,            3,        7.875)
ops.node(   110,           20,            3,            0)
ops.node(   111,           20,            4,        1.125)
ops.node(   112,           26,            0,         6.75)
ops.node(   113,           26,            4,        7.875)
ops.node(   114,           28,            2,        7.875)
ops.node(   115,           20,            3,        1.125)
ops.node(   116,           27,            2,        7.875)
ops.node(   117,           26,            3,        7.875)
ops.node(   118,           20,            2,            0)
ops.node(   119,           20,            4,         2.25)
ops.node(   120,           20,            2,        1.125)
ops.node(   121,           26,            2,        7.875)
ops.node(   122,           20,            3,         2.25)
ops.node(   123,           28,            1,        7.875)
ops.node(   124,           27,            1,        7.875)
ops.node(   125,           20,            1,            0)
ops.node(   126,           20,            2,         2.25)
ops.node(   127,           20,            1,        1.125)
ops.node(   128,           26,            1,        7.875)
ops.node(   129,           20,            4,        3.375)
ops.node(   130,           20,            3,        3.375)
ops.node(   131,           28,            0,        7.875)
ops.node(   132,           20,            1,         2.25)
ops.node(   133,           27,            0,        7.875)
ops.node(   134,           20,            2,        3.375)
ops.node(   135,           20,            0,            0)
ops.node(   136,           28,            4,            9)
ops.node(   137,           19,            4,            0)
ops.node(   138,           20,            0,        1.125)
ops.node(   139,           19,            3,            0)
ops.node(   140,           28,            3,            9)
ops.node(   141,           27,            4,            9)
ops.node(   142,           26,            0,        7.875)
ops.node(   143,           19,            4,        1.125)
ops.node(   144,           27,            3,            9)
ops.node(   145,           19,            3,        1.125)
ops.node(   146,           20,            4,          4.5)
ops.node(   147,           20,            1,        3.375)
ops.node(   148,           28,            2,            9)
ops.node(   149,           19,            2,            0)
ops.node(   150,           26,            4,            9)
ops.node(   151,           20,            0,         2.25)
ops.node(   152,           20,            3,          4.5)
ops.node(   153,           27,            2,            9)
ops.node(   154,           26,            3,            9)
ops.node(   155,           19,            4,         2.25)
ops.node(   156,           19,            2,        1.125)
ops.node(   157,           19,            3,         2.25)
ops.node(   158,           20,            2,          4.5)
ops.node(   159,           26,            2,            9)
ops.node(   160,           19,            1,            0)
ops.node(   161,           28,            1,            9)
ops.node(   162,           19,            2,         2.25)
ops.node(   163,           27,            1,            9)
ops.node(   164,           19,            1,        1.125)
ops.node(   165,           20,            0,        3.375)
ops.node(   166,           19,            4,        3.375)
ops.node(   167,           20,            1,          4.5)
ops.node(   168,           19,            3,        3.375)
ops.node(   169,           26,            1,            9)
ops.node(   170,           19,            1,         2.25)
ops.node(   171,           20,            4,        5.625)
ops.node(   172,           19,            2,        3.375)
ops.node(   173,           20,            3,        5.625)
ops.node(   174,           28,            0,            9)
ops.node(   175,           19,            0,            0)
ops.node(   176,           27,            0,            9)
ops.node(   177,           19,            0,        1.125)
ops.node(   178,           20,            2,        5.625)
ops.node(   179,      25.0798,            4,      9.54691)
ops.node(   180,           18,            4,            0)
ops.node(   181,           28,            4,           10)
ops.node(   182,           20,            0,          4.5)
ops.node(   183,      25.0798,            3,      9.54691)
ops.node(   184,           26,            0,            9)
ops.node(   185,           27,            4,           10)
ops.node(   186,           18,            3,            0)
ops.node(   187,           28,            3,           10)
ops.node(   188,           19,            4,          4.5)
ops.node(   189,           18,            4,        1.125)
ops.node(   190,           19,            1,        3.375)
ops.node(   191,           27,            3,           10)
ops.node(   192,           19,            0,         2.25)
ops.node(   193,           19,            3,          4.5)
ops.node(   194,           18,            3,        1.125)
ops.node(   195,      25.0798,            2,      9.54691)
ops.node(   196,           28,            2,           10)
ops.node(   197,           18,            2,            0)
ops.node(   198,           26,            4,           10)
ops.node(   199,           20,            1,        5.625)
ops.node(   200,           27,            2,           10)
ops.node(   201,           26,            3,           10)
ops.node(   202,           18,            4,         2.25)
ops.node(   203,           19,            2,          4.5)
ops.node(   204,           18,            2,        1.125)
ops.node(   205,           18,            3,         2.25)
ops.node(   206,           26,            2,           10)
ops.node(   207,           19,            0,        3.375)
ops.node(   208,      25.0798,            1,      9.54691)
ops.node(   209,           18,            1,            0)
ops.node(   210,           28,            1,           10)
ops.node(   211,           18,            2,         2.25)
ops.node(   212,           20,            4,         6.75)
ops.node(   213,           27,            1,           10)
ops.node(   214,           19,            1,          4.5)
ops.node(   215,           18,            1,        1.125)
ops.node(   216,           20,            3,         6.75)
ops.node(   217,           18,            4,        3.375)
ops.node(   218,           20,            0,        5.625)
ops.node(   219,           18,            3,        3.375)
ops.node(   220,           19,            4,        5.625)
ops.node(   221,           26,            1,           10)
ops.node(   222,      24.0643,            4,      9.88541)
ops.node(   223,           20,            2,         6.75)
ops.node(   224,           19,            3,        5.625)
ops.node(   225,           18,            1,         2.25)
ops.node(   226,      24.0643,            3,      9.88541)
ops.node(   227,           18,            2,        3.375)
ops.node(   228,      25.0798,  -7.1944e-17,      9.54691)
ops.node(   229,           18,            0,            0)
ops.node(   230,           28,            0,           10)
ops.node(   231,           19,            2,        5.625)
ops.node(   232,           27,            0,           10)
ops.node(   233,      24.0643,            2,      9.88541)
ops.node(   234,           19,            0,          4.5)
ops.node(   235,           18,            0,        1.125)
ops.node(   236,           20,            1,         6.75)
ops.node(   237,      25.0798,            4,      10.5469)
ops.node(   238,           26,            0,           10)
ops.node(   239,           18,            4,          4.5)
ops.node(   240,           18,            1,        3.375)
ops.node(   241,      25.0798,            3,      10.5469)
ops.node(   242,           17,            4,            0)
ops.node(   243,           18,            0,         2.25)
ops.node(   244,           18,            3,          4.5)
ops.node(   245,           19,            1,        5.625)
ops.node(   246,           17,            3,            0)
ops.node(   247,      24.0643,            1,      9.88541)
ops.node(   248,           17,            4,        1.125)
ops.node(   249,           17,            3,        1.125)
ops.node(   250,      25.0798,            2,      10.5469)
ops.node(   251,           18,            2,          4.5)
ops.node(   252,           23,            4,           10)
ops.node(   253,           17,            2,            0)
ops.node(   254,           20,            0,         6.75)
ops.node(   255,           23,            3,           10)
ops.node(   256,           20,            4,        7.875)
ops.node(   257,           17,            4,         2.25)
ops.node(   258,           17,            2,        1.125)
ops.node(   259,           19,            4,         6.75)
ops.node(   260,           20,            3,        7.875)
ops.node(   261,           17,            3,         2.25)
ops.node(   262,           18,            0,        3.375)
ops.node(   263,           19,            3,         6.75)
ops.node(   264,           19,            0,        5.625)
ops.node(   265,      25.0798,            1,      10.5469)
ops.node(   266,           23,            2,           10)
ops.node(   267,      24.0643, -1.47107e-16,      9.88541)
ops.node(   268,           18,            1,          4.5)
ops.node(   269,           17,            1,            0)
ops.node(   270,           20,            2,        7.875)
ops.node(   271,           17,            2,         2.25)
ops.node(   272,           19,            2,         6.75)
ops.node(   273,           17,            1,        1.125)
ops.node(   274,           18,            4,        5.625)
ops.node(   275,           17,            4,        3.375)
ops.node(   276,           18,            3,        5.625)
ops.node(   277,           17,            3,        3.375)
ops.node(   278,      24.0643,            4,      10.8854)
ops.node(   279,           23,            1,           10)
ops.node(   280,      21.9357,            4,      9.88541)
ops.node(   281,      24.0643,            3,      10.8854)
ops.node(   282,           20,            1,        7.875)
ops.node(   283,           17,            1,         2.25)
ops.node(   284,      21.9357,            3,      9.88541)
ops.node(   285,           19,            1,         6.75)
ops.node(   286,           18,            2,        5.625)
ops.node(   287,      25.0798,  -7.1944e-17,      10.5469)
ops.node(   288,           18,            0,          4.5)
ops.node(   289,           17,            2,        3.375)
ops.node(   290,           17,            0,            0)
ops.node(   291,      24.0643,            2,      10.8854)
ops.node(   292,           17,            0,        1.125)
ops.node(   293,      21.9357,            2,      9.88541)
ops.node(   294,           18,            1,        5.625)
ops.node(   295,           23,  -1.7255e-16,           10)
ops.node(   296,           17,            4,          4.5)
ops.node(   297,      20.9202,            4,      9.54691)
ops.node(   298,           17,            1,        3.375)
ops.node(   299,           20,            0,        7.875)
ops.node(   300,           17,            0,         2.25)
ops.node(   301,           17,            3,          4.5)
ops.node(   302,      20.9202,            3,      9.54691)
ops.node(   303,           19,            0,         6.75)
ops.node(   304,      24.0643,            1,      10.8854)
ops.node(   305,           19,            4,        7.875)
ops.node(   306,      21.9357,            1,      9.88541)
ops.node(   307,           16,            4,            0)
ops.node(   308,           19,            3,        7.875)
ops.node(   309,           16,            3,            0)
ops.node(   310,           20,            4,            9)
ops.node(   311,           17,            2,          4.5)
ops.node(   312,           16,            4,        1.125)
ops.node(   313,      20.9202,            2,      9.54691)
ops.node(   314,           18,            4,         6.75)
ops.node(   315,           23,            4,           11)
ops.node(   316,           20,            3,            9)
ops.node(   317,           16,            3,        1.125)
ops.node(   318,           18,            3,         6.75)
ops.node(   319,           23,            3,           11)
ops.node(   320,           19,            2,        7.875)
ops.node(   321,           18,            0,        5.625)
ops.node(   322,           16,            2,            0)
ops.node(   323,           17,            0,        3.375)
ops.node(   324,           20,            2,            9)
ops.node(   325,           16,            4,         2.25)
ops.node(   326,           16,            2,        1.125)
ops.node(   327,           18,            2,         6.75)
ops.node(   328,      24.0643, -1.47107e-16,      10.8854)
ops.node(   329,           23,            2,           11)
ops.node(   330,           16,            3,         2.25)
ops.node(   331,           17,            1,          4.5)
ops.node(   332,      20.9202,            1,      9.54691)
ops.node(   333,      21.9357, -1.47107e-16,      9.88541)
ops.node(   334,           19,            1,        7.875)
ops.node(   335,           17,            4,        5.625)
ops.node(   336,           16,            1,            0)
ops.node(   337,           16,            2,         2.25)
ops.node(   338,           17,            3,        5.625)
ops.node(   339,           20,            1,            9)
ops.node(   340,           16,            1,        1.125)
ops.node(   341,           18,            1,         6.75)
ops.node(   342,           23,            1,           11)
ops.node(   343,      21.9357,            4,      10.8854)
ops.node(   344,           16,            4,        3.375)
ops.node(   345,      21.9357,            3,      10.8854)
ops.node(   346,           16,            3,        3.375)
ops.node(   347,           17,            2,        5.625)
ops.node(   348,           17,            0,          4.5)
ops.node(   349,      20.9202,  -7.1944e-17,      9.54691)
ops.node(   350,           16,            1,         2.25)
ops.node(   351,           19,            0,        7.875)
ops.node(   352,      21.9357,            2,      10.8854)
ops.node(   353,           16,            2,        3.375)
ops.node(   354,           16,            0,            0)
ops.node(   355,           20,            0,            9)
ops.node(   356,           16,            0,        1.125)
ops.node(   357,      20.9202,            4,      10.5469)
ops.node(   358,           18,            0,         6.75)
ops.node(   359,           17,            1,        5.625)
ops.node(   360,           23,  -1.7255e-16,           11)
ops.node(   361,           19,            4,            9)
ops.node(   362,           18,            4,        7.875)
ops.node(   363,      20.9202,            3,      10.5469)
ops.node(   364,           19,            3,            9)
ops.node(   365,           18,            3,        7.875)
ops.node(   366,           20,            4,           10)
ops.node(   367,           16,            4,          4.5)
ops.node(   368,      21.9357,            1,      10.8854)
ops.node(   369,           16,            1,        3.375)
ops.node(   370,           20,            3,           10)
ops.node(   371,           16,            0,         2.25)
ops.node(   372,           16,            3,          4.5)
ops.node(   373,      20.9202,            2,      10.5469)
ops.node(   374,           19,            2,            9)
ops.node(   375,           18,            2,        7.875)
ops.node(   376,           17,            4,         6.75)
ops.node(   377,           17,            3,         6.75)
ops.node(   378,           20,            2,           10)
ops.node(   379,           16,            2,          4.5)
ops.node(   380,           17,            0,        5.625)
ops.node(   381,      20.9202,            1,      10.5469)
ops.node(   382,           17,            2,         6.75)
ops.node(   383,           19,            1,            9)
ops.node(   384,           18,            1,        7.875)
ops.node(   385,      21.9357, -1.47107e-16,      10.8854)
ops.node(   386,           16,            0,        3.375)
ops.node(   387,           20,            1,           10)
ops.node(   388,           16,            1,          4.5)
ops.node(   389,           17,            1,         6.75)
ops.node(   390,           16,            4,        5.625)
ops.node(   391,           16,            3,        5.625)
ops.node(   392,      20.9202,  -7.1944e-17,      10.5469)
ops.node(   393,           19,            0,            9)
ops.node(   394,           18,            0,        7.875)
ops.node(   395,           16,            2,        5.625)
ops.node(   396,           20,            0,           10)
ops.node(   397,           16,            0,          4.5)
ops.node(   398,           19,            4,           10)
ops.node(   399,           18,            4,            9)
ops.node(   400,           18,            3,            9)
ops.node(   401,           19,            3,           10)
ops.node(   402,           17,            0,         6.75)
ops.node(   403,           17,            4,        7.875)
ops.node(   404,           17,            3,        7.875)
ops.node(   405,           16,            1,        5.625)
ops.node(   406,           18,            2,            9)
ops.node(   407,           19,            2,           10)
ops.node(   408,           20,            4,           11)
ops.node(   409,           20,            3,           11)
ops.node(   410,           17,            2,        7.875)
ops.node(   411,           20,            2,           11)
ops.node(   412,           16,            4,         6.75)
ops.node(   413,           18,            1,            9)
ops.node(   414,           19,            1,           10)
ops.node(   415,           16,            3,         6.75)
ops.node(   416,           16,            0,        5.625)
ops.node(   417,           17,            1,        7.875)
ops.node(   418,           16,            2,         6.75)
ops.node(   419,           20,            1,           11)
ops.node(   420,           19,            0,           10)
ops.node(   421,           18,            0,            9)
ops.node(   422,           16,            1,         6.75)
ops.node(   423,           17,            0,        7.875)
ops.node(   424,           18,            4,           10)
ops.node(   425,           18,            3,           10)
ops.node(   426,           20,            0,           11)
ops.node(   427,           19,            4,           11)
ops.node(   428,           17,            4,            9)
ops.node(   429,           17,            3,            9)
ops.node(   430,           19,            3,           11)
ops.node(   431,           18,            2,           10)
ops.node(   432,           16,            0,         6.75)
ops.node(   433,           19,            2,           11)
ops.node(   434,           17,            2,            9)
ops.node(   435,           16,            4,        7.875)
ops.node(   436,           16,            3,        7.875)
ops.node(   437,           20,            4,           12)
ops.node(   438,           18,            1,           10)
ops.node(   439,           20,            3,           12)
ops.node(   440,           16,            2,        7.875)
ops.node(   441,           19,            1,           11)
ops.node(   442,           17,            1,            9)
ops.node(   443,           20,            2,           12)
ops.node(   444,           16,            1,        7.875)
ops.node(   445,           18,            0,           10)
ops.node(   446,           20,            1,           12)
ops.node(   447,           17,            0,            9)
ops.node(   448,           19,            0,           11)
ops.node(   449,           18,            4,           11)
ops.node(   450,           17,            4,           10)
ops.node(   451,           17,            3,           10)
ops.node(   452,           18,            3,           11)
ops.node(   453,           16,            0,        7.875)
ops.node(   454,           20,            0,           12)
ops.node(   455,           19,            4,           12)
ops.node(   456,           18,            2,           11)
ops.node(   457,           17,            2,           10)
ops.node(   458,           16,            4,            9)
ops.node(   459,           19,            3,           12)
ops.node(   460,           16,            3,            9)
ops.node(   461,           16,            2,            9)
ops.node(   462,           19,            2,           12)
ops.node(   463,           17,            1,           10)
ops.node(   464,           18,            1,           11)
ops.node(   465,           20,            4,           13)
ops.node(   466,           16,            1,            9)
ops.node(   467,           20,            3,           13)
ops.node(   468,           19,            1,           12)
ops.node(   469,           20,            2,           13)
ops.node(   470,           17,            0,           10)
ops.node(   471,           18,            0,           11)
ops.node(   472,           16,            0,            9)
ops.node(   473,           19,            0,           12)
ops.node(   474,           17,            4,           11)
ops.node(   475,           20,            1,           13)
ops.node(   476,           17,            3,           11)
ops.node(   477,           16,            4,           10)
ops.node(   478,           18,            4,           12)
ops.node(   479,           18,            3,           12)
ops.node(   480,           16,            3,           10)
ops.node(   481,           17,            2,           11)
ops.node(   482,           16,            2,           10)
ops.node(   483,           18,            2,           12)
ops.node(   484,           20,            0,           13)
ops.node(   485,           19,            4,           13)
ops.node(   486,           17,            1,           11)
ops.node(   487,           19,            3,           13)
ops.node(   488,           16,            1,           10)
ops.node(   489,           18,            1,           12)
ops.node(   490,           19,            2,           13)
ops.node(   491,           17,            0,           11)
ops.node(   492,           19,            1,           13)
ops.node(   493,           18,            0,           12)
ops.node(   494,           16,            0,           10)
ops.node(   495,           16,            4,           11)
ops.node(   496,           17,            4,           12)
ops.node(   497,           16,            3,           11)
ops.node(   498,           19,            0,           13)
ops.node(   499,           17,            3,           12)
ops.node(   500,           16,            2,           11)
ops.node(   501,           17,            2,           12)
ops.node(   502,           18,            4,           13)
ops.node(   503,           18,            3,           13)
ops.node(   504,           18,            2,           13)
ops.node(   505,           17,            1,           12)
ops.node(   506,           16,            1,           11)
ops.node(   507,           18,            1,           13)
ops.node(   508,           17,            0,           12)
ops.node(   509,           16,            0,           11)
ops.node(   510,           18,            0,           13)
ops.node(   511,           16,            4,           12)
ops.node(   512,           16,            3,           12)
ops.node(   513,           17,            4,           13)
ops.node(   514,           17,            3,           13)
ops.node(   515,           16,            2,           12)
ops.node(   516,           17,            2,           13)
ops.node(   517,           16,            1,           12)
ops.node(   518,           17,            1,           13)
ops.node(   519,           16,            0,           12)
ops.node(   520,           17,            0,           13)
ops.node(   521,           16,            4,           13)
ops.node(   522,           16,            3,           13)
ops.node(   523,           16,            2,           13)
ops.node(   524,           16,            1,           13)
ops.node(   525,      14.9389,            4,      12.3286)
ops.node(   526,      14.9389,            3,      12.3286)
ops.node(   527,      14.9389,            2,      12.3286)
ops.node(   528,           16,            0,           13)
ops.node(   529,      14.9389,            1,      12.3286)
ops.node(   530,      14.9389, -1.12568e-17,      12.3286)
ops.node(   531,      14.9389,            4,      13.3286)
ops.node(   532,      14.9389,            3,      13.3286)
ops.node(   533,      14.9389,            2,      13.3286)
ops.node(   534,      14.9389,            1,      13.3286)
ops.node(   535,      13.8599,            4,      12.5928)
ops.node(   536,      13.8599,            3,      12.5928)
ops.node(   537,      13.8599,            2,      12.5928)
ops.node(   538,      14.9389, -1.12568e-17,      13.3286)
ops.node(   539,      13.8599,            1,      12.5928)
ops.node(   540,      13.8599, -6.99391e-17,      12.5928)
ops.node(   541,      13.8599,            4,      13.5928)
ops.node(   542,      13.8599,            3,      13.5928)
ops.node(   543,      13.8599,            2,      13.5928)
ops.node(   544,      13.8599,            1,      13.5928)
ops.node(   545,      12.7671,            4,      12.7919)
ops.node(   546,      12.7671,            3,      12.7919)
ops.node(   547,      12.7671,            2,      12.7919)
ops.node(   548,      13.8599, -6.99391e-17,      13.5928)
ops.node(   549,      12.7671,            1,      12.7919)
ops.node(   550,      12.7671, -1.14137e-16,      12.7919)
ops.node(   551,      12.7671,            4,      13.7919)
ops.node(   552,      12.7671,            3,      13.7919)
ops.node(   553,      12.7671,            2,      13.7919)
ops.node(   554,      12.7671,            1,      13.7919)
ops.node(   555,      11.6642,            4,       12.925)
ops.node(   556,      11.6642,            3,       12.925)
ops.node(   557,      11.6642,            2,       12.925)
ops.node(   558,      12.7671, -1.14137e-16,      13.7919)
ops.node(   559,      11.6642,            1,       12.925)
ops.node(   560,      11.6642, -1.43691e-16,       12.925)
ops.node(   561,      11.6642,            4,       13.925)
ops.node(   562,      11.6642,            3,       13.925)
ops.node(   563,      11.6642,            2,       13.925)
ops.node(   564,      11.6642,            1,       13.925)
ops.node(   565,      10.5554,            4,      12.9917)
ops.node(   566,      10.5554,            3,      12.9917)
ops.node(   567,      11.6642, -1.43691e-16,       13.925)
ops.node(   568,      10.5554,            2,      12.9917)
ops.node(   569,      10.5554,            1,      12.9917)
ops.node(   570,      10.5554, -1.58495e-16,      12.9917)
ops.node(   571,      10.5554,            4,      13.9917)
ops.node(   572,      10.5554,            3,      13.9917)
ops.node(   573,      10.5554,            2,      13.9917)
ops.node(   574,      10.5554,            1,      13.9917)
ops.node(   575,      9.44458,            4,      12.9917)
ops.node(   576,      9.44458,            3,      12.9917)
ops.node(   577,      10.5554, -1.58495e-16,      13.9917)
ops.node(   578,      9.44458,            2,      12.9917)
ops.node(   579,      9.44458,            1,      12.9917)
ops.node(   580,      9.44458, -1.58495e-16,      12.9917)
ops.node(   581,      9.44458,            4,      13.9917)
ops.node(   582,      9.44458,            3,      13.9917)
ops.node(   583,      9.44458,            2,      13.9917)
ops.node(   584,      9.44458,            1,      13.9917)
ops.node(   585,      8.33575,            4,       12.925)
ops.node(   586,      8.33575,            3,       12.925)
ops.node(   587,      9.44458, -1.58495e-16,      13.9917)
ops.node(   588,      8.33575,            2,       12.925)
ops.node(   589,      8.33575,            1,       12.925)
ops.node(   590,      8.33575, -1.43691e-16,       12.925)
ops.node(   591,            4,            4,            0)
ops.node(   592,            4,            3,            0)
ops.node(   593,            4,            4,      1.09091)
ops.node(   594,            4,            3,      1.09091)
ops.node(   595,            4,            2,            0)
ops.node(   596,      8.33575,            4,       13.925)
ops.node(   597,            4,            4,      2.18182)
ops.node(   598,            4,            2,      1.09091)
ops.node(   599,      8.33575,            3,       13.925)
ops.node(   600,            4,            3,      2.18182)
ops.node(   601,      8.33575,            2,       13.925)
ops.node(   602,            4,            2,      2.18182)
ops.node(   603,            4,            1,            0)
ops.node(   604,            4,            1,      1.09091)
ops.node(   605,            4,            4,      3.27273)
ops.node(   606,            4,            3,      3.27273)
ops.node(   607,      8.33575,            1,       13.925)
ops.node(   608,            4,            1,      2.18182)
ops.node(   609,            4,            2,      3.27273)
ops.node(   610,            4,            0,            0)
ops.node(   611,            4,            0,      1.09091)
ops.node(   612,      7.23292,            4,      12.7919)
ops.node(   613,            4,            4,      4.36364)
ops.node(   614,            4,            1,      3.27273)
ops.node(   615,      7.23292,            3,      12.7919)
ops.node(   616,            4,            3,      4.36364)
ops.node(   617,      8.33575, -1.43691e-16,       13.925)
ops.node(   618,            4,            0,      2.18182)
ops.node(   619,      7.23292,            2,      12.7919)
ops.node(   620,            4,            2,      4.36364)
ops.node(   621,            4,            0,      3.27273)
ops.node(   622,      7.23292,            1,      12.7919)
ops.node(   623,            4,            1,      4.36364)
ops.node(   624,            4,            4,      5.45455)
ops.node(   625,            4,            3,      5.45455)
ops.node(   626,            4,            2,      5.45455)
ops.node(   627,      7.23292, -1.14137e-16,      12.7919)
ops.node(   628,            4,            0,      4.36364)
ops.node(   629,            4,            1,      5.45455)
ops.node(   630,            4,            4,      6.54545)
ops.node(   631,            4,            3,      6.54545)
ops.node(   632,      7.23292,            4,      13.7919)
ops.node(   633,            4,            0,      5.45455)
ops.node(   634,      7.23292,            3,      13.7919)
ops.node(   635,            4,            2,      6.54545)
ops.node(   636,            3,            4,            0)
ops.node(   637,      7.23292,            2,      13.7919)
ops.node(   638,            3,            3,            0)
ops.node(   639,            3,            4,      1.09091)
ops.node(   640,            3,            3,      1.09091)
ops.node(   641,            4,            1,      6.54545)
ops.node(   642,            3,            2,            0)
ops.node(   643,            3,            4,      2.18182)
ops.node(   644,            3,            2,      1.09091)
ops.node(   645,      7.23292,            1,      13.7919)
ops.node(   646,            3,            3,      2.18182)
ops.node(   647,            3,            2,      2.18182)
ops.node(   648,            3,            1,            0)
ops.node(   649,            4,            4,      7.63636)
ops.node(   650,            4,            0,      6.54545)
ops.node(   651,            3,            1,      1.09091)
ops.node(   652,            4,            3,      7.63636)
ops.node(   653,            3,            4,      3.27273)
ops.node(   654,      6.14007,            4,      12.5928)
ops.node(   655,            3,            3,      3.27273)
ops.node(   656,      6.14007,            3,      12.5928)
ops.node(   657,      7.23292, -1.14137e-16,      13.7919)
ops.node(   658,            4,            2,      7.63636)
ops.node(   659,            3,            1,      2.18182)
ops.node(   660,            3,            2,      3.27273)
ops.node(   661,      6.14007,            2,      12.5928)
ops.node(   662,            3,            0,            0)
ops.node(   663,            3,            0,      1.09091)
ops.node(   664,            4,            1,      7.63636)
ops.node(   665,            3,            4,      4.36364)
ops.node(   666,            3,            1,      3.27273)
ops.node(   667,            3,            3,      4.36364)
ops.node(   668,      6.14007,            1,      12.5928)
ops.node(   669,            3,            0,      2.18182)
ops.node(   670,            3,            2,      4.36364)
ops.node(   671,            4,            0,      7.63636)
ops.node(   672,            3,            0,      3.27273)
ops.node(   673,            4,            4,      8.72727)
ops.node(   674,      6.14007, -6.99391e-17,      12.5928)
ops.node(   675,            3,            1,      4.36364)
ops.node(   676,            4,            3,      8.72727)
ops.node(   677,            3,            4,      5.45455)
ops.node(   678,            3,            3,      5.45455)
ops.node(   679,            4,            2,      8.72727)
ops.node(   680,            3,            2,      5.45455)
ops.node(   681,            3,            0,      4.36364)
ops.node(   682,            4,            1,      8.72727)
ops.node(   683,      6.14007,            4,      13.5928)
ops.node(   684,      6.14007,            3,      13.5928)
ops.node(   685,            3,            1,      5.45455)
ops.node(   686,      6.14007,            2,      13.5928)
ops.node(   687,            3,            4,      6.54545)
ops.node(   688,            4,            0,      8.72727)
ops.node(   689,            3,            3,      6.54545)
ops.node(   690,            3,            0,      5.45455)
ops.node(   691,      6.14007,            1,      13.5928)
ops.node(   692,            3,            2,      6.54545)
ops.node(   693,            4,            4,      9.81818)
ops.node(   694,            4,            3,      9.81818)
ops.node(   695,            2,            4,            0)
ops.node(   696,            4,            2,      9.81818)
ops.node(   697,            3,            1,      6.54545)
ops.node(   698,            2,            3,            0)
ops.node(   699,            2,            4,      1.09091)
ops.node(   700,      5.06113,            4,      12.3286)
ops.node(   701,            2,            3,      1.09091)
ops.node(   702,      6.14007, -6.99391e-17,      13.5928)
ops.node(   703,      5.06113,            3,      12.3286)
ops.node(   704,            2,            2,            0)
ops.node(   705,            2,            4,      2.18182)
ops.node(   706,            2,            2,      1.09091)
ops.node(   707,            4,            1,      9.81818)
ops.node(   708,            2,            3,      2.18182)
ops.node(   709,      5.06113,            2,      12.3286)
ops.node(   710,            3,            4,      7.63636)
ops.node(   711,            3,            0,      6.54545)
ops.node(   712,            3,            3,      7.63636)
ops.node(   713,            2,            2,      2.18182)
ops.node(   714,            2,            1,            0)
ops.node(   715,            2,            1,      1.09091)
ops.node(   716,            2,            4,      3.27273)
ops.node(   717,      5.06113,            1,      12.3286)
ops.node(   718,            3,            2,      7.63636)
ops.node(   719,            2,            3,      3.27273)
ops.node(   720,            4,            0,      9.81818)
ops.node(   721,            2,            1,      2.18182)
ops.node(   722,            2,            2,      3.27273)
ops.node(   723,            2,            0,            0)
ops.node(   724,            3,            1,      7.63636)
ops.node(   725,            2,            0,      1.09091)
ops.node(   726,      5.06113, -1.12568e-17,      12.3286)
ops.node(   727,            4,            4,      10.9091)
ops.node(   728,            2,            4,      4.36364)
ops.node(   729,            2,            1,      3.27273)
ops.node(   730,            4,            3,      10.9091)
ops.node(   731,            2,            3,      4.36364)
ops.node(   732,            2,            0,      2.18182)
ops.node(   733,            4,            2,      10.9091)
ops.node(   734,            2,            2,      4.36364)
ops.node(   735,            3,            0,      7.63636)
ops.node(   736,            3,            4,      8.72727)
ops.node(   737,            3,            3,      8.72727)
ops.node(   738,            2,            0,      3.27273)
ops.node(   739,      5.06113,            4,      13.3286)
ops.node(   740,            4,            1,      10.9091)
ops.node(   741,            2,            1,      4.36364)
ops.node(   742,      5.06113,            3,      13.3286)
ops.node(   743,            3,            2,      8.72727)
ops.node(   744,            2,            4,      5.45455)
ops.node(   745,            2,            3,      5.45455)
ops.node(   746,      5.06113,            2,      13.3286)
ops.node(   747,            2,            2,      5.45455)
ops.node(   748,            3,            1,      8.72727)
ops.node(   749,            4,            0,      10.9091)
ops.node(   750,            2,            0,      4.36364)
ops.node(   751,      5.06113,            1,      13.3286)
ops.node(   752,            2,            1,      5.45455)
ops.node(   753,            3,            0,      8.72727)
ops.node(   754,            2,            4,      6.54545)
ops.node(   755,      5.06113, -1.12568e-17,      13.3286)
ops.node(   756,            2,            3,      6.54545)
ops.node(   757,            4,            4,           12)
ops.node(   758,            4,            3,           12)
ops.node(   759,            3,            4,      9.81818)
ops.node(   760,            2,            0,      5.45455)
ops.node(   761,            3,            3,      9.81818)
ops.node(   762,            2,            2,      6.54545)
ops.node(   763,            4,            2,           12)
ops.node(   764,            3,            2,      9.81818)
ops.node(   765,            2,            1,      6.54545)
ops.node(   766,            1,            4,            0)
ops.node(   767,            4,            1,           12)
ops.node(   768,            1,            3,            0)
ops.node(   769,            1,            4,      1.09091)
ops.node(   770,            3,            1,      9.81818)
ops.node(   771,            1,            3,      1.09091)
ops.node(   772,            1,            2,            0)
ops.node(   773,            1,            4,      2.18182)
ops.node(   774,            1,            2,      1.09091)
ops.node(   775,            2,            4,      7.63636)
ops.node(   776,            1,            3,      2.18182)
ops.node(   777,            2,            0,      6.54545)
ops.node(   778,            2,            3,      7.63636)
ops.node(   779,            4,            0,           12)
ops.node(   780,            3,            0,      9.81818)
ops.node(   781,            1,            2,      2.18182)
ops.node(   782,            1,            1,            0)
ops.node(   783,            2,            2,      7.63636)
ops.node(   784,            1,            1,      1.09091)
ops.node(   785,            1,            4,      3.27273)
ops.node(   786,            1,            3,      3.27273)
ops.node(   787,            1,            1,      2.18182)
ops.node(   788,            2,            1,      7.63636)
ops.node(   789,            1,            2,      3.27273)
ops.node(   790,            3,            4,      10.9091)
ops.node(   791,            1,            0,            0)
ops.node(   792,            4,            4,           13)
ops.node(   793,            3,            3,      10.9091)
ops.node(   794,            4,            3,           13)
ops.node(   795,            1,            0,      1.09091)
ops.node(   796,            3,            2,      10.9091)
ops.node(   797,            1,            4,      4.36364)
ops.node(   798,            1,            1,      3.27273)
ops.node(   799,            4,            2,           13)
ops.node(   800,            1,            3,      4.36364)
ops.node(   801,            1,            0,      2.18182)
ops.node(   802,            2,            0,      7.63636)
ops.node(   803,            1,            2,      4.36364)
ops.node(   804,            2,            4,      8.72727)
ops.node(   805,            3,            1,      10.9091)
ops.node(   806,            2,            3,      8.72727)
ops.node(   807,            4,            1,           13)
ops.node(   808,            1,            0,      3.27273)
ops.node(   809,            2,            2,      8.72727)
ops.node(   810,            1,            1,      4.36364)
ops.node(   811,            1,            4,      5.45455)
ops.node(   812,            1,            3,      5.45455)
ops.node(   813,            3,            0,      10.9091)
ops.node(   814,            4,            0,           13)
ops.node(   815,            2,            1,      8.72727)
ops.node(   816,            1,            2,      5.45455)
ops.node(   817,            1,            0,      4.36364)
ops.node(   818,            1,            1,      5.45455)
ops.node(   819,            2,            0,      8.72727)
ops.node(   820,            3,            4,           12)
ops.node(   821,            3,            3,           12)
ops.node(   822,            1,            4,      6.54545)
ops.node(   823,            2,            4,      9.81818)
ops.node(   824,            1,            3,      6.54545)
ops.node(   825,            3,            2,           12)
ops.node(   826,            2,            3,      9.81818)
ops.node(   827,            1,            0,      5.45455)
ops.node(   828,            1,            2,      6.54545)
ops.node(   829,            2,            2,      9.81818)
ops.node(   830,            3,            1,           12)
ops.node(   831,            1,            1,      6.54545)
ops.node(   832,            2,            1,      9.81818)
ops.node(   833,            0,            4,            0)
ops.node(   834,            3,            0,           12)
ops.node(   835,            0,            3,            0)
ops.node(   836,            0,            4,      1.09091)
ops.node(   837,            0,            3,      1.09091)
ops.node(   838,            1,            4,      7.63636)
ops.node(   839,            1,            0,      6.54545)
ops.node(   840,            0,            2,            0)
ops.node(   841,            1,            3,      7.63636)
ops.node(   842,            2,            0,      9.81818)
ops.node(   843,            0,            4,      2.18182)
ops.node(   844,            0,            2,      1.09091)
ops.node(   845,            0,            3,      2.18182)
ops.node(   846,            1,            2,      7.63636)
ops.node(   847,            0,            2,      2.18182)
ops.node(   848,            0,            1,            0)
ops.node(   849,            3,            4,           13)
ops.node(   850,            0,            1,      1.09091)
ops.node(   851,            0,            4,      3.27273)
ops.node(   852,            3,            3,           13)
ops.node(   853,            2,            4,      10.9091)
ops.node(   854,            0,            3,      3.27273)
ops.node(   855,            2,            3,      10.9091)
ops.node(   856,            1,            1,      7.63636)
ops.node(   857,            0,            1,      2.18182)
ops.node(   858,            3,            2,           13)
ops.node(   859,            0,            2,      3.27273)
ops.node(   860,            2,            2,      10.9091)
ops.node(   861,            0,            0,            0)
ops.node(   862,            0,            0,      1.09091)
ops.node(   863,            3,            1,           13)
ops.node(   864,            0,            4,      4.36364)
ops.node(   865,            1,            0,      7.63636)
ops.node(   866,            0,            1,      3.27273)
ops.node(   867,            2,            1,      10.9091)
ops.node(   868,            0,            3,      4.36364)
ops.node(   869,            0,            0,      2.18182)
ops.node(   870,            1,            4,      8.72727)
ops.node(   871,            1,            3,      8.72727)
ops.node(   872,            0,            2,      4.36364)
ops.node(   873,            1,            2,      8.72727)
ops.node(   874,            3,            0,           13)
ops.node(   875,            0,            0,      3.27273)
ops.node(   876,            2,            0,      10.9091)
ops.node(   877,            0,            1,      4.36364)
ops.node(   878,            0,            4,      5.45455)
ops.node(   879,            1,            1,      8.72727)
ops.node(   880,            0,            3,      5.45455)
ops.node(   881,            0,            2,      5.45455)
ops.node(   882,            0,            0,      4.36364)
ops.node(   883,            2,            4,           12)
ops.node(   884,            2,            3,           12)
ops.node(   885,            1,            0,      8.72727)
ops.node(   886,            0,            1,      5.45455)
ops.node(   887,            2,            2,           12)
ops.node(   888,            1,            4,      9.81818)
ops.node(   889,            1,            3,      9.81818)
ops.node(   890,            0,            4,      6.54545)
ops.node(   891,            0,            3,      6.54545)
ops.node(   892,            2,            1,           12)
ops.node(   893,            1,            2,      9.81818)
ops.node(   894,            0,            0,      5.45455)
ops.node(   895,            0,            2,      6.54545)
ops.node(   896,            1,            1,      9.81818)
ops.node(   897,            0,            1,      6.54545)
ops.node(   898,            2,            0,           12)
ops.node(   899,            1,            0,      9.81818)
ops.node(   900,            0,            4,      7.63636)
ops.node(   901,            0,            0,      6.54545)
ops.node(   902,            0,            3,      7.63636)
ops.node(   903,            2,            4,           13)
ops.node(   904,            2,            3,           13)
ops.node(   905,            0,            2,      7.63636)
ops.node(   906,            1,            4,      10.9091)
ops.node(   907,            2,            2,           13)
ops.node(   908,            1,            3,      10.9091)
ops.node(   909,            0,            1,      7.63636)
ops.node(   910,            1,            2,      10.9091)
ops.node(   911,            2,            1,           13)
ops.node(   912,            1,            1,      10.9091)
ops.node(   913,            0,            0,      7.63636)
ops.node(   914,            0,            4,      8.72727)
ops.node(   915,            2,            0,           13)
ops.node(   916,            0,            3,      8.72727)
ops.node(   917,            1,            0,      10.9091)
ops.node(   918,            0,            2,      8.72727)
ops.node(   919,            0,            1,      8.72727)
ops.node(   920,            1,            4,           12)
ops.node(   921,            1,            3,           12)
ops.node(   922,            0,            0,      8.72727)
ops.node(   923,            1,            2,           12)
ops.node(   924,            0,            4,      9.81818)
ops.node(   925,            0,            3,      9.81818)
ops.node(   926,            1,            1,           12)
ops.node(   927,            0,            2,      9.81818)
ops.node(   928,            1,            0,           12)
ops.node(   929,            0,            1,      9.81818)
ops.node(   930,            0,            0,      9.81818)
ops.node(   931,            1,            4,           13)
ops.node(   932,            1,            3,           13)
ops.node(   933,            1,            2,           13)
ops.node(   934,            0,            4,      10.9091)
ops.node(   935,            0,            3,      10.9091)
ops.node(   936,            1,            1,           13)
ops.node(   937,            0,            2,      10.9091)
ops.node(   938,            0,            1,      10.9091)
ops.node(   939,            1,            0,           13)
ops.node(   940,            0,            0,      10.9091)
ops.node(   941,            0,            4,           12)
ops.node(   942,            0,            3,           12)
ops.node(   943,            0,            2,           12)
ops.node(   944,            0,            1,           12)
ops.node(   945,            0,            0,           12)
ops.node(   946,            0,            4,           13)
ops.node(   947,            0,            3,           13)
ops.node(   948,            0,            2,           13)
ops.node(   949,            0,            1,           13)
ops.node(   950,            0,            0,           13)

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl z-transl

ops.fix(     1,   1,   1,   1)
ops.fix(     2,   1,   1,   1)
ops.fix(     3,   1,   1,   1)
ops.fix(     5,   1,   1,   1)
ops.fix(     9,   1,   1,   1)
ops.fix(    10,   1,   1,   1)
ops.fix(    11,   1,   1,   1)
ops.fix(    12,   1,   1,   1)
ops.fix(    21,   1,   1,   1)
ops.fix(    22,   1,   1,   1)
ops.fix(    26,   1,   1,   1)
ops.fix(    34,   1,   1,   1)
ops.fix(    42,   1,   1,   1)
ops.fix(    45,   1,   1,   1)
ops.fix(    50,   1,   1,   1)
ops.fix(   108,   1,   1,   1)
ops.fix(   110,   1,   1,   1)
ops.fix(   118,   1,   1,   1)
ops.fix(   125,   1,   1,   1)
ops.fix(   135,   1,   1,   1)
ops.fix(   137,   1,   1,   1)
ops.fix(   139,   1,   1,   1)
ops.fix(   149,   1,   1,   1)
ops.fix(   160,   1,   1,   1)
ops.fix(   175,   1,   1,   1)
ops.fix(   180,   1,   1,   1)
ops.fix(   186,   1,   1,   1)
ops.fix(   197,   1,   1,   1)
ops.fix(   209,   1,   1,   1)
ops.fix(   229,   1,   1,   1)
ops.fix(   242,   1,   1,   1)
ops.fix(   246,   1,   1,   1)
ops.fix(   253,   1,   1,   1)
ops.fix(   269,   1,   1,   1)
ops.fix(   290,   1,   1,   1)
ops.fix(   307,   1,   1,   1)
ops.fix(   309,   1,   1,   1)
ops.fix(   322,   1,   1,   1)
ops.fix(   336,   1,   1,   1)
ops.fix(   354,   1,   1,   1)
ops.fix(   591,   1,   1,   1)
ops.fix(   592,   1,   1,   1)
ops.fix(   595,   1,   1,   1)
ops.fix(   603,   1,   1,   1)
ops.fix(   610,   1,   1,   1)
ops.fix(   636,   1,   1,   1)
ops.fix(   638,   1,   1,   1)
ops.fix(   642,   1,   1,   1)
ops.fix(   648,   1,   1,   1)
ops.fix(   662,   1,   1,   1)
ops.fix(   695,   1,   1,   1)
ops.fix(   698,   1,   1,   1)
ops.fix(   704,   1,   1,   1)
ops.fix(   714,   1,   1,   1)
ops.fix(   723,   1,   1,   1)
ops.fix(   766,   1,   1,   1)
ops.fix(   768,   1,   1,   1)
ops.fix(   772,   1,   1,   1)
ops.fix(   782,   1,   1,   1)
ops.fix(   791,   1,   1,   1)
ops.fix(   833,   1,   1,   1)
ops.fix(   835,   1,   1,   1)
ops.fix(   840,   1,   1,   1)
ops.fix(   848,   1,   1,   1)
ops.fix(   861,   1,   1,   1)

# --------------------------------------------------------------------------------------------------------------
# S T A N D A R D   B R I C K   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# nDMaterial Definition used by stdBrick Elements
# (if they have not already been defined on this model domain)

ops.nDMaterial("ElasticIsotropic", 359, 2.5e+06, 0.2,            0)

# stdBrick element definition: element stdBrick $eleTag $node1 $node2 $node3 $node4 $node5 $node6 $node7 $node8 $matTag <$b1 $b2 $b3>

ops.element('stdBrick',      1,    784,    850,    848,    782,    795,    862,    861,    791   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      2,    715,    784,    782,    714,    725,    795,    791,    723   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      3,    651,    715,    714,    648,    663,    725,    723,    662   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      4,    604,    651,    648,    603,    611,    663,    662,    610   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      5,    787,    857,    850,    784,    801,    869,    862,    795   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      6,    721,    787,    784,    715,    732,    801,    795,    725   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      7,    659,    721,    715,    651,    669,    732,    725,    663   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      8,    608,    659,    651,    604,    618,    669,    663,    611   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',      9,    798,    866,    857,    787,    808,    875,    869,    801   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     10,    729,    798,    787,    721,    738,    808,    801,    732   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     11,    666,    729,    721,    659,    672,    738,    732,    669   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     12,    614,    666,    659,    608,    621,    672,    669,    618   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     13,    810,    877,    866,    798,    817,    882,    875,    808   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     14,    741,    810,    798,    729,    750,    817,    808,    738   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     15,    675,    741,    729,    666,    681,    750,    738,    672   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     16,    623,    675,    666,    614,    628,    681,    672,    621   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     17,    818,    886,    877,    810,    827,    894,    882,    817   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     18,    752,    818,    810,    741,    760,    827,    817,    750   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     19,    685,    752,    741,    675,    690,    760,    750,    681   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     20,    629,    685,    675,    623,    633,    690,    681,    628   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     21,    831,    897,    886,    818,    839,    901,    894,    827   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     22,    765,    831,    818,    752,    777,    839,    827,    760   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     23,    697,    765,    752,    685,    711,    777,    760,    690   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     24,    641,    697,    685,    629,    650,    711,    690,    633   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     25,    856,    909,    897,    831,    865,    913,    901,    839   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     26,    788,    856,    831,    765,    802,    865,    839,    777   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     27,    724,    788,    765,    697,    735,    802,    777,    711   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     28,    664,    724,    697,    641,    671,    735,    711,    650   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     29,    879,    919,    909,    856,    885,    922,    913,    865   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     30,    815,    879,    856,    788,    819,    885,    865,    802   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     31,    748,    815,    788,    724,    753,    819,    802,    735   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     32,    682,    748,    724,    664,    688,    753,    735,    671   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     33,    896,    929,    919,    879,    899,    930,    922,    885   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     34,    832,    896,    879,    815,    842,    899,    885,    819   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     35,    770,    832,    815,    748,    780,    842,    819,    753   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     36,    707,    770,    748,    682,    720,    780,    753,    688   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     37,    912,    938,    929,    896,    917,    940,    930,    899   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     38,    867,    912,    896,    832,    876,    917,    899,    842   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     39,    805,    867,    832,    770,    813,    876,    842,    780   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     40,    740,    805,    770,    707,    749,    813,    780,    720   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     41,    926,    944,    938,    912,    928,    945,    940,    917   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     42,    892,    926,    912,    867,    898,    928,    917,    876   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     43,    830,    892,    867,    805,    834,    898,    876,    813   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     44,    767,    830,    805,    740,    779,    834,    813,    749   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     45,    774,    844,    840,    772,    784,    850,    848,    782   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     46,    706,    774,    772,    704,    715,    784,    782,    714   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     47,    644,    706,    704,    642,    651,    715,    714,    648   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     48,    598,    644,    642,    595,    604,    651,    648,    603   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     49,    781,    847,    844,    774,    787,    857,    850,    784   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     50,    713,    781,    774,    706,    721,    787,    784,    715   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     51,    647,    713,    706,    644,    659,    721,    715,    651   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     52,    602,    647,    644,    598,    608,    659,    651,    604   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     53,    789,    859,    847,    781,    798,    866,    857,    787   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     54,    722,    789,    781,    713,    729,    798,    787,    721   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     55,    660,    722,    713,    647,    666,    729,    721,    659   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     56,    609,    660,    647,    602,    614,    666,    659,    608   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     57,    803,    872,    859,    789,    810,    877,    866,    798   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     58,    734,    803,    789,    722,    741,    810,    798,    729   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     59,    670,    734,    722,    660,    675,    741,    729,    666   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     60,    620,    670,    660,    609,    623,    675,    666,    614   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     61,    816,    881,    872,    803,    818,    886,    877,    810   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     62,    747,    816,    803,    734,    752,    818,    810,    741   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     63,    680,    747,    734,    670,    685,    752,    741,    675   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     64,    626,    680,    670,    620,    629,    685,    675,    623   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     65,    828,    895,    881,    816,    831,    897,    886,    818   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     66,    762,    828,    816,    747,    765,    831,    818,    752   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     67,    692,    762,    747,    680,    697,    765,    752,    685   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     68,    635,    692,    680,    626,    641,    697,    685,    629   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     69,    846,    905,    895,    828,    856,    909,    897,    831   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     70,    783,    846,    828,    762,    788,    856,    831,    765   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     71,    718,    783,    762,    692,    724,    788,    765,    697   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     72,    658,    718,    692,    635,    664,    724,    697,    641   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     73,    873,    918,    905,    846,    879,    919,    909,    856   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     74,    809,    873,    846,    783,    815,    879,    856,    788   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     75,    743,    809,    783,    718,    748,    815,    788,    724   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     76,    679,    743,    718,    658,    682,    748,    724,    664   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     77,    893,    927,    918,    873,    896,    929,    919,    879   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     78,    829,    893,    873,    809,    832,    896,    879,    815   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     79,    764,    829,    809,    743,    770,    832,    815,    748   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     80,    696,    764,    743,    679,    707,    770,    748,    682   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     81,    910,    937,    927,    893,    912,    938,    929,    896   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     82,    860,    910,    893,    829,    867,    912,    896,    832   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     83,    796,    860,    829,    764,    805,    867,    832,    770   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     84,    733,    796,    764,    696,    740,    805,    770,    707   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     85,    923,    943,    937,    910,    926,    944,    938,    912   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     86,    887,    923,    910,    860,    892,    926,    912,    867   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     87,    825,    887,    860,    796,    830,    892,    867,    805   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     88,    763,    825,    796,    733,    767,    830,    805,    740   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     89,    771,    837,    835,    768,    774,    844,    840,    772   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     90,    701,    771,    768,    698,    706,    774,    772,    704   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     91,    640,    701,    698,    638,    644,    706,    704,    642   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     92,    594,    640,    638,    592,    598,    644,    642,    595   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     93,    776,    845,    837,    771,    781,    847,    844,    774   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     94,    708,    776,    771,    701,    713,    781,    774,    706   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     95,    646,    708,    701,    640,    647,    713,    706,    644   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     96,    600,    646,    640,    594,    602,    647,    644,    598   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     97,    786,    854,    845,    776,    789,    859,    847,    781   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     98,    719,    786,    776,    708,    722,    789,    781,    713   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',     99,    655,    719,    708,    646,    660,    722,    713,    647   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    100,    606,    655,    646,    600,    609,    660,    647,    602   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    101,    800,    868,    854,    786,    803,    872,    859,    789   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    102,    731,    800,    786,    719,    734,    803,    789,    722   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    103,    667,    731,    719,    655,    670,    734,    722,    660   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    104,    616,    667,    655,    606,    620,    670,    660,    609   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    105,    812,    880,    868,    800,    816,    881,    872,    803   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    106,    745,    812,    800,    731,    747,    816,    803,    734   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    107,    678,    745,    731,    667,    680,    747,    734,    670   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    108,    625,    678,    667,    616,    626,    680,    670,    620   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    109,    824,    891,    880,    812,    828,    895,    881,    816   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    110,    756,    824,    812,    745,    762,    828,    816,    747   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    111,    689,    756,    745,    678,    692,    762,    747,    680   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    112,    631,    689,    678,    625,    635,    692,    680,    626   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    113,    841,    902,    891,    824,    846,    905,    895,    828   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    114,    778,    841,    824,    756,    783,    846,    828,    762   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    115,    712,    778,    756,    689,    718,    783,    762,    692   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    116,    652,    712,    689,    631,    658,    718,    692,    635   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    117,    871,    916,    902,    841,    873,    918,    905,    846   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    118,    806,    871,    841,    778,    809,    873,    846,    783   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    119,    737,    806,    778,    712,    743,    809,    783,    718   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    120,    676,    737,    712,    652,    679,    743,    718,    658   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    121,    889,    925,    916,    871,    893,    927,    918,    873   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    122,    826,    889,    871,    806,    829,    893,    873,    809   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    123,    761,    826,    806,    737,    764,    829,    809,    743   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    124,    694,    761,    737,    676,    696,    764,    743,    679   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    125,    908,    935,    925,    889,    910,    937,    927,    893   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    126,    855,    908,    889,    826,    860,    910,    893,    829   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    127,    793,    855,    826,    761,    796,    860,    829,    764   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    128,    730,    793,    761,    694,    733,    796,    764,    696   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    129,    921,    942,    935,    908,    923,    943,    937,    910   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    130,    884,    921,    908,    855,    887,    923,    910,    860   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    131,    821,    884,    855,    793,    825,    887,    860,    796   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    132,    758,    821,    793,    730,    763,    825,    796,    733   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    133,    769,    836,    833,    766,    771,    837,    835,    768   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    134,    699,    769,    766,    695,    701,    771,    768,    698   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    135,    639,    699,    695,    636,    640,    701,    698,    638   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    136,    593,    639,    636,    591,    594,    640,    638,    592   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    137,    773,    843,    836,    769,    776,    845,    837,    771   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    138,    705,    773,    769,    699,    708,    776,    771,    701   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    139,    643,    705,    699,    639,    646,    708,    701,    640   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    140,    597,    643,    639,    593,    600,    646,    640,    594   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    141,    785,    851,    843,    773,    786,    854,    845,    776   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    142,    716,    785,    773,    705,    719,    786,    776,    708   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    143,    653,    716,    705,    643,    655,    719,    708,    646   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    144,    605,    653,    643,    597,    606,    655,    646,    600   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    145,    797,    864,    851,    785,    800,    868,    854,    786   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    146,    728,    797,    785,    716,    731,    800,    786,    719   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    147,    665,    728,    716,    653,    667,    731,    719,    655   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    148,    613,    665,    653,    605,    616,    667,    655,    606   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    149,    811,    878,    864,    797,    812,    880,    868,    800   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    150,    744,    811,    797,    728,    745,    812,    800,    731   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    151,    677,    744,    728,    665,    678,    745,    731,    667   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    152,    624,    677,    665,    613,    625,    678,    667,    616   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    153,    822,    890,    878,    811,    824,    891,    880,    812   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    154,    754,    822,    811,    744,    756,    824,    812,    745   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    155,    687,    754,    744,    677,    689,    756,    745,    678   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    156,    630,    687,    677,    624,    631,    689,    678,    625   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    157,    838,    900,    890,    822,    841,    902,    891,    824   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    158,    775,    838,    822,    754,    778,    841,    824,    756   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    159,    710,    775,    754,    687,    712,    778,    756,    689   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    160,    649,    710,    687,    630,    652,    712,    689,    631   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    161,    870,    914,    900,    838,    871,    916,    902,    841   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    162,    804,    870,    838,    775,    806,    871,    841,    778   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    163,    736,    804,    775,    710,    737,    806,    778,    712   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    164,    673,    736,    710,    649,    676,    737,    712,    652   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    165,    888,    924,    914,    870,    889,    925,    916,    871   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    166,    823,    888,    870,    804,    826,    889,    871,    806   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    167,    759,    823,    804,    736,    761,    826,    806,    737   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    168,    693,    759,    736,    673,    694,    761,    737,    676   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    169,    906,    934,    924,    888,    908,    935,    925,    889   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    170,    853,    906,    888,    823,    855,    908,    889,    826   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    171,    790,    853,    823,    759,    793,    855,    826,    761   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    172,    727,    790,    759,    693,    730,    793,    761,    694   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    173,    920,    941,    934,    906,    921,    942,    935,    908   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    174,    883,    920,    906,    853,    884,    921,    908,    855   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    175,    820,    883,    853,    790,    821,    884,    855,    793   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    176,    757,    820,    790,    727,    758,    821,    793,    730   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    177,    936,    949,    944,    926,    939,    950,    945,    928   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    178,    911,    936,    926,    892,    915,    939,    928,    898   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    179,    863,    911,    892,    830,    874,    915,    898,    834   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    180,    807,    863,    830,    767,    814,    874,    834,    779   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    181,    933,    948,    943,    923,    936,    949,    944,    926   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    182,    907,    933,    923,    887,    911,    936,    926,    892   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    183,    858,    907,    887,    825,    863,    911,    892,    830   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    184,    799,    858,    825,    763,    807,    863,    830,    767   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    185,    932,    947,    942,    921,    933,    948,    943,    923   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    186,    904,    932,    921,    884,    907,    933,    923,    887   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    187,    852,    904,    884,    821,    858,    907,    887,    825   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    188,    794,    852,    821,    758,    799,    858,    825,    763   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    189,    931,    946,    941,    920,    932,    947,    942,    921   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    190,    903,    931,    920,    883,    904,    932,    921,    884   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    191,    849,    903,    883,    820,    852,    904,    884,    821   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    192,    792,    849,    820,    757,    794,    852,    821,    758   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    193,    529,    517,    524,    534,    530,    519,    528,    538   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    194,    539,    529,    534,    544,    540,    530,    538,    548   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    195,    549,    539,    544,    554,    550,    540,    548,    558   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    196,    559,    549,    554,    564,    560,    550,    558,    567   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    197,    569,    559,    564,    574,    570,    560,    567,    577   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    198,    579,    569,    574,    584,    580,    570,    577,    587   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    199,    589,    579,    584,    607,    590,    580,    587,    617   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    200,    622,    589,    607,    645,    627,    590,    617,    657   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    201,    668,    622,    645,    691,    674,    627,    657,    702   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    202,    717,    668,    691,    751,    726,    674,    702,    755   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    203,    767,    717,    751,    807,    779,    726,    755,    814   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    204,    527,    515,    523,    533,    529,    517,    524,    534   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    205,    537,    527,    533,    543,    539,    529,    534,    544   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    206,    547,    537,    543,    553,    549,    539,    544,    554   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    207,    557,    547,    553,    563,    559,    549,    554,    564   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    208,    568,    557,    563,    573,    569,    559,    564,    574   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    209,    578,    568,    573,    583,    579,    569,    574,    584   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    210,    588,    578,    583,    601,    589,    579,    584,    607   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    211,    619,    588,    601,    637,    622,    589,    607,    645   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    212,    661,    619,    637,    686,    668,    622,    645,    691   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    213,    709,    661,    686,    746,    717,    668,    691,    751   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    214,    763,    709,    746,    799,    767,    717,    751,    807   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    215,    526,    512,    522,    532,    527,    515,    523,    533   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    216,    536,    526,    532,    542,    537,    527,    533,    543   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    217,    546,    536,    542,    552,    547,    537,    543,    553   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    218,    556,    546,    552,    562,    557,    547,    553,    563   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    219,    566,    556,    562,    572,    568,    557,    563,    573   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    220,    576,    566,    572,    582,    578,    568,    573,    583   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    221,    586,    576,    582,    599,    588,    578,    583,    601   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    222,    615,    586,    599,    634,    619,    588,    601,    637   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    223,    656,    615,    634,    684,    661,    619,    637,    686   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    224,    703,    656,    684,    742,    709,    661,    686,    746   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    225,    758,    703,    742,    794,    763,    709,    746,    799   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    226,    525,    511,    521,    531,    526,    512,    522,    532   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    227,    535,    525,    531,    541,    536,    526,    532,    542   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    228,    545,    535,    541,    551,    546,    536,    542,    552   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    229,    555,    545,    551,    561,    556,    546,    552,    562   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    230,    565,    555,    561,    571,    566,    556,    562,    572   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    231,    575,    565,    571,    581,    576,    566,    572,    582   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    232,    585,    575,    581,    596,    586,    576,    582,    599   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    233,    612,    585,    596,    632,    615,    586,    599,    634   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    234,    654,    612,    632,    683,    656,    615,    634,    684   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    235,    700,    654,    683,    739,    703,    656,    684,    742   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    236,    757,    700,    739,    792,    758,    703,    742,    794   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    237,    505,    518,    524,    517,    508,    520,    528,    519   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    238,    489,    507,    518,    505,    493,    510,    520,    508   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    239,    468,    492,    507,    489,    473,    498,    510,    493   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    240,    446,    475,    492,    468,    454,    484,    498,    473   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    241,    501,    516,    523,    515,    505,    518,    524,    517   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    242,    483,    504,    516,    501,    489,    507,    518,    505   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    243,    462,    490,    504,    483,    468,    492,    507,    489   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    244,    443,    469,    490,    462,    446,    475,    492,    468   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    245,    499,    514,    522,    512,    501,    516,    523,    515   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    246,    479,    503,    514,    499,    483,    504,    516,    501   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    247,    459,    487,    503,    479,    462,    490,    504,    483   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    248,    439,    467,    487,    459,    443,    469,    490,    462   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    249,    496,    513,    521,    511,    499,    514,    522,    512   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    250,    478,    502,    513,    496,    479,    503,    514,    499   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    251,    455,    485,    502,    478,    459,    487,    503,    479   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    252,    437,    465,    485,    455,    439,    467,    487,    459   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    253,    486,    491,    508,    505,    506,    509,    519,    517   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    254,    481,    486,    505,    501,    500,    506,    517,    515   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    255,    476,    481,    501,    499,    497,    500,    515,    512   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    256,    474,    476,    499,    496,    495,    497,    512,    511   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    257,    463,    470,    491,    486,    488,    494,    509,    506   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    258,    457,    463,    486,    481,    482,    488,    506,    500   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    259,    451,    457,    481,    476,    480,    482,    500,    497   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    260,    450,    451,    476,    474,    477,    480,    497,    495   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    261,    464,    471,    493,    489,    486,    491,    508,    505   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    262,    456,    464,    489,    483,    481,    486,    505,    501   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    263,    452,    456,    483,    479,    476,    481,    501,    499   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    264,    449,    452,    479,    478,    474,    476,    499,    496   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    265,    438,    445,    471,    464,    463,    470,    491,    486   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    266,    431,    438,    464,    456,    457,    463,    486,    481   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    267,    425,    431,    456,    452,    451,    457,    481,    476   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    268,    424,    425,    452,    449,    450,    451,    476,    474   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    269,    441,    448,    473,    468,    464,    471,    493,    489   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    270,    433,    441,    468,    462,    456,    464,    489,    483   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    271,    430,    433,    462,    459,    452,    456,    483,    479   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    272,    427,    430,    459,    455,    449,    452,    479,    478   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    273,    414,    420,    448,    441,    438,    445,    471,    464   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    274,    407,    414,    441,    433,    431,    438,    464,    456   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    275,    401,    407,    433,    430,    425,    431,    456,    452   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    276,    398,    401,    430,    427,    424,    425,    452,    449   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    277,    419,    426,    454,    446,    441,    448,    473,    468   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    278,    411,    419,    446,    443,    433,    441,    468,    462   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    279,    409,    411,    443,    439,    430,    433,    462,    459   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    280,    408,    409,    439,    437,    427,    430,    459,    455   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    281,    387,    396,    426,    419,    414,    420,    448,    441   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    282,    378,    387,    419,    411,    407,    414,    441,    433   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    283,    370,    378,    411,    409,    401,    407,    433,    430   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    284,    366,    370,    409,    408,    398,    401,    430,    427   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    285,    442,    447,    470,    463,    466,    472,    494,    488   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    286,    434,    442,    463,    457,    461,    466,    488,    482   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    287,    429,    434,    457,    451,    460,    461,    482,    480   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    288,    428,    429,    451,    450,    458,    460,    480,    477   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    289,    413,    421,    445,    438,    442,    447,    470,    463   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    290,    406,    413,    438,    431,    434,    442,    463,    457   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    291,    400,    406,    431,    425,    429,    434,    457,    451   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    292,    399,    400,    425,    424,    428,    429,    451,    450   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    293,    383,    393,    420,    414,    413,    421,    445,    438   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    294,    374,    383,    414,    407,    406,    413,    438,    431   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    295,    364,    374,    407,    401,    400,    406,    431,    425   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    296,    361,    364,    401,    398,    399,    400,    425,    424   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    297,    339,    355,    396,    387,    383,    393,    420,    414   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    298,    324,    339,    387,    378,    374,    383,    414,    407   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    299,    316,    324,    378,    370,    364,    374,    407,    401   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    300,    310,    316,    370,    366,    361,    364,    401,    398   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    301,    417,    423,    447,    442,    444,    453,    472,    466   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    302,    410,    417,    442,    434,    440,    444,    466,    461   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    303,    404,    410,    434,    429,    436,    440,    461,    460   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    304,    403,    404,    429,    428,    435,    436,    460,    458   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    305,    389,    402,    423,    417,    422,    432,    453,    444   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    306,    382,    389,    417,    410,    418,    422,    444,    440   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    307,    377,    382,    410,    404,    415,    418,    440,    436   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    308,    376,    377,    404,    403,    412,    415,    436,    435   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    309,    359,    380,    402,    389,    405,    416,    432,    422   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    310,    347,    359,    389,    382,    395,    405,    422,    418   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    311,    338,    347,    382,    377,    391,    395,    418,    415   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    312,    335,    338,    377,    376,    390,    391,    415,    412   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    313,    331,    348,    380,    359,    388,    397,    416,    405   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    314,    311,    331,    359,    347,    379,    388,    405,    395   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    315,    301,    311,    347,    338,    372,    379,    395,    391   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    316,    296,    301,    338,    335,    367,    372,    391,    390   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    317,    298,    323,    348,    331,    369,    386,    397,    388   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    318,    289,    298,    331,    311,    353,    369,    388,    379   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    319,    277,    289,    311,    301,    346,    353,    379,    372   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    320,    275,    277,    301,    296,    344,    346,    372,    367   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    321,    283,    300,    323,    298,    350,    371,    386,    369   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    322,    271,    283,    298,    289,    337,    350,    369,    353   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    323,    261,    271,    289,    277,    330,    337,    353,    346   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    324,    257,    261,    277,    275,    325,    330,    346,    344   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    325,    273,    292,    300,    283,    340,    356,    371,    350   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    326,    258,    273,    283,    271,    326,    340,    350,    337   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    327,    249,    258,    271,    261,    317,    326,    337,    330   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    328,    248,    249,    261,    257,    312,    317,    330,    325   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    329,    269,    290,    292,    273,    336,    354,    356,    340   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    330,    253,    269,    273,    258,    322,    336,    340,    326   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    331,    246,    253,    258,    249,    309,    322,    326,    317   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    332,    242,    246,    249,    248,    307,    309,    317,    312   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    333,    384,    394,    421,    413,    417,    423,    447,    442   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    334,    375,    384,    413,    406,    410,    417,    442,    434   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    335,    365,    375,    406,    400,    404,    410,    434,    429   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    336,    362,    365,    400,    399,    403,    404,    429,    428   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    337,    341,    358,    394,    384,    389,    402,    423,    417   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    338,    327,    341,    384,    375,    382,    389,    417,    410   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    339,    318,    327,    375,    365,    377,    382,    410,    404   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    340,    314,    318,    365,    362,    376,    377,    404,    403   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    341,    294,    321,    358,    341,    359,    380,    402,    389   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    342,    286,    294,    341,    327,    347,    359,    389,    382   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    343,    276,    286,    327,    318,    338,    347,    382,    377   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    344,    274,    276,    318,    314,    335,    338,    377,    376   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    345,    268,    288,    321,    294,    331,    348,    380,    359   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    346,    251,    268,    294,    286,    311,    331,    359,    347   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    347,    244,    251,    286,    276,    301,    311,    347,    338   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    348,    239,    244,    276,    274,    296,    301,    338,    335   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    349,    240,    262,    288,    268,    298,    323,    348,    331   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    350,    227,    240,    268,    251,    289,    298,    331,    311   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    351,    219,    227,    251,    244,    277,    289,    311,    301   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    352,    217,    219,    244,    239,    275,    277,    301,    296   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    353,    225,    243,    262,    240,    283,    300,    323,    298   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    354,    211,    225,    240,    227,    271,    283,    298,    289   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    355,    205,    211,    227,    219,    261,    271,    289,    277   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    356,    202,    205,    219,    217,    257,    261,    277,    275   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    357,    215,    235,    243,    225,    273,    292,    300,    283   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    358,    204,    215,    225,    211,    258,    273,    283,    271   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    359,    194,    204,    211,    205,    249,    258,    271,    261   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    360,    189,    194,    205,    202,    248,    249,    261,    257   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    361,    209,    229,    235,    215,    269,    290,    292,    273   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    362,    197,    209,    215,    204,    253,    269,    273,    258   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    363,    186,    197,    204,    194,    246,    253,    258,    249   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    364,    180,    186,    194,    189,    242,    246,    249,    248   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    365,    334,    351,    393,    383,    384,    394,    421,    413   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    366,    320,    334,    383,    374,    375,    384,    413,    406   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    367,    308,    320,    374,    364,    365,    375,    406,    400   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    368,    305,    308,    364,    361,    362,    365,    400,    399   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    369,    285,    303,    351,    334,    341,    358,    394,    384   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    370,    272,    285,    334,    320,    327,    341,    384,    375   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    371,    263,    272,    320,    308,    318,    327,    375,    365   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    372,    259,    263,    308,    305,    314,    318,    365,    362   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    373,    245,    264,    303,    285,    294,    321,    358,    341   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    374,    231,    245,    285,    272,    286,    294,    341,    327   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    375,    224,    231,    272,    263,    276,    286,    327,    318   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    376,    220,    224,    263,    259,    274,    276,    318,    314   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    377,    214,    234,    264,    245,    268,    288,    321,    294   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    378,    203,    214,    245,    231,    251,    268,    294,    286   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    379,    193,    203,    231,    224,    244,    251,    286,    276   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    380,    188,    193,    224,    220,    239,    244,    276,    274   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    381,    190,    207,    234,    214,    240,    262,    288,    268   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    382,    172,    190,    214,    203,    227,    240,    268,    251   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    383,    168,    172,    203,    193,    219,    227,    251,    244   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    384,    166,    168,    193,    188,    217,    219,    244,    239   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    385,    170,    192,    207,    190,    225,    243,    262,    240   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    386,    162,    170,    190,    172,    211,    225,    240,    227   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    387,    157,    162,    172,    168,    205,    211,    227,    219   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    388,    155,    157,    168,    166,    202,    205,    219,    217   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    389,    164,    177,    192,    170,    215,    235,    243,    225   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    390,    156,    164,    170,    162,    204,    215,    225,    211   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    391,    145,    156,    162,    157,    194,    204,    211,    205   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    392,    143,    145,    157,    155,    189,    194,    205,    202   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    393,    160,    175,    177,    164,    209,    229,    235,    215   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    394,    149,    160,    164,    156,    197,    209,    215,    204   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    395,    139,    149,    156,    145,    186,    197,    204,    194   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    396,    137,    139,    145,    143,    180,    186,    194,    189   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    397,    282,    299,    355,    339,    334,    351,    393,    383   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    398,    270,    282,    339,    324,    320,    334,    383,    374   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    399,    260,    270,    324,    316,    308,    320,    374,    364   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    400,    256,    260,    316,    310,    305,    308,    364,    361   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    401,    236,    254,    299,    282,    285,    303,    351,    334   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    402,    223,    236,    282,    270,    272,    285,    334,    320   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    403,    216,    223,    270,    260,    263,    272,    320,    308   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    404,    212,    216,    260,    256,    259,    263,    308,    305   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    405,    199,    218,    254,    236,    245,    264,    303,    285   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    406,    178,    199,    236,    223,    231,    245,    285,    272   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    407,    173,    178,    223,    216,    224,    231,    272,    263   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    408,    171,    173,    216,    212,    220,    224,    263,    259   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    409,    167,    182,    218,    199,    214,    234,    264,    245   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    410,    158,    167,    199,    178,    203,    214,    245,    231   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    411,    152,    158,    178,    173,    193,    203,    231,    224   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    412,    146,    152,    173,    171,    188,    193,    224,    220   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    413,    147,    165,    182,    167,    190,    207,    234,    214   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    414,    134,    147,    167,    158,    172,    190,    214,    203   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    415,    130,    134,    158,    152,    168,    172,    203,    193   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    416,    129,    130,    152,    146,    166,    168,    193,    188   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    417,    132,    151,    165,    147,    170,    192,    207,    190   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    418,    126,    132,    147,    134,    162,    170,    190,    172   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    419,    122,    126,    134,    130,    157,    162,    172,    168   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    420,    119,    122,    130,    129,    155,    157,    168,    166   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    421,    127,    138,    151,    132,    164,    177,    192,    170   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    422,    120,    127,    132,    126,    156,    164,    170,    162   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    423,    115,    120,    126,    122,    145,    156,    162,    157   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    424,    111,    115,    122,    119,    143,    145,    157,    155   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    425,    125,    135,    138,    127,    160,    175,    177,    164   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    426,    118,    125,    127,    120,    149,    160,    164,    156   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    427,    110,    118,    120,    115,    139,    149,    156,    145   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    428,    108,    110,    115,    111,    137,    139,    145,    143   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    429,    208,    169,    221,    265,    228,    184,    238,    287   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    430,    247,    208,    265,    304,    267,    228,    287,    328   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    431,    279,    247,    304,    342,    295,    267,    328,    360   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    432,    306,    279,    342,    368,    333,    295,    360,    385   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    433,    332,    306,    368,    381,    349,    333,    385,    392   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    434,    339,    332,    381,    387,    355,    349,    392,    396   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    435,    195,    159,    206,    250,    208,    169,    221,    265   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    436,    233,    195,    250,    291,    247,    208,    265,    304   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    437,    266,    233,    291,    329,    279,    247,    304,    342   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    438,    293,    266,    329,    352,    306,    279,    342,    368   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    439,    313,    293,    352,    373,    332,    306,    368,    381   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    440,    324,    313,    373,    378,    339,    332,    381,    387   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    441,    183,    154,    201,    241,    195,    159,    206,    250   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    442,    226,    183,    241,    281,    233,    195,    250,    291   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    443,    255,    226,    281,    319,    266,    233,    291,    329   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    444,    284,    255,    319,    345,    293,    266,    329,    352   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    445,    302,    284,    345,    363,    313,    293,    352,    373   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    446,    316,    302,    363,    370,    324,    313,    373,    378   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    447,    179,    150,    198,    237,    183,    154,    201,    241   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    448,    222,    179,    237,    278,    226,    183,    241,    281   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    449,    252,    222,    278,    315,    255,    226,    281,    319   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    450,    280,    252,    315,    343,    284,    255,    319,    345   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    451,    297,    280,    343,    357,    302,    284,    345,    363   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    452,    310,    297,    357,    366,    316,    302,    363,    370   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    453,    163,    213,    221,    169,    176,    232,    238,    184   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    454,    161,    210,    213,    163,    174,    230,    232,    176   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    455,    153,    200,    206,    159,    163,    213,    221,    169   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    456,    148,    196,    200,    153,    161,    210,    213,    163   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    457,    144,    191,    201,    154,    153,    200,    206,    159   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    458,    140,    187,    191,    144,    148,    196,    200,    153   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    459,    141,    185,    198,    150,    144,    191,    201,    154   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    460,    136,    181,    185,    141,    140,    187,    191,    144   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    461,    124,    133,    176,    163,    128,    142,    184,    169   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    462,    116,    124,    163,    153,    121,    128,    169,    159   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    463,    109,    116,    153,    144,    117,    121,    159,    154   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    464,    107,    109,    144,    141,    113,    117,    154,    150   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    465,    101,    105,    133,    124,    102,    112,    142,    128   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    466,     97,    101,    124,    116,     99,    102,    128,    121   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    467,     91,     97,    116,    109,     96,     99,    121,    117   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    468,     89,     91,    109,    107,     95,     96,    117,    113   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    469,     86,     93,    105,    101,     87,     98,    112,    102   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    470,     81,     86,    101,     97,     83,     87,    102,     99   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    471,     76,     81,     97,     91,     80,     83,     99,     96   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    472,     73,     76,     91,     89,     77,     80,     96,     95   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    473,     70,     82,     93,     86,     75,     84,     98,     87   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    474,     64,     70,     86,     81,     67,     75,     87,     83   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    475,     59,     64,     81,     76,     65,     67,     83,     80   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    476,     55,     59,     76,     73,     61,     65,     80,     77   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    477,     57,     68,     82,     70,     62,     71,     84,     75   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    478,     44,     57,     70,     64,     49,     62,     75,     67   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    479,     36,     44,     64,     59,     43,     49,     67,     65   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    480,     32,     36,     59,     55,     40,     43,     65,     61   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    481,     39,     58,     68,     57,     47,     63,     71,     62   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    482,     27,     39,     57,     44,     35,     47,     62,     49   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    483,     20,     27,     44,     36,     28,     35,     49,     43   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    484,     17,     20,     36,     32,     23,     28,     43,     40   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    485,     30,     48,     58,     39,     38,     56,     63,     47   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    486,     18,     30,     39,     27,     25,     38,     47,     35   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    487,      8,     18,     27,     20,     19,     25,     35,     28   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    488,      7,      8,     20,     17,     14,     19,     28,     23   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    489,     26,     45,     48,     30,     34,     50,     56,     38   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    490,     12,     26,     30,     18,     21,     34,     38,     25   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    491,      5,     12,     18,      8,     11,     21,     25,     19   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    492,      3,      5,      8,      7,      9,     11,     19,     14   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    493,    123,    131,    174,    161,    124,    133,    176,    163   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    494,    114,    123,    161,    148,    116,    124,    163,    153   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    495,    106,    114,    148,    140,    109,    116,    153,    144   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    496,    104,    106,    140,    136,    107,    109,    144,    141   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    497,    100,    103,    131,    123,    101,    105,    133,    124   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    498,     94,    100,    123,    114,     97,    101,    124,    116   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    499,     90,     94,    114,    106,     91,     97,    116,    109   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    500,     88,     90,    106,    104,     89,     91,    109,    107   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    501,     85,     92,    103,    100,     86,     93,    105,    101   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    502,     78,     85,    100,     94,     81,     86,    101,     97   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    503,     74,     78,     94,     90,     76,     81,     97,     91   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    504,     72,     74,     90,     88,     73,     76,     91,     89   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    505,     69,     79,     92,     85,     70,     82,     93,     86   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    506,     60,     69,     85,     78,     64,     70,     86,     81   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    507,     54,     60,     78,     74,     59,     64,     81,     76   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    508,     51,     54,     74,     72,     55,     59,     76,     73   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    509,     52,     66,     79,     69,     57,     68,     82,     70   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    510,     41,     52,     69,     60,     44,     57,     70,     64   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    511,     33,     41,     60,     54,     36,     44,     64,     59   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    512,     31,     33,     54,     51,     32,     36,     59,     55   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    513,     37,     53,     66,     52,     39,     58,     68,     57   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    514,     24,     37,     52,     41,     27,     39,     57,     44   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    515,     16,     24,     41,     33,     20,     27,     44,     36   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    516,     13,     16,     33,     31,     17,     20,     36,     32   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    517,     29,     46,     53,     37,     30,     48,     58,     39   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    518,     15,     29,     37,     24,     18,     30,     39,     27   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    519,      6,     15,     24,     16,      8,     18,     27,     20   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    520,      4,      6,     16,     13,      7,      8,     20,     17   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    521,     22,     42,     46,     29,     26,     45,     48,     30   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    522,     10,     22,     29,     15,     12,     26,     30,     18   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    523,      2,     10,     15,      6,      5,     12,     18,      8   , 359,        0,        0,        0) # Material of masonry arch
ops.element('stdBrick',    524,      1,      2,      6,      4,      3,      5,      8,      7   , 359,        0,        0,        0) # Material of masonry arch

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

ops.recorder('Node', '-file', 'Node_displacements.out', '-time', '-nodeRange', 1, 950, '-dof', 1, 2, 3, 'disp')
ops.recorder('Node', '-file', 'Node_rotations.out', '-time', '-nodeRange', 1, 950, '-dof', 4, 5, 6, 'disp')
ops.recorder('Node', '-file', 'Node_forceReactions.out', '-time', '-nodeRange', 1, 950, '-dof', 1, 2, 3, 'reaction')
ops.recorder('Node', '-file', 'Node_momentReactions.out', '-time', '-nodeRange', 1, 950, '-dof', 4, 5, 6, 'reaction')
ops.recorder('Element', '-file', 'stdBrick_force.out', '-time', '-eleRange', 1, 524, 'forces')
ops.recorder('Element', '-file', 'stdBrick_stress.out', '-time', '-eleRange', 1, 524, 'stresses')
ops.recorder('Element', '-file', 'stdBrick_strain.out', '-time', '-eleRange', 1, 524, 'strains')

ops.logFile("Tutorial - Masonry Arch.log")

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
ops.load(   181,       25,       15,        0)
ops.load(   198,       25,       15,        0)
ops.load(   230,       25,       15,        0)
ops.load(   238,       25,       15,        0)
ops.load(   465,       25,       15,        0)
ops.load(   484,       25,       15,        0)
ops.load(   521,       25,       15,        0)
ops.load(   528,       25,       15,        0)
ops.load(   792,       25,       15,        0)
ops.load(   814,       25,       15,        0)
ops.load(   946,       25,       15,        0)
ops.load(   950,       25,       15,        0)

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
# 950

# Elements 1D
# 0

# Elements 2D
# 0

# Elements 3D
# 524

# stdBrick
# 524
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524

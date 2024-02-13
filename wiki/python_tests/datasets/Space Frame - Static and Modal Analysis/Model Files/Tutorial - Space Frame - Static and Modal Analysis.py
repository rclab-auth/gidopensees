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
# K. Mixios, Dipl. Eng. AUTh, MSc, PhD cand.
# V.K. Papanikolaou, Dipl. Eng., MSc DIC, PhD, Assoc. Prof. AUTh
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

# Column 30x30 (220)
# Beam 25x65 (510)

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  6DOF  (6)
#
# --------------------------------------------------------------------------------------------------------------
import openseespy.opensees as ops
import time
import math


ops.model("basic", "-ndm", 3, "-ndf", 6)

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord $Zcoord

ops.node(     1,            0,           20,            0)
ops.node(     2,            0,           20,          0.9)
ops.node(     3,            0,           20,          1.8)
ops.node(     4,            0,           20,          2.7)
ops.node(     5,            0,           20,          3.6)
ops.node(     6,            0,           20,          4.5)
ops.node(     7,            1,           20,          4.5)
ops.node(     8,            0,           19,          4.5)
ops.node(     9,            0,           18,          4.5)
ops.node(    10,            2,           20,          4.5)
ops.node(    11,            0,           15,            0)
ops.node(    12,            0,           15,          0.9)
ops.node(    13,            0,           15,          1.8)
ops.node(    14,            0,           17,          4.5)
ops.node(    15,            3,           20,          4.5)
ops.node(    16,            0,           20,          5.5)
ops.node(    17,            0,           15,          2.7)
ops.node(    18,            6,           20,            0)
ops.node(    19,            0,           16,          4.5)
ops.node(    20,            4,           20,          4.5)
ops.node(    21,            6,           20,          0.9)
ops.node(    22,            0,           15,          3.6)
ops.node(    23,            6,           20,          1.8)
ops.node(    24,            0,           20,          6.5)
ops.node(    25,            6,           20,          2.7)
ops.node(    26,            5,           20,          4.5)
ops.node(    27,            0,           15,          4.5)
ops.node(    28,            1,           15,          4.5)
ops.node(    29,            6,           20,          3.6)
ops.node(    30,            2,           15,          4.5)
ops.node(    31,            3,           15,          4.5)
ops.node(    32,            0,           15,          5.5)
ops.node(    33,            6,           20,          4.5)
ops.node(    34,            0,           20,          7.5)
ops.node(    35,            0,           14,          4.5)
ops.node(    36,            1,           20,          7.5)
ops.node(    37,            0,           19,          7.5)
ops.node(    38,            6,           19,          4.5)
ops.node(    39,            0,           18,          7.5)
ops.node(    40,            2,           20,          7.5)
ops.node(    41,            6,           18,          4.5)
ops.node(    42,            6,           15,            0)
ops.node(    43,            4,           15,          4.5)
ops.node(    44,            6,           15,          0.9)
ops.node(    45,            6,           15,          1.8)
ops.node(    46,            6,           17,          4.5)
ops.node(    47,            0,           17,          7.5)
ops.node(    48,            3,           20,          7.5)
ops.node(    49,            6,           20,          5.5)
ops.node(    50,            0,           15,          6.5)
ops.node(    51,            6,           15,          2.7)
ops.node(    52,            0,           13,          4.5)
ops.node(    53,            7,           20,          4.5)
ops.node(    54,            5,           15,          4.5)
ops.node(    55,            0,           16,          7.5)
ops.node(    56,            0,           20,          8.5)
ops.node(    57,            6,           16,          4.5)
ops.node(    58,            4,           20,          7.5)
ops.node(    59,            6,           15,          3.6)
ops.node(    60,            6,           20,          6.5)
ops.node(    61,            5,           20,          7.5)
ops.node(    62,            0,           15,          7.5)
ops.node(    63,            6,           15,          4.5)
ops.node(    64,            1,           15,          7.5)
ops.node(    65,            0,           12,          4.5)
ops.node(    66,            8,           20,          4.5)
ops.node(    67,            2,           15,          7.5)
ops.node(    68,            3,           15,          7.5)
ops.node(    69,            0,           20,          9.5)
ops.node(    70,            6,           15,          5.5)
ops.node(    71,            0,           14,          7.5)
ops.node(    72,            6,           14,          4.5)
ops.node(    73,            6,           20,          7.5)
ops.node(    74,            6,           19,          7.5)
ops.node(    75,            7,           15,          4.5)
ops.node(    76,            6,           18,          7.5)
ops.node(    77,            4,           15,          7.5)
ops.node(    78,            0,           15,          8.5)
ops.node(    79,            9,           20,          4.5)
ops.node(    80,            6,           17,          7.5)
ops.node(    81,            0,           11,          4.5)
ops.node(    82,            6,           15,          6.5)
ops.node(    83,            0,           13,          7.5)
ops.node(    84,            6,           13,          4.5)
ops.node(    85,            7,           20,          7.5)
ops.node(    86,            5,           15,          7.5)
ops.node(    87,            6,           16,          7.5)
ops.node(    88,            6,           20,          8.5)
ops.node(    89,            8,           15,          4.5)
ops.node(    90,            0,           20,         10.5)
ops.node(    91,            1,           20,         10.5)
ops.node(    92,            0,           19,         10.5)
ops.node(    93,            2,           20,         10.5)
ops.node(    94,            0,           18,         10.5)
ops.node(    95,            0,           15,          9.5)
ops.node(    96,            6,           15,          7.5)
ops.node(    97,            0,           17,         10.5)
ops.node(    98,            3,           20,         10.5)
ops.node(    99,            8,           20,          7.5)
ops.node(   100,            0,           12,          7.5)
ops.node(   101,            0,           10,          4.5)
ops.node(   102,           10,           20,          4.5)
ops.node(   103,            6,           12,          4.5)
ops.node(   104,            0,            9,            0)
ops.node(   105,            0,            9,       0.9375)
ops.node(   106,            0,            9,        1.875)
ops.node(   107,            0,           16,         10.5)
ops.node(   108,            4,           20,         10.5)
ops.node(   109,            6,           20,          9.5)
ops.node(   110,            9,           15,          4.5)
ops.node(   111,            6,           14,          7.5)
ops.node(   112,            0,            9,       2.8125)
ops.node(   113,            7,           15,          7.5)
ops.node(   114,            6,           15,          8.5)
ops.node(   115,            0,            9,         3.75)
ops.node(   116,            0,           15,         10.5)
ops.node(   117,            5,           20,         10.5)
ops.node(   118,            1,           15,         10.5)
ops.node(   119,            9,           20,          7.5)
ops.node(   120,            6,           11,          4.5)
ops.node(   121,            0,           11,          7.5)
ops.node(   122,            2,           15,         10.5)
ops.node(   123,            0,            9,          4.5)
ops.node(   124,            6,           13,          7.5)
ops.node(   125,           11,           20,          4.5)
ops.node(   126,            1,            9,          4.5)
ops.node(   127,            0,            9,       4.6875)
ops.node(   128,           12,           20,            0)
ops.node(   129,            3,           15,         10.5)
ops.node(   130,           12,           20,          0.9)
ops.node(   131,            2,            9,          4.5)
ops.node(   132,            8,           15,          7.5)
ops.node(   133,           10,           15,          4.5)
ops.node(   134,            6,           20,         10.5)
ops.node(   135,            0,           14,         10.5)
ops.node(   136,           12,           20,          1.8)
ops.node(   137,            6,           19,         10.5)
ops.node(   138,            6,           18,         10.5)
ops.node(   139,            3,            9,          4.5)
ops.node(   140,            4,           15,         10.5)
ops.node(   141,            6,           15,          9.5)
ops.node(   142,           12,           20,          2.7)
ops.node(   143,            0,            9,        5.625)
ops.node(   144,            6,           17,         10.5)
ops.node(   145,            6,           10,          4.5)
ops.node(   146,            0,           10,          7.5)
ops.node(   147,            6,           12,          7.5)
ops.node(   148,           10,           20,          7.5)
ops.node(   149,           12,           20,          3.6)
ops.node(   150,            6,            9,            0)
ops.node(   151,            4,            9,          4.5)
ops.node(   152,            6,            9,       0.9375)
ops.node(   153,            7,           20,         10.5)
ops.node(   154,            0,           13,         10.5)
ops.node(   155,            5,           15,         10.5)
ops.node(   156,            6,            9,        1.875)
ops.node(   157,            9,           15,          7.5)
ops.node(   158,            6,           16,         10.5)
ops.node(   159,            0,            9,       6.5625)
ops.node(   160,            0,            8,          4.5)
ops.node(   161,           12,           20,          4.5)
ops.node(   162,            6,            9,       2.8125)
ops.node(   163,           12,           19,          4.5)
ops.node(   164,            5,            9,          4.5)
ops.node(   165,           11,           15,          4.5)
ops.node(   166,           12,           18,          4.5)
ops.node(   167,           12,           15,            0)
ops.node(   168,           12,           15,          0.9)
ops.node(   169,            6,            9,         3.75)
ops.node(   170,            6,           15,         10.5)
ops.node(   171,           12,           15,          1.8)
ops.node(   172,            6,           11,          7.5)
ops.node(   173,           12,           17,          4.5)
ops.node(   174,            8,           20,         10.5)
ops.node(   175,            0,           12,         10.5)
ops.node(   176,           12,           20,          5.5)
ops.node(   177,           12,           15,          2.7)
ops.node(   178,           11,           20,          7.5)
ops.node(   179,            0,            9,          7.5)
ops.node(   180,            6,            9,          4.5)
ops.node(   181,            1,            9,          7.5)
ops.node(   182,            6,            9,       4.6875)
ops.node(   183,           12,           16,          4.5)
ops.node(   184,            2,            9,          7.5)
ops.node(   185,           10,           15,          7.5)
ops.node(   186,           12,           15,          3.6)
ops.node(   187,            6,           14,         10.5)
ops.node(   188,            7,           15,         10.5)
ops.node(   189,           12,           20,          6.5)
ops.node(   190,            3,            9,          7.5)
ops.node(   191,            6,            9,        5.625)
ops.node(   192,           13,           20,          4.5)
ops.node(   193,           12,           15,          4.5)
ops.node(   194,            0,            7,          4.5)
ops.node(   195,            7,            9,          4.5)
ops.node(   196,            0,           11,         10.5)
ops.node(   197,            9,           20,         10.5)
ops.node(   198,            6,           10,          7.5)
ops.node(   199,            4,            9,          7.5)
ops.node(   200,            0,            9,          8.5)
ops.node(   201,            6,           13,         10.5)
ops.node(   202,           12,           15,          5.5)
ops.node(   203,            8,           15,         10.5)
ops.node(   204,            6,            9,       6.5625)
ops.node(   205,            0,            8,          7.5)
ops.node(   206,            6,            8,          4.5)
ops.node(   207,           12,           20,          7.5)
ops.node(   208,           12,           14,          4.5)
ops.node(   209,           12,           19,          7.5)
ops.node(   210,            9,           10,          4.5)
ops.node(   211,            5,            9,          7.5)
ops.node(   212,           11,           15,          7.5)
ops.node(   213,           12,           18,          7.5)
ops.node(   214,            8,            9,          4.5)
ops.node(   215,           12,           17,          7.5)
ops.node(   216,            6,           12,         10.5)
ops.node(   217,            0,           10,         10.5)
ops.node(   218,           10,           20,         10.5)
ops.node(   219,            0,            9,          9.5)
ops.node(   220,           12,           15,          6.5)
ops.node(   221,           12,           13,          4.5)
ops.node(   222,            6,            9,          7.5)
ops.node(   223,           13,           15,          4.5)
ops.node(   224,           12,           20,          8.5)
ops.node(   225,           14,           20,          4.5)
ops.node(   226,            0,            6,          4.5)
ops.node(   227,            9,           15,         10.5)
ops.node(   228,           12,           16,          7.5)
ops.node(   229,            9,            9,          4.5)
ops.node(   230,           13,           20,          7.5)
ops.node(   231,            6,            7,          4.5)
ops.node(   232,           12,           15,          7.5)
ops.node(   233,            0,            7,          7.5)
ops.node(   234,            7,            9,          7.5)
ops.node(   235,            6,           11,         10.5)
ops.node(   236,           12,           12,          4.5)
ops.node(   237,            6,            9,          8.5)
ops.node(   238,            0,            9,         10.5)
ops.node(   239,           11,           20,         10.5)
ops.node(   240,            1,            9,         10.5)
ops.node(   241,           12,           20,          9.5)
ops.node(   242,           10,           15,         10.5)
ops.node(   243,            2,            9,         10.5)
ops.node(   244,            6,            8,          7.5)
ops.node(   245,           12,           14,          7.5)
ops.node(   246,            9,           10,          7.5)
ops.node(   247,            3,            9,         10.5)
ops.node(   248,           14,           15,          4.5)
ops.node(   249,           12,           15,          8.5)
ops.node(   250,           10,            9,          4.5)
ops.node(   251,            8,            9,          7.5)
ops.node(   252,           12,           11,          4.5)
ops.node(   253,           15,           20,          4.5)
ops.node(   254,            0,            5,          4.5)
ops.node(   255,            6,           10,         10.5)
ops.node(   256,            4,            9,         10.5)
ops.node(   257,            6,            9,          9.5)
ops.node(   258,           12,           13,          7.5)
ops.node(   259,           13,           15,          7.5)
ops.node(   260,            0,            6,          7.5)
ops.node(   261,           14,           20,          7.5)
ops.node(   262,            6,            6,          4.5)
ops.node(   263,           12,           20,         10.5)
ops.node(   264,            0,            8,         10.5)
ops.node(   265,           12,           19,         10.5)
ops.node(   266,            0,            4,            0)
ops.node(   267,            5,            9,         10.5)
ops.node(   268,           11,           15,         10.5)
ops.node(   269,            0,            4,          0.9)
ops.node(   270,            9,            9,          7.5)
ops.node(   271,           12,           18,         10.5)
ops.node(   272,            0,            4,          1.8)
ops.node(   273,           12,           15,          9.5)
ops.node(   274,            6,            7,          7.5)
ops.node(   275,           11,            9,          4.5)
ops.node(   276,           12,           17,         10.5)
ops.node(   277,            0,            4,          2.7)
ops.node(   278,           12,           10,          4.5)
ops.node(   279,           12,           12,          7.5)
ops.node(   280,           12,            9,            0)
ops.node(   281,           12,            9,       0.9375)
ops.node(   282,            6,            9,         10.5)
ops.node(   283,           12,            9,        1.875)
ops.node(   284,            0,            4,          3.6)
ops.node(   285,           12,           16,         10.5)
ops.node(   286,           15,           15,          4.5)
ops.node(   287,           12,            9,       2.8125)
ops.node(   288,           16,           20,          4.5)
ops.node(   289,            0,            4,          4.5)
ops.node(   290,           10,            9,          7.5)
ops.node(   291,            1,            4,          4.5)
ops.node(   292,           14,           15,          7.5)
ops.node(   293,           12,            9,         3.75)
ops.node(   294,           12,           15,         10.5)
ops.node(   295,            0,            7,         10.5)
ops.node(   296,           13,           20,         10.5)
ops.node(   297,            2,            4,          4.5)
ops.node(   298,            7,            9,         10.5)
ops.node(   299,           15,           20,          7.5)
ops.node(   300,           12,           11,          7.5)
ops.node(   301,            0,            5,          7.5)
ops.node(   302,            6,            5,          4.5)
ops.node(   303,           12,            9,          4.5)
ops.node(   304,            3,            4,          4.5)
ops.node(   305,            0,            4,          5.5)
ops.node(   306,           12,            9,       4.6875)
ops.node(   307,            6,            6,          7.5)
ops.node(   308,           12,           14,         10.5)
ops.node(   309,            6,            8,         10.5)
ops.node(   310,            9,           10,         10.5)
ops.node(   311,            6,            4,            0)
ops.node(   312,            4,            4,          4.5)
ops.node(   313,            6,            4,          0.9)
ops.node(   314,            6,            4,          1.8)
ops.node(   315,            8,            9,         10.5)
ops.node(   316,           12,            9,        5.625)
ops.node(   317,           11,            9,          7.5)
ops.node(   318,            0,            4,          6.5)
ops.node(   319,            6,            4,          2.7)
ops.node(   320,           12,           10,          7.5)
ops.node(   321,            5,            4,          4.5)
ops.node(   322,           16,           15,          4.5)
ops.node(   323,           12,           13,         10.5)
ops.node(   324,           13,           15,         10.5)
ops.node(   325,            6,            4,          3.6)
ops.node(   326,           15,           15,          7.5)
ops.node(   327,           14,           20,         10.5)
ops.node(   328,            0,            6,         10.5)
ops.node(   329,           12,            9,       6.5625)
ops.node(   330,           12,            8,          4.5)
ops.node(   331,           17,           20,          4.5)
ops.node(   332,            0,            3,          4.5)
ops.node(   333,           13,            9,          4.5)
ops.node(   334,            6,            4,          4.5)
ops.node(   335,            9,            9,         10.5)
ops.node(   336,            0,            4,          7.5)
ops.node(   337,           16,           20,          7.5)
ops.node(   338,            1,            4,          7.5)
ops.node(   339,            6,            7,         10.5)
ops.node(   340,            2,            4,          7.5)
ops.node(   341,            6,            5,          7.5)
ops.node(   342,           12,           12,         10.5)
ops.node(   343,           12,            9,          7.5)
ops.node(   344,            3,            4,          7.5)
ops.node(   345,            6,            4,          5.5)
ops.node(   346,           18,           20,            0)
ops.node(   347,           18,           20,          0.9)
ops.node(   348,            7,            4,          4.5)
ops.node(   349,           18,           20,          1.8)
ops.node(   350,            0,            4,          8.5)
ops.node(   351,            4,            4,          7.5)
ops.node(   352,           14,           15,         10.5)
ops.node(   353,           10,            9,         10.5)
ops.node(   354,           18,           20,          2.7)
ops.node(   355,           12,            7,          4.5)
ops.node(   356,            6,            4,          6.5)
ops.node(   357,           17,           15,          4.5)
ops.node(   358,           15,           20,         10.5)
ops.node(   359,           12,           11,         10.5)
ops.node(   360,            0,            5,         10.5)
ops.node(   361,           18,           20,          3.6)
ops.node(   362,            5,            4,          7.5)
ops.node(   363,           14,            9,          4.5)
ops.node(   364,           12,            9,          8.5)
ops.node(   365,           16,           15,          7.5)
ops.node(   366,            8,            4,          4.5)
ops.node(   367,            6,            6,         10.5)
ops.node(   368,           12,            8,          7.5)
ops.node(   369,           18,           20,          4.5)
ops.node(   370,            0,            2,          4.5)
ops.node(   371,            0,            3,          7.5)
ops.node(   372,           18,           19,          4.5)
ops.node(   373,           17,           20,          7.5)
ops.node(   374,            6,            3,          4.5)
ops.node(   375,           13,            9,          7.5)
ops.node(   376,            0,            4,          9.5)
ops.node(   377,            6,            4,          7.5)
ops.node(   378,           18,           18,          4.5)
ops.node(   379,           18,           15,            0)
ops.node(   380,           18,           15,          0.9)
ops.node(   381,           18,           15,          1.8)
ops.node(   382,           11,            9,         10.5)
ops.node(   383,           18,           17,          4.5)
ops.node(   384,           12,           10,         10.5)
ops.node(   385,           18,           20,          5.5)
ops.node(   386,           12,            9,          9.5)
ops.node(   387,           18,           15,          2.7)
ops.node(   388,            9,            4,          4.5)
ops.node(   389,           12,            6,          4.5)
ops.node(   390,           15,           15,         10.5)
ops.node(   391,           18,           16,          4.5)
ops.node(   392,            7,            4,          7.5)
ops.node(   393,           18,           15,          3.6)
ops.node(   394,            6,            4,          8.5)
ops.node(   395,           18,           20,          6.5)
ops.node(   396,            0,            4,         10.5)
ops.node(   397,           15,            9,          4.5)
ops.node(   398,           16,           20,         10.5)
ops.node(   399,            1,            4,         10.5)
ops.node(   400,           18,           15,          4.5)
ops.node(   401,           12,            7,          7.5)
ops.node(   402,            2,            4,         10.5)
ops.node(   403,           17,           15,          7.5)
ops.node(   404,            6,            5,         10.5)
ops.node(   405,           14,            9,          7.5)
ops.node(   406,            3,            4,         10.5)
ops.node(   407,           12,            9,         10.5)
ops.node(   408,           10,            4,          4.5)
ops.node(   409,            8,            4,          7.5)
ops.node(   410,           18,           15,          5.5)
ops.node(   411,           18,           20,          7.5)
ops.node(   412,           18,           14,          4.5)
ops.node(   413,            0,            2,          7.5)
ops.node(   414,            6,            2,          4.5)
ops.node(   415,            0,            1,          4.5)
ops.node(   416,           18,           19,          7.5)
ops.node(   417,            6,            3,          7.5)
ops.node(   418,            6,            4,          9.5)
ops.node(   419,            4,            4,         10.5)
ops.node(   420,           18,           18,          7.5)
ops.node(   421,           18,           17,          7.5)
ops.node(   422,           12,            5,          4.5)
ops.node(   423,           18,           15,          6.5)
ops.node(   424,            5,            4,         10.5)
ops.node(   425,           16,           15,         10.5)
ops.node(   426,            9,            4,          7.5)
ops.node(   427,           18,           13,          4.5)
ops.node(   428,           18,           20,          8.5)
ops.node(   429,           12,            6,          7.5)
ops.node(   430,           18,           16,          7.5)
ops.node(   431,           16,            9,          4.5)
ops.node(   432,           11,            4,          4.5)
ops.node(   433,           12,            8,         10.5)
ops.node(   434,           17,           20,         10.5)
ops.node(   435,            0,            3,         10.5)
ops.node(   436,           12,            4,            0)
ops.node(   437,            0,            0,            0)
ops.node(   438,           13,            9,         10.5)
ops.node(   439,            0,            0,          0.9)
ops.node(   440,           12,            4,          0.9)
ops.node(   441,           15,            9,          7.5)
ops.node(   442,            6,            4,         10.5)
ops.node(   443,            0,            0,          1.8)
ops.node(   444,           12,            4,          1.8)
ops.node(   445,           18,           15,          7.5)
ops.node(   446,            0,            0,          2.7)
ops.node(   447,           12,            4,          2.7)
ops.node(   448,           18,           12,          4.5)
ops.node(   449,           10,            4,          7.5)
ops.node(   450,           12,            4,          3.6)
ops.node(   451,            0,            0,          3.6)
ops.node(   452,           18,           20,          9.5)
ops.node(   453,            7,            4,         10.5)
ops.node(   454,           18,           14,          7.5)
ops.node(   455,            6,            2,          7.5)
ops.node(   456,            6,            1,          4.5)
ops.node(   457,            0,            1,          7.5)
ops.node(   458,            0,            0,          4.5)
ops.node(   459,           12,            4,          4.5)
ops.node(   460,           18,           15,          8.5)
ops.node(   461,            1,            0,          4.5)
ops.node(   462,           12,            7,         10.5)
ops.node(   463,            2,            0,          4.5)
ops.node(   464,           17,           15,         10.5)
ops.node(   465,           18,           11,          4.5)
ops.node(   466,           12,            5,          7.5)
ops.node(   467,           14,            9,         10.5)
ops.node(   468,            3,            0,          4.5)
ops.node(   469,           18,           13,          7.5)
ops.node(   470,           17,            9,          4.5)
ops.node(   471,           12,            4,          5.5)
ops.node(   472,            8,            4,         10.5)
ops.node(   473,            0,            0,          5.5)
ops.node(   474,           11,            4,          7.5)
ops.node(   475,           16,            9,          7.5)
ops.node(   476,           18,           20,         10.5)
ops.node(   477,            0,            2,         10.5)
ops.node(   478,            6,            3,         10.5)
ops.node(   479,           18,           19,         10.5)
ops.node(   480,            6,            0,            0)
ops.node(   481,            4,            0,          4.5)
ops.node(   482,            6,            0,          0.9)
ops.node(   483,           18,           18,         10.5)
ops.node(   484,            6,            0,          1.8)
ops.node(   485,           18,           15,          9.5)
ops.node(   486,           12,            4,          6.5)
ops.node(   487,            0,            0,          6.5)
ops.node(   488,           18,           17,         10.5)
ops.node(   489,            6,            0,          2.7)
ops.node(   490,           18,           10,          4.5)
ops.node(   491,           18,           12,          7.5)
ops.node(   492,           18,            9,            0)
ops.node(   493,           13,            4,          4.5)
ops.node(   494,            5,            0,          4.5)
ops.node(   495,           18,            9,       0.9375)
ops.node(   496,            9,            4,         10.5)
ops.node(   497,           18,            9,        1.875)
ops.node(   498,            6,            0,          3.6)
ops.node(   499,           18,           16,         10.5)
ops.node(   500,           12,            6,         10.5)
ops.node(   501,           18,            9,       2.8125)
ops.node(   502,            6,            1,          7.5)
ops.node(   503,           12,            3,          4.5)
ops.node(   504,            6,            0,          4.5)
ops.node(   505,            0,            0,          7.5)
ops.node(   506,           15,            9,         10.5)
ops.node(   507,           12,            4,          7.5)
ops.node(   508,            1,            0,          7.5)
ops.node(   509,           18,            9,         3.75)
ops.node(   510,           18,           15,         10.5)
ops.node(   511,            2,            0,          7.5)
ops.node(   512,           18,           11,          7.5)
ops.node(   513,            3,            0,          7.5)
ops.node(   514,           18,            9,          4.5)
ops.node(   515,            6,            0,          5.5)
ops.node(   516,           10,            4,         10.5)
ops.node(   517,           17,            9,          7.5)
ops.node(   518,           18,            9,       4.6875)
ops.node(   519,            7,            0,          4.5)
ops.node(   520,           18,           14,         10.5)
ops.node(   521,            6,            2,         10.5)
ops.node(   522,            0,            1,         10.5)
ops.node(   523,           14,            4,          4.5)
ops.node(   524,            0,            0,          8.5)
ops.node(   525,            4,            0,          7.5)
ops.node(   526,           12,            4,          8.5)
ops.node(   527,           18,            9,        5.625)
ops.node(   528,            6,            0,          6.5)
ops.node(   529,           12,            5,         10.5)
ops.node(   530,           18,           10,          7.5)
ops.node(   531,           13,            4,          7.5)
ops.node(   532,            5,            0,          7.5)
ops.node(   533,           18,           13,         10.5)
ops.node(   534,            8,            0,          4.5)
ops.node(   535,           11,            4,         10.5)
ops.node(   536,           16,            9,         10.5)
ops.node(   537,           18,            9,       6.5625)
ops.node(   538,           18,            8,          4.5)
ops.node(   539,           12,            2,          4.5)
ops.node(   540,           12,            3,          7.5)
ops.node(   541,            0,            0,          9.5)
ops.node(   542,           12,            4,          9.5)
ops.node(   543,            6,            0,          7.5)
ops.node(   544,           18,           12,         10.5)
ops.node(   545,            9,            0,          4.5)
ops.node(   546,           18,            9,          7.5)
ops.node(   547,           15,            4,          4.5)
ops.node(   548,            7,            0,          7.5)
ops.node(   549,            6,            1,         10.5)
ops.node(   550,            6,            0,          8.5)
ops.node(   551,           14,            4,          7.5)
ops.node(   552,           12,            4,         10.5)
ops.node(   553,            0,            0,         10.5)
ops.node(   554,            1,            0,         10.5)
ops.node(   555,           18,            7,          4.5)
ops.node(   556,            2,            0,         10.5)
ops.node(   557,           18,           11,         10.5)
ops.node(   558,           18,            9,          8.5)
ops.node(   559,            3,            0,         10.5)
ops.node(   560,           10,            0,          4.5)
ops.node(   561,           17,            9,         10.5)
ops.node(   562,            8,            0,          7.5)
ops.node(   563,           12,            2,          7.5)
ops.node(   564,           18,            8,          7.5)
ops.node(   565,           12,            1,          4.5)
ops.node(   566,            6,            0,          9.5)
ops.node(   567,            4,            0,         10.5)
ops.node(   568,           16,            4,          4.5)
ops.node(   569,           18,           10,         10.5)
ops.node(   570,            5,            0,         10.5)
ops.node(   571,           13,            4,         10.5)
ops.node(   572,           18,            9,          9.5)
ops.node(   573,            9,            0,          7.5)
ops.node(   574,           15,            4,          7.5)
ops.node(   575,           18,            6,          4.5)
ops.node(   576,           11,            0,          4.5)
ops.node(   577,           12,            3,         10.5)
ops.node(   578,           12,            0,            0)
ops.node(   579,           12,            0,          0.9)
ops.node(   580,            6,            0,         10.5)
ops.node(   581,           12,            0,          1.8)
ops.node(   582,           18,            7,          7.5)
ops.node(   583,           12,            0,          2.7)
ops.node(   584,           18,            9,         10.5)
ops.node(   585,           10,            0,          7.5)
ops.node(   586,           12,            0,          3.6)
ops.node(   587,            7,            0,         10.5)
ops.node(   588,           12,            1,          7.5)
ops.node(   589,           14,            4,         10.5)
ops.node(   590,           12,            0,          4.5)
ops.node(   591,           17,            4,          4.5)
ops.node(   592,           16,            4,          7.5)
ops.node(   593,           18,            5,          4.5)
ops.node(   594,            8,            0,         10.5)
ops.node(   595,           12,            0,          5.5)
ops.node(   596,           18,            6,          7.5)
ops.node(   597,           11,            0,          7.5)
ops.node(   598,           12,            2,         10.5)
ops.node(   599,           18,            8,         10.5)
ops.node(   600,           18,            4,            0)
ops.node(   601,           18,            4,          0.9)
ops.node(   602,           18,            4,          1.8)
ops.node(   603,           12,            0,          6.5)
ops.node(   604,           18,            4,          2.7)
ops.node(   605,           13,            0,          4.5)
ops.node(   606,           15,            4,         10.5)
ops.node(   607,            9,            0,         10.5)
ops.node(   608,           18,            4,          3.6)
ops.node(   609,           18,            4,          4.5)
ops.node(   610,           12,            0,          7.5)
ops.node(   611,           17,            4,          7.5)
ops.node(   612,           18,            7,         10.5)
ops.node(   613,           18,            5,          7.5)
ops.node(   614,           18,            4,          5.5)
ops.node(   615,           10,            0,         10.5)
ops.node(   616,           12,            1,         10.5)
ops.node(   617,           14,            0,          4.5)
ops.node(   618,           12,            0,          8.5)
ops.node(   619,           18,            4,          6.5)
ops.node(   620,           16,            4,         10.5)
ops.node(   621,           13,            0,          7.5)
ops.node(   622,           18,            6,         10.5)
ops.node(   623,           11,            0,         10.5)
ops.node(   624,           18,            3,          4.5)
ops.node(   625,           12,            0,          9.5)
ops.node(   626,           18,            4,          7.5)
ops.node(   627,           15,            0,          4.5)
ops.node(   628,           14,            0,          7.5)
ops.node(   629,           18,            4,          8.5)
ops.node(   630,           12,            0,         10.5)
ops.node(   631,           17,            4,         10.5)
ops.node(   632,           18,            5,         10.5)
ops.node(   633,           18,            2,          4.5)
ops.node(   634,           18,            3,          7.5)
ops.node(   635,           18,            4,          9.5)
ops.node(   636,           16,            0,          4.5)
ops.node(   637,           13,            0,         10.5)
ops.node(   638,           15,            0,          7.5)
ops.node(   639,           18,            4,         10.5)
ops.node(   640,           18,            2,          7.5)
ops.node(   641,           18,            1,          4.5)
ops.node(   642,           14,            0,         10.5)
ops.node(   643,           17,            0,          4.5)
ops.node(   644,           16,            0,          7.5)
ops.node(   645,           18,            3,         10.5)
ops.node(   646,           18,            0,            0)
ops.node(   647,           18,            0,          0.9)
ops.node(   648,           18,            0,          1.8)
ops.node(   649,           18,            0,          2.7)
ops.node(   650,           15,            0,         10.5)
ops.node(   651,           18,            0,          3.6)
ops.node(   652,           18,            1,          7.5)
ops.node(   653,           18,            0,          4.5)
ops.node(   654,           17,            0,          7.5)
ops.node(   655,           18,            0,          5.5)
ops.node(   656,           18,            2,         10.5)
ops.node(   657,           18,            0,          6.5)
ops.node(   658,           16,            0,         10.5)
ops.node(   659,           18,            0,          7.5)
ops.node(   660,           18,            1,         10.5)
ops.node(   661,           18,            0,          8.5)
ops.node(   662,           17,            0,         10.5)
ops.node(   663,           18,            0,          9.5)
ops.node(   664,           18,            0,         10.5)

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl z-transl x-rot y-rot z-rot

ops.fix(     1,   1,   1,   1,   1,   1,   1)
ops.fix(    11,   1,   1,   1,   1,   1,   1)
ops.fix(    18,   1,   1,   1,   1,   1,   1)
ops.fix(    42,   1,   1,   1,   1,   1,   1)
ops.fix(   104,   1,   1,   1,   1,   1,   1)
ops.fix(   128,   1,   1,   1,   1,   1,   1)
ops.fix(   150,   1,   1,   1,   1,   1,   1)
ops.fix(   167,   1,   1,   1,   1,   1,   1)
ops.fix(   266,   1,   1,   1,   1,   1,   1)
ops.fix(   280,   1,   1,   1,   1,   1,   1)
ops.fix(   311,   1,   1,   1,   1,   1,   1)
ops.fix(   346,   1,   1,   1,   1,   1,   1)
ops.fix(   379,   1,   1,   1,   1,   1,   1)
ops.fix(   436,   1,   1,   1,   1,   1,   1)
ops.fix(   437,   1,   1,   1,   1,   1,   1)
ops.fix(   480,   1,   1,   1,   1,   1,   1)
ops.fix(   492,   1,   1,   1,   1,   1,   1)
ops.fix(   578,   1,   1,   1,   1,   1,   1)
ops.fix(   600,   1,   1,   1,   1,   1,   1)
ops.fix(   646,   1,   1,   1,   1,   1,   1)

# --------------------------------------------------------------------------------------------------------------
# R I G I D    D I A P H R A G M S
# --------------------------------------------------------------------------------------------------------------

# Rigid Diaphragm Definition : rigidDiaphragm $perpendicularAxis $MasterNode $SlaveNode1 $SlaveNode2 . . . .

ops.fix(   210    , 0, 0, 1, 1, 1, 0)
ops.rigidDiaphragm(     3,    210 ,6 ,7 ,8 ,9 ,10 ,14 ,15 ,19 ,20 ,26 ,27 ,28 ,30 ,31 ,33 ,35 ,38 ,41 ,43 ,46 ,52 ,53 ,54 ,57 ,63 ,65 ,66 ,72 ,75 ,79 ,81 ,84 ,89 ,101 ,102 ,103 ,110 ,120 ,123 ,125 ,126 ,131 ,133 ,139 ,145 ,151 ,160 ,161 ,163 ,164 ,165 ,166 ,173 ,180 ,183 ,192 ,193 ,194 ,195 ,206 ,208 ,214 ,221 ,223 ,225 ,226 ,229 ,231 ,236 ,248 ,250 ,252 ,253 ,254 ,262 ,275 ,278 ,286 ,288 ,289 ,291 ,297 ,302 ,303 ,304 ,312 ,321 ,322 ,330 ,331 ,332 ,333 ,334 ,348 ,355 ,357 ,363 ,366 ,369 ,370 ,372 ,374 ,378 ,383 ,388 ,389 ,391 ,397 ,400 ,408 ,412 ,414 ,415 ,422 ,427 ,431 ,432 ,448 ,456 ,458 ,459 ,461 ,463 ,465 ,468 ,470 ,481 ,490 ,493 ,494 ,503 ,504 ,514 ,519 ,523 ,534 ,538 ,539 ,545 ,547 ,555 ,560 ,565 ,568 ,575 ,576 ,590 ,591 ,593 ,605 ,609 ,617 ,624 ,627 ,633 ,636 ,641 ,643 ,653 ) # ID : 1
ops.fix(   246    , 0, 0, 1, 1, 1, 0)
ops.rigidDiaphragm(     3,    246 ,34 ,36 ,37 ,39 ,40 ,47 ,48 ,55 ,58 ,61 ,62 ,64 ,67 ,68 ,71 ,73 ,74 ,76 ,77 ,80 ,83 ,85 ,86 ,87 ,96 ,99 ,100 ,111 ,113 ,119 ,121 ,124 ,132 ,146 ,147 ,148 ,157 ,172 ,178 ,179 ,181 ,184 ,185 ,190 ,198 ,199 ,205 ,207 ,209 ,211 ,212 ,213 ,215 ,222 ,228 ,230 ,232 ,233 ,234 ,244 ,245 ,251 ,258 ,259 ,260 ,261 ,270 ,274 ,279 ,290 ,292 ,299 ,300 ,301 ,307 ,317 ,320 ,326 ,336 ,337 ,338 ,340 ,341 ,343 ,344 ,351 ,362 ,365 ,368 ,371 ,373 ,375 ,377 ,392 ,401 ,403 ,405 ,409 ,411 ,413 ,416 ,417 ,420 ,421 ,426 ,429 ,430 ,441 ,445 ,449 ,454 ,455 ,457 ,466 ,469 ,474 ,475 ,491 ,502 ,505 ,507 ,508 ,511 ,512 ,513 ,517 ,525 ,530 ,531 ,532 ,540 ,543 ,546 ,548 ,551 ,562 ,563 ,564 ,573 ,574 ,582 ,585 ,588 ,592 ,596 ,597 ,610 ,611 ,613 ,621 ,626 ,628 ,634 ,638 ,640 ,644 ,652 ,654 ,659 ) # ID : 2
ops.fix(   310    , 0, 0, 1, 1, 1, 0)
ops.rigidDiaphragm(     3,    310 ,90 ,91 ,92 ,93 ,94 ,97 ,98 ,107 ,108 ,116 ,117 ,118 ,122 ,129 ,134 ,135 ,137 ,138 ,140 ,144 ,153 ,154 ,155 ,158 ,170 ,174 ,175 ,187 ,188 ,196 ,197 ,201 ,203 ,216 ,217 ,218 ,227 ,235 ,238 ,239 ,240 ,242 ,243 ,247 ,255 ,256 ,263 ,264 ,265 ,267 ,268 ,271 ,276 ,282 ,285 ,294 ,295 ,296 ,298 ,308 ,309 ,315 ,323 ,324 ,327 ,328 ,335 ,339 ,342 ,352 ,353 ,358 ,359 ,360 ,367 ,382 ,384 ,390 ,396 ,398 ,399 ,402 ,404 ,406 ,407 ,419 ,424 ,425 ,433 ,434 ,435 ,438 ,442 ,453 ,462 ,464 ,467 ,472 ,476 ,477 ,478 ,479 ,483 ,488 ,496 ,499 ,500 ,506 ,510 ,516 ,520 ,521 ,522 ,529 ,533 ,535 ,536 ,544 ,549 ,552 ,553 ,554 ,556 ,557 ,559 ,561 ,567 ,569 ,570 ,571 ,577 ,580 ,584 ,587 ,589 ,594 ,598 ,599 ,606 ,607 ,612 ,615 ,616 ,620 ,622 ,623 ,630 ,631 ,632 ,637 ,639 ,642 ,645 ,650 ,656 ,658 ,660 ,662 ,664 ) # ID : 3

# --------------------------------------------------------------------------------------------------------------
# M A S S E S
# --------------------------------------------------------------------------------------------------------------

# Mass Definition : mass $NodeTag $(ndf nodal mass values corresponding to each DOF)

ops.mass(   210,       20,       25,        0,        0,        0,       10)
ops.mass(   246,       20,       25,        0,        0,        0,       10)
ops.mass(   310,       20,       25,        0,        0,        0,       10)

# --------------------------------------------------------------------------------------------------------------
# E L A S T I C   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# Geometric Transformation

ops.geomTransf('Linear', 1, -1, 0, 0) # vertical
ops.geomTransf('Linear', 2,  0, 0, 1) # non-vertical
ops.geomTransf('PDelta', 3, -1, 0, 0) # vertical
ops.geomTransf('PDelta', 4,  0, 0, 1) # non-vertical
ops.geomTransf('Corotational', 5, -1, 0, 0) # vertical
ops.geomTransf('Corotational', 6,  0, 0, 1) # non-vertical

# Elastic Beam Column Definition

# element elasticBeamColumn $eleTag $iNode $jNode $A $E $G $J $Iy $Iz $transfTag <-mass $MassPerUnitLength>

ops.element('elasticBeamColumn',      1,    437,     439,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      2,    439,     443,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      3,    443,     446,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      4,    446,     451,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      5,    451,     458,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      6,    458,     473,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      7,    473,     487,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      8,    487,     505,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',      9,    505,     524,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     10,    524,     541,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     11,    541,     553,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     12,    553, 522,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     13,    522, 477,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     14,    477, 435,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     15,    435, 396,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     16,    396,     376,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     17,    376,     350,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     18,    350,     336,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     19,    336,     318,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     20,    318,     305,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     21,    305,     289,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     22,    289,     284,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     23,    284,     277,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     24,    277,     272,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     25,    272,     269,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     26,    269,     266,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     27,    396, 360,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     28,    360, 328,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     29,    328, 295,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     30,    295, 264,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     31,    264, 238,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     32,    238,     219,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     33,    219,     200,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     34,    200,     179,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     35,    179,     159,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     36,    159,     143,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     37,    143,     127,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     38,    127,     115,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     39,    115,     112,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     40,    112,     106,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     41,    106,     105,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     42,    105,     104,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     43,    238, 217,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     44,    217, 196,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     45,    196, 175,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     46,    175, 154,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     47,    154, 135,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     48,    135, 116,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     49,    116,      95,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     50,     95,      78,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     51,     78,      62,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     52,     62,      50,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     53,     50,      32,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     54,     32,      27,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     55,     27,      22,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     56,     22,      17,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     57,     17,      13,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     58,     13,      12,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     59,     12,      11,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     60,    116, 107,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     61,    107, 97,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     62,     97, 94,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     63,     94, 92,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     64,     92, 90,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     65,     90,      69,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     66,     69,      56,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     67,     56,      34,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     68,     34,      24,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     69,     24,      16,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     70,     16,       6,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     71,      6,       5,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     72,      5,       4,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     73,      4,       3,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     74,      3,       2,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     75,      2,       1,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',     76,    458, 415,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     77,    415, 370,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     78,    370, 332,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     79,    332, 289,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     80,    289, 254,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     81,    254, 226,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     82,    226, 194,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     83,    194, 160,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     84,    160, 123,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     85,    123, 101,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     86,    101, 81,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     87,     81, 65,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     88,     65, 52,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     89,     52, 35,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     90,     35, 27,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     91,     27, 19,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     92,     19, 14,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     93,     14, 9,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     94,      9, 8,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     95,      8, 6,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     96,    505, 457,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     97,    457, 413,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     98,    413, 371,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',     99,    371, 336,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    100,    336, 301,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    101,    301, 260,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    102,    260, 233,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    103,    233, 205,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    104,    205, 179,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    105,    179, 146,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    106,    146, 121,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    107,    121, 100,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    108,    100, 83,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    109,     83, 71,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    110,     71, 62,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    111,     62, 55,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    112,     55, 47,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    113,     47, 39,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    114,     39, 37,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    115,     37, 34,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    116,    480,     482,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    117,    482,     484,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    118,    484,     489,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    119,    489,     498,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    120,    498,     504,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    121,    504,     515,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    122,    515,     528,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    123,    528,     543,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    124,    543,     550,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    125,    550,     566,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    126,    566,     580,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    127,    580, 549,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    128,    549, 521,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    129,    521, 478,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    130,    478, 442,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    131,    442,     418,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    132,    418,     394,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    133,    394,     377,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    134,    377,     356,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    135,    356,     345,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    136,    345,     334,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    137,    334,     325,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    138,    325,     319,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    139,    319,     314,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    140,    314,     313,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    141,    313,     311,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    142,    442, 404,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    143,    404, 367,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    144,    367, 339,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    145,    339, 309,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    146,    309, 282,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    147,    282,     257,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    148,    257,     237,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    149,    237,     222,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    150,    222,     204,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    151,    204,     191,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    152,    191,     182,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    153,    182,     169,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    154,    169,     162,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    155,    162,     156,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    156,    156,     152,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    157,    152,     150,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    158,    282, 255,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    159,    255, 235,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    160,    235, 216,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    161,    216, 201,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    162,    201, 187,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    163,    187, 170,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    164,    170,     141,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    165,    141,     114,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    166,    114,      96,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    167,     96,      82,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    168,     82,      70,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    169,     70,      63,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    170,     63,      59,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    171,     59,      51,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    172,     51,      45,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    173,     45,      44,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    174,     44,      42,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    175,    170, 158,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    176,    158, 144,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    177,    144, 138,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    178,    138, 137,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    179,    137, 134,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    180,    134,     109,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    181,    109,      88,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    182,     88,      73,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    183,     73,      60,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    184,     60,      49,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    185,     49,      33,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    186,     33,      29,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    187,     29,      25,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    188,     25,      23,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    189,     23,      21,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    190,     21,      18,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    191,    504, 456,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    192,    456, 414,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    193,    414, 374,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    194,    374, 334,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    195,    334, 302,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    196,    302, 262,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    197,    262, 231,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    198,    231, 206,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    199,    206, 180,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    200,    180, 145,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    201,    145, 120,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    202,    120, 103,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    203,    103, 84,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    204,     84, 72,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    205,     72, 63,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    206,     63, 57,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    207,     57, 46,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    208,     46, 41,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    209,     41, 38,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    210,     38, 33,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    211,    543, 502,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    212,    502, 455,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    213,    455, 417,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    214,    417, 377,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    215,    377, 341,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    216,    341, 307,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    217,    307, 274,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    218,    274, 244,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    219,    244, 222,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    220,    222, 198,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    221,    198, 172,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    222,    172, 147,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    223,    147, 124,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    224,    124, 111,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    225,    111, 96,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    226,     96, 87,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    227,     87, 80,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    228,     80, 76,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    229,     76, 74,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    230,     74, 73,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    231,      6, 7,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    232,      7, 10,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    233,     10, 15,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    234,     15, 20,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    235,     20, 26,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    236,     26, 33,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    237,     27, 28,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    238,     28, 30,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    239,     30, 31,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    240,     31, 43,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    241,     43, 54,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    242,     54, 63,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    243,    123, 126,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    244,    126, 131,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    245,    131, 139,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    246,    139, 151,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    247,    151, 164,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    248,    164, 180,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    249,    289, 291,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    250,    291, 297,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    251,    297, 304,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    252,    304, 312,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    253,    312, 321,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    254,    321, 334,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    255,    458, 461,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    256,    461, 463,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    257,    463, 468,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    258,    468, 481,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    259,    481, 494,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    260,    494, 504,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    261,    505, 508,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    262,    508, 511,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    263,    511, 513,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    264,    513, 525,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    265,    525, 532,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    266,    532, 543,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    267,    336, 338,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    268,    338, 340,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    269,    340, 344,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    270,    344, 351,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    271,    351, 362,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    272,    362, 377,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    273,    179, 181,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    274,    181, 184,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    275,    184, 190,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    276,    190, 199,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    277,    199, 211,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    278,    211, 222,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    279,     62, 64,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    280,     64, 67,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    281,     67, 68,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    282,     68, 77,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    283,     77, 86,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    284,     86, 96,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    285,     34, 36,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    286,     36, 40,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    287,     40, 48,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    288,     48, 58,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    289,     58, 61,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    290,     61, 73,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    291,     90, 91,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    292,     91, 93,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    293,     93, 98,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    294,     98, 108,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    295,    108, 117,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    296,    117, 134,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    297,    116, 118,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    298,    118, 122,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    299,    122, 129,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    300,    129, 140,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    301,    140, 155,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    302,    155, 170,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    303,    238, 240,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    304,    240, 243,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    305,    243, 247,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    306,    247, 256,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    307,    256, 267,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    308,    267, 282,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    309,    396, 399,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    310,    399, 402,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    311,    402, 406,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    312,    406, 419,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    313,    419, 424,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    314,    424, 442,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    315,    553, 554,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    316,    554, 556,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    317,    556, 559,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    318,    559, 567,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    319,    567, 570,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    320,    570, 580,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    321,    578,     579,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    322,    579,     581,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    323,    581,     583,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    324,    583,     586,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    325,    586,     590,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    326,    590,     595,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    327,    595,     603,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    328,    603,     610,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    329,    610,     618,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    330,    618,     625,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    331,    625,     630,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    332,    630, 616,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    333,    616, 598,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    334,    598, 577,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    335,    577, 552,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    336,    552,     542,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    337,    542,     526,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    338,    526,     507,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    339,    507,     486,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    340,    486,     471,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    341,    471,     459,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    342,    459,     450,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    343,    450,     447,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    344,    447,     444,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    345,    444,     440,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    346,    440,     436,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    347,    552, 529,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    348,    529, 500,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    349,    500, 462,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    350,    462, 433,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    351,    433, 407,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    352,    407,     386,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    353,    386,     364,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    354,    364,     343,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    355,    343,     329,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    356,    329,     316,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    357,    316,     306,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    358,    306,     293,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    359,    293,     287,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    360,    287,     283,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    361,    283,     281,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    362,    281,     280,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    363,    407, 384,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    364,    384, 359,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    365,    359, 342,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    366,    342, 323,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    367,    323, 308,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    368,    308, 294,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    369,    294,     273,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    370,    273,     249,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    371,    249,     232,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    372,    232,     220,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    373,    220,     202,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    374,    202,     193,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    375,    193,     186,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    376,    186,     177,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    377,    177,     171,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    378,    171,     168,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    379,    168,     167,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    380,    294, 285,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    381,    285, 276,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    382,    276, 271,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    383,    271, 265,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    384,    265, 263,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    385,    263,     241,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    386,    241,     224,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    387,    224,     207,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    388,    207,     189,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    389,    189,     176,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    390,    176,     161,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    391,    161,     149,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    392,    149,     142,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    393,    142,     136,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    394,    136,     130,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    395,    130,     128,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    396,    590, 565,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    397,    565, 539,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    398,    539, 503,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    399,    503, 459,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    400,    459, 422,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    401,    422, 389,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    402,    389, 355,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    403,    355, 330,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    404,    330, 303,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    405,    303, 278,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    406,    278, 252,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    407,    252, 236,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    408,    236, 221,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    409,    221, 208,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    410,    208, 193,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    411,    193, 183,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    412,    183, 173,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    413,    173, 166,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    414,    166, 163,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    415,    163, 161,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    416,    610, 588,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    417,    588, 563,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    418,    563, 540,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    419,    540, 507,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    420,    507, 466,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    421,    466, 429,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    422,    429, 401,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    423,    401, 368,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    424,    368, 343,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    425,    343, 320,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    426,    320, 300,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    427,    300, 279,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    428,    279, 258,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    429,    258, 245,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    430,    245, 232,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    431,    232, 228,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    432,    228, 215,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    433,    215, 213,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    434,    213, 209,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    435,    209, 207,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    436,     33, 53,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    437,     53, 66,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    438,     66, 79,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    439,     79, 102,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    440,    102, 125,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    441,    125, 161,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    442,     63, 75,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    443,     75, 89,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    444,     89, 110,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    445,    110, 133,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    446,    133, 165,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    447,    165, 193,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    448,    180, 195,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    449,    195, 214,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    450,    214, 229,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    451,    229, 250,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    452,    250, 275,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    453,    275, 303,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    454,    334, 348,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    455,    348, 366,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    456,    366, 388,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    457,    388, 408,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    458,    408, 432,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    459,    432, 459,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    460,    504, 519,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    461,    519, 534,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    462,    534, 545,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    463,    545, 560,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    464,    560, 576,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    465,    576, 590,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    466,    543, 548,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    467,    548, 562,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    468,    562, 573,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    469,    573, 585,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    470,    585, 597,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    471,    597, 610,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    472,    377, 392,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    473,    392, 409,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    474,    409, 426,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    475,    426, 449,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    476,    449, 474,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    477,    474, 507,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    478,    222, 234,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    479,    234, 251,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    480,    251, 270,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    481,    270, 290,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    482,    290, 317,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    483,    317, 343,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    484,     96, 113,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    485,    113, 132,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    486,    132, 157,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    487,    157, 185,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    488,    185, 212,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    489,    212, 232,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    490,     73, 85,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    491,     85, 99,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    492,     99, 119,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    493,    119, 148,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    494,    148, 178,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    495,    178, 207,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    496,    134, 153,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    497,    153, 174,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    498,    174, 197,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    499,    197, 218,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    500,    218, 239,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    501,    239, 263,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    502,    170, 188,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    503,    188, 203,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    504,    203, 227,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    505,    227, 242,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    506,    242, 268,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    507,    268, 294,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    508,    282, 298,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    509,    298, 315,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    510,    315, 335,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    511,    335, 353,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    512,    353, 382,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    513,    382, 407,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    514,    442, 453,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    515,    453, 472,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    516,    472, 496,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    517,    496, 516,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    518,    516, 535,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    519,    535, 552,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    520,    580, 587,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    521,    587, 594,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    522,    594, 607,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    523,    607, 615,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    524,    615, 623,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    525,    623, 630,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    526,    646,     647,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    527,    647,     648,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    528,    648,     649,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    529,    649,     651,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    530,    651,     653,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    531,    653,     655,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    532,    655,     657,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    533,    657,     659,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    534,    659,     661,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    535,    661,     663,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    536,    663,     664,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    537,    664, 660,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    538,    660, 656,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    539,    656, 645,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    540,    645, 639,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    541,    639,     635,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    542,    635,     629,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    543,    629,     626,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    544,    626,     619,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    545,    619,     614,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    546,    614,     609,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    547,    609,     608,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    548,    608,     604,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    549,    604,     602,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    550,    602,     601,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    551,    601,     600,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    552,    639, 632,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    553,    632, 622,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    554,    622, 612,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    555,    612, 599,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    556,    599, 584,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    557,    584,     572,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    558,    572,     558,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    559,    558,     546,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    560,    546,     537,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    561,    537,     527,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    562,    527,     518,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    563,    518,     509,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    564,    509,     501,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    565,    501,     497,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    566,    497,     495,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    567,    495,     492,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    568,    584, 569,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    569,    569, 557,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    570,    557, 544,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    571,    544, 533,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    572,    533, 520,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    573,    520, 510,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    574,    510,     485,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    575,    485,     460,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    576,    460,     445,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    577,    445,     423,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    578,    423,     410,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    579,    410,     400,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    580,    400,     393,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    581,    393,     387,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    582,    387,     381,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    583,    381,     380,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    584,    380,     379,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    585,    510, 499,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    586,    499, 488,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    587,    488, 483,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    588,    483, 479,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    589,    479, 476,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    590,    476,     452,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    591,    452,     428,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    592,    428,     411,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    593,    411,     395,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    594,    395,     385,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    595,    385,     369,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    596,    369,     361,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    597,    361,     354,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    598,    354,     349,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    599,    349,     347,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    600,    347,     346,       0.09,      3e+07,   1.25e+07,   0.00114075,     0.000675,     0.000675   , 1, '-mass',        0) # Concrete C20/25
ops.element('elasticBeamColumn',    601,    653, 641,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    602,    641, 633,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    603,    633, 624,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    604,    624, 609,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    605,    609, 593,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    606,    593, 575,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    607,    575, 555,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    608,    555, 538,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    609,    538, 514,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    610,    514, 490,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    611,    490, 465,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    612,    465, 448,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    613,    448, 427,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    614,    427, 412,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    615,    412, 400,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    616,    400, 391,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    617,    391, 383,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    618,    383, 378,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    619,    378, 372,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    620,    372, 369,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    621,    659, 652,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    622,    652, 640,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    623,    640, 634,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    624,    634, 626,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    625,    626, 613,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    626,    613, 596,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    627,    596, 582,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    628,    582, 564,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    629,    564, 546,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    630,    546, 530,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    631,    530, 512,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    632,    512, 491,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    633,    491, 469,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    634,    469, 454,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    635,    454, 445,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    636,    445, 430,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    637,    430, 421,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    638,    421, 420,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    639,    420, 416,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    640,    416, 411,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    641,    161, 192,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    642,    192, 225,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    643,    225, 253,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    644,    253, 288,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    645,    288, 331,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    646,    331, 369,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    647,    193, 223,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    648,    223, 248,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    649,    248, 286,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    650,    286, 322,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    651,    322, 357,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    652,    357, 400,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    653,    303, 333,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    654,    333, 363,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    655,    363, 397,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    656,    397, 431,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    657,    431, 470,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    658,    470, 514,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    659,    459, 493,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    660,    493, 523,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    661,    523, 547,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    662,    547, 568,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    663,    568, 591,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    664,    591, 609,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    665,    590, 605,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    666,    605, 617,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    667,    617, 627,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    668,    627, 636,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    669,    636, 643,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    670,    643, 653,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    671,    610, 621,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    672,    621, 628,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    673,    628, 638,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    674,    638, 644,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    675,    644, 654,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    676,    654, 659,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    677,    507, 531,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    678,    531, 551,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    679,    551, 574,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    680,    574, 592,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    681,    592, 611,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    682,    611, 626,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    683,    343, 375,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    684,    375, 405,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    685,    405, 441,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    686,    441, 475,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    687,    475, 517,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    688,    517, 546,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    689,    232, 259,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    690,    259, 292,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    691,    292, 326,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    692,    326, 365,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    693,    365, 403,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    694,    403, 445,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    695,    207, 230,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    696,    230, 261,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    697,    261, 299,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    698,    299, 337,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    699,    337, 373,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    700,    373, 411,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    701,    263, 296,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    702,    296, 327,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    703,    327, 358,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    704,    358, 398,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    705,    398, 434,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    706,    434, 476,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    707,    294, 324,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    708,    324, 352,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    709,    352, 390,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    710,    390, 425,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    711,    425, 464,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    712,    464, 510,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    713,    407, 438,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    714,    438, 467,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    715,    467, 506,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    716,    506, 536,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    717,    536, 561,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    718,    561, 584,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    719,    552, 571,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    720,    571, 589,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    721,    589, 606,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    722,    606, 620,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    723,    620, 631,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    724,    631, 639,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    725,    630, 637,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    726,    637, 642,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    727,    642, 650,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    728,    650, 658,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    729,    658, 662,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25
ops.element('elasticBeamColumn',    730,    662, 664,     0.1625,      3e+07,   1.25e+07,    0.0025666,   0.00572135,  0.000846354   , 2, '-mass',        0)  # Concrete C20/25

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

ops.recorder('Node', '-file', 'Node_displacements.out', '-time', '-nodeRange', 1, 664, '-dof', 1, 2, 3, 'disp')
ops.recorder('Node', '-file', 'Node_rotations.out', '-time', '-nodeRange', 1, 664, '-dof', 4, 5, 6, 'disp')
ops.recorder('Node', '-file', 'Node_forceReactions.out', '-time', '-nodeRange', 1, 664, '-dof', 1, 2, 3, 'reaction')
ops.recorder('Node', '-file', 'Node_momentReactions.out', '-time', '-nodeRange', 1, 664, '-dof', 4, 5, 6, 'reaction')
ops.recorder('Element', '-file', 'ElasticBeamColumn_localForce.out', '-time', '-ele', 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 106 , 107 , 108 , 109 , 110 , 111 , 112 , 113 , 114 , 115 , 116 , 117 , 118 , 119 , 120 , 121 , 122 , 123 , 124 , 125 , 126 , 127 , 128 , 129 , 130 , 131 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 140 , 141 , 142 , 143 , 144 , 145 , 146 , 147 , 148 , 149 , 150 , 151 , 152 , 153 , 154 , 155 , 156 , 157 , 158 , 159 , 160 , 161 , 162 , 163 , 164 , 165 , 166 , 167 , 168 , 169 , 170 , 171 , 172 , 173 , 174 , 175 , 176 , 177 , 178 , 179 , 180 , 181 , 182 , 183 , 184 , 185 , 186 , 187 , 188 , 189 , 190 , 191 , 192 , 193 , 194 , 195 , 196 , 197 , 198 , 199 , 200 , 201 , 202 , 203 , 204 , 205 , 206 , 207 , 208 , 209 , 210 , 211 , 212 , 213 , 214 , 215 , 216 , 217 , 218 , 219 , 220 , 221 , 222 , 223 , 224 , 225 , 226 , 227 , 228 , 229 , 230 , 231 , 232 , 233 , 234 , 235 , 236 , 237 , 238 , 239 , 240 , 241 , 242 , 243 , 244 , 245 , 246 , 247 , 248 , 249 , 250 , 251 , 252 , 253 , 254 , 255 , 256 , 257 , 258 , 259 , 260 , 261 , 262 , 263 , 264 , 265 , 266 , 267 , 268 , 269 , 270 , 271 , 272 , 273 , 274 , 275 , 276 , 277 , 278 , 279 , 280 , 281 , 282 , 283 , 284 , 285 , 286 , 287 , 288 , 289 , 290 , 291 , 292 , 293 , 294 , 295 , 296 , 297 , 298 , 299 , 300 , 301 , 302 , 303 , 304 , 305 , 306 , 307 , 308 , 309 , 310 , 311 , 312 , 313 , 314 , 315 , 316 , 317 , 318 , 319 , 320 , 321 , 322 , 323 , 324 , 325 , 326 , 327 , 328 , 329 , 330 , 331 , 332 , 333 , 334 , 335 , 336 , 337 , 338 , 339 , 340 , 341 , 342 , 343 , 344 , 345 , 346 , 347 , 348 , 349 , 350 , 351 , 352 , 353 , 354 , 355 , 356 , 357 , 358 , 359 , 360 , 361 , 362 , 363 , 364 , 365 , 366 , 367 , 368 , 369 , 370 , 371 , 372 , 373 , 374 , 375 , 376 , 377 , 378 , 379 , 380 , 381 , 382 , 383 , 384 , 385 , 386 , 387 , 388 , 389 , 390 , 391 , 392 , 393 , 394 , 395 , 396 , 397 , 398 , 399 , 400 , 401 , 402 , 403 , 404 , 405 , 406 , 407 , 408 , 409 , 410 , 411 , 412 , 413 , 414 , 415 , 416 , 417 , 418 , 419 , 420 , 421 , 422 , 423 , 424 , 425 , 426 , 427 , 428 , 429 , 430 , 431 , 432 , 433 , 434 , 435 , 436 , 437 , 438 , 439 , 440 , 441 , 442 , 443 , 444 , 445 , 446 , 447 , 448 , 449 , 450 , 451 , 452 , 453 , 454 , 455 , 456 , 457 , 458 , 459 , 460 , 461 , 462 , 463 , 464 , 465 , 466 , 467 , 468 , 469 , 470 , 471 , 472 , 473 , 474 , 475 , 476 , 477 , 478 , 479 , 480 , 481 , 482 , 483 , 484 , 485 , 486 , 487 , 488 , 489 , 490 , 491 , 492 , 493 , 494 , 495 , 496 , 497 , 498 , 499 , 500 , 501 , 502 , 503 , 504 , 505 , 506 , 507 , 508 , 509 , 510 , 511 , 512 , 513 , 514 , 515 , 516 , 517 , 518 , 519 , 520 , 521 , 522 , 523 , 524 , 525 , 526 , 527 , 528 , 529 , 530 , 531 , 532 , 533 , 534 , 535 , 536 , 537 , 538 , 539 , 540 , 541 , 542 , 543 , 544 , 545 , 546 , 547 , 548 , 549 , 550 , 551 , 552 , 553 , 554 , 555 , 556 , 557 , 558 , 559 , 560 , 561 , 562 , 563 , 564 , 565 , 566 , 567 , 568 , 569 , 570 , 571 , 572 , 573 , 574 , 575 , 576 , 577 , 578 , 579 , 580 , 581 , 582 , 583 , 584 , 585 , 586 , 587 , 588 , 589 , 590 , 591 , 592 , 593 , 594 , 595 , 596 , 597 , 598 , 599 , 600 , 601 , 602 , 603 , 604 , 605 , 606 , 607 , 608 , 609 , 610 , 611 , 612 , 613 , 614 , 615 , 616 , 617 , 618 , 619 , 620 , 621 , 622 , 623 , 624 , 625 , 626 , 627 , 628 , 629 , 630 , 631 , 632 , 633 , 634 , 635 , 636 , 637 , 638 , 639 , 640 , 641 , 642 , 643 , 644 , 645 , 646 , 647 , 648 , 649 , 650 , 651 , 652 , 653 , 654 , 655 , 656 , 657 , 658 , 659 , 660 , 661 , 662 , 663 , 664 , 665 , 666 , 667 , 668 , 669 , 670 , 671 , 672 , 673 , 674 , 675 , 676 , 677 , 678 , 679 , 680 , 681 , 682 , 683 , 684 , 685 , 686 , 687 , 688 , 689 , 690 , 691 , 692 , 693 , 694 , 695 , 696 , 697 , 698 , 699 , 700 , 701 , 702 , 703 , 704 , 705 , 706 , 707 , 708 , 709 , 710 , 711 , 712 , 713 , 714 , 715 , 716 , 717 , 718 , 719 , 720 , 721 , 722 , 723 , 724 , 725 , 726 , 727 , 728 , 729 , 730 , 'localForce')

ops.logFile("Tutorial - Space Frame - Static and Modal Analysis.log")

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
ops.load(   210,       15,       25,        0,        0,        0,       15)
ops.load(   246,       15,       25,        0,        0,        0,       15)
ops.load(   310,       15,       25,        0,        0,        0,       15)

# recording the initial status

ops.record()

# Perform eigenvalue analysis

print("Running eigenvalue analysis")

numModes = 9

# Record eigenvectors

for k in range(numModes):
    ops.recorder("Node", "-file", f"Mode_{k}.out", "-nodeRange", 1, 664, "-dof", 1, 2, 3, f"eigen {k}")

lambda_ = ops.eigen("-fullGenLapack", numModes)

# Modal report

ops.modalProperties('-file', 'ModalReport.out', '-unorm')
# Calculate periods

T = []
for lam in lambda_:
    T.append(6.283185/math.sqrt(lam))

# Write periods file
period = "Periods.out"
with open(period, "w") as file:
    for index, t in enumerate(T):
        file.write(f"{t}\n")
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
        print(f"Analysis time : {minutes} minutes")

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
# 664

# Elements 1D
# 730

# Elements 2D
# 0

# Elements 3D
# 0

# ElasticBeamColumn
# 730
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357 358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 377 378 379 380 381 382 383 384 385 386 387 388 389 390 391 392 393 394 395 396 397 398 399 400 401 402 403 404 405 406 407 408 409 410 411 412 413 414 415 416 417 418 419 420 421 422 423 424 425 426 427 428 429 430 431 432 433 434 435 436 437 438 439 440 441 442 443 444 445 446 447 448 449 450 451 452 453 454 455 456 457 458 459 460 461 462 463 464 465 466 467 468 469 470 471 472 473 474 475 476 477 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493 494 495 496 497 498 499 500 501 502 503 504 505 506 507 508 509 510 511 512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535 536 537 538 539 540 541 542 543 544 545 546 547 548 549 550 551 552 553 554 555 556 557 558 559 560 561 562 563 564 565 566 567 568 569 570 571 572 573 574 575 576 577 578 579 580 581 582 583 584 585 586 587 588 589 590 591 592 593 594 595 596 597 598 599 600 601 602 603 604 605 606 607 608 609 610 611 612 613 614 615 616 617 618 619 620 621 622 623 624 625 626 627 628 629 630 631 632 633 634 635 636 637 638 639 640 641 642 643 644 645 646 647 648 649 650 651 652 653 654 655 656 657 658 659 660 661 662 663 664 665 666 667 668 669 670 671 672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689 690 691 692 693 694 695 696 697 698 699 700 701 702 703 704 705 706 707 708 709 710 711 712 713 714 715 716 717 718 719 720 721 722 723 724 725 726 727 728 729 730

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# F R A M E   L O C A L   A X E S   O R I E N T A T I O N
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#      ID                           Type                       Local-x                       Local-y                       Local-z          Literal      Material / Section
#
#       1              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       2              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       3              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       4              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       5              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       6              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       7              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       8              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#       9              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#      10              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#      11              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#      12              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      13              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      14              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      15              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      16              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      17              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      18              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      19              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      20              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      21              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      22              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      23              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      24              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      25              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      26              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      27              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      28              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      29              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      30              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      31              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      32              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      33              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      34              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      35              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      36              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      37              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      38              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      39              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      40              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      41              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      42              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      43              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      44              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      45              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      46              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      47              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      48              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      49              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      50              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      51              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      52              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      53              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      54              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      55              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      56              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      57              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      58              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      59              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      60              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      61              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      62              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      63              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      64              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      65              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      66              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      67              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      68              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      69              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      70              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      71              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      72              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      73              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      74              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      75              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#      76              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      77              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      78              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      79              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      80              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      81              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      82              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      83              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      84              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      85              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      86              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      87              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      88              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      89              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      90              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      91              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      92              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      93              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      94              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      95              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      96              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      97              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      98              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#      99              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     100              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     101              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     102              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     103              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     104              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     105              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     106              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     107              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     108              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     109              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     110              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     111              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     112              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     113              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     114              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     115              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     116              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     117              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     118              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     119              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     120              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     121              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     122              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     123              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     124              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     125              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     126              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     127              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     128              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     129              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     130              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     131              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     132              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     133              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     134              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     135              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     136              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     137              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     138              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     139              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     140              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     141              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     142              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     143              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     144              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     145              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     146              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     147              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     148              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     149              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     150              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     151              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     152              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     153              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     154              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     155              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     156              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     157              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     158              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     159              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     160              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     161              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     162              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     163              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     164              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     165              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     166              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     167              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     168              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     169              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     170              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     171              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     172              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     173              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     174              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     175              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     176              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     177              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     178              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     179              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     180              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     181              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     182              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     183              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     184              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     185              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     186              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     187              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     188              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     189              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     190              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     191              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     192              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     193              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     194              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     195              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     196              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     197              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     198              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     199              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     200              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     201              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     202              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     203              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     204              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     205              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     206              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     207              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     208              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     209              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     210              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     211              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     212              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     213              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     214              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     215              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     216              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     217              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     218              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     219              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     220              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     221              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     222              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     223              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     224              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     225              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     226              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     227              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     228              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     229              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     230              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     231              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     232              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     233              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     234              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     235              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     236              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     237              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     238              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     239              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     240              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     241              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     242              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     243              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     244              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     245              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     246              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     247              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     248              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     249              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     250              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     251              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     252              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     253              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     254              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     255              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     256              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     257              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     258              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     259              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     260              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     261              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     262              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     263              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     264              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     265              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     266              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     267              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     268              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     269              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     270              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     271              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     272              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     273              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     274              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     275              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     276              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     277              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     278              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     279              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     280              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     281              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     282              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     283              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     284              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     285              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     286              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     287              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     288              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     289              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     290              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     291              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     292              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     293              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     294              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     295              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     296              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     297              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     298              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     299              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     300              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     301              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     302              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     303              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     304              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     305              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     306              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     307              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     308              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     309              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     310              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     311              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     312              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     313              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     314              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     315              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     316              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     317              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     318              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     319              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     320              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     321              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     322              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     323              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     324              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     325              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     326              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     327              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     328              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     329              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     330              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     331              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     332              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     333              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     334              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     335              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     336              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     337              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     338              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     339              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     340              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     341              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     342              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     343              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     344              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     345              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     346              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     347              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     348              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     349              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     350              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     351              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     352              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     353              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     354              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     355              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     356              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     357              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     358              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     359              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     360              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     361              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     362              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     363              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     364              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     365              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     366              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     367              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     368              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     369              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     370              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     371              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     372              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     373              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     374              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     375              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     376              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     377              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     378              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     379              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     380              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     381              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     382              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     383              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     384              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     385              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     386              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     387              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     388              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     389              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     390              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     391              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     392              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     393              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     394              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     395              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     396              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     397              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     398              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     399              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     400              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     401              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     402              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     403              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     404              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     405              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     406              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     407              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     408              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     409              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     410              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     411              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     412              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     413              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     414              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     415              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     416              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     417              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     418              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     419              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     420              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     421              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     422              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     423              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     424              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     425              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     426              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     427              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     428              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     429              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     430              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     431              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     432              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     433              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     434              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     435              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     436              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     437              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     438              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     439              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     440              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     441              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     442              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     443              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     444              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     445              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     446              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     447              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     448              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     449              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     450              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     451              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     452              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     453              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     454              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     455              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     456              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     457              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     458              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     459              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     460              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     461              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     462              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     463              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     464              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     465              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     466              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     467              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     468              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     469              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     470              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     471              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     472              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     473              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     474              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     475              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     476              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     477              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     478              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     479              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     480              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     481              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     482              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     483              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     484              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     485              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     486              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     487              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     488              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     489              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     490              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     491              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     492              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     493              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     494              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     495              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     496              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     497              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     498              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     499              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     500              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     501              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     502              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     503              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     504              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     505              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     506              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     507              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     508              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     509              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     510              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     511              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     512              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     513              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     514              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     515              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     516              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     517              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     518              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     519              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     520              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     521              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     522              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     523              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     524              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     525              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     526              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     527              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     528              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     529              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     530              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     531              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     532              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     533              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     534              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     535              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     536              ElasticBeamColumn     {+0.0000 +0.0000 +1.0000}     {+0.0000 +1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { +Z +Y -X };   # Concrete C20/25
#     537              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     538              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     539              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     540              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     541              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     542              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     543              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     544              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     545              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     546              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     547              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     548              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     549              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     550              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     551              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     552              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     553              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     554              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     555              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     556              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     557              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     558              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     559              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     560              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     561              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     562              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     563              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     564              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     565              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     566              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     567              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     568              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     569              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     570              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     571              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     572              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     573              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     574              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     575              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     576              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     577              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     578              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     579              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     580              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     581              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     582              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     583              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     584              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     585              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     586              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     587              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     588              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     589              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     590              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     591              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     592              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     593              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     594              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     595              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     596              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     597              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     598              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     599              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     600              ElasticBeamColumn     {+0.0000 +0.0000 -1.0000}     {-0.0000 -1.0000 -0.0000}     {-1.0000 +0.0000 +0.0000}     { -Z -Y -X };   # Concrete C20/25
#     601              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     602              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     603              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     604              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     605              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     606              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     607              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     608              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     609              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     610              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     611              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     612              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     613              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     614              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     615              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     616              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     617              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     618              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     619              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     620              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     621              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     622              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     623              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     624              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     625              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     626              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     627              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     628              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     629              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     630              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     631              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     632              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     633              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     634              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     635              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     636              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     637              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     638              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     639              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     640              ElasticBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Concrete C20/25
#     641              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     642              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     643              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     644              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     645              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     646              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     647              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     648              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     649              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     650              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     651              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     652              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     653              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     654              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     655              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     656              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     657              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     658              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     659              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     660              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     661              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     662              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     663              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     664              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     665              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     666              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     667              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     668              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     669              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     670              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     671              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     672              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     673              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     674              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     675              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     676              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     677              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     678              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     679              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     680              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     681              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     682              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     683              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     684              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     685              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     686              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     687              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     688              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     689              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     690              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     691              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     692              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     693              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     694              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     695              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     696              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     697              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     698              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     699              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     700              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     701              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     702              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     703              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     704              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     705              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     706              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     707              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     708              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     709              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     710              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     711              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     712              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     713              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     714              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     715              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     716              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     717              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     718              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     719              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     720              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     721              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     722              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     723              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     724              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     725              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     726              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     727              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     728              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     729              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25
#     730              ElasticBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Concrete C20/25

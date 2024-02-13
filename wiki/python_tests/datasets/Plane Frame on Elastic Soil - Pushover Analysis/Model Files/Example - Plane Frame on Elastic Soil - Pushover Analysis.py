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

# Quad (288)
# FBC - Column 50x50 (36)
# FBC - Beam 70x30 (24)

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

ops.node(    52,           -4,            0)
ops.node(    54,           -3,            0)
ops.node(    55,           -5,            0)
ops.node(    57,           -6,            0)
ops.node(    58,           -2,            0)
ops.node(    59,           -1,            0)
ops.node(    60,           -7,            0)
ops.node(    61,           -8,            0)
ops.node(    63,            0,            0)
ops.node(    65,           -9,            0)
ops.node(    66,           -4,           -1)
ops.node(    67,            1,            0)
ops.node(    68,           -5,           -1)
ops.node(    69,           -3,           -1)
ops.node(    70,           -6,           -1)
ops.node(    71,           -2,           -1)
ops.node(    72,           -1,           -1)
ops.node(    73,           -7,           -1)
ops.node(    74,            2,            0)
ops.node(    75,          -10,            0)
ops.node(    76,           -8,           -1)
ops.node(    77,            0,           -1)
ops.node(    79,          -11,            0)
ops.node(    80,            3,            0)
ops.node(    81,           -9,           -1)
ops.node(    82,            1,           -1)
ops.node(    83,           -4,           -2)
ops.node(    84,           -5,           -2)
ops.node(    85,           -3,           -2)
ops.node(    86,           -2,           -2)
ops.node(    87,           -6,           -2)
ops.node(    88,           -7,           -2)
ops.node(    89,            2,           -1)
ops.node(    90,          -10,           -1)
ops.node(    91,           -1,           -2)
ops.node(    93,            4,            0)
ops.node(    94,          -12,            0)
ops.node(    95,            0,           -2)
ops.node(    96,           -8,           -2)
ops.node(    97,            3,           -1)
ops.node(    98,          -11,           -1)
ops.node(    99,            1,           -2)
ops.node(   100,           -9,           -2)
ops.node(   101,            5,            0)
ops.node(   102,           -4,           -3)
ops.node(   103,           -5,           -3)
ops.node(   104,           -3,           -3)
ops.node(   105,           -2,           -3)
ops.node(   106,           -6,           -3)
ops.node(   107,            2,           -2)
ops.node(   108,          -10,           -2)
ops.node(   109,            4,           -1)
ops.node(   110,          -12,           -1)
ops.node(   111,           -1,           -3)
ops.node(   112,           -7,           -3)
ops.node(   113,            0,           -3)
ops.node(   114,           -8,           -3)
ops.node(   115,            6,            0)
ops.node(   116,            3,           -2)
ops.node(   117,          -11,           -2)
ops.node(   118,           -9,           -3)
ops.node(   119,            5,           -1)
ops.node(   120,            1,           -3)
ops.node(   121,           -4,           -4)
ops.node(   122,           -3,           -4)
ops.node(   123,           -5,           -4)
ops.node(   124,           -2,           -4)
ops.node(   125,           -6,           -4)
ops.node(   126,          -12,           -2)
ops.node(   127,            4,           -2)
ops.node(   128,          -10,           -3)
ops.node(   129,            2,           -3)
ops.node(   130,           -7,           -4)
ops.node(   131,            7,            0)
ops.node(   132,           -1,           -4)
ops.node(   133,            6,           -1)
ops.node(   134,            0,           -4)
ops.node(   135,           -8,           -4)
ops.node(   136,            3,           -3)
ops.node(   137,          -11,           -3)
ops.node(   138,            5,           -2)
ops.node(   139,            1,           -4)
ops.node(   140,           -9,           -4)
ops.node(   141,            8,            0)
ops.node(   142,           -4,           -5)
ops.node(   143,            4,           -3)
ops.node(   144,          -12,           -3)
ops.node(   145,           -5,           -5)
ops.node(   146,            7,           -1)
ops.node(   147,           -3,           -5)
ops.node(   148,          -10,           -4)
ops.node(   149,            2,           -4)
ops.node(   150,           -6,           -5)
ops.node(   151,           -2,           -5)
ops.node(   152,            6,           -2)
ops.node(   153,           -1,           -5)
ops.node(   154,           -7,           -5)
ops.node(   155,          -11,           -4)
ops.node(   156,           -8,           -5)
ops.node(   157,            0,           -5)
ops.node(   158,            3,           -4)
ops.node(   159,            5,           -3)
ops.node(   160,            9,            0)
ops.node(   161,            8,           -1)
ops.node(   162,            1,           -5)
ops.node(   163,           -9,           -5)
ops.node(   164,            7,           -2)
ops.node(   165,            4,           -4)
ops.node(   166,          -12,           -4)
ops.node(   167,           -4,           -6)
ops.node(   168,            2,           -5)
ops.node(   169,          -10,           -5)
ops.node(   170,            6,           -3)
ops.node(   171,           -5,           -6)
ops.node(   172,           -3,           -6)
ops.node(   173,           -2,           -6)
ops.node(   174,           -6,           -6)
ops.node(   175,           -1,           -6)
ops.node(   176,           -7,           -6)
ops.node(   177,            5,           -4)
ops.node(   178,          -11,           -5)
ops.node(   179,            3,           -5)
ops.node(   180,            9,           -1)
ops.node(   181,            8,           -2)
ops.node(   182,           -8,           -6)
ops.node(   183,            0,           -6)
ops.node(   184,           10,            0)
ops.node(   185,            7,           -3)
ops.node(   186,           -9,           -6)
ops.node(   187,            1,           -6)
ops.node(   188,          -12,           -5)
ops.node(   189,            4,           -5)
ops.node(   190,            6,           -4)
ops.node(   191,            2,           -6)
ops.node(   192,          -10,           -6)
ops.node(   193,           -4,           -7)
ops.node(   194,           -3,           -7)
ops.node(   195,           -5,           -7)
ops.node(   196,           -6,           -7)
ops.node(   197,           -2,           -7)
ops.node(   198,           10,           -1)
ops.node(   199,            9,           -2)
ops.node(   200,            8,           -3)
ops.node(   201,           11,            0)
ops.node(   202,           -1,           -7)
ops.node(   203,           -7,           -7)
ops.node(   204,            5,           -5)
ops.node(   205,          -11,           -6)
ops.node(   206,            3,           -6)
ops.node(   207,           -8,           -7)
ops.node(   208,            7,           -4)
ops.node(   209,            0,           -7)
ops.node(   210,            1,           -7)
ops.node(   211,           -9,           -7)
ops.node(   212,            4,           -6)
ops.node(   213,          -12,           -6)
ops.node(   214,            6,           -5)
ops.node(   215,           10,           -2)
ops.node(   216,            9,           -3)
ops.node(   217,           11,           -1)
ops.node(   218,            2,           -7)
ops.node(   219,          -10,           -7)
ops.node(   220,           -4,           -8)
ops.node(   221,           12,            0)
ops.node(   222,            8,           -4)
ops.node(   223,           -3,           -8)
ops.node(   224,           -5,           -8)
ops.node(   225,           -2,           -8)
ops.node(   226,           -6,           -8)
ops.node(   227,            5,           -6)
ops.node(   228,           -7,           -8)
ops.node(   229,           -1,           -8)
ops.node(   230,            7,           -5)
ops.node(   231,            3,           -7)
ops.node(   232,          -11,           -7)
ops.node(   233,           -8,           -8)
ops.node(   234,            0,           -8)
ops.node(   235,           10,           -3)
ops.node(   236,           11,           -2)
ops.node(   237,            6,           -6)
ops.node(   238,            1,           -8)
ops.node(   239,          -12,           -7)
ops.node(   240,            9,           -4)
ops.node(   241,            4,           -7)
ops.node(   242,           -9,           -8)
ops.node(   243,           12,           -1)
ops.node(   244,            8,           -5)
ops.node(   245,          -10,           -8)
ops.node(   246,            2,           -8)
ops.node(   247,           -4,           -9)
ops.node(   248,           -3,           -9)
ops.node(   249,            5,           -7)
ops.node(   250,           -5,           -9)
ops.node(   251,           -6,           -9)
ops.node(   252,            7,           -6)
ops.node(   253,           -2,           -9)
ops.node(   254,          -11,           -8)
ops.node(   255,            3,           -8)
ops.node(   256,           11,           -3)
ops.node(   257,           -7,           -9)
ops.node(   258,           -1,           -9)
ops.node(   259,           10,           -4)
ops.node(   260,           12,           -2)
ops.node(   261,           -8,           -9)
ops.node(   262,            0,           -9)
ops.node(   263,            9,           -5)
ops.node(   264,            6,           -7)
ops.node(   265,            4,           -8)
ops.node(   266,          -12,           -8)
ops.node(   267,           -9,           -9)
ops.node(   268,            1,           -9)
ops.node(   269,            8,           -6)
ops.node(   270,            2,           -9)
ops.node(   271,          -10,           -9)
ops.node(   272,           11,           -4)
ops.node(   273,            5,           -8)
ops.node(   274,           12,           -3)
ops.node(   275,            7,           -7)
ops.node(   276,           -4,          -10)
ops.node(   277,           -3,          -10)
ops.node(   278,           10,           -5)
ops.node(   279,           -5,          -10)
ops.node(   280,           -2,          -10)
ops.node(   281,           -6,          -10)
ops.node(   282,          -11,           -9)
ops.node(   283,            3,           -9)
ops.node(   284,           -1,          -10)
ops.node(   285,           -7,          -10)
ops.node(   286,            9,           -6)
ops.node(   287,           -8,          -10)
ops.node(   288,            0,          -10)
ops.node(   289,            6,           -8)
ops.node(   290,            4,           -9)
ops.node(   291,          -12,           -9)
ops.node(   292,            8,           -7)
ops.node(   293,            1,          -10)
ops.node(   294,           -9,          -10)
ops.node(   295,           12,           -4)
ops.node(   296,           11,           -5)
ops.node(   297,            2,          -10)
ops.node(   298,           10,           -6)
ops.node(   299,          -10,          -10)
ops.node(   300,            7,           -8)
ops.node(   301,            5,           -9)
ops.node(   302,           -4,          -11)
ops.node(   303,            9,           -7)
ops.node(   304,           -3,          -11)
ops.node(   305,           -5,          -11)
ops.node(   306,           -2,          -11)
ops.node(   307,          -11,          -10)
ops.node(   308,            3,          -10)
ops.node(   309,           -6,          -11)
ops.node(   310,           -7,          -11)
ops.node(   311,           -1,          -11)
ops.node(   312,            6,           -9)
ops.node(   313,            8,           -8)
ops.node(   314,           -8,          -11)
ops.node(   315,            0,          -11)
ops.node(   316,           12,           -5)
ops.node(   317,            4,          -10)
ops.node(   318,          -12,          -10)
ops.node(   319,           11,           -6)
ops.node(   320,           -9,          -11)
ops.node(   321,            1,          -11)
ops.node(   322,           10,           -7)
ops.node(   323,            7,           -9)
ops.node(   324,          -10,          -11)
ops.node(   325,            2,          -11)
ops.node(   326,            5,          -10)
ops.node(   327,            9,           -8)
ops.node(   328,           -4,          -12)
ops.node(   329,           -3,          -12)
ops.node(   330,           -5,          -12)
ops.node(   331,            3,          -11)
ops.node(   332,          -11,          -11)
ops.node(   333,           12,           -6)
ops.node(   334,           -6,          -12)
ops.node(   335,           -2,          -12)
ops.node(   336,            6,          -10)
ops.node(   337,           -1,          -12)
ops.node(   338,            8,           -9)
ops.node(   339,           -7,          -12)
ops.node(   340,           11,           -7)
ops.node(   341,            0,          -12)
ops.node(   342,           -8,          -12)
ops.node(   343,            4,          -11)
ops.node(   344,          -12,          -11)
ops.node(   345,           10,           -8)
ops.node(   346,            1,          -12)
ops.node(   347,           -9,          -12)
ops.node(   348,            7,          -10)
ops.node(   349,            5,          -11)
ops.node(   350,            9,           -9)
ops.node(   351,          -10,          -12)
ops.node(   352,            2,          -12)
ops.node(   353,           12,           -7)
ops.node(   354,          -11,          -12)
ops.node(   355,            3,          -12)
ops.node(   356,           11,           -8)
ops.node(   357,            8,          -10)
ops.node(   358,            6,          -11)
ops.node(   359,           10,           -9)
ops.node(   360,            4,          -12)
ops.node(   361,          -12,          -12)
ops.node(   362,            7,          -11)
ops.node(   363,            9,          -10)
ops.node(   364,           12,           -8)
ops.node(   365,            5,          -12)
ops.node(   366,           11,           -9)
ops.node(   367,            8,          -11)
ops.node(   368,            6,          -12)
ops.node(   369,           10,          -10)
ops.node(   370,            7,          -12)
ops.node(   371,           12,           -9)
ops.node(   372,            9,          -11)
ops.node(   373,           11,          -10)
ops.node(   374,            8,          -12)
ops.node(   375,           10,          -11)
ops.node(   376,           12,          -10)
ops.node(   377,            9,          -12)
ops.node(   378,           11,          -11)
ops.node(   379,           10,          -12)
ops.node(   380,           12,          -11)
ops.node(   381,           11,          -12)
ops.node(   382,           12,          -12)

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl

ops.fix(    94,   1,   0)
ops.fix(   110,   1,   0)
ops.fix(   126,   1,   0)
ops.fix(   144,   1,   0)
ops.fix(   166,   1,   0)
ops.fix(   188,   1,   0)
ops.fix(   213,   1,   0)
ops.fix(   221,   1,   0)
ops.fix(   239,   1,   0)
ops.fix(   243,   1,   0)
ops.fix(   260,   1,   0)
ops.fix(   266,   1,   0)
ops.fix(   274,   1,   0)
ops.fix(   291,   1,   0)
ops.fix(   295,   1,   0)
ops.fix(   316,   1,   0)
ops.fix(   318,   1,   0)
ops.fix(   328,   1,   1)
ops.fix(   329,   1,   1)
ops.fix(   330,   1,   1)
ops.fix(   333,   1,   0)
ops.fix(   334,   1,   1)
ops.fix(   335,   1,   1)
ops.fix(   337,   1,   1)
ops.fix(   339,   1,   1)
ops.fix(   341,   1,   1)
ops.fix(   342,   1,   1)
ops.fix(   344,   1,   0)
ops.fix(   346,   1,   1)
ops.fix(   347,   1,   1)
ops.fix(   351,   1,   1)
ops.fix(   352,   1,   1)
ops.fix(   353,   1,   0)
ops.fix(   354,   1,   1)
ops.fix(   355,   1,   1)
ops.fix(   360,   1,   1)
ops.fix(   361,   1,   1)
ops.fix(   364,   1,   0)
ops.fix(   365,   1,   1)
ops.fix(   368,   1,   1)
ops.fix(   370,   1,   1)
ops.fix(   371,   1,   0)
ops.fix(   374,   1,   1)
ops.fix(   376,   1,   0)
ops.fix(   377,   1,   1)
ops.fix(   379,   1,   1)
ops.fix(   380,   1,   0)
ops.fix(   381,   1,   1)
ops.fix(   382,   1,   1)

# --------------------------------------------------------------------------------------------------------------
# Q U A D   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# nDMaterial Definition used by Quad Elements
# (only if they have not already been defined on this model domain)

ops.nDMaterial("ElasticIsotropic", 259, 170000, 0.25,            0)

# Quad elements Definition : element quad $EleTag $Nodei $Nodej Nodek $Nodel $thick $type $MatTag

ops.element('quad',      1,    110,     98,     79,     94,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      2,    126,    117,     98,    110,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      3,    144,    137,    117,    126,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      4,    166,    155,    137,    144,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      5,     98,     90,     75,     79,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      6,    117,    108,     90,     98,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      7,    137,    128,    108,    117,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      8,    155,    148,    128,    137,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',      9,     90,     81,     65,     75,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     10,    108,    100,     81,     90,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     11,    128,    118,    100,    108,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     12,    148,    140,    118,    128,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     13,     81,     76,     61,     65,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     14,    100,     96,     76,     81,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     15,    118,    114,     96,    100,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     16,    140,    135,    114,    118,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     17,     76,     73,     60,     61,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     18,     96,     88,     73,     76,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     19,    114,    112,     88,     96,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     20,    135,    130,    112,    114,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     21,     73,     70,     57,     60,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     22,     88,     87,     70,     73,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     23,    112,    106,     87,     88,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     24,    130,    125,    106,    112,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     25,     70,     68,     55,     57,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     26,     87,     84,     68,     70,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     27,    106,    103,     84,     87,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     28,    125,    123,    103,    106,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     29,     68,     66,     52,     55,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     30,     84,     83,     66,     68,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     31,    103,    102,     83,     84,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     32,    123,    121,    102,    103,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     33,     66,     69,     54,     52,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     34,     83,     85,     69,     66,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     35,    102,    104,     85,     83,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     36,    121,    122,    104,    102,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     37,     69,     71,     58,     54,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     38,     85,     86,     71,     69,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     39,    104,    105,     86,     85,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     40,    122,    124,    105,    104,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     41,     71,     72,     59,     58,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     42,     86,     91,     72,     71,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     43,    105,    111,     91,     86,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     44,    124,    132,    111,    105,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     45,     72,     77,     63,     59,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     46,     91,     95,     77,     72,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     47,    111,    113,     95,     91,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     48,    132,    134,    113,    111,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     49,     77,     82,     67,     63,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     50,     95,     99,     82,     77,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     51,    113,    120,     99,     95,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     52,    134,    139,    120,    113,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     53,     82,     89,     74,     67,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     54,     99,    107,     89,     82,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     55,    120,    129,    107,     99,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     56,    139,    149,    129,    120,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     57,     89,     97,     80,     74,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     58,    107,    116,     97,     89,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     59,    129,    136,    116,    107,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     60,    149,    158,    136,    129,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     61,     97,    109,     93,     80,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     62,    116,    127,    109,     97,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     63,    136,    143,    127,    116,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     64,    158,    165,    143,    136,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     65,    109,    119,    101,     93,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     66,    127,    138,    119,    109,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     67,    143,    159,    138,    127,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     68,    165,    177,    159,    143,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     69,    119,    133,    115,    101,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     70,    138,    152,    133,    119,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     71,    159,    170,    152,    138,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     72,    177,    190,    170,    159,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     73,    133,    146,    131,    115,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     74,    152,    164,    146,    133,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     75,    170,    185,    164,    152,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     76,    190,    208,    185,    170,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     77,    146,    161,    141,    131,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     78,    164,    181,    161,    146,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     79,    185,    200,    181,    164,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     80,    208,    222,    200,    185,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     81,    161,    180,    160,    141,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     82,    181,    199,    180,    161,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     83,    200,    216,    199,    181,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     84,    222,    240,    216,    200,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     85,    180,    198,    184,    160,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     86,    199,    215,    198,    180,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     87,    216,    235,    215,    199,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     88,    240,    259,    235,    216,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     89,    198,    217,    201,    184,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     90,    215,    236,    217,    198,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     91,    235,    256,    236,    215,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     92,    259,    272,    256,    235,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     93,    217,    243,    221,    201,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     94,    236,    260,    243,    217,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     95,    256,    274,    260,    236,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     96,    272,    295,    274,    256,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     97,    140,    163,    156,    135,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     98,    148,    169,    163,    140,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',     99,    155,    178,    169,    148,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    100,    166,    188,    178,    155,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    101,    163,    186,    182,    156,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    102,    169,    192,    186,    163,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    103,    178,    205,    192,    169,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    104,    188,    213,    205,    178,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    105,    186,    211,    207,    182,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    106,    192,    219,    211,    186,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    107,    205,    232,    219,    192,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    108,    213,    239,    232,    205,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    109,    211,    242,    233,    207,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    110,    219,    245,    242,    211,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    111,    232,    254,    245,    219,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    112,    239,    266,    254,    232,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    113,    123,    145,    142,    121,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    114,    125,    150,    145,    123,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    115,    130,    154,    150,    125,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    116,    135,    156,    154,    130,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    117,    145,    171,    167,    142,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    118,    150,    174,    171,    145,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    119,    154,    176,    174,    150,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    120,    156,    182,    176,    154,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    121,    171,    195,    193,    167,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    122,    174,    196,    195,    171,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    123,    176,    203,    196,    174,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    124,    182,    207,    203,    176,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    125,    195,    224,    220,    193,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    126,    196,    226,    224,    195,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    127,    203,    228,    226,    196,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    128,    207,    233,    228,    203,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    129,    132,    153,    157,    134,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    130,    124,    151,    153,    132,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    131,    122,    147,    151,    124,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    132,    121,    142,    147,    122,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    133,    153,    175,    183,    157,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    134,    151,    173,    175,    153,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    135,    147,    172,    173,    151,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    136,    142,    167,    172,    147,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    137,    175,    202,    209,    183,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    138,    173,    197,    202,    175,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    139,    172,    194,    197,    173,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    140,    167,    193,    194,    172,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    141,    202,    229,    234,    209,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    142,    197,    225,    229,    202,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    143,    194,    223,    225,    197,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    144,    193,    220,    223,    194,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    145,    158,    179,    189,    165,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    146,    149,    168,    179,    158,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    147,    139,    162,    168,    149,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    148,    134,    157,    162,    139,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    149,    179,    206,    212,    189,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    150,    168,    191,    206,    179,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    151,    162,    187,    191,    168,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    152,    157,    183,    187,    162,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    153,    206,    231,    241,    212,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    154,    191,    218,    231,    206,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    155,    187,    210,    218,    191,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    156,    183,    209,    210,    187,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    157,    231,    255,    265,    241,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    158,    218,    246,    255,    231,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    159,    210,    238,    246,    218,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    160,    209,    234,    238,    210,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    161,    208,    230,    244,    222,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    162,    190,    214,    230,    208,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    163,    177,    204,    214,    190,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    164,    165,    189,    204,    177,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    165,    230,    252,    269,    244,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    166,    214,    237,    252,    230,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    167,    204,    227,    237,    214,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    168,    189,    212,    227,    204,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    169,    252,    275,    292,    269,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    170,    237,    264,    275,    252,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    171,    227,    249,    264,    237,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    172,    212,    241,    249,    227,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    173,    275,    300,    313,    292,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    174,    264,    289,    300,    275,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    175,    249,    273,    289,    264,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    176,    241,    265,    273,    249,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    177,    272,    296,    316,    295,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    178,    259,    278,    296,    272,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    179,    240,    263,    278,    259,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    180,    222,    244,    263,    240,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    181,    296,    319,    333,    316,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    182,    278,    298,    319,    296,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    183,    263,    286,    298,    278,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    184,    244,    269,    286,    263,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    185,    319,    340,    353,    333,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    186,    298,    322,    340,    319,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    187,    286,    303,    322,    298,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    188,    269,    292,    303,    286,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    189,    340,    356,    364,    353,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    190,    322,    345,    356,    340,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    191,    303,    327,    345,    322,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    192,    292,    313,    327,    303,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    193,    242,    267,    261,    233,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    194,    245,    271,    267,    242,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    195,    254,    282,    271,    245,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    196,    266,    291,    282,    254,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    197,    267,    294,    287,    261,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    198,    271,    299,    294,    267,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    199,    282,    307,    299,    271,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    200,    291,    318,    307,    282,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    201,    294,    320,    314,    287,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    202,    299,    324,    320,    294,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    203,    307,    332,    324,    299,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    204,    318,    344,    332,    307,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    205,    320,    347,    342,    314,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    206,    324,    351,    347,    320,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    207,    332,    354,    351,    324,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    208,    344,    361,    354,    332,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    209,    224,    250,    247,    220,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    210,    226,    251,    250,    224,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    211,    228,    257,    251,    226,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    212,    233,    261,    257,    228,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    213,    250,    279,    276,    247,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    214,    251,    281,    279,    250,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    215,    257,    285,    281,    251,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    216,    261,    287,    285,    257,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    217,    279,    305,    302,    276,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    218,    281,    309,    305,    279,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    219,    285,    310,    309,    281,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    220,    287,    314,    310,    285,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    221,    305,    330,    328,    302,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    222,    309,    334,    330,    305,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    223,    310,    339,    334,    309,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    224,    314,    342,    339,    310,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    225,    229,    258,    262,    234,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    226,    225,    253,    258,    229,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    227,    223,    248,    253,    225,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    228,    220,    247,    248,    223,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    229,    258,    284,    288,    262,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    230,    253,    280,    284,    258,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    231,    248,    277,    280,    253,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    232,    247,    276,    277,    248,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    233,    284,    311,    315,    288,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    234,    280,    306,    311,    284,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    235,    277,    304,    306,    280,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    236,    276,    302,    304,    277,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    237,    311,    337,    341,    315,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    238,    306,    335,    337,    311,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    239,    304,    329,    335,    306,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    240,    302,    328,    329,    304,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    241,    255,    283,    290,    265,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    242,    246,    270,    283,    255,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    243,    238,    268,    270,    246,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    244,    234,    262,    268,    238,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    245,    283,    308,    317,    290,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    246,    270,    297,    308,    283,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    247,    268,    293,    297,    270,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    248,    262,    288,    293,    268,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    249,    308,    331,    343,    317,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    250,    297,    325,    331,    308,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    251,    293,    321,    325,    297,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    252,    288,    315,    321,    293,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    253,    331,    355,    360,    343,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    254,    325,    352,    355,    331,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    255,    321,    346,    352,    325,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    256,    315,    341,    346,    321,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    257,    300,    323,    338,    313,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    258,    289,    312,    323,    300,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    259,    273,    301,    312,    289,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    260,    265,    290,    301,    273,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    261,    323,    348,    357,    338,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    262,    312,    336,    348,    323,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    263,    301,    326,    336,    312,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    264,    290,    317,    326,    301,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    265,    348,    362,    367,    357,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    266,    336,    358,    362,    348,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    267,    326,    349,    358,    336,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    268,    317,    343,    349,    326,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    269,    362,    370,    374,    367,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    270,    358,    368,    370,    362,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    271,    349,    365,    368,    358,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    272,    343,    360,    365,    349,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    273,    356,    366,    371,    364,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    274,    345,    359,    366,    356,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    275,    327,    350,    359,    345,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    276,    313,    338,    350,    327,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    277,    366,    373,    376,    371,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    278,    359,    369,    373,    366,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    279,    350,    363,    369,    359,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    280,    338,    357,    363,    350,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    281,    373,    378,    380,    376,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    282,    369,    375,    378,    373,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    283,    363,    372,    375,    369,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    284,    357,    367,    372,    363,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    285,    378,    381,    382,    380,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    286,    375,    379,    381,    378,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    287,    372,    377,    379,    375,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil
ops.element('quad',    288,    367,    374,    377,    372,        1,  'PlaneStrain', 259,        0,        0,        0,        0) # Soil

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

ops.node(     1,           -4,           12)
ops.node(     2,           -3,           12)
ops.node(     3,           -4,           11)
ops.node(     4,           -4,           10)
ops.node(     5,           -2,           12)
ops.node(     6,           -1,           12)
ops.node(     7,           -4,            9)
ops.node(     8,           -4,            8)
ops.node(     9,            0,           12)
ops.node(    10,            0,           11)
ops.node(    11,           -3,            8)
ops.node(    12,           -2,            8)
ops.node(    13,            0,           10)
ops.node(    14,            1,           12)
ops.node(    15,           -4,            7)
ops.node(    16,           -1,            8)
ops.node(    17,            0,            9)
ops.node(    18,            0,            8)
ops.node(    19,            2,           12)
ops.node(    20,           -4,            6)
ops.node(    21,            0,            7)
ops.node(    22,            1,            8)
ops.node(    23,            3,           12)
ops.node(    24,           -4,            5)
ops.node(    25,            2,            8)
ops.node(    26,            0,            6)
ops.node(    27,            4,           12)
ops.node(    28,           -4,            4)
ops.node(    29,            4,           11)
ops.node(    30,            0,            5)
ops.node(    31,           -3,            4)
ops.node(    32,            3,            8)
ops.node(    33,            4,           10)
ops.node(    34,           -2,            4)
ops.node(    35,           -1,            4)
ops.node(    36,            4,            9)
ops.node(    37,            0,            4)
ops.node(    38,            4,            8)
ops.node(    39,           -4,            3)
ops.node(    40,            1,            4)
ops.node(    41,            4,            7)
ops.node(    42,            0,            3)
ops.node(    43,           -4,            2)
ops.node(    44,            2,            4)
ops.node(    45,            4,            6)
ops.node(    46,            3,            4)
ops.node(    47,            4,            5)
ops.node(    48,            0,            2)
ops.node(    49,           -4,            1)
ops.node(    50,            4,            4)
ops.node(    51,            0,            1)
ops.node(    53,           -4,            0)
ops.node(    56,            4,            3)
ops.node(    62,            0,            0)
ops.node(    64,            4,            2)
ops.node(    78,            4,            1)
ops.node(    92,            4,            0)

# --------------------------------------------------------------------------------------------------------------
# F O R C E - B A S E D   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# Geometric Transformation

ops.geomTransf('Linear', 1)
ops.geomTransf('PDelta', 2)
ops.geomTransf('Corotational', 3)

# Sections Definition used by forceBeamColumn Elements
# (if they have not already been defined on this model domain)

ops.uniaxialMaterial("Concrete01", 363, -20000, -0.002, -17000, -0.005)
ops.uniaxialMaterial("Concrete01", 362, -20000, -0.002, -17000, -0.0035)
ops.uniaxialMaterial("ReinforcingSteel", 313, 500000, 575000, 2e+08, 2e+07, 0.005, 0.075)


ops.section("Fiber", 360, "-GJ", 1e10)
ops.beamIntegration('Lobatto', 36000, 360, 3)

# Create the Core fibers

ops.patch("rect", 363,      8,      8,  -0.200000,  -0.200000,   0.200000,   0.200000)

# Create the Cover fibers

ops.patch("rect", 362,      8,      1,  -0.200000,   0.200000,   0.200000,   0.250000)
ops.patch("rect", 362,      8,      1,  -0.200000,  -0.250000,   0.200000 ,  -0.200000)
ops.patch("rect", 362,      1,      8,  -0.250000,  -0.200000,  -0.200000,   0.200000)
ops.patch("rect", 362,      1,      8,   0.200000,  -0.200000,   0.250000,   0.200000)
# Corner Cover fibers
ops.patch("rect", 362,      1,      1,  -0.250000,  -0.250000,  -0.200000,  -0.200000)
ops.patch("rect", 362,      1,      1,  -0.250000,   0.200000,  -0.200000,   0.250000)
ops.patch("rect", 362,      1,      1,   0.200000,  -0.250000,   0.250000,  -0.200000)
ops.patch("rect", 362,      1,      1,   0.200000,   0.200000,   0.250000,   0.250000)


# Create the corner bars

ops.layer("straight", 313 , 2,   0.00031420,   0.200000,   0.200000,  -0.200000,   0.200000)
ops.layer("straight", 313 , 2,   0.00031420,   0.200000,  -0.200000,  -0.200000,  -0.200000)

# Create the middle bars along local y axis

ops.layer("straight", 313,   2,   0.00025450,   0.066667,   0.200000,  -0.066667,   0.200000)
ops.layer("straight", 313,   2,   0.00025450,   0.066667,  -0.200000,  -0.066667,  -0.200000)

# Create the middle bars along local z axis

ops.layer("straight", 313,   2,   0.00025450,   0.200000,   0.066667,   0.200000,  -0.066667)
ops.layer("straight", 313,   2,   0.00025450,  -0.200000,   0.066667,  -0.200000,  -0.066667)



ops.section("Fiber", 361)
ops.beamIntegration('Lobatto', 36100, 361, 3)

# Create the Core fibers

ops.patch("rect", 363,     11,      6,  -0.300000,  -0.100000,   0.300000,   0.100000)

# Create the Cover fibers

ops.patch("rect", 362,     11,      2,  -0.300000,   0.100000,   0.300000,   0.150000)
ops.patch("rect", 362,     11,      2,  -0.300000,  -0.150000,   0.300000,  -0.100000)
ops.patch("rect", 362,      2,      6,  -0.350000,  -0.100000,  -0.300000,   0.100000)
ops.patch("rect", 362,      2,      6,   0.300000,  -0.100000,   0.350000,   0.100000)
# Corner Cover fibers
ops.patch("rect", 362,      2,      2,  -0.350000,  -0.150000,  -0.300000,  -0.100000)
ops.patch("rect", 362,      2,      2,  -0.350000,   0.100000,  -0.300000,   0.150000)
ops.patch("rect", 362,      2,      2,   0.300000,  -0.150000,   0.350000,  -0.100000)
ops.patch("rect", 362,      2,      2,   0.300000,   0.100000,   0.350000,   0.150000)


# Create the Top bars (face on local y positive dir)

ops.layer("straight", 313,   3 ,   0.00020110,   0.300000,   0.100000,   0.300000,  -0.100000)

# Create the Bottom bars (face on local y negative dir)

ops.layer("straight", 313,   3,   0.00020110,  -0.300000,   0.100000,  -0.300000,  -0.100000)


# Force-Based Beam-Column Element definition

# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

ops.element('forceBeamColumn',    289, 53, 49,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    290, 49, 43,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    291, 43, 39,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    292, 39, 28,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    293, 28, 31,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    294, 31, 34,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    295, 34, 35,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    296, 35, 37,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    297, 62, 51,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    298, 51, 48,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    299, 48, 42,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    300, 42, 37,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    301, 37, 40,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    302, 40, 44,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    303, 44, 46,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    304, 46, 50,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    305, 92, 78,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    306, 78, 64,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    307, 64, 56,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    308, 56, 50,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    309, 28, 24,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    310, 24, 20,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    311, 20, 15,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    312, 15, 8,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    313, 8, 11,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    314, 11, 12,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    315, 12, 16,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    316, 16, 18,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    317, 37, 30,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    318, 30, 26,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    319, 26, 21,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    320, 21, 18,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    321, 18, 22,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    322, 22, 25,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    323, 25, 32,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    324, 32, 38,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    325, 50, 47,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    326, 47, 45,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    327, 45, 41,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    328, 41, 38,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    329, 8, 7,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    330, 7, 4,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    331, 4, 3,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    332, 3, 1,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    333, 1, 2,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    334, 2, 5,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    335, 5, 6,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    336, 6, 9,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    337, 9, 14,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    338, 14, 19,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    339, 19, 23,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    340, 23, 27,       1, 36100,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    341, 18, 17,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    342, 17, 13,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    343, 13, 10,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    344, 10, 9,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    345, 38, 36,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    346, 36, 33,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    347, 33, 29,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)
ops.element('forceBeamColumn',    348, 29, 27,       1, 36000,   '-iter',   50,   1.00e-04,   '-mass',        0)

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# E Q U A L  C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# Equal Constraint/equalDOF Definition : equalDOF $MasterNode $SlaveNode $DOFs

ops.equalDOF(    53,     52 ,1 ,2   ) # ID : 1

ops.equalDOF(    62,     63 ,1 ,2   ) # ID : 2

ops.equalDOF(    92,     93 ,1 ,2   ) # ID : 3


# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

ops.recorder('Node', '-file', 'Node_displacements.out', '-time', '-nodeRange', 1, 382, '-dof', 1, 2, 'disp')
ops.recorder('Node', '-file', 'Node_rotations.out', '-time', '-nodeRange', 1, 382, '-dof', 3, 'disp')
ops.recorder('Node', '-file', 'Node_forceReactions.out', '-time', '-nodeRange', 1, 382, '-dof', 1, 2, 'reaction')
ops.recorder('Node', '-file', 'Node_momentReactions.out', '-time', '-nodeRange', 1, 382, '-dof', 3, 'reaction')
ops.recorder('Element', '-file', 'Quad_force.out', '-time', '-ele', 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 106 , 107 , 108 , 109 , 110 , 111 , 112 , 113 , 114 , 115 , 116 , 117 , 118 , 119 , 120 , 121 , 122 , 123 , 124 , 125 , 126 , 127 , 128 , 129 , 130 , 131 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 140 , 141 , 142 , 143 , 144 , 145 , 146 , 147 , 148 , 149 , 150 , 151 , 152 , 153 , 154 , 155 , 156 , 157 , 158 , 159 , 160 , 161 , 162 , 163 , 164 , 165 , 166 , 167 , 168 , 169 , 170 , 171 , 172 , 173 , 174 , 175 , 176 , 177 , 178 , 179 , 180 , 181 , 182 , 183 , 184 , 185 , 186 , 187 , 188 , 189 , 190 , 191 , 192 , 193 , 194 , 195 , 196 , 197 , 198 , 199 , 200 , 201 , 202 , 203 , 204 , 205 , 206 , 207 , 208 , 209 , 210 , 211 , 212 , 213 , 214 , 215 , 216 , 217 , 218 , 219 , 220 , 221 , 222 , 223 , 224 , 225 , 226 , 227 , 228 , 229 , 230 , 231 , 232 , 233 , 234 , 235 , 236 , 237 , 238 , 239 , 240 , 241 , 242 , 243 , 244 , 245 , 246 , 247 , 248 , 249 , 250 , 251 , 252 , 253 , 254 , 255 , 256 , 257 , 258 , 259 , 260 , 261 , 262 , 263 , 264 , 265 , 266 , 267 , 268 , 269 , 270 , 271 , 272 , 273 , 274 , 275 , 276 , 277 , 278 , 279 , 280 , 281 , 282 , 283 , 284 , 285 , 286 , 287 , 288 , 'forces')
ops.recorder('Element', '-file', 'Quad_stress.out', '-time', '-ele', 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 106 , 107 , 108 , 109 , 110 , 111 , 112 , 113 , 114 , 115 , 116 , 117 , 118 , 119 , 120 , 121 , 122 , 123 , 124 , 125 , 126 , 127 , 128 , 129 , 130 , 131 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 140 , 141 , 142 , 143 , 144 , 145 , 146 , 147 , 148 , 149 , 150 , 151 , 152 , 153 , 154 , 155 , 156 , 157 , 158 , 159 , 160 , 161 , 162 , 163 , 164 , 165 , 166 , 167 , 168 , 169 , 170 , 171 , 172 , 173 , 174 , 175 , 176 , 177 , 178 , 179 , 180 , 181 , 182 , 183 , 184 , 185 , 186 , 187 , 188 , 189 , 190 , 191 , 192 , 193 , 194 , 195 , 196 , 197 , 198 , 199 , 200 , 201 , 202 , 203 , 204 , 205 , 206 , 207 , 208 , 209 , 210 , 211 , 212 , 213 , 214 , 215 , 216 , 217 , 218 , 219 , 220 , 221 , 222 , 223 , 224 , 225 , 226 , 227 , 228 , 229 , 230 , 231 , 232 , 233 , 234 , 235 , 236 , 237 , 238 , 239 , 240 , 241 , 242 , 243 , 244 , 245 , 246 , 247 , 248 , 249 , 250 , 251 , 252 , 253 , 254 , 255 , 256 , 257 , 258 , 259 , 260 , 261 , 262 , 263 , 264 , 265 , 266 , 267 , 268 , 269 , 270 , 271 , 272 , 273 , 274 , 275 , 276 , 277 , 278 , 279 , 280 , 281 , 282 , 283 , 284 , 285 , 286 , 287 , 288 , 'stresses')
ops.recorder('Element', '-file', 'Quad_strain.out', '-time', '-ele', 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 , 100 , 101 , 102 , 103 , 104 , 105 , 106 , 107 , 108 , 109 , 110 , 111 , 112 , 113 , 114 , 115 , 116 , 117 , 118 , 119 , 120 , 121 , 122 , 123 , 124 , 125 , 126 , 127 , 128 , 129 , 130 , 131 , 132 , 133 , 134 , 135 , 136 , 137 , 138 , 139 , 140 , 141 , 142 , 143 , 144 , 145 , 146 , 147 , 148 , 149 , 150 , 151 , 152 , 153 , 154 , 155 , 156 , 157 , 158 , 159 , 160 , 161 , 162 , 163 , 164 , 165 , 166 , 167 , 168 , 169 , 170 , 171 , 172 , 173 , 174 , 175 , 176 , 177 , 178 , 179 , 180 , 181 , 182 , 183 , 184 , 185 , 186 , 187 , 188 , 189 , 190 , 191 , 192 , 193 , 194 , 195 , 196 , 197 , 198 , 199 , 200 , 201 , 202 , 203 , 204 , 205 , 206 , 207 , 208 , 209 , 210 , 211 , 212 , 213 , 214 , 215 , 216 , 217 , 218 , 219 , 220 , 221 , 222 , 223 , 224 , 225 , 226 , 227 , 228 , 229 , 230 , 231 , 232 , 233 , 234 , 235 , 236 , 237 , 238 , 239 , 240 , 241 , 242 , 243 , 244 , 245 , 246 , 247 , 248 , 249 , 250 , 251 , 252 , 253 , 254 , 255 , 256 , 257 , 258 , 259 , 260 , 261 , 262 , 263 , 264 , 265 , 266 , 267 , 268 , 269 , 270 , 271 , 272 , 273 , 274 , 275 , 276 , 277 , 278 , 279 , 280 , 281 , 282 , 283 , 284 , 285 , 286 , 287 , 288 , 'strains')
ops.recorder('Element', '-file', 'ForceBeamColumn_localForce.out', '-time', '-ele', 289 , 290 , 291 , 292 , 293 , 294 , 295 , 296 , 297 , 298 , 299 , 300 , 301 , 302 , 303 , 304 , 305 , 306 , 307 , 308 , 309 , 310 , 311 , 312 , 313 , 314 , 315 , 316 , 317 , 318 , 319 , 320 , 321 , 322 , 323 , 324 , 325 , 326 , 327 , 328 , 329 , 330 , 331 , 332 , 333 , 334 , 335 , 336 , 337 , 338 , 339 , 340 , 341 , 342 , 343 , 344 , 345 , 346 , 347 , 348 , 'localForce')
ops.recorder('Element', '-file', 'ForceBeamColumn_basicDeformation.out', '-time', '-ele', 289 , 290 , 291 , 292 , 293 , 294 , 295 , 296 , 297 , 298 , 299 , 300 , 301 , 302 , 303 , 304 , 305 , 306 , 307 , 308 , 309 , 310 , 311 , 312 , 313 , 314 , 315 , 316 , 317 , 318 , 319 , 320 , 321 , 322 , 323 , 324 , 325 , 326 , 327 , 328 , 329 , 330 , 331 , 332 , 333 , 334 , 335 , 336 , 337 , 338 , 339 , 340 , 341 , 342 , 343 , 344 , 345 , 346 , 347 , 348 , 'basicDeformation')
ops.recorder('Element', '-file', 'ForceBeamColumn_plasticDeformation.out', '-time', '-ele', 289 , 290 , 291 , 292 , 293 , 294 , 295 , 296 , 297 , 298 , 299 , 300 , 301 , 302 , 303 , 304 , 305 , 306 , 307 , 308 , 309 , 310 , 311 , 312 , 313 , 314 , 315 , 316 , 317 , 318 , 319 , 320 , 321 , 322 , 323 , 324 , 325 , 326 , 327 , 328 , 329 , 330 , 331 , 332 , 333 , 334 , 335 , 336 , 337 , 338 , 339 , 340 , 341 , 342 , 343 , 344 , 345 , 346 , 347 , 348 , 'plasticDeformation')

ops.logFile("Example - Plane Frame on Elastic Soil - Pushover Analysis.log")

print(" __   __       __          __                   _       ")
print("/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _")
print("\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-")
print("                  |                                     ")
print("                             v2.9.6 with OpenSeesPy\n")
print("Analysis summary\n")
print("Interval 1 : Static")
print("Static Monotonic")
print(f"{int(1+5)} steps")
print("Static Cyclic")
print("Interval 2 : Static")
print("Static Monotonic")
print(f"{int(1+500)} steps")
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
ops.eleLoad('-ele',    293, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    294, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    295, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    296, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    301, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    302, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    303, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    304, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    313, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    314, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    315, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    316, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    321, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    322, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    323, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    324, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    333, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    334, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    335, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    336, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    337, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    338, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    339, '-type', '-beamUniform',      -15,        0)
ops.eleLoad('-ele',    340, '-type', '-beamUniform',      -15,        0)

# recording the initial status

ops.record()

# Analysis options

ops.wipeAnalysis()
ops.system('BandGeneral')
ops.numberer('RCM')
ops.constraints('Transformation')
ops.integrator("LoadControl", 0.2)
ops.test("RelativeEnergyIncr", 1e-08, 100, 2)
ops.algorithm("Newton")
ops.analysis('Static')

Lincr = 0.200000
Nsteps = 5
committedSteps = 1
LoadCounter = 0

strIni = ""
testTypeStatic = 'RelativeEnergyIncr'

TolStatic = 1e-08
maxNumIterStatic = 100
algorithmTypeStatic = 'Newton'


for i in range(Nsteps):
    t = ops.getTime() + Lincr
    print(f"(1) {algorithmTypeStatic}{strIni} LF {t}")
    AnalOk = ops.analyze(1)
    if AnalOk != 0:
        break
    else:
        LoadCounter += 1.0
        committedSteps += 1

if AnalOk !=0:
    firstFail = 1
    AnalOk = 0
    Nk = 1
    returnToInitStepFlag = 0
    while LoadCounter < Nsteps and AnalOk == 0:
        if (Nk == 2 and AnalOk == 0) or (Nk == 1 and AnalOk == 0):
            Nk = 1
            if returnToInitStepFlag:
                print("Back to initial Step")
                returnToInitStepFlag = 0
            if firstFail == 0: # for the first time only, do not repeat previous failed step
                ops.integrator("LoadControl", Lincr) # reset to original increment
                t = ops.getTime() + Lincr
                print(f"(1) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
            else:
                AnalOk = 1
                firstFail = 0
            if AnalOk == 0:
                LoadCounter += 1.0 / Nk
                committedSteps += 1

        # substepping /2
        if (AnalOk !=0 and Nk==1) or (AnalOk==0 and Nk==4):
            Nk = 2; # reduce step size
            continueFlag = 1
            print("Initial step is divided by 2")
            LincrReduced = Lincr/ Nk
            ops.integrator("LoadControl", LincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + LincrReduced
                print(f"(1) {algorithmTypeStatic}{strIni} LF {t}")
                AnalOk = ops.analyze(1); # zero for convergence
                if AnalOk == 0:
                    LoadCounter += 1.0 / Nk
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1

        # substepping /4
        if (AnalOk !=0 and Nk==2) or (AnalOk==0 and Nk==8):
            Nk = 4 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 4")
            LincrReduced = Lincr / Nk
            ops.integrator("LoadControl", LincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + LincrReduced
                print("(1) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    LoadCounter += 1.0 / Nk
                    committedSteps += 1
                else:
                    continueFlag = 0
            if AnalOk == 0:
                returnToInitStepFlag = 1
        # end if Nk=4
        # substepping /8
        if (AnalOk !=0 and Nk==4) or (Nk == 16 and AnalOk == 0):
            Nk = 8 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 8")
            LincrReduced = Lincr / Nk
            ops.integrator("LoadControl", LincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + LincrReduced
                print(f"(1) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    LoadCounter += 1.0 / Nk
                    committedSteps += 1
                else:
                    continueFlag = 0
            if AnalOk == 0:
                returnToInitStepFlag = 1
        # end if Nk=8
        # substepping /16
        if Nk == 8 and AnalOk!=0:
            Nk = 16 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 16")
            LincrReduced = Lincr / Nk
            ops.integrator("LoadControl", LincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + LincrReduced
                print(f"(1) {algorithmTypeStatic}{strIni} LF {t}")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    LoadCounter += 1.0 / Nk
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1
        # end if Nk=16
# end while loop
# end if AnalOk

if AnalOk == 0:
    print("Analysis completed SUCCESSFULLY")
    print(f"Committed steps : {committedSteps}")
else:
    print("Analysis FAILED")
    print(f"Committed steps : {committedSteps}")

# all previously defined patterns are constant for so on.

ops.loadConst("-time", 0.0)

# --------------------------------------------------------------------------------------------------------------
#
# I N T E R V A L   2
#
# --------------------------------------------------------------------------------------------------------------

print("Running interval 2")

# Loads - Plain Pattern

ops.timeSeries('Linear', 400)
ops.pattern('Plain', 200, 400)
ops.load(     1,      0.5,        0,        0)
ops.load(     8,    0.333,        0,        0)
ops.load(    28,   0.1666,        0,        0)

# recording the initial status

ops.record()

# Analysis options

ops.wipeAnalysis()
ops.system('BandGeneral')
ops.numberer('RCM')
ops.constraints('Transformation')
ops.integrator("DisplacementControl", 27, 1, 0.0016)
ops.test("NormDispIncr", 1e-08, 500, 2)
ops.algorithm("Newton")
ops.analysis('Static')

Dmax = 0.8
Dincr = 0.001600
Nsteps = 500
committedSteps = 1
IDctrlNode = 27
IDctrlDOF = 1

strIni = ""
testTypeStatic = 'NormDispIncr'
TolStatic = 1e-08
maxNumIterStatic = 500
algorithmTypeStatic = 'Newton'

for i in range(Nsteps):
    t = ops.getTime()
    print(f"(2) {algorithmTypeStatic}{strIni} LF {t} ")
    AnalOk = ops.analyze(1)
    if AnalOk !=0:
        break
    else:
        committedSteps += 1


if AnalOk != 0: # if analysis fails, alternative algorithms and substepping is applied
    firstFail = 1
    Dstep = 0.0
    AnalOk = 0
    Nk = 1
    returnToInitStepFlag = 0
    while Dstep <= 1.0 and AnalOk == 0:
        controlDisp = ops.nodeDisp(IDctrlNode, IDctrlDOF)
        Dstep = controlDisp / Dmax
        if (Nk==2 and AnalOk==0) or (Nk==1 and AnalOk==0):
            Nk = 1
            if returnToInitStepFlag:
                print("Back to initial step")
                returnToInitStepFlag = 0
            if firstFail == 0: # for the first time only, do not repeat previous failed step
                ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, Dincr) # reset to original increment
                t = ops.getTime()
                print(f"(2) {algorithmTypeStatic}{strIni} LF {t}")
                AnalOk = ops.analyze(1) # zero for convergence
            else:
                AnalOk = 1
                firstFail = 0
            if AnalOk == 0:
                committedSteps += 1
        # end if Nk=1
        # substepping /2
        if (AnalOk !=0 and Nk==1) or (AnalOk==0 and Nk==4):
            Nk = 2 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 2")
            DincrReduced = Dincr / Nk
            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime()
                print(f"(2) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0
            if AnalOk == 0:
                returnToInitStepFlag = 1
        # end if Nk=2
        # substepping /4
        if (AnalOk !=0 and Nk==2) or (AnalOk==0 and Nk==8):
            Nk = 4 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 4")
            DincrReduced = Dincr / Nk
            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime()
                print(f"(2) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0
            if AnalOk == 0:
                returnToInitStepFlag = 1

        # end if Nk=4
        # substepping /8
        if (AnalOk !=0 and Nk==4) or (Nk == 16 and AnalOk == 0):
            Nk = 8 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 8")
            DincrReduced = Dincr / Nk
            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime()
                print(f"(2) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1
        # end if Nk=8
        # substepping /16
        if (Nk == 8 and AnalOk!=0):
            Nk = 16 # reduce step size
            continueFlag = 1
            print("Initial step is divided by 16")
            DincrReduced = Dincr / Nk
            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime()
                print(f"(2) {algorithmTypeStatic}{strIni} LF {t} ")
                AnalOk = ops.analyze(1) # zero for convergence
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0
            if AnalOk == 0:
                returnToInitStepFlag = 1
        # end if Nk=16
        controlDisp = ops.nodeDisp(IDctrlNode, IDctrlDOF)
        Dstep = controlDisp / Dmax
    # end while loop
# end if AnalOk

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
# 382

# Elements 1D
# 60

# Elements 2D
# 288

# Elements 3D
# 0

# ForceBeamColumn
# 60
# 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348

# Quad
# 288
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288

# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
# F R A M E   L O C A L   A X E S   O R I E N T A T I O N
#
# -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#      ID                           Type                       Local-x                       Local-y                       Local-z          Literal      Material / Section
#
#     289                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     290                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     291                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     292                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     293                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     294                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     295                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     296                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     297                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     298                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     299                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     300                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     301                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     302                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     303                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     304                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     305                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     306                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     307                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     308                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     309                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     310                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     311                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     312                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     313                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     314                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     315                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     316                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     317                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     318                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     319                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     320                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     321                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     322                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     323                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     324                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     325                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     326                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     327                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     328                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     329                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     330                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     331                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     332                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     333                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     334                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     335                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     336                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     337                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     338                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     339                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     340                forceBeamColumn     {+1.0000 +0.0000 +0.0000}     {+0.0000 +1.0000 +0.0000}     {+0.0000 +0.0000 +1.0000}     { +X +Y +Z };   # Fiber - Beam
#     341                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     342                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     343                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     344                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     345                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     346                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     347                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column
#     348                forceBeamColumn     {+0.0000 +1.0000 +0.0000}     {-1.0000 +0.0000 +0.0000}     {+0.0000 -0.0000 +1.0000}     { +Y -X +Z };   # Fiber - Column

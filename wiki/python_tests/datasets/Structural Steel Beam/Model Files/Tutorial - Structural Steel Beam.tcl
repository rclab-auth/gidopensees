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

# Structural steel column (270)

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  3DOF  (3)
#
# --------------------------------------------------------------------------------------------------------------

model BasicBuilder -ndm 3 -ndf 3

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord $Zcoord

node      1          0.6            6          0.8
node      2          0.6            6          0.7
node      3          0.4            6          0.8
node      4          0.6          5.8          0.8
node      5          0.6          5.8          0.7
node      6         0.35            6          0.7
node      7          0.4          5.8          0.8
node      8         0.35          5.8          0.7
node      9         0.25            6          0.7
node     10         0.35            6          0.5
node     11          0.2            6          0.8
node     12          0.6          5.6          0.8
node     13          0.6          5.6          0.7
node     14         0.25          5.8          0.7
node     15         0.35          5.8          0.5
node     16          0.2          5.8          0.8
node     17          0.4          5.6          0.8
node     18         0.25            6          0.5
node     19         0.35          5.6          0.7
node     20         0.25          5.8          0.5
node     21         0.25          5.6          0.7
node     22         0.35            6          0.3
node     23         0.35          5.6          0.5
node     24          0.2          5.6          0.8
node     25         0.35          5.8          0.3
node     26            0            6          0.8
node     27          0.6          5.4          0.8
node     28            0            6          0.7
node     29          0.6          5.4          0.7
node     30         0.25            6          0.3
node     31         0.25          5.6          0.5
node     32            0          5.8          0.8
node     33          0.4          5.4          0.8
node     34            0          5.8          0.7
node     35         0.25          5.8          0.3
node     36         0.35          5.4          0.7
node     37         0.35          5.6          0.3
node     38          0.6            6          0.1
node     39         0.25          5.4          0.7
node     40         0.35          5.4          0.5
node     41            0          5.6          0.8
node     42          0.2          5.4          0.8
node     43          0.6          5.8          0.1
node     44            0          5.6          0.7
node     45         0.25          5.6          0.3
node     46         0.35            6          0.1
node     47         0.25          5.4          0.5
node     48         0.35          5.8          0.1
node     49         0.25            6          0.1
node     50          0.6            6            0
node     51          0.6          5.2          0.8
node     52          0.6          5.6          0.1
node     53          0.6          5.2          0.7
node     54         0.25          5.8          0.1
node     55         0.35          5.4          0.3
node     56          0.4            6            0
node     57          0.6          5.8            0
node     58          0.4          5.2          0.8
node     59         0.35          5.6          0.1
node     60         0.35          5.2          0.7
node     61          0.4          5.8            0
node     62            0          5.4          0.8
node     63            0          5.4          0.7
node     64         0.25          5.4          0.3
node     65         0.25          5.6          0.1
node     66         0.25          5.2          0.7
node     67         0.35          5.2          0.5
node     68          0.2            6            0
node     69          0.6          5.6            0
node     70          0.2          5.2          0.8
node     71          0.2          5.8            0
node     72          0.4          5.6            0
node     73            0            6          0.1
node     74          0.6          5.4          0.1
node     75         0.25          5.2          0.5
node     76            0          5.8          0.1
node     77         0.35          5.4          0.1
node     78         0.35          5.2          0.3
node     79          0.2          5.6            0
node     80         0.25          5.4          0.1
node     81            0            6            0
node     82          0.6          5.4            0
node     83          0.6            5          0.8
node     84            0          5.2          0.8
node     85            0          5.6          0.1
node     86            0          5.2          0.7
node     87          0.6            5          0.7
node     88         0.25          5.2          0.3
node     89            0          5.8            0
node     90          0.4          5.4            0
node     91          0.4            5          0.8
node     92         0.35            5          0.7
node     93          0.6          5.2          0.1
node     94         0.25            5          0.7
node     95         0.35            5          0.5
node     96            0          5.6            0
node     97          0.2          5.4            0
node     98          0.2            5          0.8
node     99         0.35          5.2          0.1
node    100            0          5.4          0.1
node    101         0.25            5          0.5
node    102         0.25          5.2          0.1
node    103          0.6          5.2            0
node    104         0.35            5          0.3
node    105          0.4          5.2            0
node    106            0          5.4            0
node    107            0            5          0.8
node    108            0            5          0.7
node    109         0.25            5          0.3
node    110          0.2          5.2            0
node    111          0.6          4.8          0.8
node    112          0.6          4.8          0.7
node    113          0.4          4.8          0.8
node    114            0          5.2          0.1
node    115          0.6            5          0.1
node    116         0.35          4.8          0.7
node    117         0.35            5          0.1
node    118         0.25          4.8          0.7
node    119         0.35          4.8          0.5
node    120          0.2          4.8          0.8
node    121         0.25            5          0.1
node    122            0          5.2            0
node    123          0.6            5            0
node    124         0.25          4.8          0.5
node    125          0.4            5            0
node    126         0.35          4.8          0.3
node    127          0.2            5            0
node    128            0          4.8          0.8
node    129            0          4.8          0.7
node    130         0.25          4.8          0.3
node    131            0            5          0.1
node    132          0.6          4.8          0.1
node    133          0.6          4.6          0.8
node    134          0.6          4.6          0.7
node    135         0.35          4.8          0.1
node    136          0.4          4.6          0.8
node    137            0            5            0
node    138         0.35          4.6          0.7
node    139         0.25          4.8          0.1
node    140          0.6          4.8            0
node    141         0.25          4.6          0.7
node    142         0.35          4.6          0.5
node    143          0.2          4.6          0.8
node    144          0.4          4.8            0
node    145         0.25          4.6          0.5
node    146          0.2          4.8            0
node    147         0.35          4.6          0.3
node    148            0          4.8          0.1
node    149            0          4.6          0.8
node    150            0          4.6          0.7
node    151         0.25          4.6          0.3
node    152            0          4.8            0
node    153          0.6          4.6          0.1
node    154         0.35          4.6          0.1
node    155          0.6          4.4          0.8
node    156          0.6          4.4          0.7
node    157         0.25          4.6          0.1
node    158          0.4          4.4          0.8
node    159          0.6          4.6            0
node    160         0.35          4.4          0.7
node    161          0.4          4.6            0
node    162         0.25          4.4          0.7
node    163         0.35          4.4          0.5
node    164          0.2          4.4          0.8
node    165          0.2          4.6            0
node    166         0.25          4.4          0.5
node    167            0          4.6          0.1
node    168         0.35          4.4          0.3
node    169            0          4.4          0.8
node    170            0          4.4          0.7
node    171         0.25          4.4          0.3
node    172            0          4.6            0
node    173          0.6          4.4          0.1
node    174         0.35          4.4          0.1
node    175         0.25          4.4          0.1
node    176          0.6          4.4            0
node    177          0.6          4.2          0.8
node    178          0.4          4.4            0
node    179          0.6          4.2          0.7
node    180          0.4          4.2          0.8
node    181         0.35          4.2          0.7
node    182          0.2          4.4            0
node    183         0.25          4.2          0.7
node    184         0.35          4.2          0.5
node    185          0.2          4.2          0.8
node    186            0          4.4          0.1
node    187         0.25          4.2          0.5
node    188         0.35          4.2          0.3
node    189            0          4.4            0
node    190            0          4.2          0.8
node    191            0          4.2          0.7
node    192         0.25          4.2          0.3
node    193          0.6          4.2          0.1
node    194         0.35          4.2          0.1
node    195         0.25          4.2          0.1
node    196          0.6          4.2            0
node    197          0.4          4.2            0
node    198          0.6            4          0.8
node    199          0.6            4          0.7
node    200          0.4            4          0.8
node    201          0.2          4.2            0
node    202         0.35            4          0.7
node    203            0          4.2          0.1
node    204         0.25            4          0.7
node    205         0.35            4          0.5
node    206          0.2            4          0.8
node    207         0.25            4          0.5
node    208            0          4.2            0
node    209         0.35            4          0.3
node    210            0            4          0.8
node    211            0            4          0.7
node    212         0.25            4          0.3
node    213          0.6            4          0.1
node    214         0.35            4          0.1
node    215         0.25            4          0.1
node    216          0.6            4            0
node    217          0.4            4            0
node    218          0.2            4            0
node    219          0.6          3.8          0.8
node    220            0            4          0.1
node    221          0.6          3.8          0.7
node    222          0.4          3.8          0.8
node    223         0.35          3.8          0.7
node    224         0.25          3.8          0.7
node    225         0.35          3.8          0.5
node    226          0.2          3.8          0.8
node    227            0            4            0
node    228         0.25          3.8          0.5
node    229         0.35          3.8          0.3
node    230            0          3.8          0.8
node    231            0          3.8          0.7
node    232         0.25          3.8          0.3
node    233          0.6          3.8          0.1
node    234         0.35          3.8          0.1
node    235         0.25          3.8          0.1
node    236          0.6          3.8            0
node    237          0.4          3.8            0
node    238          0.2          3.8            0
node    239            0          3.8          0.1
node    240          0.6          3.6          0.8
node    241          0.6          3.6          0.7
node    242          0.4          3.6          0.8
node    243         0.35          3.6          0.7
node    244            0          3.8            0
node    245         0.25          3.6          0.7
node    246         0.35          3.6          0.5
node    247          0.2          3.6          0.8
node    248         0.25          3.6          0.5
node    249         0.35          3.6          0.3
node    250            0          3.6          0.8
node    251            0          3.6          0.7
node    252         0.25          3.6          0.3
node    253          0.6          3.6          0.1
node    254         0.35          3.6          0.1
node    255         0.25          3.6          0.1
node    256          0.6          3.6            0
node    257          0.4          3.6            0
node    258          0.2          3.6            0
node    259            0          3.6          0.1
node    260          0.6          3.4          0.8
node    261            0          3.6            0
node    262          0.6          3.4          0.7
node    263          0.4          3.4          0.8
node    264         0.35          3.4          0.7
node    265         0.25          3.4          0.7
node    266         0.35          3.4          0.5
node    267          0.2          3.4          0.8
node    268         0.25          3.4          0.5
node    269         0.35          3.4          0.3
node    270            0          3.4          0.8
node    271            0          3.4          0.7
node    272         0.25          3.4          0.3
node    273          0.6          3.4          0.1
node    274         0.35          3.4          0.1
node    275         0.25          3.4          0.1
node    276          0.6          3.4            0
node    277          0.4          3.4            0
node    278          0.2          3.4            0
node    279            0          3.4          0.1
node    280            0          3.4            0
node    281          0.6          3.2          0.8
node    282          0.6          3.2          0.7
node    283          0.4          3.2          0.8
node    284         0.35          3.2          0.7
node    285         0.25          3.2          0.7
node    286         0.35          3.2          0.5
node    287          0.2          3.2          0.8
node    288         0.25          3.2          0.5
node    289         0.35          3.2          0.3
node    290            0          3.2          0.8
node    291            0          3.2          0.7
node    292         0.25          3.2          0.3
node    293          0.6          3.2          0.1
node    294         0.35          3.2          0.1
node    295         0.25          3.2          0.1
node    296          0.6          3.2            0
node    297          0.4          3.2            0
node    298          0.2          3.2            0
node    299            0          3.2          0.1
node    300            0          3.2            0
node    301          0.6            3          0.8
node    302          0.6            3          0.7
node    303          0.4            3          0.8
node    304         0.35            3          0.7
node    305         0.25            3          0.7
node    306         0.35            3          0.5
node    307          0.2            3          0.8
node    308         0.25            3          0.5
node    309         0.35            3          0.3
node    310            0            3          0.8
node    311            0            3          0.7
node    312         0.25            3          0.3
node    313          0.6            3          0.1
node    314         0.35            3          0.1
node    315         0.25            3          0.1
node    316          0.6            3            0
node    317          0.4            3            0
node    318          0.2            3            0
node    319            0            3          0.1
node    320            0            3            0
node    321          0.6          2.8          0.8
node    322          0.6          2.8          0.7
node    323          0.4          2.8          0.8
node    324         0.35          2.8          0.7
node    325         0.25          2.8          0.7
node    326         0.35          2.8          0.5
node    327          0.2          2.8          0.8
node    328         0.25          2.8          0.5
node    329         0.35          2.8          0.3
node    330            0          2.8          0.8
node    331            0          2.8          0.7
node    332         0.25          2.8          0.3
node    333          0.6          2.8          0.1
node    334         0.35          2.8          0.1
node    335         0.25          2.8          0.1
node    336          0.6          2.8            0
node    337          0.4          2.8            0
node    338          0.2          2.8            0
node    339            0          2.8          0.1
node    340            0          2.8            0
node    341          0.6          2.6          0.8
node    342          0.6          2.6          0.7
node    343          0.4          2.6          0.8
node    344         0.35          2.6          0.7
node    345         0.25          2.6          0.7
node    346         0.35          2.6          0.5
node    347          0.2          2.6          0.8
node    348         0.25          2.6          0.5
node    349         0.35          2.6          0.3
node    350            0          2.6          0.8
node    351            0          2.6          0.7
node    352         0.25          2.6          0.3
node    353          0.6          2.6          0.1
node    354         0.35          2.6          0.1
node    355         0.25          2.6          0.1
node    356          0.6          2.6            0
node    357          0.4          2.6            0
node    358          0.2          2.6            0
node    359            0          2.6          0.1
node    360            0          2.6            0
node    361          0.6          2.4          0.8
node    362          0.6          2.4          0.7
node    363          0.4          2.4          0.8
node    364         0.35          2.4          0.7
node    365         0.25          2.4          0.7
node    366         0.35          2.4          0.5
node    367          0.2          2.4          0.8
node    368         0.25          2.4          0.5
node    369         0.35          2.4          0.3
node    370            0          2.4          0.8
node    371            0          2.4          0.7
node    372         0.25          2.4          0.3
node    373          0.6          2.4          0.1
node    374         0.35          2.4          0.1
node    375         0.25          2.4          0.1
node    376          0.6          2.4            0
node    377          0.4          2.4            0
node    378          0.2          2.4            0
node    379            0          2.4          0.1
node    380            0          2.4            0
node    381          0.6          2.2          0.8
node    382          0.6          2.2          0.7
node    383          0.4          2.2          0.8
node    384         0.35          2.2          0.7
node    385         0.25          2.2          0.7
node    386         0.35          2.2          0.5
node    387          0.2          2.2          0.8
node    388         0.25          2.2          0.5
node    389         0.35          2.2          0.3
node    390            0          2.2          0.8
node    391            0          2.2          0.7
node    392         0.25          2.2          0.3
node    393          0.6          2.2          0.1
node    394         0.35          2.2          0.1
node    395         0.25          2.2          0.1
node    396          0.6          2.2            0
node    397          0.4          2.2            0
node    398          0.2          2.2            0
node    399            0          2.2          0.1
node    400            0          2.2            0
node    401          0.6            2          0.8
node    402          0.6            2          0.7
node    403          0.4            2          0.8
node    404         0.35            2          0.7
node    405         0.25            2          0.7
node    406         0.35            2          0.5
node    407          0.2            2          0.8
node    408         0.25            2          0.5
node    409         0.35            2          0.3
node    410            0            2          0.8
node    411            0            2          0.7
node    412         0.25            2          0.3
node    413          0.6            2          0.1
node    414         0.35            2          0.1
node    415         0.25            2          0.1
node    416          0.6            2            0
node    417          0.4            2            0
node    418          0.2            2            0
node    419            0            2          0.1
node    420            0            2            0
node    421          0.6          1.8          0.8
node    422          0.6          1.8          0.7
node    423          0.4          1.8          0.8
node    424         0.35          1.8          0.7
node    425         0.25          1.8          0.7
node    426         0.35          1.8          0.5
node    427          0.2          1.8          0.8
node    428         0.25          1.8          0.5
node    429         0.35          1.8          0.3
node    430            0          1.8          0.8
node    431            0          1.8          0.7
node    432         0.25          1.8          0.3
node    433          0.6          1.8          0.1
node    434         0.35          1.8          0.1
node    435         0.25          1.8          0.1
node    436          0.6          1.8            0
node    437          0.4          1.8            0
node    438          0.2          1.8            0
node    439            0          1.8          0.1
node    440            0          1.8            0
node    441          0.6          1.6          0.8
node    442          0.6          1.6          0.7
node    443          0.4          1.6          0.8
node    444         0.35          1.6          0.7
node    445         0.25          1.6          0.7
node    446         0.35          1.6          0.5
node    447          0.2          1.6          0.8
node    448         0.25          1.6          0.5
node    449         0.35          1.6          0.3
node    450            0          1.6          0.8
node    451            0          1.6          0.7
node    452         0.25          1.6          0.3
node    453          0.6          1.6          0.1
node    454         0.35          1.6          0.1
node    455         0.25          1.6          0.1
node    456          0.6          1.6            0
node    457          0.4          1.6            0
node    458          0.2          1.6            0
node    459            0          1.6          0.1
node    460            0          1.6            0
node    461          0.6          1.4          0.8
node    462          0.6          1.4          0.7
node    463          0.4          1.4          0.8
node    464         0.35          1.4          0.7
node    465         0.25          1.4          0.7
node    466         0.35          1.4          0.5
node    467          0.2          1.4          0.8
node    468         0.25          1.4          0.5
node    469         0.35          1.4          0.3
node    470            0          1.4          0.8
node    471            0          1.4          0.7
node    472         0.25          1.4          0.3
node    473          0.6          1.4          0.1
node    474         0.35          1.4          0.1
node    475         0.25          1.4          0.1
node    476          0.6          1.4            0
node    477          0.4          1.4            0
node    478          0.2          1.4            0
node    479            0          1.4          0.1
node    480            0          1.4            0
node    481          0.6          1.2          0.8
node    482          0.6          1.2          0.7
node    483          0.4          1.2          0.8
node    484         0.35          1.2          0.7
node    485         0.25          1.2          0.7
node    486         0.35          1.2          0.5
node    487          0.2          1.2          0.8
node    488         0.25          1.2          0.5
node    489         0.35          1.2          0.3
node    490            0          1.2          0.8
node    491            0          1.2          0.7
node    492         0.25          1.2          0.3
node    493          0.6          1.2          0.1
node    494         0.35          1.2          0.1
node    495         0.25          1.2          0.1
node    496          0.6          1.2            0
node    497          0.4          1.2            0
node    498          0.2          1.2            0
node    499            0          1.2          0.1
node    500            0          1.2            0
node    501          0.6            1          0.8
node    502          0.6            1          0.7
node    503          0.4            1          0.8
node    504         0.35            1          0.7
node    505         0.25            1          0.7
node    506         0.35            1          0.5
node    507          0.2            1          0.8
node    508         0.25            1          0.5
node    509         0.35            1          0.3
node    510            0            1          0.8
node    511            0            1          0.7
node    512         0.25            1          0.3
node    513          0.6            1          0.1
node    514         0.35            1          0.1
node    515         0.25            1          0.1
node    516          0.6            1            0
node    517          0.4            1            0
node    518          0.2            1            0
node    519            0            1          0.1
node    520            0            1            0
node    521          0.6          0.8          0.8
node    522          0.6          0.8          0.7
node    523          0.4          0.8          0.8
node    524         0.35          0.8          0.7
node    525         0.25          0.8          0.7
node    526         0.35          0.8          0.5
node    527          0.2          0.8          0.8
node    528         0.25          0.8          0.5
node    529         0.35          0.8          0.3
node    530            0          0.8          0.8
node    531            0          0.8          0.7
node    532         0.25          0.8          0.3
node    533          0.6          0.8          0.1
node    534         0.35          0.8          0.1
node    535         0.25          0.8          0.1
node    536          0.6          0.8            0
node    537          0.4          0.8            0
node    538          0.2          0.8            0
node    539            0          0.8          0.1
node    540            0          0.8            0
node    541          0.6          0.6          0.8
node    542          0.6          0.6          0.7
node    543          0.4          0.6          0.8
node    544         0.35          0.6          0.7
node    545         0.25          0.6          0.7
node    546         0.35          0.6          0.5
node    547          0.2          0.6          0.8
node    548         0.25          0.6          0.5
node    549         0.35          0.6          0.3
node    550            0          0.6          0.8
node    551            0          0.6          0.7
node    552         0.25          0.6          0.3
node    553          0.6          0.6          0.1
node    554         0.35          0.6          0.1
node    555         0.25          0.6          0.1
node    556          0.6          0.6            0
node    557          0.4          0.6            0
node    558          0.2          0.6            0
node    559            0          0.6          0.1
node    560            0          0.6            0
node    561          0.6          0.4          0.8
node    562          0.6          0.4          0.7
node    563          0.4          0.4          0.8
node    564         0.35          0.4          0.7
node    565         0.25          0.4          0.7
node    566         0.35          0.4          0.5
node    567          0.2          0.4          0.8
node    568         0.25          0.4          0.5
node    569         0.35          0.4          0.3
node    570            0          0.4          0.8
node    571            0          0.4          0.7
node    572         0.25          0.4          0.3
node    573          0.6          0.4          0.1
node    574         0.35          0.4          0.1
node    575         0.25          0.4          0.1
node    576          0.6          0.4            0
node    577          0.4          0.4            0
node    578          0.2          0.4            0
node    579            0          0.4          0.1
node    580            0          0.4            0
node    581          0.6          0.2          0.8
node    582          0.6          0.2          0.7
node    583          0.4          0.2          0.8
node    584         0.35          0.2          0.7
node    585         0.25          0.2          0.7
node    586         0.35          0.2          0.5
node    587          0.2          0.2          0.8
node    588         0.25          0.2          0.5
node    589         0.35          0.2          0.3
node    590            0          0.2          0.8
node    591            0          0.2          0.7
node    592         0.25          0.2          0.3
node    593          0.6          0.2          0.1
node    594         0.35          0.2          0.1
node    595         0.25          0.2          0.1
node    596          0.6          0.2            0
node    597          0.4          0.2            0
node    598          0.2          0.2            0
node    599            0          0.2          0.1
node    600            0          0.2            0
node    601          0.6            0          0.8
node    602          0.6            0          0.7
node    603          0.4            0          0.8
node    604         0.35            0          0.7
node    605         0.25            0          0.7
node    606         0.35            0          0.5
node    607          0.2            0          0.8
node    608         0.25            0          0.5
node    609         0.35            0          0.3
node    610            0            0          0.8
node    611            0            0          0.7
node    612         0.25            0          0.3
node    613          0.6            0          0.1
node    614         0.35            0          0.1
node    615         0.25            0          0.1
node    616          0.6            0            0
node    617          0.4            0            0
node    618          0.2            0            0
node    619            0            0          0.1
node    620            0            0            0

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl z-transl

fix      1   1   1   1
fix      2   1   1   1
fix      3   1   1   1
fix      6   1   1   1
fix      9   1   1   1
fix     10   1   1   1
fix     11   1   1   1
fix     18   1   1   1
fix     22   1   1   1
fix     26   1   1   1
fix     28   1   1   1
fix     30   1   1   1
fix     38   1   1   1
fix     46   1   1   1
fix     49   1   1   1
fix     50   1   1   1
fix     56   1   1   1
fix     68   1   1   1
fix     73   1   1   1
fix     81   1   1   1
fix    601   1   1   1
fix    602   1   1   1
fix    603   1   1   1
fix    604   1   1   1
fix    605   1   1   1
fix    606   1   1   1
fix    607   1   1   1
fix    608   1   1   1
fix    609   1   1   1
fix    610   1   1   1
fix    611   1   1   1
fix    612   1   1   1
fix    613   1   1   1
fix    614   1   1   1
fix    615   1   1   1
fix    616   1   1   1
fix    617   1   1   1
fix    618   1   1   1
fix    619   1   1   1
fix    620   1   1   1

# --------------------------------------------------------------------------------------------------------------
# S T A N D A R D   B R I C K   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# nDMaterial Definition used by stdBrick Elements
# (if they have not already been defined on this model domain)

nDMaterial ElasticIsotropic 359 2e+08 0.3            0

# stdBrick element definition: element stdBrick $eleTag $node1 $node2 $node3 $node4 $node5 $node6 $node7 $node8 $matTag <$b1 $b2 $b3>

element stdBrick      1     28      9     11     26     34     14     16     32    359        0        0        0 ; # Steel
element stdBrick      2     34     14     16     32     44     21     24     41    359        0        0        0 ; # Steel
element stdBrick      3     44     21     24     41     63     39     42     62    359        0        0        0 ; # Steel
element stdBrick      4     63     39     42     62     86     66     70     84    359        0        0        0 ; # Steel
element stdBrick      5     86     66     70     84    108     94     98    107    359        0        0        0 ; # Steel
element stdBrick      6    108     94     98    107    129    118    120    128    359        0        0        0 ; # Steel
element stdBrick      7    129    118    120    128    150    141    143    149    359        0        0        0 ; # Steel
element stdBrick      8    150    141    143    149    170    162    164    169    359        0        0        0 ; # Steel
element stdBrick      9    170    162    164    169    191    183    185    190    359        0        0        0 ; # Steel
element stdBrick     10    191    183    185    190    211    204    206    210    359        0        0        0 ; # Steel
element stdBrick     11    211    204    206    210    231    224    226    230    359        0        0        0 ; # Steel
element stdBrick     12    231    224    226    230    251    245    247    250    359        0        0        0 ; # Steel
element stdBrick     13    251    245    247    250    271    265    267    270    359        0        0        0 ; # Steel
element stdBrick     14    271    265    267    270    291    285    287    290    359        0        0        0 ; # Steel
element stdBrick     15    291    285    287    290    311    305    307    310    359        0        0        0 ; # Steel
element stdBrick     16    311    305    307    310    331    325    327    330    359        0        0        0 ; # Steel
element stdBrick     17    331    325    327    330    351    345    347    350    359        0        0        0 ; # Steel
element stdBrick     18    351    345    347    350    371    365    367    370    359        0        0        0 ; # Steel
element stdBrick     19    371    365    367    370    391    385    387    390    359        0        0        0 ; # Steel
element stdBrick     20    391    385    387    390    411    405    407    410    359        0        0        0 ; # Steel
element stdBrick     21    411    405    407    410    431    425    427    430    359        0        0        0 ; # Steel
element stdBrick     22    431    425    427    430    451    445    447    450    359        0        0        0 ; # Steel
element stdBrick     23    451    445    447    450    471    465    467    470    359        0        0        0 ; # Steel
element stdBrick     24    471    465    467    470    491    485    487    490    359        0        0        0 ; # Steel
element stdBrick     25    491    485    487    490    511    505    507    510    359        0        0        0 ; # Steel
element stdBrick     26    511    505    507    510    531    525    527    530    359        0        0        0 ; # Steel
element stdBrick     27    531    525    527    530    551    545    547    550    359        0        0        0 ; # Steel
element stdBrick     28    551    545    547    550    571    565    567    570    359        0        0        0 ; # Steel
element stdBrick     29    571    565    567    570    591    585    587    590    359        0        0        0 ; # Steel
element stdBrick     30    591    585    587    590    611    605    607    610    359        0        0        0 ; # Steel
element stdBrick     31      1      3      6      2      4      7      8      5    359        0        0        0 ; # Steel
element stdBrick     32      4      7      8      5     12     17     19     13    359        0        0        0 ; # Steel
element stdBrick     33     12     17     19     13     27     33     36     29    359        0        0        0 ; # Steel
element stdBrick     34     27     33     36     29     51     58     60     53    359        0        0        0 ; # Steel
element stdBrick     35     51     58     60     53     83     91     92     87    359        0        0        0 ; # Steel
element stdBrick     36     83     91     92     87    111    113    116    112    359        0        0        0 ; # Steel
element stdBrick     37    111    113    116    112    133    136    138    134    359        0        0        0 ; # Steel
element stdBrick     38    133    136    138    134    155    158    160    156    359        0        0        0 ; # Steel
element stdBrick     39    155    158    160    156    177    180    181    179    359        0        0        0 ; # Steel
element stdBrick     40    177    180    181    179    198    200    202    199    359        0        0        0 ; # Steel
element stdBrick     41    198    200    202    199    219    222    223    221    359        0        0        0 ; # Steel
element stdBrick     42    219    222    223    221    240    242    243    241    359        0        0        0 ; # Steel
element stdBrick     43    240    242    243    241    260    263    264    262    359        0        0        0 ; # Steel
element stdBrick     44    260    263    264    262    281    283    284    282    359        0        0        0 ; # Steel
element stdBrick     45    281    283    284    282    301    303    304    302    359        0        0        0 ; # Steel
element stdBrick     46    301    303    304    302    321    323    324    322    359        0        0        0 ; # Steel
element stdBrick     47    321    323    324    322    341    343    344    342    359        0        0        0 ; # Steel
element stdBrick     48    341    343    344    342    361    363    364    362    359        0        0        0 ; # Steel
element stdBrick     49    361    363    364    362    381    383    384    382    359        0        0        0 ; # Steel
element stdBrick     50    381    383    384    382    401    403    404    402    359        0        0        0 ; # Steel
element stdBrick     51    401    403    404    402    421    423    424    422    359        0        0        0 ; # Steel
element stdBrick     52    421    423    424    422    441    443    444    442    359        0        0        0 ; # Steel
element stdBrick     53    441    443    444    442    461    463    464    462    359        0        0        0 ; # Steel
element stdBrick     54    461    463    464    462    481    483    484    482    359        0        0        0 ; # Steel
element stdBrick     55    481    483    484    482    501    503    504    502    359        0        0        0 ; # Steel
element stdBrick     56    501    503    504    502    521    523    524    522    359        0        0        0 ; # Steel
element stdBrick     57    521    523    524    522    541    543    544    542    359        0        0        0 ; # Steel
element stdBrick     58    541    543    544    542    561    563    564    562    359        0        0        0 ; # Steel
element stdBrick     59    561    563    564    562    581    583    584    582    359        0        0        0 ; # Steel
element stdBrick     60    581    583    584    582    601    603    604    602    359        0        0        0 ; # Steel
element stdBrick     61     38     46     56     50     43     48     61     57    359        0        0        0 ; # Steel
element stdBrick     62     43     48     61     57     52     59     72     69    359        0        0        0 ; # Steel
element stdBrick     63     52     59     72     69     74     77     90     82    359        0        0        0 ; # Steel
element stdBrick     64     74     77     90     82     93     99    105    103    359        0        0        0 ; # Steel
element stdBrick     65     93     99    105    103    115    117    125    123    359        0        0        0 ; # Steel
element stdBrick     66    115    117    125    123    132    135    144    140    359        0        0        0 ; # Steel
element stdBrick     67    132    135    144    140    153    154    161    159    359        0        0        0 ; # Steel
element stdBrick     68    153    154    161    159    173    174    178    176    359        0        0        0 ; # Steel
element stdBrick     69    173    174    178    176    193    194    197    196    359        0        0        0 ; # Steel
element stdBrick     70    193    194    197    196    213    214    217    216    359        0        0        0 ; # Steel
element stdBrick     71    213    214    217    216    233    234    237    236    359        0        0        0 ; # Steel
element stdBrick     72    233    234    237    236    253    254    257    256    359        0        0        0 ; # Steel
element stdBrick     73    253    254    257    256    273    274    277    276    359        0        0        0 ; # Steel
element stdBrick     74    273    274    277    276    293    294    297    296    359        0        0        0 ; # Steel
element stdBrick     75    293    294    297    296    313    314    317    316    359        0        0        0 ; # Steel
element stdBrick     76    313    314    317    316    333    334    337    336    359        0        0        0 ; # Steel
element stdBrick     77    333    334    337    336    353    354    357    356    359        0        0        0 ; # Steel
element stdBrick     78    353    354    357    356    373    374    377    376    359        0        0        0 ; # Steel
element stdBrick     79    373    374    377    376    393    394    397    396    359        0        0        0 ; # Steel
element stdBrick     80    393    394    397    396    413    414    417    416    359        0        0        0 ; # Steel
element stdBrick     81    413    414    417    416    433    434    437    436    359        0        0        0 ; # Steel
element stdBrick     82    433    434    437    436    453    454    457    456    359        0        0        0 ; # Steel
element stdBrick     83    453    454    457    456    473    474    477    476    359        0        0        0 ; # Steel
element stdBrick     84    473    474    477    476    493    494    497    496    359        0        0        0 ; # Steel
element stdBrick     85    493    494    497    496    513    514    517    516    359        0        0        0 ; # Steel
element stdBrick     86    513    514    517    516    533    534    537    536    359        0        0        0 ; # Steel
element stdBrick     87    533    534    537    536    553    554    557    556    359        0        0        0 ; # Steel
element stdBrick     88    553    554    557    556    573    574    577    576    359        0        0        0 ; # Steel
element stdBrick     89    573    574    577    576    593    594    597    596    359        0        0        0 ; # Steel
element stdBrick     90    593    594    597    596    613    614    617    616    359        0        0        0 ; # Steel
element stdBrick     91     81     68     49     73     89     71     54     76    359        0        0        0 ; # Steel
element stdBrick     92     89     71     54     76     96     79     65     85    359        0        0        0 ; # Steel
element stdBrick     93     96     79     65     85    106     97     80    100    359        0        0        0 ; # Steel
element stdBrick     94    106     97     80    100    122    110    102    114    359        0        0        0 ; # Steel
element stdBrick     95    122    110    102    114    137    127    121    131    359        0        0        0 ; # Steel
element stdBrick     96    137    127    121    131    152    146    139    148    359        0        0        0 ; # Steel
element stdBrick     97    152    146    139    148    172    165    157    167    359        0        0        0 ; # Steel
element stdBrick     98    172    165    157    167    189    182    175    186    359        0        0        0 ; # Steel
element stdBrick     99    189    182    175    186    208    201    195    203    359        0        0        0 ; # Steel
element stdBrick    100    208    201    195    203    227    218    215    220    359        0        0        0 ; # Steel
element stdBrick    101    227    218    215    220    244    238    235    239    359        0        0        0 ; # Steel
element stdBrick    102    244    238    235    239    261    258    255    259    359        0        0        0 ; # Steel
element stdBrick    103    261    258    255    259    280    278    275    279    359        0        0        0 ; # Steel
element stdBrick    104    280    278    275    279    300    298    295    299    359        0        0        0 ; # Steel
element stdBrick    105    300    298    295    299    320    318    315    319    359        0        0        0 ; # Steel
element stdBrick    106    320    318    315    319    340    338    335    339    359        0        0        0 ; # Steel
element stdBrick    107    340    338    335    339    360    358    355    359    359        0        0        0 ; # Steel
element stdBrick    108    360    358    355    359    380    378    375    379    359        0        0        0 ; # Steel
element stdBrick    109    380    378    375    379    400    398    395    399    359        0        0        0 ; # Steel
element stdBrick    110    400    398    395    399    420    418    415    419    359        0        0        0 ; # Steel
element stdBrick    111    420    418    415    419    440    438    435    439    359        0        0        0 ; # Steel
element stdBrick    112    440    438    435    439    460    458    455    459    359        0        0        0 ; # Steel
element stdBrick    113    460    458    455    459    480    478    475    479    359        0        0        0 ; # Steel
element stdBrick    114    480    478    475    479    500    498    495    499    359        0        0        0 ; # Steel
element stdBrick    115    500    498    495    499    520    518    515    519    359        0        0        0 ; # Steel
element stdBrick    116    520    518    515    519    540    538    535    539    359        0        0        0 ; # Steel
element stdBrick    117    540    538    535    539    560    558    555    559    359        0        0        0 ; # Steel
element stdBrick    118    560    558    555    559    580    578    575    579    359        0        0        0 ; # Steel
element stdBrick    119    580    578    575    579    600    598    595    599    359        0        0        0 ; # Steel
element stdBrick    120    600    598    595    599    620    618    615    619    359        0        0        0 ; # Steel
element stdBrick    121     11      9      6      3     16     14      8      7    359        0        0        0 ; # Steel
element stdBrick    122     16     14      8      7     24     21     19     17    359        0        0        0 ; # Steel
element stdBrick    123     24     21     19     17     42     39     36     33    359        0        0        0 ; # Steel
element stdBrick    124     42     39     36     33     70     66     60     58    359        0        0        0 ; # Steel
element stdBrick    125     70     66     60     58     98     94     92     91    359        0        0        0 ; # Steel
element stdBrick    126     98     94     92     91    120    118    116    113    359        0        0        0 ; # Steel
element stdBrick    127    120    118    116    113    143    141    138    136    359        0        0        0 ; # Steel
element stdBrick    128    143    141    138    136    164    162    160    158    359        0        0        0 ; # Steel
element stdBrick    129    164    162    160    158    185    183    181    180    359        0        0        0 ; # Steel
element stdBrick    130    185    183    181    180    206    204    202    200    359        0        0        0 ; # Steel
element stdBrick    131    206    204    202    200    226    224    223    222    359        0        0        0 ; # Steel
element stdBrick    132    226    224    223    222    247    245    243    242    359        0        0        0 ; # Steel
element stdBrick    133    247    245    243    242    267    265    264    263    359        0        0        0 ; # Steel
element stdBrick    134    267    265    264    263    287    285    284    283    359        0        0        0 ; # Steel
element stdBrick    135    287    285    284    283    307    305    304    303    359        0        0        0 ; # Steel
element stdBrick    136    307    305    304    303    327    325    324    323    359        0        0        0 ; # Steel
element stdBrick    137    327    325    324    323    347    345    344    343    359        0        0        0 ; # Steel
element stdBrick    138    347    345    344    343    367    365    364    363    359        0        0        0 ; # Steel
element stdBrick    139    367    365    364    363    387    385    384    383    359        0        0        0 ; # Steel
element stdBrick    140    387    385    384    383    407    405    404    403    359        0        0        0 ; # Steel
element stdBrick    141    407    405    404    403    427    425    424    423    359        0        0        0 ; # Steel
element stdBrick    142    427    425    424    423    447    445    444    443    359        0        0        0 ; # Steel
element stdBrick    143    447    445    444    443    467    465    464    463    359        0        0        0 ; # Steel
element stdBrick    144    467    465    464    463    487    485    484    483    359        0        0        0 ; # Steel
element stdBrick    145    487    485    484    483    507    505    504    503    359        0        0        0 ; # Steel
element stdBrick    146    507    505    504    503    527    525    524    523    359        0        0        0 ; # Steel
element stdBrick    147    527    525    524    523    547    545    544    543    359        0        0        0 ; # Steel
element stdBrick    148    547    545    544    543    567    565    564    563    359        0        0        0 ; # Steel
element stdBrick    149    567    565    564    563    587    585    584    583    359        0        0        0 ; # Steel
element stdBrick    150    587    585    584    583    607    605    604    603    359        0        0        0 ; # Steel
element stdBrick    151      9     18     10      6     14     20     15      8    359        0        0        0 ; # Steel
element stdBrick    152     14     20     15      8     21     31     23     19    359        0        0        0 ; # Steel
element stdBrick    153     21     31     23     19     39     47     40     36    359        0        0        0 ; # Steel
element stdBrick    154     39     47     40     36     66     75     67     60    359        0        0        0 ; # Steel
element stdBrick    155     66     75     67     60     94    101     95     92    359        0        0        0 ; # Steel
element stdBrick    156     94    101     95     92    118    124    119    116    359        0        0        0 ; # Steel
element stdBrick    157    118    124    119    116    141    145    142    138    359        0        0        0 ; # Steel
element stdBrick    158    141    145    142    138    162    166    163    160    359        0        0        0 ; # Steel
element stdBrick    159    162    166    163    160    183    187    184    181    359        0        0        0 ; # Steel
element stdBrick    160    183    187    184    181    204    207    205    202    359        0        0        0 ; # Steel
element stdBrick    161    204    207    205    202    224    228    225    223    359        0        0        0 ; # Steel
element stdBrick    162    224    228    225    223    245    248    246    243    359        0        0        0 ; # Steel
element stdBrick    163    245    248    246    243    265    268    266    264    359        0        0        0 ; # Steel
element stdBrick    164    265    268    266    264    285    288    286    284    359        0        0        0 ; # Steel
element stdBrick    165    285    288    286    284    305    308    306    304    359        0        0        0 ; # Steel
element stdBrick    166    305    308    306    304    325    328    326    324    359        0        0        0 ; # Steel
element stdBrick    167    325    328    326    324    345    348    346    344    359        0        0        0 ; # Steel
element stdBrick    168    345    348    346    344    365    368    366    364    359        0        0        0 ; # Steel
element stdBrick    169    365    368    366    364    385    388    386    384    359        0        0        0 ; # Steel
element stdBrick    170    385    388    386    384    405    408    406    404    359        0        0        0 ; # Steel
element stdBrick    171    405    408    406    404    425    428    426    424    359        0        0        0 ; # Steel
element stdBrick    172    425    428    426    424    445    448    446    444    359        0        0        0 ; # Steel
element stdBrick    173    445    448    446    444    465    468    466    464    359        0        0        0 ; # Steel
element stdBrick    174    465    468    466    464    485    488    486    484    359        0        0        0 ; # Steel
element stdBrick    175    485    488    486    484    505    508    506    504    359        0        0        0 ; # Steel
element stdBrick    176    505    508    506    504    525    528    526    524    359        0        0        0 ; # Steel
element stdBrick    177    525    528    526    524    545    548    546    544    359        0        0        0 ; # Steel
element stdBrick    178    545    548    546    544    565    568    566    564    359        0        0        0 ; # Steel
element stdBrick    179    565    568    566    564    585    588    586    584    359        0        0        0 ; # Steel
element stdBrick    180    585    588    586    584    605    608    606    604    359        0        0        0 ; # Steel
element stdBrick    181     18     30     22     10     20     35     25     15    359        0        0        0 ; # Steel
element stdBrick    182     20     35     25     15     31     45     37     23    359        0        0        0 ; # Steel
element stdBrick    183     31     45     37     23     47     64     55     40    359        0        0        0 ; # Steel
element stdBrick    184     47     64     55     40     75     88     78     67    359        0        0        0 ; # Steel
element stdBrick    185     75     88     78     67    101    109    104     95    359        0        0        0 ; # Steel
element stdBrick    186    101    109    104     95    124    130    126    119    359        0        0        0 ; # Steel
element stdBrick    187    124    130    126    119    145    151    147    142    359        0        0        0 ; # Steel
element stdBrick    188    145    151    147    142    166    171    168    163    359        0        0        0 ; # Steel
element stdBrick    189    166    171    168    163    187    192    188    184    359        0        0        0 ; # Steel
element stdBrick    190    187    192    188    184    207    212    209    205    359        0        0        0 ; # Steel
element stdBrick    191    207    212    209    205    228    232    229    225    359        0        0        0 ; # Steel
element stdBrick    192    228    232    229    225    248    252    249    246    359        0        0        0 ; # Steel
element stdBrick    193    248    252    249    246    268    272    269    266    359        0        0        0 ; # Steel
element stdBrick    194    268    272    269    266    288    292    289    286    359        0        0        0 ; # Steel
element stdBrick    195    288    292    289    286    308    312    309    306    359        0        0        0 ; # Steel
element stdBrick    196    308    312    309    306    328    332    329    326    359        0        0        0 ; # Steel
element stdBrick    197    328    332    329    326    348    352    349    346    359        0        0        0 ; # Steel
element stdBrick    198    348    352    349    346    368    372    369    366    359        0        0        0 ; # Steel
element stdBrick    199    368    372    369    366    388    392    389    386    359        0        0        0 ; # Steel
element stdBrick    200    388    392    389    386    408    412    409    406    359        0        0        0 ; # Steel
element stdBrick    201    408    412    409    406    428    432    429    426    359        0        0        0 ; # Steel
element stdBrick    202    428    432    429    426    448    452    449    446    359        0        0        0 ; # Steel
element stdBrick    203    448    452    449    446    468    472    469    466    359        0        0        0 ; # Steel
element stdBrick    204    468    472    469    466    488    492    489    486    359        0        0        0 ; # Steel
element stdBrick    205    488    492    489    486    508    512    509    506    359        0        0        0 ; # Steel
element stdBrick    206    508    512    509    506    528    532    529    526    359        0        0        0 ; # Steel
element stdBrick    207    528    532    529    526    548    552    549    546    359        0        0        0 ; # Steel
element stdBrick    208    548    552    549    546    568    572    569    566    359        0        0        0 ; # Steel
element stdBrick    209    568    572    569    566    588    592    589    586    359        0        0        0 ; # Steel
element stdBrick    210    588    592    589    586    608    612    609    606    359        0        0        0 ; # Steel
element stdBrick    211     30     49     46     22     35     54     48     25    359        0        0        0 ; # Steel
element stdBrick    212     35     54     48     25     45     65     59     37    359        0        0        0 ; # Steel
element stdBrick    213     45     65     59     37     64     80     77     55    359        0        0        0 ; # Steel
element stdBrick    214     64     80     77     55     88    102     99     78    359        0        0        0 ; # Steel
element stdBrick    215     88    102     99     78    109    121    117    104    359        0        0        0 ; # Steel
element stdBrick    216    109    121    117    104    130    139    135    126    359        0        0        0 ; # Steel
element stdBrick    217    130    139    135    126    151    157    154    147    359        0        0        0 ; # Steel
element stdBrick    218    151    157    154    147    171    175    174    168    359        0        0        0 ; # Steel
element stdBrick    219    171    175    174    168    192    195    194    188    359        0        0        0 ; # Steel
element stdBrick    220    192    195    194    188    212    215    214    209    359        0        0        0 ; # Steel
element stdBrick    221    212    215    214    209    232    235    234    229    359        0        0        0 ; # Steel
element stdBrick    222    232    235    234    229    252    255    254    249    359        0        0        0 ; # Steel
element stdBrick    223    252    255    254    249    272    275    274    269    359        0        0        0 ; # Steel
element stdBrick    224    272    275    274    269    292    295    294    289    359        0        0        0 ; # Steel
element stdBrick    225    292    295    294    289    312    315    314    309    359        0        0        0 ; # Steel
element stdBrick    226    312    315    314    309    332    335    334    329    359        0        0        0 ; # Steel
element stdBrick    227    332    335    334    329    352    355    354    349    359        0        0        0 ; # Steel
element stdBrick    228    352    355    354    349    372    375    374    369    359        0        0        0 ; # Steel
element stdBrick    229    372    375    374    369    392    395    394    389    359        0        0        0 ; # Steel
element stdBrick    230    392    395    394    389    412    415    414    409    359        0        0        0 ; # Steel
element stdBrick    231    412    415    414    409    432    435    434    429    359        0        0        0 ; # Steel
element stdBrick    232    432    435    434    429    452    455    454    449    359        0        0        0 ; # Steel
element stdBrick    233    452    455    454    449    472    475    474    469    359        0        0        0 ; # Steel
element stdBrick    234    472    475    474    469    492    495    494    489    359        0        0        0 ; # Steel
element stdBrick    235    492    495    494    489    512    515    514    509    359        0        0        0 ; # Steel
element stdBrick    236    512    515    514    509    532    535    534    529    359        0        0        0 ; # Steel
element stdBrick    237    532    535    534    529    552    555    554    549    359        0        0        0 ; # Steel
element stdBrick    238    552    555    554    549    572    575    574    569    359        0        0        0 ; # Steel
element stdBrick    239    572    575    574    569    592    595    594    589    359        0        0        0 ; # Steel
element stdBrick    240    592    595    594    589    612    615    614    609    359        0        0        0 ; # Steel
element stdBrick    241     49     68     56     46     54     71     61     48    359        0        0        0 ; # Steel
element stdBrick    242     54     71     61     48     65     79     72     59    359        0        0        0 ; # Steel
element stdBrick    243     65     79     72     59     80     97     90     77    359        0        0        0 ; # Steel
element stdBrick    244     80     97     90     77    102    110    105     99    359        0        0        0 ; # Steel
element stdBrick    245    102    110    105     99    121    127    125    117    359        0        0        0 ; # Steel
element stdBrick    246    121    127    125    117    139    146    144    135    359        0        0        0 ; # Steel
element stdBrick    247    139    146    144    135    157    165    161    154    359        0        0        0 ; # Steel
element stdBrick    248    157    165    161    154    175    182    178    174    359        0        0        0 ; # Steel
element stdBrick    249    175    182    178    174    195    201    197    194    359        0        0        0 ; # Steel
element stdBrick    250    195    201    197    194    215    218    217    214    359        0        0        0 ; # Steel
element stdBrick    251    215    218    217    214    235    238    237    234    359        0        0        0 ; # Steel
element stdBrick    252    235    238    237    234    255    258    257    254    359        0        0        0 ; # Steel
element stdBrick    253    255    258    257    254    275    278    277    274    359        0        0        0 ; # Steel
element stdBrick    254    275    278    277    274    295    298    297    294    359        0        0        0 ; # Steel
element stdBrick    255    295    298    297    294    315    318    317    314    359        0        0        0 ; # Steel
element stdBrick    256    315    318    317    314    335    338    337    334    359        0        0        0 ; # Steel
element stdBrick    257    335    338    337    334    355    358    357    354    359        0        0        0 ; # Steel
element stdBrick    258    355    358    357    354    375    378    377    374    359        0        0        0 ; # Steel
element stdBrick    259    375    378    377    374    395    398    397    394    359        0        0        0 ; # Steel
element stdBrick    260    395    398    397    394    415    418    417    414    359        0        0        0 ; # Steel
element stdBrick    261    415    418    417    414    435    438    437    434    359        0        0        0 ; # Steel
element stdBrick    262    435    438    437    434    455    458    457    454    359        0        0        0 ; # Steel
element stdBrick    263    455    458    457    454    475    478    477    474    359        0        0        0 ; # Steel
element stdBrick    264    475    478    477    474    495    498    497    494    359        0        0        0 ; # Steel
element stdBrick    265    495    498    497    494    515    518    517    514    359        0        0        0 ; # Steel
element stdBrick    266    515    518    517    514    535    538    537    534    359        0        0        0 ; # Steel
element stdBrick    267    535    538    537    534    555    558    557    554    359        0        0        0 ; # Steel
element stdBrick    268    555    558    557    554    575    578    577    574    359        0        0        0 ; # Steel
element stdBrick    269    575    578    577    574    595    598    597    594    359        0        0        0 ; # Steel
element stdBrick    270    595    598    597    594    615    618    617    614    359        0        0        0 ; # Steel

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

recorder Node -file Node_displacements.out -time -nodeRange 1 620 -dof 1 2 3 disp
recorder Node -file Node_rotations.out -time -nodeRange 1 620 -dof 4 5 6 disp
recorder Node -file Node_forceReactions.out -time -nodeRange 1 620 -dof 1 2 3 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 620 -dof 4 5 6 reaction
recorder Element -file stdBrick_force.out -time -eleRange 1 270 forces
recorder Element -file stdBrick_stress.out -time -eleRange 1 270 stresses
recorder Element -file stdBrick_strain.out -time -eleRange 1 270 strains

logFile "Tutorial - Structural Steel Beam.log"

puts " __   __       __          __                   _       "
puts "/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _"
puts "\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-"
puts "                  |                                     "
puts "                             v3.0.0 with OpenSees v[version]\n"
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
    load    301        0        0      -10
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
# 620

# Elements 1D
# 0

# Elements 2D
# 0

# Elements 3D
# 270

# stdBrick
# 270
# 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270

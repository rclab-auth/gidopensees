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

model BasicBuilder -ndm 2 -ndf 2

# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

# node $NodeTag $XCoord $Ycoord

node     53            4            0
node     54            3            0
node     56            5            0
node     57            2            0
node     58            6            0
node     59            1            0
node     60            7            0
node     61            0            0
node     62            8            0
node     65            9            0
node     66           -1            0
node     67            4           -1
node     68            5           -1
node     69            3           -1
node     70            6           -1
node     71            2           -1
node     72            7           -1
node     73            1           -1
node     74           10            0
node     75           -2            0
node     76            8           -1
node     78            0           -1
node     79           11            0
node     80           -3            0
node     81           -1           -1
node     82            9           -1
node     83            4           -2
node     84            5           -2
node     85            3           -2
node     86            6           -2
node     87            2           -2
node     88           -2           -1
node     89            1           -2
node     90           10           -1
node     91            7           -2
node     92           12            0
node     93           -4            0
node     95            8           -2
node     96            0           -2
node     97           -3           -1
node     98           11           -1
node     99           -1           -2
node    100            9           -2
node    101            4           -3
node    102           -5            0
node    103            5           -3
node    104            3           -3
node    105            6           -3
node    106            2           -3
node    107           10           -2
node    108           -2           -2
node    109           -4           -1
node    110           12           -1
node    111            1           -3
node    112            7           -3
node    113            0           -3
node    114            8           -3
node    115           -6            0
node    116           -3           -2
node    117           11           -2
node    118           -1           -3
node    119           -5           -1
node    120            9           -3
node    121            4           -4
node    122            5           -4
node    123            3           -4
node    124            2           -4
node    125           12           -2
node    126           -4           -2
node    127            6           -4
node    128           -2           -3
node    129           10           -3
node    130            7           -4
node    131           -7            0
node    132            1           -4
node    133           -6           -1
node    134            8           -4
node    135            0           -4
node    136           11           -3
node    137           -3           -3
node    138           -5           -2
node    139           -1           -4
node    140            9           -4
node    141           -8            0
node    142            4           -5
node    143           12           -3
node    144           -4           -3
node    145            5           -5
node    146            3           -5
node    147           -7           -1
node    148           -2           -4
node    149           10           -4
node    150            2           -5
node    151            6           -5
node    152           -6           -2
node    153            7           -5
node    154            1           -5
node    155           -3           -4
node    156            8           -5
node    157            0           -5
node    158           11           -4
node    159           -5           -3
node    160           -8           -1
node    161           -9            0
node    162            9           -5
node    163           -1           -5
node    164           -7           -2
node    165           12           -4
node    166           -4           -4
node    167            4           -6
node    168           10           -5
node    169            3           -6
node    170           -6           -3
node    171           -2           -5
node    172            5           -6
node    173            6           -6
node    174            2           -6
node    175            7           -6
node    176            1           -6
node    177           -5           -4
node    178           -9           -1
node    179           11           -5
node    180           -3           -5
node    181          -10            0
node    182           -8           -2
node    183            0           -6
node    184            8           -6
node    185           -7           -3
node    186           -1           -6
node    187            9           -6
node    188           -4           -5
node    189           12           -5
node    190           -6           -4
node    191           10           -6
node    192           -2           -6
node    193            4           -7
node    194            5           -7
node    195            3           -7
node    196          -10           -1
node    197            2           -7
node    198           -9           -2
node    199            6           -7
node    200          -11            0
node    201           -8           -3
node    202            1           -7
node    203           -5           -5
node    204            7           -7
node    205           11           -6
node    206           -3           -6
node    207           -7           -4
node    208            8           -7
node    209            0           -7
node    210            9           -7
node    211           -1           -7
node    212           -4           -6
node    213           12           -6
node    214           -6           -5
node    215          -10           -2
node    216          -11           -1
node    217           -9           -3
node    218           -2           -7
node    219           10           -7
node    220          -12            0
node    221            4           -8
node    222           -8           -4
node    223            3           -8
node    224            5           -8
node    225            6           -8
node    226            2           -8
node    227           -5           -6
node    228            7           -8
node    229            1           -8
node    230           -7           -5
node    231           11           -7
node    232           -3           -7
node    233            8           -8
node    234            0           -8
node    235          -10           -3
node    236          -11           -2
node    237           -6           -6
node    238           -4           -7
node    239          -12           -1
node    240           12           -7
node    241            9           -8
node    242           -1           -8
node    243           -9           -4
node    244           -8           -5
node    245           10           -8
node    246           -2           -8
node    247            4           -9
node    248           -5           -7
node    249            5           -9
node    250            3           -9
node    251           -7           -6
node    252            2           -9
node    253            6           -9
node    254           -3           -8
node    255           11           -8
node    256          -11           -3
node    257            7           -9
node    258            1           -9
node    259          -12           -2
node    260          -10           -4
node    261            8           -9
node    262            0           -9
node    263           -9           -5
node    264           -6           -7
node    265           -4           -8
node    266           12           -8
node    267            9           -9
node    268           -1           -9
node    269           -8           -6
node    270           10           -9
node    271           -2           -9
node    272          -11           -4
node    273           -5           -8
node    274          -12           -3
node    275           -7           -7
node    276            4          -10
node    277            3          -10
node    278          -10           -5
node    279            5          -10
node    280            2          -10
node    281            6          -10
node    282           -3           -9
node    283           11           -9
node    284            1          -10
node    285            7          -10
node    286           -9           -6
node    287            8          -10
node    288            0          -10
node    289           -6           -8
node    290           -8           -7
node    291           -4           -9
node    292           12           -9
node    293           -1          -10
node    294            9          -10
node    295          -12           -4
node    296          -11           -5
node    297           -2          -10
node    298           10          -10
node    299          -10           -6
node    300           -7           -8
node    301           -5           -9
node    302            4          -11
node    303            3          -11
node    304           -9           -7
node    305            5          -11
node    306            2          -11
node    307           -3          -10
node    308            6          -11
node    309           11          -10
node    310            7          -11
node    311            1          -11
node    312           -6           -9
node    313           -8           -8
node    314          -12           -5
node    315            8          -11
node    316            0          -11
node    317           12          -10
node    318           -4          -10
node    319          -11           -6
node    320           -1          -11
node    321            9          -11
node    322          -10           -7
node    323           -7           -9
node    324           -2          -11
node    325           -5          -10
node    326           10          -11
node    327           -9           -8
node    328            4          -12
node    329            3          -12
node    330            5          -12
node    331           -3          -11
node    332           11          -11
node    333            2          -12
node    334          -12           -6
node    335            6          -12
node    336           -6          -10
node    337            1          -12
node    338            7          -12
node    339           -8           -9
node    340          -11           -7
node    341            8          -12
node    342            0          -12
node    343           -4          -11
node    344           12          -11
node    345          -10           -8
node    346           -1          -12
node    347            9          -12
node    348           -7          -10
node    349           -5          -11
node    350           -9           -9
node    351           -2          -12
node    352           10          -12
node    353          -12           -7
node    354           11          -12
node    355           -3          -12
node    356          -11           -8
node    357           -8          -10
node    358           -6          -11
node    359          -10           -9
node    360           12          -12
node    361           -4          -12
node    362           -7          -11
node    363           -9          -10
node    364          -12           -8
node    365           -5          -12
node    366          -11           -9
node    367           -8          -11
node    368           -6          -12
node    369          -10          -10
node    370           -7          -12
node    371          -12           -9
node    372           -9          -11
node    373          -11          -10
node    374           -8          -12
node    375          -10          -11
node    376          -12          -10
node    377           -9          -12
node    378          -11          -11
node    379          -10          -12
node    380          -12          -11
node    381          -11          -12
node    382          -12          -12

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# fix $NodeTag x-transl y-transl

fix     92   1   0
fix    110   1   0
fix    125   1   0
fix    143   1   0
fix    165   1   0
fix    189   1   0
fix    213   1   0
fix    220   1   0
fix    239   1   0
fix    240   1   0
fix    259   1   0
fix    266   1   0
fix    274   1   0
fix    292   1   0
fix    295   1   0
fix    314   1   0
fix    317   1   0
fix    328   1   1
fix    329   1   1
fix    330   1   1
fix    333   1   1
fix    334   1   0
fix    335   1   1
fix    337   1   1
fix    338   1   1
fix    341   1   1
fix    342   1   1
fix    344   1   0
fix    346   1   1
fix    347   1   1
fix    351   1   1
fix    352   1   1
fix    353   1   0
fix    354   1   1
fix    355   1   1
fix    360   1   1
fix    361   1   1
fix    364   1   0
fix    365   1   1
fix    368   1   1
fix    370   1   1
fix    371   1   0
fix    374   1   1
fix    376   1   0
fix    377   1   1
fix    379   1   1
fix    380   1   0
fix    381   1   1
fix    382   1   1

# --------------------------------------------------------------------------------------------------------------
# Q U A D   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# nDMaterial Definition used by Quad Elements
# (only if they have not already been defined on this model domain)

nDMaterial ElasticIsotropic 259 170000 0.25            0

# Quad elements Definition : element quad $EleTag $Nodei $Nodej Nodek $Nodel $thick $type $MatTag

element quad      1    239    216    200    220        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      2    259    236    216    239        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      3    274    256    236    259        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      4    295    272    256    274        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      5    216    196    181    200        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      6    236    215    196    216        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      7    256    235    215    236        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      8    272    260    235    256        1  PlaneStrain 259        0        0        0        0; # Soil
element quad      9    196    178    161    181        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     10    215    198    178    196        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     11    235    217    198    215        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     12    260    243    217    235        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     13    178    160    141    161        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     14    198    182    160    178        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     15    217    201    182    198        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     16    243    222    201    217        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     17    160    147    131    141        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     18    182    164    147    160        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     19    201    185    164    182        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     20    222    207    185    201        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     21    147    133    115    131        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     22    164    152    133    147        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     23    185    170    152    164        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     24    207    190    170    185        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     25    133    119    102    115        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     26    152    138    119    133        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     27    170    159    138    152        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     28    190    177    159    170        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     29    119    109     93    102        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     30    138    126    109    119        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     31    159    144    126    138        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     32    177    166    144    159        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     33    109     97     80     93        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     34    126    116     97    109        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     35    144    137    116    126        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     36    166    155    137    144        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     37     97     88     75     80        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     38    116    108     88     97        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     39    137    128    108    116        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     40    155    148    128    137        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     41     88     81     66     75        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     42    108     99     81     88        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     43    128    118     99    108        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     44    148    139    118    128        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     45     81     78     61     66        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     46     99     96     78     81        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     47    118    113     96     99        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     48    139    135    113    118        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     49     78     73     59     61        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     50     96     89     73     78        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     51    113    111     89     96        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     52    135    132    111    113        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     53     73     71     57     59        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     54     89     87     71     73        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     55    111    106     87     89        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     56    132    124    106    111        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     57     71     69     54     57        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     58     87     85     69     71        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     59    106    104     85     87        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     60    124    123    104    106        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     61     69     67     53     54        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     62     85     83     67     69        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     63    104    101     83     85        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     64    123    121    101    104        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     65     67     68     56     53        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     66     83     84     68     67        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     67    101    103     84     83        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     68    121    122    103    101        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     69     68     70     58     56        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     70     84     86     70     68        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     71    103    105     86     84        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     72    122    127    105    103        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     73     70     72     60     58        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     74     86     91     72     70        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     75    105    112     91     86        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     76    127    130    112    105        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     77     72     76     62     60        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     78     91     95     76     72        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     79    112    114     95     91        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     80    130    134    114    112        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     81     76     82     65     62        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     82     95    100     82     76        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     83    114    120    100     95        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     84    134    140    120    114        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     85     82     90     74     65        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     86    100    107     90     82        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     87    120    129    107    100        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     88    140    149    129    120        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     89     90     98     79     74        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     90    107    117     98     90        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     91    129    136    117    107        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     92    149    158    136    129        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     93     98    110     92     79        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     94    117    125    110     98        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     95    136    143    125    117        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     96    158    165    143    136        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     97    243    263    244    222        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     98    260    278    263    243        1  PlaneStrain 259        0        0        0        0; # Soil
element quad     99    272    296    278    260        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    100    295    314    296    272        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    101    263    286    269    244        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    102    278    299    286    263        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    103    296    319    299    278        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    104    314    334    319    296        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    105    286    304    290    269        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    106    299    322    304    286        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    107    319    340    322    299        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    108    334    353    340    319        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    109    304    327    313    290        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    110    322    345    327    304        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    111    340    356    345    322        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    112    353    364    356    340        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    113    177    203    188    166        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    114    190    214    203    177        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    115    207    230    214    190        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    116    222    244    230    207        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    117    203    227    212    188        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    118    214    237    227    203        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    119    230    251    237    214        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    120    244    269    251    230        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    121    227    248    238    212        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    122    237    264    248    227        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    123    251    275    264    237        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    124    269    290    275    251        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    125    248    273    265    238        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    126    264    289    273    248        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    127    275    300    289    264        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    128    290    313    300    275        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    129    139    163    157    135        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    130    148    171    163    139        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    131    155    180    171    148        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    132    166    188    180    155        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    133    163    186    183    157        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    134    171    192    186    163        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    135    180    206    192    171        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    136    188    212    206    180        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    137    186    211    209    183        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    138    192    218    211    186        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    139    206    232    218    192        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    140    212    238    232    206        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    141    211    242    234    209        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    142    218    246    242    211        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    143    232    254    246    218        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    144    238    265    254    232        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    145    123    146    142    121        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    146    124    150    146    123        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    147    132    154    150    124        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    148    135    157    154    132        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    149    146    169    167    142        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    150    150    174    169    146        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    151    154    176    174    150        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    152    157    183    176    154        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    153    169    195    193    167        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    154    174    197    195    169        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    155    176    202    197    174        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    156    183    209    202    176        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    157    195    223    221    193        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    158    197    226    223    195        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    159    202    229    226    197        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    160    209    234    229    202        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    161    130    153    156    134        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    162    127    151    153    130        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    163    122    145    151    127        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    164    121    142    145    122        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    165    153    175    184    156        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    166    151    173    175    153        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    167    145    172    173    151        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    168    142    167    172    145        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    169    175    204    208    184        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    170    173    199    204    175        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    171    172    194    199    173        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    172    167    193    194    172        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    173    204    228    233    208        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    174    199    225    228    204        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    175    194    224    225    199        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    176    193    221    224    194        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    177    158    179    189    165        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    178    149    168    179    158        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    179    140    162    168    149        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    180    134    156    162    140        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    181    179    205    213    189        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    182    168    191    205    179        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    183    162    187    191    168        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    184    156    184    187    162        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    185    205    231    240    213        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    186    191    219    231    205        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    187    187    210    219    191        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    188    184    208    210    187        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    189    231    255    266    240        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    190    219    245    255    231        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    191    210    241    245    219        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    192    208    233    241    210        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    193    327    350    339    313        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    194    345    359    350    327        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    195    356    366    359    345        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    196    364    371    366    356        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    197    350    363    357    339        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    198    359    369    363    350        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    199    366    373    369    359        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    200    371    376    373    366        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    201    363    372    367    357        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    202    369    375    372    363        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    203    373    378    375    369        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    204    376    380    378    373        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    205    372    377    374    367        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    206    375    379    377    372        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    207    378    381    379    375        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    208    380    382    381    378        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    209    273    301    291    265        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    210    289    312    301    273        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    211    300    323    312    289        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    212    313    339    323    300        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    213    301    325    318    291        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    214    312    336    325    301        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    215    323    348    336    312        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    216    339    357    348    323        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    217    325    349    343    318        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    218    336    358    349    325        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    219    348    362    358    336        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    220    357    367    362    348        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    221    349    365    361    343        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    222    358    368    365    349        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    223    362    370    368    358        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    224    367    374    370    362        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    225    242    268    262    234        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    226    246    271    268    242        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    227    254    282    271    246        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    228    265    291    282    254        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    229    268    293    288    262        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    230    271    297    293    268        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    231    282    307    297    271        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    232    291    318    307    282        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    233    293    320    316    288        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    234    297    324    320    293        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    235    307    331    324    297        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    236    318    343    331    307        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    237    320    346    342    316        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    238    324    351    346    320        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    239    331    355    351    324        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    240    343    361    355    331        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    241    223    250    247    221        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    242    226    252    250    223        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    243    229    258    252    226        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    244    234    262    258    229        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    245    250    277    276    247        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    246    252    280    277    250        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    247    258    284    280    252        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    248    262    288    284    258        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    249    277    303    302    276        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    250    280    306    303    277        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    251    284    311    306    280        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    252    288    316    311    284        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    253    303    329    328    302        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    254    306    333    329    303        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    255    311    337    333    306        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    256    316    342    337    311        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    257    228    257    261    233        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    258    225    253    257    228        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    259    224    249    253    225        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    260    221    247    249    224        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    261    257    285    287    261        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    262    253    281    285    257        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    263    249    279    281    253        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    264    247    276    279    249        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    265    285    310    315    287        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    266    281    308    310    285        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    267    279    305    308    281        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    268    276    302    305    279        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    269    310    338    341    315        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    270    308    335    338    310        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    271    305    330    335    308        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    272    302    328    330    305        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    273    255    283    292    266        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    274    245    270    283    255        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    275    241    267    270    245        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    276    233    261    267    241        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    277    283    309    317    292        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    278    270    298    309    283        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    279    267    294    298    270        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    280    261    287    294    267        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    281    309    332    344    317        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    282    298    326    332    309        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    283    294    321    326    298        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    284    287    315    321    294        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    285    332    354    360    344        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    286    326    352    354    332        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    287    321    347    352    326        1  PlaneStrain 259        0        0        0        0; # Soil
element quad    288    315    341    347    321        1  PlaneStrain 259        0        0        0        0; # Soil

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

node      1            4           12
node      2            3           12
node      3            4           11
node      4            2           12
node      5            4           10
node      6            1           12
node      7            4            9
node      8            0           12
node      9            4            8
node     10            3            8
node     11            0           11
node     12            2            8
node     13            0           10
node     14            0            9
node     15           -1           12
node     16            4            7
node     17            1            8
node     18            0            8
node     19            4            6
node     20           -2           12
node     21           -1            8
node     22            0            7
node     23           -3           12
node     24            4            5
node     25            0            6
node     26           -2            8
node     27           -4           12
node     28            4            4
node     29           -4           11
node     30            0            5
node     31            3            4
node     32           -3            8
node     33           -4           10
node     34            2            4
node     35            1            4
node     36           -4            9
node     37            0            4
node     38           -4            8
node     39            4            3
node     40           -4            7
node     41           -1            4
node     42            0            3
node     43            4            2
node     44           -2            4
node     45           -4            6
node     46           -4            5
node     47           -3            4
node     48            0            2
node     49            4            1
node     50           -4            4
node     51            0            1
node     52            4            0
node     55           -4            3
node     63            0            0
node     64           -4            2
node     77           -4            1
node     94           -4            0

# --------------------------------------------------------------------------------------------------------------
# M A S S E S
# --------------------------------------------------------------------------------------------------------------

# Mass Definition : mass $NodeTag $(ndf nodal mass values corresponding to each DOF)

mass      1       20        0        0
mass      8       20        0        0
mass      9       20        0        0
mass     18       20        0        0
mass     27       20        0        0
mass     28       20        0        0
mass     37       20        0        0
mass     38       20        0        0
mass     50       20        0        0

# --------------------------------------------------------------------------------------------------------------
# F O R C E - B A S E D   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

# Geometric Transformation

geomTransf Linear 1
geomTransf PDelta 2
geomTransf Corotational 3

# Sections Definition used by forceBeamColumn Elements
# (if they have not already been defined on this model domain)

uniaxialMaterial Concrete01 363 -20000 -0.002 -17000 -0.005
uniaxialMaterial Concrete01 362 -20000 -0.002 -17000 -0.0035
uniaxialMaterial ReinforcingSteel 313 500000 575000 2e+08 2e+07 0.005 0.075


section Fiber 360 -GJ 1e10  {

# Create the Core fibers

patch rect 363      8      8  -0.200000  -0.200000   0.200000   0.200000

# Create the Cover fibers

patch rect 362      8      1  -0.200000   0.200000   0.200000   0.250000
patch rect 362      8      1  -0.200000  -0.250000   0.200000  -0.200000
patch rect 362      1      8  -0.250000  -0.200000  -0.200000   0.200000
patch rect 362      1      8   0.200000  -0.200000   0.250000   0.200000
# Corner Cover fibers
patch rect 362      1      1  -0.250000  -0.250000  -0.200000  -0.200000
patch rect 362      1      1  -0.250000   0.200000  -0.200000   0.250000
patch rect 362      1      1   0.200000  -0.250000   0.250000  -0.200000
patch rect 362      1      1   0.200000   0.200000   0.250000   0.250000


# Create the corner bars

layer straight 313  2   0.00031420   0.200000   0.200000  -0.200000   0.200000
layer straight 313  2   0.00031420   0.200000  -0.200000  -0.200000  -0.200000

# Create the middle bars along local y axis

layer straight 313   2   0.00025450   0.066667   0.200000  -0.066667   0.200000
layer straight 313   2   0.00025450   0.066667  -0.200000  -0.066667  -0.200000

# Create the middle bars along local z axis

layer straight 313   2   0.00025450   0.200000   0.066667   0.200000  -0.066667
layer straight 313   2   0.00025450  -0.200000   0.066667  -0.200000  -0.066667
}


section Fiber 361 {

# Create the Core fibers

patch rect 363     11      6  -0.300000  -0.100000   0.300000   0.100000

# Create the Cover fibers

patch rect 362     11      2  -0.300000   0.100000   0.300000   0.150000
patch rect 362     11      2  -0.300000  -0.150000   0.300000  -0.100000
patch rect 362      2      6  -0.350000  -0.100000  -0.300000   0.100000
patch rect 362      2      6   0.300000  -0.100000   0.350000   0.100000
# Corner Cover fibers
patch rect 362      2      2  -0.350000  -0.150000  -0.300000  -0.100000
patch rect 362      2      2  -0.350000   0.100000  -0.300000   0.150000
patch rect 362      2      2   0.300000  -0.150000   0.350000  -0.100000
patch rect 362      2      2   0.300000   0.100000   0.350000   0.150000


# Create the Top bars (face on local y positive dir)

layer straight 313   3    0.00020110   0.300000   0.100000   0.300000  -0.100000

# Create the Bottom bars (face on local y negative dir)

layer straight 313   3   0.00020110  -0.300000   0.100000  -0.300000  -0.100000
}

# Force-Based Beam-Column Element definition

# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

element forceBeamColumn    289     94     77  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    290     77     64  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    291     64     55  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    292     55     50  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    293     50     47  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    294     47     44  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    295     44     41  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    296     41     37  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    297     63     51  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    298     51     48  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    299     48     42  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    300     42     37  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    301     37     35  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    302     35     34  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    303     34     31  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    304     31     28  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    305     52     49  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    306     49     43  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    307     43     39  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    308     39     28  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    309     50     46  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    310     46     45  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    311     45     40  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    312     40     38  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    313     38     32  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    314     32     26  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    315     26     21  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    316     21     18  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    317     37     30  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    318     30     25  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    319     25     22  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    320     22     18  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    321     18     17  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    322     17     12  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    323     12     10  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    324     10      9  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    325     28     24  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    326     24     19  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    327     19     16  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    328     16      9  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    329     38     36  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    330     36     33  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    331     33     29  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    332     29     27  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    333     27     23  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    334     23     20  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    335     20     15  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    336     15      8  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    337      8      6  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    338      6      4  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    339      4      2  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    340      2      1  3    361  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    341     18     14  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    342     14     13  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    343     13     11  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    344     11      8  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    345      9      7  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    346      7      5  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    347      5      3  3    360  1   -iter   50   1.00e-04   -mass        0
element forceBeamColumn    348      3      1  3    360  1   -iter   50   1.00e-04   -mass        0

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# E Q U A L  C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# Equal Constraint/equalDOF Definition : equalDOF $MasterNode $SlaveNode $DOFs

equalDOF     52     53 1 2   ; # ID : 3
equalDOF     63     61 1 2   ; # ID : 2
equalDOF     94     93 1 2   ; # ID : 1

# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

recorder Node -file Node_displacements.out -time -nodeRange 1 382 -dof 1 2 disp
recorder Node -file Node_rotations.out -time -nodeRange 1 382 -dof 3 disp
recorder Node -file Node_forceReactions.out -time -nodeRange 1 382 -dof 1 2 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 382 -dof 3 reaction
recorder Node -file Node_accelerations.out -time -nodeRange 1 382 -dof 1 2 accel
recorder Node -file Node_velocities.out -time -nodeRange 1 382 -dof 1 2 vel
recorder Element -file Quad_force.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 forces
recorder Element -file Quad_stress.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 stresses
recorder Element -file Quad_strain.out -time -ele 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 strains
recorder Element -file ForceBeamColumn_localForce.out -time -ele 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 localForce
recorder Element -file ForceBeamColumn_basicDeformation.out -time -ele 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 basicDeformation
recorder Element -file ForceBeamColumn_plasticDeformation.out -time -ele 289 290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 305 306 307 308 309 310 311 312 313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 330 331 332 333 334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 plasticDeformation

logFile "Example - Plane Frame on Elastic Soil - Dynamic Analysis.log"

puts " __   __       __          __                   _       "
puts "/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _"
puts "\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-"
puts "                  |                                     "
puts "                             v3.0.0 with OpenSees v[version]\n"
puts "Analysis summary\n"
puts "Interval 1 : Static - [expr int(1+5)] steps"
puts "Interval 2 : Transient - [expr int(1.0 + 40/0.01)] steps x 0.01 s"
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
    eleLoad -ele    293 -type -beamUniform      -15        0
    eleLoad -ele    294 -type -beamUniform      -15        0
    eleLoad -ele    295 -type -beamUniform      -15        0
    eleLoad -ele    296 -type -beamUniform      -15        0
    eleLoad -ele    301 -type -beamUniform      -15        0
    eleLoad -ele    302 -type -beamUniform      -15        0
    eleLoad -ele    303 -type -beamUniform      -15        0
    eleLoad -ele    304 -type -beamUniform      -15        0
    eleLoad -ele    313 -type -beamUniform      -15        0
    eleLoad -ele    314 -type -beamUniform      -15        0
    eleLoad -ele    315 -type -beamUniform      -15        0
    eleLoad -ele    316 -type -beamUniform      -15        0
    eleLoad -ele    321 -type -beamUniform      -15        0
    eleLoad -ele    322 -type -beamUniform      -15        0
    eleLoad -ele    323 -type -beamUniform      -15        0
    eleLoad -ele    324 -type -beamUniform      -15        0
    eleLoad -ele    333 -type -beamUniform      -15        0
    eleLoad -ele    334 -type -beamUniform      -15        0
    eleLoad -ele    335 -type -beamUniform      -15        0
    eleLoad -ele    336 -type -beamUniform      -15        0
    eleLoad -ele    337 -type -beamUniform      -15        0
    eleLoad -ele    338 -type -beamUniform      -15        0
    eleLoad -ele    339 -type -beamUniform      -15        0
    eleLoad -ele    340 -type -beamUniform      -15        0
}

# recording the initial status

record

# Analysis options

wipeAnalysis
system BandGeneral
numberer RCM
constraints Transformation
integrator LoadControl 0.2
test RelativeEnergyIncr 0.0001 100 2
algorithm Newton
analysis Static

set Lincr 0.200000
set Nsteps 5
set committedSteps 1
set LoadCounter 0

set strIni {}
variable testTypeStatic RelativeEnergyIncr
variable TolStatic 0.0001
variable maxNumIterStatic 100
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

# recording the initial status

record

# Analysis options

wipeAnalysis
system BandGeneral
numberer RCM
constraints Transformation
integrator Newmark 0.5 0.25
test RelativeEnergyIncr 0.0001 500 2
algorithm ModifiedNewton -initial
analysis Transient

# Loads - Uniform Excitation

set iGMdirection 1
set DtAnalysis 0.01
set TmaxAnalysis 40

proc LoadRecordTimeandValues {filename recordValues recordTimes skiplines tcol vcol} {
    set currentLine 0
    upvar $recordValues RecValues
    upvar $recordTimes RecTimes
    # clear lists
    set RecValues " "
    set RecTimes " "

    if [catch {open $filename r} inFileID] {
        puts stderr "Cannot open $filename for reading"
    } else {
        foreach line [split [read $inFileID] \n] {
            set currentLine [expr $currentLine+1]
            if {[llength $line] == 0 || $line == " " || $currentLine<= $skiplines} {
            continue
            } else {
                set valueColumnIndex [expr $vcol-1]
                set timeColumnIndex [expr $tcol-1]
                lappend RecValues [lindex [join $line " "] $valueColumnIndex ]
                lappend RecTimes [lindex [join $line " "] $timeColumnIndex ]
            }
        }
        close $inFileID
    }
}

set iGMfile "{../Records/Loma_Prieta.dat} "
set iGMfact "{9.810} "
set iGMFormat "{TimeValue} "
set iGMType "{-accel} "
set iGMdt "{0} "
set iGMskip "{6} "
set iGMvalCol "{2} "
set iGMtimeCol "{1} "
set IDGMLoadPatternTag 250

foreach GMdirection $iGMdirection GMfile $iGMfile GMfact $iGMfact GMtype $iGMType GMformat $iGMFormat GMdt $iGMdt GMskip $iGMskip GMvalCol $iGMvalCol GMtimeCol $iGMtimeCol {
    incr IDGMLoadPatternTag
    if {$GMformat=="PEER"} {
        ReadPEERfile $GMfile recordValues dt
            if {$GMtype == "-accel"} {
            set AccelSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -accel $AccelSeries
        } elseif {$GMtype == "-disp"} {
            set DispSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -disp $DispSeries
        }

    } elseif {$GMformat == "Value"} {
        LoadRecordValues $GMfile recordValues $GMskip
        set dt $GMdt
        if {$GMtype == "-accel"} {
            set AccelSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -accel $AccelSeries
        } elseif {$GMtype == "-disp"} {
            set DispSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -disp $DispSeries
        }
    } elseif {$GMformat == "TimeValue"} {
        LoadRecordTimeandValues $GMfile recordValues recordTimes $GMskip $GMtimeCol $GMvalCol
        if {$GMtype == "-accel"} {
                set AccelSeries "Path -time {$recordTimes} -values {$recordValues} -factor $GMfact"
                pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -accel $AccelSeries
        } elseif {$GMtype == "-disp"} {
                set DispSeries "Path -time {$recordTimes} -values {$recordValues} -factor $GMfact"
                pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -disp $DispSeries
        }
    }
}

set committedSteps 1
set Nsteps [expr int($TmaxAnalysis/$DtAnalysis)]

set strIni {}
variable testTypeDynamic RelativeEnergyIncr
variable TolDynamic 0.0001
variable maxNumIterDynamic 500
variable algorithmTypeDynamic ModifiedNewton
set strIni "/Ini"

for {set i 1} { $i <= $Nsteps } {incr i 1} {
    set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
    puts -nonewline "(2) $algorithmTypeDynamic$strIni Time $t "
    set AnalOk [analyze 1 $DtAnalysis]; # perform analysis - returns 0 if analysis was successful
    if {$AnalOk == 0} {
        set committedSteps [expr $committedSteps+1]
    } else {
        break
    }
}

if {$AnalOk != 0} {; # if analysis fails, alternative algorithms and substepping is applied
    set firstFail 1
    set AnalOk 0
    set controlTime [getTime]
    set Nk 1; # dt = dt/Nk
    set returnToInitStepFlag 0
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        if { ($Nk == 1 && $AnalOk == 0) || ($Nk == 2 && $AnalOk == 0) } {
            set Nk 1
            if {$returnToInitStepFlag} {
                puts "\nBack to initial step\n"
                set returnToInitStepFlag 0
            }
            if {$firstFail == 0} {; # for the first time only, do not repeat previous failed step
                set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
                puts -nonewline "(2) $algorithmTypeDynamic$strIni Time $t "
                set AnalOk [analyze 1 $DtAnalysis]
            } else {
                set AnalOk 1
                set firstFail 0
            }
            if {$AnalOk == 0} {
                set committedSteps [expr $committedSteps+1]
            }
        }; # end if Nk=1
        # substepping /2
        if {($Nk == 1 && $AnalOk!=0) || ($Nk == 4 && $AnalOk==0)} {
            set Nk 2.0
            set continueFlag 1
            puts "\nInitial step is divided by 2\n"
            set currTime1 [getTime]
            set curStep [expr int($currTime1/$DtAnalysis)]
            set remStep1 [expr int(($Nsteps-$curStep)*2.0)]
            set ReducedDtAnalysis [expr $DtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "(2) $algorithmTypeDynamic$strIni Time $t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
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
        if {($Nk == 2 && $AnalOk!=0) || ($Nk == 8 && $AnalOk == 0)} {
            set Nk 4.0
            set continueFlag 1
            puts "\nInitial step is divided by 4\n"
            set currTime2 [getTime]
            set curStep [expr ($currTime2-$currTime1)/$ReducedDtAnalysis]
            set remStep2 [expr int(($remStep1-$curStep)*2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "(2) $algorithmTypeDynamic$strIni Time $t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
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
        if {($Nk == 4 && $AnalOk!=0) || ($Nk == 16 && $AnalOk == 0)} {
            set Nk 8.0
            set continueFlag 1
            puts "\nInitial step is divided by 8\n"
            set currTime3 [getTime]
            set curStep [expr ($currTime3-$currTime2)/$ReducedDtAnalysis]
            set remStep3 [expr int(($remStep2-$curStep)*2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "(2) $algorithmTypeDynamic$strIni Time $t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
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
            set Nk 16.0
            set continueFlag 1
            puts "\nInitial step is divided by 16\n"
            set currTime4 [getTime]
            set curStep [expr ($currTime4-$currTime3)/$ReducedDtAnalysis]
            set remStep4 [expr int(($remStep3-$curStep)*2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "(2) $algorithmTypeDynamic$strIni Time $t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
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
        set controlTime [getTime]
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

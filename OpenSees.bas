#
#  _____ _______       _____                  _____                  _____      _             __               
# |  __ (_)  _  \  _  |  _  |                /  ___|                |_   _|    | |           / _|              
# | |  \/_| | | |_| |_| | | |_ __   ___ _ __ \ `--.  ___  ___  ___    | | _ __ | |_ ___ _ __| |_ __ _  ___ ___ 
# | | __| | | | |_   _| | | | '_ \ / _ \ '_ \ `--. \/ _ \/ _ \/ __|   | || '_ \| __/ _ \ '__|  _/ _` |/ __/ _ \
# | |_\ \ | |/ /  |_| \ \_/ / |_) |  __/ | | /\__/ /  __/  __/\__ \  _| || | | | ||  __/ |  | || (_| | (_|  __/
#  \____/_|___/        \___/| .__/ \___|_| |_\____/ \___|\___||___/  \___/_| |_|\__\___|_|  |_| \__,_|\___\___|
#                           | |                                                                                
#                           |_|                                                                                
#
# (c) 2016-2017
#
# Lab of R/C and Masonry Structures
# School of Civil Engineering, AUTh
#  
# Development team
#
# T. Kartalis-Kaounis, Civil Engineer AUTh
# V. Protopapadakis, Civil Engineer AUTh
# T. Papadopoulos, Civil Engineer AUTh
# 
# Project coordinator
#
# V.K. Papanikolaou, Assistant Professor AUTh
#

*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
# --------------------------------------------------------------------------------------------------------------
#
# OPENSEES MODEL DATA FILE (Three dimensional / Six degrees of freedom)
#
# --------------------------------------------------------------------------------------------------------------
*elseif(GenData(Dimensions,int)==3 && GenData(DOF,int)==3)
# --------------------------------------------------------------------------------------------------------------
#
# OPENSEES MODEL DATA FILE (Three dimensional / Three degrees of freedom)
#
# --------------------------------------------------------------------------------------------------------------
*elseif(GenData(Dimensions,int)==2 && GenData(DOF,int)==2)
# --------------------------------------------------------------------------------------------------------------
#
# OPENSEES MODEL DATA FILE (Two dimensional / Two degrees of freedom)
#
# --------------------------------------------------------------------------------------------------------------
*elseif(GenData(Dimensions,int)==2 && GenData(DOF,int)==3)
# --------------------------------------------------------------------------------------------------------------
#
# OPENSEES MODEL DATA FILE (Two dimensional / Three degrees of freedom)
#
# --------------------------------------------------------------------------------------------------------------
*elseif(GenData(Dimensions,int)==2 && GenData(DOF,int)==6)
*MessageBox Error: You CANNOT define 6 DOF in a 2D Model ! Please change the Problem Data.
*else
*MessageBox Error: You CANNOT define 2 DOF in a 3D Model ! Please change the Problem Data.
*endif

# Modeling environment (ndm = model dimensions, ndf = global degrees of freedom)

*if(GenData(Dimensions,int)==3)
*if(GenData(DOF,int)==6)
model BasicBuilder -ndm 3 -ndf 6;  
*else
model BasicBuilder -ndm 3 -ndf 3;
*endif
*elseif(GenData(Dimensions,int)==2)
*if(GenData(DOF,int)==2)
model BasicBuilder -ndm 2 -ndf 2;
*else
model BasicBuilder -ndm 2 -ndf 3;
*endif
*endif
*#
*#----------- General Variables ---------------
*#
*# variable to control geometric transformation to be printed once
*set var GeomTransfPrinted=0
*# variable to control files to be printed
*set var file=0
*# procedure to clear list with used materials, because in case of recalculation, the list keeps its elements for previous calculation
*set var dummy=tcl(ClearUsedMaterials)
*set var MaterialExists=-1
*# 
*# Nodes
*#
*include bas\Nodes.bas
*#
*# Constraints
*#
*include bas\Constraints.bas
*#
*# Masses
*#
*include bas\Mass.bas
*#
*# Restraints
*#
*include bas\Restraints.bas
*#
*# Elastic Beam Column Elements
*#
*include bas\Elements\BeamColumnElements\ElasticBeamElements.bas
*#
*# Elastic Timoshenko Beam Elements
*#
*include bas\Elements\BeamColumnElements\ElasticTimoshenkoBeamElements.bas
*#
*# Force-based Beam Column Elements
*#
*include bas\Elements\BeamColumnElements\forceBeamColumn.bas
*#
*# Truss Elements
*#
*include bas\Elements\Truss\TrussElement.bas
*#
*# Corotational Truss Elements
*#
*include bas\Elements\Truss\CorotationalTrussElements.bas
*#
*# Quad Elements
*#
*include bas\Elements\Quadrilateral\QuadElements.bas
*#
*# Shell Elements
*#
*include bas\Elements\Quadrilateral\ShellElements.bas
*#
*# Tri31 Elements
*#
*include bas\Elements\Triangular\Tri31Elements.bas
*#
*# Standard Brick Elements
*#
*include bas\Elements\Brick\StdBrickElement.bas
*#
*# Zero Length Elements
*#
*include bas\Elements\ZeroLengthElements\ZeroLength.bas
*include bas\recorders.bas

logFile log.txt

# --------------------------------------------------------------------------------------------------------------

set time_start [clock seconds]
puts "\nAnalysis started  : [clock format $time_start -format %H:%M:%S]"
puts ""
*set var IntvNum=0
*loop intervals
*set var IntvNum=operation(IntvNum+1)

# --------------------------------------------------------------------------------------------------------------
#
# I N T E R V A L   *IntvNum
#
# --------------------------------------------------------------------------------------------------------------

*#
*# Loading
*#
*include bas\Loads.bas
*# 
*# Analysis Options
*#
*include bas\Analyze.bas
*if(IntvData(Keep_this_loading_active_until_the_end_of_analysis,int)==1)

loadConst -time 0.0
*endif
*end intervals

# --------------------------------------------------------------------------------------------------------------

set time_end [clock seconds]
set analysisTime [expr $time_end-$time_start]
puts "Analysis finished : [clock format $time_end -format %H:%M:%S]"
puts "Analysis time     : $analysisTime seconds"
puts "\nAnalysis finished."
*#
*# Metadata
*#
*include bas\Meta.bas

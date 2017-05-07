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
# GiD + OpenSees Interface - An Integrated FEA Platform
# Copyright (C) 2016-2017
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
#
*set var TwoDOF=0
*set var ThreeDOF=0
*set var SixDOF=0
*set var currentDOF=0
*#
*# loop elements to find number of model domains
*#
*loop materials
*set var ElemDOF=tcl(ReturnElemDOF *MatProp(Element_type:) *ndime)
*if(ElemDOF==2)
*set var TwoDOF=1
*elseif(ElemDOF==3)
*set var ThreeDOF=1
*elseif(ElemDOF==6)
*set var SixDOF=1
*endif
*end materials
*if(TwoDOF==0 && ThreeDOF==0&& SixDOF==0)
*MessageBox Error: No Elements were assigned.
*endif
*#
*# Depending on modeled elements, DOF groups (domains) are created
*#
*set var dummy=tcl(CreateDOFGroups *TwoDOF *ThreeDOF *SixDOF)
*#
*# Assign  elements (with their nodes) to the corresponding groups
*#
*loop elems
*set var ElemDOF=tcl(ReturnElemDOF *ElemsMatProp(Element_type:) *ndime)
*set var dummy=tcl(AssignElemNumToDOFlist *ElemsNum *ElemDOF)
*end elems
*set var dummy=tcl(AssignElemsToDOFGroups *TwoDOF *ThreeDOF *SixDOF)
*#
*# Orphan nodes (for example : master nodes for diaphragms)
*#
*set var dummy=tcl(InitOrphanNodesList )
*loop nodes
*set var dummy=tcl(AppendOrphanNodeList *NodesNum)
*end nodes
*loop groups
*if(strcmp(GroupName,"2DOF")==0 || strcmp(GroupName,"3DOF")==0 || strcmp(GroupName,"6DOF")==0)
*set Group *GroupName *nodes
*loop nodes *OnlyInGroup
*#
*# Remove non-orphan nodes (have a higher entity) from the orphan nodes list
*#
*set var dummy=tcl(RemoveFromOrphanNodesList *NodesNum)
*end nodes
*endif
*end groups
*set var dummy=tcl(AssignOrphanNodesToDOFGroups *ndime)
*#
*# Initialize element counting
*#
*set var cntNodes=0
*set var cntFBC=0
*set var cntQuad=0
*set var cntEBC=0
*set var cntETB=0
*set var cntDBC=0
*set var cntQuadUP=0
*set var cntShell=0
*set var cntStdBrick=0
*set var cntTri31=0
*set var cntTruss=0
*set var cntCorotTruss=0
*#
*loop groups
*if(strcmp(GroupName,"2DOF")==0 || strcmp(GroupName,"3DOF")==0 || strcmp(GroupName,"6DOF")==0)
*#
*# Specify the current ndf
*#
*set Group *GroupName *nodes
*loop nodes *OnlyInGroup
*set var currentDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*break
*end nodes

# Model domain *GroupName

*format "%d%d"
model BasicBuilder -ndm *ndime -ndf *currentDOF

*#
*# General Variables
*#
*# variable to control geometric transformation to be printed once
*#
*set var GeomTransfPrinted=0
*#
*# procedure to clear list of used materials, because in case of recalculation, the list keeps its elements from previous calculation
*#
*set var dummy=tcl(ClearUsedMaterials)
*set var MaterialExists=-1
*set var procReadPeerFilePrinted=0
*set var procLoadRecValuesPrinted=0
*set var procLoadRecTimeandValuesPrinted=0
*#
*# Nodes
*#
*include bas\Nodes.bas
*#
*# Restraints
*#
*include bas\Restraints.bas
*#
*# Rigid Diaphragms
*#
*include bas\rigidDiaphragm.bas
*#
*# Masses
*#
*include bas\Mass.bas
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
*include bas\Elements\BeamColumnElements\ForceBeamColumn.bas
*#
*# Displacement-based Beam Column Elements
*#
*include bas\Elements\BeamColumnElements\DispBeamColumn.bas
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
*# QuadUP Elements
*#
*include bas\Elements\Quadrilateral\QuadUPElements.bas
*#
*# Standard Brick Elements
*#
*include bas\Elements\Brick\StdBrickElement.bas
*#
*# Zero Length Elements
*#
*include bas\Elements\ZeroLengthElements\ZeroLength.bas
*endif
*end groups
*#
*# Equal DOFs
*#
*include bas\equalDOF.bas
*include bas\Recorders.bas

logFile log.txt

# --------------------------------------------------------------------------------------------------------------

puts "Analysis Summary"
*loop intervals
*set var IntvNum=operation(IntvNum+1)
*format "%g"
puts "Interval *IntvNum - *IntvData(Analysis_type) : Steps *\
*if(strcmp(IntvData(Analysis_type),"Static")==0)
*IntvData(Analysis_steps,int)"
*elseif(strcmp(IntvData(Analysis_type),"Transient")==0)
*format "%g"
[expr int(*IntvData(Analysis_duration,real)/*IntvData(Analysis_time_step,real))]"
*endif
*end intervals
puts ""
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

puts "Interval *IntvNum"
puts ""

*include bas\Loads.bas

# recording the initial status

record;
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
*#
*# Metadata
*#
*include bas\Meta.bas

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

# Length : *Units(LENGTH)
# Force  : *Units(FORCE)
# Moment : *Units(MOMENT)
# Stress : *Units(STRESS)
# Mass   : *Units(MASS)

# --------------------------------------------------------------------------------------------------------------
# M A T E R I A L S / S E C T I O N S ( E L E M E N T S )
# --------------------------------------------------------------------------------------------------------------

*loop materials
*set var ElementCounter=0
# *MatProp(0) *\
*loop elems
*# *ElemsNum
*if(strcmp(MatProp(0),ElemsMatProp(0))==0)
*set var ElementCounter=operation(ElementCounter+1)
*endif
*end elems
(*ElementCounter)
*end materials
*set var dummy=tcl(ClearZeroLengthLists )
*set var nZL=0
*set cond Point_ZeroLength *nodes
*loop nodes *OnlyInCond
*set var IDExists=tcl(CheckZeroLengthID *Cond(1))
*if(IDExists==-1)
*set var dummy=tcl(AddZeroLengthID *Cond(1))
*endif
*end nodes
*set var HowManyZeroLengthID=tcl(HowManyZeroLengthID)
*if(HowManyZeroLengthID>=1)
*for(i=1;i<=HowManyZeroLengthID;i=i+1)
*set var ZLNodes=0
*loop nodes *OnlyInCond
*set var CorrectID=tcl(IsThisZeroLengthID *Cond(1) *i)
*if(CorrectID==1)
*set var ZLNodes=operation(ZLNodes+1)
*endif
*end nodes
*set var nZL=operation(nZL+(ZLNodes-1))
*endfor
# ZeroLength (*nZL)
*endif
*set var TwoDOF=0
*set var ThreeDOF=0
*set var ThreePDOF=0
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
*elseif(ElemDOF==30)
*set var ThreePDOF=1
*elseif(ElemDOF==6)
*set var SixDOF=1
*else
*MessageBox Error: Invalid elements used for this model dimensions.
*endif
*end materials
*if(TwoDOF==0 && ThreeDOF==0 && SixDOF==0 && ThreePDOF==0)
*MessageBox Error: No Elements were assigned.
*endif
*set var numberGroups=operation(TwoDOF+ThreeDOF+SixDOF+ThreePDOF)
*#
*# Depending on modeled elements, DOF groups (domains) are created
*#
*set var dummy=tcl(CreateDOFGroups *TwoDOF *ThreeDOF *SixDOF *ThreePDOF)
*#
*# Assign  elements (including their nodes) to the corresponding groups
*#
*loop elems
*set var ElemDOF=tcl(ReturnElemDOF *ElemsMatProp(Element_type:) *ndime)
*set var dummy=tcl(AssignElemNumToDOFlist *ElemsNum *ElemDOF)
*end elems
*set var dummy=tcl(AssignElemsToDOFGroups *TwoDOF *ThreeDOF *SixDOF *ThreePDOF)
*#
*# Orphan nodes (for example : master nodes for diaphragms)
*#
*set var dummy=tcl(InitOrphanNodesList )
*loop nodes
*set var dummy=tcl(AppendOrphanNodeList *NodesNum)
*end nodes
*loop groups
*# Loop only to these auto made groups, because user may has created more groups manually.
*if(strcmp(GroupName,"2DOF")==0 || strcmp(GroupName,"3DOF")==0 || strcmp(GroupName,"6DOF")==0 || strcmp(GroupName,"3PDOF")==0)
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
*set var cntDBCI=0
*set var cntQuadUP=0
*set var cntShell=0
*set var cntShellDKGQ=0
*set var cntStdBrick=0
*set var cntTri31=0
*set var cntTruss=0
*set var cntCorotTruss=0
*#
*# Initialize some materials tags
*#
*set var PlaneStressUserMaterialTag=200
*set var PlateFromPlaneStressMaterialTag=300
*set var PlateRebarLongTag=400
*set var PlateRebarTransTag=500
*# Clear the lists of nodeTags for each Group (each domain)
*set var dummy=tcl(ClearGroupNodes )
*# Clear the list of Quad/QuadUP Nodes, used for automatic equalDOF commands (if chosen)
*set var dummy=tcl(ClearQuadMasterNodeList )
*set var dummy=tcl(ClearQuadUPMasterNodeList )
*#
*set var DomainNum=0
*loop groups
*if(strcmp(GroupName,"2DOF")==0)
*set var DomainNum=2
*elseif(strcmp(GroupName,"3DOF")==0)
*set var DomainNum=3
*elseif(strcmp(GroupName,"6DOF")==0)
*set var DomainNum=6
*elseif(strcmp(GroupName,"3PDOF")==0)
*set var DomainNum=30
*endif
*if(DomainNum != 0)
*#
*# Specify the current ndf
*#
*set Group *GroupName *nodes
*loop nodes *OnlyInGroup
*set var currentDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*break
*end nodes

# --------------------------------------------------------------------------------------------------------------
#
# M O D E L  D O M A I N  *GroupName  (*DomainNum)
#
# --------------------------------------------------------------------------------------------------------------

*if(currentDOF==30)
*format "%d%d"
model BasicBuilder -ndm *ndime -ndf 3
*else
model BasicBuilder -ndm *ndime -ndf *currentDOF
*endif

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
*set var procDeck3DPrinted=0
*set var procDeck2DPrinted=0
*#
*# Nodes
*#
*include bas\Model\Nodes.bas
*#
*# Restraints
*#
*include bas\Boundary\Restraints.bas
*#
*# Rigid Diaphragms
*#
*include bas\Boundary\rigidDiaphragm.bas
*#
*# Rigid Links
*#
*include bas\Boundary\RigidLink.bas
*#
*# Masses
*#
*include bas\Actions\Mass.bas
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
*# Displacement-based Beam Column Interaction Elements
*#
*include bas\Elements\BeamColumnElements\InteractionDispBeamColumn.bas
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
*# ShellDKGQ Elements
*#
*include bas\Elements\Quadrilateral\ShellDKGQ.bas
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

# --------------------------------------------------------------------------------------------------------------
#
# D O M A I N  C O M M O N S
#
# --------------------------------------------------------------------------------------------------------------
*#
*# Equal DOFs
*#
*include bas\Boundary\equalDOF.bas
*#
*# Beam Contact Elements
*#
*include bas\Elements\BeamContact\BeamContact.bas
*#
*# Recorders
*#
*include bas\Model\Recorders.bas

*tcl(LogFile)

puts " __   __       __          __                   _       "
puts "/ _ .|  \\ _|_ /  \\ _  _ _ (_  _ _ _  | _ |_ _ _(_ _  _ _"
puts "\\__)||__/  |  \\__/|_)(-| )__)(-(-_)  || )|_(-| | (_|(_(-"
puts "                  |                                     "
puts "                             *tcl(OpenSees::GetVersion) with OpenSees v[version]\n"
puts "Analysis summary\n"
*set var IntvNum=0
*loop intervals
*set var IntvNum=operation(IntvNum+1)
*if(IntvData(Enabled,int)==1)
*format "%d"
puts "Interval *IntvNum : *IntvData(Analysis_type) - *\
*if(strcmp(IntvData(Analysis_type),"Static")==0)
*# Static Monotonic
*if(strcmp(IntvData(Loading_path),"Monotonic")==0)
*format "%d%g"
[expr int(1+*IntvData(Analysis_steps,int))] steps"
*# Static Cyclic
*else
*set var npeaks=IntvData(Displacement_peaks-cycles,int)
*set var totalCyclicSteps=0
*for(index=1;index<=npeaks;index=index+2)
*set var dispRatio=IntvData(Displacement_peaks-cycles,*index,real)
*if(IntvData(Adjust_number_of_steps_according_to_displacement_ratio,int)==1)
*set var adjustedSteps=operation(dispRatio*IntvData(Analysis_steps,int))
*set var adjustedSteps=tcl(Bas_Int *adjustedSteps)
*set var totalCyclicSteps=operation(totalCyclicSteps+IntvData(Displacement_peaks-cycles,*operation(index+1),int)*adjustedSteps)
*else
*set var totalCyclicSteps=operation(totalCyclicSteps+IntvData(Displacement_peaks-cycles,*operation(index+1),int)*IntvData(Analysis_steps,int))
*endif
*endfor
*#set var index=operation(IntvNum*2)
*#set var cycles=IntvData(Displacement_peaks-cycles,*index,real)
*#[expr int(1+*operation(4*cycles*IntvData(Analysis_steps,int)))] steps"
[expr int(1+*operation(4*totalCyclicSteps))] steps"
*endif
*elseif(strcmp(IntvData(Analysis_type),"Transient")==0)
*format "%g%g%g"
[expr int(1.0 + *IntvData(Analysis_duration,real)/*IntvData(Analysis_time_step,real))] steps x *IntvData(Analysis_time_step,real) s"
*endif
*endif
*end intervals
puts "\n----------------\n"
set time_start [clock seconds]
puts "Starting analysis...\n"
*set var IntvNum=0
*loop intervals
*set var IntvNum=operation(IntvNum+1)
*if(IntvData(Enabled,int)==1)

# --------------------------------------------------------------------------------------------------------------
#
# I N T E R V A L   *IntvNum
#
# --------------------------------------------------------------------------------------------------------------

puts "Running interval *IntvNum"
*include bas\Actions\Loads.bas
*include bas\Analysis\UpdateMaterialStage.bas
*include bas\Analysis\UpdateParameters.bas
*include bas\Analysis\setParameter.bas

# recording the initial status

record

*include bas\Analysis\Analyze.bas
*if(IntvData(Keep_this_loading_active_until_the_end_of_analysis,int)==1)

# all previously defined patterns are constant for so on.

loadConst -time 0.0
*endif
*include bas\Analysis\RemovePattern.bas
*if(IntvData(Reset_at_the_end_of_the_interval_analysis,int)==1)

# reset all components to the initial state

reset
*endif
*if(IntvData(Set_time_at_the_end_of_the_interval_analysis,int)==1)

*format "%g"
setTime *IntvData(Time_to_be_set,real)
*endif
*endif
*end intervals

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
*#
*# Metadata
*#
*include bas\Model\Meta.bas

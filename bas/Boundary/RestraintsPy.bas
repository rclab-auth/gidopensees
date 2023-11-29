*set var RestraintsFound=0
*set Cond Surface_Restraints *nodes
*add Cond Line_Restraints *nodes
*add Cond Point_Restraints *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var RestraintsFound=1
*break
*endif
*end nodes
*if(RestraintsFound!=0)

# --------------------------------------------------------------------------------------------------------------
# R E S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

*endif
*if(RestraintsFound!=0)
*#--------------------------3D ----------------------------
*if(ndime==3)
*#--------------------------6 DOF -------------------------
*if(currentDOF==6)
# fix $NodeTag x-transl y-transl z-transl x-rot y-rot z-rot

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*format "%6d%3d%3d%3d%3d%3d%3d"
ops.fix(*NodesNum, *Cond(1,int), *Cond(2,int), *Cond(3,int), *Cond(4,int), *Cond(5,int), *Cond(6,int))
*endif
*end nodes
*else
# fix $NodeTag x-transl y-transl z-transl

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*format "%6d%3d%3d%3d"
ops.fix(*NodesNum, *Cond(1,int), *Cond(2,int), *Cond(3,int))
*endif
*end nodes
*endif
*#------------------------------- 2D Model ------------------------------
*elseif(ndime==2)
*#------------------------------- 2 DOF ---------------------------------
*if(currentDOF==2)
# fix $NodeTag x-transl y-transl

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*format "%6d%3d%3d"
ops.fix(*NodesNum, *Cond(1,int), *Cond(2,int))
*endif
*end nodes
*elseif(currentDOF==3)
*#----------------------------- 2D model 3 DOF ----------------------------------
# fix $NodeTag x-transl y-transl z-rot

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*format "%6d%3d%3d%3d"
ops.fix(*NodesNum, *Cond(1,int), *Cond(2,int), *Cond(6,int))
*endif
*end nodes
*#---------------------- 2D model 3 DOF (2 displacement, 1 fluid-pressure)
*elseif(currentDOF==30)
# fix $NodeTag x-transl -y-transl fluid-pressure

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*format "%6d%3d%3d%3d"
ops.fix(*NodesNum, *Cond(1,int), *Cond(2,int), *Cond(7,int))
*endif
*end nodes
*endif
*endif
*endif
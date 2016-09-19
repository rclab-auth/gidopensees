#
# Restraints
#

*#--------------------------3D ----------------------------
*if(GenData(Dimensions,int)==3)
*#--------------------------6 DOF -------------------------
*if(GenData(DOF,int)==6)
# fix $NodeTag x-transl y-transl z-transl x-rot y-rot z-rot 

*set Cond Point_Restraints *nodes
*add Cond Line_Restraints *nodes
*add Cond Surface_Restraints *nodes
*loop nodes *OnlyInCond
fix *NodesNum *Cond(1,int) *Cond(2,int) *Cond(3,int) *Cond(4,int) *Cond(5,int) *Cond(6,int)
*end nodes
*else
# fix $NodeTag x-transl y-transl z-transl

*set Cond Point_Restraints *nodes
*add Cond Line_Restraints *nodes
*add Cond Surface_Restraints *nodes
*loop nodes *OnlyInCond
fix *NodesNum *Cond(1,int) *Cond(2,int) *Cond(3,int)
*end nodes
*endif
*#------------------------------- 2D Model ------------------------------
*elseif(GenData(Dimensions,int)==2)
*#------------------------------- 2 DOF ---------------------------------
*if(GenData(DOF,int)==2)
# fix $NodeTag x-transl y-transl 

*set Cond Point_Restraints *nodes
*add Cond Line_Restraints *nodes
*add Cond Surface_Restraints *nodes
*loop nodes *OnlyInCond
fix *NodesNum *Cond(1,int) *Cond(2,int)
*end nodes
*else
*#----------------------------- 2D model 3 DOF ----------------------------------
*set Cond Point_Restraints *nodes
*add Cond Line_Restraints *nodes
*add Cond Surface_Restraints *nodes
# fix $NodeTag x-transl y-transl z-rot 

*loop nodes *OnlyInCond
fix *NodesNum *Cond(1,int) *Cond(2,int) *Cond(6,int)
*end nodes
*endif
*endif
*# variable to check masses existance
*set var MassFound=0
*set Cond Point_Mass *nodes *CanRepeat
*add Cond Line_Mass *nodes *CanRepeat
*add Cond Surface_Mass *nodes *CanRepeat
*add Cond Volume_Mass *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var MassFound=1
*break
*endif
*end nodes
*if(MassFound==1)

# --------------------------------------------------------------------------------------------------------------
# M A S S E S
# --------------------------------------------------------------------------------------------------------------

*endif
*set Cond Point_Mass *nodes *CanRepeat
*add Cond Line_Mass *nodes *CanRepeat
*add Cond Surface_Mass *nodes *CanRepeat
*add Cond Volume_Mass *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(Loopvar==1)
# Mass Definition : mass $NodeTag $(ndf nodal mass values corresponding to each DOF)

*endif
*format "%6d"
mass *NodesNum *\
*#-------------------------3D-6DOF------------------------------
*if(currentDOF==6)
*format "%8g%8g%8g%8g%8g%8g"
*Cond(2,real) *Cond(3,real) *Cond(4,real) *Cond(5,real) *Cond(6,real) *Cond(7,real)
*elseif(currentDOF==3)
*#--------------------------2D-3DOF----------------------------
*if(ndime==2)
*format "%8g%8g%8g"
*Cond(2,real) *Cond(3,real) *Cond(6,real)
*else
*#--------------------------3D-3DOF----------------------------
*format "%8g%8g%8g"
*Cond(2,real) *Cond(3,real) *Cond(4,real)
*endif
*#--------------------------2D-3PDOF----------------------------
*elseif(currentDOF==30)
*format "%8g%8g   "
*Cond(2,real) *Cond(3,real) 0.000
*#--------------------------2D-2DOF----------------------------
*else
*format "%8g%8g"
*Cond(2,real) *Cond(3,real)
*endif
*endif
*end nodes
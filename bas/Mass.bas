*# variable to check masses existance
*set var MassFound=0
*set Cond Point_Mass *nodes
*loop nodes *OnlyInCond
*set var MassFound=1
*break
*end nodes
*if(MassFound==1)

# --------------------------------------------------------------------------------------------------------------
# M A S S E S
# --------------------------------------------------------------------------------------------------------------

*endif
*set Cond Point_Mass *nodes
*loop nodes *OnlyInCond
*if(Loopvar==1)
# Mass Definition : mass $NodeTag $(ndf nodal mass values corresponding to each DOF)

*endif
*format "%6d"
mass *NodesNum *\
*#-------------------------3D-6DOF------------------------------
*if(GenData(DOF,int)==6)
*format "%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*Cond(2,real) *Cond(3,real) *Cond(4,real) *Cond(5,real) *Cond(6,real) *Cond(7,real)
*elseif(GenData(DOF,int)==3) 
*#--------------------------2D-3DOF----------------------------
*if(GenData(Dimensions,int)==2)
*format "%8.3f%8.3f%8.3f"
*Cond(2,real) *Cond(3,real) *Cond(6,real)
*else
*#--------------------------3D-3DOF----------------------------
*format "%8.3f%8.3f%8.3f"
*Cond(2,real) *Cond(3,real) *Cond(4,real)
*endif
*#--------------------------2D-2DOF----------------------------
*else
*format "%8.3f%8.3f"
*Cond(2,real) *Cond(3,real)
*endif
*end nodes

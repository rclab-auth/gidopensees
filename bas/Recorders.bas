
# --------------------------------------------------------------------------------------------------------------
# R E C O R D E R S
# --------------------------------------------------------------------------------------------------------------

*# Check if transient analysis is taking place, for recording nodal velocities and accelerations
*set var Transient_analysis=0
*loop intervals
*if(strcmp(IntvData(Analysis_type),"Transient")==0)
*set var Transient_analysis=1
*break
*endif
*end intervals
*#
*# Nodes
*#
*if(ndime==2)
recorder Node -file Node_displacements.out -time -nodeRange 1 *cntNodes -dof 1 2 disp
recorder Node -file Node_rotations.out -time -nodeRange 1 *cntNodes -dof 3 disp
recorder Node -file Node_forceReactions.out -time -nodeRange 1 *cntNodes -dof 1 2 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 *cntNodes -dof 3 reaction
*if(Transient_analysis==1)
recorder Node -file Node_relativeAccelerations.out -time -nodeRange 1 *cntNodes -dof 1 2 accel
recorder Node -file Node_relativeVelocities.out -time -nodeRange 1 *cntNodes -dof 1 2 vel
*endif
*# 3D
*else
recorder Node -file Node_displacements.out -time -nodeRange 1 *cntNodes -dof 1 2 3 disp
recorder Node -file Node_rotations.out -time -nodeRange 1 *cntNodes -dof 4 5 6 disp
recorder Node -file Node_forceReactions.out -time -nodeRange 1 *cntNodes -dof 1 2 3 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 *cntNodes -dof 4 5 6 reaction
*if(Transient_analysis==1)
recorder Node -file Node_relativeAccelerations.out -time -nodeRange 1 *cntNodes -dof 1 2 3 accel
recorder Node -file Node_relativeVelocities.out -time -nodeRange 1 *cntNodes -dof 1 2 3 vel
*endif
*endif
*#
*# Brick
*#
*if(cntStdBrick!=0)
*set var FirstBrickElemNumber=0
*set var LastBrickElemNumber=0
*loop elems
*if(ElemsType==5)
*set var FirstBrickElemNumber=ElemsNum
*break
*endif
*end elems
*loop elems
*if(ElemsType==5)
*set var LastBrickElemNumber=ElemsNum
*endif
*end elems
recorder Element -file stdBrick_force.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber forces
recorder Element -file stdBrick_stress.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber stresses
recorder Element -file stdBrick_strain.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber strains
*endif
*#
*# Shell
*#
*if(cntShell!=0)
*set var FirstShellElemNumber=0
*set var LastShellElemNumber=0
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var FirstShellElemNumber=ElemsNum
*break
*endif
*end elems
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var LastShellElemNumber=ElemsNum
*endif
*end elems
recorder Element -file ShellMITC4_force.out -time -eleRange *FirstShellElemNumber *LastShellElemNumber forces
recorder Element -file ShellMITC4_stress.out -time -eleRange *FirstShellElemNumber *LastShellElemNumber stresses
*endif
*#
*# Quad
*#
*if(cntQuad!=0)
recorder Element -file Quad_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
forces
recorder Element -file Quad_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
stresses
recorder Element -file Quad_strain.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
strains
*endif
*#
*# Tri
*#
*if(cntTri31!=0)
recorder Element -file Tri31_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems
forces
recorder Element -file Tri31_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*#
*# Elastic beam-column
*#
*if(cntEBC!=0)
recorder Element -file ElasticBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*#
*# Elastic Timoshenko beam-column
*#
*if(cntETB!=0)
recorder Element -file ElasticTimoshenkoBeam_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*#
*# Force beam-column
*#
*if(cntFBC!=0)
recorder Element -file ForceBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
recorder Element -file ForceBeamColumn_basicDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
basicDeformation
recorder Element -file ForceBeamColumn_plasticDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
plasticDeformation
*endif
*#
*# Displacement beam-column
*#
*if(cntDBC!=0)
recorder Element -file DispBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
recorder Element -file DispBeamColumn_basicDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
basicDeformation
recorder Element -file DispBeamColumn_plasticDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
plasticDeformation
*endif
*#
*# Truss
*#
*if(cntTruss!=0)
recorder Element -file Truss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*#
*# Corotational truss
*#
*if(cntCorotTruss!=0)
recorder Element -file CorotTruss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
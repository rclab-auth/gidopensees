
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
*if(GenData(Nodal_displacements,int)==1)
recorder Node -file Node_displacements.out -time -nodeRange 1 *cntNodes -dof 1 2 disp
*endif
*if(GenData(Nodal_rotations,int)==1)
recorder Node -file Node_rotations.out -time -nodeRange 1 *cntNodes -dof 3 disp
*endif
*if(GenData(Nodal_reactions,int)==1)
recorder Node -file Node_forceReactions.out -time -nodeRange 1 *cntNodes -dof 1 2 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 *cntNodes -dof 3 reaction
*endif
*if(Transient_analysis==1)
*if(GenData(Nodal_relative_accelerations,int)==1)
recorder Node -file Node_relativeAccelerations.out -time -nodeRange 1 *cntNodes -dof 1 2 accel
*endif
*if(GenData(Nodal_relative_velocities,int)==1)
recorder Node -file Node_relativeVelocities.out -time -nodeRange 1 *cntNodes -dof 1 2 vel
*endif
*endif
*# 3D
*else
*if(GenData(Nodal_displacements,int)==1)
recorder Node -file Node_displacements.out -time -nodeRange 1 *cntNodes -dof 1 2 3 disp
*endif
*if(GenData(Nodal_rotations,int)==1)
recorder Node -file Node_rotations.out -time -nodeRange 1 *cntNodes -dof 4 5 6 disp
*endif
*if(GenData(Nodal_reactions,int)==1)
recorder Node -file Node_forceReactions.out -time -nodeRange 1 *cntNodes -dof 1 2 3 reaction
recorder Node -file Node_momentReactions.out -time -nodeRange 1 *cntNodes -dof 4 5 6 reaction
*endif
*if(Transient_analysis==1)
*if(GenData(Nodal_relative_accelerations,int)==1)
recorder Node -file Node_relativeAccelerations.out -time -nodeRange 1 *cntNodes -dof 1 2 3 accel
*endif
*if(GenData(Nodal_relative_velocities,int)==1)
recorder Node -file Node_relativeVelocities.out -time -nodeRange 1 *cntNodes -dof 1 2 3 vel
*endif
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
*if(GenData(_Forces,int)==1)
recorder Element -file stdBrick_force.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber forces
*endif
*if(GenData(_Stresses,int)==1)
recorder Element -file stdBrick_stress.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber stresses
*endif
*if(GenData(_Strains,int)==1)
recorder Element -file stdBrick_strain.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber strains
*endif
*endif
*#
*# ShellMITC4
*#
*if(cntShell!=0)
*if(GenData(Forces,int)==1)
recorder Element -file ShellMITC4_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file ShellMITC4_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*endif
*#
*# ShellDKGQ
*#
*if(cntShellDKGQ!=0)
*if(GenData(Forces,int)==1)
recorder Element -file ShellDKGQ_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file ShellDKGQ_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*endif
*#
*# Quad
*#
*if(cntQuad!=0)
*if(GenData(Forces,int)==1)
recorder Element -file Quad_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file Quad_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*if(GenData(Strains,int)==1)
recorder Element -file Quad_strain.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems
strains
*endif
*endif
*#
*# QuadUP
*#
*if(cntQuadUP!=0)
*if(GenData(Forces,int)==1)
recorder Element -file QuadUP_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file QuadUP_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*if(GenData(Strains,int)==1)
recorder Element -file QuadUP_strain.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems
strains
*endif
*endif
*#
*# Tri
*#
*if(cntTri31!=0)
*if(GenData(Forces,int)==1)
recorder Element -file Tri31_force.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*if(GenData(Stresses,int)==1)
recorder Element -file Tri31_stress.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems
stresses
*endif
*endif
*#
*# Elastic beam-column
*#
*if(cntEBC!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file ElasticBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*endif
*#
*# Elastic Timoshenko beam-column
*#
*if(cntETB!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file ElasticTimoshenkoBeam_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*endif
*#
*# Force beam-column
*#
*if(cntFBC!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file ForceBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*if(GenData(Basic_deformation,int)==1)
recorder Element -file ForceBeamColumn_basicDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
basicDeformation
*endif
*if(GenData(Plastic_Deformation,int)==1)
recorder Element -file ForceBeamColumn_plasticDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
plasticDeformation
*endif
*endif
*#
*# Displacement beam-column
*#
*if(cntDBC!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file DispBeamColumn_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*if(GenData(Basic_deformation,int)==1)
recorder Element -file DispBeamColumn_basicDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
basicDeformation
*endif
*if(GenData(Plastic_Deformation,int)==1)
recorder Element -file DispBeamColumn_plasticDeformation.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
plasticDeformation
*endif
*endif
*#
*# Flexure-Shear Interaction Displacement beam-column
*#
*if(cntDBCI!=0)
*if(GenData(Local_forces,int)==1)
recorder Element -file DispBeamColumnInt_localForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*ElemsNum *\
*endif
*end elems
localForce
*endif
*endif
*#
*# Truss
*#
*if(cntTruss!=0)
*if(GenData(Axial_force,int)==1)
recorder Element -file Truss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*endif
*#
*# Corotational truss
*#
*if(cntCorotTruss!=0)
*if(GenData(Axial_force,int)==1)
recorder Element -file CorotTruss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*endif
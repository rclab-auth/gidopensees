
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
recorder Element -file stdBrick_stress.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber stresses
recorder Element -file stdBrick_strain.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber strains
recorder Element -file stdBrick_force.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber forces
recorder Element -binary stdBrick_stress.bin -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber stresses
recorder Element -binary stdBrick_strain.bin -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber strains
recorder Element -binary stdBrick_force.bin -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber forces
*endif
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
recorder Element -binary ShellMITC4_force.bin -time -eleRange *FirstShellElemNumber *LastShellElemNumber forces
recorder Element -binary ShellMITC4_stress.bin -time -eleRange *FirstShellElemNumber *LastShellElemNumber stresses
*endif
*#
*if(cntQuad!=0)
*set var FirstQuadElemNumber=0
*set var LastQuadElemNumber=0
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*set var FirstQuadElemNumber=ElemsNum
*break
*endif
*end elems
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*set var LastQuadElemNumber=ElemsNum
*endif
*end elems
recorder Element -file Quad_force.out -time -eleRange *FirstQuadElemNumber *LastQuadElemNumber forces
recorder Element -file Quad_stress.out -time -eleRange *FirstQuadElemNumber *LastQuadElemNumber stresses
recorder Element -binary Quad_force.bin -time -eleRange *FirstQuadElemNumber *LastQuadElemNumber forces
recorder Element -binary Quad_stress.bin -time -eleRange *FirstQuadElemNumber *LastQuadElemNumber stresses
*endif
*#
*if(cntEBC!=0)
recorder Element -file ElasticBeamColumn_force.out -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
forces
recorder Element -binary ElasticBeamColumn_force.bin -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*#
*if(cntETB!=0)
recorder Element -file ElasticTimoshenkoBeam_force.out -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
forces
recorder Element -binary ElasticTimoshenkoBeam_force.bin -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*#
*if(cntTruss!=0)
recorder Element -file truss_axialForce.out -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
recorder Element -binary truss_axialForce.bin -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*#
*if(cntCorotTruss!=0)
recorder Element -file CorotTruss_axialForce.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
recorder Element -binary CorotTruss_axialForce.bin -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
recorder Node -file Nodes_disp.out -time -nodeRange 1 *cntNodes disp
recorder Node -binary Nodes_disp.bin -time -nodeRange 1 *cntNodes disp
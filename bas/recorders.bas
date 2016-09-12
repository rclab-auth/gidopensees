
*if(StdBrickFound==1)
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
recorder Element -file HexahedraBrickElemStresses.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber stresses
recorder Element -file HexahedraBrickElemStrains.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber strains
recorder Element -file HexahedraBrickElemForces.out -time -eleRange *FirstBrickElemNumber *LastBrickElemNumber forces
*endif
*#
*if(ShellFound==1)
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
recorder Element -file ShellForces.out -time -eleRange *FirstShellElemNumber *LastShellElemNumber forces
recorder Element -file ShellStresses.out -time -eleRange *FirstShellElemNumber *LastShellElemNumber stresses
*endif
*#
*if(QuadFound==1)
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
recorder Element -file QuadForces.out -time -eleRange *FirstQuadElemNumber *LastQuadElemNumber forces
recorder Element -file QuadStresses.out -time -eleRange *FirstQuadElemNumber *LastQuadElemNumber stresses
*endif
*#
*if(EBCFound==1)
recorder Element -file ElasticBeamColumnForces.out -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*#
*if(ETBFound==1)
recorder Element -file ElasticTimoshenkoBeamForces.out -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems
forces
*endif
*#
*if(TrussFound==1)
recorder Element -file TrussAxialForces.out -time -ele *\ 
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
*#
*if(CorotTrussFound==1)
recorder Element -file CorotTrussAxialForces.out -time -ele *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems
axialForce
*endif
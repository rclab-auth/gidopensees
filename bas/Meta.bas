
# --------------------------------------------------------------------------------------------------------------
#
# M E T A D A T A
#
# --------------------------------------------------------------------------------------------------------------

# Number of nodes
# *cntNodes

# Elements 1D
# *operation(cntEBC+cntETB+cntTruss+cntCorotTruss)

# Elements 2D
# *operation(cntQuad+cntShell)

# Elements 3D
# *cntStdBrick
*if(cntEBC!=0)

# ElasticBeamColumn
# *cntEBC
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntETB!=0)

# ElasticTimoshenkoBeam
# *cntETB
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntFBC!=0)

# ForceBeamColumn
# *cntFBC
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntTruss!=0)

# Truss
# *cntTruss
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntCorotTruss!=0)

# CorotTruss
# *cntCorotTruss
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems 

*endif
*if(cntQuad!=0)

# Quad
# *cntQuad
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems 

*endif
*if(cntShell!=0)

# ShellMITC4
# *cntShell
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems 

*endif
*if(cntTri31!=0)

# Tri31
# *cntTri31
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems 

*endif
*if(cntStdBrick!=0)

# stdBrick
# *cntStdBrick
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*ElemsNum *\
*endif
*end elems

*endif
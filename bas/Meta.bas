
# -------------------------------
#
# METADATA (used by OpenSeesPost)
#
# -------------------------------
#
# Nodes
# *cntNodes
#
# Elements 1D
# *operation(cntEBC+cntETB+cntTruss+cntCorotTruss)
#
# Elements 2D
# *operation(cntQuad+cntShell)
#
# Elements 3D
# *cntStdBrick
#
*if(cntEBC!=0)
# ElasticBeamColumn
# *cntEBC 
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems 
*\n
#
*endif
*if(cntETB!=0)
# ElasticTimoshenkoBeam
# *cntETB *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems 
*\n
#
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
*\n
#
*endif
*if(cntCorotTruss!=0)
# CorotTruss
# *cntCorotTruss
# *\
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"CorotTruss")==0)
*ElemsNum *\
*endif
*end elems 
*\n
#
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
*\n
#
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
*\n
#
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
*\n
#
*endif
#
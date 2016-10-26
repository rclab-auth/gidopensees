# Loads

*set var PatternTag=operation(IntvNum*100)
*# -------------------------------------3D--------------------------------------
*if(GenData(Dimensions,int)==3)
*# --------------------------------------6 DOF--------------------------
*if(GenData(DOF,int)==6)
*if(strcmp(IntvData(Loading_Type),"Constant")==0 || strcmp(IntvData(Loading_Type),"Linear")==0)
pattern Plain *PatternTag *IntvData(Loading_Type) {
*set cond point_Loads *nodes *CanRepeat
*add cond Line_Loads *nodes *CanRepeat
*loop nodes *OnlyInCond
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(3,real) *cond(4,real) *cond(5,real) *cond(6,real)
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
}
*endif
*else
*# ----------------------------------3 DOF -------------------------------------
*if(strcmp(IntvData(Loading_Type),"Constant")==0 || strcmp(IntvData(Loading_Type),"Linear")==0)
pattern Plain *PatternTag *IntvData(Loading_Type) {
*set cond point_Loads *nodes *CanRepeat
*add cond Line_Loads *nodes *CanRepeat
*loop nodes *OnlyInCond
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(3,real) 
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
}
*endif
*endif
*else
*# -------------------------------2D ------2 DOF--------------------------------------------
*if(GenData(DOF,int)==2)
*if(strcmp(IntvData(Loading_Type),"Constant")==0 || strcmp(IntvData(Loading_Type),"Linear")==0)
pattern Plain *PatternTag *IntvData(Loading_Type) {
*set cond point_Loads *nodes *CanRepeat
*add cond Line_Loads *nodes *CanRepeat
*loop nodes *OnlyInCond
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f"
*cond(1,real) *cond(2,real) 
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
}
*endif
*#-----------------------------2D----3 DOF--------------------------------------------------
*elseif(GenData(DOF,int)==3)
*if(strcmp(IntvData(Loading_Type),"Constant")==0 || strcmp(IntvData(Loading_Type),"Linear")==0)
pattern Plain *PatternTag *IntvData(Loading_Type) {
*set cond point_Loads *nodes *CanRepeat
*add cond Line_Loads *nodes *CanRepeat
*loop nodes *OnlyInCond
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(5,real)
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
}
*endif
*endif
*endif

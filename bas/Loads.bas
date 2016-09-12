#
# Loading
#

*# -------------------------------------3D--------------------------------------
*if(GenData(Dimensions,int)==3)
*# --------------------------------------6 DOF--------------------------
*if(GenData(DOF,int)==6)
timeSeries Constant 1
pattern Plain 1 1 {
*set cond point_Loads *nodes
*add cond Line_Loads *nodes
*loop nodes *OnlyInCond
  load *NodesNum *\
*format "%1.2f%1.2f%1.2f%1.2f%1.2f%1.2f"
*cond(1,real) *cond(2,real) *cond(3,real) *cond(4,real) *cond(5,real) *cond(6,real)
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
}
*else
*# ----------------------------------3 DOF -------------------------------------
timeSeries Constant 1
pattern Plain 1 1 {
*set cond point_Loads *nodes
*add cond Line_Loads *nodes
*loop nodes *OnlyInCond
  load *NodesNum *\
*format "%1.2f%1.2f%1.2f"
*cond(1,real) *cond(2,real) *cond(3,real) 
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
}
*endif
*else
*# -------------------------------2D ------2 DOF--------------------------------------------
*if(GenData(DOF,int)==2)
timeSeries Constant 1
pattern Plain 1 1 {
*set cond point_Loads *nodes
*add cond Line_Loads *nodes
*loop nodes *OnlyInCond
  load *NodesNum *\
*format "%1.2f%1.2f"
*cond(1,real) *cond(2,real) 
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
}
*#-----------------------------2D----3 DOF--------------------------------------------------
*elseif(GenData(DOF,int)==3)
timeSeries Constant 1
pattern Plain 1 1 {
*set cond point_Loads *nodes
*add cond Line_Loads *nodes
*loop nodes *OnlyInCond
  load *NodesNum *\
*format "%1.2f%1.2f%1.2f"
*cond(1,real) *cond(2,real) *cond(5,real)
*end nodes
*set cond Line_Uniform_Loads *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
}
*endif
*endif
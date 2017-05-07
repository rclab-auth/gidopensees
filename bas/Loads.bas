# Loads

*set var PatternTag=operation(IntvNum*100)
*if(strcmp(IntvData(Loading_type),"Constant")==0 || strcmp(IntvData(Loading_type),"Linear")==0)
pattern Plain *PatternTag *IntvData(Loading_type) {
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(3,real) *cond(4,real) *cond(5,real) *cond(6,real)
*elseif(nodeDOF==3)
*if(ndime==3)
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(3,real)
*# 2D with 3DOF : Ux Uy Rz --> Fx Fy Mz
*else
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(6,real)
*endif
*elseif(nodeDOF==2)
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f"
*cond(1,real) *cond(2,real)
*endif
*end nodes
*if(ndime==3)
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
*# if it is 2D..
*else
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
*endif
}
*elseif(strcmp(IntvData(Loading_type),"Multiple_support_excitation")==0)
*include analysis/MultipleSupportExcitationPattern.bas
*endif

*set var PrintPlainPattern=0
*set var PrintMultiSupportPattern=0
*# Check if there are any loads applied
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*add cond Point_Displacements *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var PrintPlainPattern=1
*break
*end nodes
*set cond Line_Uniform_Forces *elems *CanRepeat
*loop elems *OnlyInCond
*set var PrintPlainPattern=1
*break
*end elems
*if(IntvData(Activate_dead_load,int)==1)
*set var PrintPlainPattern=1
*endif
*set cond Point_Ground_Motion_from_Record *nodes
*add cond Point_Sine_Ground_Motion *nodes
*loop nodes *OnlyInCond
*set var PrintMultiSupportPattern=1
*break
*end nodes
*if(strcmp(IntvData(Loading_type),"Constant")==0 || strcmp(IntvData(Loading_type),"Linear")==0)
*# if there are loads applied, Create the pattern
*if(PrintPlainPattern==1)
# Loads - Plain Pattern

*set var PatternTag=operation(IntvNum*100)
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
*set cond Point_Displacements *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*# 3D - 6 Dofs -> Ux Uy Uz Rx Ry Rz
*# If value is zero, it is like a restraint! So a restraint condition can be used instead.
*if(cond(1,real)!=0)
*format "%d%g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%d%g"
  sp *NodesNum 2 *cond(2,real)
*endif
*if(cond(3,real)!=0)
*format "%d%g"
  sp *NodesNum 3 *cond(3,real)
*endif
*if(cond(4,real)!=0)
*format "%d%g"
  sp *NodesNum 4 *cond(4,real)
*endif
*if(cond(5,real)!=0)
*format "%d%g"
  sp *NodesNum 5 *cond(5,real)
*endif
*if(cond(6,real)!=0)
*format "%d%g"
  sp *NodesNum 6 *cond(6,real)
*endif
*elseif(nodeDOF==3)
*if(ndime==3)
*# 3D - 3 Dofs -> Ux Uy Uz
  sp *NodesNum 1 *cond(1,real)
  sp *NodesNum 2 *cond(2,real)
  sp *NodesNum 3 *cond(3,real)
*else
*# 2D - 6 Dofs -> 2 Translations (Ux,Uy) 1 Rotation Rz
*if(cond(1,real)!=0)
*format "%d%g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%d%g"
  sp *NodesNum 2 *cond(2,real)
*endif
*if(cond(6,real)!=0)
*format "%d%g"
  sp *NodesNum 3 *cond(6,real)
*endif
*endif
*# 2 dofs
*else
*if(cond(1,real)!=0)
*format "%d%g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%d%g"
  sp *NodesNum 2 *cond(2,real)
*endif
*endif
*end nodes
*if(IntvData(Activate_dead_load,int)==1 && strcmp(IntvData(Analysis_type),"Static")==0 && strcmp(IntvData(Integrator_type),"Load_control")==0)
# Dead Loads
*include DeadLoad.bas
*endif
}
*endif
*elseif(strcmp(IntvData(Loading_type),"Multiple_support_excitation")==0)
*if(PrintMultiSupportPattern==1)
# Loads - Multiple Support Pattern

*set var PatternTag=operation(IntvNum*1000)
*include analysis/MultipleSupportExcitationPattern.bas
*endif
*endif

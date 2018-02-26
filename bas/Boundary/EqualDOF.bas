*#
*#      Automatic equalDOF commands between nodes, which belong to different domains and share the same location. (see SSI: Beam-Column elements' connection with Quad elements)
*#
*if(GenData(Activate_automatic_equalDOF_between_nodes_of_different_domains_with_identical_coordinates,int)==1)
*if(numberGroups>=2)

#
# Auto equalDOF commands between nodes, which belong to different domains
#

*if(TwoDOF==1)
*set var TwoDOFnNodes=tcl(ReturnGroupNodes 2)
*endif
*if(ThreeDOF==1)
*set var ThreeDOFnNodes=tcl(ReturnGroupNodes 3)
*endif
*if(SixDOF==1)
*set var SixDOFnNodes=tcl(ReturnGroupNodes 6)
*endif
*if(ThreePDOF==1)
*set var ThreePDOFnNodes=tcl(ReturnGroupNodes 30)
*endif
*if(TwoDOF==1 && ThreeDOF==1)
*for(i=1;i<=TwoDOFnNodes;i=i+1)
*set var NodeTag1=tcl(ReturnGroupNodeTag 2 *i)
*for(j=1;j<=ThreeDOFnNodes;j=j+1)
*set var NodeTag2=tcl(ReturnGroupNodeTag 3 *j)
*set var Identical=tcl(CompareNodesCoordinates *NodeTag1 *NodeTag2)
*if(Identical==1)
equalDOF *NodeTag1 *NodeTag2 1 2
*endif
*endfor
*endfor
*# 3 (with fluid-pressure) DOF and 3 DOF domain
*elseif(ThreeDOF==1 && ThreePDOF==1)
*for(ii=1;ii<=ThreePDOFnNodes;ii=ii+1)
*set var NodeTag1=tcl(ReturnGroupNodeTag 30 *ii)
*for(jj=1;jj<=ThreeDOFnNodes;jj=jj+1)
*set var NodeTag2=tcl(ReturnGroupNodeTag 3 *jj)
*set var Identical=tcl(CompareNodesCoordinates *NodeTag1 *NodeTag2)
*if(Identical==1)
equalDOF *NodeTag1 *NodeTag2 1 2
*endif
*endfor
*endfor
*# 3 DOF and 6 DOF domain
*elseif(ThreeDOF==1 && SixDOF==1)
*for(iii=1;iii<=ThreeDOFnNodes;iii=iii+1)
*set var NodeTag1=tcl(ReturnGroupNodeTag 3 *iii)
*for(jjj=1;jjj<=SixDOFnNodes;jjj=jjj+1)
*set var NodeTag2=tcl(ReturnGroupNodeTag 6 *jjj)
*set var Identical=tcl(CompareNodesCoordinates *NodeTag1 *NodeTag2)
*if(Identical==1)
equalDOF *NodeTag1 *NodeTag2 1 2 3
*endif
*endfor
*endfor
*endif
*endif
*endif
*#
*# Automatic equalDOF commands between nodes of Quad/QuadUP elements, which share the same vertical (Y) location
*#
*set var printQuadEqualDOF=0
*if(cntQuad!=0)
*loop materials
*if(strcmp(MatProp(Element_type:),"Quad")==0)
*if(MatProp(Define_equalDOF_between_nodes_of_the_same_vertical_location,int)==1)
*set var printQuadEqualDOF=1

#
# Auto equalDOF commands between Quad nodes, which share the same vertical (Y) location
#

*break
*endif
*endif
*end materials
*if(printQuadEqualDOF==1)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*if(ElemsMatProp(Define_equalDOF_between_nodes_of_the_same_vertical_location,int)==1)
*set var x1=NodesCoord(1,1)
*set var x2=NodesCoord(2,1)
*set var x3=NodesCoord(3,1)
*set var x4=NodesCoord(4,1)
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(1) *ElemsConec(4) y)
*if(Identical==1)
*if(x1<x4)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(1))
*if(Exists==-1)
equalDOF *ElemsConec(1) *ElemsConec(4) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(1))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(4))
*if(Exists==-1)
equalDOF *ElemsConec(4) *ElemsConec(1) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(4))
*endif
*endif
*endif
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(2) *ElemsConec(3) y)
*if(Identical==1)
*if(x2<x3)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(2))
*if(Exists==-1)
equalDOF *ElemsConec(2) *ElemsConec(3) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(2))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(3))
*if(Exists==-1)
equalDOF *ElemsConec(3) *ElemsConec(2) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(3))
*endif
*endif
*endif
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(1) *ElemsConec(2) y)
*if(Identical==1)
*if(x1<x2)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(1))
*if(Exists==-1)
equalDOF *ElemsConec(1) *ElemsConec(2) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(1))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(2))
*if(Exists==-1)
equalDOF *ElemsConec(2) *ElemsConec(1) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(2))
*endif
*endif
*endif
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(4) *ElemsConec(3) y)
*if(Identical==1)
*if(x4<x3)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(4))
*if(Exists==-1)
equalDOF *ElemsConec(4) *ElemsConec(3) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(4))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(3))
*if(Exists==-1)
equalDOF *ElemsConec(3) *ElemsConec(4) 1 2
*set var dummy=tcl(AddToQuadMasterNodeList *ElemsConec(3))
*endif
*endif
*endif
*endif
*endif
*end elems
*endif
*endif
*set var printQuadUPEqualDOF=0
*if(cntQuadUP!=0)
*loop materials
*if(strcmp(MatProp(Element_type:),"QuadUP")==0)
*if(MatProp(Define_equal_translational_DOF_between_nodes_of_the_same_vertical_location,int)==1)
*set var printQuadUPEqualDOF=1

#
# Auto equalDOF commands between QuadUP nodes, which share the same vertical (Y) location
#

*break
*endif
*endif
*end materials
*if(printQuadUPEqualDOF==1)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*if(ElemsMatProp(Define_equal_translational_DOF_between_nodes_of_the_same_vertical_location,int)==1)
*set var x1=NodesCoord(1,1)
*set var x2=NodesCoord(2,1)
*set var x3=NodesCoord(3,1)
*set var x4=NodesCoord(4,1)
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(1) *ElemsConec(4) y)
*if(Identical==1)
*if(x1<x4)
*set var Exists=tcl(ExistsToQuadUPMasterNodeList *ElemsConec(1))
*if(Exists==-1)
equalDOF *ElemsConec(1) *ElemsConec(4) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(1))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(4))
*if(Exists==-1)
equalDOF *ElemsConec(4) *ElemsConec(1) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(4))
*endif
*endif
*endif
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(2) *ElemsConec(3) y)
*if(Identical==1)
*if(x2<x3)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(2))
*if(Exists==-1)
equalDOF *ElemsConec(2) *ElemsConec(3) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(2))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(3))
*if(Exists==-1)
equalDOF *ElemsConec(3) *ElemsConec(2) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(3))
*endif
*endif
*endif
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(1) *ElemsConec(2) y)
*if(Identical==1)
*if(x1<x2)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(1))
*if(Exists==-1)
equalDOF *ElemsConec(1) *ElemsConec(2) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(1))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(2))
*if(Exists==-1)
equalDOF *ElemsConec(2) *ElemsConec(1) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(2))
*endif
*endif
*endif
*set var Identical=tcl(CompareNodesCoordinates *ElemsConec(4) *ElemsConec(3) y)
*if(Identical==1)
*if(x4<x3)
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(4))
*if(Exists==-1)
equalDOF *ElemsConec(4) *ElemsConec(3) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(4))
*endif
*else
*set var Exists=tcl(ExistsToQuadMasterNodeList *ElemsConec(3))
*if(Exists==-1)
equalDOF *ElemsConec(3) *ElemsConec(4) 1 2
*set var dummy=tcl(AddToQuadUPMasterNodeList *ElemsConec(3))
*endif
*endif
*endif
*endif
*endif
*end elems
*endif
*endif
*#---------------------------
*# Saving Equal Constraints ID number to the corresponding list
*#---------------------------
*set var dummy=tcl(equalDOFClear)
*set var IDExists=-1
*set cond Point_Equal_constraint_master_node *nodes
*# We check, for every node that user applied Equal Constraint Condition, the ID number and we save it in a list.
*# This list then contains every equal constraint id number, one time each.
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckIDequalConstraintList *Cond(1))
*endif
*if(IDExists==-1)
*set var dummy=tcl(AddEqualConstraintIDList *Cond(1) )
*else
*MessageBox Error: For each Equal constraint ID group, only one master node can be selected.
*endif
*end nodes
*set var HowmanyECID=tcl(HowmanyECID)
*#---------------------------
*# Printing EqualDOF
*#---------------------------
*# if we have at least one Equal Constraint Condition applied
*if(HowmanyECID>=1)

# --------------------------------------------------------------------------------------------------------------
# E Q U A L  C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# Equal Constraint/equalDOF Definition : equalDOF $MasterNode $SlaveNode $DOFs

*# For every Equal constaint ID do the following:
*for(i=1;i<=HowmanyECID;i=i+1)
*# ECID get the ID number from the corresponding list
*#set var ECID=tcl(ECID *i)
*set var dummy=tcl(RestartECSlaveNodes)
*set cond Point_Equal_constraint_master_node *nodes
*loop nodes *OnlyInCond
*set var CorrectID=tcl(IsThisECID *Cond(1) *i)
*#if(Cond(1,int)==ECID)
*if(CorrectID==1)
*set var MasterNode=NodesNum
*break
*endif
*end nodes
*set cond Line_Equal_constraint_slave_nodes *nodes
*add cond Point_Equal_constraint_slave_nodes *nodes
*# For every node that belongs to the running EC ID do the following
*loop nodes *OnlyInCond
*set var CorrectID=tcl(IsThisECID *Cond(1) *i)
*#if(Cond(1,int)==ECID)
*if(CorrectID==1)
*set var Translx=0
*set var Transly=0
*set var Translz=0
*set var Rotx=0
*set var Roty=0
*set var Rotz=0
*# for each Equal constaint ID, this procedure clears the list of the equalDOF(Translx,Transly,....Rotx,Roty,..)
*set var dummy=tcl(RestartECconditions)
*set var SlaveNode=NodesNum
*set var SlaveNodeExists=tcl(CheckECslaveNode *SlaveNode)
*# For every node of this EC ID except the MasterNode(we call it SlaveNode) print : equalDOF *MasterNode *SlaveNode and the DOF user chose to constrain
*if(SlaveNode!=MasterNode && SlaveNodeExists==-1)
*set var dummy=tcl(AddECSlaveNode *SlaveNode)
*format "%6d%6d%6d"
equalDOF *MasterNode *SlaveNode *\
*# 2D
*if(ndime==2)
*if(Cond(2,int)==1)
1 *\
*else
  *\
*endif
*if(Cond(3,int)==1)
2 *\
*else
  *\
*endif
*if(Cond(7,int)==1)
3 *\
*else
  *\
*endif
; # ID : *tcl(ECID *i)
*# 3D
*else
*if(Cond(2,int)==1)
1 *\
*else
  *\
*endif
*if(Cond(3,int)==1)
2 *\
*else
  *\
*endif
*if(Cond(4,int)==1)
3 *\
*else
  *\
*endif
*if(Cond(5,int)==1)
4 *\
*else
  *\
*endif
*if(Cond(6,int)==1)
5 *\
*else
  *\
*endif
*if(Cond(7,int)==1)
6 *\
*else
  *\
*endif
; # ID : *tcl(ECID *i)
*endif
*endif
*endif
*end nodes
*endfor
*endif
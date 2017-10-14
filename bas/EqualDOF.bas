*#
*#      Automatic equalDOF commands between nodes, which belong to different domains and share the same location. (see SSI: Beam-Column elements' connection with Quad elements)
*#
*if(GenData(Activate_automatic_equalDOF_between_nodes_of_different_domain_with_identical_coordinates,int)==1)
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
*# Saving B.Constraint ID number to the corresponding list
*#---------------------------
*set var dummy=tcl(equalDOFClear)
*set var IDExists=-1
*set Cond Point_Body_constraint_master_node *nodes
*# We check, for every node that user applied Body Constraint Condition, the ID number and we save it in a list.
*# This list then contains every body constraint id number, one time each.
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckIDbodyconstraintList *Cond(1,int))
*endif
*if(IDExists==-1)
*set var dummy=tcl(AddbodyconstraintIDList *Cond(1,int) )
*else
*MessageBox Error: For each Body constraint ID group, only one master node can be selected.
*endif
*end nodes
*set var howmanyBCID=tcl(HowmanyBCID)
*#---------------------------
*# Printing EqualDOF
*#---------------------------
*# if we have at least one Body Constraint Condition applied
*if(howmanyBCID>=1)

# --------------------------------------------------------------------------------------------------------------
# C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# Body Constraint/equalDOF Definition : equalDOF $MasterNode $SlaveNode $DOFs

*# For every body constaint ID do the following:
*for(i=1;i<=howmanyBCID;i=i+1)
*# BCID get the ID number from the corresponding list
*set var BCID=tcl(BCIDnumber *i)
*set var dummy=tcl(RestartBCSlaveNodes)
*set cond Point_Body_constraint_master_node *nodes
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
*set var MasterNode=NodesNum
*break
*endif
*end nodes
*set cond Line_Body_constraint_slave_nodes *nodes
*add cond Point_Body_constraint_slave_nodes *nodes
*# For every node that belongs to the running BC ID do the following
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
*set var Translx=0
*set var Transly=0
*set var Translz=0
*set var Rotx=0
*set var Roty=0
*set var Rotz=0
*# for each Body constaint ID, this procedure clears the list of the equalDOF(Translx,Transly,....Rotx,Roty,..)
*set var dummy=tcl(RestartBCconditions)
*# 2D
*if(ndime==2)
*if(Cond(2,int)==1)
*set var Translx=1
*endif
*if(Cond(3,int)==1)
*set var Transly=2
*endif
*if(Cond(7,int)==1)
*set var Rotz=3
*endif
*# 3D
*else
*if(Cond(2,int)==1)
*set var Translx=1
*endif
*if(Cond(3,int)==1)
*set var Transly=2
*endif
*if(Cond(4,int)==1)
*set var Translz=3
*endif
*if(Cond(5,int)==1)
*set var Rotx=4
*endif
*if(Cond(6,int)==1)
*set var Roty=5
*endif
*if(Cond(7,int)==1)
*set var Rotz=6
*endif
*endif
*# This procedure puts the constrained DOF in a list called BodyConstraintConditions(it depends on the checkboxes on the Body constraint window options)
*set var dummy=tcl(exportBCConditions *Translx *Transly *Translz *Rotx *Roty *Rotz)
*set var SlaveNode=NodesNum
*set var SlaveNodeExists=tcl(CheckSlaveNode *SlaveNode)
*# For every node of this BC ID except the MasterNode(we call it SlaveNode) print : equalDOF *MasterNode *SlaveNode and the DOF user chose to constrain
*if(SlaveNode!=MasterNode && SlaveNodeExists==-1)
*set var dummy=tcl(AddBCSlaveNode *SlaveNode)
*format "%6d%6d%6d"
equalDOF *MasterNode *SlaveNode *tcl(importBCConditions )
*endif
*endif
*end nodes
*endfor
*endif
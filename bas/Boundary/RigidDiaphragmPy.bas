*#
*#--------------------- Rigid Diaphragm -----------------------
*#
*#------------------------- 3D-6DOF ---------------------------
*if(ndime==3 && currentDOF==6)
*set var dummy=tcl(RigidDiaphragmClear)
*set var RDIDExists=-1
*set cond Point_Rigid_diaphragm_master_node *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(LoopVar!=1)
*set var RDIDExists=tcl(CheckrigidDiaphragmID *Cond(2))
*endif
*if(RDIDExists==-1)
*set var dummy=tcl(AddRigidDiaphragmID *Cond(2))
*else
*MessageBox Error : For each Rigid diaphragm ID group, only one master node can be selected.
*endif
*endif
*end nodes
*set var howmanyRDID=tcl(HowmanyRD)
*if(howmanyRDID>=1)

# --------------------------------------------------------------------------------------------------------------
# R I G I D    D I A P H R A G M S
# --------------------------------------------------------------------------------------------------------------

# Rigid Diaphragm Definition : rigidDiaphragm $perpendicularAxis $MasterNode $SlaveNode1 $SlaveNode2 . . . .

*for(i=1;i<=howmanyRDID;i=i+1)
*#set var RDID=tcl(RDID *i)
*set var perpendicularAxis=0
*set cond Point_Rigid_diaphragm_master_node *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var IsThisRDID=tcl(IsThisRDID *Cond(2) *i)
*if(IsThisRDID==1)
*set var RDMasterNodeTag=NodesNum
*break
*endif
*endif
*end nodes
*set cond Line_Rigid_diaphragm_slave_nodes *nodes
*add cond Point_Rigid_diaphragm_slave_nodes *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var IsThisRDID=tcl(IsThisRDID *Cond(2) *i)
*if(IsThisRDID==1)
*if(strcmp(Cond(3),"XY")==0)
*set var perpendicularAxis=3
*elseif(strcmp(Cond(3),"YZ")==0)
*set var perpendicularAxis=1
*else
*set var perpendicularAxis=2
*endif
*endif
*endif
*end nodes
*if(perpendicularAxis==1)
*format "%6d    "
ops.fix(*RDMasterNodeTag, 1, 0, 0, 0, 1, 1)
*elseif(perpendicularAxis==2)
*format "%6d    "
ops.fix(*RDMasterNodeTag, 0, 1, 0, 1, 0, 1)
*else
*format "%6d    "
ops.fix(*RDMasterNodeTag, 0, 0, 1, 1, 1, 0)
*endif
*format "%6d%6d"
ops.rigidDiaphragm(*perpendicularAxis, *RDMasterNodeTag *\
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var IsThisRDID=tcl(IsThisRDID *Cond(2) *i)
*if(IsThisRDID==1 && NodesNum!=RDMasterNodeTag)
*,NodesNum *\
*endif
*endif
*end nodes
) # ID : *tcl(RDID *i)
*endfor
*endif
*#----------------NOT 3D Model and 6 DOF Nodes ----------------------
*else
*set Cond Point_Rigid_diaphragm_master_node *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(LoopVar==1)
*WarningBox Warning: Invalid rigid diaphragm assignment has been omitted.
*endif
*endif
*end nodes
*endif
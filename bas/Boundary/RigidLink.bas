*#---------------------------
*# Saving Rigid link Constraints ID number to the corresponding list
*#---------------------------
*set var dummy=tcl(rigidLinkClear)
*set var IDExists=-1
*set Cond Point_Rigid_link_master_node *nodes
*# We check, for every node that user applied Rigid link Constraint Condition, the ID number and we save it in a list.
*# This list then contains every equal constraint id number, one time each.
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckIDRigidLinkConstraintList *Cond(1))
*endif
*if(IDExists==-1)
*set var dummy=tcl(AddRigidLinkConstraintIDList *Cond(1) )
*else
*MessageBox Error: For each Rigid link constraint ID group, only one master node can be selected.
*endif
*end nodes
*set var HowmanyRLCID=tcl(HowmanyRLCID)
*#---------------------------
*# Printing rigidLink
*#---------------------------
*# if we have at least one Body Constraint Condition applied
*if(HowmanyRLCID>=1)

# --------------------------------------------------------------------------------------------------------------
# R I G I D  L I N K  C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

# Rigid link Constraint/rigidLink Definition : rigidLink $type $MasterNodeTag $SlaveNodeTag

*# For each rigid link constaint ID do the following:
*for(i=1;i<=HowmanyRLCID;i=i+1)
*# RLCID get the ID number from the corresponding list
*#set var RLCID=tcl(RLID *i)
*set var dummy=tcl(RestartRLCSlaveNodes)
*set cond Point_Rigid_link_master_node *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var IsThisRLID=tcl(IsThisRLID *Cond(1) *i)
*if(IsThisRLID==1)
*set var MasterNode=NodesNum
*break
*endif
*endif
*end nodes
*set cond Line_Rigid_link_slave_nodes *nodes
*add cond Point_Rigid_link_slave_nodes *nodes
*# For every node that belongs to the running Rigid link ID do the following
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var IsThisRLID=tcl(IsThisRLID *Cond(1) *i)
*if(IsThisRLID==1)
*set var SlaveNode=NodesNum
*set var SlaveNodeExists=tcl(CheckRLCslaveNode *SlaveNode)
*# For every node of this Rigid link ID except the MasterNode(we call it SlaveNode) print : rigidLink *RLtype *MasterNode *SlaveNode and the DOF user chose to constrain
*if(SlaveNode!=MasterNode && SlaveNodeExists==-1)
*set var dummy=tcl(AddRLCSlaveNode *SlaveNode)
rigidLink *\
*if(strcmp(cond(2),"Bar")==0)
bar  *\
*else
beam *\
*endif
*format "%6d%6d"
*MasterNode *SlaveNode; # ID : *tcl(RLID *i)
*endif
*endif
*endif
*end nodes
*endfor
*endif
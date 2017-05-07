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
*set var BCNode=0
*set var Translx=0
*set var Transly=0
*set var Translz=0
*set var Rotx=0
*set var Roty=0
*set var Rotz=0
*# for each Body constaint ID, this procedure clears the list of the equalDOF(Translx,Transly,....Rotx,Roty,..)
*set var dummy=tcl(RestartBCconditions)
*set cond Point_Body_constraint_master_node *nodes
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
*set var MasterNode=NodesNum
*endif
*end nodes
*set cond Point_Body_constraint_slave_nodes *nodes
*add cond Line_Body_constraint_slave_nodes *nodes
*# For every node that belongs to the running BC ID do the following
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
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
*set var BCNode=operation(BCNode+1)
*endif
*end nodes
*# This procedure puts the constrained DOF in a list called BodyConstraintConditions(it depends on the checkboxes on the Body constraint window options)
*set var dummy=tcl(exportBCConditions *Translx *Transly *Translz *Rotx *Roty *Rotz)
*# For every node of this BC ID except the MasterNode(we call it SlaveNode) print : equalDOF *MasterNode *SlaveNode and the DOF user chose to constrain
*for(k=1;k<=BCNode;k=k+1)
*set var CountLoop=0
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
*set var CountLoop=CountLoop+1
*if(CountLoop==k)
*set var SlaveNode=NodesNum
*if(SlaveNode==MasterNode)
*set var CountLoop=operation(CountLoop-1)
*endif
*endif
*endif
*end nodes
equalDOF *MasterNode *SlaveNode *tcl(importBCConditions )
*endfor
*endfor
*endif

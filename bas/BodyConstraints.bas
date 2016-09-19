*#----------------
*# EqualDOF Preparation
*# Saving B.Constraint ID number to the corresponding list
*#----------------
*tcl(equalDOFClear )
*set var IDExists=-1
*set Cond Point_Body_constraints *nodes
*add Cond Line_Body_constraints *nodes
*# We check, for every node that user applied Body Constraint Condition, the ID number and we save it in a list. 
*# This list then contains every body constraint id number, one time each.
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckIDbodyconstraintList *Cond(1,int))
*endif
*if(IDExists==-1)
*tcl(AddbodyconstraintIDList *Cond(1,int) )
*endif
*end nodes
*set var howmanyBCID=tcl(HowmanyBCID )
*#------------------
*# Printing EqualDOF
*#------------------
*#  IF we have at least one Body Constraint Condition applied
*if(howmanyBCID>=1)
# 
# Constraints
#

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
*tcl(RestartBCconditions )
*set Cond Point_Body_constraints *nodes
*add Cond Line_Body_constraints *nodes
*# For every node that belongs to the running BC ID do the following
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
*if(BCNode==0)
*# The first Node that belongs to this ID, we use it as the MasterNode
*set var MasterNode=NodesNum
*endif
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
*# BCNode variable counts how many nodes belongs to the running Body constaint ID number
*set var BCNode=BCNode+1
*endif
*end nodes
*# This procedure puts the constrained DOF in a list called BodyConstraintConditions(it depends on the checkboxes on the Body constraint menu)
*tcl(exportBCConditions *Translx *Transly *Translz *Rotx *Roty *Rotz)
*# For every node of this BC ID except the MasterNode(we call it SlaveNode) print : equalDOF *MasterNode *SlaveNode and the DOF user chose to constrain
*for(k=1;k<=operation(BCNode-1);k=k+1)
*set var CountLoop=0
*loop nodes *OnlyInCond
*if(Cond(1,int)==BCID)
*if(CountLoop==k)
*set var SlaveNode=NodesNum
*endif
*set var CountLoop=CountLoop+1
*endif
*end nodes
*#--------------------------3D-6DOF----------------------------
*if(GenData(Dimensions,int)==3)
*if(GenData(DOF,int)==6)
equalDOF *MasterNode *SlaveNode *tcl(importBCConditions )
*#--------------------------3D-3DOF----------------------------
*else
*if(Translx!=0 && Transly!=0 && Translz!=0)
equalDOF *MasterNode *SlaveNode *Translx *Transly *Translz
*elseif(Translx!=0 && Transly==0 && Translz==0)
equalDOF *MasterNode *SlaveNode *Translx
*elseif(Translx!=0 && Transly!=0 && Translz==0)
equalDOF *MasterNode *SlaveNode *Translx *Transly
*elseif(Translx==0 && Transly!=0 && Translz==0)
equalDOF *MasterNode *SlaveNode *Transly 
*elseif(Translx==0 && Transly!=0 && Translz!=0)
equalDOF *MasterNode *SlaveNode *Transly *Translz
*else
equalDOF *MasterNode *SlaveNode *Translz
*endif
*endif
*#--------------------------2D-3DOF----------------------------
*else
*if(GenData(DOF,int)==3)
*if(Translx!=0 && Transly!=0 && Rotz!=0)
equalDOF *MasterNode *SlaveNode *Translx *Transly *Rotz
*elseif(Translx!=0 && Transly==0 && Rotz==0)
equalDOF *MasterNode *SlaveNode *Translx
*elseif(Translx!=0 && Transly!=0 && Rotz==0)
equalDOF *MasterNode *SlaveNode *Translx *Transly
*elseif(Translx==0 && Transly!=0 && Rotz==0)
equalDOF *MasterNode *SlaveNode *Transly 
*elseif(Translx==0 && Transly!=0 && Rotz!=0)
equalDOF *MasterNode *SlaveNode *Transly *Rotz
*else
equalDOF *MasterNode *SlaveNode *Rotz
*endif
*#--------------------------2D-2DOF----------------------------
*else
*if(Translx!=0 && Transly!=0)
equalDOF *MasterNode *SlaveNode *Translx *Transly
*elseif(Translx!=0 && Transly==0)
equalDOF *MasterNode *SlaveNode *Translx
*else
equalDOF *MasterNode *SlaveNode *Transly
*endif
*endif
*endif
*endfor
*endfor
*endif
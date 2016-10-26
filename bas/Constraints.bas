*#---------------------------
*# EqualDOF Preparation
*# Saving B.Constraint ID number to the corresponding list
*#---------------------------
*set var dummy=tcl(equalDOFClear)
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
*set var dummy=tcl(AddbodyconstraintIDList *Cond(1,int) )
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
*set var dummy=tcl(exportBCConditions *Translx *Transly *Translz *Rotx *Roty *Rotz)
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
*#------------------------- 3D-6DOF ---------------------------
*if(GenData(Dimensions,int)==3)
*if(GenData(DOF,int)==6)
equalDOF *MasterNode *SlaveNode *tcl(importBCConditions )
*#------------------------- 3D-3DOF ---------------------------
*else
*if(Translx!=0 && Transly!=0 && Translz!=0)
*format "%6d%6d%3d%3d%3d"
equalDOF *MasterNode *SlaveNode *Translx *Transly *Translz
*elseif(Translx!=0 && Transly==0 && Translz==0)
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Translx
*elseif(Translx!=0 && Transly!=0 && Translz==0)
*format "%6d%6d%3d%3d"
equalDOF *MasterNode *SlaveNode *Translx *Transly
*elseif(Translx==0 && Transly!=0 && Translz==0)
*format "%6d%6d%3d%"
equalDOF *MasterNode *SlaveNode *Transly 
*elseif(Translx==0 && Transly!=0 && Translz!=0)
*format "%6d%6d%3d%3d"
equalDOF *MasterNode *SlaveNode *Transly *Translz
*else
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Translz
*endif
*endif
*#------------------------- 2D-3DOF ---------------------------
*else
*if(GenData(DOF,int)==3)
*if(Translx!=0 && Transly!=0 && Rotz!=0)
*format "%6d%6d%3d%3d%3d"
equalDOF *MasterNode *SlaveNode *Translx *Transly *Rotz
*elseif(Translx!=0 && Transly==0 && Rotz==0)
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Translx
*elseif(Translx!=0 && Transly!=0 && Rotz==0)
*format "%6d%6d%3d%3d"
equalDOF *MasterNode *SlaveNode *Translx *Transly
*elseif(Translx==0 && Transly!=0 && Rotz==0)
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Transly 
*elseif(Translx==0 && Transly!=0 && Rotz!=0)
*format "%6d%6d%3d%3d"
equalDOF *MasterNode *SlaveNode *Transly *Rotz
*else
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Rotz
*endif
*#------------------------- 2D-2DOF ---------------------------
*else
*if(Translx!=0 && Transly!=0)
*format "%6d%6d%3d%3d"
equalDOF *MasterNode *SlaveNode *Translx *Transly
*elseif(Translx!=0 && Transly==0)
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Translx
*else
*format "%6d%6d%3d"
equalDOF *MasterNode *SlaveNode *Transly
*endif
*endif
*endif
*endfor
*endfor
*endif
*#
*#--------------------- Rigid Diaphragm -----------------------
*#
*#------------------------- 3D-6DOF ---------------------------
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*set var dummy=tcl(RigidDiaphragmClear)
*set var RDIDExists=-1
*set Cond Rigid_diaphragm
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var RDIDExists=tcl(CheckrigidDiaphragmID *Cond(1,int))
*endif
*if(RDIDExists==-1)
*set var dummy=tcl(AddRigidDiaphragmID *Cond(1,int))
*endif
*end nodes
*set var howmanyRDID=tcl(HowmanyRD)
*if(howmanyRDID>=1)
*if(howmanyBCID==0)

# --------------------------------------------------------------------------------------------------------------
# C O N S T R A I N T S
# --------------------------------------------------------------------------------------------------------------

*endif
# Rigid Diaphragm Definition : rigidDiaphragm $perpendicularAxis $MasterNode $SlaveNode1 $SlaveNode2 . . . .

*for(i=1;i<=howmanyRDID;i=i+1)
*set var RDID=tcl(RDID *i)
*set var perpendicularAxis=0
*set Cond Rigid_diaphragm
*loop nodes *OnlyInCond
*if(Cond(1,int)==RDID)
*if(strcmp(Cond(2),"XY")==0)
*set var perpendicularAxis=3
*elseif(strcmp(Cond(2),"YZ")==0)
*set var perpendicularAxis=1
*else
*set var perpendicularAxis=2
*endif
*set var RDMasterNodeTag=Cond(3,int)
*endif
*end nodes
*if(perpendicularAxis==1)
*format "%6d       "
fix            *RDMasterNodeTag 1 0 0 0 1 1
*elseif(perpendicularAxis==2)
*format "%6d       "
fix            *RDMasterNodeTag 0 1 0 1 0 1
*else
*format "%6d       "
fix            *RDMasterNodeTag 0 0 1 1 1 0
*endif
*format "%6d%6d"
rigidDiaphragm *perpendicularAxis *RDMasterNodeTag *\
*loop nodes *OnlyInCond
*if(Cond(1,int)==RDID && NodesNum!=RDMasterNodeTag)
*NodesNum *\
*endif
*end nodes

*endfor
*endif
*#----------------NOT 3D Model and 6 DOF ----------------------
*else
*set Cond Rigid_diaphragm
*loop nodes *OnlyInCond
*if(LoopVar==1)
*WarningBox Warning: Rigid Diaphragm can be used only in a 3D model with 6 Degrees of Freedom.Therefore, it is omitted.
*endif
*end nodes
*endif
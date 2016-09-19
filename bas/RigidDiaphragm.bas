*#--------------------------3D-6DOF-------------------------------------
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*tcl(RigidDiaphragmClear )
*set var RDIDExists=-1
*set Cond Rigid_diaphragm
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var RDIDExists=tcl(CheckrigidDiaphragmID *Cond(1,int))
*endif
*if(RDIDExists==-1)
*tcl(AddRigidDiaphragmID *Cond(1,int) )
*endif
*end nodes
*set var howmanyRDID=tcl(HowmanyRD )
*if(howmanyRDID>=1)
*if(howmanyBCID==0)
#
# Constraints 
#

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
fix *RDMasterNodeTag 1 0 0 0 1 1
*elseif(perpendicularAxis==2)
fix *RDMasterNodeTag 0 1 0 1 0 1
*else
fix *RDMasterNodeTag 0 0 1 1 1 0
*endif
rigidDiaphragm *perpendicularAxis *RDMasterNodeTag *\
*loop nodes *OnlyInCond
*if(Cond(1,int)==RDID && NodesNum!=RDMasterNodeTag)
*NodesNum *\
*endif
*end nodes 
*# SPACE IS NEEDED


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